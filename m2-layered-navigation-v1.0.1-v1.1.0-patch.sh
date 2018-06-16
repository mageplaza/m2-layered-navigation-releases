diff --git a/Helper/Data.php b/Helper/Data.php
deleted file mode 100644
index 865d2a8..0000000
--- a/Helper/Data.php
+++ /dev/null
@@ -1,13 +0,0 @@
-<?php
-
-namespace Mageplaza\LayeredNavigation\Helper;
-
-use Mageplaza\Core\Helper\AbstractData;
-
-class Data extends AbstractData
-{
-	public function isEnabled($storeId = null)
-	{
-		return $this->getConfigValue('layered_navigation/general/enable', $storeId);
-	}
-}
diff --git a/Model/Layer/Filter/Attribute.php b/Model/Layer/Filter/Attribute.php
index c775464..0271d33 100644
--- a/Model/Layer/Filter/Attribute.php
+++ b/Model/Layer/Filter/Attribute.php
@@ -1,7 +1,7 @@
 <?php
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
-use Magento\CatalogSearch\Model\Layer\Filter\Attribute as AbstractFilter;
+use Magento\Catalog\Model\Layer\Filter\AbstractFilter;
 
 class Attribute extends AbstractFilter
 {
@@ -10,10 +10,6 @@ class Attribute extends AbstractFilter
      */
     private $tagFilter;
 
-    protected $filterValue = true;
-
-    protected $_moduleHelper;
-
     /**
      * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
      * @param \Magento\Store\Model\StoreManagerInterface $storeManager
@@ -28,7 +24,6 @@ class Attribute extends AbstractFilter
         \Magento\Catalog\Model\Layer $layer,
         \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
         \Magento\Framework\Filter\StripTags $tagFilter,
-        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper,
         array $data = []
     ) {
         parent::__construct(
@@ -36,11 +31,9 @@ class Attribute extends AbstractFilter
             $storeManager,
             $layer,
             $itemDataBuilder,
-            $tagFilter,
             $data
         );
         $this->tagFilter = $tagFilter;
-        $this->_moduleHelper = $moduleHelper;
     }
 
     /**
@@ -52,13 +45,9 @@ class Attribute extends AbstractFilter
      */
     public function apply(\Magento\Framework\App\RequestInterface $request)
     {
-        if(!$this->_moduleHelper->isEnabled()){
-            return parent::apply($request);
-        }
         $attributeValue = $request->getParam($this->_requestVar);
 
         if (empty($attributeValue)) {
-            $this->filterValue = false;
             return $this;
         }
         $attributeValue = explode(',', $attributeValue);
@@ -93,24 +82,11 @@ class Attribute extends AbstractFilter
      */
     protected function _getItemsData()
     {
-        if(!$this->_moduleHelper->isEnabled()){
-            return parent::_getItemsData();
-        }
-
         $attribute = $this->getAttributeModel();
-        /** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
+        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
         $productCollection = $this->getLayer()
             ->getProductCollection();
-
-
-        if($this->filterValue){
-            $productCollectionClone = $productCollection->getCollectionClone();
-            $collection = $productCollectionClone->removeAttributeSearch($attribute->getAttributeCode());
-        } else {
-            $collection = $productCollection;
-        }
-
-        $optionsFacetedData = $collection->getFacetedData($attribute->getAttributeCode());
+        $optionsFacetedData = $productCollection->getFacetedData($attribute->getAttributeCode());
 
         if (count($optionsFacetedData) === 0
             && $this->getAttributeIsFilterable($attribute) !== static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
@@ -118,7 +94,7 @@ class Attribute extends AbstractFilter
             return $this->itemDataBuilder->build();
         }
 
-        $productSize = $collection->getSize();
+        $productSize = $productCollection->getSize();
 
         $options = $attribute->getFrontend()
             ->getSelectOptions();
diff --git a/Model/Layer/Filter/Category.php b/Model/Layer/Filter/Category.php
deleted file mode 100644
index 9f0ffe7..0000000
--- a/Model/Layer/Filter/Category.php
+++ /dev/null
@@ -1,133 +0,0 @@
-<?php
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
-
-use Magento\Catalog\Model\Layer\Filter\AbstractFilter;
-use Magento\Catalog\Model\Layer\Filter\DataProvider\Category as CategoryDataProvider;
-
-/**
- * Layer category filter
- */
-class Category extends AbstractFilter
-{
-    /**
-     * @var \Magento\Framework\Escaper
-     */
-    private $escaper;
-
-    /**
-     * @var CategoryDataProvider
-     */
-    private $dataProvider;
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Catalog\Model\Layer $layer
-     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-     * @param \Magento\Catalog\Model\CategoryFactory $categoryFactory
-     * @param \Magento\Framework\Escaper $escaper
-     * @param CategoryManagerFactory $categoryManager
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-        \Magento\Store\Model\StoreManagerInterface $storeManager,
-        \Magento\Catalog\Model\Layer $layer,
-        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-        \Magento\Framework\Escaper $escaper,
-        \Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory,
-        array $data = []
-    ) {
-        parent::__construct(
-            $filterItemFactory,
-            $storeManager,
-            $layer,
-            $itemDataBuilder,
-            $data
-        );
-        $this->escaper = $escaper;
-        $this->_requestVar = 'cat';
-        $this->dataProvider = $categoryDataProviderFactory->create(['layer' => $this->getLayer()]);
-    }
-
-    /**
-     * Apply category filter to product collection
-     *
-     * @param   \Magento\Framework\App\RequestInterface $request
-     * @return  $this
-     */
-    public function apply(\Magento\Framework\App\RequestInterface $request)
-    {
-        $categoryId = $request->getParam($this->_requestVar) ?: $request->getParam('id');
-        if (empty($categoryId)) {
-            return $this;
-        }
-
-        $this->dataProvider->setCategoryId($categoryId);
-
-        $category = $this->dataProvider->getCategory();
-
-        $this->getLayer()->getProductCollection()->addCategoryFilter($category);
-
-        if ($request->getParam('id') != $category->getId() && $this->dataProvider->isValid()) {
-            $this->getLayer()->getState()->addFilter($this->_createItem($category->getName(), $categoryId));
-        }
-        return $this;
-    }
-
-    /**
-     * Get filter value for reset current filter state
-     *
-     * @return mixed|null
-     */
-    public function getResetValue()
-    {
-        return $this->dataProvider->getResetValue();
-    }
-
-    /**
-     * Get filter name
-     *
-     * @return \Magento\Framework\Phrase
-     */
-    public function getName()
-    {
-        return __('Category');
-    }
-
-    /**
-     * Get data array for building category filter items
-     *
-     * @return array
-     */
-    protected function _getItemsData()
-    {
-        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-        $productCollection = $this->getLayer()->getProductCollection();
-        $optionsFacetedData = $productCollection->getFacetedData('category');
-        $category = $this->dataProvider->getCategory();
-        $categories = $category->getChildrenCategories();
-
-        $collectionSize = $productCollection->getSize();
-
-        if ($category->getIsActive()) {
-            foreach ($categories as $category) {
-                if ($category->getIsActive()
-                    && isset($optionsFacetedData[$category->getId()])
-                    && $this->isOptionReducesResults($optionsFacetedData[$category->getId()]['count'], $collectionSize)
-                ) {
-                    $this->itemDataBuilder->addItemData(
-                        $this->escaper->escapeHtml($category->getName()),
-                        $category->getId(),
-                        $optionsFacetedData[$category->getId()]['count']
-                    );
-                }
-            }
-        }
-        return $this->itemDataBuilder->build();
-    }
-}
diff --git a/Model/Layer/Filter/Decimal.php b/Model/Layer/Filter/Decimal.php
deleted file mode 100644
index d84027c..0000000
--- a/Model/Layer/Filter/Decimal.php
+++ /dev/null
@@ -1,153 +0,0 @@
-<?php
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-namespace Mageplaza\LayerdNavigation\Model\Layer\Filter;
-
-use Magento\Catalog\Model\Layer\Filter\AbstractFilter;
-
-/**
- * Layer decimal filter
- */
-class Decimal extends AbstractFilter
-{
-    /**
-     * @var \Magento\Framework\Pricing\PriceCurrencyInterface
-     */
-    private $priceCurrency;
-
-    /**
-     * @var \Magento\Catalog\Model\ResourceModel\Layer\Filter\Decimal
-     */
-    private $resource;
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Catalog\Model\Layer $layer
-     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-     * @param \Magento\Catalog\Model\ResourceModel\Layer\Filter\DecimalFactory $filterDecimalFactory
-     * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-        \Magento\Store\Model\StoreManagerInterface $storeManager,
-        \Magento\Catalog\Model\Layer $layer,
-        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-        \Magento\Catalog\Model\ResourceModel\Layer\Filter\DecimalFactory $filterDecimalFactory,
-        \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency,
-        array $data = []
-    ) {
-        parent::__construct(
-            $filterItemFactory,
-            $storeManager,
-            $layer,
-            $itemDataBuilder,
-            $data
-        );
-        $this->resource = $filterDecimalFactory->create();
-        $this->priceCurrency = $priceCurrency;
-    }
-
-    /**
-     * Apply price range filter
-     *
-     * @param \Magento\Framework\App\RequestInterface $request
-     * @return $this
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    public function apply(\Magento\Framework\App\RequestInterface $request)
-    {
-        /**
-         * Filter must be string: $fromPrice-$toPrice
-         */
-        $filter = $request->getParam($this->getRequestVar());
-        if (!$filter || is_array($filter)) {
-            return $this;
-        }
-
-        list($from, $to) = explode('-', $filter);
-
-        $this->getLayer()
-            ->getProductCollection()
-            ->addFieldToFilter(
-                $this->getAttributeModel()->getAttributeCode(),
-                ['from' => $from, 'to' => $to]
-            );
-
-        $this->getLayer()->getState()->addFilter(
-            $this->_createItem($this->renderRangeLabel(empty($from) ? 0 : $from, $to), $filter)
-        );
-
-        return $this;
-    }
-
-    /**
-     * Get data array for building attribute filter items
-     *
-     * @return array
-     * @throws \Magento\Framework\Exception\LocalizedException
-     * @SuppressWarnings(PHPMD.NPathComplexity)
-     */
-    protected function _getItemsData()
-    {
-        $attribute = $this->getAttributeModel();
-
-        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-        $productCollection = $this->getLayer()->getProductCollection();
-        $productSize = $productCollection->getSize();
-        $facets = $productCollection->getFacetedData($attribute->getAttributeCode());
-
-        $data = [];
-        foreach ($facets as $key => $aggregation) {
-            $count = $aggregation['count'];
-            if (!$this->isOptionReducesResults($count, $productSize)) {
-                continue;
-            }
-            list($from, $to) = explode('_', $key);
-            if ($from == '*') {
-                $from = '';
-            }
-            if ($to == '*') {
-                $to = '';
-            }
-            $label = $this->renderRangeLabel(
-                empty($from) ? 0 : $from,
-                empty($to) ? $to : $to
-            );
-            $value = $from . '-' . $to;
-
-            $data[] = [
-                'label' => $label,
-                'value' => $value,
-                'count' => $count,
-                'from' => $from,
-                'to' => $to
-            ];
-        }
-
-        return $data;
-    }
-
-    /**
-     * Prepare text of range label
-     *
-     * @param float|string $fromPrice
-     * @param float|string $toPrice
-     * @return \Magento\Framework\Phrase
-     */
-    protected function renderRangeLabel($fromPrice, $toPrice)
-    {
-        $formattedFromPrice = $this->priceCurrency->format($fromPrice);
-        if ($toPrice === '') {
-            return __('%1 and above', $formattedFromPrice);
-        } else {
-            if ($fromPrice != $toPrice) {
-                $toPrice -= .01;
-            }
-            return __('%1 - %2', $formattedFromPrice, $this->priceCurrency->format($toPrice));
-        }
-    }
-}
diff --git a/Model/Layer/Filter/Price.php b/Model/Layer/Filter/Price.php
deleted file mode 100644
index 5f21ec2..0000000
--- a/Model/Layer/Filter/Price.php
+++ /dev/null
@@ -1,173 +0,0 @@
-<?php
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
-
-use Magento\CatalogSearch\Model\Layer\Filter\Price as AbstractFilter;
-
-/**
- * Layer price filter based on Search API
- *
- * @SuppressWarnings(PHPMD.CouplingBetweenObjects)
- */
-class Price extends AbstractFilter
-{
-	/**
-	 * @var \Magento\Catalog\Model\Layer\Filter\DataProvider\Price
-	 */
-	private $dataProvider;
-
-	/**
-	 * @var \Magento\Framework\Pricing\PriceCurrencyInterface
-	 */
-	private $priceCurrency;
-
-	protected $_moduleHelper;
-
-	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-	 * @param \Magento\Catalog\Model\Layer $layer
-	 * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-	 * @param \Magento\Catalog\Model\ResourceModel\Layer\Filter\Price $resource
-	 * @param \Magento\Customer\Model\Session $customerSession
-	 * @param \Magento\Framework\Search\Dynamic\Algorithm $priceAlgorithm
-	 * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
-	 * @param \Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory
-	 * @param \Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory
-	 * @param array $data
-	 * @SuppressWarnings(PHPMD.ExcessiveParameterList)
-	 * @SuppressWarnings(PHPMD.UnusedFormalParameter)
-	 */
-	public function __construct(
-		\Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-		\Magento\Store\Model\StoreManagerInterface $storeManager,
-		\Magento\Catalog\Model\Layer $layer,
-		\Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-		\Magento\Catalog\Model\ResourceModel\Layer\Filter\Price $resource,
-		\Magento\Customer\Model\Session $customerSession,
-		\Magento\Framework\Search\Dynamic\Algorithm $priceAlgorithm,
-		\Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency,
-		\Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory,
-		\Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory,
-		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper,
-		array $data = []
-	)
-	{
-		parent::__construct(
-			$filterItemFactory,
-			$storeManager,
-			$layer,
-			$itemDataBuilder,
-			$resource,
-			$customerSession,
-			$priceAlgorithm,
-			$priceCurrency,
-			$algorithmFactory,
-			$dataProviderFactory,
-			$data
-		);
-
-		$this->priceCurrency = $priceCurrency;
-		$this->dataProvider  = $dataProviderFactory->create(['layer' => $this->getLayer()]);
-		$this->_moduleHelper = $moduleHelper;
-	}
-
-	/**
-	 * Apply price range filter
-	 *
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 * @return $this
-	 * @SuppressWarnings(PHPMD.NPathComplexity)
-	 */
-	public function apply(\Magento\Framework\App\RequestInterface $request)
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return parent::apply($request);
-		}
-		/**
-		 * Filter must be string: $fromPrice-$toPrice
-		 */
-		$filter = $request->getParam($this->getRequestVar());
-		if (!$filter || is_array($filter)) {
-			$this->filterValue = false;
-
-			return $this;
-		}
-
-		$filterParams = explode(',', $filter);
-		$filter       = $this->dataProvider->validateFilter($filterParams[0]);
-		if (!$filter) {
-			$this->filterValue = false;
-
-			return $this;
-		}
-
-		$this->dataProvider->setInterval($filter);
-		$priorFilters = $this->dataProvider->getPriorFilters($filterParams);
-		if ($priorFilters) {
-			$this->dataProvider->setPriorIntervals($priorFilters);
-		}
-
-		list($from, $to) = $filter;
-
-		$this->getLayer()->getProductCollection()->addFieldToFilter(
-			'price',
-			['from' => $from, 'to' => $to]
-		);
-
-		$this->getLayer()->getState()->addFilter(
-			$this->_createItem($this->_renderRangeLabel(empty($from) ? 0 : $from, $to), $filter)
-		);
-
-		return $this;
-	}
-
-	/**
-	 * Prepare text of range label
-	 *
-	 * @param float|string $fromPrice
-	 * @param float|string $toPrice
-	 * @return float|\Magento\Framework\Phrase
-	 */
-	protected function _renderRangeLabel($fromPrice, $toPrice)
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return parent::_renderRangeLabel($fromPrice, $toPrice);
-		}
-		$formattedFromPrice = $this->priceCurrency->format($fromPrice);
-		if ($toPrice === '') {
-			return __('%1 and above', $formattedFromPrice);
-		} elseif ($fromPrice == $toPrice && $this->dataProvider->getOnePriceIntervalValue()) {
-			return $formattedFromPrice;
-		} else {
-			return __('%1 - %2', $formattedFromPrice, $this->priceCurrency->format($toPrice));
-		}
-	}
-
-	/**
-	 * Get data array for building attribute filter items
-	 *
-	 * @return array
-	 *
-	 * @SuppressWarnings(PHPMD.NPathComplexity)
-	 */
-	protected function _getItemsData()
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return parent::_getItemsData();
-		}
-
-		$data = [[
-			'label' => '0-100',
-			'value' => '0-100',
-			'count' => 1,
-			'from'  => '0',
-			'to'    => '100',
-		]];
-
-		return $data;
-	}
-}
diff --git a/Model/ResourceModel/Fulltext/Collection.php b/Model/ResourceModel/Fulltext/Collection.php
index 333ed9f..e06726d 100644
--- a/Model/ResourceModel/Fulltext/Collection.php
+++ b/Model/ResourceModel/Fulltext/Collection.php
@@ -93,8 +93,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	 */
 	private $filterBuilder;
 
-	public $collectionClone = null;
-
 	/**
 	 * @param \Magento\Framework\Data\Collection\EntityFactory $entityFactory
 	 * @param \Psr\Log\LoggerInterface $logger
@@ -151,8 +149,7 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 		\Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
 		$searchRequestName = 'catalog_view_container',
 		SearchResultFactory $searchResultFactory = null
-	)
-	{
+	) {
 		$this->queryFactory = $catalogSearchData;
 		if ($searchResultFactory === null) {
 			$this->searchResultFactory = \Magento\Framework\App\ObjectManager::getInstance()
@@ -180,10 +177,10 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 			$groupManagement,
 			$connection
 		);
-		$this->requestBuilder          = $requestBuilder;
-		$this->searchEngine            = $searchEngine;
+		$this->requestBuilder = $requestBuilder;
+		$this->searchEngine = $searchEngine;
 		$this->temporaryStorageFactory = $temporaryStorageFactory;
-		$this->searchRequestName       = $searchRequestName;
+		$this->searchRequestName = $searchRequestName;
 	}
 
 	/**
@@ -195,7 +192,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 		if ($this->search === null) {
 			$this->search = ObjectManager::getInstance()->get('\Magento\Search\Api\SearchInterface');
 		}
-
 		return $this->search;
 	}
 
@@ -213,55 +209,21 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	 * @deprecated
 	 * @return \Magento\Framework\Api\Search\SearchCriteriaBuilder
 	 */
-	public function getSearchCriteriaBuilder()
+	private function getSearchCriteriaBuilder()
 	{
 		if ($this->searchCriteriaBuilder === null) {
 			$this->searchCriteriaBuilder = ObjectManager::getInstance()
-				->get('\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder');
+				->get('\Magento\Framework\Api\Search\SearchCriteriaBuilder');
 		}
-
 		return $this->searchCriteriaBuilder;
 	}
 
-	public function getCollectionClone()
-	{
-		$collectionClone = clone $this->collectionClone;
-		$collectionClone->setSearchCriteriaBuilder($this->collectionClone->getSearchCriteriaBuilder()->cloneObject());
-
-		return $collectionClone;
-	}
-
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
-	public function removeAttributeSearch($attributeCode)
-	{
-		if(is_array($attributeCode)){
-			foreach($attributeCode as $attCode){
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
 	/**
 	 * @deprecated
 	 * @param \Magento\Framework\Api\Search\SearchCriteriaBuilder $object
 	 * @return void
 	 */
-	public function setSearchCriteriaBuilder(\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object)
+	public function setSearchCriteriaBuilder(\Magento\Framework\Api\Search\SearchCriteriaBuilder $object)
 	{
 		$this->searchCriteriaBuilder = $object;
 	}
@@ -275,7 +237,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 		if ($this->filterBuilder === null) {
 			$this->filterBuilder = ObjectManager::getInstance()->get('\Magento\Framework\Api\FilterBuilder');
 		}
-
 		return $this->filterBuilder;
 	}
 
@@ -324,7 +285,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 				$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
 			}
 		}
-
 		return $this;
 	}
 
@@ -337,7 +297,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	public function addSearchFilter($query)
 	{
 		$this->queryText = trim($this->queryText . ' ' . $query);
-
 		return $this;
 	}
 
@@ -366,11 +325,8 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
 		}
 
-		$this->cloneObject();
-
 		$searchCriteria = $this->searchCriteriaBuilder->create();
 		$searchCriteria->setRequestName($this->searchRequestName);
-
 		try {
 			$this->searchResult = $this->getSearch()->search($searchCriteria);
 		} catch (EmptyRequestDataException $e) {
@@ -382,7 +338,7 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 		}
 
 		$temporaryStorage = $this->temporaryStorageFactory->create();
-		$table            = $temporaryStorage->storeApiDocuments($this->searchResult->getItems());
+		$table = $temporaryStorage->storeApiDocuments($this->searchResult->getItems());
 
 		$this->getSelect()->joinInner(
 			[
@@ -395,9 +351,8 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 		$this->_totalRecords = $this->searchResult->getTotalCount();
 
 		if ($this->order && 'relevance' === $this->order['field']) {
-			$this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
+			$this->getSelect()->order('search_result.'. TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
 		}
-
 		return parent::_renderFiltersBefore();
 	}
 
@@ -407,7 +362,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	protected function _renderFilters()
 	{
 		$this->_filters = [];
-
 		return parent::_renderFilters();
 	}
 
@@ -424,7 +378,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 		if ($attribute != 'relevance') {
 			parent::setOrder($attribute, $dir);
 		}
-
 		return $this;
 	}
 
@@ -456,14 +409,13 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 			$bucket = $aggregations->getBucket($field . RequestGenerator::BUCKET_SUFFIX);
 			if ($bucket) {
 				foreach ($bucket->getValues() as $value) {
-					$metrics                   = $value->getMetrics();
+					$metrics = $value->getMetrics();
 					$result[$metrics['value']] = $metrics;
 				}
 			} else {
 				throw new StateException(__('Bucket does not exist'));
 			}
 		}
-
 		return $result;
 	}
 
@@ -476,7 +428,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	public function addCategoryFilter(\Magento\Catalog\Model\Category $category)
 	{
 		$this->addFieldToFilter('category_ids', $category->getId());
-
 		return parent::addCategoryFilter($category);
 	}
 
@@ -489,7 +440,6 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 	public function setVisibility($visibility)
 	{
 		$this->addFieldToFilter('visibility', $visibility);
-
 		return parent::setVisibility($visibility);
 	}
 }
diff --git a/Model/Search/FilterGroup.php b/Model/Search/FilterGroup.php
deleted file mode 100644
index 26e8484..0000000
--- a/Model/Search/FilterGroup.php
+++ /dev/null
@@ -1,12 +0,0 @@
-<?php
-
-namespace Mageplaza\LayeredNavigation\Model\Search;
-
-use Magento\Framework\Api\Search\FilterGroup as SourceFilterGroup;
-
-/**
- * Groups two or more filters together using a logical OR
- */
-class FilterGroup extends SourceFilterGroup
-{
-}
diff --git a/Model/Search/FilterGroupBuilder.php b/Model/Search/FilterGroupBuilder.php
deleted file mode 100644
index 4c263e6..0000000
--- a/Model/Search/FilterGroupBuilder.php
+++ /dev/null
@@ -1,55 +0,0 @@
-<?php
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-
-namespace Mageplaza\LayeredNavigation\Model\Search;
-
-use Magento\Framework\Api\FilterBuilder;
-use Magento\Framework\Api\ObjectFactory;
-use Magento\Framework\Api\Search\FilterGroupBuilder as SourceFilterGroupBuilder;
-
-/**
- * Builder for FilterGroup Data.
- */
-class FilterGroupBuilder extends SourceFilterGroupBuilder
-{
-	/**
-	 * @param ObjectFactory $objectFactory
-	 * @param FilterBuilder $filterBuilder
-	 */
-	public function __construct(
-		ObjectFactory $objectFactory,
-		FilterBuilder $filterBuilder
-	)
-	{
-		parent::__construct($objectFactory, $filterBuilder);
-	}
-
-	public function setFilterBuilder($filterBuilder)
-	{
-		$this->_filterBuilder = $filterBuilder;
-	}
-
-	public function cloneObject()
-	{
-		$cloneObject = clone $this;
-		$cloneObject->setFilterBuilder(clone $this->_filterBuilder);
-
-		return $cloneObject;
-	}
-
-	public function removeFilter($attributeCode)
-	{
-		if (isset($this->data[FilterGroup::FILTERS])) {
-			foreach ($this->data[FilterGroup::FILTERS] as $key => $filter) {
-				if ($filter->getField() == $attributeCode) {
-					unset($this->data[FilterGroup::FILTERS][$key]);
-				}
-			}
-		}
-
-		return $this;
-	}
-}
diff --git a/Model/Search/SearchCriteria.php b/Model/Search/SearchCriteria.php
deleted file mode 100644
index b7a763a..0000000
--- a/Model/Search/SearchCriteria.php
+++ /dev/null
@@ -1,12 +0,0 @@
-<?php
-
-namespace Mageplaza\LayeredNavigation\Model\Search;
-
-use Magento\Framework\Api\Search\SearchCriteria as SourceSearchCriteria;
-
-/**
- * Groups two or more filters together using a logical OR
- */
-class SearchCriteria extends SourceSearchCriteria
-{
-}
diff --git a/Model/Search/SearchCriteriaBuilder.php b/Model/Search/SearchCriteriaBuilder.php
deleted file mode 100644
index 626affd..0000000
--- a/Model/Search/SearchCriteriaBuilder.php
+++ /dev/null
@@ -1,51 +0,0 @@
-<?php
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-
-namespace Mageplaza\LayeredNavigation\Model\Search;
-
-use Magento\Framework\Api\ObjectFactory;
-use Magento\Framework\Api\SortOrderBuilder;
-use Magento\Framework\Api\Search\SearchCriteriaBuilder as SourceSearchCriteriaBuilder;
-
-/**
- * Builder for SearchCriteria Service Data Object
- */
-class SearchCriteriaBuilder extends SourceSearchCriteriaBuilder
-{
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
-	public function removeFilter($attributeCode)
-	{
-		$this->filterGroupBuilder->removeFilter($attributeCode);
-
-		return $this;
-	}
-
-	public function setFilterGroupBuilder($filterGroupBuilder)
-	{
-		$this->filterGroupBuilder = $filterGroupBuilder;
-	}
-
-	public function cloneObject()
-	{
-		$cloneObject = clone $this;
-		$cloneObject->setFilterGroupBuilder($this->filterGroupBuilder->cloneObject());
-
-		return $cloneObject;
-	}
-}
diff --git a/Plugins/Controller/Category/View.php b/Plugins/Controller/Category/View.php
index ebf0531..6a70ddc 100644
--- a/Plugins/Controller/Category/View.php
+++ b/Plugins/Controller/Category/View.php
@@ -5,19 +5,13 @@ namespace Mageplaza\LayeredNavigation\Plugins\Controller\Category;
 class View
 {
 	protected $_jsonHelper;
-	protected $_moduleHelper;
-
-	public function __construct(
-		\Magento\Framework\Json\Helper\Data $jsonHelper,
-		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	){
+	public function __construct(\Magento\Framework\Json\Helper\Data $jsonHelper){
 		$this->_jsonHelper = $jsonHelper;
-		$this->_moduleHelper = $moduleHelper;
 	}
     public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
 	{
-		if($this->_moduleHelper->isEnabled() && $action->getRequest()->getParam('isAjax')){
-			$navigation = $page->getLayout()->getBlock('catalog.leftnav');
+		if($action->getRequest()->getParam('isAjax')){
+			$navigation = $page->getLayout()->getBlock('catalog.ln.leftnav');
 			$products = $page->getLayout()->getBlock('category.products');
 			$result = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
 			$action->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
diff --git a/Plugins/Model/Layer/Filter/Item.php b/Plugins/Model/Layer/Filter/Item.php
index d80123d..6701987 100644
--- a/Plugins/Model/Layer/Filter/Item.php
+++ b/Plugins/Model/Layer/Filter/Item.php
@@ -6,26 +6,19 @@ class Item
 	protected $_url;
 	protected $_htmlPagerBlock;
 	protected $_request;
-	protected $_moduleHelper;
 
 	public function __construct(
 		\Magento\Framework\UrlInterface $url,
 		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
-		\Magento\Framework\App\RequestInterface $request,
-		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+		\Magento\Framework\App\RequestInterface $request
 	) {
 		$this->_url = $url;
 		$this->_htmlPagerBlock = $htmlPagerBlock;
 		$this->_request = $request;
-		$this->_moduleHelper = $moduleHelper;
 	}
 
     public function aroundGetUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
     {
-		if(!$this->_moduleHelper->isEnabled()){
-			return $proceed();
-		}
-
 		$value = array();
 		$requestVar = $item->getFilter()->getRequestVar();
 		if($requestValue = $this->_request->getParam($requestVar)){
@@ -47,10 +40,6 @@ class Item
 
     public function aroundGetRemoveUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
     {
-		if(!$this->_moduleHelper->isEnabled()){
-			return $proceed();
-		}
-
 		$value = array();
 		$requestVar = $item->getFilter()->getRequestVar();
 		if($requestValue = $this->_request->getParam($requestVar)){
@@ -61,10 +50,6 @@ class Item
 			$value = array_diff($value, array($item->getValue()));
 		}
 
-		if($requestVar == 'price'){
-			$value = [];
-		}
-
         $query = [$requestVar => count($value) ? implode(',', $value) : $item->getFilter()->getResetValue()];
         $params['_current'] = true;
         $params['_use_rewrite'] = true;
diff --git a/README.md b/README.md
index 8190903..00a0341 100644
--- a/README.md
+++ b/README.md
@@ -1,5 +1,2 @@
 How to install: https://docs.mageplaza.com/kb/installation.html
-
-User Guide: https://docs.mageplaza.com/layered-navigation-m2/
-
-Help: http://mageplaza.freshdesk.com/
\ No newline at end of file
+User Guide: https://docs.mageplaza.com/layered-navigation-m2/
\ No newline at end of file
diff --git a/composer.json b/composer.json
index a28d566..241f6fc 100644
--- a/composer.json
+++ b/composer.json
@@ -16,8 +16,8 @@
   ],
   "authors": [
     {
-      "name": "Mageplaza",
-      "email": "hi@mageplaza.com",
+      "name": "Sam",
+      "email": "sam@mageplaza.com",
       "homepage": "https://www.mageplaza.com",
       "role": "Leader"
     }
diff --git a/etc/acl.xml b/etc/acl.xml
deleted file mode 100644
index 9eff352..0000000
--- a/etc/acl.xml
+++ /dev/null
@@ -1,37 +0,0 @@
-<?xml version="1.0"?>
-<!--
-/**
- * Mageplaza_LayeredNavigation extension
- *                     NOTICE OF LICENSE
- * 
- *                     This source file is subject to the Mageplaza License
- *                     that is bundled with this package in the file LICENSE.txt.
- *                     It is also available through the world-wide-web at this URL:
- *                     https://www.mageplaza.com/LICENSE.txt
- * 
- *                     @category  Mageplaza
- *                     @package   Mageplaza_LayeredNavigation
- *                     @copyright Copyright (c) 2016
- *                     @license   https://www.mageplaza.com/LICENSE.txt
- */
--->
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Acl/etc/acl.xsd">
-    <acl>
-        <resources>
-            <resource id="Magento_Backend::admin">
-                <resource id="Mageplaza_Core::menu">
-                    <resource id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" sortOrder="30">
-                        <resource id="Mageplaza_LayeredNavigation::configuration" title="Configuration" sortOrder="10"/>
-                    </resource>
-                </resource>
-                <resource id="Magento_Backend::stores">
-                    <resource id="Magento_Backend::stores_settings">
-                        <resource id="Magento_Config::config">
-                            <resource id="Mageplaza_LayeredNavigation::layered_navigation" title="Layer Navigation"/>
-                        </resource>
-                    </resource>
-                </resource>
-            </resource>
-        </resources>
-    </acl>
-</config>
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
deleted file mode 100644
index 294e7bb..0000000
--- a/etc/adminhtml/menu.xml
+++ /dev/null
@@ -1,7 +0,0 @@
-<?xml version="1.0"?>
-<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
-    <menu>
-        <add id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" module="Mageplaza_LayeredNavigation" sortOrder="100" resource="Mageplaza_LayeredNavigation::layer" parent="Mageplaza_Core::menu"/>
-        <add id="Mageplaza_LayeredNavigation::configuration" title="Configuration" module="Mageplaza_LayeredNavigation" sortOrder="10" action="adminhtml/system_config/edit/section/layered_navigation" resource="Mageplaza_LayeredNavigation::configuration" parent="Mageplaza_LayeredNavigation::layer"/>
-    </menu>
-</config>
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index d2967fe..77e1eb5 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -1,6 +1,9 @@
 <?xml version="1.0"?>
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
     <system>
+        <tab id="mageplaza" translate="label" sortOrder="10">
+            <label>Mageplaza</label>
+        </tab>
         <section id="layered_navigation" translate="label" sortOrder="50" showInDefault="1" showInWebsite="1" showInStore="1">
             <class>separator-top</class>
             <label>Layered Navigation</label>
@@ -8,22 +11,22 @@
             <resource>Mageplaza_LayeredNavigation::layered_navigation</resource>
             <group id="general" translate="label" type="text" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>General Configuration</label>
-
-                <field id="head" translate="label" type="button" sortOrder="1" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <frontend_model>Mageplaza\Core\Block\Adminhtml\System\Config\Head</frontend_model>
-                    <comment><![CDATA[
-                        <ul class="mageplaza-head">
-                            <li><a href="https://docs.mageplaza.com/layered-navigation-m2/" target="_blank">User Guide</a>    </li>
-                            <li><a href="https://mageplaza.freshdesk.com/support/discussions/forums/6000241382" target="_blank">Ask Community</a> </li>
-                            <li><a href="https://mageplaza.freshdesk.com/" target="_blank">Ask Mageplaza</a> </li>
-                            <li><strong><a href="https://www.mageplaza.com/?utm_source=magento2&utm_medium=documents&utm_campaign=layered-navigation" target="_blank">Find more extensions</a></strong> </li>
-                        </ul>
-                        ]]></comment>
-                </field>
                 <field id="enable" translate="label" type="select" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
                     <label>Module Enable</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
+                <field id="allow_multiple" translate="label" type="select" sortOrder="20" showInDefault="1" showInWebsite="1" showInStore="1">
+                    <label>Allow Multiple Filter</label>
+                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                    <comment>Customer can choose multiple options before update the result</comment>
+                </field>
+                <field id="enable_shop_by" translate="label" type="select" sortOrder="30" showInDefault="1" showInWebsite="1" showInStore="1">
+                    <label>Enable Shop By</label>
+                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
+                    <depends>
+                        <field id="allow_multiple">1</field>
+                    </depends>
+                </field>
             </group>
         </section>
     </system>
diff --git a/etc/di.xml b/etc/di.xml
index 25d6974..62a4adc 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -5,9 +5,6 @@
         <arguments>
             <argument name="filters" xsi:type="array">
                 <item name="attribute" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Attribute</item>
-                <item name="price" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Price</item>
-                <!--<item name="decimal" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Decimal</item>-->
-                <!--<item name="category" xsi:type="string">Mageplaza\LayeredNavigation\Model\Layer\Filter\Category</item>-->
             </argument>
         </arguments>
     </virtualType>
diff --git a/etc/module.xml b/etc/module.xml
index 3934127..993e7f9 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -4,7 +4,6 @@
         <sequence>
             <module name="Magento_Catalog"/>
             <module name="Magento_LayeredNavigation"/>
-            <module name="Mageplaza_Core"/>
         </sequence>
     </module>
 </config>
diff --git a/view/adminhtml/web/css/source/_module.less b/view/adminhtml/web/css/source/_module.less
deleted file mode 100644
index 4b675fe..0000000
--- a/view/adminhtml/web/css/source/_module.less
+++ /dev/null
@@ -1,6 +0,0 @@
-.admin__menu #menu-mageplaza-core-menu .item-layer.parent.level-1 > strong:before {
-  content: '\e617';
-  font-family: 'Admin Icons';
-  font-size: 1.5rem;
-  margin-right: .8rem;
-}
\ No newline at end of file
diff --git a/view/frontend/layout/catalog_category_view_type_layered.xml b/view/frontend/layout/catalog_category_view_type_layered.xml
index c7ebc89..082c410 100644
--- a/view/frontend/layout/catalog_category_view_type_layered.xml
+++ b/view/frontend/layout/catalog_category_view_type_layered.xml
@@ -2,18 +2,25 @@
 
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
-        <referenceBlock name="catalog.leftnav">
-            <action method="setTemplate" ifconfig="layered_navigation/general/enable">
-                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::view.phtml</argument>
-            </action>
-        </referenceBlock>
-        <referenceBlock name="catalog.navigation.renderer">
-            <action method="setTemplate" ifconfig="layered_navigation/general/enable">
-                <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::filter.phtml</argument>
-            </action>
-        </referenceBlock>
+        <referenceContainer name="sidebar.main">
+            <referenceBlock name="catalog.leftnav" remove="true"/>
+            <block class="Magento\LayeredNavigation\Block\Navigation\Category" name="catalog.ln.leftnav" before="-" template="Mageplaza_LayeredNavigation::view.phtml">
+                <block class="Magento\LayeredNavigation\Block\Navigation\State" name="catalog.navigation.state" as="state" />
+                <block class="Magento\LayeredNavigation\Block\Navigation\FilterRenderer" name="catalog.navigation.renderer" as="renderer" template="Mageplaza_LayeredNavigation::filter.phtml"/>
+            </block>
+        </referenceContainer>
+        <!--<referenceBlock name="catalog.leftnav">-->
+            <!--<action method="setTemplate">-->
+                <!--<argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::view.phtml</argument>-->
+            <!--</action>-->
+        <!--</referenceBlock>-->
+        <!--<referenceBlock name="catalog.navigation.renderer">-->
+            <!--<action method="setTemplate">-->
+                <!--<argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::filter.phtml</argument>-->
+            <!--</action>-->
+        <!--</referenceBlock>-->
         <referenceBlock name="category.products">
-            <action method="setTemplate" ifconfig="layered_navigation/general/enable">
+            <action method="setTemplate">
                 <argument name="template" xsi:type="string">Mageplaza_LayeredNavigation::products.phtml</argument>
             </action>
         </referenceBlock>
diff --git a/view/frontend/templates/filter.phtml b/view/frontend/templates/filter.phtml
index 7450b30..d50f734 100644
--- a/view/frontend/templates/filter.phtml
+++ b/view/frontend/templates/filter.phtml
@@ -12,13 +12,8 @@
             <?php if($attributeModel && $attributeModel->getFrontendInput() == 'price'): ?>
                 <?php
                     $productCollection = $filter->getLayer()->getProductCollection();
-                    $productCollectionClone = $productCollection->getCollectionClone();
-                    $collection = $productCollectionClone
-                        ->removeAttributeSearch(['price.from', 'price.to']);
-
-                    $min = $collection->getMinPrice();
-                    $max = $collection->getMaxPrice();
-
+                    $min = $productCollection->getMinPrice();
+                    $max = $productCollection->getMaxPrice();
                     list($from, $to) = $requestValue ? explode('-', $requestValue) : [$min, $max];
                 ?>
                 <div id="ln_price_attribute">
diff --git a/view/frontend/web/js/layer.js b/view/frontend/web/js/layer.js
index 8e7bc33..ddd3228 100644
--- a/view/frontend/web/js/layer.js
+++ b/view/frontend/web/js/layer.js
@@ -6,7 +6,7 @@ define([
     'jquery',
     'jquery/ui',
     'productListToolbarForm'
-], function ($) {
+], function($) {
     "use strict";
 
     $.widget('mageplaza.layer', {
@@ -16,13 +16,13 @@ define([
             navigationSelector: '#layered-filter-block'
         },
 
-        _create: function () {
+        _create: function() {
             this.initProductListUrl();
             this.initObserve();
             this.initLoading();
         },
 
-        initProductListUrl: function () {
+        initProductListUrl: function(){
             var self = this;
             $.mage.productListToolbarForm.prototype.changeUrl = function (paramName, paramValue, defaultValue) {
                 var urlPaths = this.options.url.split('?'),
@@ -46,16 +46,14 @@ define([
             }
         },
 
-        initObserve: function () {
+        initObserve: function(){
             var self = this;
             var aElements = this.element.find('a');
-            aElements.each(function (index) {
+            aElements.each(function(index){
                 var el = $(this);
-                var link = self.checkUrl(el.prop('href'));
-                if(!link) return;
-
-                el.bind('click', function (e) {
-                    if (el.hasClass('swatch-option-link-layered')) {
+                var link = el.prop('href');
+                el.bind('click', function(e){
+                    if(el.hasClass('swatch-option-link-layered')){
                         var childEl = el.find('.swatch-option');
                         childEl.addClass('selected');
                     } else {
@@ -69,42 +67,30 @@ define([
                 });
 
                 var checkbox = el.find('input[type=checkbox]');
-                checkbox.bind('click', function (e) {
+                checkbox.bind('click', function(e){
                     self.ajaxSubmit(link);
                     e.stopPropagation();
                 });
             });
 
-            $(".filter-current a").bind('click', function (e) {
-                var link = self.checkUrl($(this).prop('href'));
-                if(!link) return;
-
-                self.ajaxSubmit(link);
+            $(".filter-current a").bind('click', function(e){
+                self.ajaxSubmit($(this).prop('href'));
                 e.stopPropagation();
                 e.preventDefault();
             });
 
-            $(".filter-actions a").bind('click', function (e) {
-                var link = self.checkUrl($(this).prop('href'));
-                if(!link) return;
-
-                self.ajaxSubmit(link);
+            $(".filter-actions a").bind('click', function(e){
+                self.ajaxSubmit($(this).prop('href'));
                 e.stopPropagation();
                 e.preventDefault();
             });
         },
 
-        checkUrl: function (url) {
-            var regex = /(http|https):\/\/(\w+:{0,1}\w*)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%!\-\/]))?/;
-
-            return regex.test(url) ? url : null;
-        },
-
-        initLoading: function () {
+        initLoading: function(){
 
         },
 
-        ajaxSubmit: function (submitUrl) {
+        ajaxSubmit: function(submitUrl) {
             var self = this;
 
             $.ajax({
@@ -112,13 +98,13 @@ define([
                 data: {isAjax: 1},
                 type: 'post',
                 dataType: 'json',
-                beforeSend: function () {
+                beforeSend: function() {
                     $('.ln_overlay').show();
                     if (typeof window.history.pushState === 'function') {
                         window.history.pushState({url: submitUrl}, '', submitUrl);
                     }
                 },
-                success: function (res) {
+                success: function(res) {
                     if (res.backUrl) {
                         window.location = res.backUrl;
                         return;
@@ -133,7 +119,7 @@ define([
                     }
                     $('.ln_overlay').hide();
                 },
-                error: function () {
+                error: function(){
                     window.location.reload();
                 }
             });
