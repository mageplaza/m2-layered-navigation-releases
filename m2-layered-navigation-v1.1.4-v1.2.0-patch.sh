diff --git a/Helper/Data.php b/Helper/Data.php
index a06f006..2a302bf 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -1,66 +1,32 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Helper;
 
 use Mageplaza\Core\Helper\AbstractData;
 
-/**
- * Class Data
- * @package Mageplaza\LayeredNavigation\Helper
- */
 class Data extends AbstractData
 {
 
-	/**
-	 * @param null $storeId
-	 *
-	 * @return mixed
-	 */
+    /**
+     * @param null $storeId
+     *
+     * @return mixed
+     */
 	public function isEnabled($storeId = null)
 	{
 		return $this->getConfigValue('layered_navigation/general/enable', $storeId);
 	}
-
-	/**
-	 * @param string $code
-	 * @param null $storeId
-	 * @return mixed
-	 */
-	public function getGeneralConfig($code = '', $storeId = null)
-	{
-		$code = ($code !== '') ? '/' . $code : '';
-
-		return $this->getConfigValue('layered_navigation/general' . $code, $storeId);
-	}
-
-	/**
-	 * @param string $code
-	 * @param null $storeId
-	 * @return mixed
-	 */
-	public function getDisplayConfig($code = '', $storeId = null)
-	{
-		$code = ($code !== '') ? '/' . $code : '';
-
-		return $this->getConfigValue('layered_navigation/display' . $code, $storeId);
-	}
 }
diff --git a/Model/Config/Source/ActiveFilter.php b/Model/Config/Source/ActiveFilter.php
deleted file mode 100644
index 49aef77..0000000
--- a/Model/Config/Source/ActiveFilter.php
+++ /dev/null
@@ -1,43 +0,0 @@
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
-
-namespace Mageplaza\LayeredNavigation\Model\Config\Source;
-
-use Magento\Framework\Model\AbstractModel;
-
-class ActiveFilter extends AbstractModel
-{
-	const SHOW_NONE = 0;
-	const SHOW_ACTIVE = 1;
-	const SHOW_ALL = 2;
-
-	/**
-	 * @return array
-	 */
-	public function toOptionArray()
-	{
-		return [
-			self::SHOW_NONE   => __('No'),
-			self::SHOW_ACTIVE => __('Open Active'),
-			self::SHOW_ALL    => __('Open All')
-		];
-	}
-}
\ No newline at end of file
diff --git a/Model/Layer/Filter/Attribute.php b/Model/Layer/Filter/Attribute.php
index 10a394e..4c6869f 100644
--- a/Model/Layer/Filter/Attribute.php
+++ b/Model/Layer/Filter/Attribute.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Attribute as AbstractFilter;
@@ -72,7 +66,7 @@ class Attribute extends AbstractFilter
      */
     public function apply(\Magento\Framework\App\RequestInterface $request)
     {
-        if (!$this->_moduleHelper->isEnabled()) {
+        if(!$this->_moduleHelper->isEnabled()){
             return parent::apply($request);
         }
         $attributeValue = $request->getParam($this->_requestVar);
@@ -86,22 +80,18 @@ class Attribute extends AbstractFilter
         /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
         $productCollection = $this->getLayer()
             ->getProductCollection();
-        if (count($attributeValue) > 1) {
-            $productCollection->addFieldToFilter($attribute->getAttributeCode(), ['in' => $attributeValue]);
+        if(sizeof($attributeValue) > 1){
+			$productCollection->addFieldToFilter($attribute->getAttributeCode(), array('in' => $attributeValue));
         } else {
             $productCollection->addFieldToFilter($attribute->getAttributeCode(), $attributeValue[0]);
         }
 
         $state = $this->getLayer()->getState();
-        foreach ($attributeValue as $value) {
+        foreach($attributeValue as $value){
             $label = $this->getOptionText($value);
             $state->addFilter($this->_createItem($label, $value));
         }
 
-        if(!$this->_moduleHelper->getGeneralConfig('allow_multiple')){
-            $this->setItems([]); // set items to disable show filtering
-        }
-
         return $this;
     }
 
@@ -113,7 +103,7 @@ class Attribute extends AbstractFilter
      */
     protected function _getItemsData()
     {
-        if (!$this->_moduleHelper->isEnabled()) {
+        if(!$this->_moduleHelper->isEnabled()){
             return parent::_getItemsData();
         }
 
@@ -122,7 +112,8 @@ class Attribute extends AbstractFilter
         $productCollection = $this->getLayer()
             ->getProductCollection();
 
-        if ($this->filterValue && $this->_moduleHelper->getGeneralConfig('allow_multiple')) {
+
+        if($this->filterValue){
             $productCollectionClone = $productCollection->getCollectionClone();
             $collection = $productCollectionClone->removeAttributeSearch($attribute->getAttributeCode());
         } else {
@@ -141,7 +132,6 @@ class Attribute extends AbstractFilter
 
         $itemData = [];
         $checkCount = false;
-        $isShowZeroAttribute = $this->_moduleHelper->getDisplayConfig('show_zero');
 
         $options = $attribute->getFrontend()
             ->getSelectOptions();
@@ -155,12 +145,13 @@ class Attribute extends AbstractFilter
             $count = isset($optionsFacetedData[$value]['count'])
                 ? (int)$optionsFacetedData[$value]['count']
                 : 0;
-            if ($count > 0) {
+            if($count > 0){
                 $checkCount = true;
             }
             // Check filter type
-            if ($this->getAttributeIsFilterable($attribute) === static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
-                && (!$this->isOptionReducesResults($count, $productSize) || ($count === 0 && !$isShowZeroAttribute))
+            if (
+                $this->getAttributeIsFilterable($attribute) === static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
+                && (!$this->isOptionReducesResults($count, $productSize))// || $count === 0)
             ) {
                 continue;
             }
@@ -172,7 +163,7 @@ class Attribute extends AbstractFilter
             ];
         }
 
-        if ($checkCount) {
+        if($checkCount) {
             foreach ($itemData as $value) {
                 $this->itemDataBuilder->addItemData($value[0], $value[1], $value[2]);
             }
diff --git a/Model/Layer/Filter/Category.php b/Model/Layer/Filter/Category.php
index aed4669..afcf63d 100644
--- a/Model/Layer/Filter/Category.php
+++ b/Model/Layer/Filter/Category.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\Catalog\Model\Layer\Filter\AbstractFilter;
diff --git a/Model/Layer/Filter/Decimal.php b/Model/Layer/Filter/Decimal.php
index caf58e6..1521359 100644
--- a/Model/Layer/Filter/Decimal.php
+++ b/Model/Layer/Filter/Decimal.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayerdNavigation\Model\Layer\Filter;
 
 use Magento\Catalog\Model\Layer\Filter\AbstractFilter;
diff --git a/Model/Layer/Filter/Price.php b/Model/Layer/Filter/Price.php
index f85ad30..31b86ca 100644
--- a/Model/Layer/Filter/Price.php
+++ b/Model/Layer/Filter/Price.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Price as AbstractFilter;
@@ -40,14 +34,6 @@ class Price extends AbstractFilter
 	 */
 	private $priceCurrency;
 
-	/**
-	 * @type
-	 */
-	protected $filterValue;
-
-	/**
-	 * @type \Mageplaza\LayeredNavigation\Helper\Data
-	 */
 	protected $_moduleHelper;
 
 	/**
@@ -120,6 +106,7 @@ class Price extends AbstractFilter
 
 			return $this;
 		}
+
 		$filterParams = explode(',', $filter);
 		$filter       = $this->dataProvider->validateFilter($filterParams[0]);
 		if (!$filter) {
@@ -134,7 +121,6 @@ class Price extends AbstractFilter
 			$this->dataProvider->setPriorIntervals($priorFilters);
 		}
 
-		$this->filterValue = $filter;
 		list($from, $to) = $filter;
 
 		$this->getLayer()->getProductCollection()->addFieldToFilter(
@@ -184,44 +170,14 @@ class Price extends AbstractFilter
 			return parent::_getItemsData();
 		}
 
-		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-		$productCollection      = $this->getLayer()->getProductCollection();
-		$productCollectionClone = $productCollection->getCollectionClone();
-		$collection             = $productCollectionClone
-			->removeAttributeSearch(['price.from', 'price.to']);
-
-		$min = $collection->getMinPrice();
-		$max = $collection->getMaxPrice();
-		list($from, $to) = $this->filterValue ?: [$min, $max];
-
-		return [[
-			'label'       => __('Price Slider'),
-			'value'       => $from . '-' . $to,
-			'count'       => 1,
-			'filter_type' => 'slider',
-			'min'         => $min,
-			'max'         => $max,
-			'from'        => $from,
-			'to'          => $to
+		$data = [[
+			'label' => '0-100',
+			'value' => '0-100',
+			'count' => 1,
+			'from'  => '0',
+			'to'    => '100',
 		]];
-	}
 
-	/**
-	 * Initialize filter items
-	 *
-	 * @return  \Magento\Catalog\Model\Layer\Filter\AbstractFilter
-	 */
-	protected function _initItems()
-	{
-		$data  = $this->_getItemsData();
-		$items = [];
-		foreach ($data as $itemData) {
-			$item = $this->_createItem($itemData['label'], $itemData['value'], $itemData['count']);
-			$item->addData($itemData);
-			$items[] = $item;
-		}
-		$this->_items = $items;
-
-		return $this;
+		return $data;
 	}
 }
diff --git a/Model/ResourceModel/Fulltext/Collection.php b/Model/ResourceModel/Fulltext/Collection.php
index 9c9eccc..d449230 100644
--- a/Model/ResourceModel/Fulltext/Collection.php
+++ b/Model/ResourceModel/Fulltext/Collection.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext;
 
 use Magento\CatalogSearch\Model\Search\RequestGenerator;
@@ -38,481 +32,470 @@ use Magento\Framework\App\ObjectManager;
  */
 class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 {
-    /**
-     * @var  QueryResponse
-     * @deprecated
-     */
-    protected $queryResponse;
-
-    /**
-     * Catalog search data
-     *
-     * @var \Magento\Search\Model\QueryFactory
-     * @deprecated
-     */
-    protected $queryFactory = null;
-
-    /**
-     * @var \Magento\Framework\Search\Request\Builder
-     * @deprecated
-     */
-    private $requestBuilder;
-
-    /**
-     * @var \Magento\Search\Model\SearchEngine
-     * @deprecated
-     */
-    private $searchEngine;
-
-    /**
-     * @var string
-     */
-    private $queryText;
-
-    /**
-     * @var string|null
-     */
-    private $order = null;
-
-    /**
-     * @var string
-     */
-    private $searchRequestName;
-
-    /**
-     * @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory
-     */
-    private $temporaryStorageFactory;
-
-    /**
-     * @var \Magento\Search\Api\SearchInterface
-     */
-    private $search;
-
-    /**
-     * @var \Magento\Framework\Api\Search\SearchCriteriaBuilder
-     */
-    private $searchCriteriaBuilder;
-
-    /**
-     * @var \Magento\Framework\Api\Search\SearchResultInterface
-     */
-    private $searchResult;
-
-    /**
-     * @var SearchResultFactory
-     */
-    private $searchResultFactory;
-
-    /**
-     * @var \Magento\Framework\Api\FilterBuilder
-     */
-    private $filterBuilder;
-
-    /**
-     * @type null
-     */
-    public $collectionClone = null;
-
-    /**
-     * @param \Magento\Framework\Data\Collection\EntityFactory $entityFactory
-     * @param \Psr\Log\LoggerInterface $logger
-     * @param \Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy
-     * @param \Magento\Framework\Event\ManagerInterface $eventManager
-     * @param \Magento\Eav\Model\Config $eavConfig
-     * @param \Magento\Framework\App\ResourceConnection $resource
-     * @param \Magento\Eav\Model\EntityFactory $eavEntityFactory
-     * @param \Magento\Catalog\Model\ResourceModel\Helper $resourceHelper
-     * @param \Magento\Framework\Validator\UniversalFactory $universalFactory
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Framework\Module\Manager $moduleManager
-     * @param \Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState
-     * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
-     * @param \Magento\Catalog\Model\Product\OptionFactory $productOptionFactory
-     * @param \Magento\Catalog\Model\ResourceModel\Url $catalogUrl
-     * @param \Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate
-     * @param \Magento\Customer\Model\Session $customerSession
-     * @param \Magento\Framework\Stdlib\DateTime $dateTime
-     * @param \Magento\Customer\Api\GroupManagementInterface $groupManagement
-     * @param \Magento\Search\Model\QueryFactory $catalogSearchData
-     * @param \Magento\Framework\Search\Request\Builder $requestBuilder
-     * @param \Magento\Search\Model\SearchEngine $searchEngine
-     * @param \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory
-     * @param \Magento\Framework\DB\Adapter\AdapterInterface $connection
-     * @param string $searchRequestName
-     * @param SearchResultFactory $searchResultFactory
-     * @SuppressWarnings(PHPMD.ExcessiveParameterList)
-     */
-    public function __construct(
-        \Magento\Framework\Data\Collection\EntityFactory $entityFactory,
-        \Psr\Log\LoggerInterface $logger,
-        \Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy,
-        \Magento\Framework\Event\ManagerInterface $eventManager,
-        \Magento\Eav\Model\Config $eavConfig,
-        \Magento\Framework\App\ResourceConnection $resource,
-        \Magento\Eav\Model\EntityFactory $eavEntityFactory,
-        \Magento\Catalog\Model\ResourceModel\Helper $resourceHelper,
-        \Magento\Framework\Validator\UniversalFactory $universalFactory,
-        \Magento\Store\Model\StoreManagerInterface $storeManager,
-        \Magento\Framework\Module\Manager $moduleManager,
-        \Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState,
-        \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
-        \Magento\Catalog\Model\Product\OptionFactory $productOptionFactory,
-        \Magento\Catalog\Model\ResourceModel\Url $catalogUrl,
-        \Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate,
-        \Magento\Customer\Model\Session $customerSession,
-        \Magento\Framework\Stdlib\DateTime $dateTime,
-        \Magento\Customer\Api\GroupManagementInterface $groupManagement,
-        \Magento\Search\Model\QueryFactory $catalogSearchData,
-        \Magento\Framework\Search\Request\Builder $requestBuilder,
-        \Magento\Search\Model\SearchEngine $searchEngine,
-        \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory,
-        \Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
-        $searchRequestName = 'catalog_view_container',
-        SearchResultFactory $searchResultFactory = null
-    ) {
-    
-        $this->queryFactory = $catalogSearchData;
-        if ($searchResultFactory === null) {
-            $this->searchResultFactory = \Magento\Framework\App\ObjectManager::getInstance()
-                ->get('Magento\Framework\Api\Search\SearchResultFactory');
-        }
-        parent::__construct(
-            $entityFactory,
-            $logger,
-            $fetchStrategy,
-            $eventManager,
-            $eavConfig,
-            $resource,
-            $eavEntityFactory,
-            $resourceHelper,
-            $universalFactory,
-            $storeManager,
-            $moduleManager,
-            $catalogProductFlatState,
-            $scopeConfig,
-            $productOptionFactory,
-            $catalogUrl,
-            $localeDate,
-            $customerSession,
-            $dateTime,
-            $groupManagement,
-            $connection
-        );
-        $this->requestBuilder          = $requestBuilder;
-        $this->searchEngine            = $searchEngine;
-        $this->temporaryStorageFactory = $temporaryStorageFactory;
-        $this->searchRequestName       = $searchRequestName;
-    }
-
-    /**
-     * @deprecated
-     * @return \Magento\Search\Api\SearchInterface
-     */
-    private function getSearch()
-    {
-        if ($this->search === null) {
-            $this->search = ObjectManager::getInstance()->get('\Magento\Search\Api\SearchInterface');
-        }
-
-        return $this->search;
-    }
-
-    /**
-     * @deprecated
-     * @param \Magento\Search\Api\SearchInterface $object
-     * @return void
-     */
-    public function setSearch(\Magento\Search\Api\SearchInterface $object)
-    {
-        $this->search = $object;
-    }
-
-    /**
-     * @deprecated
-     * @return \Magento\Framework\Api\Search\SearchCriteriaBuilder
-     */
-    public function getSearchCriteriaBuilder()
-    {
-        if ($this->searchCriteriaBuilder === null) {
-            $this->searchCriteriaBuilder = ObjectManager::getInstance()
-                ->get('\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder');
-        }
-
-        return $this->searchCriteriaBuilder;
-    }
-
-    /**
-     * @return null
-     */
-    public function getCollectionClone()
-    {
-        $collectionClone = clone $this->collectionClone;
-        $collectionClone->setSearchCriteriaBuilder($this->collectionClone->getSearchCriteriaBuilder()->cloneObject());
-
-        return $collectionClone;
-    }
-
-    /**
-     * @return $this
-     */
-    public function cloneObject()
-    {
-        if ($this->collectionClone === null) {
-            $this->collectionClone = clone $this;
-            $this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
-        }
-
-        return $this;
-    }
-
-    /**
-     * @param $attributeCode
-     * @return $this
-     */
-    public function removeAttributeSearch($attributeCode)
-    {
-        if (is_array($attributeCode)) {
-            foreach ($attributeCode as $attCode) {
-                $this->searchCriteriaBuilder->removeFilter($attCode);
-            }
-        } else {
-            $this->searchCriteriaBuilder->removeFilter($attributeCode);
-        }
-
-        $this->_isFiltersRendered = false;
-
-        return $this->loadWithFilter();
-    }
-
-    /**
-     * @param \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object
-     */
-    public function setSearchCriteriaBuilder(\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object)
-    {
-        $this->searchCriteriaBuilder = $object;
-    }
-
-    /**
-     * @deprecated
-     * @return \Magento\Framework\Api\FilterBuilder
-     */
-    private function getFilterBuilder()
-    {
-        if ($this->filterBuilder === null) {
-            $this->filterBuilder = ObjectManager::getInstance()->get('\Magento\Framework\Api\FilterBuilder');
-        }
-
-        return $this->filterBuilder;
-    }
-
-    /**
-     * @deprecated
-     * @param \Magento\Framework\Api\FilterBuilder $object
-     * @return void
-     */
-    public function setFilterBuilder(\Magento\Framework\Api\FilterBuilder $object)
-    {
-        $this->filterBuilder = $object;
-    }
-
-    /**
-     * Apply attribute filter to facet collection
-     *
-     * @param string $field
-     * @param null $condition
-     * @return $this
-     */
-    public function addFieldToFilter($field, $condition = null)
-    {
-        if ($this->searchResult !== null) {
-            throw new \RuntimeException('Illegal state');
-        }
-
-        $this->getSearchCriteriaBuilder();
-        $this->getFilterBuilder();
-        if (!is_array($condition) || !in_array(key($condition), ['from', 'to'])) {
-            $this->filterBuilder->setField($field);
-            $this->filterBuilder->setValue($condition);
-            $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-        } else {
-            if (!empty($condition['from'])) {
-                $this->filterBuilder->setField("{$field}.from");
-                $this->filterBuilder->setValue($condition['from']);
-                $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-            }
-            if (!empty($condition['to'])) {
-                $this->filterBuilder->setField("{$field}.to");
-                $this->filterBuilder->setValue($condition['to']);
-                $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-            }
-        }
-
-        return $this;
-    }
-
-    /**
-     * Add search query filter
-     *
-     * @param string $query
-     * @return $this
-     */
-    public function addSearchFilter($query)
-    {
-        $this->queryText = trim($this->queryText . ' ' . $query);
-
-        return $this;
-    }
-
-    /**
-     * @inheritdoc
-     */
-    protected function _renderFiltersBefore()
-    {
-        $this->getSearchCriteriaBuilder();
-        $this->getFilterBuilder();
-        $this->getSearch();
-
-        if ($this->queryText) {
-            $this->filterBuilder->setField('search_term');
-            $this->filterBuilder->setValue($this->queryText);
-            $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-        }
-
-        $priceRangeCalculation = $this->_scopeConfig->getValue(
-            \Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory::XML_PATH_RANGE_CALCULATION,
-            \Magento\Store\Model\ScopeInterface::SCOPE_STORE
-        );
-        if ($priceRangeCalculation) {
-            $this->filterBuilder->setField('price_dynamic_algorithm');
-            $this->filterBuilder->setValue($priceRangeCalculation);
-            $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-        }
-
-        $this->cloneObject();
-
-        $searchCriteria = $this->searchCriteriaBuilder->create();
-        $searchCriteria->setRequestName($this->searchRequestName);
-
-        try {
-            $this->searchResult = $this->getSearch()->search($searchCriteria);
-        } catch (EmptyRequestDataException $e) {
-            /** @var \Magento\Framework\Api\Search\SearchResultInterface $searchResult */
-            $this->searchResult = $this->searchResultFactory->create()->setItems([]);
-        } catch (NonExistingRequestNameException $e) {
-            $this->_logger->error($e->getMessage());
-            throw new LocalizedException(__('Sorry, something went wrong. You can find out more in the error log.'));
-        }
-
-        $temporaryStorage = $this->temporaryStorageFactory->create();
-        $table            = $temporaryStorage->storeApiDocuments($this->searchResult->getItems());
-
-        $this->getSelect()->joinInner(
-            [
-                'search_result' => $table->getName(),
-            ],
-            'e.entity_id = search_result.' . TemporaryStorage::FIELD_ENTITY_ID,
-            []
-        );
-
-        $this->_totalRecords = $this->searchResult->getTotalCount();
-
-        if ($this->order && 'relevance' === $this->order['field']) {
-            $this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
-        }
-
-        return parent::_renderFiltersBefore();
-    }
-
-    /**
-     * @return $this
-     */
-    protected function _renderFilters()
-    {
-        $this->_filters = [];
-
-        return parent::_renderFilters();
-    }
-
-    /**
-     * Set Order field
-     *
-     * @param string $attribute
-     * @param string $dir
-     * @return $this
-     */
-    public function setOrder($attribute, $dir = Select::SQL_DESC)
-    {
-        $this->order = ['field' => $attribute, 'dir' => $dir];
-        if ($attribute != 'relevance') {
-            parent::setOrder($attribute, $dir);
-        }
-
-        return $this;
-    }
-
-    /**
-     * Stub method for compatibility with other search engines
-     *
-     * @return $this
-     */
-    public function setGeneralDefaultQuery()
-    {
-        return $this;
-    }
-
-    /**
-     * Return field faceted data from faceted search result
-     *
-     * @param string $field
-     * @return array
-     * @throws StateException
-     */
-    public function getFacetedData($field)
-    {
-        $this->_renderFilters();
-        $result = [];
-
-        $aggregations = $this->searchResult->getAggregations();
-        // This behavior is for case with empty object when we got EmptyRequestDataException
-        if (null !== $aggregations) {
-            $bucket = $aggregations->getBucket($field . RequestGenerator::BUCKET_SUFFIX);
-            if ($bucket) {
-                foreach ($bucket->getValues() as $value) {
-                    $metrics                   = $value->getMetrics();
-                    $result[$metrics['value']] = $metrics;
-                }
-            } else {
-                throw new StateException(__('Bucket does not exist'));
-            }
-        }
-
-        return $result;
-    }
-
-    /**
-     * Specify category filter for product collection
-     *
-     * @param \Magento\Catalog\Model\Category $category
-     * @return $this
-     */
-    public function addCategoryFilter(\Magento\Catalog\Model\Category $category)
-    {
-        $this->addFieldToFilter('category_ids', $category->getId());
-
-        return parent::addCategoryFilter($category);
-    }
-
-    /**
-     * Set product visibility filter for enabled products
-     *
-     * @param array $visibility
-     * @return $this
-     */
-    public function setVisibility($visibility)
-    {
-        $this->addFieldToFilter('visibility', $visibility);
-
-        return parent::setVisibility($visibility);
-    }
+	/**
+	 * @var  QueryResponse
+	 * @deprecated
+	 */
+	protected $queryResponse;
+
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
+	private $queryText;
+
+	/**
+	 * @var string|null
+	 */
+	private $order = null;
+
+	/**
+	 * @var string
+	 */
+	private $searchRequestName;
+
+	/**
+	 * @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory
+	 */
+	private $temporaryStorageFactory;
+
+	/**
+	 * @var \Magento\Search\Api\SearchInterface
+	 */
+	private $search;
+
+	/**
+	 * @var \Magento\Framework\Api\Search\SearchCriteriaBuilder
+	 */
+	private $searchCriteriaBuilder;
+
+	/**
+	 * @var \Magento\Framework\Api\Search\SearchResultInterface
+	 */
+	private $searchResult;
+
+	/**
+	 * @var SearchResultFactory
+	 */
+	private $searchResultFactory;
+
+	/**
+	 * @var \Magento\Framework\Api\FilterBuilder
+	 */
+	private $filterBuilder;
+
+	public $collectionClone = null;
+
+	/**
+	 * @param \Magento\Framework\Data\Collection\EntityFactory $entityFactory
+	 * @param \Psr\Log\LoggerInterface $logger
+	 * @param \Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy
+	 * @param \Magento\Framework\Event\ManagerInterface $eventManager
+	 * @param \Magento\Eav\Model\Config $eavConfig
+	 * @param \Magento\Framework\App\ResourceConnection $resource
+	 * @param \Magento\Eav\Model\EntityFactory $eavEntityFactory
+	 * @param \Magento\Catalog\Model\ResourceModel\Helper $resourceHelper
+	 * @param \Magento\Framework\Validator\UniversalFactory $universalFactory
+	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+	 * @param \Magento\Framework\Module\Manager $moduleManager
+	 * @param \Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState
+	 * @param \Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig
+	 * @param \Magento\Catalog\Model\Product\OptionFactory $productOptionFactory
+	 * @param \Magento\Catalog\Model\ResourceModel\Url $catalogUrl
+	 * @param \Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate
+	 * @param \Magento\Customer\Model\Session $customerSession
+	 * @param \Magento\Framework\Stdlib\DateTime $dateTime
+	 * @param \Magento\Customer\Api\GroupManagementInterface $groupManagement
+	 * @param \Magento\Search\Model\QueryFactory $catalogSearchData
+	 * @param \Magento\Framework\Search\Request\Builder $requestBuilder
+	 * @param \Magento\Search\Model\SearchEngine $searchEngine
+	 * @param \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory
+	 * @param \Magento\Framework\DB\Adapter\AdapterInterface $connection
+	 * @param string $searchRequestName
+	 * @param SearchResultFactory $searchResultFactory
+	 * @SuppressWarnings(PHPMD.ExcessiveParameterList)
+	 */
+	public function __construct(
+		\Magento\Framework\Data\Collection\EntityFactory $entityFactory,
+		\Psr\Log\LoggerInterface $logger,
+		\Magento\Framework\Data\Collection\Db\FetchStrategyInterface $fetchStrategy,
+		\Magento\Framework\Event\ManagerInterface $eventManager,
+		\Magento\Eav\Model\Config $eavConfig,
+		\Magento\Framework\App\ResourceConnection $resource,
+		\Magento\Eav\Model\EntityFactory $eavEntityFactory,
+		\Magento\Catalog\Model\ResourceModel\Helper $resourceHelper,
+		\Magento\Framework\Validator\UniversalFactory $universalFactory,
+		\Magento\Store\Model\StoreManagerInterface $storeManager,
+		\Magento\Framework\Module\Manager $moduleManager,
+		\Magento\Catalog\Model\Indexer\Product\Flat\State $catalogProductFlatState,
+		\Magento\Framework\App\Config\ScopeConfigInterface $scopeConfig,
+		\Magento\Catalog\Model\Product\OptionFactory $productOptionFactory,
+		\Magento\Catalog\Model\ResourceModel\Url $catalogUrl,
+		\Magento\Framework\Stdlib\DateTime\TimezoneInterface $localeDate,
+		\Magento\Customer\Model\Session $customerSession,
+		\Magento\Framework\Stdlib\DateTime $dateTime,
+		\Magento\Customer\Api\GroupManagementInterface $groupManagement,
+		\Magento\Search\Model\QueryFactory $catalogSearchData,
+		\Magento\Framework\Search\Request\Builder $requestBuilder,
+		\Magento\Search\Model\SearchEngine $searchEngine,
+		\Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory,
+		\Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
+		$searchRequestName = 'catalog_view_container',
+		SearchResultFactory $searchResultFactory = null
+	)
+	{
+		$this->queryFactory = $catalogSearchData;
+		if ($searchResultFactory === null) {
+			$this->searchResultFactory = \Magento\Framework\App\ObjectManager::getInstance()
+				->get('Magento\Framework\Api\Search\SearchResultFactory');
+		}
+		parent::__construct(
+			$entityFactory,
+			$logger,
+			$fetchStrategy,
+			$eventManager,
+			$eavConfig,
+			$resource,
+			$eavEntityFactory,
+			$resourceHelper,
+			$universalFactory,
+			$storeManager,
+			$moduleManager,
+			$catalogProductFlatState,
+			$scopeConfig,
+			$productOptionFactory,
+			$catalogUrl,
+			$localeDate,
+			$customerSession,
+			$dateTime,
+			$groupManagement,
+			$connection
+		);
+		$this->requestBuilder          = $requestBuilder;
+		$this->searchEngine            = $searchEngine;
+		$this->temporaryStorageFactory = $temporaryStorageFactory;
+		$this->searchRequestName       = $searchRequestName;
+	}
+
+	/**
+	 * @deprecated
+	 * @return \Magento\Search\Api\SearchInterface
+	 */
+	private function getSearch()
+	{
+		if ($this->search === null) {
+			$this->search = ObjectManager::getInstance()->get('\Magento\Search\Api\SearchInterface');
+		}
+
+		return $this->search;
+	}
+
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
+	public function getCollectionClone()
+	{
+		$collectionClone = clone $this->collectionClone;
+		$collectionClone->setSearchCriteriaBuilder($this->collectionClone->getSearchCriteriaBuilder()->cloneObject());
+
+		return $collectionClone;
+	}
+
+	public function cloneObject()
+	{
+		if ($this->collectionClone === null) {
+			$this->collectionClone = clone $this;
+			$this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
+		}
+
+		return $this;
+	}
+
+	public function removeAttributeSearch($attributeCode)
+	{
+		if(is_array($attributeCode)){
+			foreach($attributeCode as $attCode){
+				$this->searchCriteriaBuilder->removeFilter($attCode);
+			}
+		} else {
+			$this->searchCriteriaBuilder->removeFilter($attributeCode);
+		}
+
+		$this->_isFiltersRendered = false;
+
+		return $this->loadWithFilter();
+	}
+
+	/**
+	 * @deprecated
+	 * @param \Magento\Framework\Api\Search\SearchCriteriaBuilder $object
+	 * @return void
+	 */
+	public function setSearchCriteriaBuilder(\Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object)
+	{
+		$this->searchCriteriaBuilder = $object;
+	}
+
+	/**
+	 * @deprecated
+	 * @return \Magento\Framework\Api\FilterBuilder
+	 */
+	private function getFilterBuilder()
+	{
+		if ($this->filterBuilder === null) {
+			$this->filterBuilder = ObjectManager::getInstance()->get('\Magento\Framework\Api\FilterBuilder');
+		}
+
+		return $this->filterBuilder;
+	}
+
+	/**
+	 * @deprecated
+	 * @param \Magento\Framework\Api\FilterBuilder $object
+	 * @return void
+	 */
+	public function setFilterBuilder(\Magento\Framework\Api\FilterBuilder $object)
+	{
+		$this->filterBuilder = $object;
+	}
+
+	/**
+	 * Apply attribute filter to facet collection
+	 *
+	 * @param string $field
+	 * @param null $condition
+	 * @return $this
+	 */
+	public function addFieldToFilter($field, $condition = null)
+	{
+		if ($this->searchResult !== null) {
+			throw new \RuntimeException('Illegal state');
+		}
+
+		$this->getSearchCriteriaBuilder();
+		$this->getFilterBuilder();
+		if (!is_array($condition) || !in_array(key($condition), ['from', 'to'])) {
+			$this->filterBuilder->setField($field);
+			$this->filterBuilder->setValue($condition);
+			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+		} else {
+			if (!empty($condition['from'])) {
+				$this->filterBuilder->setField("{$field}.from");
+				$this->filterBuilder->setValue($condition['from']);
+				$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+			}
+			if (!empty($condition['to'])) {
+				$this->filterBuilder->setField("{$field}.to");
+				$this->filterBuilder->setValue($condition['to']);
+				$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+			}
+		}
+
+		return $this;
+	}
+
+	/**
+	 * Add search query filter
+	 *
+	 * @param string $query
+	 * @return $this
+	 */
+	public function addSearchFilter($query)
+	{
+		$this->queryText = trim($this->queryText . ' ' . $query);
+
+		return $this;
+	}
+
+	/**
+	 * @inheritdoc
+	 */
+	protected function _renderFiltersBefore()
+	{
+		$this->getSearchCriteriaBuilder();
+		$this->getFilterBuilder();
+		$this->getSearch();
+
+		if ($this->queryText) {
+			$this->filterBuilder->setField('search_term');
+			$this->filterBuilder->setValue($this->queryText);
+			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+		}
+
+		$priceRangeCalculation = $this->_scopeConfig->getValue(
+			\Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory::XML_PATH_RANGE_CALCULATION,
+			\Magento\Store\Model\ScopeInterface::SCOPE_STORE
+		);
+		if ($priceRangeCalculation) {
+			$this->filterBuilder->setField('price_dynamic_algorithm');
+			$this->filterBuilder->setValue($priceRangeCalculation);
+			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+		}
+
+		$this->cloneObject();
+
+		$searchCriteria = $this->searchCriteriaBuilder->create();
+		$searchCriteria->setRequestName($this->searchRequestName);
+
+		try {
+			$this->searchResult = $this->getSearch()->search($searchCriteria);
+		} catch (EmptyRequestDataException $e) {
+			/** @var \Magento\Framework\Api\Search\SearchResultInterface $searchResult */
+			$this->searchResult = $this->searchResultFactory->create()->setItems([]);
+		} catch (NonExistingRequestNameException $e) {
+			$this->_logger->error($e->getMessage());
+			throw new LocalizedException(__('Sorry, something went wrong. You can find out more in the error log.'));
+		}
+
+		$temporaryStorage = $this->temporaryStorageFactory->create();
+		$table            = $temporaryStorage->storeApiDocuments($this->searchResult->getItems());
+
+		$this->getSelect()->joinInner(
+			[
+				'search_result' => $table->getName(),
+			],
+			'e.entity_id = search_result.' . TemporaryStorage::FIELD_ENTITY_ID,
+			[]
+		);
+
+		$this->_totalRecords = $this->searchResult->getTotalCount();
+
+		if ($this->order && 'relevance' === $this->order['field']) {
+			$this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
+		}
+
+		return parent::_renderFiltersBefore();
+	}
+
+	/**
+	 * @return $this
+	 */
+	protected function _renderFilters()
+	{
+		$this->_filters = [];
+
+		return parent::_renderFilters();
+	}
+
+	/**
+	 * Set Order field
+	 *
+	 * @param string $attribute
+	 * @param string $dir
+	 * @return $this
+	 */
+	public function setOrder($attribute, $dir = Select::SQL_DESC)
+	{
+		$this->order = ['field' => $attribute, 'dir' => $dir];
+		if ($attribute != 'relevance') {
+			parent::setOrder($attribute, $dir);
+		}
+
+		return $this;
+	}
+
+	/**
+	 * Stub method for compatibility with other search engines
+	 *
+	 * @return $this
+	 */
+	public function setGeneralDefaultQuery()
+	{
+		return $this;
+	}
+
+	/**
+	 * Return field faceted data from faceted search result
+	 *
+	 * @param string $field
+	 * @return array
+	 * @throws StateException
+	 */
+	public function getFacetedData($field)
+	{
+		$this->_renderFilters();
+		$result = [];
+
+		$aggregations = $this->searchResult->getAggregations();
+		// This behavior is for case with empty object when we got EmptyRequestDataException
+		if (null !== $aggregations) {
+			$bucket = $aggregations->getBucket($field . RequestGenerator::BUCKET_SUFFIX);
+			if ($bucket) {
+				foreach ($bucket->getValues() as $value) {
+					$metrics                   = $value->getMetrics();
+					$result[$metrics['value']] = $metrics;
+				}
+			} else {
+				throw new StateException(__('Bucket does not exist'));
+			}
+		}
+
+		return $result;
+	}
+
+	/**
+	 * Specify category filter for product collection
+	 *
+	 * @param \Magento\Catalog\Model\Category $category
+	 * @return $this
+	 */
+	public function addCategoryFilter(\Magento\Catalog\Model\Category $category)
+	{
+		$this->addFieldToFilter('category_ids', $category->getId());
+
+		return parent::addCategoryFilter($category);
+	}
+
+	/**
+	 * Set product visibility filter for enabled products
+	 *
+	 * @param array $visibility
+	 * @return $this
+	 */
+	public function setVisibility($visibility)
+	{
+		$this->addFieldToFilter('visibility', $visibility);
+
+		return parent::setVisibility($visibility);
+	}
 }
diff --git a/Model/Search/FilterGroup.php b/Model/Search/FilterGroup.php
index a128c37..a4c883d 100644
--- a/Model/Search/FilterGroup.php
+++ b/Model/Search/FilterGroup.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\Search\FilterGroup as SourceFilterGroup;
@@ -28,11 +22,4 @@ use Magento\Framework\Api\Search\FilterGroup as SourceFilterGroup;
  */
 class FilterGroup extends SourceFilterGroup
 {
-    /**
-     * @return bool
-     */
-    public function isUsedQuery()
-    {
-        return true;
-    }
 }
diff --git a/Model/Search/FilterGroupBuilder.php b/Model/Search/FilterGroupBuilder.php
index c345c26..31ca45c 100644
--- a/Model/Search/FilterGroupBuilder.php
+++ b/Model/Search/FilterGroupBuilder.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\FilterBuilder;
@@ -30,52 +24,52 @@ use Magento\Framework\Api\Search\FilterGroupBuilder as SourceFilterGroupBuilder;
  */
 class FilterGroupBuilder extends SourceFilterGroupBuilder
 {
-    /**
-     * @param ObjectFactory $objectFactory
-     * @param FilterBuilder $filterBuilder
-     */
-    public function __construct(
-        ObjectFactory $objectFactory,
-        FilterBuilder $filterBuilder
-    ) {
-
-        parent::__construct($objectFactory, $filterBuilder);
-    }
+	/**
+	 * @param ObjectFactory $objectFactory
+	 * @param FilterBuilder $filterBuilder
+	 */
+	public function __construct(
+		ObjectFactory $objectFactory,
+		FilterBuilder $filterBuilder
+	)
+	{
+		parent::__construct($objectFactory, $filterBuilder);
+	}
 
     /**
      * @param $filterBuilder
      */
-    public function setFilterBuilder($filterBuilder)
-    {
-        $this->_filterBuilder = $filterBuilder;
-    }
+	public function setFilterBuilder($filterBuilder)
+	{
+		$this->_filterBuilder = $filterBuilder;
+	}
 
     /**
      * @return FilterGroupBuilder
      */
-    public function cloneObject()
-    {
-        $cloneObject = clone $this;
-        $cloneObject->setFilterBuilder(clone $this->_filterBuilder);
+	public function cloneObject()
+	{
+		$cloneObject = clone $this;
+		$cloneObject->setFilterBuilder(clone $this->_filterBuilder);
 
-        return $cloneObject;
-    }
+		return $cloneObject;
+	}
 
     /**
      * @param $attributeCode
      *
      * @return $this
      */
-    public function removeFilter($attributeCode)
-    {
-        if (isset($this->data[FilterGroup::FILTERS])) {
-            foreach ($this->data[FilterGroup::FILTERS] as $key => $filter) {
-                if ($filter->getField() == $attributeCode) {
-                    unset($this->data[FilterGroup::FILTERS][$key]);
-                }
-            }
-        }
+	public function removeFilter($attributeCode)
+	{
+		if (isset($this->data[FilterGroup::FILTERS])) {
+			foreach ($this->data[FilterGroup::FILTERS] as $key => $filter) {
+				if ($filter->getField() == $attributeCode) {
+					unset($this->data[FilterGroup::FILTERS][$key]);
+				}
+			}
+		}
 
-        return $this;
-    }
+		return $this;
+	}
 }
diff --git a/Model/Search/SearchCriteria.php b/Model/Search/SearchCriteria.php
index 91423fe..79bd9ab 100644
--- a/Model/Search/SearchCriteria.php
+++ b/Model/Search/SearchCriteria.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\Search\SearchCriteria as SourceSearchCriteria;
@@ -28,11 +22,4 @@ use Magento\Framework\Api\Search\SearchCriteria as SourceSearchCriteria;
  */
 class SearchCriteria extends SourceSearchCriteria
 {
-    /**
-     * @return bool
-     */
-    public function isUsedQuery()
-    {
-        return true;
-    }
 }
diff --git a/Model/Search/SearchCriteriaBuilder.php b/Model/Search/SearchCriteriaBuilder.php
index 7e0a1e2..6d87af3 100644
--- a/Model/Search/SearchCriteriaBuilder.php
+++ b/Model/Search/SearchCriteriaBuilder.php
@@ -1,24 +1,18 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\ObjectFactory;
@@ -30,48 +24,48 @@ use Magento\Framework\Api\Search\SearchCriteriaBuilder as SourceSearchCriteriaBu
  */
 class SearchCriteriaBuilder extends SourceSearchCriteriaBuilder
 {
-    /**
-     * @param ObjectFactory $objectFactory
-     * @param FilterGroupBuilder $filterGroupBuilder
-     * @param SortOrderBuilder $sortOrderBuilder
-     */
-    public function __construct(
-        ObjectFactory $objectFactory,
-        FilterGroupBuilder $filterGroupBuilder,
-        SortOrderBuilder $sortOrderBuilder
-    ) {
-    
-        parent::__construct($objectFactory, $filterGroupBuilder, $sortOrderBuilder);
-    }
+	/**
+	 * @param ObjectFactory $objectFactory
+	 * @param FilterGroupBuilder $filterGroupBuilder
+	 * @param SortOrderBuilder $sortOrderBuilder
+	 */
+	public function __construct(
+		ObjectFactory $objectFactory,
+		FilterGroupBuilder $filterGroupBuilder,
+		SortOrderBuilder $sortOrderBuilder
+	)
+	{
+		parent::__construct($objectFactory, $filterGroupBuilder, $sortOrderBuilder);
+	}
 
     /**
      * @param $attributeCode
      *
      * @return $this
      */
-    public function removeFilter($attributeCode)
-    {
-        $this->filterGroupBuilder->removeFilter($attributeCode);
+	public function removeFilter($attributeCode)
+	{
+		$this->filterGroupBuilder->removeFilter($attributeCode);
 
-        return $this;
-    }
+		return $this;
+	}
 
     /**
      * @param $filterGroupBuilder
      */
-    public function setFilterGroupBuilder($filterGroupBuilder)
-    {
-        $this->filterGroupBuilder = $filterGroupBuilder;
-    }
+	public function setFilterGroupBuilder($filterGroupBuilder)
+	{
+		$this->filterGroupBuilder = $filterGroupBuilder;
+	}
 
     /**
      * @return SearchCriteriaBuilder
      */
-    public function cloneObject()
-    {
-        $cloneObject = clone $this;
-        $cloneObject->setFilterGroupBuilder($this->filterGroupBuilder->cloneObject());
+	public function cloneObject()
+	{
+		$cloneObject = clone $this;
+		$cloneObject->setFilterGroupBuilder($this->filterGroupBuilder->cloneObject());
 
-        return $cloneObject;
-    }
+		return $cloneObject;
+	}
 }
diff --git a/Plugins/Block/RenderLayered.php b/Plugins/Block/RenderLayered.php
index bae8b44..741944c 100644
--- a/Plugins/Block/RenderLayered.php
+++ b/Plugins/Block/RenderLayered.php
@@ -1,101 +1,86 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Plugins\Block;
 
 class RenderLayered
 {
-	/**
-	 * @var \Magento\Framework\UrlInterface
-	 */
+    /**
+     * @var \Magento\Framework\UrlInterface
+     */
 	protected $_url;
 
-	/**
-	 * @var \Magento\Theme\Block\Html\Pager
-	 */
+    /**
+     * @var \Magento\Theme\Block\Html\Pager
+     */
 	protected $_htmlPagerBlock;
 
-	/**
-	 * @var \Magento\Framework\App\RequestInterface
-	 */
+    /**
+     * @var \Magento\Framework\App\RequestInterface
+     */
 	protected $_request;
 
-	/**
-	 * @var \Mageplaza\LayeredNavigation\Helper\Data
-	 */
+    /**
+     * @var \Mageplaza\LayeredNavigation\Helper\Data
+     */
 	protected $_moduleHelper;
 
-	/**
-	 * RenderLayered constructor.
-	 *
-	 * @param \Magento\Framework\UrlInterface $url
-	 * @param \Magento\Theme\Block\Html\Pager $htmlPagerBlock
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	 */
+    /**
+     * RenderLayered constructor.
+     *
+     * @param \Magento\Framework\UrlInterface          $url
+     * @param \Magento\Theme\Block\Html\Pager          $htmlPagerBlock
+     * @param \Magento\Framework\App\RequestInterface  $request
+     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+     */
 	public function __construct(
 		\Magento\Framework\UrlInterface $url,
 		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
 		\Magento\Framework\App\RequestInterface $request,
 		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	)
-	{
-		$this->_url            = $url;
+	) {
+		$this->_url = $url;
 		$this->_htmlPagerBlock = $htmlPagerBlock;
-		$this->_request        = $request;
-		$this->_moduleHelper   = $moduleHelper;
+		$this->_request = $request;
+		$this->_moduleHelper = $moduleHelper;
 	}
 
-	/**
-	 * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
-	 * @param $proceed
-	 * @param $attributeCode
-	 * @param $optionId
-	 *
-	 * @return string
-	 */
-	public function aroundBuildUrl(
-		\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject,
-		$proceed,
-		$attributeCode,
-		$optionId
-	)
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
-			return $proceed($attributeCode, $optionId);
+    /**
+     * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
+     * @param                                                         $proceed
+     * @param                                                         $attributeCode
+     * @param                                                         $optionId
+     *
+     * @return string
+     */
+    public function aroundBuildUrl(\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject, $proceed, $attributeCode, $optionId)
+    {
+		if(!$this->_moduleHelper->isEnabled()){
+			return $proceed();
 		}
 
-		$value = [];
-		if ($requestValue = $this->_request->getParam($attributeCode)) {
+		$value = array();
+		if($requestValue = $this->_request->getParam($attributeCode)){
 			$value = explode(',', $requestValue);
 		}
-		if (!in_array($optionId, $value)) {
+		if(!in_array($optionId, $value)) {
 			$value[] = $optionId;
 		}
 
-		$query = [$attributeCode => implode(',', $value)];
+        $query = [$attributeCode => implode(',', $value)];
 
-		return $this->_url->getUrl(
-			'*/*/*',
-			['_current' => true, '_use_rewrite' => true, '_query' => $query]
-		);
-	}
+        return $this->_url->getUrl('*/*/*', ['_current' => true, '_use_rewrite' => true, '_query' => $query]);
+    }
 }
diff --git a/Plugins/Controller/Category/View.php b/Plugins/Controller/Category/View.php
index 89164c7..3b4c2eb 100644
--- a/Plugins/Controller/Category/View.php
+++ b/Plugins/Controller/Category/View.php
@@ -1,30 +1,24 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-
 namespace Mageplaza\LayeredNavigation\Plugins\Controller\Category;
 
 class View
 {
-    protected $_jsonHelper;
-    protected $_moduleHelper;
+	protected $_jsonHelper;
+	protected $_moduleHelper;
 
     /**
      * View constructor.
@@ -32,13 +26,13 @@ class View
      * @param \Magento\Framework\Json\Helper\Data      $jsonHelper
      * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
      */
-    public function __construct(
-        \Magento\Framework\Json\Helper\Data $jsonHelper,
-        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-    ) {
-        $this->_jsonHelper = $jsonHelper;
-        $this->_moduleHelper = $moduleHelper;
-    }
+	public function __construct(
+		\Magento\Framework\Json\Helper\Data $jsonHelper,
+		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	){
+		$this->_jsonHelper = $jsonHelper;
+		$this->_moduleHelper = $moduleHelper;
+	}
 
     /**
      * @param \Magento\Catalog\Controller\Category\View $action
@@ -47,14 +41,14 @@ class View
      * @return mixed
      */
     public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
-    {
-        if ($this->_moduleHelper->isEnabled() && $action->getRequest()->getParam('isAjax')) {
-            $navigation = $page->getLayout()->getBlock('catalog.leftnav');
-            $products = $page->getLayout()->getBlock('category.products');
-            $result = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
-            $action->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
-        } else {
-            return $page;
-        }
+	{
+		if($this->_moduleHelper->isEnabled() && $action->getRequest()->getParam('isAjax')){
+			$navigation = $page->getLayout()->getBlock('catalog.leftnav');
+			$products = $page->getLayout()->getBlock('category.products');
+			$result = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
+			$action->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
+		} else {
+			return $page;
+		}
     }
 }
diff --git a/Plugins/Model/Layer/Filter/Item.php b/Plugins/Model/Layer/Filter/Item.php
index 168d52f..66522aa 100644
--- a/Plugins/Model/Layer/Filter/Item.php
+++ b/Plugins/Model/Layer/Filter/Item.php
@@ -1,30 +1,6 @@
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
-
 namespace Mageplaza\LayeredNavigation\Plugins\Model\Layer\Filter;
 
-/**
- * Class Item
- * @package Mageplaza\LayeredNavigation\Plugins\Model\Layer\Filter
- */
 class Item
 {
 	protected $_url;
@@ -32,97 +8,90 @@ class Item
 	protected $_request;
 	protected $_moduleHelper;
 
-	/**
-	 * Item constructor.
-	 *
-	 * @param \Magento\Framework\UrlInterface $url
-	 * @param \Magento\Theme\Block\Html\Pager $htmlPagerBlock
-	 * @param \Magento\Framework\App\RequestInterface $request
-	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	 */
+    /**
+     * Item constructor.
+     *
+     * @param \Magento\Framework\UrlInterface          $url
+     * @param \Magento\Theme\Block\Html\Pager          $htmlPagerBlock
+     * @param \Magento\Framework\App\RequestInterface  $request
+     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+     */
 	public function __construct(
 		\Magento\Framework\UrlInterface $url,
 		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
 		\Magento\Framework\App\RequestInterface $request,
 		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	)
-	{
-		$this->_url            = $url;
+	) {
+		$this->_url = $url;
 		$this->_htmlPagerBlock = $htmlPagerBlock;
-		$this->_request        = $request;
-		$this->_moduleHelper   = $moduleHelper;
+		$this->_request = $request;
+		$this->_moduleHelper = $moduleHelper;
 	}
 
-	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-	 * @param                                          $proceed
-	 *
-	 * @return string
-	 */
-	public function aroundGetUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
+    /**
+     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
+     * @param                                          $proceed
+     *
+     * @return string
+     */
+    public function aroundGetUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
+    {
+		if(!$this->_moduleHelper->isEnabled()){
 			return $proceed();
 		}
 
-		$value      = [];
+		$value = array();
 		$requestVar = $item->getFilter()->getRequestVar();
-		if ($requestVar == 'price') {
-			$value = ["{price_start}-{price_end}"];
-		} else if ($this->_moduleHelper->getGeneralConfig('allow_multiple')) {
-			if ($requestValue = $this->_request->getParam($requestVar)) {
-				$value = explode(',', $requestValue);
-			}
-			if (!in_array($item->getValue(), $value)) {
-				$value[] = $item->getValue();
-			}
+		if($requestValue = $this->_request->getParam($requestVar)){
+			$value = explode(',', $requestValue);
+		}
+		if(!in_array($item->getValue(), $value)) {
+			$value[] = $item->getValue();
 		}
 
-		if (sizeof($value)) {
-			$query = [
-				$item->getFilter()->getRequestVar()      => implode(',', $value),
-				// exclude current page from urls
-				$this->_htmlPagerBlock->getPageVarName() => null,
-			];
-
-			return $this->_url->getUrl('*/*/*', ['_current' => true, '_use_rewrite' => true, '_query' => $query]);
+		if($requestVar == 'price'){
+			$value = ["{price_start}-{price_end}"];
 		}
 
-		return $proceed();
-	}
+        $query = [
+			$item->getFilter()->getRequestVar() => implode(',', $value),
+            // exclude current page from urls
+			$this->_htmlPagerBlock->getPageVarName() => null,
+        ];
+        return $this->_url->getUrl('*/*/*', ['_current' => true, '_use_rewrite' => true, '_query' => $query]);
+    }
 
-	/**
-	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-	 * @param                                          $proceed
-	 *
-	 * @return string
-	 */
-	public function aroundGetRemoveUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
-	{
-		if (!$this->_moduleHelper->isEnabled()) {
+    /**
+     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
+     * @param                                          $proceed
+     *
+     * @return string
+     */
+    public function aroundGetRemoveUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
+    {
+		if(!$this->_moduleHelper->isEnabled()){
 			return $proceed();
 		}
 
-		$value      = [];
+		$value = array();
 		$requestVar = $item->getFilter()->getRequestVar();
-		if ($requestValue = $this->_request->getParam($requestVar)) {
+		if($requestValue = $this->_request->getParam($requestVar)){
 			$value = explode(',', $requestValue);
 		}
 
-		if (in_array($item->getValue(), $value)) {
-			$value = array_diff($value, [$item->getValue()]);
+		if(in_array($item->getValue(), $value)){
+			$value = array_diff($value, array($item->getValue()));
 		}
 
-		if ($requestVar == 'price') {
+		if($requestVar == 'price'){
 			$value = [];
 		}
 
-		$query                  = [$requestVar => count($value) ? implode(',', $value) : $item->getFilter()->getResetValue()];
-		$params['_current']     = true;
-		$params['_use_rewrite'] = true;
-		$params['_query']       = $query;
-		$params['_escape']      = true;
-
-		return $this->_url->getUrl('*/*/*', $params);
-	}
+        $query = [$requestVar => count($value) ? implode(',', $value) : $item->getFilter()->getResetValue()];
+        $params['_current'] = true;
+        $params['_use_rewrite'] = true;
+        $params['_query'] = $query;
+        $params['_escape'] = true;
+        return $this->_url->getUrl('*/*/*', $params);
+    }
 }
diff --git a/composer.json b/composer.json
index 7934aea..d3bf6f7 100644
--- a/composer.json
+++ b/composer.json
@@ -1,9 +1,8 @@
 {
-  "name": "mageplaza/layered-navigation-m2",
+  "name": "layered-navigation-m2",
   "description": "Layered navigation M2",
   "require": {
-    "php": "~5.5.0|~5.6.0|~7.0.0",
-    "mageplaza/core-m2": "*"
+    "php": "~5.5.0|~5.6.0|~7.0.0"
   },
   "type": "magento2-module",
   "version": "1.0.0",
diff --git a/etc/acl.xml b/etc/acl.xml
index 6a0e5f3..2f5f322 100644
--- a/etc/acl.xml
+++ b/etc/acl.xml
@@ -1,26 +1,20 @@
 <?xml version="1.0"?>
 <!--
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Acl/etc/acl.xsd">
     <acl>
         <resources>
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index 8bd94c4..3a3e605 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -1,26 +1,20 @@
 <?xml version="1.0"?>
 <!--
 /**
- * Mageplaza
+ *                      Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
     <menu>
         <add id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" module="Mageplaza_LayeredNavigation" sortOrder="100" resource="Mageplaza_LayeredNavigation::layer" parent="Mageplaza_Core::menu"/>
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 8226c16..10203d6 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -1,26 +1,20 @@
 <?xml version="1.0"?>
 <!--
 /**
- * Mageplaza
+ *                      Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
     <system>
         <section id="layered_navigation" translate="label" sortOrder="50" showInDefault="1" showInWebsite="1" showInStore="1">
@@ -30,6 +24,7 @@
             <resource>Mageplaza_LayeredNavigation::layered_navigation</resource>
             <group id="general" translate="label" type="text" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
                 <label>General Configuration</label>
+
                 <field id="head" translate="label" type="button" sortOrder="1" showInDefault="1" showInWebsite="1" showInStore="1">
                     <frontend_model>Mageplaza\Core\Block\Adminhtml\System\Config\Head</frontend_model>
                     <comment><![CDATA[
@@ -45,25 +40,6 @@
                     <label>Module Enable</label>
                     <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                 </field>
-                <field id="allow_multiple" translate="label" type="select" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Allow Multiple Filter</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-            </group>
-            <group id="display" translate="label" type="text" sortOrder="20" showInDefault="1" showInWebsite="1" showInStore="1">
-                <label>Display Configuration</label>
-                <field id="show_zero" translate="label" type="select" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Show Option With No Product</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="show_counter" translate="label" type="select" sortOrder="20" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Display Product Count</label>
-                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
-                </field>
-                <field id="auto_open" translate="label" type="select" sortOrder="30" showInDefault="1" showInWebsite="1" showInStore="1">
-                    <label>Auto Open Attribute Group</label>
-                    <source_model>Mageplaza\LayeredNavigation\Model\Config\Source\ActiveFilter</source_model>
-                </field>
             </group>
         </section>
     </system>
diff --git a/etc/config.xml b/etc/config.xml
index 206fb89..ed1773d 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -1,26 +1,20 @@
 <?xml version="1.0"?>
 <!--
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Store:etc/config.xsd">
     <default>
         <layered_navigation>
@@ -29,11 +23,6 @@
                 <allow_multiple>1</allow_multiple>
                 <enable_shop_by>0</enable_shop_by>
             </general>
-            <display>
-                <show_zero>0</show_zero>
-                <auto_open>0</auto_open>
-                <show_counter>1</show_counter>
-            </display>
         </layered_navigation>
     </default>
 </config>
diff --git a/etc/di.xml b/etc/di.xml
index 55c1ddc..c3060c2 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -1,25 +1,4 @@
 <?xml version="1.0"?>
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
- * @copyright   Copyright (c) 2016 Mageplaza (http://www.mageplaza.com/)
- * @license     https://www.mageplaza.com/LICENSE.txt
- */
--->
 
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <virtualType name="categoryFilterList" type="Magento\Catalog\Model\Layer\FilterList">
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index 0c0b927..b6f9acf 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -1,26 +1,20 @@
 <?xml version="1.0"?>
 <!--
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <type name="Magento\Catalog\Controller\Category\View">
         <plugin name="layer_navigation_ajax_update" type="Mageplaza\LayeredNavigation\Plugins\Controller\Category\View" sortOrder="1" />
diff --git a/etc/module.xml b/etc/module.xml
index 44f390d..84bcc0f 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -1,26 +1,20 @@
 <?xml version="1.0"?>
 <!--
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 -->
-
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
     <module name="Mageplaza_LayeredNavigation" setup_version="1.0.0">
         <sequence>
diff --git a/view/adminhtml/web/css/source/_module.less b/view/adminhtml/web/css/source/_module.less
index 9497f31..4b675fe 100644
--- a/view/adminhtml/web/css/source/_module.less
+++ b/view/adminhtml/web/css/source/_module.less
@@ -1,23 +1,3 @@
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
-
 .admin__menu #menu-mageplaza-core-menu .item-layer.parent.level-1 > strong:before {
   content: '\e617';
   font-family: 'Admin Icons';
diff --git a/view/frontend/layout/catalog_category_view_type_layered.xml b/view/frontend/layout/catalog_category_view_type_layered.xml
index aaf47d9..15aef7a 100644
--- a/view/frontend/layout/catalog_category_view_type_layered.xml
+++ b/view/frontend/layout/catalog_category_view_type_layered.xml
@@ -1,23 +1,18 @@
 <?xml version="1.0"?>
 <!--
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 -->
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
diff --git a/view/frontend/templates/filter.phtml b/view/frontend/templates/filter.phtml
index 70b2979..a802a4d 100644
--- a/view/frontend/templates/filter.phtml
+++ b/view/frontend/templates/filter.phtml
@@ -1,30 +1,22 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 ?>
-
 <ol class="items">
     <?php foreach ($filterItems as $filterItem): ?>
         <?php
-        $lnHelper = \Magento\Framework\App\ObjectManager::getInstance()->get('Mageplaza\LayeredNavigation\Helper\Data');
-        $isMultipleMode = $lnHelper->getGeneralConfig('allow_multiple');
         $filter = $filterItem->getFilter();
         $attributeModel = $filter->getData('attribute_model');
         $inputName = $filter->getRequestVar();
@@ -33,7 +25,18 @@
         $url = in_array($filterItem->getValue(), $requestArray) ? $filterItem->getRemoveUrl() : $filterItem->getUrl();
         ?>
         <li class="item">
-            <?php if($filterItem->getFilterType() == 'slider'): ?>
+            <?php if($attributeModel && $attributeModel->getFrontendInput() == 'price'): ?>
+                <?php
+                    $productCollection = $filter->getLayer()->getProductCollection();
+                    $productCollectionClone = $productCollection->getCollectionClone();
+                    $collection = $productCollectionClone
+                        ->removeAttributeSearch(['price.from', 'price.to']);
+
+                    $min = $collection->getMinPrice();
+                    $max = $collection->getMaxPrice();
+
+                    list($from, $to) = $requestValue ? explode('-', $requestValue) : [$min, $max];
+                ?>
                 <div id="ln_price_attribute">
                     <div id="ln_price_slider"></div>
                     <div id="ln_price_text"></div>
@@ -42,10 +45,10 @@
                     {
                         "#ln_price_attribute": {
                             "Mageplaza_LayeredNavigation/js/price/slider": {
-                                "selectedFrom": <?php echo $filterItem->getFrom() ?>,
-                                "selectedTo": <?php echo $filterItem->getTo() ?>,
-                                "minValue": <?php echo $filterItem->getMin() ?>,
-                                "maxValue": <?php echo $filterItem->getMax() ?>,
+                                "selectedFrom": <?php echo $from ?>,
+                                "selectedTo": <?php echo $to ?>,
+                                "minValue": <?php echo $min ?>,
+                                "maxValue": <?php echo $max ?>,
                                 "priceFormat": <?php /* @escapeNotVerified */ echo $this->helper('Magento\Tax\Helper\Data')->getPriceFormat($block->getStore()); ?>,
                                 "ajaxUrl": <?php /* @escapeNotVerified */ echo $this->helper('Magento\Framework\Json\Helper\Data')->jsonEncode($filterItem->getUrl()) ?>
                             }
@@ -56,21 +59,21 @@
             <?php else: ?>
 				<?php if ($filterItem->getCount() > 0): ?>
                     <a href="<?php echo $block->escapeUrl($url) ?>">
-                        <?php if($attributeModel && $attributeModel->getFrontendInput() == 'multiselect' && $isMultipleMode): ?>
+                        <?php if($attributeModel && $attributeModel->getFrontendInput() == 'multiselect'): ?>
                             <input type="checkbox" <?php echo in_array($filterItem->getValue(), $requestArray) ? 'checked="checked"' : ''  ?> />
                         <?php endif; ?>
 						<?php /* @escapeNotVerified */ echo $filterItem->getLabel() ?>
-                        <?php if ($lnHelper->getDisplayConfig('show_counter')): ?>
+                        <?php if ($this->helper('\Magento\Catalog\Helper\Data')->shouldDisplayProductCountOnLayer()): ?>
                             <span class="count"><?php /* @escapeNotVerified */ echo $filterItem->getCount()?><span class="filter-count-label">
 								<?php if ($filterItem->getCount() == 1):?> <?php /* @escapeNotVerified */ echo __('item')?><?php else:?> <?php /* @escapeNotVerified */ echo __('items') ?><?php endif;?></span></span>
                         <?php endif; ?>
 					</a>
                 <?php else:?>
-                    <?php if($attributeModel && $attributeModel->getFrontendInput() == 'multiselect' && $isMultipleMode): ?>
+                    <?php if($attributeModel && $attributeModel->getFrontendInput() == 'multiselect'): ?>
                         <input type="checkbox" disabled="disabled" />
                     <?php endif; ?>
                     <?php /* @escapeNotVerified */ echo $filterItem->getLabel() ?>
-                    <?php if ($lnHelper->getDisplayConfig('show_counter')): ?>
+                    <?php if ($this->helper('\Magento\Catalog\Helper\Data')->shouldDisplayProductCountOnLayer()): ?>
                         <span class="count"><?php /* @escapeNotVerified */ echo $filterItem->getCount()?><span class="filter-count-label">
 							<?php if ($filterItem->getCount() == 1):?><?php /* @escapeNotVerified */ echo __('item')?><?php else:?><?php /* @escapeNotVerified */ echo __('items') ?><?php endif;?></span></span>
                     <?php endif; ?>
diff --git a/view/frontend/templates/products.phtml b/view/frontend/templates/products.phtml
index 6dbc3f0..925738a 100644
--- a/view/frontend/templates/products.phtml
+++ b/view/frontend/templates/products.phtml
@@ -1,25 +1,20 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
-?>
 
+?>
 <?php
 /**
  * Category view template
diff --git a/view/frontend/templates/view.phtml b/view/frontend/templates/view.phtml
index 76e95aa..31107ca 100644
--- a/view/frontend/templates/view.phtml
+++ b/view/frontend/templates/view.phtml
@@ -1,35 +1,25 @@
 <?php
 /**
- * Mageplaza
+ *                     Mageplaza_LayeredNavigation extension
+ *                     NOTICE OF LICENSE
  *
- * NOTICE OF LICENSE
+ *                     This source file is subject to the Mageplaza License
+ *                     that is bundled with this package in the file LICENSE.txt.
+ *                     It is also available through the world-wide-web at this URL:
+ *                     https://www.mageplaza.com/LICENSE.txt
  *
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
+ *                     @category  Mageplaza
+ *                     @package   Mageplaza_LayeredNavigation
+ *                     @copyright Copyright (c) 2016
+ *                     @license   https://www.mageplaza.com/LICENSE.txt
  */
 ?>
-
-<?php $lnHelper = \Magento\Framework\App\ObjectManager::getInstance()->get('Mageplaza\LayeredNavigation\Helper\Data'); ?>
 <?php if ($block->canShowBlock()): ?>
-    <?php
-    $wrapOptions = false;
-    $activeKey = 0;
-    $activeItems = '';
-    $displayConfig = $lnHelper->getDisplayConfig();
-    ?>
-
-    <div class="block filter" id="layered-filter-block">
+    <div class="block filter" id="layered-filter-block" data-mage-init='{"collapsible":{"openedState": "active", "collapsible": true, "active": false, "collateral": { "openedState": "filter-active", "element": "body" } }}'>
+        <?php $filtered = count($block->getLayer()->getState()->getFilters()) ?>
+        <div class="block-title filter-title" data-count="<?php /* @escapeNotVerified */ echo $filtered; ?>">
+            <strong data-role="title"><?php /* @escapeNotVerified */ echo __('Shop By') ?></strong>
+        </div>
         <div class="block-content filter-content">
             <?php echo $block->getChildHtml('state') ?>
 
@@ -38,46 +28,78 @@
                     <a href="<?php /* @escapeNotVerified */ echo $block->getClearUrl() ?>" class="action clear filter-clear"><span><?php /* @escapeNotVerified */ echo __('Clear All') ?></span></a>
                 </div>
             <?php endif; ?>
-
+            <?php $wrapOptions = false; $activeKey = 0; $activeArray = []; ?>
             <?php foreach ($block->getFilters() as $key => $filter): ?>
                 <?php if ($filter->getItemsCount()): ?>
                     <?php if (!$wrapOptions): ?>
                         <strong role="heading" aria-level="2" class="block-subtitle filter-subtitle"><?php /* @escapeNotVerified */ echo __('Shopping Options') ?></strong>
-                        <div class="filter-options" id="narrow-by-list">
+                        <div class="filter-options" id="narrow-by-list" data-role="content">
                     <?php  $wrapOptions = true; endif; ?>
-                    <div data-role="ln_collapsible" class="filter-options-item">
-                        <div data-role="ln_title" class="filter-options-title"><?php /* @escapeNotVerified */ echo __($filter->getName()) ?></div>
-                        <div data-role="ln_content" class="filter-options-content"><?php /* @escapeNotVerified */ echo $block->getChildBlock('renderer')->render($filter); ?></div>
+                    <div data-role="collapsible" class="filter-options-item">
+                        <div data-role="title" class="filter-options-title"><?php /* @escapeNotVerified */ echo __($filter->getName()) ?></div>
+                        <div data-role="content" class="filter-options-content"><?php /* @escapeNotVerified */ echo $block->getChildBlock('renderer')->render($filter); ?></div>
                     </div>
-                    <?php $activeItems .= ($displayConfig['auto_open'] == \Mageplaza\LayeredNavigation\Model\Config\Source\ActiveFilter::SHOW_ALL ||
-                                        ($displayConfig['auto_open'] == \Mageplaza\LayeredNavigation\Model\Config\Source\ActiveFilter::SHOW_ACTIVE &&
-                                            $block->getRequest()->getParam($filter->getRequestVar(), false)))
-                                        ? ' ' . $activeKey : '';
+                    <?php
+                        if($block->getRequest()->getParam($filter->getRequestVar())){
+                            $activeArray[] = $activeKey;
+                        }
                         $activeKey++;
                     ?>
                 <?php endif; ?>
             <?php endforeach; ?>
-            <?php if ($wrapOptions): ?></div><?php endif; ?>
-        </div>
-        <div id="ln_overlay" class="ln_overlay">
-            <img src="<?php /* @escapeNotVerified */ echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
+            <?php if ($wrapOptions): ?>
+                </div>
+				<script type="text/x-magento-init">
+					{
+						"#narrow-by-list": {
+							"accordion": {
+								"openedState": "active",
+								"collapsible": true,
+								"active": <?php echo sizeof($activeArray) ? $this->helper('Magento\Framework\Json\Helper\Data')->jsonEncode($activeArray) : 'false' ?>,
+								"multipleCollapsible": true
+							},
+							"Mageplaza_LayeredNavigation/js/layer": {}
+						}
+					}
+				</script>
+            <?php endif; ?>
+            <div id="ln_overlay" class="ln_overlay">
+                <img src="<?php /* @escapeNotVerified */ echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
+            </div>
+            <style type="text/css">
+                .ln_overlay{
+                    background-color: #FFFFFF;
+                    height: 100%;
+                    left: 0;
+                    opacity: 0.5;
+                    filter: alpha(opacity = 50);
+                    position: absolute;
+                    top: 0;
+                    width: 100%;
+                    z-index: 555;
+                    display:none;
+                }
+                .ln_overlay img {
+                    top: 30%;left: 45%;display: block;position: absolute;
+                }
+            </style>
         </div>
     </div>
-    <script type="text/x-magento-init">
-        {
-            "#layered-filter-block": {
-                "Mageplaza_LayeredNavigation/js/layer": {
-                    "openedState": "active",
-                    "collapsible": true,
-                    "active": "<?php echo $activeItems ?>",
-                    "multipleCollapsible": true,
-                    "animate": 200,
-                    "collapsibleElement": "[data-role=ln_collapsible]",
-                    "header": "[data-role=ln_title]",
-                    "content": "[data-role=ln_content]",
-                    "params": <?php echo $this->helper('Magento\Framework\Json\Helper\Data')->jsonEncode($block->getRequest()->getParams()) ?>
-                }
-            }
-        }
-    </script>
 <?php endif; ?>
+<style type="text/css">
+    .ln_overlay{
+        background-color: #FFFFFF;
+        height: 100%;
+        left: 0;
+        opacity: 0.5;
+        filter: alpha(opacity = 50);
+        position: absolute;
+        top: 0;
+        width: 100%;
+        z-index: 555;
+        display:none;
+    }
+    .ln_overlay img {
+        top: 30%;left: 45%;display: block;position: absolute;
+    }
+</style>
diff --git a/view/frontend/web/css/source/_module.less b/view/frontend/web/css/source/_module.less
deleted file mode 100644
index 7c23900..0000000
--- a/view/frontend/web/css/source/_module.less
+++ /dev/null
@@ -1,38 +0,0 @@
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
-
-.ln_overlay {
-  background-color: #FFFFFF;
-  height: 100%;
-  left: 0;
-  opacity: 0.5;
-  filter: alpha(opacity=50);
-  position: absolute;
-  top: 0;
-  width: 100%;
-  z-index: 555;
-  display: none;
-  img {
-    top: 40%;
-    left: 45%;
-    display: block;
-    position: fixed;
-  }
-}
\ No newline at end of file
diff --git a/view/frontend/web/js/layer.js b/view/frontend/web/js/layer.js
index 0ab6dfd..8e7bc33 100644
--- a/view/frontend/web/js/layer.js
+++ b/view/frontend/web/js/layer.js
@@ -1,32 +1,15 @@
 /**
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
+ * Copyright © 2016 Mageplaza. All rights reserved.
+ * See https://www.mageplaza.com/LICENSE.txt for license details.
  */
-
 define([
     'jquery',
     'jquery/ui',
-    'accordion',
     'productListToolbarForm'
 ], function ($) {
     "use strict";
 
-    $.widget('mageplaza.layer', $.mage.accordion, {
+    $.widget('mageplaza.layer', {
 
         options: {
             productsListSelector: '#layer-product-list',
@@ -34,8 +17,6 @@ define([
         },
 
         _create: function () {
-            this._super();
-
             this.initProductListUrl();
             this.initObserve();
             this.initLoading();
@@ -71,9 +52,7 @@ define([
             aElements.each(function (index) {
                 var el = $(this);
                 var link = self.checkUrl(el.prop('href'));
-                if (!link) {
-                    return;
-                }
+                if(!link) return;
 
                 el.bind('click', function (e) {
                     if (el.hasClass('swatch-option-link-layered')) {
@@ -96,22 +75,22 @@ define([
                 });
             });
 
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
+            $(".filter-current a").bind('click', function (e) {
+                var link = self.checkUrl($(this).prop('href'));
+                if(!link) return;
+
+                self.ajaxSubmit(link);
+                e.stopPropagation();
+                e.preventDefault();
+            });
+
+            $(".filter-actions a").bind('click', function (e) {
+                var link = self.checkUrl($(this).prop('href'));
+                if(!link) return;
+
+                self.ajaxSubmit(link);
+                e.stopPropagation();
+                e.preventDefault();
             });
         },
 
diff --git a/view/frontend/web/js/price/slider.js b/view/frontend/web/js/price/slider.js
index 31073ba..94cd52c 100644
--- a/view/frontend/web/js/price/slider.js
+++ b/view/frontend/web/js/price/slider.js
@@ -1,29 +1,13 @@
 /**
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
+ * Copyright © 2016 Mageplaza. All rights reserved.
+ * See https://www.mageplaza.com/LICENSE.txt for license details.
  */
-
 define([
     'jquery',
     'Magento_Catalog/js/price-utils',
     'jquery/ui',
     'Mageplaza_LayeredNavigation/js/layer'
-], function ($, ultil) {
+], function($, ultil) {
     "use strict";
 
     $.widget('mageplaza.layerSlider', $.mageplaza.layer, {
@@ -37,25 +21,25 @@ define([
                 min: self.options.minValue,
                 max: self.options.maxValue,
                 values: [self.options.selectedFrom, self.options.selectedTo],
-                slide: function ( event, ui ) {
+                slide: function( event, ui ) {
                     self.displayText(ui.values[0], ui.values[1]);
                 },
-                change: function (event, ui) {
+                change: function(event, ui) {
                     self.ajaxSubmit(self.getUrl(ui.values[0], ui.values[1]));
                 }
             });
             this.displayText(this.options.selectedFrom, this.options.selectedTo);
         },
 
-        getUrl: function (from, to) {
+        getUrl: function(from, to){
             return this.options.ajaxUrl.replace(encodeURI('{price_start}'), from).replace(encodeURI('{price_end}'), to);
         },
 
-        displayText: function (from, to) {
+        displayText: function(from, to){
             $(this.options.textElement).html(this.formatPrice(from) + ' - ' + this.formatPrice(to));
         },
 
-        formatPrice: function (value) {
+        formatPrice: function(value) {
             return ultil.formatPrice(value, this.options.priceFormat);
         }
     });
