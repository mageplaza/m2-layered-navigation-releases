diff --git a/Helper/Data.php b/Helper/Data.php
index 2a302bf..865d2a8 100644
--- a/Helper/Data.php
+++ b/Helper/Data.php
@@ -1,30 +1,11 @@
 <?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
+
 namespace Mageplaza\LayeredNavigation\Helper;
 
 use Mageplaza\Core\Helper\AbstractData;
 
 class Data extends AbstractData
 {
-
-    /**
-     * @param null $storeId
-     *
-     * @return mixed
-     */
 	public function isEnabled($storeId = null)
 	{
 		return $this->getConfigValue('layered_navigation/general/enable', $storeId);
diff --git a/Model/Layer/Filter/Attribute.php b/Model/Layer/Filter/Attribute.php
index 4c6869f..4de573e 100644
--- a/Model/Layer/Filter/Attribute.php
+++ b/Model/Layer/Filter/Attribute.php
@@ -1,18 +1,4 @@
 <?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
 use Magento\CatalogSearch\Model\Layer\Filter\Attribute as AbstractFilter;
diff --git a/Model/Layer/Filter/Category.php b/Model/Layer/Filter/Category.php
index afcf63d..9f0ffe7 100644
--- a/Model/Layer/Filter/Category.php
+++ b/Model/Layer/Filter/Category.php
@@ -1,17 +1,7 @@
 <?php
 /**
- *                     Mageplaza_LayeredNavigation extension
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
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
diff --git a/Model/Layer/Filter/Decimal.php b/Model/Layer/Filter/Decimal.php
index 1521359..d84027c 100644
--- a/Model/Layer/Filter/Decimal.php
+++ b/Model/Layer/Filter/Decimal.php
@@ -1,17 +1,7 @@
 <?php
 /**
- *                     Mageplaza_LayeredNavigation extension
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
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 namespace Mageplaza\LayerdNavigation\Model\Layer\Filter;
 
diff --git a/Model/Layer/Filter/Price.php b/Model/Layer/Filter/Price.php
index 31b86ca..5f21ec2 100644
--- a/Model/Layer/Filter/Price.php
+++ b/Model/Layer/Filter/Price.php
@@ -1,17 +1,7 @@
 <?php
 /**
- *                     Mageplaza_LayeredNavigation extension
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
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 namespace Mageplaza\LayeredNavigation\Model\Layer\Filter;
 
diff --git a/Model/ResourceModel/Fulltext/Collection.php b/Model/ResourceModel/Fulltext/Collection.php
index d449230..e8b7ca1 100644
--- a/Model/ResourceModel/Fulltext/Collection.php
+++ b/Model/ResourceModel/Fulltext/Collection.php
@@ -1,17 +1,7 @@
 <?php
 /**
- *                     Mageplaza_LayeredNavigation extension
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
+ * Copyright � 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 namespace Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext;
 
diff --git a/Model/Search/FilterGroup.php b/Model/Search/FilterGroup.php
index a4c883d..26e8484 100644
--- a/Model/Search/FilterGroup.php
+++ b/Model/Search/FilterGroup.php
@@ -1,18 +1,5 @@
 <?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\Search\FilterGroup as SourceFilterGroup;
diff --git a/Model/Search/FilterGroupBuilder.php b/Model/Search/FilterGroupBuilder.php
index 31ca45c..4c263e6 100644
--- a/Model/Search/FilterGroupBuilder.php
+++ b/Model/Search/FilterGroupBuilder.php
@@ -1,18 +1,9 @@
 <?php
 /**
- *                     Mageplaza_LayeredNavigation extension
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
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\FilterBuilder;
@@ -36,17 +27,11 @@ class FilterGroupBuilder extends SourceFilterGroupBuilder
 		parent::__construct($objectFactory, $filterBuilder);
 	}
 
-    /**
-     * @param $filterBuilder
-     */
 	public function setFilterBuilder($filterBuilder)
 	{
 		$this->_filterBuilder = $filterBuilder;
 	}
 
-    /**
-     * @return FilterGroupBuilder
-     */
 	public function cloneObject()
 	{
 		$cloneObject = clone $this;
@@ -55,11 +40,6 @@ class FilterGroupBuilder extends SourceFilterGroupBuilder
 		return $cloneObject;
 	}
 
-    /**
-     * @param $attributeCode
-     *
-     * @return $this
-     */
 	public function removeFilter($attributeCode)
 	{
 		if (isset($this->data[FilterGroup::FILTERS])) {
diff --git a/Model/Search/SearchCriteria.php b/Model/Search/SearchCriteria.php
index 79bd9ab..b7a763a 100644
--- a/Model/Search/SearchCriteria.php
+++ b/Model/Search/SearchCriteria.php
@@ -1,18 +1,5 @@
 <?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\Search\SearchCriteria as SourceSearchCriteria;
diff --git a/Model/Search/SearchCriteriaBuilder.php b/Model/Search/SearchCriteriaBuilder.php
index 6d87af3..626affd 100644
--- a/Model/Search/SearchCriteriaBuilder.php
+++ b/Model/Search/SearchCriteriaBuilder.php
@@ -1,18 +1,9 @@
 <?php
 /**
- *                     Mageplaza_LayeredNavigation extension
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
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
+
 namespace Mageplaza\LayeredNavigation\Model\Search;
 
 use Magento\Framework\Api\ObjectFactory;
@@ -38,11 +29,6 @@ class SearchCriteriaBuilder extends SourceSearchCriteriaBuilder
 		parent::__construct($objectFactory, $filterGroupBuilder, $sortOrderBuilder);
 	}
 
-    /**
-     * @param $attributeCode
-     *
-     * @return $this
-     */
 	public function removeFilter($attributeCode)
 	{
 		$this->filterGroupBuilder->removeFilter($attributeCode);
@@ -50,17 +36,11 @@ class SearchCriteriaBuilder extends SourceSearchCriteriaBuilder
 		return $this;
 	}
 
-    /**
-     * @param $filterGroupBuilder
-     */
 	public function setFilterGroupBuilder($filterGroupBuilder)
 	{
 		$this->filterGroupBuilder = $filterGroupBuilder;
 	}
 
-    /**
-     * @return SearchCriteriaBuilder
-     */
 	public function cloneObject()
 	{
 		$cloneObject = clone $this;
diff --git a/Plugins/Block/RenderLayered.php b/Plugins/Block/RenderLayered.php
index 741944c..8ab9ba7 100644
--- a/Plugins/Block/RenderLayered.php
+++ b/Plugins/Block/RenderLayered.php
@@ -1,50 +1,13 @@
 <?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
 namespace Mageplaza\LayeredNavigation\Plugins\Block;
 
 class RenderLayered
 {
-    /**
-     * @var \Magento\Framework\UrlInterface
-     */
 	protected $_url;
-
-    /**
-     * @var \Magento\Theme\Block\Html\Pager
-     */
 	protected $_htmlPagerBlock;
-
-    /**
-     * @var \Magento\Framework\App\RequestInterface
-     */
 	protected $_request;
-
-    /**
-     * @var \Mageplaza\LayeredNavigation\Helper\Data
-     */
 	protected $_moduleHelper;
 
-    /**
-     * RenderLayered constructor.
-     *
-     * @param \Magento\Framework\UrlInterface          $url
-     * @param \Magento\Theme\Block\Html\Pager          $htmlPagerBlock
-     * @param \Magento\Framework\App\RequestInterface  $request
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
 	public function __construct(
 		\Magento\Framework\UrlInterface $url,
 		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
@@ -57,14 +20,6 @@ class RenderLayered
 		$this->_moduleHelper = $moduleHelper;
 	}
 
-    /**
-     * @param \Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject
-     * @param                                                         $proceed
-     * @param                                                         $attributeCode
-     * @param                                                         $optionId
-     *
-     * @return string
-     */
     public function aroundBuildUrl(\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject, $proceed, $attributeCode, $optionId)
     {
 		if(!$this->_moduleHelper->isEnabled()){
diff --git a/Plugins/Controller/Category/View.php b/Plugins/Controller/Category/View.php
index 3b4c2eb..ebf0531 100644
--- a/Plugins/Controller/Category/View.php
+++ b/Plugins/Controller/Category/View.php
@@ -1,18 +1,5 @@
 <?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
+
 namespace Mageplaza\LayeredNavigation\Plugins\Controller\Category;
 
 class View
@@ -20,12 +7,6 @@ class View
 	protected $_jsonHelper;
 	protected $_moduleHelper;
 
-    /**
-     * View constructor.
-     *
-     * @param \Magento\Framework\Json\Helper\Data      $jsonHelper
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
 	public function __construct(
 		\Magento\Framework\Json\Helper\Data $jsonHelper,
 		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
@@ -33,13 +14,6 @@ class View
 		$this->_jsonHelper = $jsonHelper;
 		$this->_moduleHelper = $moduleHelper;
 	}
-
-    /**
-     * @param \Magento\Catalog\Controller\Category\View $action
-     * @param                                           $page
-     *
-     * @return mixed
-     */
     public function afterExecute(\Magento\Catalog\Controller\Category\View $action, $page)
 	{
 		if($this->_moduleHelper->isEnabled() && $action->getRequest()->getParam('isAjax')){
diff --git a/Plugins/Model/Layer/Filter/Item.php b/Plugins/Model/Layer/Filter/Item.php
index 66522aa..3f855a3 100644
--- a/Plugins/Model/Layer/Filter/Item.php
+++ b/Plugins/Model/Layer/Filter/Item.php
@@ -8,14 +8,6 @@ class Item
 	protected $_request;
 	protected $_moduleHelper;
 
-    /**
-     * Item constructor.
-     *
-     * @param \Magento\Framework\UrlInterface          $url
-     * @param \Magento\Theme\Block\Html\Pager          $htmlPagerBlock
-     * @param \Magento\Framework\App\RequestInterface  $request
-     * @param \Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-     */
 	public function __construct(
 		\Magento\Framework\UrlInterface $url,
 		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
@@ -28,12 +20,6 @@ class Item
 		$this->_moduleHelper = $moduleHelper;
 	}
 
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-     * @param                                          $proceed
-     *
-     * @return string
-     */
     public function aroundGetUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
     {
 		if(!$this->_moduleHelper->isEnabled()){
@@ -61,12 +47,6 @@ class Item
         return $this->_url->getUrl('*/*/*', ['_current' => true, '_use_rewrite' => true, '_query' => $query]);
     }
 
-    /**
-     * @param \Magento\Catalog\Model\Layer\Filter\Item $item
-     * @param                                          $proceed
-     *
-     * @return string
-     */
     public function aroundGetRemoveUrl(\Magento\Catalog\Model\Layer\Filter\Item $item, $proceed)
     {
 		if(!$this->_moduleHelper->isEnabled()){
diff --git a/README.md b/README.md
index cea9a12..8190903 100644
--- a/README.md
+++ b/README.md
@@ -2,4 +2,4 @@ How to install: https://docs.mageplaza.com/kb/installation.html
 
 User Guide: https://docs.mageplaza.com/layered-navigation-m2/
 
-Help: https://mageplaza.freshdesk.com/
\ No newline at end of file
+Help: http://mageplaza.freshdesk.com/
\ No newline at end of file
diff --git a/SearchAdapter/Filter/Builder/Term.php b/SearchAdapter/Filter/Builder/Term.php
new file mode 100644
index 0000000..a3f2df5
--- /dev/null
+++ b/SearchAdapter/Filter/Builder/Term.php
@@ -0,0 +1,55 @@
+<?php
+/**
+ * Copyright � 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
+ */
+namespace Mageplaza\LayeredNavigation\SearchAdapter\Filter\Builder;
+
+use Magento\Framework\Search\Request\Filter\Term as TermFilterRequest;
+use Magento\Framework\Search\Request\FilterInterface as RequestFilterInterface;
+use Magento\Solr\SearchAdapter\FieldMapperInterface;
+use Magento\Solr\SearchAdapter\Filter\Builder\Term as SourceTerm;
+use Magento\Solr\SearchAdapter\Filter\Builder\FilterInterface;
+use Magento\Solr\SearchAdapter\Filter\Builder;
+use Solarium\QueryType\Select\Query\Query;
+
+class Term extends SourceTerm implements FilterInterface
+{
+	/**
+	 * @var FieldMapperInterface
+	 */
+	private $mapper;
+
+	/**
+	 * @param FieldMapperInterface $mapper
+	 */
+	public function __construct(FieldMapperInterface $mapper)
+	{
+		$this->mapper = $mapper;
+	}
+
+	/**
+	 * @param RequestFilterInterface|TermFilterRequest $filter
+	 * @return string
+	 */
+	public function buildFilter(RequestFilterInterface $filter)
+	{
+		$values = $filter->getValue();
+		if(is_array($values) && array_key_exists('in', $values)){
+			$values = $values['in'];
+		}
+		return implode(
+			' ' . Query::QUERY_OPERATOR_OR . ' ',
+			array_map(
+				function ($value) use ($filter) {
+					return sprintf(
+						'%s:"%s"',
+						$this->mapper->getFieldName($filter->getField()),
+						$value
+					);
+				},
+				(array)$values
+			)
+		);
+	}
+}
diff --git a/composer.json b/composer.json
index d3bf6f7..a28d566 100644
--- a/composer.json
+++ b/composer.json
@@ -4,6 +4,10 @@
   "require": {
     "php": "~5.5.0|~5.6.0|~7.0.0"
   },
+  "repositories": {
+    "type": "git",
+    "url": "git@gitlab.com:mageplaza/layered-navigation-m2.git"
+  },
   "type": "magento2-module",
   "version": "1.0.0",
   "license": [
diff --git a/etc/acl.xml b/etc/acl.xml
index 2f5f322..3b04f26 100644
--- a/etc/acl.xml
+++ b/etc/acl.xml
@@ -1,14 +1,14 @@
 <?xml version="1.0"?>
 <!--
 /**
- *                     Mageplaza_LayeredNavigation extension
+ * Mageplaza_LayeredNavigation extension
  *                     NOTICE OF LICENSE
- *
+ * 
  *                     This source file is subject to the Mageplaza License
  *                     that is bundled with this package in the file LICENSE.txt.
  *                     It is also available through the world-wide-web at this URL:
  *                     https://www.mageplaza.com/LICENSE.txt
- *
+ * 
  *                     @category  Mageplaza
  *                     @package   Mageplaza_LayeredNavigation
  *                     @copyright Copyright (c) 2016
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index 3a3e605..294e7bb 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -1,20 +1,4 @@
 <?xml version="1.0"?>
-<!--
-/**
- *                      Mageplaza_LayeredNavigation extension
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
     <menu>
         <add id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" module="Mageplaza_LayeredNavigation" sortOrder="100" resource="Mageplaza_LayeredNavigation::layer" parent="Mageplaza_Core::menu"/>
diff --git a/etc/adminhtml/system.xml b/etc/adminhtml/system.xml
index 10203d6..d2967fe 100644
--- a/etc/adminhtml/system.xml
+++ b/etc/adminhtml/system.xml
@@ -1,20 +1,4 @@
 <?xml version="1.0"?>
-<!--
-/**
- *                      Mageplaza_LayeredNavigation extension
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
     <system>
         <section id="layered_navigation" translate="label" sortOrder="50" showInDefault="1" showInWebsite="1" showInStore="1">
diff --git a/etc/config.xml b/etc/config.xml
index ed1773d..e6d9f74 100644
--- a/etc/config.xml
+++ b/etc/config.xml
@@ -1,20 +1,4 @@
 <?xml version="1.0"?>
-<!--
-/**
- *                     Mageplaza_LayeredNavigation extension
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Store:etc/config.xsd">
     <default>
         <layered_navigation>
diff --git a/etc/di.xml b/etc/di.xml
index c3060c2..2fe778a 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -22,4 +22,10 @@
         </arguments>
     </type>
 
+    <!-- Enterprise -->
+    <type name="Magento\Solr\SearchAdapter\Filter\Builder">
+        <arguments>
+            <argument name="term" xsi:type="object">Mageplaza\LayeredNavigation\SearchAdapter\Filter\Builder\Term</argument>
+        </arguments>
+    </type>
 </config>
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index b6f9acf..04e2eee 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -1,20 +1,5 @@
 <?xml version="1.0"?>
-<!--
-/**
- *                     Mageplaza_LayeredNavigation extension
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
+
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
     <type name="Magento\Catalog\Controller\Category\View">
         <plugin name="layer_navigation_ajax_update" type="Mageplaza\LayeredNavigation\Plugins\Controller\Category\View" sortOrder="1" />
diff --git a/etc/module.xml b/etc/module.xml
index 84bcc0f..3934127 100644
--- a/etc/module.xml
+++ b/etc/module.xml
@@ -1,20 +1,4 @@
 <?xml version="1.0"?>
-<!--
-/**
- *                     Mageplaza_LayeredNavigation extension
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
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
     <module name="Mageplaza_LayeredNavigation" setup_version="1.0.0">
         <sequence>
diff --git a/view/frontend/layout/catalog_category_view_type_layered.xml b/view/frontend/layout/catalog_category_view_type_layered.xml
index 15aef7a..c7ebc89 100644
--- a/view/frontend/layout/catalog_category_view_type_layered.xml
+++ b/view/frontend/layout/catalog_category_view_type_layered.xml
@@ -1,20 +1,5 @@
 <?xml version="1.0"?>
-<!--
-/**
- *                     Mageplaza_LayeredNavigation extension
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
+
 <page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
     <body>
         <referenceBlock name="catalog.leftnav">
diff --git a/view/frontend/templates/filter.phtml b/view/frontend/templates/filter.phtml
index a802a4d..7450b30 100644
--- a/view/frontend/templates/filter.phtml
+++ b/view/frontend/templates/filter.phtml
@@ -1,19 +1,3 @@
-<?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
-?>
 <ol class="items">
     <?php foreach ($filterItems as $filterItem): ?>
         <?php
diff --git a/view/frontend/templates/products.phtml b/view/frontend/templates/products.phtml
index 925738a..a58c827 100644
--- a/view/frontend/templates/products.phtml
+++ b/view/frontend/templates/products.phtml
@@ -1,19 +1,11 @@
 <?php
 /**
- *                     Mageplaza_LayeredNavigation extension
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
+ * Copyright © 2016 Magento. All rights reserved.
+ * See COPYING.txt for license details.
  */
 
+// @codingStandardsIgnoreFile
+
 ?>
 <?php
 /**
diff --git a/view/frontend/templates/view.phtml b/view/frontend/templates/view.phtml
index 31107ca..afe0ea3 100644
--- a/view/frontend/templates/view.phtml
+++ b/view/frontend/templates/view.phtml
@@ -1,19 +1,3 @@
-<?php
-/**
- *                     Mageplaza_LayeredNavigation extension
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
-?>
 <?php if ($block->canShowBlock()): ?>
     <div class="block filter" id="layered-filter-block" data-mage-init='{"collapsible":{"openedState": "active", "collapsible": true, "active": false, "collateral": { "openedState": "filter-active", "element": "body" } }}'>
         <?php $filtered = count($block->getLayer()->getState()->getFilters()) ?>
