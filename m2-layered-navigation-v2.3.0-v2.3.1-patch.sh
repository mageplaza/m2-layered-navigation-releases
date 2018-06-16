diff --git a/Api/Search/Document.php b/Api/Search/Document.php
index e9f1df4..4c3afb8 100644
--- a/Api/Search/Document.php
+++ b/Api/Search/Document.php
@@ -28,14 +28,14 @@ use Magento\Framework\Api\Search\Document as SourceDocument;
  */
 class Document extends SourceDocument
 {
-    /**
-     * Get Document field
-     *
-     * @param string $fieldName
-     * @return \Magento\Framework\Api\AttributeInterface
-     */
-    public function getField($fieldName)
-    {
-        return $this->getCustomAttribute($fieldName);
-    }
+	/**
+	 * Get Document field
+	 *
+	 * @param string $fieldName
+	 * @return \Magento\Framework\Api\AttributeInterface
+	 */
+	public function getField($fieldName)
+	{
+		return $this->getCustomAttribute($fieldName);
+	}
 }
diff --git a/CHANGELOG b/CHANGELOG
deleted file mode 100644
index 9c3cf10..0000000
--- a/CHANGELOG
+++ /dev/null
@@ -1 +0,0 @@
-CHANGELOG: https://www.mageplaza.com/changelog/m2-layered-navigation.txt
\ No newline at end of file
diff --git a/Controller/Search/Result/Index.php b/Controller/Search/Result/Index.php
index 0e3d78e..cd6af1e 100644
--- a/Controller/Search/Result/Index.php
+++ b/Controller/Search/Result/Index.php
@@ -33,113 +33,113 @@ use Magento\Store\Model\StoreManagerInterface;
  */
 class Index extends \Magento\Framework\App\Action\Action
 {
-    /**
-     * Catalog session
-     *
-     * @var Session
-     */
-    protected $_catalogSession;
+	/**
+	 * Catalog session
+	 *
+	 * @var Session
+	 */
+	protected $_catalogSession;
 
-    /**
-     * @var StoreManagerInterface
-     */
-    protected $_storeManager;
-    /**
-     * @type \Magento\Framework\Json\Helper\Data
-     */
-    protected $_jsonHelper;
-    /**
-     * @type \Mageplaza\LayeredNavigation\Helper\Data
-     */
-    protected $_moduleHelper;
-    /**
-     * @type \Magento\CatalogSearch\Helper\Data
-     */
-    protected $_helper;
-    /**
-     * @var QueryFactory
-     */
-    private $_queryFactory;
-    /**
-     * Catalog Layer Resolver
-     *
-     * @var Resolver
-     */
-    private $layerResolver;
+	/**
+	 * @var StoreManagerInterface
+	 */
+	protected $_storeManager;
+	/**
+	 * @type \Magento\Framework\Json\Helper\Data
+	 */
+	protected $_jsonHelper;
+	/**
+	 * @type \Mageplaza\LayeredNavigation\Helper\Data
+	 */
+	protected $_moduleHelper;
+	/**
+	 * @type \Magento\CatalogSearch\Helper\Data
+	 */
+	protected $_helper;
+	/**
+	 * @var QueryFactory
+	 */
+	private $_queryFactory;
+	/**
+	 * Catalog Layer Resolver
+	 *
+	 * @var Resolver
+	 */
+	private $layerResolver;
 
-    /**
-     * @param \Magento\Framework\App\Action\Context $context
-     * @param \Magento\Catalog\Model\Session $catalogSession
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Search\Model\QueryFactory $queryFactory
-     * @param \Magento\Catalog\Model\Layer\Resolver $layerResolver
-     * @param \Magento\CatalogSearch\Helper\Data $helper
-     * @param \Magento\Framework\Json\Helper\Data $jsonHelper
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
-    public function __construct(
-        Context $context,
-        Session $catalogSession,
-        StoreManagerInterface $storeManager,
-        QueryFactory $queryFactory,
-        Resolver $layerResolver,
-        \Magento\CatalogSearch\Helper\Data $helper,
-        \Magento\Framework\Json\Helper\Data $jsonHelper,
-        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-    ) {
-    
-        parent::__construct($context);
-        $this->_storeManager   = $storeManager;
-        $this->_catalogSession = $catalogSession;
-        $this->_queryFactory   = $queryFactory;
-        $this->layerResolver   = $layerResolver;
-        $this->_jsonHelper     = $jsonHelper;
-        $this->_moduleHelper   = $moduleHelper;
-        $this->_helper         = $helper;
-    }
+	/**
+	 * @param \Magento\Framework\App\Action\Context $context
+	 * @param \Magento\Catalog\Model\Session $catalogSession
+	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+	 * @param \Magento\Search\Model\QueryFactory $queryFactory
+	 * @param \Magento\Catalog\Model\Layer\Resolver $layerResolver
+	 * @param \Magento\CatalogSearch\Helper\Data $helper
+	 * @param \Magento\Framework\Json\Helper\Data $jsonHelper
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 */
+	public function __construct(
+		Context $context,
+		Session $catalogSession,
+		StoreManagerInterface $storeManager,
+		QueryFactory $queryFactory,
+		Resolver $layerResolver,
+		\Magento\CatalogSearch\Helper\Data $helper,
+		\Magento\Framework\Json\Helper\Data $jsonHelper,
+		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	)
+	{
+		parent::__construct($context);
+		$this->_storeManager   = $storeManager;
+		$this->_catalogSession = $catalogSession;
+		$this->_queryFactory   = $queryFactory;
+		$this->layerResolver   = $layerResolver;
+		$this->_jsonHelper     = $jsonHelper;
+		$this->_moduleHelper   = $moduleHelper;
+		$this->_helper         = $helper;
+	}
 
-    /**
-     * Display search result
-     *
-     * @return void
-     */
-    public function execute()
-    {
-        $this->layerResolver->create(Resolver::CATALOG_LAYER_SEARCH);
-        /* @var $query \Magento\Search\Model\Query */
-        $query = $this->_queryFactory->get();
+	/**
+	 * Display search result
+	 *
+	 * @return void
+	 */
+	public function execute()
+	{
+		$this->layerResolver->create(Resolver::CATALOG_LAYER_SEARCH);
+		/* @var $query \Magento\Search\Model\Query */
+		$query = $this->_queryFactory->get();
 
-        $query->setStoreId($this->_storeManager->getStore()->getId());
+		$query->setStoreId($this->_storeManager->getStore()->getId());
 
-        if ($query->getQueryText() != '') {
-            if ($this->_helper->isMinQueryLength()) {
-                $query->setId(0)->setIsActive(1)->setIsProcessed(1);
-            } else {
-                $query->saveIncrementalPopularity();
+		if ($query->getQueryText() != '') {
+			if ($this->_helper->isMinQueryLength()) {
+				$query->setId(0)->setIsActive(1)->setIsProcessed(1);
+			} else {
+				$query->saveIncrementalPopularity();
 
-                if ($query->getRedirect()) {
-                    $this->getResponse()->setRedirect($query->getRedirect());
+				if ($query->getRedirect()) {
+					$this->getResponse()->setRedirect($query->getRedirect());
 
-                    return;
-                }
-            }
+					return;
+				}
+			}
 
-            $this->_helper->checkNotes();
-            $this->_view->loadLayout();
+			$this->_helper->checkNotes();
+			$this->_view->loadLayout();
 
-            if ($this->_moduleHelper->isEnabled() && $this->getRequest()->isAjax()) {
-                $navigation = $this->_view->getLayout()->getBlock('catalogsearch.leftnav');
-                $products   = $this->_view->getLayout()->getBlock('search.result');
-                $result     = [
-                    'products' => $products->toHtml(),
-                    'navigation' => $navigation->toHtml()
-                ];
-                $this->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
-            } else {
-                $this->_view->renderLayout();
-            }
-        } else {
-            $this->getResponse()->setRedirect($this->_redirect->getRedirectUrl());
-        }
-    }
+			if ($this->_moduleHelper->isEnabled() && $this->getRequest()->isAjax()) {
+				$navigation = $this->_view->getLayout()->getBlock('catalogsearch.leftnav');
+				$products   = $this->_view->getLayout()->getBlock('search.result');
+				$result     = [
+					'products' => $products->toHtml(),
+					'navigation' => $navigation->toHtml()
+				];
+				$this->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
+			} else {
+				$this->_view->renderLayout();
+			}
+		} else {
+			$this->getResponse()->setRedirect($this->_redirect->getRedirectUrl());
+		}
+	}
 }
diff --git a/Helper/Data.php b/Helper/Data.php
index 1a9dbf1..00d62cb 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -29,68 +29,68 @@ use Mageplaza\Core\Helper\AbstractData;
  */
 class Data extends AbstractData
 {
-    const FILTER_TYPE_SLIDER = 'slider';
-    const FILTER_TYPE_LIST = 'list';
+	const FILTER_TYPE_SLIDER = 'slider';
+	const FILTER_TYPE_LIST = 'list';
 
-    /** @var \Mageplaza\LayeredNavigation\Model\Layer\Filter */
-    protected $filterModel;
+	/** @var \Mageplaza\LayeredNavigation\Model\Layer\Filter */
+	protected $filterModel;
 
-    /**
-     * @param null $storeId
-     *
-     * @return mixed
-     */
-    public function isEnabled($storeId = null)
-    {
-        return $this->getGeneralConfig('enable', $storeId) && $this->isModuleOutputEnabled();
-    }
+	/**
+	 * @param null $storeId
+	 *
+	 * @return mixed
+	 */
+	public function isEnabled($storeId = null)
+	{
+		return $this->getGeneralConfig('enable', $storeId) && $this->isModuleOutputEnabled();
+	}
 
-    /**
-     * @param string $code
-     * @param null $storeId
-     * @return mixed
-     */
-    public function getGeneralConfig($code = '', $storeId = null)
-    {
-        $code = ($code !== '') ? '/' . $code : '';
+	/**
+	 * @param string $code
+	 * @param null $storeId
+	 * @return mixed
+	 */
+	public function getGeneralConfig($code = '', $storeId = null)
+	{
+		$code = ($code !== '') ? '/' . $code : '';
 
-        return $this->getConfigValue('layered_navigation/general' . $code, $storeId);
-    }
+		return $this->getConfigValue('layered_navigation/general' . $code, $storeId);
+	}
 
-    /**
-     * @param $filters
-     * @return mixed
-     */
-    public function getLayerConfiguration($filters)
-    {
-        $filterParams = $this->_getRequest()->getParams();
-        $config       = new \Magento\Framework\DataObject([
-            'active' => array_keys($filterParams),
-            'params' => $filterParams
-        ]);
+	/**
+	 * @param $filters
+	 * @return mixed
+	 */
+	public function getLayerConfiguration($filters)
+	{
+		$filterParams = $this->_getRequest()->getParams();
+		$config       = new \Magento\Framework\DataObject([
+			'active' => array_keys($filterParams),
+			'params' => $filterParams
+		]);
 
-        $this->getFilterModel()->getLayerConfiguration($filters, $config);
+		$this->getFilterModel()->getLayerConfiguration($filters, $config);
 
-        return $this->objectManager->get('Magento\Framework\Json\EncoderInterface')->encode($config->getData());
-    }
+		return $this->objectManager->get('Magento\Framework\Json\EncoderInterface')->encode($config->getData());
+	}
 
-    /**
-     * @return \Mageplaza\LayeredNavigation\Model\Layer\Filter
-     */
-    public function getFilterModel()
-    {
-        if (!$this->filterModel) {
-            $this->filterModel = $this->objectManager->create('Mageplaza\LayeredNavigation\Model\Layer\Filter');
-        }
+	/**
+	 * @return \Mageplaza\LayeredNavigation\Model\Layer\Filter
+	 */
+	public function getFilterModel()
+	{
+		if (!$this->filterModel) {
+			$this->filterModel = $this->objectManager->create('Mageplaza\LayeredNavigation\Model\Layer\Filter');
+		}
 
-        return $this->filterModel;
-    }
+		return $this->filterModel;
+	}
 
-    /**
-     * @return \Magento\Framework\ObjectManagerInterface
-     */
-    public function getObjectManager()
-    {
-        return $this->objectManager;
-    }
+	/**
+	 * @return \Magento\Framework\ObjectManagerInterface
+	 */
+	public function getObjectManager()
+	{
+		return $this->objectManager;
+	}
 }
diff --git a/LICENSE b/LICENSE
deleted file mode 100644
index f9c459c..0000000
--- a/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-LICENSE: https://www.mageplaza.com/LICENSE.txt
\ No newline at end of file
diff --git a/Model/Layer/Filter.php b/Model/Layer/Filter.php
index b4a043e..93e95ee 100644
--- a/Model/Layer/Filter.php
+++ b/Model/Layer/Filter.php
@@ -30,162 +30,162 @@ use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
  */
 class Filter
 {
-    /** @var \Magento\Framework\App\RequestInterface */
-    protected $request;
-
-    /** @var array Slider types */
-    protected $sliderTypes = [LayerHelper::FILTER_TYPE_SLIDER];
-
-    /**
-     * Filter constructor.
-     * @param \Magento\Framework\App\RequestInterface $request
-     */
-    public function __construct(RequestInterface $request)
-    {
-        $this->request = $request;
-    }
-
-    /**
-     * Layered configuration for js widget
-     *
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filters
-     * @param $config
-     * @return mixed
-     */
-    public function getLayerConfiguration($filters, $config)
-    {
-        $slider = [];
-        foreach ($filters as $filter) {
-            if ($this->getIsSliderTypes($filter) && $filter->getItemsCount()) {
-                $slider[$filter->getRequestVar()] = $filter->getSliderConfig();
-            }
-        }
-        $config->setData('slider', $slider);
-
-        return $this;
-    }
-
-    /**
-     * @param $filter
-     * @param null $types
-     * @return bool
-     */
-    public function getIsSliderTypes($filter, $types = null)
-    {
-        $filterType = $this->getFilterType($filter);
-        $types      = $types ?: $this->sliderTypes;
-
-        return in_array($filterType, $types);
-    }
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-     * @param null $compareType
-     * @return bool|string
-     */
-    public function getFilterType($filter, $compareType = null)
-    {
-        $type = LayerHelper::FILTER_TYPE_LIST;
-        if ($filter->getRequestVar() == 'price') {
-            $type = LayerHelper::FILTER_TYPE_SLIDER;
-        }
-
-        return $compareType ? ($type == $compareType) : $type;
-    }
-
-    /**
-     * Get option url. If it has been filtered, return removed url. Else return filter url
-     *
-     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-     * @return mixed
-     */
-    public function getItemUrl($item)
-    {
-        if ($this->isSelected($item)) {
-            return $item->getRemoveUrl();
-        }
-
-        return $item->getUrl();
-    }
-
-    /**
-     * Check if option is selected or not
-     *
-     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-     * @return bool
-     */
-    public function isSelected($item)
-    {
-        $filterValue = $this->getFilterValue($item->getFilter());
-        if (!empty($filterValue) && in_array($item->getValue(), $filterValue)) {
-            return true;
-        }
-
-        return false;
-    }
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-     * @param bool|true $explode
-     * @return array|mixed
-     */
-    public function getFilterValue($filter, $explode = true)
-    {
-        $filterValue = $this->request->getParam($filter->getRequestVar());
-        if (empty($filterValue)) {
-            return [];
-        }
-
-        return $explode ? explode(',', $filterValue) : $filterValue;
-    }
-
-    /**
-     * Allow to show counter after options
-     *
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-     * @return bool
-     */
-    public function isShowCounter($filter)
-    {
-        return true;
-    }
-
-    /**
-     * Allow multiple filter
-     *
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-     * @return bool
-     */
-    public function isMultiple($filter)
-    {
-        return true;
-    }
-
-    /**
-     * Checks whether the option reduces the number of results
-     *
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-     * @param int $optionCount Count of search results with this option
-     * @param int $totalSize Current search results count
-     * @return bool
-     */
-    public function isOptionReducesResults($filter, $optionCount, $totalSize)
-    {
-        $result = $optionCount <= $totalSize;
-
-        if ($this->isShowZero($filter)) {
-            return $result;
-        }
-
-        return $optionCount && $result;
-    }
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-     * @return bool
-     */
-    public function isShowZero($filter)
-    {
-        return false;
-    }
-}
+	/** @var \Magento\Framework\App\RequestInterface */
+	protected $request;
+
+	/** @var array Slider types */
+	protected $sliderTypes = [LayerHelper::FILTER_TYPE_SLIDER];
+
+	/**
+	 * Filter constructor.
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 */
+	public function __construct(RequestInterface $request)
+	{
+		$this->request = $request;
+	}
+
+	/**
+	 * Layered configuration for js widget
+	 *
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filters
+	 * @param $config
+	 * @return mixed
+	 */
+	public function getLayerConfiguration($filters, $config)
+	{
+		$slider = [];
+		foreach ($filters as $filter) {
+			if ($this->getIsSliderTypes($filter) && $filter->getItemsCount()) {
+				$slider[$filter->getRequestVar()] = $filter->getSliderConfig();
+			}
+		}
+		$config->setData('slider', $slider);
+
+		return $this;
+	}
+
+	/**
+	 * @param $filter
+	 * @param null $types
+	 * @return bool
+	 */
+	public function getIsSliderTypes($filter, $types = null)
+	{
+		$filterType = $this->getFilterType($filter);
+		$types      = $types ?: $this->sliderTypes;
+
+		return in_array($filterType, $types);
+	}
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
+	 * @param null $compareType
+	 * @return bool|string
+	 */
+	public function getFilterType($filter, $compareType = null)
+	{
+		$type = LayerHelper::FILTER_TYPE_LIST;
+		if ($filter->getRequestVar() == 'price') {
+			$type = LayerHelper::FILTER_TYPE_SLIDER;
+		}
+
+		return $compareType ? ($type == $compareType) : $type;
+	}
+
+	/**
+	 * Get option url. If it has been filtered, return removed url. Else return filter url
+	 *
+	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
+	 * @return mixed
+	 */
+	public function getItemUrl($item)
+	{
+		if ($this->isSelected($item)) {
+			return $item->getRemoveUrl();
+		}
+
+		return $item->getUrl();
+	}
+
+	/**
+	 * Check if option is selected or not
+	 *
+	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
+	 * @return bool
+	 */
+	public function isSelected($item)
+	{
+		$filterValue = $this->getFilterValue($item->getFilter());
+		if (!empty($filterValue) && in_array($item->getValue(), $filterValue)) {
+			return true;
+		}
+
+		return false;
+	}
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
+	 * @param bool|true $explode
+	 * @return array|mixed
+	 */
+	public function getFilterValue($filter, $explode = true)
+	{
+		$filterValue = $this->request->getParam($filter->getRequestVar());
+		if (empty($filterValue)) {
+			return [];
+		}
+
+		return $explode ? explode(',', $filterValue) : $filterValue;
+	}
+
+	/**
+	 * Allow to show counter after options
+	 *
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
+	 * @return bool
+	 */
+	public function isShowCounter($filter)
+	{
+		return true;
+	}
+
+	/**
+	 * Allow multiple filter
+	 *
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
+	 * @return bool
+	 */
+	public function isMultiple($filter)
+	{
+		return true;
+	}
+
+	/**
+	 * Checks whether the option reduces the number of results
+	 *
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
+	 * @param int $optionCount Count of search results with this option
+	 * @param int $totalSize Current search results count
+	 * @return bool
+	 */
+	public function isOptionReducesResults($filter, $optionCount, $totalSize)
+	{
+		$result = $optionCount <= $totalSize;
+
+		if ($this->isShowZero($filter)) {
+			return $result;
+		}
+
+		return $optionCount && $result;
+	}
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
+	 * @return bool
+	 */
+	public function isShowZero($filter)
+	{
+		return false;
+	}
+}
\ No newline at end of file
diff --git a/Model/Layer/Filter/Attribute.php b/Model/Layer/Filter/Attribute.php
index 07327f6..15293f3 100644
--- a/Model/Layer/Filter/Attribute.php
+++ b/Model/Layer/Filter/Attribute.php
@@ -30,152 +30,152 @@ use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
  */
 class Attribute extends AbstractFilter
 {
-    /** @var \Mageplaza\LayeredNavigation\Helper\Data */
-    protected $_moduleHelper;
-
-    /** @var bool Is Filterable Flag */
-    protected $_isFilter = true;
-
-    /** @var \Magento\Framework\Filter\StripTags */
-    private $tagFilter;
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Catalog\Model\Layer $layer
-     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-     * @param \Magento\Framework\Filter\StripTags $tagFilter
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-        \Magento\Store\Model\StoreManagerInterface $storeManager,
-        \Magento\Catalog\Model\Layer $layer,
-        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-        \Magento\Framework\Filter\StripTags $tagFilter,
-        LayerHelper $moduleHelper,
-        array $data = []
-    ) {
-    
-        parent::__construct(
-            $filterItemFactory,
-            $storeManager,
-            $layer,
-            $itemDataBuilder,
-            $tagFilter,
-            $data
-        );
-        $this->tagFilter     = $tagFilter;
-        $this->_moduleHelper = $moduleHelper;
-    }
-
-    /**
-     * @inheritdoc
-     */
-    public function apply(\Magento\Framework\App\RequestInterface $request)
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return parent::apply($request);
-        }
-
-        $attributeValue = $request->getParam($this->_requestVar);
-        if (empty($attributeValue)) {
-            $this->_isFilter = false;
-
-            return $this;
-        }
-
-        $attributeValue = explode(',', $attributeValue);
-
-        $attribute = $this->getAttributeModel();
-        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-        $productCollection = $this->getLayer()
-            ->getProductCollection();
-        if (count($attributeValue) > 1) {
-            $productCollection->addFieldToFilter($attribute->getAttributeCode(), ['in' => $attributeValue]);
-        } else {
-            $productCollection->addFieldToFilter($attribute->getAttributeCode(), $attributeValue[0]);
-        }
-
-        $state = $this->getLayer()->getState();
-        foreach ($attributeValue as $value) {
-            $label = $this->getOptionText($value);
-            $state->addFilter($this->_createItem($label, $value));
-        }
-
-        return $this;
-    }
-
-    /**
-     * @inheritdoc
-     */
-    protected function _getItemsData()
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return parent::_getItemsData();
-        }
-
-        $attribute = $this->getAttributeModel();
-
-        /** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
-        $productCollection = $this->getLayer()->getProductCollection();
-
-        if ($this->_isFilter) {
-            $productCollection = $productCollection->getCollectionClone()
-                ->removeAttributeSearch($attribute->getAttributeCode());
-        }
-
-        $optionsFacetedData = $productCollection->getFacetedData($attribute->getAttributeCode());
-
-        if (count($optionsFacetedData) === 0
-            && $this->getAttributeIsFilterable($attribute) !== static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
-        ) {
-            return $this->itemDataBuilder->build();
-        }
-
-        $productSize = $productCollection->getSize();
-
-        $itemData   = [];
-        $checkCount = false;
-
-        $options = $attribute->getFrontend()
-            ->getSelectOptions();
-        foreach ($options as $option) {
-            if (empty($option['value'])) {
-                continue;
-            }
-
-            $value = $option['value'];
-
-            $count = isset($optionsFacetedData[$value]['count'])
-                ? (int)$optionsFacetedData[$value]['count']
-                : 0;
-
-            // Check filter type
-            if ($this->getAttributeIsFilterable($attribute) == static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
-                && (!$this->_moduleHelper->getFilterModel()->isOptionReducesResults($this, $count, $productSize))
-            ) {
-                continue;
-            }
-
-            if ($count > 0) {
-                $checkCount = true;
-            }
-
-            $itemData[] = [
-                'label' => $this->tagFilter->filter($option['label']),
-                'value' => $value,
-                'count' => $count
-            ];
-        }
-
-        if ($checkCount) {
-            foreach ($itemData as $item) {
-                $this->itemDataBuilder->addItemData($item['label'], $item['value'], $item['count']);
-            }
-        }
-
-        return $this->itemDataBuilder->build();
-    }
+	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
+	protected $_moduleHelper;
+
+	/** @var bool Is Filterable Flag */
+	protected $_isFilter = true;
+
+	/** @var \Magento\Framework\Filter\StripTags */
+	private $tagFilter;
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
+	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+	 * @param \Magento\Catalog\Model\Layer $layer
+	 * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
+	 * @param \Magento\Framework\Filter\StripTags $tagFilter
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 * @param array $data
+	 */
+	public function __construct(
+		\Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
+		\Magento\Store\Model\StoreManagerInterface $storeManager,
+		\Magento\Catalog\Model\Layer $layer,
+		\Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
+		\Magento\Framework\Filter\StripTags $tagFilter,
+		LayerHelper $moduleHelper,
+		array $data = []
+	)
+	{
+		parent::__construct(
+			$filterItemFactory,
+			$storeManager,
+			$layer,
+			$itemDataBuilder,
+			$tagFilter,
+			$data
+		);
+		$this->tagFilter     = $tagFilter;
+		$this->_moduleHelper = $moduleHelper;
+	}
+
+	/**
+	 * @inheritdoc
+	 */
+	public function apply(\Magento\Framework\App\RequestInterface $request)
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return parent::apply($request);
+		}
+
+		$attributeValue = $request->getParam($this->_requestVar);
+		if (empty($attributeValue)) {
+			$this->_isFilter = false;
+
+			return $this;
+		}
+
+		$attributeValue = explode(',', $attributeValue);
+
+		$attribute = $this->getAttributeModel();
+		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
+		$productCollection = $this->getLayer()
+			->getProductCollection();
+		if (count($attributeValue) > 1) {
+			$productCollection->addFieldToFilter($attribute->getAttributeCode(), ['in' => $attributeValue]);
+		} else {
+			$productCollection->addFieldToFilter($attribute->getAttributeCode(), $attributeValue[0]);
+		}
+
+		$state = $this->getLayer()->getState();
+		foreach ($attributeValue as $value) {
+			$label = $this->getOptionText($value);
+			$state->addFilter($this->_createItem($label, $value));
+		}
+
+		return $this;
+	}
+
+	/**
+	 * @inheritdoc
+	 */
+	protected function _getItemsData()
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return parent::_getItemsData();
+		}
+
+		$attribute = $this->getAttributeModel();
+
+		/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
+		$productCollection = $this->getLayer()->getProductCollection();
+
+		if ($this->_isFilter) {
+			$productCollection = $productCollection->getCollectionClone()
+				->removeAttributeSearch($attribute->getAttributeCode());
+		}
+
+		$optionsFacetedData = $productCollection->getFacetedData($attribute->getAttributeCode());
+
+		if (count($optionsFacetedData) === 0
+			&& $this->getAttributeIsFilterable($attribute) !== static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
+		) {
+			return $this->itemDataBuilder->build();
+		}
+
+		$productSize = $productCollection->getSize();
+
+		$itemData   = [];
+		$checkCount = false;
+
+		$options = $attribute->getFrontend()
+			->getSelectOptions();
+		foreach ($options as $option) {
+			if (empty($option['value'])) {
+				continue;
+			}
+
+			$value = $option['value'];
+
+			$count = isset($optionsFacetedData[$value]['count'])
+				? (int)$optionsFacetedData[$value]['count']
+				: 0;
+
+			// Check filter type
+			if ($this->getAttributeIsFilterable($attribute) == static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
+				&& (!$this->_moduleHelper->getFilterModel()->isOptionReducesResults($this, $count, $productSize))
+			) {
+				continue;
+			}
+
+			if ($count > 0) {
+				$checkCount = true;
+			}
+
+			$itemData[] = [
+				'label' => $this->tagFilter->filter($option['label']),
+				'value' => $value,
+				'count' => $count
+			];
+		}
+
+		if ($checkCount) {
+			foreach ($itemData as $item) {
+				$this->itemDataBuilder->addItemData($item['label'], $item['value'], $item['count']);
+			}
+		}
+
+		return $this->itemDataBuilder->build();
+	}
 }
diff --git a/Model/Layer/Filter/Category.php b/Model/Layer/Filter/Category.php
index e724e31..27bc69a 100644
--- a/Model/Layer/Filter/Category.php
+++ b/Model/Layer/Filter/Category.php
@@ -30,130 +30,130 @@ use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
  */
 class Category extends AbstractFilter
 {
-    /** @var \Mageplaza\LayeredNavigation\Helper\Data */
-    protected $_moduleHelper;
-
-    /** @var bool Is Filterable Flag */
-    protected $_isFilter = false;
-
-    /** @var \Magento\Framework\Escaper */
-    private $escaper;
-
-    /** @var  \Magento\Catalog\Model\Layer\Filter\DataProvider\Category */
-    private $dataProvider;
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Catalog\Model\Layer $layer
-     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-     * @param \Magento\Framework\Escaper $escaper
-     * @param \Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-        \Magento\Store\Model\StoreManagerInterface $storeManager,
-        \Magento\Catalog\Model\Layer $layer,
-        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-        \Magento\Framework\Escaper $escaper,
-        \Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory,
-        LayerHelper $moduleHelper,
-        array $data = []
-    ) {
-    
-        parent::__construct(
-            $filterItemFactory,
-            $storeManager,
-            $layer,
-            $itemDataBuilder,
-            $escaper,
-            $categoryDataProviderFactory,
-            $data
-        );
-
-        $this->escaper       = $escaper;
-        $this->_moduleHelper = $moduleHelper;
-        $this->dataProvider  = $categoryDataProviderFactory->create(['layer' => $this->getLayer()]);
-    }
-
-    /**
-     * @inheritdoc
-     */
-    public function apply(\Magento\Framework\App\RequestInterface $request)
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return parent::apply($request);
-        }
-
-        $categoryId = $request->getParam($this->_requestVar);
-        if (empty($categoryId)) {
-            return $this;
-        }
-
-        $categoryIds = [];
-        foreach (explode(',', $categoryId) as $key => $id) {
-            $this->dataProvider->setCategoryId($id);
-            if ($this->dataProvider->isValid()) {
-                $category = $this->dataProvider->getCategory();
-                if ($request->getParam('id') != $id) {
-                    $categoryIds[] = $id;
-                    $this->getLayer()->getState()->addFilter($this->_createItem($category->getName(), $id));
-                }
-            }
-        }
-
-        if (sizeof($categoryIds)) {
-            $this->_isFilter = true;
-            $this->getLayer()->getProductCollection()->addLayerCategoryFilter($categoryIds);
-        }
-
-        if ($parentCategoryId = $request->getParam('id')) {
-            $this->dataProvider->setCategoryId($parentCategoryId);
-        }
-
-        return $this;
-    }
-
-    /**
-     * @inheritdoc
-     */
-    protected function _getItemsData()
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return parent::_getItemsData();
-        }
-
-        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-        $productCollection = $this->getLayer()->getProductCollection();
-
-        if ($this->_isFilter) {
-            $productCollection = $productCollection->getCollectionClone()
-                ->removeAttributeSearch('category_ids');
-        }
-
-        $optionsFacetedData = $productCollection->getFacetedData('category');
-        $category           = $this->dataProvider->getCategory();
-        $categories         = $category->getChildrenCategories();
-
-        $collectionSize = $productCollection->getSize();
-
-        if ($category->getIsActive()) {
-            foreach ($categories as $category) {
-                $count = isset($optionsFacetedData[$category->getId()]) ? $optionsFacetedData[$category->getId()]['count'] : 0;
-                if ($category->getIsActive()
-                    && $this->_moduleHelper->getFilterModel()->isOptionReducesResults($this, $count, $collectionSize)
-                ) {
-                    $this->itemDataBuilder->addItemData(
-                        $this->escaper->escapeHtml($category->getName()),
-                        $category->getId(),
-                        $count
-                    );
-                }
-            }
-        }
-
-        return $this->itemDataBuilder->build();
-    }
+	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
+	protected $_moduleHelper;
+
+	/** @var bool Is Filterable Flag */
+	protected $_isFilter = false;
+
+	/** @var \Magento\Framework\Escaper */
+	private $escaper;
+
+	/** @var  \Magento\Catalog\Model\Layer\Filter\DataProvider\Category */
+	private $dataProvider;
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
+	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+	 * @param \Magento\Catalog\Model\Layer $layer
+	 * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
+	 * @param \Magento\Framework\Escaper $escaper
+	 * @param \Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 * @param array $data
+	 */
+	public function __construct(
+		\Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
+		\Magento\Store\Model\StoreManagerInterface $storeManager,
+		\Magento\Catalog\Model\Layer $layer,
+		\Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
+		\Magento\Framework\Escaper $escaper,
+		\Magento\Catalog\Model\Layer\Filter\DataProvider\CategoryFactory $categoryDataProviderFactory,
+		LayerHelper $moduleHelper,
+		array $data = []
+	)
+	{
+		parent::__construct(
+			$filterItemFactory,
+			$storeManager,
+			$layer,
+			$itemDataBuilder,
+			$escaper,
+			$categoryDataProviderFactory,
+			$data
+		);
+
+		$this->escaper       = $escaper;
+		$this->_moduleHelper = $moduleHelper;
+		$this->dataProvider  = $categoryDataProviderFactory->create(['layer' => $this->getLayer()]);
+	}
+
+	/**
+	 * @inheritdoc
+	 */
+	public function apply(\Magento\Framework\App\RequestInterface $request)
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return parent::apply($request);
+		}
+
+		$categoryId = $request->getParam($this->_requestVar);
+		if (empty($categoryId)) {
+			return $this;
+		}
+
+		$categoryIds = [];
+		foreach (explode(',', $categoryId) as $key => $id) {
+			$this->dataProvider->setCategoryId($id);
+			if ($this->dataProvider->isValid()) {
+				$category = $this->dataProvider->getCategory();
+				if ($request->getParam('id') != $id) {
+					$categoryIds[] = $id;
+					$this->getLayer()->getState()->addFilter($this->_createItem($category->getName(), $id));
+				}
+			}
+		}
+
+		if (sizeof($categoryIds)) {
+			$this->_isFilter = true;
+			$this->getLayer()->getProductCollection()->addLayerCategoryFilter($categoryIds);
+		}
+
+		if ($parentCategoryId = $request->getParam('id')) {
+			$this->dataProvider->setCategoryId($parentCategoryId);
+		}
+
+		return $this;
+	}
+
+	/**
+	 * @inheritdoc
+	 */
+	protected function _getItemsData()
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return parent::_getItemsData();
+		}
+
+		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
+		$productCollection = $this->getLayer()->getProductCollection();
+
+		if ($this->_isFilter) {
+			$productCollection = $productCollection->getCollectionClone()
+				->removeAttributeSearch('category_ids');
+		}
+
+		$optionsFacetedData = $productCollection->getFacetedData('category');
+		$category           = $this->dataProvider->getCategory();
+		$categories         = $category->getChildrenCategories();
+
+		$collectionSize = $productCollection->getSize();
+
+		if ($category->getIsActive()) {
+			foreach ($categories as $category) {
+				$count = isset($optionsFacetedData[$category->getId()]) ? $optionsFacetedData[$category->getId()]['count'] : 0;
+				if ($category->getIsActive()
+					&& $this->_moduleHelper->getFilterModel()->isOptionReducesResults($this, $count, $collectionSize)
+				) {
+					$this->itemDataBuilder->addItemData(
+						$this->escaper->escapeHtml($category->getName()),
+						$category->getId(),
+						$count
+					);
+				}
+			}
+		}
+
+		return $this->itemDataBuilder->build();
+	}
 }
diff --git a/Model/Layer/Filter/Price.php b/Model/Layer/Filter/Price.php
index 8280b67..8615eb1 100644
--- a/Model/Layer/Filter/Price.php
+++ b/Model/Layer/Filter/Price.php
@@ -30,235 +30,235 @@ use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
  */
 class Price extends AbstractFilter
 {
-    /** @var \Mageplaza\LayeredNavigation\Helper\Data */
-    protected $_moduleHelper;
-
-    /** @var array|null Filter value */
-    protected $_filterVal = null;
-
-    /** @var \Magento\Tax\Helper\Data */
-    protected $_taxHelper;
-
-    /** @var \Magento\Catalog\Model\Layer\Filter\DataProvider\Price */
-    private $dataProvider;
-
-    /** @var \Magento\Framework\Pricing\PriceCurrencyInterface */
-    private $priceCurrency;
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
-     * @param \Magento\Store\Model\StoreManagerInterface $storeManager
-     * @param \Magento\Catalog\Model\Layer $layer
-     * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
-     * @param \Magento\Catalog\Model\ResourceModel\Layer\Filter\Price $resource
-     * @param \Magento\Customer\Model\Session $customerSession
-     * @param \Magento\Framework\Search\Dynamic\Algorithm $priceAlgorithm
-     * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
-     * @param \Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory
-     * @param \Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory
-     * @param \Magento\Tax\Helper\Data $taxHelper
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     * @param array $data
-     */
-    public function __construct(
-        \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
-        \Magento\Store\Model\StoreManagerInterface $storeManager,
-        \Magento\Catalog\Model\Layer $layer,
-        \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
-        \Magento\Catalog\Model\ResourceModel\Layer\Filter\Price $resource,
-        \Magento\Customer\Model\Session $customerSession,
-        \Magento\Framework\Search\Dynamic\Algorithm $priceAlgorithm,
-        \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency,
-        \Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory,
-        \Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory,
-        \Magento\Tax\Helper\Data $taxHelper,
-        LayerHelper $moduleHelper,
-        array $data = []
-    ) {
-    
-        parent::__construct(
-            $filterItemFactory,
-            $storeManager,
-            $layer,
-            $itemDataBuilder,
-            $resource,
-            $customerSession,
-            $priceAlgorithm,
-            $priceCurrency,
-            $algorithmFactory,
-            $dataProviderFactory,
-            $data
-        );
-
-        $this->priceCurrency = $priceCurrency;
-        $this->dataProvider  = $dataProviderFactory->create(['layer' => $this->getLayer()]);
-        $this->_moduleHelper = $moduleHelper;
-        $this->_taxHelper    = $taxHelper;
-    }
-
-    /**
-     * @inheritdoc
-     */
-    public function apply(\Magento\Framework\App\RequestInterface $request)
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return parent::apply($request);
-        }
-        /**
-         * Filter must be string: $fromPrice-$toPrice
-         */
-        $filter = $request->getParam($this->getRequestVar());
-        if (!$filter || is_array($filter)) {
-            return $this;
-        }
-        $filterParams = explode(',', $filter);
-        $filter       = $this->dataProvider->validateFilter($filterParams[0]);
-        if (!$filter) {
-            return $this;
-        }
-
-        $this->dataProvider->setInterval($filter);
-        $priorFilters = $this->dataProvider->getPriorFilters($filterParams);
-        if ($priorFilters) {
-            $this->dataProvider->setPriorIntervals($priorFilters);
-        }
-
-        list($from, $to) = $this->_filterVal = $filter;
-
-        $this->getLayer()->getProductCollection()->addFieldToFilter(
-            'price',
-            ['from' => $from/$this->getCurrencyRate(), 'to' => $to/$this->getCurrencyRate()]
-        );
-
-        $this->getLayer()->getState()->addFilter(
-            $this->_createItem($this->_renderRangeLabel(empty($from) ? 0 : $from, $to), $filter)
-        );
-
-        return $this;
-    }
-
-    /**
-     * @inheritdoc
-     */
-    protected function _renderRangeLabel($fromPrice, $toPrice)
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return parent::_renderRangeLabel($fromPrice, $toPrice);
-        }
-        $formattedFromPrice = $this->priceCurrency->format($fromPrice);
-        if ($toPrice === '') {
-            return __('%1 and above', $formattedFromPrice);
-        } elseif ($fromPrice == $toPrice && $this->dataProvider->getOnePriceIntervalValue()) {
-            return $formattedFromPrice;
-        } else {
-            return __('%1 - %2', $formattedFromPrice, $this->priceCurrency->format($toPrice));
-        }
-    }
-
-    /**
-     * Price Slider Configuration
-     *
-     * @return array
-     */
-    public function getSliderConfig()
-    {
-        /** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
-        $productCollection = $this->getLayer()->getProductCollection();
-
-        if ($this->_filterVal) {
-            /** @type \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollectionClone */
-            $productCollection = $productCollection->getCollectionClone()
-                ->removeAttributeSearch(['price.from', 'price.to']);
-        }
-
-        $min = $productCollection->getMinPrice();
-        $max = $productCollection->getMaxPrice();
-
-        list($from, $to) = $this->_filterVal ?: [$min, $max];
-        $from = ($from < $min) ? $min : (($from > $max) ? $max : $from);
-        $to = ($to > $max) ? $max : (($to < $from) ? $from : $to);
-
-        $item = $this->getItems()[0];
-
-        return [
-            "selectedFrom" => $from,
-            "selectedTo"   => $to,
-            "minValue"     => $min,
-            "maxValue"     => $max,
-            "priceFormat"  => $this->_taxHelper->getPriceFormat(),
-            "ajaxUrl"      => $item->getUrl()
-        ];
-    }
-
-    /**
-     * Get data array for building attribute filter items
-     *
-     * @return array
-     *
-     * @SuppressWarnings(PHPMD.NPathComplexity)
-     */
-    protected function _getItemsData()
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return parent::_getItemsData();
-        }
-
-        $attribute         = $this->getAttributeModel();
-        $this->_requestVar = $attribute->getAttributeCode();
-
-        /** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
-        $productCollection = $this->getLayer()->getProductCollection();
-
-        if ($this->_filterVal) {
-            /** @type \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollectionClone */
-            $productCollection = $productCollection->getCollectionClone()
-                ->removeAttributeSearch(['price.from', 'price.to']);
-        }
-
-        $facets = $productCollection->getFacetedData($attribute->getAttributeCode());
-
-        $data = [];
-        if (count($facets) > 1) { // two range minimum
-            foreach ($facets as $key => $aggregation) {
-                $count = $aggregation['count'];
-                if (strpos($key, '_') === false) {
-                    continue;
-                }
-                $data[] = $this->prepareData($key, $count);
-            }
-        }
-
-        return $data;
-    }
-
-    /**
-     * @param string $key
-     * @param int $count
-     * @return array
-     */
-    private function prepareData($key, $count)
-    {
-        list($from, $to) = explode('_', $key);
-        if ($from == '*') {
-            $from = $this->getFrom($to);
-        }
-        if ($to == '*') {
-            $to = $this->getTo($to);
-        }
-        $label = $this->_renderRangeLabel(
-            empty($from) ? 0 : $from * $this->getCurrencyRate(),
-            empty($to) ? $to : $to * $this->getCurrencyRate()
-        );
-        $value = $from * $this->getCurrencyRate() . '-' . $to * $this->getCurrencyRate();// . $this->dataProvider->getAdditionalRequestData();
-
-        $data = [
-            'label' => $label,
-            'value' => $value,
-            'count' => $count,
-            'from'  => $from,
-            'to'    => $to,
-        ];
-
-        return $data;
-    }
+	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
+	protected $_moduleHelper;
+
+	/** @var array|null Filter value */
+	protected $_filterVal = null;
+
+	/** @var \Magento\Tax\Helper\Data */
+	protected $_taxHelper;
+
+	/** @var \Magento\Catalog\Model\Layer\Filter\DataProvider\Price */
+	private $dataProvider;
+
+	/** @var \Magento\Framework\Pricing\PriceCurrencyInterface */
+	private $priceCurrency;
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory
+	 * @param \Magento\Store\Model\StoreManagerInterface $storeManager
+	 * @param \Magento\Catalog\Model\Layer $layer
+	 * @param \Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder
+	 * @param \Magento\Catalog\Model\ResourceModel\Layer\Filter\Price $resource
+	 * @param \Magento\Customer\Model\Session $customerSession
+	 * @param \Magento\Framework\Search\Dynamic\Algorithm $priceAlgorithm
+	 * @param \Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency
+	 * @param \Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory
+	 * @param \Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory
+	 * @param \Magento\Tax\Helper\Data $taxHelper
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 * @param array $data
+	 */
+	public function __construct(
+		\Magento\Catalog\Model\Layer\Filter\ItemFactory $filterItemFactory,
+		\Magento\Store\Model\StoreManagerInterface $storeManager,
+		\Magento\Catalog\Model\Layer $layer,
+		\Magento\Catalog\Model\Layer\Filter\Item\DataBuilder $itemDataBuilder,
+		\Magento\Catalog\Model\ResourceModel\Layer\Filter\Price $resource,
+		\Magento\Customer\Model\Session $customerSession,
+		\Magento\Framework\Search\Dynamic\Algorithm $priceAlgorithm,
+		\Magento\Framework\Pricing\PriceCurrencyInterface $priceCurrency,
+		\Magento\Catalog\Model\Layer\Filter\Dynamic\AlgorithmFactory $algorithmFactory,
+		\Magento\Catalog\Model\Layer\Filter\DataProvider\PriceFactory $dataProviderFactory,
+		\Magento\Tax\Helper\Data $taxHelper,
+		LayerHelper $moduleHelper,
+		array $data = []
+	)
+	{
+		parent::__construct(
+			$filterItemFactory,
+			$storeManager,
+			$layer,
+			$itemDataBuilder,
+			$resource,
+			$customerSession,
+			$priceAlgorithm,
+			$priceCurrency,
+			$algorithmFactory,
+			$dataProviderFactory,
+			$data
+		);
+
+		$this->priceCurrency = $priceCurrency;
+		$this->dataProvider  = $dataProviderFactory->create(['layer' => $this->getLayer()]);
+		$this->_moduleHelper = $moduleHelper;
+		$this->_taxHelper    = $taxHelper;
+	}
+
+	/**
+	 * @inheritdoc
+	 */
+	public function apply(\Magento\Framework\App\RequestInterface $request)
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return parent::apply($request);
+		}
+		/**
+		 * Filter must be string: $fromPrice-$toPrice
+		 */
+		$filter = $request->getParam($this->getRequestVar());
+		if (!$filter || is_array($filter)) {
+			return $this;
+		}
+		$filterParams = explode(',', $filter);
+		$filter       = $this->dataProvider->validateFilter($filterParams[0]);
+		if (!$filter) {
+			return $this;
+		}
+
+		$this->dataProvider->setInterval($filter);
+		$priorFilters = $this->dataProvider->getPriorFilters($filterParams);
+		if ($priorFilters) {
+			$this->dataProvider->setPriorIntervals($priorFilters);
+		}
+
+		list($from, $to) = $this->_filterVal = $filter;
+
+		$this->getLayer()->getProductCollection()->addFieldToFilter(
+			'price',
+			['from' => $from/$this->getCurrencyRate(), 'to' => $to/$this->getCurrencyRate()]
+		);
+
+		$this->getLayer()->getState()->addFilter(
+			$this->_createItem($this->_renderRangeLabel(empty($from) ? 0 : $from, $to), $filter)
+		);
+
+		return $this;
+	}
+
+	/**
+	 * @inheritdoc
+	 */
+	protected function _renderRangeLabel($fromPrice, $toPrice)
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return parent::_renderRangeLabel($fromPrice, $toPrice);
+		}
+		$formattedFromPrice = $this->priceCurrency->format($fromPrice);
+		if ($toPrice === '') {
+			return __('%1 and above', $formattedFromPrice);
+		} elseif ($fromPrice == $toPrice && $this->dataProvider->getOnePriceIntervalValue()) {
+			return $formattedFromPrice;
+		} else {
+			return __('%1 - %2', $formattedFromPrice, $this->priceCurrency->format($toPrice));
+		}
+	}
+
+	/**
+	 * Price Slider Configuration
+	 *
+	 * @return array
+	 */
+	public function getSliderConfig()
+	{
+		/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollection */
+		$productCollection = $this->getLayer()->getProductCollection();
+
+		if ($this->_filterVal) {
+			/** @type \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollectionClone */
+			$productCollection = $productCollection->getCollectionClone()
+				->removeAttributeSearch(['price.from', 'price.to']);
+		}
+
+		$min = $productCollection->getMinPrice();
+		$max = $productCollection->getMaxPrice();
+
+		list($from, $to) = $this->_filterVal ?: [$min, $max];
+		$from = ($from < $min) ? $min : (($from > $max) ? $max : $from);
+		$to = ($to > $max) ? $max : (($to < $from) ? $from : $to);
+
+		$item = $this->getItems()[0];
+
+		return [
+			"selectedFrom" => $from,
+			"selectedTo"   => $to,
+			"minValue"     => $min,
+			"maxValue"     => $max,
+			"priceFormat"  => $this->_taxHelper->getPriceFormat(),
+			"ajaxUrl"      => $item->getUrl()
+		];
+	}
+
+	/**
+	 * Get data array for building attribute filter items
+	 *
+	 * @return array
+	 *
+	 * @SuppressWarnings(PHPMD.NPathComplexity)
+	 */
+	protected function _getItemsData()
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return parent::_getItemsData();
+		}
+
+		$attribute         = $this->getAttributeModel();
+		$this->_requestVar = $attribute->getAttributeCode();
+
+		/** @var \Magento\CatalogSearch\Model\ResourceModel\Fulltext\Collection $productCollection */
+		$productCollection = $this->getLayer()->getProductCollection();
+
+		if ($this->_filterVal) {
+			/** @type \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $productCollectionClone */
+			$productCollection = $productCollection->getCollectionClone()
+				->removeAttributeSearch(['price.from', 'price.to']);
+		}
+
+		$facets = $productCollection->getFacetedData($attribute->getAttributeCode());
+
+		$data = [];
+		if (count($facets) > 1) { // two range minimum
+			foreach ($facets as $key => $aggregation) {
+				$count = $aggregation['count'];
+				if (strpos($key, '_') === false) {
+					continue;
+				}
+				$data[] = $this->prepareData($key, $count);
+			}
+		}
+
+		return $data;
+	}
+
+	/**
+	 * @param string $key
+	 * @param int $count
+	 * @return array
+	 */
+	private function prepareData($key, $count)
+	{
+		list($from, $to) = explode('_', $key);
+		if ($from == '*') {
+			$from = $this->getFrom($to);
+		}
+		if ($to == '*') {
+			$to = $this->getTo($to);
+		}
+		$label = $this->_renderRangeLabel(
+			empty($from) ? 0 : $from * $this->getCurrencyRate(),
+			empty($to) ? $to : $to * $this->getCurrencyRate()
+		);
+		$value = $from * $this->getCurrencyRate() . '-' . $to * $this->getCurrencyRate();// . $this->dataProvider->getAdditionalRequestData();
+
+		$data = [
+			'label' => $label,
+			'value' => $value,
+			'count' => $count,
+			'from'  => $from,
+			'to'    => $to,
+		];
+
+		return $data;
+	}
 }
diff --git a/Model/ResourceModel/Fulltext/Collection.php b/Model/ResourceModel/Fulltext/Collection.php
index 96fdbba..132b157 100644
--- a/Model/ResourceModel/Fulltext/Collection.php
+++ b/Model/ResourceModel/Fulltext/Collection.php
@@ -34,448 +34,448 @@ use Magento\Framework\Search\Adapter\Mysql\TemporaryStorage;
  */
 class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 {
-    /** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection|null Clone collection */
-    public $collectionClone = null;
-
-    /** @var string */
-    private $queryText;
-
-    /** @var string|null */
-    private $order = null;
-
-    /** @var string */
-    private $searchRequestName;
-
-    /** @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory */
-    private $temporaryStorageFactory;
-
-    /** @var \Magento\Search\Api\SearchInterface */
-    private $search;
-
-    /** @var \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder */
-    private $searchCriteriaBuilder;
-
-    /** @var \Magento\Framework\Api\Search\SearchResultInterface */
-    private $searchResult;
-
-    /** @var \Magento\Framework\Api\FilterBuilder */
-    private $filterBuilder;
-
-    /**
-     * Collection constructor.
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
-     * @param \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory
-     * @param \Magento\Framework\DB\Adapter\AdapterInterface|null $connection
-     * @param string $searchRequestName
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
-        \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory,
-        \Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
-        $searchRequestName = 'catalog_view_container'
-    ) {
-    
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
-        $this->temporaryStorageFactory = $temporaryStorageFactory;
-        $this->searchRequestName       = $searchRequestName;
-    }
-
-    /**
-     * MP LayerNavigation Clone collection
-     *
-     * @return \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection|null
-     */
-    public function getCollectionClone()
-    {
-        if ($this->collectionClone === null) {
-            $this->collectionClone = clone $this;
-            $this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
-        }
-
-        $searchCriterialBuilder = $this->collectionClone->getSearchCriteriaBuilder()->cloneObject();
-
-        /** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $collectionClone */
-        $collectionClone = clone $this->collectionClone;
-        $collectionClone->setSearchCriteriaBuilder($searchCriterialBuilder);
-
-        return $collectionClone;
-    }
-
-    /**
-     * MP LayerNavigation Add multi-filter categories
-     *
-     * @param $categories
-     * @return $this
-     */
-    public function addLayerCategoryFilter($categories)
-    {
-        $this->addFieldToFilter('category_ids', implode(',', $categories));
-
-        return $this;
-    }
-
-    /**
-     * MP LayerNavigation remove filter to load option item data
-     *
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
-     * MP LayerNavigation Get attribute condition sql
-     *
-     * @param $attribute
-     * @param $condition
-     * @param string $joinType
-     * @return string
-     */
-    public function getAttributeConditionSql($attribute, $condition, $joinType = 'inner')
-    {
-        return $this->_getAttributeConditionSql($attribute, $condition, $joinType);
-    }
-
-    /**
-     * MP LayerNavigation Reset Total records
-     *
-     * @return $this
-     */
-    public function resetTotalRecords()
-    {
-        $this->_totalRecords = null;
-
-        return $this;
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
-     * @return \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder
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
-        $this->getCollectionClone();
-
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
-            $this->filterBuilder->setValue('auto');
-            $this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
-        }
-
-        $searchCriteria = $this->searchCriteriaBuilder->create();
-        $searchCriteria->setRequestName($this->searchRequestName);
-
-        try {
-            $this->searchResult = $this->getSearch()->search($searchCriteria);
-        } catch (\Exception $e) {
-            throw new LocalizedException(__('Sorry, something went wrong. You can find out more in the error log.'));
-        }
-
-        $temporaryStorage = $this->temporaryStorageFactory->create();
-        $table            = $temporaryStorage->storeDocuments($this->searchResult->getItems());
-
-        $this->getSelect()->joinInner(
-            [
-                'search_result' => $table->getName(),
-            ],
-            'e.entity_id = search_result.' . TemporaryStorage::FIELD_ENTITY_ID,
-            []
-        );
-
-        if ($this->order && 'relevance' === $this->order['field']) {
-            $this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
-        }
-
-        parent::_renderFiltersBefore();
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
+	/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection|null Clone collection */
+	public $collectionClone = null;
+
+	/** @var string */
+	private $queryText;
+
+	/** @var string|null */
+	private $order = null;
+
+	/** @var string */
+	private $searchRequestName;
+
+	/** @var \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory */
+	private $temporaryStorageFactory;
+
+	/** @var \Magento\Search\Api\SearchInterface */
+	private $search;
+
+	/** @var \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder */
+	private $searchCriteriaBuilder;
+
+	/** @var \Magento\Framework\Api\Search\SearchResultInterface */
+	private $searchResult;
+
+	/** @var \Magento\Framework\Api\FilterBuilder */
+	private $filterBuilder;
+
+	/**
+	 * Collection constructor.
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
+	 * @param \Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory
+	 * @param \Magento\Framework\DB\Adapter\AdapterInterface|null $connection
+	 * @param string $searchRequestName
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
+		\Magento\Framework\Search\Adapter\Mysql\TemporaryStorageFactory $temporaryStorageFactory,
+		\Magento\Framework\DB\Adapter\AdapterInterface $connection = null,
+		$searchRequestName = 'catalog_view_container'
+	)
+	{
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
+		$this->temporaryStorageFactory = $temporaryStorageFactory;
+		$this->searchRequestName       = $searchRequestName;
+	}
+
+	/**
+	 * MP LayerNavigation Clone collection
+	 *
+	 * @return \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection|null
+	 */
+	public function getCollectionClone()
+	{
+		if ($this->collectionClone === null) {
+			$this->collectionClone = clone $this;
+			$this->collectionClone->setSearchCriteriaBuilder($this->searchCriteriaBuilder->cloneObject());
+		}
+
+		$searchCriterialBuilder = $this->collectionClone->getSearchCriteriaBuilder()->cloneObject();
+
+		/** @var \Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\Collection $collectionClone */
+		$collectionClone = clone $this->collectionClone;
+		$collectionClone->setSearchCriteriaBuilder($searchCriterialBuilder);
+
+		return $collectionClone;
+	}
+
+	/**
+	 * MP LayerNavigation Add multi-filter categories
+	 *
+	 * @param $categories
+	 * @return $this
+	 */
+	public function addLayerCategoryFilter($categories)
+	{
+		$this->addFieldToFilter('category_ids', implode(',', $categories));
+
+		return $this;
+	}
+
+	/**
+	 * MP LayerNavigation remove filter to load option item data
+	 *
+	 * @param $attributeCode
+	 * @return $this
+	 */
+	public function removeAttributeSearch($attributeCode)
+	{
+		if (is_array($attributeCode)) {
+			foreach ($attributeCode as $attCode) {
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
+	 * MP LayerNavigation Get attribute condition sql
+	 *
+	 * @param $attribute
+	 * @param $condition
+	 * @param string $joinType
+	 * @return string
+	 */
+	public function getAttributeConditionSql($attribute, $condition, $joinType = 'inner')
+	{
+		return $this->_getAttributeConditionSql($attribute, $condition, $joinType);
+	}
+
+	/**
+	 * MP LayerNavigation Reset Total records
+	 *
+	 * @return $this
+	 */
+	public function resetTotalRecords()
+	{
+		$this->_totalRecords = null;
+
+		return $this;
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
+	 * @return \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder
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
+	 * @param \Mageplaza\LayeredNavigation\Model\Search\SearchCriteriaBuilder $object
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
+		$this->getCollectionClone();
+
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
+		$searchCriteria = $this->searchCriteriaBuilder->create();
+		$searchCriteria->setRequestName($this->searchRequestName);
+
+		try {
+			$this->searchResult = $this->getSearch()->search($searchCriteria);
+		} catch (\Exception $e) {
+			throw new LocalizedException(__('Sorry, something went wrong. You can find out more in the error log.'));
+		}
+
+		$temporaryStorage = $this->temporaryStorageFactory->create();
+		$table            = $temporaryStorage->storeDocuments($this->searchResult->getItems());
+
+		$this->getSelect()->joinInner(
+			[
+				'search_result' => $table->getName(),
+			],
+			'e.entity_id = search_result.' . TemporaryStorage::FIELD_ENTITY_ID,
+			[]
+		);
+
+		if ($this->order && 'relevance' === $this->order['field']) {
+			$this->getSelect()->order('search_result.' . TemporaryStorage::FIELD_SCORE . ' ' . $this->order['dir']);
+		}
+
+		parent::_renderFiltersBefore();
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
diff --git a/Model/Search/FilterGroupBuilder.php b/Model/Search/FilterGroupBuilder.php
index c507699..e874a49 100644
--- a/Model/Search/FilterGroupBuilder.php
+++ b/Model/Search/FilterGroupBuilder.php
@@ -32,73 +32,73 @@ use Magento\Framework\App\RequestInterface;
  */
 class FilterGroupBuilder extends SourceFilterGroupBuilder
 {
-    /** @var \Magento\Framework\App\RequestInterface */
-    protected $_request;
+	/** @var \Magento\Framework\App\RequestInterface */
+	protected $_request;
 
-    /**
-     * FilterGroupBuilder constructor.
-     * @param \Magento\Framework\Api\ObjectFactory $objectFactory
-     * @param \Magento\Framework\Api\FilterBuilder $filterBuilder
-     * @param \Magento\Framework\App\RequestInterface $request
-     */
-    public function __construct(
-        ObjectFactory $objectFactory,
-        FilterBuilder $filterBuilder,
-        RequestInterface $request
-    ) {
-    
-        parent::__construct($objectFactory, $filterBuilder);
+	/**
+	 * FilterGroupBuilder constructor.
+	 * @param \Magento\Framework\Api\ObjectFactory $objectFactory
+	 * @param \Magento\Framework\Api\FilterBuilder $filterBuilder
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 */
+	public function __construct(
+		ObjectFactory $objectFactory,
+		FilterBuilder $filterBuilder,
+		RequestInterface $request
+	)
+	{
+		parent::__construct($objectFactory, $filterBuilder);
 
-        $this->_request = $request;
-    }
+		$this->_request = $request;
+	}
 
-    /**
-     * @return FilterGroupBuilder
-     */
-    public function cloneObject()
-    {
-        $cloneObject = clone $this;
-        $cloneObject->setFilterBuilder(clone $this->_filterBuilder);
+	/**
+	 * @return FilterGroupBuilder
+	 */
+	public function cloneObject()
+	{
+		$cloneObject = clone $this;
+		$cloneObject->setFilterBuilder(clone $this->_filterBuilder);
 
-        return $cloneObject;
-    }
+		return $cloneObject;
+	}
 
-    /**
-     * @param $filterBuilder
-     */
-    public function setFilterBuilder($filterBuilder)
-    {
-        $this->_filterBuilder = $filterBuilder;
-    }
+	/**
+	 * @param $filterBuilder
+	 */
+	public function setFilterBuilder($filterBuilder)
+	{
+		$this->_filterBuilder = $filterBuilder;
+	}
 
-    /**
-     * @param $attributeCode
-     *
-     * @return $this
-     */
-    public function removeFilter($attributeCode)
-    {
-        if (isset($this->data[FilterGroup::FILTERS])) {
-            foreach ($this->data[FilterGroup::FILTERS] as $key => $filter) {
-                if ($filter->getField() == $attributeCode) {
-                    if (($attributeCode == 'category_ids') && ($filter->getValue() == $this->_request->getParam('id'))) {
-                        continue;
-                    }
-                    unset($this->data[FilterGroup::FILTERS][$key]);
-                }
-            }
-        }
+	/**
+	 * @param $attributeCode
+	 *
+	 * @return $this
+	 */
+	public function removeFilter($attributeCode)
+	{
+		if (isset($this->data[FilterGroup::FILTERS])) {
+			foreach ($this->data[FilterGroup::FILTERS] as $key => $filter) {
+				if ($filter->getField() == $attributeCode) {
+					if (($attributeCode == 'category_ids') && ($filter->getValue() == $this->_request->getParam('id'))) {
+						continue;
+					}
+					unset($this->data[FilterGroup::FILTERS][$key]);
+				}
+			}
+		}
 
-        return $this;
-    }
+		return $this;
+	}
 
-    /**
-     * Return the Data type class name
-     *
-     * @return string
-     */
-    protected function _getDataObjectType()
-    {
-        return 'Magento\Framework\Api\Search\FilterGroup';
-    }
+	/**
+	 * Return the Data type class name
+	 *
+	 * @return string
+	 */
+	protected function _getDataObjectType()
+	{
+		return 'Magento\Framework\Api\Search\FilterGroup';
+	}
 }
diff --git a/Model/Search/SearchCriteriaBuilder.php b/Model/Search/SearchCriteriaBuilder.php
index ffb0d70..d463130 100644
--- a/Model/Search/SearchCriteriaBuilder.php
+++ b/Model/Search/SearchCriteriaBuilder.php
@@ -30,58 +30,58 @@ use Magento\Framework\Api\SortOrderBuilder;
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
 
-    /**
-     * @param $attributeCode
-     *
-     * @return $this
-     */
-    public function removeFilter($attributeCode)
-    {
-        $this->filterGroupBuilder->removeFilter($attributeCode);
+	/**
+	 * @param $attributeCode
+	 *
+	 * @return $this
+	 */
+	public function removeFilter($attributeCode)
+	{
+		$this->filterGroupBuilder->removeFilter($attributeCode);
 
-        return $this;
-    }
+		return $this;
+	}
 
-    /**
-     * @return SearchCriteriaBuilder
-     */
-    public function cloneObject()
-    {
-        $cloneObject = clone $this;
-        $cloneObject->setFilterGroupBuilder($this->filterGroupBuilder->cloneObject());
+	/**
+	 * @return SearchCriteriaBuilder
+	 */
+	public function cloneObject()
+	{
+		$cloneObject = clone $this;
+		$cloneObject->setFilterGroupBuilder($this->filterGroupBuilder->cloneObject());
 
-        return $cloneObject;
-    }
+		return $cloneObject;
+	}
 
-    /**
-     * @param $filterGroupBuilder
-     */
-    public function setFilterGroupBuilder($filterGroupBuilder)
-    {
-        $this->filterGroupBuilder = $filterGroupBuilder;
-    }
+	/**
+	 * @param $filterGroupBuilder
+	 */
+	public function setFilterGroupBuilder($filterGroupBuilder)
+	{
+		$this->filterGroupBuilder = $filterGroupBuilder;
+	}
 
-    /**
-     * Return the Data type class name
-     *
-     * @return string
-     */
-    protected function _getDataObjectType()
-    {
-        return 'Magento\Framework\Api\Search\SearchCriteria';
-    }
+	/**
+	 * Return the Data type class name
+	 *
+	 * @return string
+	 */
+	protected function _getDataObjectType()
+	{
+		return 'Magento\Framework\Api\Search\SearchCriteria';
+	}
 }
diff --git a/Plugin/Block/Swatches/RenderLayered.php b/Plugin/Block/Swatches/RenderLayered.php
index 0691039..8bbcc7c 100644
--- a/Plugin/Block/Swatches/RenderLayered.php
+++ b/Plugin/Block/Swatches/RenderLayered.php
@@ -27,88 +27,88 @@ namespace Mageplaza\LayeredNavigation\Plugin\Block\Swatches;
  */
 class RenderLayered
 {
-    /** @var \Magento\Framework\UrlInterface */
-    protected $_url;
+	/** @var \Magento\Framework\UrlInterface */
+	protected $_url;
 
-    /** @var \Magento\Theme\Block\Html\Pager */
-    protected $_htmlPagerBlock;
+	/** @var \Magento\Theme\Block\Html\Pager */
+	protected $_htmlPagerBlock;
 
-    /** @var \Mageplaza\LayeredNavigation\Helper\Data */
-    protected $_moduleHelper;
+	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
+	protected $_moduleHelper;
 
-    /** @type \Magento\Catalog\Model\Layer\Filter\AbstractFilter */
-    protected $filter;
+	/** @type \Magento\Catalog\Model\Layer\Filter\AbstractFilter */
+	protected $filter;
 
-    /**
-     * RenderLayered constructor.
-     *
-     * @param \Magento\Framework\UrlInterface $url
-     * @param \Magento\Theme\Block\Html\Pager $htmlPagerBlock
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
-    public function __construct(
-        \Magento\Framework\UrlInterface $url,
-        \Magento\Theme\Block\Html\Pager $htmlPagerBlock,
-        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-    ) {
-    
-        $this->_url            = $url;
-        $this->_htmlPagerBlock = $htmlPagerBlock;
-        $this->_moduleHelper   = $moduleHelper;
-    }
+	/**
+	 * RenderLayered constructor.
+	 *
+	 * @param \Magento\Framework\UrlInterface $url
+	 * @param \Magento\Theme\Block\Html\Pager $htmlPagerBlock
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 */
+	public function __construct(
+		\Magento\Framework\UrlInterface $url,
+		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
+		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	)
+	{
+		$this->_url            = $url;
+		$this->_htmlPagerBlock = $htmlPagerBlock;
+		$this->_moduleHelper   = $moduleHelper;
+	}
 
-    /**
-     * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
-     * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
-     * @return array
-     */
-    public function beforeSetSwatchFilter(\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject, \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter)
-    {
-        $this->filter = $filter;
+	/**
+	 * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
+	 * @param \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter
+	 * @return array
+	 */
+	public function beforeSetSwatchFilter(\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject, \Magento\Catalog\Model\Layer\Filter\AbstractFilter $filter)
+	{
+		$this->filter = $filter;
 
-        return [$filter];
-    }
+		return [$filter];
+	}
 
-    /**
-     * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
-     * @param $proceed
-     * @param $attributeCode
-     * @param $optionId
-     *
-     * @return string
-     */
-    public function aroundBuildUrl(
-        \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject,
-        $proceed,
-        $attributeCode,
-        $optionId
-    ) {
-    
-        if (!$this->_moduleHelper->isEnabled()) {
-            return $proceed($attributeCode, $optionId);
-        }
+	/**
+	 * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
+	 * @param $proceed
+	 * @param $attributeCode
+	 * @param $optionId
+	 *
+	 * @return string
+	 */
+	public function aroundBuildUrl(
+		\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject,
+		$proceed,
+		$attributeCode,
+		$optionId
+	)
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return $proceed($attributeCode, $optionId);
+		}
 
-        $attHelper = $this->_moduleHelper->getFilterModel();
-        if ($attHelper->isMultiple($this->filter)) {
-            $value = $attHelper->getFilterValue($this->filter);
+		$attHelper = $this->_moduleHelper->getFilterModel();
+		if ($attHelper->isMultiple($this->filter)) {
+			$value = $attHelper->getFilterValue($this->filter);
 
-            if (!in_array($optionId, $value)) {
-                $value[] = $optionId;
-            } else {
-                $key = array_search($optionId, $value);
-                if ($key !== false) {
-                    unset($value[$key]);
-                }
-            }
-        } else {
-            $value = [$optionId];
-        }
+			if (!in_array($optionId, $value)) {
+				$value[] = $optionId;
+			} else {
+				$key = array_search($optionId, $value);
+				if ($key !== false) {
+					unset($value[$key]);
+				}
+			}
+		} else {
+			$value = [$optionId];
+		}
 
-        $query = !empty($value) ? [$attributeCode => implode(',', $value)] : '';
+		$query = !empty($value) ? [$attributeCode => implode(',', $value)] : '';
 
-        return $this->_url->getUrl(
-            '*/*/*',
-            ['_current' => true, '_use_rewrite' => true, '_query' => $query]
-        );
-    }
+		return $this->_url->getUrl(
+			'*/*/*',
+			['_current' => true, '_use_rewrite' => true, '_query' => $query]
+		);
+	}
 }
diff --git a/Plugin/Controller/Category/View.php b/Plugin/Controller/Category/View.php
index d2f6af1..3095221 100644
--- a/Plugin/Controller/Category/View.php
+++ b/Plugin/Controller/Category/View.php
@@ -27,39 +27,39 @@ namespace Mageplaza\LayeredNavigation\Plugin\Controller\Category;
  */
 class View
 {
-    /** @var \Magento\Framework\Json\Helper\Data */
-    protected $_jsonHelper;
+	/** @var \Magento\Framework\Json\Helper\Data */
+	protected $_jsonHelper;
 
-    /** @var \Mageplaza\LayeredNavigation\Helper\Data */
-    protected $_moduleHelper;
+	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
+	protected $_moduleHelper;
 
-    /**
-     * @param \Magento\Framework\Json\Helper\Data $jsonHelper
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
-    public function __construct(
-        \Magento\Framework\Json\Helper\Data $jsonHelper,
-        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-    ) {
-    
-        $this->_jsonHelper   = $jsonHelper;
-        $this->_moduleHelper = $moduleHelper;
-    }
+	/**
+	 * @param \Magento\Framework\Json\Helper\Data $jsonHelper
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 */
+	public function __construct(
+		\Magento\Framework\Json\Helper\Data $jsonHelper,
+		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	)
+	{
+		$this->_jsonHelper   = $jsonHelper;
+		$this->_moduleHelper = $moduleHelper;
+	}
 
-    /**
-     * @param \Magento\Catalog\Controller\Category\View $action
-     * @param $page
-     * @return mixed
-     */
-    public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
-    {
-        if ($this->_moduleHelper->isEnabled() && $action->getRequest()->isAjax()) {
-            $navigation = $page->getLayout()->getBlock('catalog.leftnav');
-            $products   = $page->getLayout()->getBlock('category.products');
-            $result     = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
-            $action->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
-        } else {
-            return $page;
-        }
-    }
+	/**
+	 * @param \Magento\Catalog\Controller\Category\View $action
+	 * @param $page
+	 * @return mixed
+	 */
+	public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
+	{
+		if ($this->_moduleHelper->isEnabled() && $action->getRequest()->isAjax()) {
+			$navigation = $page->getLayout()->getBlock('catalog.leftnav');
+			$products   = $page->getLayout()->getBlock('category.products');
+			$result     = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
+			$action->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
+		} else {
+			return $page;
+		}
+	}
 }
diff --git a/Plugin/Model/Adapter/Preprocessor.php b/Plugin/Model/Adapter/Preprocessor.php
index 7a8b8ff..040d74f 100644
--- a/Plugin/Model/Adapter/Preprocessor.php
+++ b/Plugin/Model/Adapter/Preprocessor.php
@@ -26,35 +26,35 @@ namespace Mageplaza\LayeredNavigation\Plugin\Model\Adapter;
  */
 class Preprocessor
 {
-    /**
-     * @type \Mageplaza\LayeredNavigation\Helper\Data
-     */
-    protected $_moduleHelper;
+	/**
+	 * @type \Mageplaza\LayeredNavigation\Helper\Data
+	 */
+	protected $_moduleHelper;
 
-    /**
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
-    public function __construct(
-        \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-    ) {
-    
-        $this->_moduleHelper   = $moduleHelper;
-    }
+	/**
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 */
+	public function __construct(
+		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	)
+	{
+		$this->_moduleHelper   = $moduleHelper;
+	}
 
-    /**
-     * @param \Magento\CatalogSearch\Model\Adapter\Mysql\Filter\Preprocessor $subject
-     * @param \Closure $proceed
-     * @param $filter
-     * @param $isNegation
-     * @param $query
-     * @return string
-     */
-    public function aroundProcess(\Magento\CatalogSearch\Model\Adapter\Mysql\Filter\Preprocessor $subject, \Closure $proceed, $filter, $isNegation, $query)
-    {
-        if ($this->_moduleHelper->isEnabled() && ($filter->getField() === 'category_ids')) {
-            return 'category_ids_index.category_id IN (' . $filter->getValue() . ')';
-        }
+	/**
+	 * @param \Magento\CatalogSearch\Model\Adapter\Mysql\Filter\Preprocessor $subject
+	 * @param \Closure $proceed
+	 * @param $filter
+	 * @param $isNegation
+	 * @param $query
+	 * @return string
+	 */
+	public function aroundProcess(\Magento\CatalogSearch\Model\Adapter\Mysql\Filter\Preprocessor $subject, \Closure $proceed, $filter, $isNegation, $query)
+	{
+		if ($this->_moduleHelper->isEnabled() && ($filter->getField() === 'category_ids')) {
+			return 'category_ids_index.category_id IN (' . $filter->getValue() . ')';
+		}
 
-        return $proceed($filter, $isNegation, $query);
-    }
+		return $proceed($filter, $isNegation, $query);
+	}
 }
diff --git a/Plugin/Model/Layer/Filter/Item.php b/Plugin/Model/Layer/Filter/Item.php
index 8438515..01b3ad6 100644
--- a/Plugin/Model/Layer/Filter/Item.php
+++ b/Plugin/Model/Layer/Filter/Item.php
@@ -29,106 +29,106 @@ use Mageplaza\LayeredNavigation\Helper\Data as LayerHelper;
  */
 class Item
 {
-    /** @var \Magento\Framework\UrlInterface */
-    protected $_url;
-
-    /** @var \Magento\Theme\Block\Html\Pager */
-    protected $_htmlPagerBlock;
-
-    /** @var \Magento\Framework\App\RequestInterface */
-    protected $_request;
-
-    /** @var \Mageplaza\LayeredNavigation\Helper\Data */
-    protected $_moduleHelper;
-
-    /**
-     * Item constructor.
-     *
-     * @param \Magento\Framework\UrlInterface $url
-     * @param \Magento\Theme\Block\Html\Pager $htmlPagerBlock
-     * @param \Magento\Framework\App\RequestInterface $request
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
-    public function __construct(
-        \Magento\Framework\UrlInterface $url,
-        \Magento\Theme\Block\Html\Pager $htmlPagerBlock,
-        \Magento\Framework\App\RequestInterface $request,
-        LayerHelper $moduleHelper
-    ) {
-    
-        $this->_url            = $url;
-        $this->_htmlPagerBlock = $htmlPagerBlock;
-        $this->_request        = $request;
-        $this->_moduleHelper   = $moduleHelper;
-    }
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-     * @param $proceed
-     * @return string
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    public function aroundGetUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return $proceed();
-        }
-
-        $value     = [];
-        $filter    = $item->getFilter();
-        $filterModel = $this->_moduleHelper->getFilterModel();
-        if ($filterModel->getIsSliderTypes($filter) || $filter->getData('range_mode')) {
-            $value = ["from-to"];
-        } elseif ($filterModel->isMultiple($filter)) {
-            $requestVar = $filter->getRequestVar();
-            if ($requestValue = $this->_request->getParam($requestVar)) {
-                $value = explode(',', $requestValue);
-            }
-            if (!in_array($item->getValue(), $value)) {
-                $value[] = $item->getValue();
-            }
-        }
-
-        if (sizeof($value)) {
-            $query = [
-                $filter->getRequestVar()                 => implode(',', $value),
-                // exclude current page from urls
-                $this->_htmlPagerBlock->getPageVarName() => null,
-            ];
-
-            return $this->_url->getUrl('*/*/*', ['_current' => true, '_use_rewrite' => true, '_query' => $query]);
-        }
-
-        return $proceed();
-    }
-
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-     * @param $proceed
-     * @return string
-     * @throws \Magento\Framework\Exception\LocalizedException
-     */
-    public function aroundGetRemoveUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
-    {
-        if (!$this->_moduleHelper->isEnabled()) {
-            return $proceed();
-        }
-
-        $value     = [];
-        $filter    = $item->getFilter();
-        $filterModel = $this->_moduleHelper->getFilterModel();
-        if ($filterModel->isMultiple($filter)) {
-            $value = $filterModel->getFilterValue($filter);
-            if (in_array($item->getValue(), $value)) {
-                $value = array_diff($value, [$item->getValue()]);
-            }
-        }
-
-        $params['_query']       = [$filter->getRequestVar() => count($value) ? implode(',', $value) : $filter->getResetValue()];
-        $params['_current']     = true;
-        $params['_use_rewrite'] = true;
-        $params['_escape']      = true;
-
-        return $this->_url->getUrl('*/*/*', $params);
-    }
+	/** @var \Magento\Framework\UrlInterface */
+	protected $_url;
+
+	/** @var \Magento\Theme\Block\Html\Pager */
+	protected $_htmlPagerBlock;
+
+	/** @var \Magento\Framework\App\RequestInterface */
+	protected $_request;
+
+	/** @var \Mageplaza\LayeredNavigation\Helper\Data */
+	protected $_moduleHelper;
+
+	/**
+	 * Item constructor.
+	 *
+	 * @param \Magento\Framework\UrlInterface $url
+	 * @param \Magento\Theme\Block\Html\Pager $htmlPagerBlock
+	 * @param \Magento\Framework\App\RequestInterface $request
+	 * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
+	 */
+	public function __construct(
+		\Magento\Framework\UrlInterface $url,
+		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
+		\Magento\Framework\App\RequestInterface $request,
+		LayerHelper $moduleHelper
+	)
+	{
+		$this->_url            = $url;
+		$this->_htmlPagerBlock = $htmlPagerBlock;
+		$this->_request        = $request;
+		$this->_moduleHelper   = $moduleHelper;
+	}
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
+	 * @param $proceed
+	 * @return string
+	 * @throws \Magento\Framework\Exception\LocalizedException
+	 */
+	public function aroundGetUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return $proceed();
+		}
+
+		$value     = [];
+		$filter    = $item->getFilter();
+		$filterModel = $this->_moduleHelper->getFilterModel();
+		if ($filterModel->getIsSliderTypes($filter) || $filter->getData('range_mode')) {
+			$value = ["from-to"];
+		} else if ($filterModel->isMultiple($filter)) {
+			$requestVar = $filter->getRequestVar();
+			if ($requestValue = $this->_request->getParam($requestVar)) {
+				$value = explode(',', $requestValue);
+			}
+			if (!in_array($item->getValue(), $value)) {
+				$value[] = $item->getValue();
+			}
+		}
+
+		if (sizeof($value)) {
+			$query = [
+				$filter->getRequestVar()                 => implode(',', $value),
+				// exclude current page from urls
+				$this->_htmlPagerBlock->getPageVarName() => null,
+			];
+
+			return $this->_url->getUrl('*/*/*', ['_current' => true, '_use_rewrite' => true, '_query' => $query]);
+		}
+
+		return $proceed();
+	}
+
+	/**
+	 * @param \Magento\Catalog\Model\Layer\Filter\Item $item
+	 * @param $proceed
+	 * @return string
+	 * @throws \Magento\Framework\Exception\LocalizedException
+	 */
+	public function aroundGetRemoveUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
+	{
+		if (!$this->_moduleHelper->isEnabled()) {
+			return $proceed();
+		}
+
+		$value     = [];
+		$filter    = $item->getFilter();
+		$filterModel = $this->_moduleHelper->getFilterModel();
+		if ($filterModel->isMultiple($filter)) {
+			$value = $filterModel->getFilterValue($filter);
+			if (in_array($item->getValue(), $value)) {
+				$value = array_diff($value, [$item->getValue()]);
+			}
+		}
+
+		$params['_query']       = [$filter->getRequestVar() => count($value) ? implode(',', $value) : $filter->getResetValue()];
+		$params['_current']     = true;
+		$params['_use_rewrite'] = true;
+		$params['_escape']      = true;
+
+		return $this->_url->getUrl('*/*/*', $params);
+	}
 }
diff --git a/README.md b/README.md
index 7a04410..cea9a12 100644
--- a/README.md
+++ b/README.md
@@ -1,58 +1,5 @@
-## Documentation
+How to install: https://docs.mageplaza.com/kb/installation.html
 
-- Installation guide: https://docs.mageplaza.com/kb/installation.html
-- User Guide: https://docs.mageplaza.com/layered-navigation-m2/
-- Product page: https://www.mageplaza.com/magento-2-layered-navigation-extension/
-- Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
-- Changelog: https://www.mageplaza.com/changelog/m2-layered-navigation.txt
-- License agreement: https://www.mageplaza.com/LICENSE.txt
+User Guide: https://docs.mageplaza.com/layered-navigation-m2/
 
-
-
-## How to install
-
-### Method 1: Install ready-to-paste package (Recommended)
-
-- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
-- Installation guide: https://docs.mageplaza.com/kb/installation.html
-
-
-
-### Method 2: Manually install via composer
-
-1. Access to your server via SSH
-2. Create a folder (Not Magento root directory) in called: `mageplaza`, 
-3. Download the zip package at https://store.mageplaza.com/my-downloadable-products.html
-4. Upload the zip package to `mageplaza` folder.
-
-
-3. Add the following snippet to `composer.json`
-
-```
-	{
-		"repositories": [
-		 {
-		 "type": "artifact",
-		 "url": "mageplaza/"
-		 }
-		]
-	}
-```
-
-4. Run composer command line
-
-```
-composer require mageplaza/layered-navigation-m2
-php bin/magento setup:upgrade
-php bin/magento setup:static-content:deploy
-```
-
-## FAQs
-
-
-#### Q: I got error: `Mageplaza_Core has been already defined`
-A: Read solution: https://github.com/mageplaza/module-core/issues/3
-
-
-#### Q: My site is down
-A: Please follow this guide: https://www.mageplaza.com/blog/magento-site-down.html
+Help: https://mageplaza.freshdesk.com/
\ No newline at end of file
diff --git a/USER-GUIDE.md b/USER-GUIDE.md
deleted file mode 100644
index 7a04410..0000000
--- a/USER-GUIDE.md
+++ /dev/null
@@ -1,58 +0,0 @@
-## Documentation
-
-- Installation guide: https://docs.mageplaza.com/kb/installation.html
-- User Guide: https://docs.mageplaza.com/layered-navigation-m2/
-- Product page: https://www.mageplaza.com/magento-2-layered-navigation-extension/
-- Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
-- Changelog: https://www.mageplaza.com/changelog/m2-layered-navigation.txt
-- License agreement: https://www.mageplaza.com/LICENSE.txt
-
-
-
-## How to install
-
-### Method 1: Install ready-to-paste package (Recommended)
-
-- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
-- Installation guide: https://docs.mageplaza.com/kb/installation.html
-
-
-
-### Method 2: Manually install via composer
-
-1. Access to your server via SSH
-2. Create a folder (Not Magento root directory) in called: `mageplaza`, 
-3. Download the zip package at https://store.mageplaza.com/my-downloadable-products.html
-4. Upload the zip package to `mageplaza` folder.
-
-
-3. Add the following snippet to `composer.json`
-
-```
-	{
-		"repositories": [
-		 {
-		 "type": "artifact",
-		 "url": "mageplaza/"
-		 }
-		]
-	}
-```
-
-4. Run composer command line
-
-```
-composer require mageplaza/layered-navigation-m2
-php bin/magento setup:upgrade
-php bin/magento setup:static-content:deploy
-```
-
-## FAQs
-
-
-#### Q: I got error: `Mageplaza_Core has been already defined`
-A: Read solution: https://github.com/mageplaza/module-core/issues/3
-
-
-#### Q: My site is down
-A: Please follow this guide: https://www.mageplaza.com/blog/magento-site-down.html
diff --git a/composer.json b/composer.json
index 024a4cf..0fc9a70 100644
--- a/composer.json
+++ b/composer.json
@@ -6,7 +6,10 @@
   },
   "type": "magento2-module",
   "version": "2.2.0",
-  "license": "Mageplaza License",
+  "license": [
+    "OSL-3.0",
+    "AFL-3.0"
+  ],
   "authors": [
     {
       "name": "Mageplaza",
diff --git a/i18n/af_ZA.csv b/i18n/af_ZA.csv
deleted file mode 100644
index 873881c..0000000
--- a/i18n/af_ZA.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 en hoër"
-"%1 - %2","%1 - %2"
-"Price Slider","Prys Slider"
-"Sorry, something went wrong. You can find out more in the error log.","Jammer, iets het verkeerd gegaan. U kan meer uitvind in die foutlogboek."
-"Bucket does not exist","Emmer bestaan ​​nie"
-"Shop By","Winkel By"
-"Clear All","Maak alles skoon"
-"Shopping Options","Shopping Options"
-"Layered Navigation","Gelaagde navigasie"
-"General Configuration","Algemene konfigurasie"
-"Module Enable","Module Aktiveer"
\ No newline at end of file
diff --git a/i18n/ar_SA.csv b/i18n/ar_SA.csv
deleted file mode 100644
index ec4f623..0000000
--- a/i18n/ar_SA.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 وما فوقها"
-"%1 - %2","%1 - %2"
-"Price Slider","السعر المنزلق"
-"Sorry, something went wrong. You can find out more in the error log.","عذرا، هناك خطأ ما. يمكنك معرفة المزيد في سجل الأخطاء."
-"Bucket does not exist","دلو غير موجود"
-"Shop By","تسوق بواسطة"
-"Clear All","امسح الكل"
-"Shopping Options","خيارات التسوق"
-"Layered Navigation","التنقل عبر الطبقات"
-"General Configuration","التكوين العام"
-"Module Enable","تمكين الوحدة"
\ No newline at end of file
diff --git a/i18n/be_BY.csv b/i18n/be_BY.csv
deleted file mode 100644
index 05bc34e..0000000
--- a/i18n/be_BY.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 і вышэй"
-"%1 - %2","%1 - %2"
-"Price Slider","кошт Slider"
-"Sorry, something went wrong. You can find out more in the error log.","На жаль, што-то пайшло не так. Вы можаце даведацца больш у часопісе памылак."
-"Bucket does not exist","Коўш не існуе"
-"Shop By","крама па"
-"Clear All","ачысціць ўсе"
-"Shopping Options","варыянты тавараў"
-"Layered Navigation","шматузроўневая рух"
-"General Configuration","агульная канфігурацыя"
-"Module Enable","модуль Уключыць"
\ No newline at end of file
diff --git a/i18n/ca_ES.csv b/i18n/ca_ES.csv
deleted file mode 100644
index 114085e..0000000
--- a/i18n/ca_ES.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 i superior"
-"%1 - %2","%1 - %2"
-"Price Slider","Control lliscant de preus"
-"Sorry, something went wrong. You can find out more in the error log.","Ho sentim, alguna cosa ha anat malament. Podeu trobar més informació al registre d'errors."
-"Bucket does not exist","El cub no existeix"
-"Shop By","Compra per"
-"Clear All","Esborra-ho tot"
-"Shopping Options","Opcions de compra"
-"Layered Navigation","Navegació en capes"
-"General Configuration","Configuració general"
-"Module Enable","Mòdul habilitable"
\ No newline at end of file
diff --git a/i18n/cs_CZ.csv b/i18n/cs_CZ.csv
deleted file mode 100644
index 15e0cb7..0000000
--- a/i18n/cs_CZ.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 a výše"
-"%1 - %2","%1 - %2"
-"Price Slider","Cena posuvníku"
-"Sorry, something went wrong. You can find out more in the error log.","Promiň, něco se pokazilo. Více se dozvíte v protokolu chyb."
-"Bucket does not exist","Kbelík neexistuje"
-"Shop By","Shop By"
-"Clear All","Vymazat vše"
-"Shopping Options","Možnosti nákupu"
-"Layered Navigation","Vrstvená navigace"
-"General Configuration","Obecná konfigurace"
-"Module Enable","Modul Povolit"
\ No newline at end of file
diff --git a/i18n/da_DK.csv b/i18n/da_DK.csv
deleted file mode 100644
index 875ac06..0000000
--- a/i18n/da_DK.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 og derover"
-"%1 - %2","%1 - %2"
-"Price Slider","Pris Slider"
-"Sorry, something went wrong. You can find out more in the error log.","Undskyld, noget gik galt. Du kan finde ud af mere i fejlloggen."
-"Bucket does not exist","Bucket eksisterer ikke"
-"Shop By","Shop By"
-"Clear All","Slet alt"
-"Shopping Options","Indkøbsmuligheder"
-"Layered Navigation","Lagdelt navigation"
-"General Configuration","Generel konfiguration"
-"Module Enable","Modul Aktiver"
\ No newline at end of file
diff --git a/i18n/de_DE.csv b/i18n/de_DE.csv
deleted file mode 100644
index e40b46d..0000000
--- a/i18n/de_DE.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 und höher"
-"%1 - %2","%1 - %2"
-"Price Slider","Preisschieber"
-"Sorry, something went wrong. You can find out more in the error log.","Entschuldigung, etwas ist schief gelaufen Im Fehlerprotokoll erfahren Sie mehr."
-"Bucket does not exist","Eimer existiert nicht"
-"Shop By","Geschäft durch"
-"Clear All","Alles löschen"
-"Shopping Options","Einkaufsmöglichkeiten"
-"Layered Navigation","Layered Navigation"
-"General Configuration","Allgemeine Konfiguration"
-"Module Enable","Modul aktivieren"
\ No newline at end of file
diff --git a/i18n/el_GR.csv b/i18n/el_GR.csv
deleted file mode 100644
index f6bb076..0000000
--- a/i18n/el_GR.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 και παραπάνω"
-"%1 - %2","%1 - %2"
-"Price Slider","Τιμή ρυθμιστικό"
-"Sorry, something went wrong. You can find out more in the error log.","Συγνώμη, κάτι πήγε στραβά. Μπορείτε να μάθετε περισσότερα στο αρχείο καταγραφής σφαλμάτων."
-"Bucket does not exist","Ο κάδος δεν υπάρχει"
-"Shop By","Κατάστημα από"
-"Clear All","Τα καθαρίζω όλα"
-"Shopping Options","Επιλογές αγορών"
-"Layered Navigation","Επίπεδη πλοήγηση"
-"General Configuration","Γενική διαμόρφωση"
-"Module Enable","Ενεργοποίηση μονάδας"
\ No newline at end of file
diff --git a/i18n/en_US.csv b/i18n/en_US.csv
index e1c7d54..a84c339 100644
--- a/i18n/en_US.csv
+++ b/i18n/en_US.csv
@@ -8,4 +8,4 @@
 "Shopping Options","Shopping Options"
 "Layered Navigation","Layered Navigation"
 "General Configuration","General Configuration"
-"Module Enable","Module Enable"
\ No newline at end of file
+"Module Enable","Module Enable"
diff --git a/i18n/es_ES.csv b/i18n/es_ES.csv
deleted file mode 100644
index 7a75fda..0000000
--- a/i18n/es_ES.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 y superiores"
-"%1 - %2","%1 - %2"
-"Price Slider","Control deslizante de precios"
-"Sorry, something went wrong. You can find out more in the error log.","Perdón, algo salió mal. Puede obtener más información en el registro de errores."
-"Bucket does not exist","El cubo no existe"
-"Shop By","Comprar por"
-"Clear All","Limpiar todo"
-"Shopping Options","Opciones de compra"
-"Layered Navigation","Navegación en capas"
-"General Configuration","Configuración general"
-"Module Enable","Módulo habilitado"
\ No newline at end of file
diff --git a/i18n/fi_FI.csv b/i18n/fi_FI.csv
deleted file mode 100644
index 3afa6d5..0000000
--- a/i18n/fi_FI.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 tai uudempi"
-"%1 - %2","%1 - %2"
-"Price Slider","Hintaliukusäädin"
-"Sorry, something went wrong. You can find out more in the error log.","Pahoittelut, jotain meni pieleen. Lisätietoja löytyy virhelokista."
-"Bucket does not exist","Kauhaa ei ole olemassa"
-"Shop By","Osta"
-"Clear All","Tyhjennä"
-"Shopping Options","Ostosmahdollisuudet"
-"Layered Navigation","Layered Navigation"
-"General Configuration","Yleinen määritys"
-"Module Enable","Moduuli sallitaan"
\ No newline at end of file
diff --git a/i18n/fr_FR.csv b/i18n/fr_FR.csv
deleted file mode 100644
index 23f93a6..0000000
--- a/i18n/fr_FR.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 et au-dessus"
-"%1 - %2","%1 - %2"
-"Price Slider","Curseur de prix"
-"Sorry, something went wrong. You can find out more in the error log.","Désolé, quelque chose s'est mal passé. Vous pouvez en savoir plus sur le journal des erreurs."
-"Bucket does not exist","Le godet n'existe pas"
-"Shop By","Acheter par"
-"Clear All","Tout effacer"
-"Shopping Options","Options d'achat"
-"Layered Navigation","Navigation en couches"
-"General Configuration","Configuration générale"
-"Module Enable","Module Activer"
\ No newline at end of file
diff --git a/i18n/he_IL.csv b/i18n/he_IL.csv
deleted file mode 100644
index 2685dfd..0000000
--- a/i18n/he_IL.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 ומעלה"
-"%1 - %2","%1 - %2"
-"Price Slider","מחיר המחוון"
-"Sorry, something went wrong. You can find out more in the error log.","מצטערים, משהו השתבש. תוכל למצוא מידע נוסף ביומן השגיאות."
-"Bucket does not exist","הדלי אינו קיים"
-"Shop By","חנות על ידי"
-"Clear All","נקה הכל"
-"Shopping Options","אפשרויות קניות"
-"Layered Navigation","ניווט בשכבות"
-"General Configuration","תצורה כללית"
-"Module Enable","מודול אפשר"
\ No newline at end of file
diff --git a/i18n/hu_HU.csv b/i18n/hu_HU.csv
deleted file mode 100644
index 6ade10a..0000000
--- a/i18n/hu_HU.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 vagy annál magasabb"
-"%1 - %2","%1 - %2"
-"Price Slider","Árcsúszka"
-"Sorry, something went wrong. You can find out more in the error log.","Elnézést, valami nem ment jól. További információ a hiba naplóban található."
-"Bucket does not exist","A vödör nem létezik"
-"Shop By","Shop By"
-"Clear All","Kitörölni mindent"
-"Shopping Options","Vásárlási lehetőségek"
-"Layered Navigation","Layered Navigation"
-"General Configuration","Általános konfiguráció"
-"Module Enable","Modul engedélyezése"
\ No newline at end of file
diff --git a/i18n/it_IT.csv b/i18n/it_IT.csv
deleted file mode 100644
index 13296cb..0000000
--- a/i18n/it_IT.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 e sopra"
-"%1 - %2","%1 - %2"
-"Price Slider","Prezzo Slider"
-"Sorry, something went wrong. You can find out more in the error log.","Scusa, qualcosa è andato storto. Puoi trovare maggiori informazioni nel registro degli errori."
-"Bucket does not exist","La benna non esiste"
-"Shop By","Acquista da"
-"Clear All","Cancella tutto"
-"Shopping Options","Opzioni di acquisto"
-"Layered Navigation","Navigazione stratificata"
-"General Configuration","Configurazione generale"
-"Module Enable","Abilita modulo"
\ No newline at end of file
diff --git a/i18n/ja_JP.csv b/i18n/ja_JP.csv
deleted file mode 100644
index 1e3af1f..0000000
--- a/i18n/ja_JP.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1以上"
-"%1 - %2","%1  -  %2"
-"Price Slider","価格スライダ"
-"Sorry, something went wrong. You can find out more in the error log.","申し訳ありませんが、何かが間違っていました。エラーログで詳細を調べることができます。"
-"Bucket does not exist","バケツは存在しません"
-"Shop By","ショップバイ"
-"Clear All","すべてクリア"
-"Shopping Options","ショッピングオプション"
-"Layered Navigation","階層化ナビゲーション"
-"General Configuration","一般的な設定"
-"Module Enable","モジュール有効化"
\ No newline at end of file
diff --git a/i18n/ko_KR.csv b/i18n/ko_KR.csv
deleted file mode 100644
index b319e19..0000000
--- a/i18n/ko_KR.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 이상"
-"%1 - %2","%1 - %2"
-"Price Slider","가격 슬라이더"
-"Sorry, something went wrong. You can find out more in the error log.","죄송합니다. 무엇인가 잘못되었습니다. 오류 로그에서 자세한 내용을 확인할 수 있습니다."
-"Bucket does not exist","버킷이 없습니다."
-"Shop By","쇼핑몰"
-"Clear All","모두 지우기"
-"Shopping Options","쇼핑 옵션"
-"Layered Navigation","계층 적 탐색"
-"General Configuration","일반 구성"
-"Module Enable","모듈 사용"
\ No newline at end of file
diff --git a/i18n/nl_NL.csv b/i18n/nl_NL.csv
deleted file mode 100644
index 8a580dc..0000000
--- a/i18n/nl_NL.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 en hoger"
-"%1 - %2","%1 - %2"
-"Price Slider","Prijs Slider"
-"Sorry, something went wrong. You can find out more in the error log.","Sorry, er ging iets mis. U kunt meer weten in het foutlogboek."
-"Bucket does not exist","Emmer bestaat niet"
-"Shop By","Kopen bij"
-"Clear All","Wis alles"
-"Shopping Options","Winkelen Opties"
-"Layered Navigation","Gelaagde navigatie"
-"General Configuration","Algemene configuratie"
-"Module Enable","Module inschakelen"
\ No newline at end of file
diff --git a/i18n/no_NO.csv b/i18n/no_NO.csv
deleted file mode 100644
index c269b29..0000000
--- a/i18n/no_NO.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 og over"
-"%1 - %2","%1 - %2"
-"Price Slider","Pris Slider"
-"Sorry, something went wrong. You can find out more in the error log.","Beklager, noe gikk galt. Du kan finne ut mer i feilloggen."
-"Bucket does not exist","Bucket eksisterer ikke"
-"Shop By","Shop By"
-"Clear All","Rydd alt"
-"Shopping Options","Shopping alternativer"
-"Layered Navigation","Lagdelt navigasjon"
-"General Configuration","Generell konfigurasjon"
-"Module Enable","Modul Aktiver"
\ No newline at end of file
diff --git a/i18n/pl_PL.csv b/i18n/pl_PL.csv
deleted file mode 100644
index 2386b8a..0000000
--- a/i18n/pl_PL.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 i wyżej"
-"%1 - %2","%1 - %2"
-"Price Slider","Suwak cenowy"
-"Sorry, something went wrong. You can find out more in the error log.","Przepraszam, coś poszło nie tak. Więcej informacji można znaleźć w dzienniku błędów."
-"Bucket does not exist","Wiadro nie istnieje"
-"Shop By","Sklep przez"
-"Clear All","Wyczyść wszystko"
-"Shopping Options","Opcje zakupów"
-"Layered Navigation","Layered Navigation"
-"General Configuration","Konfiguracja ogólna"
-"Module Enable","Włącz moduł"
\ No newline at end of file
diff --git a/i18n/pt_BR.csv b/i18n/pt_BR.csv
deleted file mode 100644
index e1c7d54..0000000
--- a/i18n/pt_BR.csv
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
\ No newline at end of file
diff --git a/i18n/pt_PT.csv b/i18n/pt_PT.csv
deleted file mode 100644
index 5bf2497..0000000
--- a/i18n/pt_PT.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 e acima"
-"%1 - %2","%1 - %2"
-"Price Slider","Slider de preço"
-"Sorry, something went wrong. You can find out more in the error log.","Desculpe, algo deu errado. Você pode descobrir mais no registro de erros."
-"Bucket does not exist","O balde não existe"
-"Shop By","Compras por"
-"Clear All","Limpar tudo"
-"Shopping Options","Opções de compra"
-"Layered Navigation","Navegação em camadas"
-"General Configuration","Configuração Geral"
-"Module Enable","Módulo Ativado"
\ No newline at end of file
diff --git a/i18n/ro_RO.csv b/i18n/ro_RO.csv
deleted file mode 100644
index 6654a42..0000000
--- a/i18n/ro_RO.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 și mai sus"
-"%1 - %2","%1 - %2"
-"Price Slider","Slider pentru preț"
-"Sorry, something went wrong. You can find out more in the error log.","Scuze, ceva a mers greșit. Puteți afla mai multe în jurnalul de erori."
-"Bucket does not exist","Cupa nu există"
-"Shop By","Cumpărați"
-"Clear All","Curata tot"
-"Shopping Options","Opțiuni de cumpărături"
-"Layered Navigation","Navigare prin straturi"
-"General Configuration","Configurație generală"
-"Module Enable","Modul Activare"
\ No newline at end of file
diff --git a/i18n/ru_RU.csv b/i18n/ru_RU.csv
deleted file mode 100644
index dd51c6b..0000000
--- a/i18n/ru_RU.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 и выше"
-"%1 - %2","%1 - %2"
-"Price Slider","Ценовой слайдер"
-"Sorry, something went wrong. You can find out more in the error log.","Извините, что-то пошло не так. Вы можете узнать больше в журнале ошибок."
-"Bucket does not exist","Ковш не существует"
-"Shop By","Интернет-магазин"
-"Clear All","Очистить все"
-"Shopping Options","Варианты покупок"
-"Layered Navigation","Многоуровневая навигация"
-"General Configuration","Общая конфигурация"
-"Module Enable","Включить модуль"
\ No newline at end of file
diff --git a/i18n/sr_SP.csv b/i18n/sr_SP.csv
deleted file mode 100644
index 64f2be8..0000000
--- a/i18n/sr_SP.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 и изнад"
-"%1 - %2","%1 - %2"
-"Price Slider","Прице Слидер"
-"Sorry, something went wrong. You can find out more in the error log.","Извини, нешто није у реду. Више можете сазнати у дневнику грешака."
-"Bucket does not exist","Жлица не постоји"
-"Shop By","Схоп Би"
-"Clear All","Избриши све"
-"Shopping Options","Опције куповине"
-"Layered Navigation","Лаиеред Навигатион"
-"General Configuration","Општа конфигурација"
-"Module Enable","Омогући модул"
\ No newline at end of file
diff --git a/i18n/sv_SE.csv b/i18n/sv_SE.csv
deleted file mode 100644
index c50cfff..0000000
--- a/i18n/sv_SE.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 och över"
-"%1 - %2","%1 - %2"
-"Price Slider","Pris Slider"
-"Sorry, something went wrong. You can find out more in the error log.","Förlåt, något gick fel. Du kan läsa mer i felloggen."
-"Bucket does not exist","Skopa finns inte"
-"Shop By","Shop By"
-"Clear All","Rensa alla"
-"Shopping Options","Shoppingalternativ"
-"Layered Navigation","Lagrad navigering"
-"General Configuration","Allmän konfiguration"
-"Module Enable","Modul Aktivera"
\ No newline at end of file
diff --git a/i18n/tr_TR.csv b/i18n/tr_TR.csv
deleted file mode 100644
index 2102300..0000000
--- a/i18n/tr_TR.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 ve üstü"
-"%1 - %2","%1 - %2"
-"Price Slider","Fiyat Kaydırıcı"
-"Sorry, something went wrong. You can find out more in the error log.","Üzgünüz, bir şeyler ters gitti. Hata günlüğünde daha fazla bilgi bulabilirsiniz."
-"Bucket does not exist","Kova yok"
-"Shop By","Dükkan Tarafından"
-"Clear All","Hepsini temizle"
-"Shopping Options","Alışveriş Seçenekleri"
-"Layered Navigation","Katmanlı Gezinme"
-"General Configuration","Genel Yapılandırma"
-"Module Enable","Modül Etkinleştir"
\ No newline at end of file
diff --git a/i18n/uk_UA.csv b/i18n/uk_UA.csv
deleted file mode 100644
index fc68c9f..0000000
--- a/i18n/uk_UA.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 і вище"
-"%1 - %2","%1 - %2"
-"Price Slider","Ціна повзунка"
-"Sorry, something went wrong. You can find out more in the error log.","Вибач, щось пішло не так. Ви можете дізнатись більше в журналі помилок."
-"Bucket does not exist","Відро не існує"
-"Shop By","Магазин по"
-"Clear All","Очистити все"
-"Shopping Options","Варіанти покупки"
-"Layered Navigation","Шарована навігація"
-"General Configuration","Загальна конфігурація"
-"Module Enable","Включити модуль"
\ No newline at end of file
diff --git a/i18n/vi_VN.csv b/i18n/vi_VN.csv
deleted file mode 100644
index 188db2f..0000000
--- a/i18n/vi_VN.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1 trở lên"
-"%1 - %2","%1 - %2"
-"Price Slider","Thanh trượt giá"
-"Sorry, something went wrong. You can find out more in the error log.","Xin lỗi, có lỗi xảy ra. Bạn có thể tìm hiểu thêm trong bản ghi lỗi."
-"Bucket does not exist","Bucket không tồn tại"
-"Shop By","Mua sắm bởi"
-"Clear All","Làm sạch tất cả"
-"Shopping Options","Tùy chọn mua hàng"
-"Layered Navigation","Điều hướng Layered"
-"General Configuration","Cấu hình chung"
-"Module Enable","Module Enable"
\ No newline at end of file
diff --git a/i18n/zh_CN.csv b/i18n/zh_CN.csv
deleted file mode 100644
index c79a3fc..0000000
--- a/i18n/zh_CN.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1及以上"
-"%1 - %2","%1  -  %2"
-"Price Slider","价格滑块"
-"Sorry, something went wrong. You can find out more in the error log.","抱歉，出了一些问题。您可以在错误日志中找到更多内容。"
-"Bucket does not exist","Bucket不存在"
-"Shop By","店铺"
-"Clear All","全部清除"
-"Shopping Options","购物选项"
-"Layered Navigation","分层导航"
-"General Configuration","一般配置"
-"Module Enable","模块启用"
\ No newline at end of file
diff --git a/i18n/zh_TW.csv b/i18n/zh_TW.csv
deleted file mode 100644
index 2a9d9fa..0000000
--- a/i18n/zh_TW.csv
+++ /dev/null
@@ -1,11 +0,0 @@
-"%1 and above","%1及以上"
-"%1 - %2","%1  -  %2"
-"Price Slider","價格滑塊"
-"Sorry, something went wrong. You can find out more in the error log.","抱歉，出了一些問題。您可以在錯誤日誌中找到更多內容。"
-"Bucket does not exist","Bucket不存在"
-"Shop By","店鋪"
-"Clear All","全部清除"
-"Shopping Options","購物選項"
-"Layered Navigation","分層導航"
-"General Configuration","一般配置"
-"Module Enable","模塊啟用"
\ No newline at end of file
diff --git a/view/frontend/templates/layer.phtml b/view/frontend/templates/layer.phtml
index 2412fcd..b3f1d15 100644
--- a/view/frontend/templates/layer.phtml
+++ b/view/frontend/templates/layer.phtml
@@ -23,4 +23,8 @@
 <div id="layered-filter-block-container" class="layered-filter-block-container">
     <?php echo $block->getChildHtml() ?>
 </div>
-
+<div id="ln_overlay" class="ln_overlay">
+    <div class="loader">
+        <img src="<?php echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
+    </div>
+</div>
diff --git a/view/frontend/templates/layer/filter.phtml b/view/frontend/templates/layer/filter.phtml
index 304687e..baf5718 100644
--- a/view/frontend/templates/layer/filter.phtml
+++ b/view/frontend/templates/layer/filter.phtml
@@ -25,7 +25,7 @@ $filter = $this->getFilter();
 $attributeCode = $filter->getRequestVar();
 
 /** @type \Mageplaza\Layerednavigation\Model\Layer\Filter $filterModel */
-$filterModel = $this->helper('\Mageplaza\LayeredNavigation\Helper\Data')->getFilterModel();
+$filterModel = $this->helper('\Mageplaza\Layerednavigation\Helper\Data')->getFilterModel();
 ?>
 <ol class="items">
     <?php /** @type  $filterItem */ foreach ($filterItems as $filterItem): ?>
diff --git a/view/frontend/templates/layer/view.phtml b/view/frontend/templates/layer/view.phtml
index 6d36ee3..03e2fcb 100644
--- a/view/frontend/templates/layer/view.phtml
+++ b/view/frontend/templates/layer/view.phtml
@@ -26,13 +26,6 @@
 	$filtered = count($block->getLayer()->getState()->getFilters());
 ?>
 <div class="block filter" id="layered-filter-block" data-mage-init='{"collapsible":{"openedState": "active", "collapsible": true, "active": false, "collateral": { "openedState": "filter-active", "element": "body" } }}'>
-	
-	<div id="ln_overlay" class="ln_overlay">
-        <div class="loader">
-            <img src="<?php echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
-        </div>
-    </div>
-    
 	<div class="block-title filter-title" data-count="<?php /* @escapeNotVerified */ echo $filtered; ?>">
 		<strong data-role="title"><?php /* @escapeNotVerified */ echo __('Shop By') ?></strong>
 	</div>
diff --git a/view/frontend/web/js/view/layer.js b/view/frontend/web/js/view/layer.js
index c7d7c95..795e329 100644
--- a/view/frontend/web/js/view/layer.js
+++ b/view/frontend/web/js/view/layer.js
@@ -105,22 +105,7 @@ define([
 
         initObserve: function () {
             var self = this;
-            
-            var pageElements = $('#layer-product-list').find('.pages a');
-            pageElements.each(function () {
-                var el = $(this),
-                    link = self.checkUrl(el.prop('href'));
-                if (!link) {
-                    return;
-                }
-                el.bind('click', function (e) {
-                    submitFilterAction(link);
-                    e.stopPropagation();
-                    e.preventDefault();
-                })
 
-            });
-            
             var currentElements = this.element.find('.filter-current a, .filter-actions a');
             currentElements.each(function (index) {
                 var el = $(this),
@@ -161,7 +146,6 @@ define([
                 checkbox.bind('click', function (e) {
                     self.ajaxSubmit(link);
                     e.stopPropagation();
-                    e.preventDefault();
                 });
             });
 
