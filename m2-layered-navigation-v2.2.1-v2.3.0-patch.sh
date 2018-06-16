diff --git a/Controller/Search/Result/Index.php b/Controller/Search/Result/Index.php
index cd6af1e..689b401 100644
--- a/Controller/Search/Result/Index.php
+++ b/Controller/Search/Result/Index.php
@@ -125,17 +125,14 @@ class Index extends \Magento\Framework\App\Action\Action
 			}
 
 			$this->_helper->checkNotes();
-			$this->_view->loadLayout();
 
 			if ($this->_moduleHelper->isEnabled() && $this->getRequest()->isAjax()) {
 				$navigation = $this->_view->getLayout()->getBlock('catalogsearch.leftnav');
 				$products   = $this->_view->getLayout()->getBlock('search.result');
-				$result     = [
-					'products' => $products->toHtml(),
-					'navigation' => $navigation->toHtml()
-				];
+				$result     = ['products' => $products->toHtml(), 'navigation' => $navigation->toHtml()];
 				$this->getResponse()->representJson($this->_jsonHelper->jsonEncode($result));
 			} else {
+				$this->_view->loadLayout();
 				$this->_view->renderLayout();
 			}
 		} else {
diff --git a/Model/Layer/Filter/Price.php b/Model/Layer/Filter/Price.php
index 8615eb1..44e6532 100644
--- a/Model/Layer/Filter/Price.php
+++ b/Model/Layer/Filter/Price.php
@@ -127,7 +127,7 @@ class Price extends AbstractFilter
 
 		$this->getLayer()->getProductCollection()->addFieldToFilter(
 			'price',
-			['from' => $from/$this->getCurrencyRate(), 'to' => $to/$this->getCurrencyRate()]
+			['from' => $from, 'to' => $to]
 		);
 
 		$this->getLayer()->getState()->addFilter(
@@ -175,8 +175,8 @@ class Price extends AbstractFilter
 		$max = $productCollection->getMaxPrice();
 
 		list($from, $to) = $this->_filterVal ?: [$min, $max];
-		$from = ($from < $min) ? $min : (($from > $max) ? $max : $from);
-		$to = ($to > $max) ? $max : (($to < $from) ? $from : $to);
+		$from = ($from < $min) ? $min : $from;
+		$to = ($to > $max) ? $max : $to;
 
 		$item = $this->getItems()[0];
 
@@ -249,7 +249,7 @@ class Price extends AbstractFilter
 			empty($from) ? 0 : $from * $this->getCurrencyRate(),
 			empty($to) ? $to : $to * $this->getCurrencyRate()
 		);
-		$value = $from * $this->getCurrencyRate() . '-' . $to * $this->getCurrencyRate();// . $this->dataProvider->getAdditionalRequestData();
+		$value = $from . '-' . $to . $this->dataProvider->getAdditionalRequestData();
 
 		$data = [
 			'label' => $label,
diff --git a/Plugin/Model/Layer/Filter/Item.php b/Plugin/Model/Layer/Filter/Item.php
index 01b3ad6..86f03d6 100644
--- a/Plugin/Model/Layer/Filter/Item.php
+++ b/Plugin/Model/Layer/Filter/Item.php
@@ -77,7 +77,7 @@ class Item
 		$value     = [];
 		$filter    = $item->getFilter();
 		$filterModel = $this->_moduleHelper->getFilterModel();
-		if ($filterModel->getIsSliderTypes($filter) || $filter->getData('range_mode')) {
+		if ($filterModel->getIsSliderTypes($filter)) {
 			$value = ["from-to"];
 		} else if ($filterModel->isMultiple($filter)) {
 			$requestVar = $filter->getRequestVar();
@@ -117,7 +117,7 @@ class Item
 		$value     = [];
 		$filter    = $item->getFilter();
 		$filterModel = $this->_moduleHelper->getFilterModel();
-		if ($filterModel->isMultiple($filter)) {
+		if (!$filterModel->getIsSliderTypes($filter)) {
 			$value = $filterModel->getFilterValue($filter);
 			if (in_array($item->getValue(), $value)) {
 				$value = array_diff($value, [$item->getValue()]);
diff --git a/etc/adminhtml/menu.xml b/etc/adminhtml/menu.xml
index a0747ab..11c5c4d 100644
--- a/etc/adminhtml/menu.xml
+++ b/etc/adminhtml/menu.xml
@@ -24,6 +24,6 @@
 <config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Backend:etc/menu.xsd">
     <menu>
         <add id="Mageplaza_LayeredNavigation::layer" title="Layered Navigation" module="Mageplaza_LayeredNavigation" sortOrder="100" resource="Mageplaza_LayeredNavigation::configuration" parent="Mageplaza_Core::menu"/>
-        <add id="Mageplaza_LayeredNavigation::configuration" title="Configuration" module="Mageplaza_LayeredNavigation" sortOrder="1000" action="adminhtml/system_config/edit/section/layered_navigation" resource="Mageplaza_LayeredNavigation::configuration" parent="Mageplaza_LayeredNavigation::layer"/>
+        <add id="Mageplaza_LayeredNavigation::configuration" title="Configuration" module="Mageplaza_LayeredNavigation" sortOrder="10" action="adminhtml/system_config/edit/section/layered_navigation" resource="Mageplaza_LayeredNavigation::configuration" parent="Mageplaza_LayeredNavigation::layer"/>
     </menu>
 </config>
