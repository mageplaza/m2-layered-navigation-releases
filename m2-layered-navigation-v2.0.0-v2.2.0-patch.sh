diff --git a/Plugin/Block/Swatches/RenderLayered.php b/Block/Plugin/Swatches/RenderLayered.php
similarity index 60%
rename from Plugin/Block/Swatches/RenderLayered.php
rename to Block/Plugin/Swatches/RenderLayered.php
index 8bbcc7c..2324eb1 100644
--- a/Plugin/Block/Swatches/RenderLayered.php
+++ b/Block/Plugin/Swatches/RenderLayered.php
@@ -15,11 +15,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
-namespace Mageplaza\LayeredNavigation\Plugin\Block\Swatches;
+namespace Mageplaza\LayeredNavigation\Block\Plugin\Swatches;
 
 /**
  * Class RenderLayered
@@ -27,50 +26,49 @@ namespace Mageplaza\LayeredNavigation\Plugin\Block\Swatches;
  */
 class RenderLayered
 {
-	/** @var \Magento\Framework\UrlInterface */
+	/**
+	 * @var \Magento\Framework\UrlInterface
+	 */
 	protected $_url;
 
-	/** @var \Magento\Theme\Block\Html\Pager */
+	/**
+	 * @var \Magento\Theme\Block\Html\Pager
+	 */
 	protected $_htmlPagerBlock;
 
-	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
-	protected $_moduleHelper;
+	/**
+	 * @var \Magento\Framework\App\RequestInterface
+	 */
+	protected $_request;
 
-	/** @type \Magento\Catalog\Model\Layer\Filter\AbstractFilter */
-	protected $filter;
+	/**
+	 * @var \Mageplaza\LayeredNavigation\Helper\Data
+	 */
+	protected $_moduleHelper;
 
 	/**
 	 * RenderLayered constructor.
 	 *
 	 * @param \Magento\Framework\UrlInterface $url
 	 * @param \Magento\Theme\Block\Html\Pager $htmlPagerBlock
+	 * @param \Magento\Framework\App\RequestInterface $request
 	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
 	 */
 	public function __construct(
 		\Magento\Framework\UrlInterface $url,
 		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
+		\Magento\Framework\App\RequestInterface $request,
 		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
 	)
 	{
 		$this->_url            = $url;
 		$this->_htmlPagerBlock = $htmlPagerBlock;
+		$this->_request        = $request;
 		$this->_moduleHelper   = $moduleHelper;
 	}
 
 	/**
 	 * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-	 * @return array
-	 */
-	public function beforeSetSwatchFilter(\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject, \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter)
-	{
-		$this->filter = $filter;
-
-		return [$filter];
-	}
-
-	/**
-	 * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
 	 * @param $proceed
 	 * @param $attributeCode
 	 * @param $optionId
@@ -88,23 +86,20 @@ class RenderLayered
 			return $proceed($attributeCode, $optionId);
 		}
 
-		$attHelper = $this->_moduleHelper->getFilterModel();
-		if ($attHelper->isMultiple($this->filter)) {
-			$value = $attHelper->getFilterValue($this->filter);
-
-			if (!in_array($optionId, $value)) {
-				$value[] = $optionId;
-			} else {
-				$key = array_search($optionId, $value);
-				if ($key !== false) {
-					unset($value[$key]);
-				}
-			}
+		$value = [];
+		if ($requestValue = $this->_request->getParam($attributeCode)) {
+			$value = explode(',', $requestValue);
+		}
+		if (!in_array($optionId, $value)) {
+			$value[] = $optionId;
 		} else {
-			$value = [$optionId];
+			$key = array_search($optionId, $value);
+			if ($key !== false) {
+				unset($value[$key]);
+			}
 		}
 
-		$query = !empty($value) ? [$attributeCode => implode(',', $value)] : '';
+		$query = [$attributeCode => implode(',', $value)];
 
 		return $this->_url->getUrl(
 			'*/*/*',
diff --git a/Controller/Plugin/Category/View.php b/Controller/Plugin/Category/View.php
new file mode 100644
index 0000000..dc82a5a
--- /dev/null
+++ b/Controller/Plugin/Category/View.php
@@ -0,0 +1,63 @@
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
+namespace Mageplaza\LayeredNavigation\Controller\Plugin\Category;
+
+/**
+ * Class View
+ * @package Mageplaza\LayeredNavigation\Controller\Plugin\Category
+ */
+class View
+{
+    protected $_jsonHelper;
+    protected $_moduleHelper;
+
+    /**
+     * View constructor.
+     *
+     * @param \Magento\Framework\Json\Helper\Data      $jsonHelper
+     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+     */
+    public function __construct(
+        \Magento\Framework\Json\Helper\Data $jsonHelper,
+        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+    ) {
+        $this->_jsonHelper = $jsonHelper;
+        $this->_moduleHelper = $moduleHelper;
+    }
+
+    /**
+     * @param \Magento\Catalog\Controller\Category\View $action
+     * @param                                           $page
+     *
+     * @return mixed
+     */
+    public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
+    {
+        if ($this->_moduleHelper->isEnabled() && $action->getRequest()->isAjax()) {
+            $navigation = $page->getLayout()->getBlock('catalog.leftnav');
+            $products = $page->getLayout()->getBlock('category.products');
+            $result = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
+            $action->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
+        } else {
+            return $page;
+        }
+    }
+}
diff --git a/Controller/Search/Result/Index.php b/Controller/Search/Result/Index.php
deleted file mode 100644
index 689b401..0000000
--- a/Controller/Search/Result/Index.php
+++ /dev/null
@@ -1,142 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\LayeredNavigation\Controller\Search\Result;
-
-use Magento\Catalog\Model\Layer\Resolver;
-use Magento\Catalog\Model\Session;
-use Magento\Framework\App\Action\Context;
-use Magento\Search\Model\QueryFactory;
-use Magento\Store\Model\StoreManagerInterface;
-
-/**
- * Class Index
- * @package Mageplaza\LayeredNavigation\Controller\Search\Result
- */
-class Index extends \Magento\Framework\App\Action\Action
-{
-	/**
-	 * Catalog session
-	 *
-	 * @var Session
-	 */
-	protected $_catalogSession;
-
-	/**
-	 * @var StoreManagerInterface
-	 */
-	protected $_storeManager;
-	/**
-	 * @type \Magento\Framework\Json\Helper\Data
-	 */
-	protected $_jsonHelper;
-	/**
-	 * @type \Mageplaza\LayeredNavigation\Helper\Data
-	 */
-	protected $_moduleHelper;
-	/**
-	 * @type \Magento\CatalogSearch\Helper\Data
-	 */
-	protected $_helper;
-	/**
-	 * @var QueryFactory
-	 */
-	private $_queryFactory;
-	/**
-	 * Catalog Layer Resolver
-	 *
-	 * @var Resolver
-	 */
-	private $layerResolver;
-
-	/**
-	 * @param \Magento\Framework\App\Action\Context $context
-	 * @param \Magento\Catalog\Model\Session $catalogSession
-	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-	 * @param \Magento\Search\Model\QueryFactory $queryFactory
-	 * @param \Magento\Catalog\Model\Layer\Resolver $layerResolver
-	 * @param \Magento\CatalogSearch\Helper\Data $helper
-	 * @param \Magento\Framework\Json\Helper\Data $jsonHelper
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	 */
-	public function __construct(
-		Context $context,
-		Session $catalogSession,
-		StoreManagerInterface $storeManager,
-		QueryFactory $queryFactory,
-		Resolver $layerResolver,
-		\Magento\CatalogSearch\Helper\Data $helper,
-		\Magento\Framework\Json\Helper\Data $jsonHelper,
-		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	)
-	{
-		parent::__construct($context);
-		$this->_storeManager   = $storeManager;
-		$this->_catalogSession = $catalogSession;
-		$this->_queryFactory   = $queryFactory;
-		$this->layerResolver   = $layerResolver;
-		$this->_jsonHelper     = $jsonHelper;
-		$this->_moduleHelper   = $moduleHelper;
-		$this->_helper         = $helper;
-	}
-
-	/**
-	 * Display search result
-	 *
-	 * @return void
-	 */
-	public function execute()
-	{
-		$this->layerResolver->create(Resolver::CATALOG_LAYER_SEARCH);
-		/* @var $query \Magento\Search\Model\Query */
-		$query = $this->_queryFactory->get();
-
-		$query->setStoreId($this->_storeManager->getStore()->getId());
-
-		if ($query->getQueryText() != '') {
-			if ($this->_helper->isMinQueryLength()) {
-				$query->setId(0)->setIsActive(1)->setIsProcessed(1);
-			} else {
-				$query->saveIncrementalPopularity();
-
-				if ($query->getRedirect()) {
-					$this->getResponse()->setRedirect($query->getRedirect());
-
-					return;
-				}
-			}
-
-			$this->_helper->checkNotes();
-
-			if ($this->_moduleHelper->isEnabled() && $this->getRequest()->isAjax()) {
-				$navigation = $this->_view->getLayout()->getBlock('catalogsearch.leftnav');
-				$products   = $this->_view->getLayout()->getBlock('search.result');
-				$result     = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
-				$this->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
-			} else {
-				$this->_view->loadLayout();
-				$this->_view->renderLayout();
-			}
-		} else {
-			$this->getResponse()->setRedirect($this->_redirect->getRedirectUrl());
-		}
-	}
-}
diff --git a/Helper/Data.php b/Helper/Data.php
index 00d62cb..f110b9a 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Helper;
 
 use Mageplaza\Core\Helper\AbstractData;
@@ -29,11 +28,9 @@ use Mageplaza\Core\Helper\AbstractData;
  */
 class Data extends AbstractData
 {
-	const FILTER_TYPE_SLIDER = 'slider';
-	const FILTER_TYPE_LIST = 'list';
 
-	/** @var \Mageplaza\LayeredNavigation\Model\Layer\Filter */
-	protected $filterModel;
+	const FILTER_TYPE_RANGE = 'range';
+	const FILTER_TYPE_LIST = 'list';
 
 	/**
 	 * @param null $storeId
@@ -42,7 +39,7 @@ class Data extends AbstractData
 	 */
 	public function isEnabled($storeId = null)
 	{
-		return $this->getGeneralConfig('enable', $storeId) && $this->isModuleOutputEnabled();
+		return $this->getConfigValue('layered_navigation/general/enable', $storeId) && $this->isModuleOutputEnabled();
 	}
 
 	/**
@@ -58,6 +55,8 @@ class Data extends AbstractData
 	}
 
 	/**
+	 * Layered configuration for js widget
+	 *
 	 * @param $filters
 	 * @return mixed
 	 */
@@ -69,28 +68,19 @@ class Data extends AbstractData
 			'params' => $filterParams
 		]);
 
-		$this->getFilterModel()->getLayerConfiguration($filters, $config);
-
-		return $this->objectManager->get('Magento\Framework\Json\EncoderInterface')->encode($config->getData());
-	}
-
-	/**
-	 * @return \Mageplaza\LayeredNavigation\Model\Layer\Filter
-	 */
-	public function getFilterModel()
-	{
-		if (!$this->filterModel) {
-			$this->filterModel = $this->objectManager->create('Mageplaza\LayeredNavigation\Model\Layer\Filter');
+		$slider = [];
+		foreach ($filters as $filter) {
+			if ($filter->getFilterType() == self::FILTER_TYPE_RANGE) {
+				$slider[$filter->getRequestVar()] = $filter->getFilterSliderConfig();
+			}
 		}
+		$config->setData('slider', $slider);
 
-		return $this->filterModel;
-	}
+		$this->_eventManager->dispatch('layer_navigation_get_filter_configuration', [
+			'config'  => $config,
+			'filters' => $filters
+		]);
 
-	/**
-	 * @return \Magento\Framework\ObjectManagerInterface
-	 */
-	public function getObjectManager()
-	{
-		return $this->objectManager;
+		return $this->objectManager->get('Magento\Framework\Json\EncoderInterface')->encode($config->getData());
 	}
 }
diff --git a/Model/Layer/Filter.php b/Model/Layer/Filter.php
deleted file mode 100644
index 93e95ee..0000000
--- a/Model/Layer/Filter.php
+++ /dev/null
@@ -1,191 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\LayeredNavigation\Model\Layer;
-
-use Magento\Framework\App\RequestInterface;
-use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
-
-/**
- * Class Filter
- * @package Mageplaza\LayeredNavigation\Model\Layer
- */
-class Filter
-{
-	/** @var \Magento\Framework\App\RequestInterface */
-	protected $request;
-
-	/** @var array Slider types */
-	protected $sliderTypes = [LayerHelper::FILTER_TYPE_SLIDER];
-
-	/**
-	 * Filter constructor.
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 */
-	public function __construct(RequestInterface $request)
-	{
-		$this->request = $request;
-	}
-
-	/**
-	 * Layered configuration for js widget
-	 *
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filters
-	 * @param $config
-	 * @return mixed
-	 */
-	public function getLayerConfiguration($filters, $config)
-	{
-		$slider = [];
-		foreach ($filters as $filter) {
-			if ($this->getIsSliderTypes($filter) && $filter->getItemsCount()) {
-				$slider[$filter->getRequestVar()] = $filter->getSliderConfig();
-			}
-		}
-		$config->setData('slider', $slider);
-
-		return $this;
-	}
-
-	/**
-	 * @param $filter
-	 * @param null $types
-	 * @return bool
-	 */
-	public function getIsSliderTypes($filter, $types = null)
-	{
-		$filterType = $this->getFilterType($filter);
-		$types      = $types ?: $this->sliderTypes;
-
-		return in_array($filterType, $types);
-	}
-
-	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-	 * @param null $compareType
-	 * @return bool|string
-	 */
-	public function getFilterType($filter, $compareType = null)
-	{
-		$type = LayerHelper::FILTER_TYPE_LIST;
-		if ($filter->getRequestVar() == 'price') {
-			$type = LayerHelper::FILTER_TYPE_SLIDER;
-		}
-
-		return $compareType ? ($type == $compareType) : $type;
-	}
-
-	/**
-	 * Get option url. If it has been filtered, return removed url. Else return filter url
-	 *
-	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-	 * @return mixed
-	 */
-	public function getItemUrl($item)
-	{
-		if ($this->isSelected($item)) {
-			return $item->getRemoveUrl();
-		}
-
-		return $item->getUrl();
-	}
-
-	/**
-	 * Check if option is selected or not
-	 *
-	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-	 * @return bool
-	 */
-	public function isSelected($item)
-	{
-		$filterValue = $this->getFilterValue($item->getFilter());
-		if (!empty($filterValue) && in_array($item->getValue(), $filterValue)) {
-			return true;
-		}
-
-		return false;
-	}
-
-	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-	 * @param bool|true $explode
-	 * @return array|mixed
-	 */
-	public function getFilterValue($filter, $explode = true)
-	{
-		$filterValue = $this->request->getParam($filter->getRequestVar());
-		if (empty($filterValue)) {
-			return [];
-		}
-
-		return $explode ? explode(',', $filterValue) : $filterValue;
-	}
-
-	/**
-	 * Allow to show counter after options
-	 *
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-	 * @return bool
-	 */
-	public function isShowCounter($filter)
-	{
-		return true;
-	}
-
-	/**
-	 * Allow multiple filter
-	 *
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-	 * @return bool
-	 */
-	public function isMultiple($filter)
-	{
-		return true;
-	}
-
-	/**
-	 * Checks whether the option reduces the number of results
-	 *
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-	 * @param int $optionCount Count of search results with this option
-	 * @param int $totalSize Current search results count
-	 * @return bool
-	 */
-	public function isOptionReducesResults($filter, $optionCount, $totalSize)
-	{
-		$result = $optionCount <= $totalSize;
-
-		if ($this->isShowZero($filter)) {
-			return $result;
-		}
-
-		return $optionCount && $result;
-	}
-
-	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-	 * @return bool
-	 */
-	public function isShowZero($filter)
-	{
-		return false;
-	}
-}
\ No newline at end of file
diff --git a/Model/Layer/Filter/Attribute.php b/Model/Layer/Filter/Attribute.php
index 15293f3..f02376d 100644
--- a/Model/Layer/Filter/Attribute.php
+++ b/Model/Layer/Filter/Attribute.php
@@ -15,10 +15,9 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Attribute as AbstractFilter;
@@ -28,16 +27,24 @@ use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
  * Class Attribute
  * @package Mageplaza\LayeredNavigation\Model\Layer\Filter
  */
-class Attribute extends AbstractFilter
+class Attribute extends AbstractFilter implements FilterInterface
 {
-	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
-	protected $_moduleHelper;
+	/**
+	 * @var \Magento\Framework\Filter\StripTags
+	 */
+	private $tagFilter;
 
-	/** @var bool Is Filterable Flag */
-	protected $_isFilter = true;
+	/**
+	 * filterable value
+	 *
+	 * @type array
+	 */
+	protected $filterValue;
 
-	/** @var \Magento\Framework\Filter\StripTags */
-	private $tagFilter;
+	/**
+	 * @type \Mageplaza\LayeredNavigation\Helper\Data
+	 */
+	protected $_moduleHelper;
 
 	/**
 	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
@@ -68,10 +75,15 @@ class Attribute extends AbstractFilter
 		);
 		$this->tagFilter     = $tagFilter;
 		$this->_moduleHelper = $moduleHelper;
+		$this->filterValue   = [];
 	}
 
 	/**
-	 * @inheritdoc
+	 * Apply attribute option filter to product collection
+	 *
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 * @return $this
+	 * @throws \Magento\Framework\Exception\LocalizedException
 	 */
 	public function apply(\Magento\Framework\App\RequestInterface $request)
 	{
@@ -81,12 +93,11 @@ class Attribute extends AbstractFilter
 
 		$attributeValue = $request->getParam($this->_requestVar);
 		if (empty($attributeValue)) {
-			$this->_isFilter = false;
-
 			return $this;
 		}
 
-		$attributeValue = explode(',', $attributeValue);
+		$attributeValue    = explode(',', $attributeValue);
+		$this->filterValue = $attributeValue;
 
 		$attribute = $this->getAttributeModel();
 		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
@@ -108,7 +119,10 @@ class Attribute extends AbstractFilter
 	}
 
 	/**
-	 * @inheritdoc
+	 * Get data array for building attribute filter items
+	 *
+	 * @return array
+	 * @throws \Magento\Framework\Exception\LocalizedException
 	 */
 	protected function _getItemsData()
 	{
@@ -119,14 +133,17 @@ class Attribute extends AbstractFilter
 		$attribute = $this->getAttributeModel();
 
 		/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
-		$productCollection = $this->getLayer()->getProductCollection();
+		$productCollection = $this->getLayer()
+			->getProductCollection();
 
-		if ($this->_isFilter) {
-			$productCollection = $productCollection->getCollectionClone()
-				->removeAttributeSearch($attribute->getAttributeCode());
+		if (!empty($this->filterValue)) {
+			$productCollectionClone = $productCollection->getCollectionClone();
+			$collection             = $productCollectionClone->removeAttributeSearch($attribute->getAttributeCode());
+		} else {
+			$collection = $productCollection;
 		}
 
-		$optionsFacetedData = $productCollection->getFacetedData($attribute->getAttributeCode());
+		$optionsFacetedData = $collection->getFacetedData($attribute->getAttributeCode());
 
 		if (count($optionsFacetedData) === 0
 			&& $this->getAttributeIsFilterable($attribute) !== static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
@@ -134,7 +151,7 @@ class Attribute extends AbstractFilter
 			return $this->itemDataBuilder->build();
 		}
 
-		$productSize = $productCollection->getSize();
+		$productSize = $collection->getSize();
 
 		$itemData   = [];
 		$checkCount = false;
@@ -153,8 +170,8 @@ class Attribute extends AbstractFilter
 				: 0;
 
 			// Check filter type
-			if ($this->getAttributeIsFilterable($attribute) == static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
-				&& (!$this->_moduleHelper->getFilterModel()->isOptionReducesResults($this, $count, $productSize))
+			if ($this->getAttributeIsFilterable($attribute) === static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
+				&& (!$this->isOptionReducesResults($count, $productSize) || ($count == 0 && !$this->isShowZero()))
 			) {
 				continue;
 			}
@@ -178,4 +195,72 @@ class Attribute extends AbstractFilter
 
 		return $this->itemDataBuilder->build();
 	}
+
+	/**
+	 * @return string
+	 */
+	public function getFilterType()
+	{
+		return LayerHelper::FILTER_TYPE_LIST;
+	}
+
+	/**
+	 * Get option url. If it has been filtered, return removed url. Else return filter url
+	 *
+	 * @param $item
+	 * @return mixed
+	 */
+	public function getUrl($item)
+	{
+		if ($this->isSelected($item)) {
+			return $item->getRemoveUrl();
+		}
+
+		return $item->getUrl();
+	}
+
+	/**
+	 * Check it option is selected or not
+	 *
+	 * @param $item
+	 * @return bool
+	 */
+	public function isSelected($item)
+	{
+		if (!empty($this->filterValue) && in_array($item->getValue(), $this->filterValue)) {
+			return true;
+		}
+
+		return false;
+	}
+
+	/**
+	 * Allow to show zero options
+	 *
+	 * @return bool
+	 */
+	public function isShowZero()
+	{
+		return false;
+	}
+
+	/**
+	 * Allow to show counter after options
+	 *
+	 * @return bool
+	 */
+	public function isShowCounter()
+	{
+		return true;
+	}
+
+	/**
+	 * Allow multiple filter
+	 *
+	 * @return bool
+	 */
+	public function isMultiple()
+	{
+		return true;
+	}
 }
diff --git a/Model/Layer/Filter/Category.php b/Model/Layer/Filter/Category.php
index 27bc69a..01f9a8d 100644
--- a/Model/Layer/Filter/Category.php
+++ b/Model/Layer/Filter/Category.php
@@ -15,145 +15,107 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Category as AbstractFilter;
 use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
 
 /**
- * Class Category
- * @package Mageplaza\LayeredNavigation\Model\Layer\Filter
+ * Layer category filter
  */
-class Category extends AbstractFilter
+class Category extends AbstractFilter implements FilterInterface
 {
-	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
-	protected $_moduleHelper;
-
-	/** @var bool Is Filterable Flag */
-	protected $_isFilter = false;
-
-	/** @var \Magento\Framework\Escaper */
-	private $escaper;
-
-	/** @var  \Magento\Catalog\Model\Layer\Filter\DataProvider\Category */
-	private $dataProvider;
-
 	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-	 * @param \Magento\Catalog\Model\Layer $layer
-	 * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-	 * @param \Magento\Framework\Escaper $escaper
-	 * @param \Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	 * @param array $data
+	 * @type array
 	 */
-	public function __construct(
-		\Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-		\Magento\Store\Model\StoreManagerInterface $storeManager,
-		\Magento\Catalog\Model\Layer $layer,
-		\Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-		\Magento\Framework\Escaper $escaper,
-		\Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory,
-		LayerHelper $moduleHelper,
-		array $data = []
-	)
-	{
-		parent::__construct(
-			$filterItemFactory,
-			$storeManager,
-			$layer,
-			$itemDataBuilder,
-			$escaper,
-			$categoryDataProviderFactory,
-			$data
-		);
-
-		$this->escaper       = $escaper;
-		$this->_moduleHelper = $moduleHelper;
-		$this->dataProvider  = $categoryDataProviderFactory->create(['layer' => $this->getLayer()]);
-	}
+	protected $filterValue = [];
 
 	/**
-	 * @inheritdoc
+	 * Apply category filter to product collection
+	 *
+	 * @param   \Magento\Framework\App\RequestInterface $request
+	 * @return  $this
 	 */
 	public function apply(\Magento\Framework\App\RequestInterface $request)
 	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return parent::apply($request);
-		}
+		parent::apply($request);
 
-		$categoryId = $request->getParam($this->_requestVar);
-		if (empty($categoryId)) {
-			return $this;
-		}
-
-		$categoryIds = [];
-		foreach (explode(',', $categoryId) as $key => $id) {
-			$this->dataProvider->setCategoryId($id);
-			if ($this->dataProvider->isValid()) {
-				$category = $this->dataProvider->getCategory();
-				if ($request->getParam('id') != $id) {
-					$categoryIds[] = $id;
-					$this->getLayer()->getState()->addFilter($this->_createItem($category->getName(), $id));
-				}
-			}
-		}
-
-		if (sizeof($categoryIds)) {
-			$this->_isFilter = true;
-			$this->getLayer()->getProductCollection()->addLayerCategoryFilter($categoryIds);
-		}
-
-		if ($parentCategoryId = $request->getParam('id')) {
-			$this->dataProvider->setCategoryId($parentCategoryId);
+		$attributeValue = $request->getParam($this->_requestVar) ?: $request->getParam('id');
+		if (!empty($attributeValue)) {
+			$this->filterValue = explode(',', $attributeValue);
 		}
 
 		return $this;
 	}
 
 	/**
-	 * @inheritdoc
+	 * @return string
 	 */
-	protected function _getItemsData()
+	public function getFilterType()
 	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return parent::_getItemsData();
+		return LayerHelper::FILTER_TYPE_LIST;
+	}
+
+	/**
+	 * Get option url. If it has been filtered, return removed url. Else return filter url
+	 *
+	 * @param $item
+	 * @return mixed
+	 */
+	public function getUrl($item)
+	{
+		if ($this->isSelected($item)) {
+			return $item->getRemoveUrl();
 		}
 
-		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-		$productCollection = $this->getLayer()->getProductCollection();
+		return $item->getUrl();
+	}
 
-		if ($this->_isFilter) {
-			$productCollection = $productCollection->getCollectionClone()
-				->removeAttributeSearch('category_ids');
+	/**
+	 * Check it option is selected or not
+	 *
+	 * @param $item
+	 * @return bool
+	 */
+	public function isSelected($item)
+	{
+		if (!empty($this->filterValue) && in_array($item->getValue(), $this->filterValue)) {
+			return true;
 		}
 
-		$optionsFacetedData = $productCollection->getFacetedData('category');
-		$category           = $this->dataProvider->getCategory();
-		$categories         = $category->getChildrenCategories();
+		return false;
+	}
 
-		$collectionSize = $productCollection->getSize();
+	/**
+	 * Allow to show zero options
+	 *
+	 * @return bool
+	 */
+	public function isShowZero()
+	{
+		return false;
+	}
 
-		if ($category->getIsActive()) {
-			foreach ($categories as $category) {
-				$count = isset($optionsFacetedData[$category->getId()]) ? $optionsFacetedData[$category->getId()]['count'] : 0;
-				if ($category->getIsActive()
-					&& $this->_moduleHelper->getFilterModel()->isOptionReducesResults($this, $count, $collectionSize)
-				) {
-					$this->itemDataBuilder->addItemData(
-						$this->escaper->escapeHtml($category->getName()),
-						$category->getId(),
-						$count
-					);
-				}
-			}
-		}
+	/**
+	 * Allow to show counter after options
+	 *
+	 * @return bool
+	 */
+	public function isShowCounter()
+	{
+		return true;
+	}
 
-		return $this->itemDataBuilder->build();
+	/**
+	 * Allow multiple filter
+	 *
+	 * @return bool
+	 */
+	public function isMultiple()
+	{
+		return false;
 	}
 }
diff --git a/Model/Layer/Filter/Decimal.php b/Model/Layer/Filter/Decimal.php
new file mode 100644
index 0000000..d318ab1
--- /dev/null
+++ b/Model/Layer/Filter/Decimal.php
@@ -0,0 +1,137 @@
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
+namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
+
+use Magento\CatalogSearch\Model\Layer\Filter\Decimal as AbstractFilter;
+use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
+
+/**
+ * Layer category filter
+ */
+class Decimal extends AbstractFilter implements FilterInterface
+{
+	/**
+	 * @type array
+	 */
+	protected $filterValue = [];
+
+	/**
+	 * Apply price range filter
+	 *
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 * @return $this
+	 * @throws \Magento\Framework\Exception\LocalizedException
+	 */
+	public function apply(\Magento\Framework\App\RequestInterface $request)
+	{
+		/**
+		 * Filter must be string: $fromPrice-$toPrice
+		 */
+		$filter = $request->getParam($this->getRequestVar());
+		if (!$filter || is_array($filter)) {
+			return $this;
+		}
+
+		$this->filterValue[] = $filter;
+		list($from, $to) = explode('-', $filter);
+
+		$this->getLayer()
+			->getProductCollection()
+			->addFieldToFilter(
+				$this->getAttributeModel()->getAttributeCode(),
+				['from' => $from, 'to' => $to]
+			);
+
+		$this->getLayer()->getState()->addFilter(
+			$this->_createItem($this->renderRangeLabel(empty($from) ? 0 : $from, $to), $filter)
+		);
+
+		return $this;
+	}
+
+	/**
+	 * @return string
+	 */
+	public function getFilterType()
+	{
+		return LayerHelper::FILTER_TYPE_LIST;
+	}
+
+	/**
+	 * Get option url. If it has been filtered, return removed url. Else return filter url
+	 *
+	 * @param $item
+	 * @return mixed
+	 */
+	public function getUrl($item)
+	{
+		if ($this->isSelected($item)) {
+			return $item->getRemoveUrl();
+		}
+
+		return $item->getUrl();
+	}
+
+	/**
+	 * Check it option is selected or not
+	 *
+	 * @param $item
+	 * @return bool
+	 */
+	public function isSelected($item)
+	{
+		if (!empty($this->filterValue) && in_array($item->getValue(), $this->filterValue)) {
+			return true;
+		}
+
+		return false;
+	}
+
+	/**
+	 * Allow to show zero options
+	 *
+	 * @return bool
+	 */
+	public function isShowZero()
+	{
+		return false;
+	}
+
+	/**
+	 * Allow to show counter after options
+	 *
+	 * @return bool
+	 */
+	public function isShowCounter()
+	{
+		return true;
+	}
+
+	/**
+	 * Allow multiple filter
+	 *
+	 * @return bool
+	 */
+	public function isMultiple()
+	{
+		return true;
+	}
+}
diff --git a/Model/Layer/Filter/FilterInterface.php b/Model/Layer/Filter/FilterInterface.php
new file mode 100644
index 0000000..fc66ddb
--- /dev/null
+++ b/Model/Layer/Filter/FilterInterface.php
@@ -0,0 +1,80 @@
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
+namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
+
+/**
+ * Interface FilterInterface
+ * @package Mageplaza\LayeredNavigation\Model\Layer\Filter
+ */
+interface FilterInterface
+{
+	/**
+	 * Apply filter
+	 *
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 * @return mixed
+	 */
+	public function apply(\Magento\Framework\App\RequestInterface $request);
+
+	/**
+	 * Filter type. Used for get item url range or list
+	 *
+	 * @return mixed
+	 */
+	public function getFilterType();
+
+	/**
+	 * Depend on item is selected or not, return filter url or remove url
+	 *
+	 * @param $item
+	 * @return mixed
+	 */
+	public function getUrl($item);
+
+	/**
+	 * Item is selected or not
+	 *
+	 * @param $item
+	 * @return mixed
+	 */
+	public function isSelected($item);
+
+	/**
+	 * Can show non product options
+	 *
+	 * @return mixed
+	 */
+	public function isShowZero();
+
+	/**
+	 * Can show counter after option label
+	 *
+	 * @return mixed
+	 */
+	public function isShowCounter();
+
+	/**
+	 * Is multiple filter
+	 *
+	 * @return mixed
+	 */
+	public function isMultiple();
+}
\ No newline at end of file
diff --git a/Model/Layer/Filter/Price.php b/Model/Layer/Filter/Price.php
index 44e6532..9c30909 100644
--- a/Model/Layer/Filter/Price.php
+++ b/Model/Layer/Filter/Price.php
@@ -15,35 +15,50 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Price as AbstractFilter;
 use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
 
 /**
- * Class Price
- * @package Mageplaza\LayeredNavigation\Model\Layer\Filter
+ * Layer price filter based on Search API
+ *
+ * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
  */
 class Price extends AbstractFilter
 {
-	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
-	protected $_moduleHelper;
+	/**
+	 * @var \Magento\Catalog\Model\Layer\Filter\DataProvider\Price
+	 */
+	private $dataProvider;
 
-	/** @var array|null Filter value */
-	protected $_filterVal = null;
+	/**
+	 * @var \Magento\Framework\Pricing\PriceCurrencyInterface
+	 */
+	private $priceCurrency;
 
-	/** @var \Magento\Tax\Helper\Data */
-	protected $_taxHelper;
+	/**
+	 * @type
+	 */
+	protected $filterValue;
 
-	/** @var \Magento\Catalog\Model\Layer\Filter\DataProvider\Price */
-	private $dataProvider;
+	/**
+	 * @type
+	 */
+	protected $filterType;
 
-	/** @var \Magento\Framework\Pricing\PriceCurrencyInterface */
-	private $priceCurrency;
+	/**
+	 * @type \Mageplaza\LayeredNavigation\Helper\Data
+	 */
+	protected $_moduleHelper;
+
+	/**
+	 * @type \Magento\Tax\Helper\Data
+	 */
+	protected $_taxHelper;
 
 	/**
 	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
@@ -56,9 +71,9 @@ class Price extends AbstractFilter
 	 * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
 	 * @param \Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory
 	 * @param \Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory
-	 * @param \Magento\Tax\Helper\Data $taxHelper
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
 	 * @param array $data
+	 * @SuppressWarnings(PHPMD.ExcessiveParameterList)
+	 * @SuppressWarnings(PHPMD.UnusedFormalParameter)
 	 */
 	public function __construct(
 		\Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
@@ -71,8 +86,8 @@ class Price extends AbstractFilter
 		\Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency,
 		\Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory,
 		\Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory,
+		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper,
 		\Magento\Tax\Helper\Data $taxHelper,
-		LayerHelper $moduleHelper,
 		array $data = []
 	)
 	{
@@ -94,10 +109,15 @@ class Price extends AbstractFilter
 		$this->dataProvider  = $dataProviderFactory->create(['layer' => $this->getLayer()]);
 		$this->_moduleHelper = $moduleHelper;
 		$this->_taxHelper    = $taxHelper;
+		$this->filterValue   = [];
 	}
 
 	/**
-	 * @inheritdoc
+	 * Apply price range filter
+	 *
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 * @return $this
+	 * @SuppressWarnings(PHPMD.NPathComplexity)
 	 */
 	public function apply(\Magento\Framework\App\RequestInterface $request)
 	{
@@ -123,7 +143,8 @@ class Price extends AbstractFilter
 			$this->dataProvider->setPriorIntervals($priorFilters);
 		}
 
-		list($from, $to) = $this->_filterVal = $filter;
+		$this->filterValue = $filter;
+		list($from, $to) = $filter;
 
 		$this->getLayer()->getProductCollection()->addFieldToFilter(
 			'price',
@@ -138,7 +159,11 @@ class Price extends AbstractFilter
 	}
 
 	/**
-	 * @inheritdoc
+	 * Prepare text of range label
+	 *
+	 * @param float|string $fromPrice
+	 * @param float|string $toPrice
+	 * @return float|\Magento\Framework\Phrase
 	 */
 	protected function _renderRangeLabel($fromPrice, $toPrice)
 	{
@@ -156,41 +181,6 @@ class Price extends AbstractFilter
 	}
 
 	/**
-	 * Price Slider Configuration
-	 *
-	 * @return array
-	 */
-	public function getSliderConfig()
-	{
-		/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
-		$productCollection = $this->getLayer()->getProductCollection();
-
-		if ($this->_filterVal) {
-			/** @type \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollectionClone */
-			$productCollection = $productCollection->getCollectionClone()
-				->removeAttributeSearch(['price.from', 'price.to']);
-		}
-
-		$min = $productCollection->getMinPrice();
-		$max = $productCollection->getMaxPrice();
-
-		list($from, $to) = $this->_filterVal ?: [$min, $max];
-		$from = ($from < $min) ? $min : $from;
-		$to = ($to > $max) ? $max : $to;
-
-		$item = $this->getItems()[0];
-
-		return [
-			"selectedFrom" => $from,
-			"selectedTo"   => $to,
-			"minValue"     => $min,
-			"maxValue"     => $max,
-			"priceFormat"  => $this->_taxHelper->getPriceFormat(),
-			"ajaxUrl"      => $item->getUrl()
-		];
-	}
-
-	/**
 	 * Get data array for building attribute filter items
 	 *
 	 * @return array
@@ -199,66 +189,51 @@ class Price extends AbstractFilter
 	 */
 	protected function _getItemsData()
 	{
-		if (!$this->_moduleHelper->isEnabled()) {
+		if (!$this->_moduleHelper->isEnabled() || ($this->getFilterType() != LayerHelper::FILTER_TYPE_RANGE)) {
 			return parent::_getItemsData();
 		}
 
-		$attribute         = $this->getAttributeModel();
-		$this->_requestVar = $attribute->getAttributeCode();
-
-		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-		$productCollection = $this->getLayer()->getProductCollection();
-
-		if ($this->_filterVal) {
-			/** @type \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollectionClone */
-			$productCollection = $productCollection->getCollectionClone()
-				->removeAttributeSearch(['price.from', 'price.to']);
-		}
-
-		$facets = $productCollection->getFacetedData($attribute->getAttributeCode());
-
-		$data = [];
-		if (count($facets) > 1) { // two range minimum
-			foreach ($facets as $key => $aggregation) {
-				$count = $aggregation['count'];
-				if (strpos($key, '_') === false) {
-					continue;
-				}
-				$data[] = $this->prepareData($key, $count);
-			}
-		}
+		return [[
+			'label' => __('Price Slider'),
+			'value' => 'slider',
+			'count' => 1
+		]];
+	}
 
-		return $data;
+	/**
+	 * @return string
+	 */
+	public function getFilterType()
+	{
+		return LayerHelper::FILTER_TYPE_RANGE;
 	}
 
 	/**
-	 * @param string $key
-	 * @param int $count
 	 * @return array
 	 */
-	private function prepareData($key, $count)
+	public function getFilterSliderConfig()
 	{
-		list($from, $to) = explode('_', $key);
-		if ($from == '*') {
-			$from = $this->getFrom($to);
-		}
-		if ($to == '*') {
-			$to = $this->getTo($to);
-		}
-		$label = $this->_renderRangeLabel(
-			empty($from) ? 0 : $from * $this->getCurrencyRate(),
-			empty($to) ? $to : $to * $this->getCurrencyRate()
-		);
-		$value = $from . '-' . $to . $this->dataProvider->getAdditionalRequestData();
+		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
+		$productCollection      = $this->getLayer()->getProductCollection();
+		$productCollectionClone = $productCollection->getCollectionClone();
+		$collection             = $productCollectionClone
+			->removeAttributeSearch(['price.from', 'price.to']);
+
+		$min = $collection->getMinPrice();
+		$max = $collection->getMaxPrice();
+		list($from, $to) = $this->filterValue ?: [$min, $max];
+
+		$item = $this->getItems()[0];
 
-		$data = [
-			'label' => $label,
-			'value' => $value,
-			'count' => $count,
-			'from'  => $from,
-			'to'    => $to,
+		$config = [
+			"selectedFrom"  => $from,
+			"selectedTo"    => $to,
+			"minValue"      => $min,
+			"maxValue"      => $max,
+			"priceFormat"   => $this->_taxHelper->getPriceFormat(),
+			"ajaxUrl"       => $item->getUrl()
 		];
 
-		return $data;
+		return $config;
 	}
 }
diff --git a/Plugin/Model/Layer/Filter/Item.php b/Model/Plugin/Layer/Filter/Item.php
similarity index 70%
rename from Plugin/Model/Layer/Filter/Item.php
rename to Model/Plugin/Layer/Filter/Item.php
index 86f03d6..8de412f 100644
--- a/Plugin/Model/Layer/Filter/Item.php
+++ b/Model/Plugin/Layer/Filter/Item.php
@@ -15,11 +15,10 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
-namespace Mageplaza\LayeredNavigation\Plugin\Model\Layer\Filter;
+namespace Mageplaza\LayeredNavigation\Model\Plugin\Layer\Filter;
 
 use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
 
@@ -29,16 +28,24 @@ use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
  */
 class Item
 {
-	/** @var \Magento\Framework\UrlInterface */
+	/**
+	 * @type \Magento\Framework\UrlInterface
+	 */
 	protected $_url;
 
-	/** @var \Magento\Theme\Block\Html\Pager */
+	/**
+	 * @type \Magento\Theme\Block\Html\Pager
+	 */
 	protected $_htmlPagerBlock;
 
-	/** @var \Magento\Framework\App\RequestInterface */
+	/**
+	 * @type \Magento\Framework\App\RequestInterface
+	 */
 	protected $_request;
 
-	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
+	/**
+	 * @type \Mageplaza\LayeredNavigation\Helper\Data
+	 */
 	protected $_moduleHelper;
 
 	/**
@@ -64,9 +71,9 @@ class Item
 
 	/**
 	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-	 * @param $proceed
+	 * @param                                          $proceed
+	 *
 	 * @return string
-	 * @throws \Magento\Framework\Exception\LocalizedException
 	 */
 	public function aroundGetUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
 	{
@@ -74,12 +81,11 @@ class Item
 			return $proceed();
 		}
 
-		$value     = [];
-		$filter    = $item->getFilter();
-		$filterModel = $this->_moduleHelper->getFilterModel();
-		if ($filterModel->getIsSliderTypes($filter)) {
-			$value = ["from-to"];
-		} else if ($filterModel->isMultiple($filter)) {
+		$value  = [];
+		$filter = $item->getFilter();
+		if ($filter->getFilterType() == LayerHelper::FILTER_TYPE_RANGE) {
+			$value = ["{start}-{end}"];
+		} else if ($filter->isMultiple()) {
 			$requestVar = $filter->getRequestVar();
 			if ($requestValue = $this->_request->getParam($requestVar)) {
 				$value = explode(',', $requestValue);
@@ -91,7 +97,7 @@ class Item
 
 		if (sizeof($value)) {
 			$query = [
-				$filter->getRequestVar()                 => implode(',', $value),
+				$item->getFilter()->getRequestVar()      => implode(',', $value),
 				// exclude current page from urls
 				$this->_htmlPagerBlock->getPageVarName() => null,
 			];
@@ -104,9 +110,9 @@ class Item
 
 	/**
 	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-	 * @param $proceed
+	 * @param                                          $proceed
+	 *
 	 * @return string
-	 * @throws \Magento\Framework\Exception\LocalizedException
 	 */
 	public function aroundGetRemoveUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
 	{
@@ -114,17 +120,20 @@ class Item
 			return $proceed();
 		}
 
-		$value     = [];
-		$filter    = $item->getFilter();
-		$filterModel = $this->_moduleHelper->getFilterModel();
-		if (!$filterModel->getIsSliderTypes($filter)) {
-			$value = $filterModel->getFilterValue($filter);
+		$value      = [];
+		$filter     = $item->getFilter();
+		$requestVar = $filter->getRequestVar();
+		if ($filter->getFilterType() != LayerHelper::FILTER_TYPE_RANGE) {
+			if ($requestValue = $this->_request->getParam($requestVar)) {
+				$value = explode(',', $requestValue);
+			}
+
 			if (in_array($item->getValue(), $value)) {
 				$value = array_diff($value, [$item->getValue()]);
 			}
 		}
 
-		$params['_query']       = [$filter->getRequestVar() => count($value) ? implode(',', $value) : $filter->getResetValue()];
+		$params['_query']       = [$requestVar => count($value) ? implode(',', $value) : $filter->getResetValue()];
 		$params['_current']     = true;
 		$params['_use_rewrite'] = true;
 		$params['_escape']      = true;
diff --git a/Model/ResourceModel/Fulltext/Collection.php b/Model/ResourceModel/Fulltext/Collection.php
index 132b157..2d91315 100644
--- a/Model/ResourceModel/Fulltext/Collection.php
+++ b/Model/ResourceModel/Fulltext/Collection.php
@@ -15,54 +15,105 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext;
 
 use Magento\CatalogSearch\Model\Search\RequestGenerator;
-use Magento\Framework\App\ObjectManager;
 use Magento\Framework\DB\Select;
-use Magento\Framework\Exception\LocalizedException;
 use Magento\Framework\Exception\StateException;
 use Magento\Framework\Search\Adapter\Mysql\TemporaryStorage;
+use Magento\Framework\Search\Response\QueryResponse;
+use Magento\Framework\Search\Request\EmptyRequestDataException;
+use Magento\Framework\Search\Request\NonExistingRequestNameException;
+use Magento\Framework\Api\Search\SearchResultFactory;
+use Magento\Framework\Exception\LocalizedException;
+use Magento\Framework\App\ObjectManager;
 
 /**
- * Class Collection
- * @package Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext
+ * Fulltext Collection
+ * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
  */
 class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 {
-	/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection|null Clone collection */
-	public $collectionClone = null;
+	/**
+	 * @var  QueryResponse
+	 * @deprecated
+	 */
+	protected $queryResponse;
 
-	/** @var string */
+	/**
+	 * Catalog search data
+	 *
+	 * @var \Magento\Search\Model\QueryFactory
+	 * @deprecated
+	 */
+	protected $queryFactory = null;
+
+	/**
+	 * @var \Magento\Framework\Search\Request\Builder
+	 * @deprecated
+	 */
+	private $requestBuilder;
+
+	/**
+	 * @var \Magento\Search\Model\SearchEngine
+	 * @deprecated
+	 */
+	private $searchEngine;
+
+	/**
+	 * @var string
+	 */
 	private $queryText;
 
-	/** @var string|null */
+	/**
+	 * @var string|null
+	 */
 	private $order = null;
 
-	/** @var string */
+	/**
+	 * @var string
+	 */
 	private $searchRequestName;
 
-	/** @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory */
+	/**
+	 * @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory
+	 */
 	private $temporaryStorageFactory;
 
-	/** @var \Magento\Search\Api\SearchInterface */
+	/**
+	 * @var \Magento\Search\Api\SearchInterface
+	 */
 	private $search;
 
-	/** @var \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder */
+	/**
+	 * @var \Magento\Framework\Api\Search\SearchCriteriaBuilder
+	 */
 	private $searchCriteriaBuilder;
 
-	/** @var \Magento\Framework\Api\Search\SearchResultInterface */
+	/**
+	 * @var \Magento\Framework\Api\Search\SearchResultInterface
+	 */
 	private $searchResult;
 
-	/** @var \Magento\Framework\Api\FilterBuilder */
+	/**
+	 * @var SearchResultFactory
+	 */
+	private $searchResultFactory;
+
+	/**
+	 * @var \Magento\Framework\Api\FilterBuilder
+	 */
 	private $filterBuilder;
 
 	/**
-	 * Collection constructor.
+	 * @type null
+	 */
+	public $collectionClone = null;
+
+	/**
 	 * @param \Magento\Framework\Data\Collection\EntityFactory $entityFactory
 	 * @param \Psr\Log\LoggerInterface $logger
 	 * @param \Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy
@@ -82,9 +133,14 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	 * @param \Magento\Customer\Model\Session $customerSession
 	 * @param \Magento\Framework\Stdlib\DateTime $dateTime
 	 * @param \Magento\Customer\Api\GroupManagementInterface $groupManagement
+	 * @param \Magento\Search\Model\QueryFactory $catalogSearchData
+	 * @param \Magento\Framework\Search\Request\Builder $requestBuilder
+	 * @param \Magento\Search\Model\SearchEngine $searchEngine
 	 * @param \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory
-	 * @param \Magento\Framework\DB\Adapter\AdapterInterface|null $connection
+	 * @param \Magento\Framework\DB\Adapter\AdapterInterface $connection
 	 * @param string $searchRequestName
+	 * @param SearchResultFactory $searchResultFactory
+	 * @SuppressWarnings(PHPMD.ExcessiveParameterList)
 	 */
 	public function __construct(
 		\Magento\Framework\Data\Collection\EntityFactory $entityFactory,
@@ -106,11 +162,21 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 		\Magento\Customer\Model\Session $customerSession,
 		\Magento\Framework\Stdlib\DateTime $dateTime,
 		\Magento\Customer\Api\GroupManagementInterface $groupManagement,
+		\Magento\Search\Model\QueryFactory $catalogSearchData,
+		\Magento\Framework\Search\Request\Builder $requestBuilder,
+		\Magento\Search\Model\SearchEngine $searchEngine,
 		\Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory,
 		\Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
-		$searchRequestName = 'catalog_view_container'
+		$searchRequestName = 'catalog_view_container',
+		SearchResultFactory $searchResultFactory = null
 	)
 	{
+
+		$this->queryFactory = $catalogSearchData;
+		if ($searchResultFactory === null) {
+			$this->searchResultFactory = \Magento\Framework\App\ObjectManager::getInstance()
+				->get('Magento\Framework\Api\Search\SearchResultFactory');
+		}
 		parent::__construct(
 			$entityFactory,
 			$logger,
@@ -133,47 +199,74 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 			$groupManagement,
 			$connection
 		);
+		$this->requestBuilder          = $requestBuilder;
+		$this->searchEngine            = $searchEngine;
 		$this->temporaryStorageFactory = $temporaryStorageFactory;
 		$this->searchRequestName       = $searchRequestName;
 	}
 
 	/**
-	 * MP LayerNavigation Clone collection
-	 *
-	 * @return \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection|null
+	 * @deprecated
+	 * @return \Magento\Search\Api\SearchInterface
 	 */
-	public function getCollectionClone()
+	private function getSearch()
 	{
-		if ($this->collectionClone === null) {
-			$this->collectionClone = clone $this;
-			$this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
+		if ($this->search === null) {
+			$this->search = ObjectManager::getInstance()->get('\Magento\Search\Api\SearchInterface');
 		}
 
-		$searchCriterialBuilder = $this->collectionClone->getSearchCriteriaBuilder()->cloneObject();
+		return $this->search;
+	}
 
-		/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $collectionClone */
+	/**
+	 * @deprecated
+	 * @param \Magento\Search\Api\SearchInterface $object
+	 * @return void
+	 */
+	public function setSearch(\Magento\Search\Api\SearchInterface $object)
+	{
+		$this->search = $object;
+	}
+
+	/**
+	 * @deprecated
+	 * @return \Magento\Framework\Api\Search\SearchCriteriaBuilder
+	 */
+	public function getSearchCriteriaBuilder()
+	{
+		if ($this->searchCriteriaBuilder === null) {
+			$this->searchCriteriaBuilder = ObjectManager::getInstance()
+				->get('\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder');
+		}
+
+		return $this->searchCriteriaBuilder;
+	}
+
+	/**
+	 * @return null
+	 */
+	public function getCollectionClone()
+	{
 		$collectionClone = clone $this->collectionClone;
-		$collectionClone->setSearchCriteriaBuilder($searchCriterialBuilder);
+		$collectionClone->setSearchCriteriaBuilder($this->collectionClone->getSearchCriteriaBuilder()->cloneObject());
 
 		return $collectionClone;
 	}
 
 	/**
-	 * MP LayerNavigation Add multi-filter categories
-	 *
-	 * @param $categories
 	 * @return $this
 	 */
-	public function addLayerCategoryFilter($categories)
+	public function cloneObject()
 	{
-		$this->addFieldToFilter('category_ids', implode(',', $categories));
+		if ($this->collectionClone === null) {
+			$this->collectionClone = clone $this;
+			$this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
+		}
 
 		return $this;
 	}
 
 	/**
-	 * MP LayerNavigation remove filter to load option item data
-	 *
 	 * @param $attributeCode
 	 * @return $this
 	 */
@@ -193,7 +286,7 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	}
 
 	/**
-	 * MP LayerNavigation Get attribute condition sql
+	 * Get attribute condition sql
 	 *
 	 * @param $attribute
 	 * @param $condition
@@ -206,7 +299,7 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	}
 
 	/**
-	 * MP LayerNavigation Reset Total records
+	 * Reset Total records
 	 *
 	 * @return $this
 	 */
@@ -218,43 +311,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	}
 
 	/**
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
-	 * @return \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder
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
 	 * @param \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object
 	 */
 	public function setSearchCriteriaBuilder(\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object)
@@ -338,8 +394,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	 */
 	protected function _renderFiltersBefore()
 	{
-		$this->getCollectionClone();
-
 		$this->getSearchCriteriaBuilder();
 		$this->getFilterBuilder();
 		$this->getSearch();
@@ -360,17 +414,23 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
 		}
 
+		$this->cloneObject();
+
 		$searchCriteria = $this->searchCriteriaBuilder->create();
 		$searchCriteria->setRequestName($this->searchRequestName);
 
 		try {
 			$this->searchResult = $this->getSearch()->search($searchCriteria);
-		} catch (\Exception $e) {
+		} catch (EmptyRequestDataException $e) {
+			/** @var \Magento\Framework\Api\Search\SearchResultInterface $searchResult */
+			$this->searchResult = $this->searchResultFactory->create()->setItems([]);
+		} catch (NonExistingRequestNameException $e) {
+			$this->_logger->error($e->getMessage());
 			throw new LocalizedException(__('Sorry, something went wrong. You can find out more in the error log.'));
 		}
 
 		$temporaryStorage = $this->temporaryStorageFactory->create();
-		$table            = $temporaryStorage->storeDocuments($this->searchResult->getItems());
+		$table            = $temporaryStorage->storeApiDocuments($this->searchResult->getItems());
 
 		$this->getSelect()->joinInner(
 			[
@@ -380,11 +440,13 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 			[]
 		);
 
+//		$this->_totalRecords = $this->searchResult->getTotalCount();
+
 		if ($this->order && 'relevance' === $this->order['field']) {
 			$this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
 		}
 
-		parent::_renderFiltersBefore();
+		return parent::_renderFiltersBefore();
 	}
 
 	/**
diff --git a/view/frontend/templates/layer.phtml b/Model/Search/FilterGroup.php
similarity index 54%
rename from view/frontend/templates/layer.phtml
rename to Model/Search/FilterGroup.php
index b3f1d15..02e6231 100644
--- a/view/frontend/templates/layer.phtml
+++ b/Model/Search/FilterGroup.php
@@ -15,16 +15,23 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-?>
+namespace Mageplaza\LayeredNavigation\Model\Search;
 
-<div id="layered-filter-block-container" class="layered-filter-block-container">
-    <?php echo $block->getChildHtml() ?>
-</div>
-<div id="ln_overlay" class="ln_overlay">
-    <div class="loader">
-        <img src="<?php echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
-    </div>
-</div>
+use Magento\Framework\Api\Search\FilterGroup as SourceFilterGroup;
+
+/**
+ * Groups two or more filters together using a logical OR
+ */
+class FilterGroup extends SourceFilterGroup
+{
+    /**
+     * @return bool
+     */
+    public function isUsedQuery()
+    {
+        return true;
+    }
+}
diff --git a/Model/Search/FilterGroupBuilder.php b/Model/Search/FilterGroupBuilder.php
index e874a49..387ac1b 100644
--- a/Model/Search/FilterGroupBuilder.php
+++ b/Model/Search/FilterGroupBuilder.php
@@ -15,90 +15,66 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\FilterBuilder;
 use Magento\Framework\Api\ObjectFactory;
-use Magento\Framework\Api\Search\FilterGroup;
 use Magento\Framework\Api\Search\FilterGroupBuilder as SourceFilterGroupBuilder;
-use Magento\Framework\App\RequestInterface;
 
 /**
  * Builder for FilterGroup Data.
  */
 class FilterGroupBuilder extends SourceFilterGroupBuilder
 {
-	/** @var \Magento\Framework\App\RequestInterface */
-	protected $_request;
-
-	/**
-	 * FilterGroupBuilder constructor.
-	 * @param \Magento\Framework\Api\ObjectFactory $objectFactory
-	 * @param \Magento\Framework\Api\FilterBuilder $filterBuilder
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 */
-	public function __construct(
-		ObjectFactory $objectFactory,
-		FilterBuilder $filterBuilder,
-		RequestInterface $request
-	)
-	{
-		parent::__construct($objectFactory, $filterBuilder);
-
-		$this->_request = $request;
-	}
+    /**
+     * @param ObjectFactory $objectFactory
+     * @param FilterBuilder $filterBuilder
+     */
+    public function __construct(
+        ObjectFactory $objectFactory,
+        FilterBuilder $filterBuilder
+    ) {
 
-	/**
-	 * @return FilterGroupBuilder
-	 */
-	public function cloneObject()
-	{
-		$cloneObject = clone $this;
-		$cloneObject->setFilterBuilder(clone $this->_filterBuilder);
+        parent::__construct($objectFactory, $filterBuilder);
+    }
 
-		return $cloneObject;
-	}
+    /**
+     * @param $filterBuilder
+     */
+    public function setFilterBuilder($filterBuilder)
+    {
+        $this->_filterBuilder = $filterBuilder;
+    }
 
-	/**
-	 * @param $filterBuilder
-	 */
-	public function setFilterBuilder($filterBuilder)
-	{
-		$this->_filterBuilder = $filterBuilder;
-	}
+    /**
+     * @return FilterGroupBuilder
+     */
+    public function cloneObject()
+    {
+        $cloneObject = clone $this;
+        $cloneObject->setFilterBuilder(clone $this->_filterBuilder);
 
-	/**
-	 * @param $attributeCode
-	 *
-	 * @return $this
-	 */
-	public function removeFilter($attributeCode)
-	{
-		if (isset($this->data[FilterGroup::FILTERS])) {
-			foreach ($this->data[FilterGroup::FILTERS] as $key => $filter) {
-				if ($filter->getField() == $attributeCode) {
-					if (($attributeCode == 'category_ids') && ($filter->getValue() == $this->_request->getParam('id'))) {
-						continue;
-					}
-					unset($this->data[FilterGroup::FILTERS][$key]);
-				}
-			}
-		}
+        return $cloneObject;
+    }
 
-		return $this;
-	}
+    /**
+     * @param $attributeCode
+     *
+     * @return $this
+     */
+    public function removeFilter($attributeCode)
+    {
+        if (isset($this->data[FilterGroup::FILTERS])) {
+            foreach ($this->data[FilterGroup::FILTERS] as $key => $filter) {
+                if ($filter->getField() == $attributeCode) {
+                    unset($this->data[FilterGroup::FILTERS][$key]);
+                }
+            }
+        }
 
-	/**
-	 * Return the Data type class name
-	 *
-	 * @return string
-	 */
-	protected function _getDataObjectType()
-	{
-		return 'Magento\Framework\Api\Search\FilterGroup';
-	}
+        return $this;
+    }
 }
diff --git a/Api/Search/Document.php b/Model/Search/SearchCriteria.php
similarity index 50%
rename from Api/Search/Document.php
rename to Model/Search/SearchCriteria.php
index 4c3afb8..1b6ad3c 100644
--- a/Api/Search/Document.php
+++ b/Model/Search/SearchCriteria.php
@@ -15,27 +15,23 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-namespace Mageplaza\LayeredNavigation\Api\Search;
+namespace Mageplaza\LayeredNavigation\Model\Search;
 
-use Magento\Framework\Api\Search\Document as SourceDocument;
+use Magento\Framework\Api\Search\SearchCriteria as SourceSearchCriteria;
 
 /**
- * Class Document
- * @package Mageplaza\LayeredNavigation\Api\Search
+ * Groups two or more filters together using a logical OR
  */
-class Document extends SourceDocument
+class SearchCriteria extends SourceSearchCriteria
 {
-	/**
-	 * Get Document field
-	 *
-	 * @param string $fieldName
-	 * @return \Magento\Framework\Api\AttributeInterface
-	 */
-	public function getField($fieldName)
-	{
-		return $this->getCustomAttribute($fieldName);
-	}
+    /**
+     * @return bool
+     */
+    public function isUsedQuery()
+    {
+        return true;
+    }
 }
diff --git a/Model/Search/SearchCriteriaBuilder.php b/Model/Search/SearchCriteriaBuilder.php
index d463130..f767e94 100644
--- a/Model/Search/SearchCriteriaBuilder.php
+++ b/Model/Search/SearchCriteriaBuilder.php
@@ -15,73 +15,62 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\ObjectFactory;
-use Magento\Framework\Api\Search\SearchCriteriaBuilder as SourceSearchCriteriaBuilder;
 use Magento\Framework\Api\SortOrderBuilder;
+use Magento\Framework\Api\Search\SearchCriteriaBuilder as SourceSearchCriteriaBuilder;
 
 /**
  * Builder for SearchCriteria Service Data Object
  */
 class SearchCriteriaBuilder extends SourceSearchCriteriaBuilder
 {
-	/**
-	 * @param ObjectFactory $objectFactory
-	 * @param FilterGroupBuilder $filterGroupBuilder
-	 * @param SortOrderBuilder $sortOrderBuilder
-	 */
-	public function __construct(
-		ObjectFactory $objectFactory,
-		FilterGroupBuilder $filterGroupBuilder,
-		SortOrderBuilder $sortOrderBuilder
-	)
-	{
-		parent::__construct($objectFactory, $filterGroupBuilder, $sortOrderBuilder);
-	}
-
-	/**
-	 * @param $attributeCode
-	 *
-	 * @return $this
-	 */
-	public function removeFilter($attributeCode)
-	{
-		$this->filterGroupBuilder->removeFilter($attributeCode);
+    /**
+     * @param ObjectFactory $objectFactory
+     * @param FilterGroupBuilder $filterGroupBuilder
+     * @param SortOrderBuilder $sortOrderBuilder
+     */
+    public function __construct(
+        ObjectFactory $objectFactory,
+        FilterGroupBuilder $filterGroupBuilder,
+        SortOrderBuilder $sortOrderBuilder
+    ) {
+    
+        parent::__construct($objectFactory, $filterGroupBuilder, $sortOrderBuilder);
+    }
 
-		return $this;
-	}
+    /**
+     * @param $attributeCode
+     *
+     * @return $this
+     */
+    public function removeFilter($attributeCode)
+    {
+        $this->filterGroupBuilder->removeFilter($attributeCode);
 
-	/**
-	 * @return SearchCriteriaBuilder
-	 */
-	public function cloneObject()
-	{
-		$cloneObject = clone $this;
-		$cloneObject->setFilterGroupBuilder($this->filterGroupBuilder->cloneObject());
+        return $this;
+    }
 
-		return $cloneObject;
-	}
+    /**
+     * @param $filterGroupBuilder
+     */
+    public function setFilterGroupBuilder($filterGroupBuilder)
+    {
+        $this->filterGroupBuilder = $filterGroupBuilder;
+    }
 
-	/**
-	 * @param $filterGroupBuilder
-	 */
-	public function setFilterGroupBuilder($filterGroupBuilder)
-	{
-		$this->filterGroupBuilder = $filterGroupBuilder;
-	}
+    /**
+     * @return SearchCriteriaBuilder
+     */
+    public function cloneObject()
+    {
+        $cloneObject = clone $this;
+        $cloneObject->setFilterGroupBuilder($this->filterGroupBuilder->cloneObject());
 
-	/**
-	 * Return the Data type class name
-	 *
-	 * @return string
-	 */
-	protected function _getDataObjectType()
-	{
-		return 'Magento\Framework\Api\Search\SearchCriteria';
-	}
+        return $cloneObject;
+    }
 }
diff --git a/Plugin/Controller/Category/View.php b/Plugin/Controller/Category/View.php
deleted file mode 100644
index 3095221..0000000
--- a/Plugin/Controller/Category/View.php
+++ /dev/null
@@ -1,65 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-
-namespace Mageplaza\LayeredNavigation\Plugin\Controller\Category;
-
-/**
- * Class View
- * @package Mageplaza\LayeredNavigation\Controller\Plugin\Category
- */
-class View
-{
-	/** @var \Magento\Framework\Json\Helper\Data */
-	protected $_jsonHelper;
-
-	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
-	protected $_moduleHelper;
-
-	/**
-	 * @param \Magento\Framework\Json\Helper\Data $jsonHelper
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	 */
-	public function __construct(
-		\Magento\Framework\Json\Helper\Data $jsonHelper,
-		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	)
-	{
-		$this->_jsonHelper   = $jsonHelper;
-		$this->_moduleHelper = $moduleHelper;
-	}
-
-	/**
-	 * @param \Magento\Catalog\Controller\Category\View $action
-	 * @param $page
-	 * @return mixed
-	 */
-	public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
-	{
-		if ($this->_moduleHelper->isEnabled() && $action->getRequest()->isAjax()) {
-			$navigation = $page->getLayout()->getBlock('catalog.leftnav');
-			$products   = $page->getLayout()->getBlock('category.products');
-			$result     = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
-			$action->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
-		} else {
-			return $page;
-		}
-	}
-}
diff --git a/Plugin/Model/Adapter/Preprocessor.php b/Plugin/Model/Adapter/Preprocessor.php
deleted file mode 100644
index 040d74f..0000000
--- a/Plugin/Model/Adapter/Preprocessor.php
+++ /dev/null
@@ -1,60 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-namespace Mageplaza\LayeredNavigation\Plugin\Model\Adapter;
-
-/**
- * Class Preprocessor
- * @package Mageplaza\LayeredNavigation\Model\Plugin\Adapter
- */
-class Preprocessor
-{
-	/**
-	 * @type \Mageplaza\LayeredNavigation\Helper\Data
-	 */
-	protected $_moduleHelper;
-
-	/**
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	 */
-	public function __construct(
-		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	)
-	{
-		$this->_moduleHelper   = $moduleHelper;
-	}
-
-	/**
-	 * @param \Magento\CatalogSearch\Model\Adapter\Mysql\Filter\Preprocessor $subject
-	 * @param \Closure $proceed
-	 * @param $filter
-	 * @param $isNegation
-	 * @param $query
-	 * @return string
-	 */
-	public function aroundProcess(\Magento\CatalogSearch\Model\Adapter\Mysql\Filter\Preprocessor $subject, \Closure $proceed, $filter, $isNegation, $query)
-	{
-		if ($this->_moduleHelper->isEnabled() && ($filter->getField() === 'category_ids')) {
-			return 'category_ids_index.category_id IN (' . $filter->getValue() . ')';
-		}
-
-		return $proceed($filter, $isNegation, $query);
-	}
-}
diff --git a/composer.json b/composer.json
index 0fc9a70..7934aea 100644
--- a/composer.json
+++ b/composer.json
@@ -2,10 +2,11 @@
   "name": "mageplaza/layered-navigation-m2",
   "description": "Layered navigation M2",
   "require": {
-    "mageplaza/module-core": "*"
+    "php": "~5.5.0|~5.6.0|~7.0.0",
+    "mageplaza/core-m2": "*"
   },
   "type": "magento2-module",
-  "version": "2.2.0",
+  "version": "1.0.0",
   "license": [
     "OSL-3.0",
     "AFL-3.0"
diff --git a/etc/acl.xml b/etc/acl.xml
index 114807b..6a0e5f3 100644
--- a/etc/acl.xml
+++ b/etc/acl.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -25,10 +25,15 @@
     <acl>
         <resources>
             <resource id="Magento_Backend::admin">
+                <resource id="Mageplaza_Core::menu">
+                    <resource id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" sortOrder="30">
+                        <resource id="Mageplaza_LayeredNavigation::configuration" title="Configuration" sortOrder="10"/>
+                    </resource>
+                </resource>
                 <resource id="Magento_Backend::stores">
                     <resource id="Magento_Backend::stores_settings">
                         <resource id="Magento_Config::config">
-                            <resource id="Mageplaza_LayeredNavigation::configuration" title="Layered Navigation"/>
+                            <resource id="Mageplaza_LayeredNavigation::layered_navigation" title="Layered Navigation"/>
                         </resource>
                     </resource>
                 </resource>
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index 11c5c4d..8bd94c4 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -16,14 +16,14 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
 
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
     <menu>
-        <add id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" module="Mageplaza_LayeredNavigation" sortOrder="100" resource="Mageplaza_LayeredNavigation::configuration" parent="Mageplaza_Core::menu"/>
+        <add id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" module="Mageplaza_LayeredNavigation" sortOrder="100" resource="Mageplaza_LayeredNavigation::layer" parent="Mageplaza_Core::menu"/>
         <add id="Mageplaza_LayeredNavigation::configuration" title="Configuration" module="Mageplaza_LayeredNavigation" sortOrder="10" action="adminhtml/system_config/edit/section/layered_navigation" resource="Mageplaza_LayeredNavigation::configuration" parent="Mageplaza_LayeredNavigation::layer"/>
     </menu>
 </config>
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 7218f1b..11a91e7 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -27,7 +27,7 @@
             <class>separator-top</class>
             <label>Layered Navigation</label>
             <tab>mageplaza</tab>
-            <resource>Mageplaza_LayeredNavigation::configuration</resource>
+            <resource>Mageplaza_LayeredNavigation::layered_navigation</resource>
             <group id="general" translate="label" type="text" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>General Configuration</label>
                 <field id="head" translate="label" type="button" sortOrder="1" showInDefault="1" showInWebsite="1" showInStore="1">
diff --git a/etc/config.xml b/etc/config.xml
index 202cb0d..f0e70f3 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/etc/di.xml b/etc/di.xml
index 7a0eaa1..dffa798 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -27,27 +27,19 @@
             <argument name="filters" xsi:type="array">
                 <item name="attribute" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Attribute</item>
                 <item name="price" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Price</item>
+                <item name="decimal" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Decimal</item>
                 <item name="category" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Category</item>
             </argument>
         </arguments>
     </virtualType>
-    <virtualType name="searchFilterList" type="Magento\Catalog\Model\Layer\FilterList">
-        <arguments>
-            <argument name="filters" xsi:type="array">
-                <item name="attribute" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Attribute</item>
-                <item name="price" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Price</item>
-                <item name="category" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Category</item>
-            </argument>
-        </arguments>
-    </virtualType>
-    <virtualType name="Magento\CatalogSearch\Model\ResourceModel\Fulltext\CollectionFactory" type="Magento\Catalog\Model\ResourceModel\Product\CollectionFactory">
+    <virtualType name="Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\CollectionFactory" type="Magento\Catalog\Model\ResourceModel\Product\CollectionFactory">
         <arguments>
             <argument name="instanceName" xsi:type="string">Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection</argument>
         </arguments>
     </virtualType>
-    <virtualType name="Magento\CatalogSearch\Model\ResourceModel\Fulltext\SearchCollection" type="Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection">
+    <type name="Magento\CatalogSearch\Model\Layer\Category\ItemCollectionProvider">
         <arguments>
-            <argument name="searchRequestName" xsi:type="string">quick_search_container</argument>
+            <argument name="collectionFactory" xsi:type="object">Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\CollectionFactory</argument>
         </arguments>
-    </virtualType>
+    </type>
 </config>
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index f571a75..3f802da 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -16,33 +16,19 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
 
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
-    <preference for="Magento\CatalogSearch\Controller\Result\Index" type="Mageplaza\LayeredNavigation\Controller\Search\Result\Index"/>
-    <virtualType name="Mageplaza\LayeredNavigation\Api\Search\DocumentFactory" type="Magento\Framework\Api\Search\DocumentFactory">
-        <arguments>
-            <argument name="instanceName" xsi:type="string">Mageplaza\LayeredNavigation\Api\Search\Document</argument>
-        </arguments>
-    </virtualType>
-    <type name="Magento\Framework\Search\SearchResponseBuilder">
-        <arguments>
-            <argument name="documentFactory" xsi:type="object">Mageplaza\LayeredNavigation\Api\Search\DocumentFactory</argument>
-        </arguments>
-    </type>
     <type name="Magento\Catalog\Controller\Category\View">
-        <plugin name="layer_navigation_ajax_update" type="Mageplaza\LayeredNavigation\Plugin\Controller\Category\View" sortOrder="1" />
+        <plugin name="layer_navigation_ajax_update" type="Mageplaza\LayeredNavigation\Controller\Plugin\Category\View" sortOrder="1" />
     </type>
     <type name="Magento\Catalog\Model\Layer\Filter\Item">
-        <plugin name="layer_filter_item_url" type="Mageplaza\LayeredNavigation\Plugin\Model\Layer\Filter\Item" sortOrder="1" />
+        <plugin name="ln_filter_item_url" type="Mageplaza\LayeredNavigation\Model\Plugin\Layer\Filter\Item" sortOrder="1" />
     </type>
     <type name="Magento\Swatches\Block\LayeredNavigation\RenderLayered">
-        <plugin name="layer_filter_item_swatch_url" type="Mageplaza\LayeredNavigation\Plugin\Block\Swatches\RenderLayered" sortOrder="1" />
-    </type>
-    <type name="Magento\CatalogSearch\Model\Adapter\Mysql\Filter\Preprocessor">
-        <plugin name="layer_filter_item_swatch_url" type="Mageplaza\LayeredNavigation\Plugin\Model\Adapter\Preprocessor" sortOrder="1" />
+        <plugin name="ln_filter_item_swatch_url" type="Mageplaza\LayeredNavigation\Block\Plugin\Swatches\RenderLayered" sortOrder="1" />
     </type>
 </config>
diff --git a/etc/module.xml b/etc/module.xml
index f03df2d..d36e25e 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
diff --git a/i18n/en_US.csv b/i18n/en_US.csv
deleted file mode 100644
index a84c339..0000000
--- a/i18n/en_US.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 and above"
-"%1 - %2","%1 - %2"
-"Price Slider","Price Slider"
-"Sorry, something went wrong. You can find out more in the error log.","Sorry, something went wrong. You can find out more in the error log."
-"Bucket does not exist","Bucket does not exist"
-"Shop By","Shop By"
-"Clear All","Clear All"
-"Shopping Options","Shopping Options"
-"Layered Navigation","Layered Navigation"
-"General Configuration","General Configuration"
-"Module Enable","Module Enable"
diff --git a/registration.php b/registration.php
index e5f783f..521b62d 100644
--- a/registration.php
+++ b/registration.php
@@ -15,7 +15,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/adminhtml/web/css/source/_module.less b/view/adminhtml/web/css/source/_module.less
index 17c1e45..9497f31 100644
--- a/view/adminhtml/web/css/source/_module.less
+++ b/view/adminhtml/web/css/source/_module.less
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/layout/catalog_category_view_type_layered.xml b/view/frontend/layout/catalog_category_view_type_layered.xml
index e4cd607..0e9f9f1 100644
--- a/view/frontend/layout/catalog_category_view_type_layered.xml
+++ b/view/frontend/layout/catalog_category_view_type_layered.xml
@@ -16,7 +16,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 -->
@@ -24,23 +24,20 @@
     <body>
         <referenceBlock name="catalog.leftnav">
             <action method="setTemplate" ifconfig="layered_navigation/general/enable">
-                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::layer/view.phtml</argument>
+                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::view.phtml</argument>
             </action>
             <container name="layer.additional.info" as="layer_additional_info"/>
             <container name="layer.content.before" as="layer_content_before"/>
         </referenceBlock>
         <referenceBlock name="catalog.navigation.renderer">
             <action method="setTemplate" ifconfig="layered_navigation/general/enable">
-                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::layer/filter.phtml</argument>
+                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::filter.phtml</argument>
+            </action>
+        </referenceBlock>
+        <referenceBlock name="category.products">
+            <action method="setTemplate" ifconfig="layered_navigation/general/enable">
+                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::products.phtml</argument>
             </action>
         </referenceBlock>
-        <referenceContainer name="content">
-            <block class="Magento\Framework\View\Element\Template" name="layer.category.products" template="Mageplaza_LayeredNavigation::products.phtml" />
-        </referenceContainer>
-        <referenceContainer name="sidebar.main">
-            <block class="Magento\Framework\View\Element\Template" name="layer.catalog.leftnav" template="Mageplaza_LayeredNavigation::layer.phtml" />
-        </referenceContainer>
-        <move element="category.products" destination="layer.category.products"/>
-        <move element="catalog.leftnav" destination="layer.catalog.leftnav"/>
     </body>
 </page>
diff --git a/view/frontend/layout/catalogsearch_result_index.xml b/view/frontend/layout/catalogsearch_result_index.xml
deleted file mode 100644
index 0adab86..0000000
--- a/view/frontend/layout/catalogsearch_result_index.xml
+++ /dev/null
@@ -1,46 +0,0 @@
-<?xml version="1.0"?>
-<!--
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
--->
-<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
-    <body>
-        <referenceBlock name="catalogsearch.leftnav">
-            <action method="setTemplate" ifconfig="layered_navigation/general/enable">
-                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::layer/view.phtml</argument>
-            </action>
-            <container name="layer.additional.info" as="layer_additional_info"/>
-            <container name="layer.content.before" as="layer_content_before"/>
-        </referenceBlock>
-        <referenceBlock name="catalogsearch.navigation.renderer">
-            <action method="setTemplate" ifconfig="layered_navigation/general/enable">
-                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::layer/filter.phtml</argument>
-            </action>
-        </referenceBlock>
-        <referenceContainer name="content">
-            <block class="Magento\Framework\View\Element\Template" name="layer.category.products" template="Mageplaza_LayeredNavigation::products.phtml" />
-        </referenceContainer>
-        <referenceContainer name="sidebar.main">
-            <block class="Magento\Framework\View\Element\Template" name="layer.catalog.leftnav" template="Mageplaza_LayeredNavigation::layer.phtml" />
-        </referenceContainer>
-        <move element="search.result" destination="layer.category.products"/>
-        <move element="catalogsearch.leftnav" destination="layer.catalog.leftnav"/>
-    </body>
-</page>
diff --git a/view/frontend/requirejs-config.js b/view/frontend/requirejs-config.js
index cc932ec..3f58af1 100644
--- a/view/frontend/requirejs-config.js
+++ b/view/frontend/requirejs-config.js
@@ -14,12 +14,14 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
 var config = {
-    paths: {
-        mpLayer: 'Mageplaza_LayeredNavigation/js/view/layer'
+    map: {
+        '*': {
+            'mpLayer': 'Mageplaza_LayeredNavigation/js/view/layer'
+        }
     }
 };
diff --git a/view/frontend/templates/filter.phtml b/view/frontend/templates/filter.phtml
new file mode 100644
index 0000000..0c78e0f
--- /dev/null
+++ b/view/frontend/templates/filter.phtml
@@ -0,0 +1,44 @@
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
+?>
+<?php
+/** @type \Mageplaza\LayeredNavigation\Model\Layer\Filter\Attribute $filter */
+$filter = $this->getFilter();
+$attributeCode = $filter->getRequestVar();
+?>
+<ol class="items">
+    <?php /** @type  $filterItem */ foreach ($filterItems as $filterItem): ?>
+        <li class="item">
+            <?php if($filter->getFilterType() == \Mageplaza\LayeredNavigation\Helper\Data::FILTER_TYPE_RANGE): ?>
+                <div id="ln_slider_container_<?php echo $attributeCode ?>">
+                    <div id="ln_slider_<?php echo $attributeCode ?>"></div>
+                    <div id="ln_slider_text_<?php echo $attributeCode ?>"></div>
+                </div>
+            <?php elseif ($filterItem->getCount() > 0): ?>
+                <a href="<?php echo $block->escapeUrl($filter->getUrl($filterItem)) ?>">
+                    <input type="checkbox" <?php echo $filter->isSelected($filterItem) ? 'checked="checked"' : ''  ?> class="layer-input-filter" name="filter_<?php echo $attributeCode ?>"/>
+                    <?php echo $filterItem->getLabel() ?>
+                    <span class="count"><?php echo $filterItem->getCount()?><span class="filter-count-label"><?php echo ($filterItem->getCount() == 1) ? 'item' : 'items'; ?></span></span>
+                </a>
+            <?php endif; ?>
+        </li>
+    <?php endforeach ?>
+</ol>
\ No newline at end of file
diff --git a/view/frontend/templates/layer/filter.phtml b/view/frontend/templates/layer/filter.phtml
deleted file mode 100644
index baf5718..0000000
--- a/view/frontend/templates/layer/filter.phtml
+++ /dev/null
@@ -1,54 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-?>
-<?php
-/** @type \Mageplaza\LayeredNavigation\Model\Layer\Filter\Attribute $filter */
-$filter = $this->getFilter();
-$attributeCode = $filter->getRequestVar();
-
-/** @type \Mageplaza\Layerednavigation\Model\Layer\Filter $filterModel */
-$filterModel = $this->helper('\Mageplaza\Layerednavigation\Helper\Data')->getFilterModel();
-?>
-<ol class="items">
-    <?php /** @type  $filterItem */ foreach ($filterItems as $filterItem): ?>
-        <li class="item">
-            <?php if($filterModel->getIsSliderTypes($filter)): ?>
-                <div id="ln_slider_container_<?php echo $attributeCode ?>" class="ln_slider_container">
-                    <div id="ln_slider_<?php echo $attributeCode ?>"></div>
-                    <div id="ln_slider_text_<?php echo $attributeCode ?>"></div>
-                </div>
-            <?php else: ?>
-                <a href="<?php echo $block->escapeUrl($filterModel->getItemUrl($filterItem)) ?>">
-                    <?php if ($filterItem->getCount() > 0): ?>
-                        <input type="<?php echo $filterModel->isMultiple($filter) ? 'checkbox' : 'radio' ?>" <?php echo $filterModel->isSelected($filterItem) ? 'checked="checked"' : ''  ?> />
-                    <?php else: ?>
-                        <input type="<?php echo $filterModel->isMultiple($filter) ? 'checkbox' : 'radio' ?>" disabled="disabled" />
-                    <?php endif; ?>
-
-                    <?php echo $filterItem->getLabel() ?>
-                    <?php if ($filterModel->isShowCounter($filter)): ?>
-                        <span class="count"><?php echo $filterItem->getCount()?><span class="filter-count-label"><?php echo ($filterItem->getCount() == 1) ? 'item' : 'items'; ?></span></span>
-                    <?php endif; ?>
-                </a>
-            <?php endif; ?>
-        </li>
-	<?php endforeach ?>
-</ol>
\ No newline at end of file
diff --git a/view/frontend/templates/layer/view.phtml b/view/frontend/templates/layer/view.phtml
deleted file mode 100644
index 03e2fcb..0000000
--- a/view/frontend/templates/layer/view.phtml
+++ /dev/null
@@ -1,69 +0,0 @@
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
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
-?>
-<?php if ($block->canShowBlock()): ?>
-<?php
-    $filters = $block->getFilters();
-    $layerConfig = $this->helper('Mageplaza\LayeredNavigation\Helper\Data')->getLayerConfiguration($filters);
-	$filtered = count($block->getLayer()->getState()->getFilters());
-?>
-<div class="block filter" id="layered-filter-block" data-mage-init='{"collapsible":{"openedState": "active", "collapsible": true, "active": false, "collateral": { "openedState": "filter-active", "element": "body" } }}'>
-	<div class="block-title filter-title" data-count="<?php /* @escapeNotVerified */ echo $filtered; ?>">
-		<strong data-role="title"><?php /* @escapeNotVerified */ echo __('Shop By') ?></strong>
-	</div>
-    <div class="block-content filter-content" data-mage-init='{"mpLayer": <?php echo $layerConfig ?>}' >
-        <?php echo $block->getChildHtml('state') ?>
-
-        <?php if ($block->getLayer()->getState()->getFilters()): ?>
-            <div class="block-actions filter-actions">
-                <a href="<?php /* @escapeNotVerified */ echo $block->getClearUrl() ?>" class="action clear filter-clear"><span><?php /* @escapeNotVerified */ echo __('Clear All') ?></span></a>
-            </div>
-        <?php endif; ?>
-
-        <?php $wrapOptions = false; ?>
-        <?php foreach ($filters as $key => $filter): ?>
-            <?php if ($filter->getItemsCount()): ?>
-                <?php if (!$wrapOptions): ?>
-                    <strong role="heading" aria-level="2" class="block-subtitle filter-subtitle"><?php echo __('Shopping Options') ?></strong>
-                    <div class="filter-options" id="narrow-by-list" data-role="content">
-                <?php  $wrapOptions = true; endif; ?>
-                <div data-role="ln_collapsible" class="filter-options-item" attribute="<?php echo $filter->getRequestVar() ?>">
-                    <div data-role="ln_title" class="filter-options-title"><?php /* @escapeNotVerified */ echo __($filter->getName()) ?></div>
-                    <div data-role="ln_content" class="filter-options-content"><?php /* @escapeNotVerified */ echo $block->getChildBlock('renderer')->setFilter($filter)->render($filter); ?></div>
-                </div>
-            <?php endif; ?>
-        <?php endforeach; ?>
-        <?php if ($wrapOptions): ?>
-            </div>
-        <?php else: ?>
-            <script>
-                require([
-                    'jquery'
-                ], function ($) {
-                    $('#layered-filter-block').addClass('filter-no-options');
-                });
-            </script>
-		<?php endif; ?>
-
-        <?php echo $block->getChildHtml('layer_additional_info') ?>
-    </div>
-</div>
-<?php endif; ?>
diff --git a/view/frontend/templates/products.phtml b/view/frontend/templates/products.phtml
index 6616e27..6dbc3f0 100644
--- a/view/frontend/templates/products.phtml
+++ b/view/frontend/templates/products.phtml
@@ -15,11 +15,20 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 ?>
 
-<div id="layer-product-list">
-    <?php echo $block->getChildHtml() ?>
-</div>
+<?php
+/**
+ * Category view template
+ *
+ * @var $block \Magento\Catalog\Block\Category\View
+ */
+?>
+<?php if (!$block->isContentMode() || $block->isMixedMode()): ?>
+    <div id="layer-product-list">
+    <?php echo $block->getProductListHtml() ?>
+    </div>
+<?php endif; ?>
diff --git a/view/frontend/templates/view.phtml b/view/frontend/templates/view.phtml
new file mode 100644
index 0000000..c8ba213
--- /dev/null
+++ b/view/frontend/templates/view.phtml
@@ -0,0 +1,67 @@
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
+?>
+
+<?php if ($block->canShowBlock()): ?>
+<div class="block filter" id="layered-filter-block-container">
+    <div class="block-content filter-content" id="layered-filter-block">
+        <?php echo $block->getChildHtml('state') ?>
+
+        <?php if ($block->getLayer()->getState()->getFilters()): ?>
+            <div class="block-actions filter-actions">
+                <a href="<?php echo $block->getClearUrl() ?>" class="action clear filter-clear"><span><?php echo __('Clear All') ?></span></a>
+            </div>
+        <?php endif; ?>
+
+        <?php $wrapOptions = false; ?>
+        <?php foreach ($block->getFilters() as $key => $filter): ?>
+            <?php if ($filter->getItemsCount()): ?>
+                <?php if (!$wrapOptions): ?>
+                    <strong role="heading" aria-level="2" class="block-subtitle filter-subtitle"><?php echo __('Shopping Options') ?></strong>
+                    <div class="filter-options" id="narrow-by-list">
+                <?php  $wrapOptions = true; endif; ?>
+                <div data-role="ln_collapsible" class="filter-options-item ln-filter-options-item" attribute="<?php echo $filter->getRequestVar() ?>">
+                    <div data-role="ln_title" class="filter-options-title"><?php echo __($filter->getName()) ?></div>
+                    <div data-role="ln_content" class="filter-options-content">
+                        <?php echo $block->getChildHtml('layer_content_before') ?>
+                        <?php echo $block->getChildBlock('renderer')->setFilter($filter)->render($filter); ?>
+                    </div>
+                </div>
+            <?php endif; ?>
+        <?php endforeach; ?>
+        <?php if ($wrapOptions): ?></div><?php endif; ?>
+
+        <?php echo $block->getChildHtml('layer_additional_info') ?>
+    </div>
+    <div id="ln_overlay" class="ln_overlay">
+        <div class="loader">
+            <img src="<?php echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
+        </div>
+    </div>
+    <script type="text/x-magento-init">
+        {
+            "#layered-filter-block": {
+                "mpLayer": <?php echo $this->helper('Mageplaza\LayeredNavigation\Helper\Data')->getLayerConfiguration($block->getFilters()) ?>
+            }
+        }
+    </script>
+</div>
+<?php endif; ?>
diff --git a/view/frontend/web/css/source/_module.less b/view/frontend/web/css/source/_module.less
index bae22d0..c1ed66a 100644
--- a/view/frontend/web/css/source/_module.less
+++ b/view/frontend/web/css/source/_module.less
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -37,7 +37,7 @@
   }
 }
 
-.ln_slider_container {
+.ln_slider_container_price {
   width: calc(100% - 20px);
   margin: 0 15px 0 5px;
 }
\ No newline at end of file
diff --git a/view/frontend/web/js/action/submit-filter.js b/view/frontend/web/js/action/submit-filter.js
index 9f29be0..14cdc1e 100644
--- a/view/frontend/web/js/action/submit-filter.js
+++ b/view/frontend/web/js/action/submit-filter.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -27,13 +27,10 @@ define(
     function ($, storage, loader) {
         'use strict';
 
-        var productContainer = $('#layer-product-list'),
-            layerContainer = $('.layered-filter-block-container');
-
         return function (submitUrl) {
             /** save active state */
             var actives = [];
-            $('.filter-options-item').each(function (index) {
+            $('.ln-filter-options-item').each(function (index) {
                 if ($(this).hasClass('active')) {
                     actives.push($(this).attr('attribute'));
                 }
@@ -55,12 +52,12 @@ define(
                         return;
                     }
                     if (response.navigation) {
-                        layerContainer.html(response.navigation);
-                        layerContainer.trigger('contentUpdated');
+                        $('#layered-filter-block-container').replaceWith(response.navigation);
+                        $('#layered-filter-block-container').trigger('contentUpdated');
                     }
                     if (response.products) {
-                        productContainer.html(response.products);
-                        productContainer.trigger('contentUpdated');
+                        $('#layer-product-list').replaceWith(response.products);
+                        $('#layer-product-list').trigger('contentUpdated');
                     }
                 }
             ).fail(
diff --git a/view/frontend/web/js/model/loader.js b/view/frontend/web/js/model/loader.js
index 46b2640..4160e40 100644
--- a/view/frontend/web/js/model/loader.js
+++ b/view/frontend/web/js/model/loader.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
diff --git a/view/frontend/web/js/view/layer.js b/view/frontend/web/js/view/layer.js
index 795e329..3076418 100644
--- a/view/frontend/web/js/view/layer.js
+++ b/view/frontend/web/js/view/layer.js
@@ -14,7 +14,7 @@
  *
  * @category    Mageplaza
  * @package     Mageplaza_LayeredNavigation
- * @copyright   Copyright (c) 2017 Mageplaza (http://www.mageplaza.com/)
+ * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
  * @license     https://www.mageplaza.com/LICENSE.txt
  */
 
@@ -34,7 +34,6 @@ define([
             collapsible: true,
             multipleCollapsible: true,
             animate: 200,
-            mobileShopbyElement: '#layered-filter-block .filter-title [data-role=title]',
             collapsibleElement: '[data-role=ln_collapsible]',
             header: '[data-role=ln_title]',
             content: '[data-role=ln_content]',
@@ -63,7 +62,7 @@ define([
                 layerActives = window.layerActiveTabs;
             }
             if (layerActives.length) {
-                this.element.find('.filter-options-item').each(function (index) {
+                $('.ln-filter-options-item').each(function (index) {
                     if (~$.inArray($(this).attr('attribute'), layerActives)) {
                         actives.push(index);
                     }
@@ -95,7 +94,7 @@ define([
                         : '';
                 }
                 paramData[paramName] = paramValue;
-                if (paramValue === defaultValue) {
+                if (paramValue == defaultValue) {
                     delete paramData[paramName];
                 }
                 paramData = $.param(paramData);
@@ -107,7 +106,7 @@ define([
             var self = this;
 
             var currentElements = this.element.find('.filter-current a, .filter-actions a');
-            currentElements.each(function (index) {
+            currentElements.each(function(index){
                 var el = $(this),
                     link = self.checkUrl(el.prop('href'));
                 if (!link) {
@@ -131,7 +130,12 @@ define([
 
                 el.bind('click', function (e) {
                     if (el.hasClass('swatch-option-link-layered')) {
-                        self.selectSwatchOption(el);
+                        var childEl = el.find('.swatch-option');
+                        if(childEl.hasClass('selected')){
+                            childEl.removeClass('selected');
+                        } else {
+                            childEl.addClass('selected');
+                        }
                     } else {
                         var checkboxEl = el.find(self.options.checkboxEl);
                         checkboxEl.prop('checked', !checkboxEl.prop('checked'));
@@ -168,15 +172,6 @@ define([
             });
         },
 
-        selectSwatchOption: function (el) {
-            var childEl = el.find('.swatch-option');
-            if (childEl.hasClass('selected')) {
-                childEl.removeClass('selected');
-            } else {
-                childEl.addClass('selected');
-            }
-        },
-
         initSlider: function () {
             var self = this,
                 slider = this.options.slider;
@@ -184,12 +179,11 @@ define([
             for (var code in slider) {
                 if (slider.hasOwnProperty(code)) {
                     var sliderConfig = slider[code],
-                        sliderElement = self.element.find(this.options.sliderElementPrefix + code),
+                        sliderElement = $(this.options.sliderElementPrefix + code),
                         priceFormat = sliderConfig.hasOwnProperty('priceFormat') ? JSON.parse(sliderConfig.priceFormat) : null;
 
                     if (sliderElement.length) {
                         sliderElement.slider({
-                            range: true,
                             min: sliderConfig.minValue,
                             max: sliderConfig.maxValue,
                             values: [sliderConfig.selectedFrom, sliderConfig.selectedTo],
@@ -197,19 +191,22 @@ define([
                                 self.displaySliderText(code, ui.values[0], ui.values[1], priceFormat);
                             },
                             change: function (event, ui) {
-                                self.ajaxSubmit(self.getSliderUrl(sliderConfig.ajaxUrl, ui.values[0], ui.values[1]));
+                                var url = sliderConfig.ajaxUrl.replace(encodeURI('{start}'), ui.values[0])
+                                    .replace(encodeURI('{end}'), ui.values[1]);
+
+                                self.ajaxSubmit(url);
                             }
                         });
+                        self.displaySliderText(code, sliderConfig.selectedFrom, sliderConfig.selectedTo, priceFormat);
                     }
-                    self.displaySliderText(code, sliderConfig.selectedFrom, sliderConfig.selectedTo, priceFormat);
                 }
             }
         },
 
         displaySliderText: function (code, from, to, format) {
-            var textElement = this.element.find(this.options.sliderTextElementPrefix + code);
+            var textElement = $(this.options.sliderTextElementPrefix + code);
             if (textElement.length) {
-                if (format !== null) {
+                if (typeof format !== null) {
                     from = this.formatPrice(from, format);
                     to = this.formatPrice(to, format);
                 }
@@ -218,17 +215,11 @@ define([
             }
         },
 
-        getSliderUrl: function (url, from, to) {
-            return url.replace('from-to', from + '-' + to);
-        },
-
         formatPrice: function (value, format) {
             return ultil.formatPrice(value, format);
         },
 
         ajaxSubmit: function (submitUrl) {
-            this.element.find(this.options.mobileShopbyElement).trigger('click');
-
             return submitFilterAction(submitUrl);
         },
 
