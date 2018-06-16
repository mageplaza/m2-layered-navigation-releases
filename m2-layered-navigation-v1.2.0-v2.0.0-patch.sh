diff --git a/Helper/Data.php b/Helper/Data.php
index f110b9a..a06f006 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -18,6 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Helper;
 
 use Mageplaza\Core\Helper\AbstractData;
@@ -29,9 +30,6 @@ use Mageplaza\Core\Helper\AbstractData;
 class Data extends AbstractData
 {
 
-	const FILTER_TYPE_RANGE = 'range';
-	const FILTER_TYPE_LIST = 'list';
-
 	/**
 	 * @param null $storeId
 	 *
@@ -39,7 +37,7 @@ class Data extends AbstractData
 	 */
 	public function isEnabled($storeId = null)
 	{
-		return $this->getConfigValue('layered_navigation/general/enable', $storeId) && $this->isModuleOutputEnabled();
+		return $this->getConfigValue('layered_navigation/general/enable', $storeId);
 	}
 
 	/**
@@ -55,32 +53,14 @@ class Data extends AbstractData
 	}
 
 	/**
-	 * Layered configuration for js widget
-	 *
-	 * @param $filters
+	 * @param string $code
+	 * @param null $storeId
 	 * @return mixed
 	 */
-	public function getLayerConfiguration($filters)
+	public function getDisplayConfig($code = '', $storeId = null)
 	{
-		$filterParams = $this->_getRequest()->getParams();
-		$config       = new \Magento\Framework\DataObject([
-			'active' => array_keys($filterParams),
-			'params' => $filterParams
-		]);
-
-		$slider = [];
-		foreach ($filters as $filter) {
-			if ($filter->getFilterType() == self::FILTER_TYPE_RANGE) {
-				$slider[$filter->getRequestVar()] = $filter->getFilterSliderConfig();
-			}
-		}
-		$config->setData('slider', $slider);
-
-		$this->_eventManager->dispatch('layer_navigation_get_filter_configuration', [
-			'config'  => $config,
-			'filters' => $filters
-		]);
+		$code = ($code !== '') ? '/' . $code : '';
 
-		return $this->objectManager->get('Magento\Framework\Json\EncoderInterface')->encode($config->getData());
+		return $this->getConfigValue('layered_navigation/display' . $code, $storeId);
 	}
 }
diff --git a/Model/Config/Source/ActiveFilter.php b/Model/Config/Source/ActiveFilter.php
new file mode 100644
index 0000000..49aef77
--- /dev/null
+++ b/Model/Config/Source/ActiveFilter.php
@@ -0,0 +1,43 @@
+<?php
+/**
+ * Mageplaza
+ *
+ * NOTICE OF LICENSE
+ *
+ * This source file is subject to the Mageplaza.com license that is
+ * available through the world-wide-web at this URL:
+ * https://www.mageplaza.com/LICENSE.txt
+ *
+ * DISCLAIMER
+ *
+ * Do not edit or add to this file if you wish to upgrade this extension to newer
+ * version in the future.
+ *
+ * @category    Mageplaza
+ * @package     Mageplaza_LayeredNavigation
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+namespace Mageplaza\LayeredNavigation\Model\Config\Source;
+
+use Magento\Framework\Model\AbstractModel;
+
+class ActiveFilter extends AbstractModel
+{
+	const SHOW_NONE = 0;
+	const SHOW_ACTIVE = 1;
+	const SHOW_ALL = 2;
+
+	/**
+	 * @return array
+	 */
+	public function toOptionArray()
+	{
+		return [
+			self::SHOW_NONE   => __('No'),
+			self::SHOW_ACTIVE => __('Open Active'),
+			self::SHOW_ALL    => __('Open All')
+		];
+	}
+}
\ No newline at end of file
diff --git a/Model/Layer/Filter/Attribute.php b/Model/Layer/Filter/Attribute.php
index f02376d..10a394e 100644
--- a/Model/Layer/Filter/Attribute.php
+++ b/Model/Layer/Filter/Attribute.php
@@ -18,249 +18,166 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Attribute as AbstractFilter;
-use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
 
-/**
- * Class Attribute
- * @package Mageplaza\LayeredNavigation\Model\Layer\Filter
- */
-class Attribute extends AbstractFilter implements FilterInterface
+class Attribute extends AbstractFilter
 {
-	/**
-	 * @var \Magento\Framework\Filter\StripTags
-	 */
-	private $tagFilter;
-
-	/**
-	 * filterable value
-	 *
-	 * @type array
-	 */
-	protected $filterValue;
-
-	/**
-	 * @type \Mageplaza\LayeredNavigation\Helper\Data
-	 */
-	protected $_moduleHelper;
-
-	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-	 * @param \Magento\Catalog\Model\Layer $layer
-	 * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-	 * @param \Magento\Framework\Filter\StripTags $tagFilter
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	 * @param array $data
-	 */
-	public function __construct(
-		\Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-		\Magento\Store\Model\StoreManagerInterface $storeManager,
-		\Magento\Catalog\Model\Layer $layer,
-		\Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-		\Magento\Framework\Filter\StripTags $tagFilter,
-		LayerHelper $moduleHelper,
-		array $data = []
-	)
-	{
-		parent::__construct(
-			$filterItemFactory,
-			$storeManager,
-			$layer,
-			$itemDataBuilder,
-			$tagFilter,
-			$data
-		);
-		$this->tagFilter     = $tagFilter;
-		$this->_moduleHelper = $moduleHelper;
-		$this->filterValue   = [];
-	}
-
-	/**
-	 * Apply attribute option filter to product collection
-	 *
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 * @return $this
-	 * @throws \Magento\Framework\Exception\LocalizedException
-	 */
-	public function apply(\Magento\Framework\App\RequestInterface $request)
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return parent::apply($request);
-		}
-
-		$attributeValue = $request->getParam($this->_requestVar);
-		if (empty($attributeValue)) {
-			return $this;
-		}
-
-		$attributeValue    = explode(',', $attributeValue);
-		$this->filterValue = $attributeValue;
-
-		$attribute = $this->getAttributeModel();
-		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-		$productCollection = $this->getLayer()
-			->getProductCollection();
-		if (count($attributeValue) > 1) {
-			$productCollection->addFieldToFilter($attribute->getAttributeCode(), ['in' => $attributeValue]);
-		} else {
-			$productCollection->addFieldToFilter($attribute->getAttributeCode(), $attributeValue[0]);
-		}
-
-		$state = $this->getLayer()->getState();
-		foreach ($attributeValue as $value) {
-			$label = $this->getOptionText($value);
-			$state->addFilter($this->_createItem($label, $value));
-		}
-
-		return $this;
-	}
-
-	/**
-	 * Get data array for building attribute filter items
-	 *
-	 * @return array
-	 * @throws \Magento\Framework\Exception\LocalizedException
-	 */
-	protected function _getItemsData()
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return parent::_getItemsData();
-		}
-
-		$attribute = $this->getAttributeModel();
-
-		/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
-		$productCollection = $this->getLayer()
-			->getProductCollection();
-
-		if (!empty($this->filterValue)) {
-			$productCollectionClone = $productCollection->getCollectionClone();
-			$collection             = $productCollectionClone->removeAttributeSearch($attribute->getAttributeCode());
-		} else {
-			$collection = $productCollection;
-		}
-
-		$optionsFacetedData = $collection->getFacetedData($attribute->getAttributeCode());
-
-		if (count($optionsFacetedData) === 0
-			&& $this->getAttributeIsFilterable($attribute) !== static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
-		) {
-			return $this->itemDataBuilder->build();
-		}
-
-		$productSize = $collection->getSize();
-
-		$itemData   = [];
-		$checkCount = false;
-
-		$options = $attribute->getFrontend()
-			->getSelectOptions();
-		foreach ($options as $option) {
-			if (empty($option['value'])) {
-				continue;
-			}
-
-			$value = $option['value'];
-
-			$count = isset($optionsFacetedData[$value]['count'])
-				? (int)$optionsFacetedData[$value]['count']
-				: 0;
-
-			// Check filter type
-			if ($this->getAttributeIsFilterable($attribute) === static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
-				&& (!$this->isOptionReducesResults($count, $productSize) || ($count == 0 && !$this->isShowZero()))
-			) {
-				continue;
-			}
-
-			if ($count > 0) {
-				$checkCount = true;
-			}
-
-			$itemData[] = [
-				'label' => $this->tagFilter->filter($option['label']),
-				'value' => $value,
-				'count' => $count
-			];
-		}
-
-		if ($checkCount) {
-			foreach ($itemData as $item) {
-				$this->itemDataBuilder->addItemData($item['label'], $item['value'], $item['count']);
-			}
-		}
-
-		return $this->itemDataBuilder->build();
-	}
-
-	/**
-	 * @return string
-	 */
-	public function getFilterType()
-	{
-		return LayerHelper::FILTER_TYPE_LIST;
-	}
-
-	/**
-	 * Get option url. If it has been filtered, return removed url. Else return filter url
-	 *
-	 * @param $item
-	 * @return mixed
-	 */
-	public function getUrl($item)
-	{
-		if ($this->isSelected($item)) {
-			return $item->getRemoveUrl();
-		}
-
-		return $item->getUrl();
-	}
-
-	/**
-	 * Check it option is selected or not
-	 *
-	 * @param $item
-	 * @return bool
-	 */
-	public function isSelected($item)
-	{
-		if (!empty($this->filterValue) && in_array($item->getValue(), $this->filterValue)) {
-			return true;
-		}
-
-		return false;
-	}
-
-	/**
-	 * Allow to show zero options
-	 *
-	 * @return bool
-	 */
-	public function isShowZero()
-	{
-		return false;
-	}
-
-	/**
-	 * Allow to show counter after options
-	 *
-	 * @return bool
-	 */
-	public function isShowCounter()
-	{
-		return true;
-	}
-
-	/**
-	 * Allow multiple filter
-	 *
-	 * @return bool
-	 */
-	public function isMultiple()
-	{
-		return true;
-	}
+    /**
+     * @var \Magento\Framework\Filter\StripTags
+     */
+    private $tagFilter;
+
+    protected $filterValue = true;
+
+    protected $_moduleHelper;
+
+    /**
+     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
+     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+     * @param \Magento\Catalog\Model\Layer $layer
+     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
+     * @param \Magento\Framework\Filter\StripTags $tagFilter
+     * @param array $data
+     */
+    public function __construct(
+        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
+        \Magento\Store\Model\StoreManagerInterface $storeManager,
+        \Magento\Catalog\Model\Layer $layer,
+        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
+        \Magento\Framework\Filter\StripTags $tagFilter,
+        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper,
+        array $data = []
+    ) {
+        parent::__construct(
+            $filterItemFactory,
+            $storeManager,
+            $layer,
+            $itemDataBuilder,
+            $tagFilter,
+            $data
+        );
+        $this->tagFilter = $tagFilter;
+        $this->_moduleHelper = $moduleHelper;
+    }
+
+    /**
+     * Apply attribute option filter to product collection
+     *
+     * @param \Magento\Framework\App\RequestInterface $request
+     * @return $this
+     * @throws \Magento\Framework\Exception\LocalizedException
+     */
+    public function apply(\Magento\Framework\App\RequestInterface $request)
+    {
+        if (!$this->_moduleHelper->isEnabled()) {
+            return parent::apply($request);
+        }
+        $attributeValue = $request->getParam($this->_requestVar);
+
+        if (empty($attributeValue)) {
+            $this->filterValue = false;
+            return $this;
+        }
+        $attributeValue = explode(',', $attributeValue);
+        $attribute = $this->getAttributeModel();
+        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
+        $productCollection = $this->getLayer()
+            ->getProductCollection();
+        if (count($attributeValue) > 1) {
+            $productCollection->addFieldToFilter($attribute->getAttributeCode(), ['in' => $attributeValue]);
+        } else {
+            $productCollection->addFieldToFilter($attribute->getAttributeCode(), $attributeValue[0]);
+        }
+
+        $state = $this->getLayer()->getState();
+        foreach ($attributeValue as $value) {
+            $label = $this->getOptionText($value);
+            $state->addFilter($this->_createItem($label, $value));
+        }
+
+        if(!$this->_moduleHelper->getGeneralConfig('allow_multiple')){
+            $this->setItems([]); // set items to disable show filtering
+        }
+
+        return $this;
+    }
+
+    /**
+     * Get data array for building attribute filter items
+     *
+     * @return array
+     * @throws \Magento\Framework\Exception\LocalizedException
+     */
+    protected function _getItemsData()
+    {
+        if (!$this->_moduleHelper->isEnabled()) {
+            return parent::_getItemsData();
+        }
+
+        $attribute = $this->getAttributeModel();
+        /** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
+        $productCollection = $this->getLayer()
+            ->getProductCollection();
+
+        if ($this->filterValue && $this->_moduleHelper->getGeneralConfig('allow_multiple')) {
+            $productCollectionClone = $productCollection->getCollectionClone();
+            $collection = $productCollectionClone->removeAttributeSearch($attribute->getAttributeCode());
+        } else {
+            $collection = $productCollection;
+        }
+
+        $optionsFacetedData = $collection->getFacetedData($attribute->getAttributeCode());
+
+        if (count($optionsFacetedData) === 0
+            && $this->getAttributeIsFilterable($attribute) !== static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
+        ) {
+            return $this->itemDataBuilder->build();
+        }
+
+        $productSize = $collection->getSize();
+
+        $itemData = [];
+        $checkCount = false;
+        $isShowZeroAttribute = $this->_moduleHelper->getDisplayConfig('show_zero');
+
+        $options = $attribute->getFrontend()
+            ->getSelectOptions();
+        foreach ($options as $option) {
+            if (empty($option['value'])) {
+                continue;
+            }
+
+            $value = $option['value'];
+
+            $count = isset($optionsFacetedData[$value]['count'])
+                ? (int)$optionsFacetedData[$value]['count']
+                : 0;
+            if ($count > 0) {
+                $checkCount = true;
+            }
+            // Check filter type
+            if ($this->getAttributeIsFilterable($attribute) === static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
+                && (!$this->isOptionReducesResults($count, $productSize) || ($count === 0 && !$isShowZeroAttribute))
+            ) {
+                continue;
+            }
+
+            $itemData[] = [
+                $this->tagFilter->filter($option['label']),
+                $value,
+                $count
+            ];
+        }
+
+        if ($checkCount) {
+            foreach ($itemData as $value) {
+                $this->itemDataBuilder->addItemData($value[0], $value[1], $value[2]);
+            }
+        }
+
+        return $this->itemDataBuilder->build();
+    }
 }
diff --git a/Model/Layer/Filter/Category.php b/Model/Layer/Filter/Category.php
index 01f9a8d..aed4669 100644
--- a/Model/Layer/Filter/Category.php
+++ b/Model/Layer/Filter/Category.php
@@ -18,104 +18,132 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
-use Magento\CatalogSearch\Model\Layer\Filter\Category as AbstractFilter;
-use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
+use Magento\Catalog\Model\Layer\Filter\AbstractFilter;
+use Magento\Catalog\Model\Layer\Filter\DataProvider\Category as CategoryDataProvider;
 
 /**
  * Layer category filter
  */
-class Category extends AbstractFilter implements FilterInterface
+class Category extends AbstractFilter
 {
-	/**
-	 * @type array
-	 */
-	protected $filterValue = [];
+    /**
+     * @var \Magento\Framework\Escaper
+     */
+    private $escaper;
+
+    /**
+     * @var CategoryDataProvider
+     */
+    private $dataProvider;
 
-	/**
-	 * Apply category filter to product collection
-	 *
-	 * @param   \Magento\Framework\App\RequestInterface $request
-	 * @return  $this
-	 */
-	public function apply(\Magento\Framework\App\RequestInterface $request)
-	{
-		parent::apply($request);
+    /**
+     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
+     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+     * @param \Magento\Catalog\Model\Layer $layer
+     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
+     * @param \Magento\Catalog\Model\CategoryFactory $categoryFactory
+     * @param \Magento\Framework\Escaper $escaper
+     * @param CategoryManagerFactory $categoryManager
+     * @param array $data
+     */
+    public function __construct(
+        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
+        \Magento\Store\Model\StoreManagerInterface $storeManager,
+        \Magento\Catalog\Model\Layer $layer,
+        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
+        \Magento\Framework\Escaper $escaper,
+        \Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory,
+        array $data = []
+    ) {
+        parent::__construct(
+            $filterItemFactory,
+            $storeManager,
+            $layer,
+            $itemDataBuilder,
+            $data
+        );
+        $this->escaper = $escaper;
+        $this->_requestVar = 'cat';
+        $this->dataProvider = $categoryDataProviderFactory->create(['layer' => $this->getLayer()]);
+    }
 
-		$attributeValue = $request->getParam($this->_requestVar) ?: $request->getParam('id');
-		if (!empty($attributeValue)) {
-			$this->filterValue = explode(',', $attributeValue);
-		}
+    /**
+     * Apply category filter to product collection
+     *
+     * @param   \Magento\Framework\App\RequestInterface $request
+     * @return  $this
+     */
+    public function apply(\Magento\Framework\App\RequestInterface $request)
+    {
+        $categoryId = $request->getParam($this->_requestVar) ?: $request->getParam('id');
+        if (empty($categoryId)) {
+            return $this;
+        }
 
-		return $this;
-	}
+        $this->dataProvider->setCategoryId($categoryId);
 
-	/**
-	 * @return string
-	 */
-	public function getFilterType()
-	{
-		return LayerHelper::FILTER_TYPE_LIST;
-	}
+        $category = $this->dataProvider->getCategory();
 
-	/**
-	 * Get option url. If it has been filtered, return removed url. Else return filter url
-	 *
-	 * @param $item
-	 * @return mixed
-	 */
-	public function getUrl($item)
-	{
-		if ($this->isSelected($item)) {
-			return $item->getRemoveUrl();
-		}
+        $this->getLayer()->getProductCollection()->addCategoryFilter($category);
 
-		return $item->getUrl();
-	}
+        if ($request->getParam('id') != $category->getId() && $this->dataProvider->isValid()) {
+            $this->getLayer()->getState()->addFilter($this->_createItem($category->getName(), $categoryId));
+        }
+        return $this;
+    }
 
-	/**
-	 * Check it option is selected or not
-	 *
-	 * @param $item
-	 * @return bool
-	 */
-	public function isSelected($item)
-	{
-		if (!empty($this->filterValue) && in_array($item->getValue(), $this->filterValue)) {
-			return true;
-		}
+    /**
+     * Get filter value for reset current filter state
+     *
+     * @return mixed|null
+     */
+    public function getResetValue()
+    {
+        return $this->dataProvider->getResetValue();
+    }
 
-		return false;
-	}
+    /**
+     * Get filter name
+     *
+     * @return \Magento\Framework\Phrase
+     */
+    public function getName()
+    {
+        return __('Category');
+    }
 
-	/**
-	 * Allow to show zero options
-	 *
-	 * @return bool
-	 */
-	public function isShowZero()
-	{
-		return false;
-	}
+    /**
+     * Get data array for building category filter items
+     *
+     * @return array
+     */
+    protected function _getItemsData()
+    {
+        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
+        $productCollection = $this->getLayer()->getProductCollection();
+        $optionsFacetedData = $productCollection->getFacetedData('category');
+        $category = $this->dataProvider->getCategory();
+        $categories = $category->getChildrenCategories();
 
-	/**
-	 * Allow to show counter after options
-	 *
-	 * @return bool
-	 */
-	public function isShowCounter()
-	{
-		return true;
-	}
+        $collectionSize = $productCollection->getSize();
 
-	/**
-	 * Allow multiple filter
-	 *
-	 * @return bool
-	 */
-	public function isMultiple()
-	{
-		return false;
-	}
+        if ($category->getIsActive()) {
+            foreach ($categories as $category) {
+                if ($category->getIsActive()
+                    && isset($optionsFacetedData[$category->getId()])
+                    && $this->isOptionReducesResults($optionsFacetedData[$category->getId()]['count'], $collectionSize)
+                ) {
+                    $this->itemDataBuilder->addItemData(
+                        $this->escaper->escapeHtml($category->getName()),
+                        $category->getId(),
+                        $optionsFacetedData[$category->getId()]['count']
+                    );
+                }
+            }
+        }
+        return $this->itemDataBuilder->build();
+    }
 }
diff --git a/Model/Layer/Filter/Decimal.php b/Model/Layer/Filter/Decimal.php
index d318ab1..caf58e6 100644
--- a/Model/Layer/Filter/Decimal.php
+++ b/Model/Layer/Filter/Decimal.php
@@ -18,120 +18,152 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
-use Magento\CatalogSearch\Model\Layer\Filter\Decimal as AbstractFilter;
-use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
+namespace Mageplaza\LayerdNavigation\Model\Layer\Filter;
+
+use Magento\Catalog\Model\Layer\Filter\AbstractFilter;
 
 /**
- * Layer category filter
+ * Layer decimal filter
  */
-class Decimal extends AbstractFilter implements FilterInterface
+class Decimal extends AbstractFilter
 {
-	/**
-	 * @type array
-	 */
-	protected $filterValue = [];
-
-	/**
-	 * Apply price range filter
-	 *
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 * @return $this
-	 * @throws \Magento\Framework\Exception\LocalizedException
-	 */
-	public function apply(\Magento\Framework\App\RequestInterface $request)
-	{
-		/**
-		 * Filter must be string: $fromPrice-$toPrice
-		 */
-		$filter = $request->getParam($this->getRequestVar());
-		if (!$filter || is_array($filter)) {
-			return $this;
-		}
-
-		$this->filterValue[] = $filter;
-		list($from, $to) = explode('-', $filter);
-
-		$this->getLayer()
-			->getProductCollection()
-			->addFieldToFilter(
-				$this->getAttributeModel()->getAttributeCode(),
-				['from' => $from, 'to' => $to]
-			);
-
-		$this->getLayer()->getState()->addFilter(
-			$this->_createItem($this->renderRangeLabel(empty($from) ? 0 : $from, $to), $filter)
-		);
-
-		return $this;
-	}
-
-	/**
-	 * @return string
-	 */
-	public function getFilterType()
-	{
-		return LayerHelper::FILTER_TYPE_LIST;
-	}
-
-	/**
-	 * Get option url. If it has been filtered, return removed url. Else return filter url
-	 *
-	 * @param $item
-	 * @return mixed
-	 */
-	public function getUrl($item)
-	{
-		if ($this->isSelected($item)) {
-			return $item->getRemoveUrl();
-		}
-
-		return $item->getUrl();
-	}
-
-	/**
-	 * Check it option is selected or not
-	 *
-	 * @param $item
-	 * @return bool
-	 */
-	public function isSelected($item)
-	{
-		if (!empty($this->filterValue) && in_array($item->getValue(), $this->filterValue)) {
-			return true;
-		}
-
-		return false;
-	}
-
-	/**
-	 * Allow to show zero options
-	 *
-	 * @return bool
-	 */
-	public function isShowZero()
-	{
-		return false;
-	}
-
-	/**
-	 * Allow to show counter after options
-	 *
-	 * @return bool
-	 */
-	public function isShowCounter()
-	{
-		return true;
-	}
-
-	/**
-	 * Allow multiple filter
-	 *
-	 * @return bool
-	 */
-	public function isMultiple()
-	{
-		return true;
-	}
+    /**
+     * @var \Magento\Framework\Pricing\PriceCurrencyInterface
+     */
+    private $priceCurrency;
+
+    /**
+     * @var \Magento\Catalog\Model\ResourceModel\Layer\Filter\Decimal
+     */
+    private $resource;
+
+    /**
+     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
+     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+     * @param \Magento\Catalog\Model\Layer $layer
+     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
+     * @param \Magento\Catalog\Model\ResourceModel\Layer\Filter\DecimalFactory $filterDecimalFactory
+     * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
+     * @param array $data
+     */
+    public function __construct(
+        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
+        \Magento\Store\Model\StoreManagerInterface $storeManager,
+        \Magento\Catalog\Model\Layer $layer,
+        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
+        \Magento\Catalog\Model\ResourceModel\Layer\Filter\DecimalFactory $filterDecimalFactory,
+        \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency,
+        array $data = []
+    ) {
+        parent::__construct(
+            $filterItemFactory,
+            $storeManager,
+            $layer,
+            $itemDataBuilder,
+            $data
+        );
+        $this->resource = $filterDecimalFactory->create();
+        $this->priceCurrency = $priceCurrency;
+    }
+
+    /**
+     * Apply price range filter
+     *
+     * @param \Magento\Framework\App\RequestInterface $request
+     * @return $this
+     * @throws \Magento\Framework\Exception\LocalizedException
+     */
+    public function apply(\Magento\Framework\App\RequestInterface $request)
+    {
+        /**
+         * Filter must be string: $fromPrice-$toPrice
+         */
+        $filter = $request->getParam($this->getRequestVar());
+        if (!$filter || is_array($filter)) {
+            return $this;
+        }
+
+        list($from, $to) = explode('-', $filter);
+
+        $this->getLayer()
+            ->getProductCollection()
+            ->addFieldToFilter(
+                $this->getAttributeModel()->getAttributeCode(),
+                ['from' => $from, 'to' => $to]
+            );
+
+        $this->getLayer()->getState()->addFilter(
+            $this->_createItem($this->renderRangeLabel(empty($from) ? 0 : $from, $to), $filter)
+        );
+
+        return $this;
+    }
+
+    /**
+     * Get data array for building attribute filter items
+     *
+     * @return array
+     * @throws \Magento\Framework\Exception\LocalizedException
+     * @SuppressWarnings(PHPMD.NPathComplexity)
+     */
+    protected function _getItemsData()
+    {
+        $attribute = $this->getAttributeModel();
+
+        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
+        $productCollection = $this->getLayer()->getProductCollection();
+        $productSize = $productCollection->getSize();
+        $facets = $productCollection->getFacetedData($attribute->getAttributeCode());
+
+        $data = [];
+        foreach ($facets as $key => $aggregation) {
+            $count = $aggregation['count'];
+            if (!$this->isOptionReducesResults($count, $productSize)) {
+                continue;
+            }
+            list($from, $to) = explode('_', $key);
+            if ($from == '*') {
+                $from = '';
+            }
+            if ($to == '*') {
+                $to = '';
+            }
+            $label = $this->renderRangeLabel(
+                empty($from) ? 0 : $from,
+                empty($to) ? $to : $to
+            );
+            $value = $from . '-' . $to;
+
+            $data[] = [
+                'label' => $label,
+                'value' => $value,
+                'count' => $count,
+                'from' => $from,
+                'to' => $to
+            ];
+        }
+
+        return $data;
+    }
+
+    /**
+     * Prepare text of range label
+     *
+     * @param float|string $fromPrice
+     * @param float|string $toPrice
+     * @return \Magento\Framework\Phrase
+     */
+    protected function renderRangeLabel($fromPrice, $toPrice)
+    {
+        $formattedFromPrice = $this->priceCurrency->format($fromPrice);
+        if ($toPrice === '') {
+            return __('%1 and above', $formattedFromPrice);
+        } else {
+            if ($fromPrice != $toPrice) {
+                $toPrice -= .01;
+            }
+            return __('%1 - %2', $formattedFromPrice, $this->priceCurrency->format($toPrice));
+        }
+    }
 }
diff --git a/Model/Layer/Filter/FilterInterface.php b/Model/Layer/Filter/FilterInterface.php
deleted file mode 100644
index fc66ddb..0000000
--- a/Model/Layer/Filter/FilterInterface.php
+++ /dev/null
@@ -1,80 +0,0 @@
-<?php
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
-
-/**
- * Interface FilterInterface
- * @package Mageplaza\LayeredNavigation\Model\Layer\Filter
- */
-interface FilterInterface
-{
-	/**
-	 * Apply filter
-	 *
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 * @return mixed
-	 */
-	public function apply(\Magento\Framework\App\RequestInterface $request);
-
-	/**
-	 * Filter type. Used for get item url range or list
-	 *
-	 * @return mixed
-	 */
-	public function getFilterType();
-
-	/**
-	 * Depend on item is selected or not, return filter url or remove url
-	 *
-	 * @param $item
-	 * @return mixed
-	 */
-	public function getUrl($item);
-
-	/**
-	 * Item is selected or not
-	 *
-	 * @param $item
-	 * @return mixed
-	 */
-	public function isSelected($item);
-
-	/**
-	 * Can show non product options
-	 *
-	 * @return mixed
-	 */
-	public function isShowZero();
-
-	/**
-	 * Can show counter after option label
-	 *
-	 * @return mixed
-	 */
-	public function isShowCounter();
-
-	/**
-	 * Is multiple filter
-	 *
-	 * @return mixed
-	 */
-	public function isMultiple();
-}
\ No newline at end of file
diff --git a/Model/Layer/Filter/Price.php b/Model/Layer/Filter/Price.php
index 9c30909..f85ad30 100644
--- a/Model/Layer/Filter/Price.php
+++ b/Model/Layer/Filter/Price.php
@@ -18,10 +18,10 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Price as AbstractFilter;
-use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
 
 /**
  * Layer price filter based on Search API
@@ -46,21 +46,11 @@ class Price extends AbstractFilter
 	protected $filterValue;
 
 	/**
-	 * @type
-	 */
-	protected $filterType;
-
-	/**
 	 * @type \Mageplaza\LayeredNavigation\Helper\Data
 	 */
 	protected $_moduleHelper;
 
 	/**
-	 * @type \Magento\Tax\Helper\Data
-	 */
-	protected $_taxHelper;
-
-	/**
 	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
 	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
 	 * @param \Magento\Catalog\Model\Layer $layer
@@ -87,7 +77,6 @@ class Price extends AbstractFilter
 		\Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory,
 		\Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory,
 		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper,
-		\Magento\Tax\Helper\Data $taxHelper,
 		array $data = []
 	)
 	{
@@ -108,8 +97,6 @@ class Price extends AbstractFilter
 		$this->priceCurrency = $priceCurrency;
 		$this->dataProvider  = $dataProviderFactory->create(['layer' => $this->getLayer()]);
 		$this->_moduleHelper = $moduleHelper;
-		$this->_taxHelper    = $taxHelper;
-		$this->filterValue   = [];
 	}
 
 	/**
@@ -129,11 +116,15 @@ class Price extends AbstractFilter
 		 */
 		$filter = $request->getParam($this->getRequestVar());
 		if (!$filter || is_array($filter)) {
+			$this->filterValue = false;
+
 			return $this;
 		}
 		$filterParams = explode(',', $filter);
 		$filter       = $this->dataProvider->validateFilter($filterParams[0]);
 		if (!$filter) {
+			$this->filterValue = false;
+
 			return $this;
 		}
 
@@ -189,30 +180,10 @@ class Price extends AbstractFilter
 	 */
 	protected function _getItemsData()
 	{
-		if (!$this->_moduleHelper->isEnabled() || ($this->getFilterType() != LayerHelper::FILTER_TYPE_RANGE)) {
+		if (!$this->_moduleHelper->isEnabled()) {
 			return parent::_getItemsData();
 		}
 
-		return [[
-			'label' => __('Price Slider'),
-			'value' => 'slider',
-			'count' => 1
-		]];
-	}
-
-	/**
-	 * @return string
-	 */
-	public function getFilterType()
-	{
-		return LayerHelper::FILTER_TYPE_RANGE;
-	}
-
-	/**
-	 * @return array
-	 */
-	public function getFilterSliderConfig()
-	{
 		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
 		$productCollection      = $this->getLayer()->getProductCollection();
 		$productCollectionClone = $productCollection->getCollectionClone();
@@ -223,17 +194,34 @@ class Price extends AbstractFilter
 		$max = $collection->getMaxPrice();
 		list($from, $to) = $this->filterValue ?: [$min, $max];
 
-		$item = $this->getItems()[0];
+		return [[
+			'label'       => __('Price Slider'),
+			'value'       => $from . '-' . $to,
+			'count'       => 1,
+			'filter_type' => 'slider',
+			'min'         => $min,
+			'max'         => $max,
+			'from'        => $from,
+			'to'          => $to
+		]];
+	}
 
-		$config = [
-			"selectedFrom"  => $from,
-			"selectedTo"    => $to,
-			"minValue"      => $min,
-			"maxValue"      => $max,
-			"priceFormat"   => $this->_taxHelper->getPriceFormat(),
-			"ajaxUrl"       => $item->getUrl()
-		];
+	/**
+	 * Initialize filter items
+	 *
+	 * @return  \Magento\Catalog\Model\Layer\Filter\AbstractFilter
+	 */
+	protected function _initItems()
+	{
+		$data  = $this->_getItemsData();
+		$items = [];
+		foreach ($data as $itemData) {
+			$item = $this->_createItem($itemData['label'], $itemData['value'], $itemData['count']);
+			$item->addData($itemData);
+			$items[] = $item;
+		}
+		$this->_items = $items;
 
-		return $config;
+		return $this;
 	}
 }
diff --git a/Model/ResourceModel/Fulltext/Collection.php b/Model/ResourceModel/Fulltext/Collection.php
index 2d91315..9c9eccc 100644
--- a/Model/ResourceModel/Fulltext/Collection.php
+++ b/Model/ResourceModel/Fulltext/Collection.php
@@ -18,6 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext;
 
 use Magento\CatalogSearch\Model\Search\RequestGenerator;
@@ -37,507 +38,481 @@ use Magento\Framework\App\ObjectManager;
  */
 class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 {
-	/**
-	 * @var  QueryResponse
-	 * @deprecated
-	 */
-	protected $queryResponse;
-
-	/**
-	 * Catalog search data
-	 *
-	 * @var \Magento\Search\Model\QueryFactory
-	 * @deprecated
-	 */
-	protected $queryFactory = null;
-
-	/**
-	 * @var \Magento\Framework\Search\Request\Builder
-	 * @deprecated
-	 */
-	private $requestBuilder;
-
-	/**
-	 * @var \Magento\Search\Model\SearchEngine
-	 * @deprecated
-	 */
-	private $searchEngine;
-
-	/**
-	 * @var string
-	 */
-	private $queryText;
-
-	/**
-	 * @var string|null
-	 */
-	private $order = null;
-
-	/**
-	 * @var string
-	 */
-	private $searchRequestName;
-
-	/**
-	 * @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory
-	 */
-	private $temporaryStorageFactory;
-
-	/**
-	 * @var \Magento\Search\Api\SearchInterface
-	 */
-	private $search;
-
-	/**
-	 * @var \Magento\Framework\Api\Search\SearchCriteriaBuilder
-	 */
-	private $searchCriteriaBuilder;
-
-	/**
-	 * @var \Magento\Framework\Api\Search\SearchResultInterface
-	 */
-	private $searchResult;
-
-	/**
-	 * @var SearchResultFactory
-	 */
-	private $searchResultFactory;
-
-	/**
-	 * @var \Magento\Framework\Api\FilterBuilder
-	 */
-	private $filterBuilder;
-
-	/**
-	 * @type null
-	 */
-	public $collectionClone = null;
-
-	/**
-	 * @param \Magento\Framework\Data\Collection\EntityFactory $entityFactory
-	 * @param \Psr\Log\LoggerInterface $logger
-	 * @param \Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy
-	 * @param \Magento\Framework\Event\ManagerInterface $eventManager
-	 * @param \Magento\Eav\Model\Config $eavConfig
-	 * @param \Magento\Framework\App\ResourceConnection $resource
-	 * @param \Magento\Eav\Model\EntityFactory $eavEntityFactory
-	 * @param \Magento\Catalog\Model\ResourceModel\Helper $resourceHelper
-	 * @param \Magento\Framework\Validator\UniversalFactory $universalFactory
-	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-	 * @param \Magento\Framework\Module\Manager $moduleManager
-	 * @param \Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState
-	 * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
-	 * @param \Magento\Catalog\Model\Product\OptionFactory $productOptionFactory
-	 * @param \Magento\Catalog\Model\ResourceModel\Url $catalogUrl
-	 * @param \Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate
-	 * @param \Magento\Customer\Model\Session $customerSession
-	 * @param \Magento\Framework\Stdlib\DateTime $dateTime
-	 * @param \Magento\Customer\Api\GroupManagementInterface $groupManagement
-	 * @param \Magento\Search\Model\QueryFactory $catalogSearchData
-	 * @param \Magento\Framework\Search\Request\Builder $requestBuilder
-	 * @param \Magento\Search\Model\SearchEngine $searchEngine
-	 * @param \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory
-	 * @param \Magento\Framework\DB\Adapter\AdapterInterface $connection
-	 * @param string $searchRequestName
-	 * @param SearchResultFactory $searchResultFactory
-	 * @SuppressWarnings(PHPMD.ExcessiveParameterList)
-	 */
-	public function __construct(
-		\Magento\Framework\Data\Collection\EntityFactory $entityFactory,
-		\Psr\Log\LoggerInterface $logger,
-		\Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy,
-		\Magento\Framework\Event\ManagerInterface $eventManager,
-		\Magento\Eav\Model\Config $eavConfig,
-		\Magento\Framework\App\ResourceConnection $resource,
-		\Magento\Eav\Model\EntityFactory $eavEntityFactory,
-		\Magento\Catalog\Model\ResourceModel\Helper $resourceHelper,
-		\Magento\Framework\Validator\UniversalFactory $universalFactory,
-		\Magento\Store\Model\StoreManagerInterface $storeManager,
-		\Magento\Framework\Module\Manager $moduleManager,
-		\Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState,
-		\Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
-		\Magento\Catalog\Model\Product\OptionFactory $productOptionFactory,
-		\Magento\Catalog\Model\ResourceModel\Url $catalogUrl,
-		\Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate,
-		\Magento\Customer\Model\Session $customerSession,
-		\Magento\Framework\Stdlib\DateTime $dateTime,
-		\Magento\Customer\Api\GroupManagementInterface $groupManagement,
-		\Magento\Search\Model\QueryFactory $catalogSearchData,
-		\Magento\Framework\Search\Request\Builder $requestBuilder,
-		\Magento\Search\Model\SearchEngine $searchEngine,
-		\Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory,
-		\Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
-		$searchRequestName = 'catalog_view_container',
-		SearchResultFactory $searchResultFactory = null
-	)
-	{
-
-		$this->queryFactory = $catalogSearchData;
-		if ($searchResultFactory === null) {
-			$this->searchResultFactory = \Magento\Framework\App\ObjectManager::getInstance()
-				->get('Magento\Framework\Api\Search\SearchResultFactory');
-		}
-		parent::__construct(
-			$entityFactory,
-			$logger,
-			$fetchStrategy,
-			$eventManager,
-			$eavConfig,
-			$resource,
-			$eavEntityFactory,
-			$resourceHelper,
-			$universalFactory,
-			$storeManager,
-			$moduleManager,
-			$catalogProductFlatState,
-			$scopeConfig,
-			$productOptionFactory,
-			$catalogUrl,
-			$localeDate,
-			$customerSession,
-			$dateTime,
-			$groupManagement,
-			$connection
-		);
-		$this->requestBuilder          = $requestBuilder;
-		$this->searchEngine            = $searchEngine;
-		$this->temporaryStorageFactory = $temporaryStorageFactory;
-		$this->searchRequestName       = $searchRequestName;
-	}
-
-	/**
-	 * @deprecated
-	 * @return \Magento\Search\Api\SearchInterface
-	 */
-	private function getSearch()
-	{
-		if ($this->search === null) {
-			$this->search = ObjectManager::getInstance()->get('\Magento\Search\Api\SearchInterface');
-		}
-
-		return $this->search;
-	}
-
-	/**
-	 * @deprecated
-	 * @param \Magento\Search\Api\SearchInterface $object
-	 * @return void
-	 */
-	public function setSearch(\Magento\Search\Api\SearchInterface $object)
-	{
-		$this->search = $object;
-	}
-
-	/**
-	 * @deprecated
-	 * @return \Magento\Framework\Api\Search\SearchCriteriaBuilder
-	 */
-	public function getSearchCriteriaBuilder()
-	{
-		if ($this->searchCriteriaBuilder === null) {
-			$this->searchCriteriaBuilder = ObjectManager::getInstance()
-				->get('\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder');
-		}
-
-		return $this->searchCriteriaBuilder;
-	}
-
-	/**
-	 * @return null
-	 */
-	public function getCollectionClone()
-	{
-		$collectionClone = clone $this->collectionClone;
-		$collectionClone->setSearchCriteriaBuilder($this->collectionClone->getSearchCriteriaBuilder()->cloneObject());
-
-		return $collectionClone;
-	}
-
-	/**
-	 * @return $this
-	 */
-	public function cloneObject()
-	{
-		if ($this->collectionClone === null) {
-			$this->collectionClone = clone $this;
-			$this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
-		}
-
-		return $this;
-	}
-
-	/**
-	 * @param $attributeCode
-	 * @return $this
-	 */
-	public function removeAttributeSearch($attributeCode)
-	{
-		if (is_array($attributeCode)) {
-			foreach ($attributeCode as $attCode) {
-				$this->searchCriteriaBuilder->removeFilter($attCode);
-			}
-		} else {
-			$this->searchCriteriaBuilder->removeFilter($attributeCode);
-		}
-
-		$this->_isFiltersRendered = false;
-
-		return $this->loadWithFilter();
-	}
-
-	/**
-	 * Get attribute condition sql
-	 *
-	 * @param $attribute
-	 * @param $condition
-	 * @param string $joinType
-	 * @return string
-	 */
-	public function getAttributeConditionSql($attribute, $condition, $joinType = 'inner')
-	{
-		return $this->_getAttributeConditionSql($attribute, $condition, $joinType);
-	}
-
-	/**
-	 * Reset Total records
-	 *
-	 * @return $this
-	 */
-	public function resetTotalRecords()
-	{
-		$this->_totalRecords = null;
-
-		return $this;
-	}
-
-	/**
-	 * @param \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object
-	 */
-	public function setSearchCriteriaBuilder(\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object)
-	{
-		$this->searchCriteriaBuilder = $object;
-	}
-
-	/**
-	 * @deprecated
-	 * @return \Magento\Framework\Api\FilterBuilder
-	 */
-	private function getFilterBuilder()
-	{
-		if ($this->filterBuilder === null) {
-			$this->filterBuilder = ObjectManager::getInstance()->get('\Magento\Framework\Api\FilterBuilder');
-		}
-
-		return $this->filterBuilder;
-	}
-
-	/**
-	 * @deprecated
-	 * @param \Magento\Framework\Api\FilterBuilder $object
-	 * @return void
-	 */
-	public function setFilterBuilder(\Magento\Framework\Api\FilterBuilder $object)
-	{
-		$this->filterBuilder = $object;
-	}
-
-	/**
-	 * Apply attribute filter to facet collection
-	 *
-	 * @param string $field
-	 * @param null $condition
-	 * @return $this
-	 */
-	public function addFieldToFilter($field, $condition = null)
-	{
-		if ($this->searchResult !== null) {
-			throw new \RuntimeException('Illegal state');
-		}
-
-		$this->getSearchCriteriaBuilder();
-		$this->getFilterBuilder();
-		if (!is_array($condition) || !in_array(key($condition), ['from', 'to'])) {
-			$this->filterBuilder->setField($field);
-			$this->filterBuilder->setValue($condition);
-			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-		} else {
-			if (!empty($condition['from'])) {
-				$this->filterBuilder->setField("{$field}.from");
-				$this->filterBuilder->setValue($condition['from']);
-				$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-			}
-			if (!empty($condition['to'])) {
-				$this->filterBuilder->setField("{$field}.to");
-				$this->filterBuilder->setValue($condition['to']);
-				$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-			}
-		}
-
-		return $this;
-	}
-
-	/**
-	 * Add search query filter
-	 *
-	 * @param string $query
-	 * @return $this
-	 */
-	public function addSearchFilter($query)
-	{
-		$this->queryText = trim($this->queryText . ' ' . $query);
-
-		return $this;
-	}
-
-	/**
-	 * @inheritdoc
-	 */
-	protected function _renderFiltersBefore()
-	{
-		$this->getSearchCriteriaBuilder();
-		$this->getFilterBuilder();
-		$this->getSearch();
-
-		if ($this->queryText) {
-			$this->filterBuilder->setField('search_term');
-			$this->filterBuilder->setValue($this->queryText);
-			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-		}
-
-		$priceRangeCalculation = $this->_scopeConfig->getValue(
-			\Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory::XML_PATH_RANGE_CALCULATION,
-			\Magento\Store\Model\ScopeInterface::SCOPE_STORE
-		);
-		if ($priceRangeCalculation) {
-			$this->filterBuilder->setField('price_dynamic_algorithm');
-			$this->filterBuilder->setValue($priceRangeCalculation);
-			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-		}
-
-		$this->cloneObject();
-
-		$searchCriteria = $this->searchCriteriaBuilder->create();
-		$searchCriteria->setRequestName($this->searchRequestName);
-
-		try {
-			$this->searchResult = $this->getSearch()->search($searchCriteria);
-		} catch (EmptyRequestDataException $e) {
-			/** @var \Magento\Framework\Api\Search\SearchResultInterface $searchResult */
-			$this->searchResult = $this->searchResultFactory->create()->setItems([]);
-		} catch (NonExistingRequestNameException $e) {
-			$this->_logger->error($e->getMessage());
-			throw new LocalizedException(__('Sorry, something went wrong. You can find out more in the error log.'));
-		}
-
-		$temporaryStorage = $this->temporaryStorageFactory->create();
-		$table            = $temporaryStorage->storeApiDocuments($this->searchResult->getItems());
-
-		$this->getSelect()->joinInner(
-			[
-				'search_result' => $table->getName(),
-			],
-			'e.entity_id = search_result.' . TemporaryStorage::FIELD_ENTITY_ID,
-			[]
-		);
-
-//		$this->_totalRecords = $this->searchResult->getTotalCount();
-
-		if ($this->order && 'relevance' === $this->order['field']) {
-			$this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
-		}
-
-		return parent::_renderFiltersBefore();
-	}
-
-	/**
-	 * @return $this
-	 */
-	protected function _renderFilters()
-	{
-		$this->_filters = [];
-
-		return parent::_renderFilters();
-	}
-
-	/**
-	 * Set Order field
-	 *
-	 * @param string $attribute
-	 * @param string $dir
-	 * @return $this
-	 */
-	public function setOrder($attribute, $dir = Select::SQL_DESC)
-	{
-		$this->order = ['field' => $attribute, 'dir' => $dir];
-		if ($attribute != 'relevance') {
-			parent::setOrder($attribute, $dir);
-		}
-
-		return $this;
-	}
-
-	/**
-	 * Stub method for compatibility with other search engines
-	 *
-	 * @return $this
-	 */
-	public function setGeneralDefaultQuery()
-	{
-		return $this;
-	}
-
-	/**
-	 * Return field faceted data from faceted search result
-	 *
-	 * @param string $field
-	 * @return array
-	 * @throws StateException
-	 */
-	public function getFacetedData($field)
-	{
-		$this->_renderFilters();
-		$result = [];
-
-		$aggregations = $this->searchResult->getAggregations();
-		// This behavior is for case with empty object when we got EmptyRequestDataException
-		if (null !== $aggregations) {
-			$bucket = $aggregations->getBucket($field . RequestGenerator::BUCKET_SUFFIX);
-			if ($bucket) {
-				foreach ($bucket->getValues() as $value) {
-					$metrics                   = $value->getMetrics();
-					$result[$metrics['value']] = $metrics;
-				}
-			} else {
-				throw new StateException(__('Bucket does not exist'));
-			}
-		}
-
-		return $result;
-	}
-
-	/**
-	 * Specify category filter for product collection
-	 *
-	 * @param \Magento\Catalog\Model\Category $category
-	 * @return $this
-	 */
-	public function addCategoryFilter(\Magento\Catalog\Model\Category $category)
-	{
-		$this->addFieldToFilter('category_ids', $category->getId());
-
-		return parent::addCategoryFilter($category);
-	}
-
-	/**
-	 * Set product visibility filter for enabled products
-	 *
-	 * @param array $visibility
-	 * @return $this
-	 */
-	public function setVisibility($visibility)
-	{
-		$this->addFieldToFilter('visibility', $visibility);
-
-		return parent::setVisibility($visibility);
-	}
+    /**
+     * @var  QueryResponse
+     * @deprecated
+     */
+    protected $queryResponse;
+
+    /**
+     * Catalog search data
+     *
+     * @var \Magento\Search\Model\QueryFactory
+     * @deprecated
+     */
+    protected $queryFactory = null;
+
+    /**
+     * @var \Magento\Framework\Search\Request\Builder
+     * @deprecated
+     */
+    private $requestBuilder;
+
+    /**
+     * @var \Magento\Search\Model\SearchEngine
+     * @deprecated
+     */
+    private $searchEngine;
+
+    /**
+     * @var string
+     */
+    private $queryText;
+
+    /**
+     * @var string|null
+     */
+    private $order = null;
+
+    /**
+     * @var string
+     */
+    private $searchRequestName;
+
+    /**
+     * @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory
+     */
+    private $temporaryStorageFactory;
+
+    /**
+     * @var \Magento\Search\Api\SearchInterface
+     */
+    private $search;
+
+    /**
+     * @var \Magento\Framework\Api\Search\SearchCriteriaBuilder
+     */
+    private $searchCriteriaBuilder;
+
+    /**
+     * @var \Magento\Framework\Api\Search\SearchResultInterface
+     */
+    private $searchResult;
+
+    /**
+     * @var SearchResultFactory
+     */
+    private $searchResultFactory;
+
+    /**
+     * @var \Magento\Framework\Api\FilterBuilder
+     */
+    private $filterBuilder;
+
+    /**
+     * @type null
+     */
+    public $collectionClone = null;
+
+    /**
+     * @param \Magento\Framework\Data\Collection\EntityFactory $entityFactory
+     * @param \Psr\Log\LoggerInterface $logger
+     * @param \Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy
+     * @param \Magento\Framework\Event\ManagerInterface $eventManager
+     * @param \Magento\Eav\Model\Config $eavConfig
+     * @param \Magento\Framework\App\ResourceConnection $resource
+     * @param \Magento\Eav\Model\EntityFactory $eavEntityFactory
+     * @param \Magento\Catalog\Model\ResourceModel\Helper $resourceHelper
+     * @param \Magento\Framework\Validator\UniversalFactory $universalFactory
+     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+     * @param \Magento\Framework\Module\Manager $moduleManager
+     * @param \Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState
+     * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
+     * @param \Magento\Catalog\Model\Product\OptionFactory $productOptionFactory
+     * @param \Magento\Catalog\Model\ResourceModel\Url $catalogUrl
+     * @param \Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate
+     * @param \Magento\Customer\Model\Session $customerSession
+     * @param \Magento\Framework\Stdlib\DateTime $dateTime
+     * @param \Magento\Customer\Api\GroupManagementInterface $groupManagement
+     * @param \Magento\Search\Model\QueryFactory $catalogSearchData
+     * @param \Magento\Framework\Search\Request\Builder $requestBuilder
+     * @param \Magento\Search\Model\SearchEngine $searchEngine
+     * @param \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory
+     * @param \Magento\Framework\DB\Adapter\AdapterInterface $connection
+     * @param string $searchRequestName
+     * @param SearchResultFactory $searchResultFactory
+     * @SuppressWarnings(PHPMD.ExcessiveParameterList)
+     */
+    public function __construct(
+        \Magento\Framework\Data\Collection\EntityFactory $entityFactory,
+        \Psr\Log\LoggerInterface $logger,
+        \Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy,
+        \Magento\Framework\Event\ManagerInterface $eventManager,
+        \Magento\Eav\Model\Config $eavConfig,
+        \Magento\Framework\App\ResourceConnection $resource,
+        \Magento\Eav\Model\EntityFactory $eavEntityFactory,
+        \Magento\Catalog\Model\ResourceModel\Helper $resourceHelper,
+        \Magento\Framework\Validator\UniversalFactory $universalFactory,
+        \Magento\Store\Model\StoreManagerInterface $storeManager,
+        \Magento\Framework\Module\Manager $moduleManager,
+        \Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState,
+        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
+        \Magento\Catalog\Model\Product\OptionFactory $productOptionFactory,
+        \Magento\Catalog\Model\ResourceModel\Url $catalogUrl,
+        \Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate,
+        \Magento\Customer\Model\Session $customerSession,
+        \Magento\Framework\Stdlib\DateTime $dateTime,
+        \Magento\Customer\Api\GroupManagementInterface $groupManagement,
+        \Magento\Search\Model\QueryFactory $catalogSearchData,
+        \Magento\Framework\Search\Request\Builder $requestBuilder,
+        \Magento\Search\Model\SearchEngine $searchEngine,
+        \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory,
+        \Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
+        $searchRequestName = 'catalog_view_container',
+        SearchResultFactory $searchResultFactory = null
+    ) {
+    
+        $this->queryFactory = $catalogSearchData;
+        if ($searchResultFactory === null) {
+            $this->searchResultFactory = \Magento\Framework\App\ObjectManager::getInstance()
+                ->get('Magento\Framework\Api\Search\SearchResultFactory');
+        }
+        parent::__construct(
+            $entityFactory,
+            $logger,
+            $fetchStrategy,
+            $eventManager,
+            $eavConfig,
+            $resource,
+            $eavEntityFactory,
+            $resourceHelper,
+            $universalFactory,
+            $storeManager,
+            $moduleManager,
+            $catalogProductFlatState,
+            $scopeConfig,
+            $productOptionFactory,
+            $catalogUrl,
+            $localeDate,
+            $customerSession,
+            $dateTime,
+            $groupManagement,
+            $connection
+        );
+        $this->requestBuilder          = $requestBuilder;
+        $this->searchEngine            = $searchEngine;
+        $this->temporaryStorageFactory = $temporaryStorageFactory;
+        $this->searchRequestName       = $searchRequestName;
+    }
+
+    /**
+     * @deprecated
+     * @return \Magento\Search\Api\SearchInterface
+     */
+    private function getSearch()
+    {
+        if ($this->search === null) {
+            $this->search = ObjectManager::getInstance()->get('\Magento\Search\Api\SearchInterface');
+        }
+
+        return $this->search;
+    }
+
+    /**
+     * @deprecated
+     * @param \Magento\Search\Api\SearchInterface $object
+     * @return void
+     */
+    public function setSearch(\Magento\Search\Api\SearchInterface $object)
+    {
+        $this->search = $object;
+    }
+
+    /**
+     * @deprecated
+     * @return \Magento\Framework\Api\Search\SearchCriteriaBuilder
+     */
+    public function getSearchCriteriaBuilder()
+    {
+        if ($this->searchCriteriaBuilder === null) {
+            $this->searchCriteriaBuilder = ObjectManager::getInstance()
+                ->get('\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder');
+        }
+
+        return $this->searchCriteriaBuilder;
+    }
+
+    /**
+     * @return null
+     */
+    public function getCollectionClone()
+    {
+        $collectionClone = clone $this->collectionClone;
+        $collectionClone->setSearchCriteriaBuilder($this->collectionClone->getSearchCriteriaBuilder()->cloneObject());
+
+        return $collectionClone;
+    }
+
+    /**
+     * @return $this
+     */
+    public function cloneObject()
+    {
+        if ($this->collectionClone === null) {
+            $this->collectionClone = clone $this;
+            $this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
+        }
+
+        return $this;
+    }
+
+    /**
+     * @param $attributeCode
+     * @return $this
+     */
+    public function removeAttributeSearch($attributeCode)
+    {
+        if (is_array($attributeCode)) {
+            foreach ($attributeCode as $attCode) {
+                $this->searchCriteriaBuilder->removeFilter($attCode);
+            }
+        } else {
+            $this->searchCriteriaBuilder->removeFilter($attributeCode);
+        }
+
+        $this->_isFiltersRendered = false;
+
+        return $this->loadWithFilter();
+    }
+
+    /**
+     * @param \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object
+     */
+    public function setSearchCriteriaBuilder(\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object)
+    {
+        $this->searchCriteriaBuilder = $object;
+    }
+
+    /**
+     * @deprecated
+     * @return \Magento\Framework\Api\FilterBuilder
+     */
+    private function getFilterBuilder()
+    {
+        if ($this->filterBuilder === null) {
+            $this->filterBuilder = ObjectManager::getInstance()->get('\Magento\Framework\Api\FilterBuilder');
+        }
+
+        return $this->filterBuilder;
+    }
+
+    /**
+     * @deprecated
+     * @param \Magento\Framework\Api\FilterBuilder $object
+     * @return void
+     */
+    public function setFilterBuilder(\Magento\Framework\Api\FilterBuilder $object)
+    {
+        $this->filterBuilder = $object;
+    }
+
+    /**
+     * Apply attribute filter to facet collection
+     *
+     * @param string $field
+     * @param null $condition
+     * @return $this
+     */
+    public function addFieldToFilter($field, $condition = null)
+    {
+        if ($this->searchResult !== null) {
+            throw new \RuntimeException('Illegal state');
+        }
+
+        $this->getSearchCriteriaBuilder();
+        $this->getFilterBuilder();
+        if (!is_array($condition) || !in_array(key($condition), ['from', 'to'])) {
+            $this->filterBuilder->setField($field);
+            $this->filterBuilder->setValue($condition);
+            $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+        } else {
+            if (!empty($condition['from'])) {
+                $this->filterBuilder->setField("{$field}.from");
+                $this->filterBuilder->setValue($condition['from']);
+                $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+            }
+            if (!empty($condition['to'])) {
+                $this->filterBuilder->setField("{$field}.to");
+                $this->filterBuilder->setValue($condition['to']);
+                $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+            }
+        }
+
+        return $this;
+    }
+
+    /**
+     * Add search query filter
+     *
+     * @param string $query
+     * @return $this
+     */
+    public function addSearchFilter($query)
+    {
+        $this->queryText = trim($this->queryText . ' ' . $query);
+
+        return $this;
+    }
+
+    /**
+     * @inheritdoc
+     */
+    protected function _renderFiltersBefore()
+    {
+        $this->getSearchCriteriaBuilder();
+        $this->getFilterBuilder();
+        $this->getSearch();
+
+        if ($this->queryText) {
+            $this->filterBuilder->setField('search_term');
+            $this->filterBuilder->setValue($this->queryText);
+            $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+        }
+
+        $priceRangeCalculation = $this->_scopeConfig->getValue(
+            \Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory::XML_PATH_RANGE_CALCULATION,
+            \Magento\Store\Model\ScopeInterface::SCOPE_STORE
+        );
+        if ($priceRangeCalculation) {
+            $this->filterBuilder->setField('price_dynamic_algorithm');
+            $this->filterBuilder->setValue($priceRangeCalculation);
+            $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+        }
+
+        $this->cloneObject();
+
+        $searchCriteria = $this->searchCriteriaBuilder->create();
+        $searchCriteria->setRequestName($this->searchRequestName);
+
+        try {
+            $this->searchResult = $this->getSearch()->search($searchCriteria);
+        } catch (EmptyRequestDataException $e) {
+            /** @var \Magento\Framework\Api\Search\SearchResultInterface $searchResult */
+            $this->searchResult = $this->searchResultFactory->create()->setItems([]);
+        } catch (NonExistingRequestNameException $e) {
+            $this->_logger->error($e->getMessage());
+            throw new LocalizedException(__('Sorry, something went wrong. You can find out more in the error log.'));
+        }
+
+        $temporaryStorage = $this->temporaryStorageFactory->create();
+        $table            = $temporaryStorage->storeApiDocuments($this->searchResult->getItems());
+
+        $this->getSelect()->joinInner(
+            [
+                'search_result' => $table->getName(),
+            ],
+            'e.entity_id = search_result.' . TemporaryStorage::FIELD_ENTITY_ID,
+            []
+        );
+
+        $this->_totalRecords = $this->searchResult->getTotalCount();
+
+        if ($this->order && 'relevance' === $this->order['field']) {
+            $this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
+        }
+
+        return parent::_renderFiltersBefore();
+    }
+
+    /**
+     * @return $this
+     */
+    protected function _renderFilters()
+    {
+        $this->_filters = [];
+
+        return parent::_renderFilters();
+    }
+
+    /**
+     * Set Order field
+     *
+     * @param string $attribute
+     * @param string $dir
+     * @return $this
+     */
+    public function setOrder($attribute, $dir = Select::SQL_DESC)
+    {
+        $this->order = ['field' => $attribute, 'dir' => $dir];
+        if ($attribute != 'relevance') {
+            parent::setOrder($attribute, $dir);
+        }
+
+        return $this;
+    }
+
+    /**
+     * Stub method for compatibility with other search engines
+     *
+     * @return $this
+     */
+    public function setGeneralDefaultQuery()
+    {
+        return $this;
+    }
+
+    /**
+     * Return field faceted data from faceted search result
+     *
+     * @param string $field
+     * @return array
+     * @throws StateException
+     */
+    public function getFacetedData($field)
+    {
+        $this->_renderFilters();
+        $result = [];
+
+        $aggregations = $this->searchResult->getAggregations();
+        // This behavior is for case with empty object when we got EmptyRequestDataException
+        if (null !== $aggregations) {
+            $bucket = $aggregations->getBucket($field . RequestGenerator::BUCKET_SUFFIX);
+            if ($bucket) {
+                foreach ($bucket->getValues() as $value) {
+                    $metrics                   = $value->getMetrics();
+                    $result[$metrics['value']] = $metrics;
+                }
+            } else {
+                throw new StateException(__('Bucket does not exist'));
+            }
+        }
+
+        return $result;
+    }
+
+    /**
+     * Specify category filter for product collection
+     *
+     * @param \Magento\Catalog\Model\Category $category
+     * @return $this
+     */
+    public function addCategoryFilter(\Magento\Catalog\Model\Category $category)
+    {
+        $this->addFieldToFilter('category_ids', $category->getId());
+
+        return parent::addCategoryFilter($category);
+    }
+
+    /**
+     * Set product visibility filter for enabled products
+     *
+     * @param array $visibility
+     * @return $this
+     */
+    public function setVisibility($visibility)
+    {
+        $this->addFieldToFilter('visibility', $visibility);
+
+        return parent::setVisibility($visibility);
+    }
 }
diff --git a/Model/Search/FilterGroup.php b/Model/Search/FilterGroup.php
index 02e6231..a128c37 100644
--- a/Model/Search/FilterGroup.php
+++ b/Model/Search/FilterGroup.php
@@ -18,6 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\Search\FilterGroup as SourceFilterGroup;
diff --git a/Model/Search/FilterGroupBuilder.php b/Model/Search/FilterGroupBuilder.php
index 387ac1b..c345c26 100644
--- a/Model/Search/FilterGroupBuilder.php
+++ b/Model/Search/FilterGroupBuilder.php
@@ -18,6 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\FilterBuilder;
diff --git a/Model/Search/SearchCriteria.php b/Model/Search/SearchCriteria.php
index 1b6ad3c..91423fe 100644
--- a/Model/Search/SearchCriteria.php
+++ b/Model/Search/SearchCriteria.php
@@ -18,6 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\Search\SearchCriteria as SourceSearchCriteria;
diff --git a/Model/Search/SearchCriteriaBuilder.php b/Model/Search/SearchCriteriaBuilder.php
index f767e94..7e0a1e2 100644
--- a/Model/Search/SearchCriteriaBuilder.php
+++ b/Model/Search/SearchCriteriaBuilder.php
@@ -18,6 +18,7 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\ObjectFactory;
diff --git a/Block/Plugin/Swatches/RenderLayered.php b/Plugins/Block/RenderLayered.php
similarity index 89%
rename from Block/Plugin/Swatches/RenderLayered.php
rename to Plugins/Block/RenderLayered.php
index 2324eb1..bae8b44 100644
--- a/Block/Plugin/Swatches/RenderLayered.php
+++ b/Plugins/Block/RenderLayered.php
@@ -18,12 +18,9 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\LayeredNavigation\Block\Plugin\Swatches;
 
-/**
- * Class RenderLayered
- * @package Mageplaza\LayeredNavigation\Block\Plugin\Swatches
- */
+namespace Mageplaza\LayeredNavigation\Plugins\Block;
+
 class RenderLayered
 {
 	/**
@@ -92,11 +89,6 @@ class RenderLayered
 		}
 		if (!in_array($optionId, $value)) {
 			$value[] = $optionId;
-		} else {
-			$key = array_search($optionId, $value);
-			if ($key !== false) {
-				unset($value[$key]);
-			}
 		}
 
 		$query = [$attributeCode => implode(',', $value)];
diff --git a/Controller/Plugin/Category/View.php b/Plugins/Controller/Category/View.php
similarity index 91%
rename from Controller/Plugin/Category/View.php
rename to Plugins/Controller/Category/View.php
index dc82a5a..89164c7 100644
--- a/Controller/Plugin/Category/View.php
+++ b/Plugins/Controller/Category/View.php
@@ -18,12 +18,9 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\LayeredNavigation\Controller\Plugin\Category;
 
-/**
- * Class View
- * @package Mageplaza\LayeredNavigation\Controller\Plugin\Category
- */
+namespace Mageplaza\LayeredNavigation\Plugins\Controller\Category;
+
 class View
 {
     protected $_jsonHelper;
@@ -51,7 +48,7 @@ class View
      */
     public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
     {
-        if ($this->_moduleHelper->isEnabled() && $action->getRequest()->isAjax()) {
+        if ($this->_moduleHelper->isEnabled() && $action->getRequest()->getParam('isAjax')) {
             $navigation = $page->getLayout()->getBlock('catalog.leftnav');
             $products = $page->getLayout()->getBlock('category.products');
             $result = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
diff --git a/Model/Plugin/Layer/Filter/Item.php b/Plugins/Model/Layer/Filter/Item.php
similarity index 69%
rename from Model/Plugin/Layer/Filter/Item.php
rename to Plugins/Model/Layer/Filter/Item.php
index 8de412f..168d52f 100644
--- a/Model/Plugin/Layer/Filter/Item.php
+++ b/Plugins/Model/Layer/Filter/Item.php
@@ -18,34 +18,18 @@
  * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\LayeredNavigation\Model\Plugin\Layer\Filter;
 
-use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
+namespace Mageplaza\LayeredNavigation\Plugins\Model\Layer\Filter;
 
 /**
  * Class Item
- * @package Mageplaza\LayeredNavigation\Model\Plugin\Layer\Filter
+ * @package Mageplaza\LayeredNavigation\Plugins\Model\Layer\Filter
  */
 class Item
 {
-	/**
-	 * @type \Magento\Framework\UrlInterface
-	 */
 	protected $_url;
-
-	/**
-	 * @type \Magento\Theme\Block\Html\Pager
-	 */
 	protected $_htmlPagerBlock;
-
-	/**
-	 * @type \Magento\Framework\App\RequestInterface
-	 */
 	protected $_request;
-
-	/**
-	 * @type \Mageplaza\LayeredNavigation\Helper\Data
-	 */
 	protected $_moduleHelper;
 
 	/**
@@ -60,7 +44,7 @@ class Item
 		\Magento\Framework\UrlInterface $url,
 		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
 		\Magento\Framework\App\RequestInterface $request,
-		LayerHelper $moduleHelper
+		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
 	)
 	{
 		$this->_url            = $url;
@@ -81,12 +65,11 @@ class Item
 			return $proceed();
 		}
 
-		$value  = [];
-		$filter = $item->getFilter();
-		if ($filter->getFilterType() == LayerHelper::FILTER_TYPE_RANGE) {
-			$value = ["{start}-{end}"];
-		} else if ($filter->isMultiple()) {
-			$requestVar = $filter->getRequestVar();
+		$value      = [];
+		$requestVar = $item->getFilter()->getRequestVar();
+		if ($requestVar == 'price') {
+			$value = ["{price_start}-{price_end}"];
+		} else if ($this->_moduleHelper->getGeneralConfig('allow_multiple')) {
 			if ($requestValue = $this->_request->getParam($requestVar)) {
 				$value = explode(',', $requestValue);
 			}
@@ -121,21 +104,23 @@ class Item
 		}
 
 		$value      = [];
-		$filter     = $item->getFilter();
-		$requestVar = $filter->getRequestVar();
-		if ($filter->getFilterType() != LayerHelper::FILTER_TYPE_RANGE) {
-			if ($requestValue = $this->_request->getParam($requestVar)) {
-				$value = explode(',', $requestValue);
-			}
+		$requestVar = $item->getFilter()->getRequestVar();
+		if ($requestValue = $this->_request->getParam($requestVar)) {
+			$value = explode(',', $requestValue);
+		}
 
-			if (in_array($item->getValue(), $value)) {
-				$value = array_diff($value, [$item->getValue()]);
-			}
+		if (in_array($item->getValue(), $value)) {
+			$value = array_diff($value, [$item->getValue()]);
+		}
+
+		if ($requestVar == 'price') {
+			$value = [];
 		}
 
-		$params['_query']       = [$requestVar => count($value) ? implode(',', $value) : $filter->getResetValue()];
+		$query                  = [$requestVar => count($value) ? implode(',', $value) : $item->getFilter()->getResetValue()];
 		$params['_current']     = true;
 		$params['_use_rewrite'] = true;
+		$params['_query']       = $query;
 		$params['_escape']      = true;
 
 		return $this->_url->getUrl('*/*/*', $params);
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 11a91e7..8226c16 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -45,6 +45,25 @@
                     <label>Module Enable</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
+                <field id="allow_multiple" translate="label" type="select" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
+                    <label>Allow Multiple Filter</label>
+                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                </field>
+            </group>
+            <group id="display" translate="label" type="text" sortOrder="20" showInDefault="1" showInWebsite="1" showInStore="1">
+                <label>Display Configuration</label>
+                <field id="show_zero" translate="label" type="select" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
+                    <label>Show Option With No Product</label>
+                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                </field>
+                <field id="show_counter" translate="label" type="select" sortOrder="20" showInDefault="1" showInWebsite="1" showInStore="1">
+                    <label>Display Product Count</label>
+                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                </field>
+                <field id="auto_open" translate="label" type="select" sortOrder="30" showInDefault="1" showInWebsite="1" showInStore="1">
+                    <label>Auto Open Attribute Group</label>
+                    <source_model>Mageplaza\LayeredNavigation\Model\Config\Source\ActiveFilter</source_model>
+                </field>
             </group>
         </section>
     </system>
diff --git a/etc/config.xml b/etc/config.xml
index f0e70f3..206fb89 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -26,7 +26,14 @@
         <layered_navigation>
             <general>
                 <enable>1</enable>
+                <allow_multiple>1</allow_multiple>
+                <enable_shop_by>0</enable_shop_by>
             </general>
+            <display>
+                <show_zero>0</show_zero>
+                <auto_open>0</auto_open>
+                <show_counter>1</show_counter>
+            </display>
         </layered_navigation>
     </default>
 </config>
diff --git a/etc/di.xml b/etc/di.xml
index dffa798..55c1ddc 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -27,8 +27,8 @@
             <argument name="filters" xsi:type="array">
                 <item name="attribute" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Attribute</item>
                 <item name="price" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Price</item>
-                <item name="decimal" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Decimal</item>
-                <item name="category" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Category</item>
+                <!--<item name="decimal" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Decimal</item>-->
+                <!--<item name="category" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Category</item>-->
             </argument>
         </arguments>
     </virtualType>
@@ -42,4 +42,5 @@
             <argument name="collectionFactory" xsi:type="object">Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\CollectionFactory</argument>
         </arguments>
     </type>
+
 </config>
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index 3f802da..0c0b927 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -23,12 +23,12 @@
 
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <type name="Magento\Catalog\Controller\Category\View">
-        <plugin name="layer_navigation_ajax_update" type="Mageplaza\LayeredNavigation\Controller\Plugin\Category\View" sortOrder="1" />
+        <plugin name="layer_navigation_ajax_update" type="Mageplaza\LayeredNavigation\Plugins\Controller\Category\View" sortOrder="1" />
     </type>
     <type name="Magento\Catalog\Model\Layer\Filter\Item">
-        <plugin name="ln_filter_item_url" type="Mageplaza\LayeredNavigation\Model\Plugin\Layer\Filter\Item" sortOrder="1" />
+        <plugin name="ln_filter_item_url" type="Mageplaza\LayeredNavigation\Plugins\Model\Layer\Filter\Item" sortOrder="1" />
     </type>
     <type name="Magento\Swatches\Block\LayeredNavigation\RenderLayered">
-        <plugin name="ln_filter_item_swatch_url" type="Mageplaza\LayeredNavigation\Block\Plugin\Swatches\RenderLayered" sortOrder="1" />
+        <plugin name="ln_filter_item_swatch_url" type="Mageplaza\LayeredNavigation\Plugins\Block\RenderLayered" sortOrder="1" />
     </type>
 </config>
diff --git a/etc/module.xml b/etc/module.xml
index d36e25e..44f390d 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -22,7 +22,7 @@
 -->
 
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
-    <module name="Mageplaza_LayeredNavigation" setup_version="2.0.0">
+    <module name="Mageplaza_LayeredNavigation" setup_version="1.0.0">
         <sequence>
             <module name="Magento_Catalog"/>
             <module name="Magento_LayeredNavigation"/>
diff --git a/registration.php b/registration.php
index 521b62d..826d79e 100644
--- a/registration.php
+++ b/registration.php
@@ -1,23 +1,4 @@
 <?php
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license that is
- * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
 
 \Magento\Framework\Component\ComponentRegistrar::register(
     \Magento\Framework\Component\ComponentRegistrar::MODULE,
diff --git a/view/frontend/layout/catalog_category_view_type_layered.xml b/view/frontend/layout/catalog_category_view_type_layered.xml
index 0e9f9f1..aaf47d9 100644
--- a/view/frontend/layout/catalog_category_view_type_layered.xml
+++ b/view/frontend/layout/catalog_category_view_type_layered.xml
@@ -26,8 +26,6 @@
             <action method="setTemplate" ifconfig="layered_navigation/general/enable">
                 <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::view.phtml</argument>
             </action>
-            <container name="layer.additional.info" as="layer_additional_info"/>
-            <container name="layer.content.before" as="layer_content_before"/>
         </referenceBlock>
         <referenceBlock name="catalog.navigation.renderer">
             <action method="setTemplate" ifconfig="layered_navigation/general/enable">
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
deleted file mode 100644
index 3f58af1..0000000
--- a/view/frontend/requirejs-config.js
+++ /dev/null
@@ -1,27 +0,0 @@
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license sliderConfig is
- * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-var config = {
-    map: {
-        '*': {
-            'mpLayer': 'Mageplaza_LayeredNavigation/js/view/layer'
-        }
-    }
-};
diff --git a/view/frontend/templates/filter.phtml b/view/frontend/templates/filter.phtml
index 0c78e0f..70b2979 100644
--- a/view/frontend/templates/filter.phtml
+++ b/view/frontend/templates/filter.phtml
@@ -19,25 +19,62 @@
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
-<?php
-/** @type \Mageplaza\LayeredNavigation\Model\Layer\Filter\Attribute $filter */
-$filter = $this->getFilter();
-$attributeCode = $filter->getRequestVar();
-?>
+
 <ol class="items">
-    <?php /** @type  $filterItem */ foreach ($filterItems as $filterItem): ?>
+    <?php foreach ($filterItems as $filterItem): ?>
+        <?php
+        $lnHelper = \Magento\Framework\App\ObjectManager::getInstance()->get('Mageplaza\LayeredNavigation\Helper\Data');
+        $isMultipleMode = $lnHelper->getGeneralConfig('allow_multiple');
+        $filter = $filterItem->getFilter();
+        $attributeModel = $filter->getData('attribute_model');
+        $inputName = $filter->getRequestVar();
+        $requestValue = $block->getRequest()->getParam($inputName);
+        $requestArray = $requestValue ? explode(',', $requestValue) : [];
+        $url = in_array($filterItem->getValue(), $requestArray) ? $filterItem->getRemoveUrl() : $filterItem->getUrl();
+        ?>
         <li class="item">
-            <?php if($filter->getFilterType() == \Mageplaza\LayeredNavigation\Helper\Data::FILTER_TYPE_RANGE): ?>
-                <div id="ln_slider_container_<?php echo $attributeCode ?>">
-                    <div id="ln_slider_<?php echo $attributeCode ?>"></div>
-                    <div id="ln_slider_text_<?php echo $attributeCode ?>"></div>
+            <?php if($filterItem->getFilterType() == 'slider'): ?>
+                <div id="ln_price_attribute">
+                    <div id="ln_price_slider"></div>
+                    <div id="ln_price_text"></div>
                 </div>
-            <?php elseif ($filterItem->getCount() > 0): ?>
-                <a href="<?php echo $block->escapeUrl($filter->getUrl($filterItem)) ?>">
-                    <input type="checkbox" <?php echo $filter->isSelected($filterItem) ? 'checked="checked"' : ''  ?> class="layer-input-filter" name="filter_<?php echo $attributeCode ?>"/>
-                    <?php echo $filterItem->getLabel() ?>
-                    <span class="count"><?php echo $filterItem->getCount()?><span class="filter-count-label"><?php echo ($filterItem->getCount() == 1) ? 'item' : 'items'; ?></span></span>
-                </a>
+                <script type="text/x-magento-init">
+                    {
+                        "#ln_price_attribute": {
+                            "Mageplaza_LayeredNavigation/js/price/slider": {
+                                "selectedFrom": <?php echo $filterItem->getFrom() ?>,
+                                "selectedTo": <?php echo $filterItem->getTo() ?>,
+                                "minValue": <?php echo $filterItem->getMin() ?>,
+                                "maxValue": <?php echo $filterItem->getMax() ?>,
+                                "priceFormat": <?php /* @escapeNotVerified */ echo $this->helper('Magento\Tax\Helper\Data')->getPriceFormat($block->getStore()); ?>,
+                                "ajaxUrl": <?php /* @escapeNotVerified */ echo $this->helper('Magento\Framework\Json\Helper\Data')->jsonEncode($filterItem->getUrl()) ?>
+                            }
+                        }
+                    }
+                </script>
+                <?php break; ?>
+            <?php else: ?>
+				<?php if ($filterItem->getCount() > 0): ?>
+                    <a href="<?php echo $block->escapeUrl($url) ?>">
+                        <?php if($attributeModel && $attributeModel->getFrontendInput() == 'multiselect' && $isMultipleMode): ?>
+                            <input type="checkbox" <?php echo in_array($filterItem->getValue(), $requestArray) ? 'checked="checked"' : ''  ?> />
+                        <?php endif; ?>
+						<?php /* @escapeNotVerified */ echo $filterItem->getLabel() ?>
+                        <?php if ($lnHelper->getDisplayConfig('show_counter')): ?>
+                            <span class="count"><?php /* @escapeNotVerified */ echo $filterItem->getCount()?><span class="filter-count-label">
+								<?php if ($filterItem->getCount() == 1):?> <?php /* @escapeNotVerified */ echo __('item')?><?php else:?> <?php /* @escapeNotVerified */ echo __('items') ?><?php endif;?></span></span>
+                        <?php endif; ?>
+					</a>
+                <?php else:?>
+                    <?php if($attributeModel && $attributeModel->getFrontendInput() == 'multiselect' && $isMultipleMode): ?>
+                        <input type="checkbox" disabled="disabled" />
+                    <?php endif; ?>
+                    <?php /* @escapeNotVerified */ echo $filterItem->getLabel() ?>
+                    <?php if ($lnHelper->getDisplayConfig('show_counter')): ?>
+                        <span class="count"><?php /* @escapeNotVerified */ echo $filterItem->getCount()?><span class="filter-count-label">
+							<?php if ($filterItem->getCount() == 1):?><?php /* @escapeNotVerified */ echo __('item')?><?php else:?><?php /* @escapeNotVerified */ echo __('items') ?><?php endif;?></span></span>
+                    <?php endif; ?>
+                <?php endif; ?>
             <?php endif; ?>
         </li>
     <?php endforeach ?>
diff --git a/view/frontend/templates/view.phtml b/view/frontend/templates/view.phtml
index c8ba213..76e95aa 100644
--- a/view/frontend/templates/view.phtml
+++ b/view/frontend/templates/view.phtml
@@ -20,48 +20,64 @@
  */
 ?>
 
+<?php $lnHelper = \Magento\Framework\App\ObjectManager::getInstance()->get('Mageplaza\LayeredNavigation\Helper\Data'); ?>
 <?php if ($block->canShowBlock()): ?>
-<div class="block filter" id="layered-filter-block-container">
-    <div class="block-content filter-content" id="layered-filter-block">
-        <?php echo $block->getChildHtml('state') ?>
+    <?php
+    $wrapOptions = false;
+    $activeKey = 0;
+    $activeItems = '';
+    $displayConfig = $lnHelper->getDisplayConfig();
+    ?>
 
-        <?php if ($block->getLayer()->getState()->getFilters()): ?>
-            <div class="block-actions filter-actions">
-                <a href="<?php echo $block->getClearUrl() ?>" class="action clear filter-clear"><span><?php echo __('Clear All') ?></span></a>
-            </div>
-        <?php endif; ?>
+    <div class="block filter" id="layered-filter-block">
+        <div class="block-content filter-content">
+            <?php echo $block->getChildHtml('state') ?>
 
-        <?php $wrapOptions = false; ?>
-        <?php foreach ($block->getFilters() as $key => $filter): ?>
-            <?php if ($filter->getItemsCount()): ?>
-                <?php if (!$wrapOptions): ?>
-                    <strong role="heading" aria-level="2" class="block-subtitle filter-subtitle"><?php echo __('Shopping Options') ?></strong>
-                    <div class="filter-options" id="narrow-by-list">
-                <?php  $wrapOptions = true; endif; ?>
-                <div data-role="ln_collapsible" class="filter-options-item ln-filter-options-item" attribute="<?php echo $filter->getRequestVar() ?>">
-                    <div data-role="ln_title" class="filter-options-title"><?php echo __($filter->getName()) ?></div>
-                    <div data-role="ln_content" class="filter-options-content">
-                        <?php echo $block->getChildHtml('layer_content_before') ?>
-                        <?php echo $block->getChildBlock('renderer')->setFilter($filter)->render($filter); ?>
-                    </div>
+            <?php if ($block->getLayer()->getState()->getFilters()): ?>
+                <div class="block-actions filter-actions">
+                    <a href="<?php /* @escapeNotVerified */ echo $block->getClearUrl() ?>" class="action clear filter-clear"><span><?php /* @escapeNotVerified */ echo __('Clear All') ?></span></a>
                 </div>
             <?php endif; ?>
-        <?php endforeach; ?>
-        <?php if ($wrapOptions): ?></div><?php endif; ?>
 
-        <?php echo $block->getChildHtml('layer_additional_info') ?>
-    </div>
-    <div id="ln_overlay" class="ln_overlay">
-        <div class="loader">
-            <img src="<?php echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
+            <?php foreach ($block->getFilters() as $key => $filter): ?>
+                <?php if ($filter->getItemsCount()): ?>
+                    <?php if (!$wrapOptions): ?>
+                        <strong role="heading" aria-level="2" class="block-subtitle filter-subtitle"><?php /* @escapeNotVerified */ echo __('Shopping Options') ?></strong>
+                        <div class="filter-options" id="narrow-by-list">
+                    <?php  $wrapOptions = true; endif; ?>
+                    <div data-role="ln_collapsible" class="filter-options-item">
+                        <div data-role="ln_title" class="filter-options-title"><?php /* @escapeNotVerified */ echo __($filter->getName()) ?></div>
+                        <div data-role="ln_content" class="filter-options-content"><?php /* @escapeNotVerified */ echo $block->getChildBlock('renderer')->render($filter); ?></div>
+                    </div>
+                    <?php $activeItems .= ($displayConfig['auto_open'] == \Mageplaza\LayeredNavigation\Model\Config\Source\ActiveFilter::SHOW_ALL ||
+                                        ($displayConfig['auto_open'] == \Mageplaza\LayeredNavigation\Model\Config\Source\ActiveFilter::SHOW_ACTIVE &&
+                                            $block->getRequest()->getParam($filter->getRequestVar(), false)))
+                                        ? ' ' . $activeKey : '';
+                        $activeKey++;
+                    ?>
+                <?php endif; ?>
+            <?php endforeach; ?>
+            <?php if ($wrapOptions): ?></div><?php endif; ?>
+        </div>
+        <div id="ln_overlay" class="ln_overlay">
+            <img src="<?php /* @escapeNotVerified */ echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
         </div>
     </div>
     <script type="text/x-magento-init">
         {
             "#layered-filter-block": {
-                "mpLayer": <?php echo $this->helper('Mageplaza\LayeredNavigation\Helper\Data')->getLayerConfiguration($block->getFilters()) ?>
+                "Mageplaza_LayeredNavigation/js/layer": {
+                    "openedState": "active",
+                    "collapsible": true,
+                    "active": "<?php echo $activeItems ?>",
+                    "multipleCollapsible": true,
+                    "animate": 200,
+                    "collapsibleElement": "[data-role=ln_collapsible]",
+                    "header": "[data-role=ln_title]",
+                    "content": "[data-role=ln_content]",
+                    "params": <?php echo $this->helper('Magento\Framework\Json\Helper\Data')->jsonEncode($block->getRequest()->getParams()) ?>
+                }
             }
         }
     </script>
-</div>
 <?php endif; ?>
diff --git a/view/frontend/web/css/source/_module.less b/view/frontend/web/css/source/_module.less
index c1ed66a..7c23900 100644
--- a/view/frontend/web/css/source/_module.less
+++ b/view/frontend/web/css/source/_module.less
@@ -35,9 +35,4 @@
     display: block;
     position: fixed;
   }
-}
-
-.ln_slider_container_price {
-  width: calc(100% - 20px);
-  margin: 0 15px 0 5px;
 }
\ No newline at end of file
diff --git a/view/frontend/web/js/action/submit-filter.js b/view/frontend/web/js/action/submit-filter.js
deleted file mode 100644
index 14cdc1e..0000000
--- a/view/frontend/web/js/action/submit-filter.js
+++ /dev/null
@@ -1,74 +0,0 @@
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license sliderConfig is
- * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-define(
-    [
-        'jquery',
-        'mage/storage',
-        'Mageplaza_LayeredNavigation/js/model/loader'
-    ],
-    function ($, storage, loader) {
-        'use strict';
-
-        return function (submitUrl) {
-            /** save active state */
-            var actives = [];
-            $('.ln-filter-options-item').each(function (index) {
-                if ($(this).hasClass('active')) {
-                    actives.push($(this).attr('attribute'));
-                }
-            });
-            window.layerActiveTabs = actives;
-
-            /** start loader */
-            loader.startLoader();
-
-            /** change browser url */
-            if (typeof window.history.pushState === 'function') {
-                window.history.pushState({url: submitUrl}, '', submitUrl);
-            }
-
-            return storage.post(submitUrl, {}).done(
-                function (response) {
-                    if (response.backUrl) {
-                        window.location = response.backUrl;
-                        return;
-                    }
-                    if (response.navigation) {
-                        $('#layered-filter-block-container').replaceWith(response.navigation);
-                        $('#layered-filter-block-container').trigger('contentUpdated');
-                    }
-                    if (response.products) {
-                        $('#layer-product-list').replaceWith(response.products);
-                        $('#layer-product-list').trigger('contentUpdated');
-                    }
-                }
-            ).fail(
-                function () {
-                    window.location.reload();
-                }
-            ).always(
-                function () {
-                    loader.stopLoader();
-                }
-            );
-        };
-    }
-);
diff --git a/view/frontend/web/js/layer.js b/view/frontend/web/js/layer.js
new file mode 100644
index 0000000..0ab6dfd
--- /dev/null
+++ b/view/frontend/web/js/layer.js
@@ -0,0 +1,165 @@
+/**
+ * Mageplaza
+ *
+ * NOTICE OF LICENSE
+ *
+ * This source file is subject to the Mageplaza.com license that is
+ * available through the world-wide-web at this URL:
+ * https://www.mageplaza.com/LICENSE.txt
+ *
+ * DISCLAIMER
+ *
+ * Do not edit or add to this file if you wish to upgrade this extension to newer
+ * version in the future.
+ *
+ * @category    Mageplaza
+ * @package     Mageplaza_LayeredNavigation
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+define([
+    'jquery',
+    'jquery/ui',
+    'accordion',
+    'productListToolbarForm'
+], function ($) {
+    "use strict";
+
+    $.widget('mageplaza.layer', $.mage.accordion, {
+
+        options: {
+            productsListSelector: '#layer-product-list',
+            navigationSelector: '#layered-filter-block'
+        },
+
+        _create: function () {
+            this._super();
+
+            this.initProductListUrl();
+            this.initObserve();
+            this.initLoading();
+        },
+
+        initProductListUrl: function () {
+            var self = this;
+            $.mage.productListToolbarForm.prototype.changeUrl = function (paramName, paramValue, defaultValue) {
+                var urlPaths = this.options.url.split('?'),
+                    baseUrl = urlPaths[0],
+                    urlParams = urlPaths[1] ? urlPaths[1].split('&') : [],
+                    paramData = {},
+                    parameters;
+                for (var i = 0; i < urlParams.length; i++) {
+                    parameters = urlParams[i].split('=');
+                    paramData[parameters[0]] = parameters[1] !== undefined
+                        ? window.decodeURIComponent(parameters[1].replace(/\+/g, '%20'))
+                        : '';
+                }
+                paramData[paramName] = paramValue;
+                if (paramValue == defaultValue) {
+                    delete paramData[paramName];
+                }
+                paramData = $.param(paramData);
+
+                self.ajaxSubmit(baseUrl + (paramData.length ? '?' + paramData : ''));
+            }
+        },
+
+        initObserve: function () {
+            var self = this;
+            var aElements = this.element.find('a');
+            aElements.each(function (index) {
+                var el = $(this);
+                var link = self.checkUrl(el.prop('href'));
+                if (!link) {
+                    return;
+                }
+
+                el.bind('click', function (e) {
+                    if (el.hasClass('swatch-option-link-layered')) {
+                        var childEl = el.find('.swatch-option');
+                        childEl.addClass('selected');
+                    } else {
+                        var checkboxEl = el.find('input[type=checkbox]');
+                        checkboxEl.prop('checked', !checkboxEl.prop('checked'));
+                    }
+
+                    self.ajaxSubmit(link);
+                    e.stopPropagation();
+                    e.preventDefault();
+                });
+
+                var checkbox = el.find('input[type=checkbox]');
+                checkbox.bind('click', function (e) {
+                    self.ajaxSubmit(link);
+                    e.stopPropagation();
+                });
+            });
+
+            var swatchElements = this.element.find('.swatch-attribute');
+            swatchElements.each(function (index) {
+                var el = $(this);
+                var attCode = el.attr('attribute-code');
+                if (attCode) {
+                    if (self.options.params.hasOwnProperty(attCode)) {
+                        var attValues = self.options.params[attCode].split(",");
+                        var swatchOptions = el.find('.swatch-option');
+                        swatchOptions.each(function (option) {
+                            var elOption = $(this);
+                            if ($.inArray(elOption.attr('option-id'), attValues) !== -1) {
+                                elOption.addClass('selected');
+                            }
+                        });
+                    }
+                }
+            });
+        },
+
+        checkUrl: function (url) {
+            var regex = /(http|https):\/\/(\w+:{0,1}\w*)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%!\-\/]))?/;
+
+            return regex.test(url) ? url : null;
+        },
+
+        initLoading: function () {
+
+        },
+
+        ajaxSubmit: function (submitUrl) {
+            var self = this;
+
+            $.ajax({
+                url: submitUrl,
+                data: {isAjax: 1},
+                type: 'post',
+                dataType: 'json',
+                beforeSend: function () {
+                    $('.ln_overlay').show();
+                    if (typeof window.history.pushState === 'function') {
+                        window.history.pushState({url: submitUrl}, '', submitUrl);
+                    }
+                },
+                success: function (res) {
+                    if (res.backUrl) {
+                        window.location = res.backUrl;
+                        return;
+                    }
+                    if (res.navigation) {
+                        $(self.options.navigationSelector).replaceWith(res.navigation);
+                        $(self.options.navigationSelector).trigger('contentUpdated');
+                    }
+                    if (res.products) {
+                        $(self.options.productsListSelector).replaceWith(res.products);
+                        $(self.options.productsListSelector).trigger('contentUpdated');
+                    }
+                    $('.ln_overlay').hide();
+                },
+                error: function () {
+                    window.location.reload();
+                }
+            });
+        }
+    });
+
+    return $.mageplaza.layer;
+});
diff --git a/view/frontend/web/js/model/loader.js b/view/frontend/web/js/model/loader.js
deleted file mode 100644
index 4160e40..0000000
--- a/view/frontend/web/js/model/loader.js
+++ /dev/null
@@ -1,44 +0,0 @@
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license sliderConfig is
- * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-define(
-    [
-        'jquery'
-    ],
-    function ($) {
-        'use strict';
-
-        return {
-            /**
-             * Start full page loader action
-             */
-            startLoader: function () {
-                $('#ln_overlay').show();
-            },
-
-            /**
-             * Stop full page loader action
-             */
-            stopLoader: function () {
-                $('#ln_overlay').hide();
-            }
-        };
-    }
-);
diff --git a/view/frontend/web/js/price/slider.js b/view/frontend/web/js/price/slider.js
new file mode 100644
index 0000000..31073ba
--- /dev/null
+++ b/view/frontend/web/js/price/slider.js
@@ -0,0 +1,64 @@
+/**
+ * Mageplaza
+ *
+ * NOTICE OF LICENSE
+ *
+ * This source file is subject to the Mageplaza.com license that is
+ * available through the world-wide-web at this URL:
+ * https://www.mageplaza.com/LICENSE.txt
+ *
+ * DISCLAIMER
+ *
+ * Do not edit or add to this file if you wish to upgrade this extension to newer
+ * version in the future.
+ *
+ * @category    Mageplaza
+ * @package     Mageplaza_LayeredNavigation
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
+ * @license     https://www.mageplaza.com/LICENSE.txt
+ */
+
+define([
+    'jquery',
+    'Magento_Catalog/js/price-utils',
+    'jquery/ui',
+    'Mageplaza_LayeredNavigation/js/layer'
+], function ($, ultil) {
+    "use strict";
+
+    $.widget('mageplaza.layerSlider', $.mageplaza.layer, {
+        options: {
+            sliderElement: '#ln_price_slider',
+            textElement: '#ln_price_text'
+        },
+        _create: function () {
+            var self = this;
+            $(this.options.sliderElement).slider({
+                min: self.options.minValue,
+                max: self.options.maxValue,
+                values: [self.options.selectedFrom, self.options.selectedTo],
+                slide: function ( event, ui ) {
+                    self.displayText(ui.values[0], ui.values[1]);
+                },
+                change: function (event, ui) {
+                    self.ajaxSubmit(self.getUrl(ui.values[0], ui.values[1]));
+                }
+            });
+            this.displayText(this.options.selectedFrom, this.options.selectedTo);
+        },
+
+        getUrl: function (from, to) {
+            return this.options.ajaxUrl.replace(encodeURI('{price_start}'), from).replace(encodeURI('{price_end}'), to);
+        },
+
+        displayText: function (from, to) {
+            $(this.options.textElement).html(this.formatPrice(from) + ' - ' + this.formatPrice(to));
+        },
+
+        formatPrice: function (value) {
+            return ultil.formatPrice(value, this.options.priceFormat);
+        }
+    });
+
+    return $.mageplaza.layerSlider;
+});
diff --git a/view/frontend/web/js/view/layer.js b/view/frontend/web/js/view/layer.js
deleted file mode 100644
index 3076418..0000000
--- a/view/frontend/web/js/view/layer.js
+++ /dev/null
@@ -1,234 +0,0 @@
-/**
- * Mageplaza
- *
- * NOTICE OF LICENSE
- *
- * This source file is subject to the Mageplaza.com license sliderConfig is
- * available through the world-wide-web at this URL:
- * https://www.mageplaza.com/LICENSE.txt
- *
- * DISCLAIMER
- *
- * Do not edit or add to this file if you wish to upgrade this extension to newer
- * version in the future.
- *
- * @category    Mageplaza
- * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-define([
-    'jquery',
-    'Mageplaza_LayeredNavigation/js/action/submit-filter',
-    'Magento_Catalog/js/price-utils',
-    'jquery/ui',
-    'accordion',
-    'productListToolbarForm'
-], function ($, submitFilterAction, ultil) {
-    "use strict";
-
-    $.widget('mageplaza.layer', $.mage.accordion, {
-        options: {
-            openedState: 'active',
-            collapsible: true,
-            multipleCollapsible: true,
-            animate: 200,
-            collapsibleElement: '[data-role=ln_collapsible]',
-            header: '[data-role=ln_title]',
-            content: '[data-role=ln_content]',
-            params: [],
-            active: [],
-            checkboxEl: 'input[type=checkbox]',
-            sliderElementPrefix: '#ln_slider_',
-            sliderTextElementPrefix: '#ln_slider_text_'
-        },
-
-        _create: function () {
-            this.initActiveItems();
-
-            this._super();
-
-            this.initProductListUrl();
-            this.initObserve();
-            this.initSlider();
-        },
-
-        initActiveItems: function () {
-            var layerActives = this.options.active,
-                actives = [];
-
-            if (typeof window.layerActiveTabs !== 'undefined') {
-                layerActives = window.layerActiveTabs;
-            }
-            if (layerActives.length) {
-                $('.ln-filter-options-item').each(function (index) {
-                    if (~$.inArray($(this).attr('attribute'), layerActives)) {
-                        actives.push(index);
-                    }
-                });
-            }
-
-            this.options.active = actives;
-
-            return this;
-        },
-
-        initProductListUrl: function () {
-            var isProcessToolbar = false;
-            $.mage.productListToolbarForm.prototype.changeUrl = function (paramName, paramValue, defaultValue) {
-                if (isProcessToolbar) {
-                    return;
-                }
-                isProcessToolbar = true;
-
-                var urlPaths = this.options.url.split('?'),
-                    baseUrl = urlPaths[0],
-                    urlParams = urlPaths[1] ? urlPaths[1].split('&') : [],
-                    paramData = {},
-                    parameters;
-                for (var i = 0; i < urlParams.length; i++) {
-                    parameters = urlParams[i].split('=');
-                    paramData[parameters[0]] = parameters[1] !== undefined
-                        ? window.decodeURIComponent(parameters[1].replace(/\+/g, '%20'))
-                        : '';
-                }
-                paramData[paramName] = paramValue;
-                if (paramValue == defaultValue) {
-                    delete paramData[paramName];
-                }
-                paramData = $.param(paramData);
-                submitFilterAction(baseUrl + (paramData.length ? '?' + paramData : ''));
-            }
-        },
-
-        initObserve: function () {
-            var self = this;
-
-            var currentElements = this.element.find('.filter-current a, .filter-actions a');
-            currentElements.each(function(index){
-                var el = $(this),
-                    link = self.checkUrl(el.prop('href'));
-                if (!link) {
-                    return;
-                }
-
-                el.bind('click', function (e) {
-                    submitFilterAction(link);
-                    e.stopPropagation();
-                    e.preventDefault();
-                });
-            });
-
-            var optionElements = this.element.find('.filter-options a');
-            optionElements.each(function (index) {
-                var el = $(this),
-                    link = self.checkUrl(el.prop('href'));
-                if (!link) {
-                    return;
-                }
-
-                el.bind('click', function (e) {
-                    if (el.hasClass('swatch-option-link-layered')) {
-                        var childEl = el.find('.swatch-option');
-                        if(childEl.hasClass('selected')){
-                            childEl.removeClass('selected');
-                        } else {
-                            childEl.addClass('selected');
-                        }
-                    } else {
-                        var checkboxEl = el.find(self.options.checkboxEl);
-                        checkboxEl.prop('checked', !checkboxEl.prop('checked'));
-                    }
-
-                    self.ajaxSubmit(link);
-                    e.stopPropagation();
-                    e.preventDefault();
-                });
-
-                var checkbox = el.find(self.options.checkboxEl);
-                checkbox.bind('click', function (e) {
-                    self.ajaxSubmit(link);
-                    e.stopPropagation();
-                });
-            });
-
-            var swatchElements = this.element.find('.swatch-attribute');
-            swatchElements.each(function (index) {
-                var el = $(this);
-                var attCode = el.attr('attribute-code');
-                if (attCode) {
-                    if (self.options.params.hasOwnProperty(attCode)) {
-                        var attValues = self.options.params[attCode].split(",");
-                        var swatchOptions = el.find('.swatch-option');
-                        swatchOptions.each(function (option) {
-                            var elOption = $(this);
-                            if ($.inArray(elOption.attr('option-id'), attValues) !== -1) {
-                                elOption.addClass('selected');
-                            }
-                        });
-                    }
-                }
-            });
-        },
-
-        initSlider: function () {
-            var self = this,
-                slider = this.options.slider;
-
-            for (var code in slider) {
-                if (slider.hasOwnProperty(code)) {
-                    var sliderConfig = slider[code],
-                        sliderElement = $(this.options.sliderElementPrefix + code),
-                        priceFormat = sliderConfig.hasOwnProperty('priceFormat') ? JSON.parse(sliderConfig.priceFormat) : null;
-
-                    if (sliderElement.length) {
-                        sliderElement.slider({
-                            min: sliderConfig.minValue,
-                            max: sliderConfig.maxValue,
-                            values: [sliderConfig.selectedFrom, sliderConfig.selectedTo],
-                            slide: function (event, ui) {
-                                self.displaySliderText(code, ui.values[0], ui.values[1], priceFormat);
-                            },
-                            change: function (event, ui) {
-                                var url = sliderConfig.ajaxUrl.replace(encodeURI('{start}'), ui.values[0])
-                                    .replace(encodeURI('{end}'), ui.values[1]);
-
-                                self.ajaxSubmit(url);
-                            }
-                        });
-                        self.displaySliderText(code, sliderConfig.selectedFrom, sliderConfig.selectedTo, priceFormat);
-                    }
-                }
-            }
-        },
-
-        displaySliderText: function (code, from, to, format) {
-            var textElement = $(this.options.sliderTextElementPrefix + code);
-            if (textElement.length) {
-                if (typeof format !== null) {
-                    from = this.formatPrice(from, format);
-                    to = this.formatPrice(to, format);
-                }
-
-                textElement.html(from + ' - ' + to);
-            }
-        },
-
-        formatPrice: function (value, format) {
-            return ultil.formatPrice(value, format);
-        },
-
-        ajaxSubmit: function (submitUrl) {
-            return submitFilterAction(submitUrl);
-        },
-
-        checkUrl: function (url) {
-            var regex = /(http|https):\/\/(\w+:{0,1}\w*)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%!\-\/]))?/;
-
-            return regex.test(url) ? url : null;
-        }
-    });
-
-    return $.mageplaza.layer;
-});
