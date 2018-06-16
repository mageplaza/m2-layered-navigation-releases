diff --git a/Plugins/Block/RenderLayered.php b/Plugins/Block/RenderLayered.php
deleted file mode 100644
index 8ab9ba7..0000000
--- a/Plugins/Block/RenderLayered.php
+++ /dev/null
@@ -1,41 +0,0 @@
-<?php
-namespace Mageplaza\LayeredNavigation\Plugins\Block;
-
-class RenderLayered
-{
-	protected $_url;
-	protected $_htmlPagerBlock;
-	protected $_request;
-	protected $_moduleHelper;
-
-	public function __construct(
-		\Magento\Framework\UrlInterface $url,
-		\Magento\Theme\Block\Html\Pager $htmlPagerBlock,
-		\Magento\Framework\App\RequestInterface $request,
-		\Mageplaza\LayeredNavigation\Helper\Data $moduleHelper
-	) {
-		$this->_url = $url;
-		$this->_htmlPagerBlock = $htmlPagerBlock;
-		$this->_request = $request;
-		$this->_moduleHelper = $moduleHelper;
-	}
-
-    public function aroundBuildUrl(\Magento\Swatches\Block\LayeredNavigation\RenderLayered $subject, $proceed, $attributeCode, $optionId)
-    {
-		if(!$this->_moduleHelper->isEnabled()){
-			return $proceed();
-		}
-
-		$value = array();
-		if($requestValue = $this->_request->getParam($attributeCode)){
-			$value = explode(',', $requestValue);
-		}
-		if(!in_array($optionId, $value)) {
-			$value[] = $optionId;
-		}
-
-        $query = [$attributeCode => implode(',', $value)];
-
-        return $this->_url->getUrl('*/*/*', ['_current' => true, '_use_rewrite' => true, '_query' => $query]);
-    }
-}
diff --git a/Plugins/Model/Layer/Filter/Item.php b/Plugins/Model/Layer/Filter/Item.php
index 3f855a3..d80123d 100644
--- a/Plugins/Model/Layer/Filter/Item.php
+++ b/Plugins/Model/Layer/Filter/Item.php
@@ -31,9 +31,7 @@ class Item
 		if($requestValue = $this->_request->getParam($requestVar)){
 			$value = explode(',', $requestValue);
 		}
-		if(!in_array($item->getValue(), $value)) {
-			$value[] = $item->getValue();
-		}
+		$value[] = $item->getValue();
 
 		if($requestVar == 'price'){
 			$value = ["{price_start}-{price_end}"];
diff --git a/etc/frontend/di.xml b/etc/frontend/di.xml
index 04e2eee..1f85251 100644
--- a/etc/frontend/di.xml
+++ b/etc/frontend/di.xml
@@ -7,7 +7,4 @@
     <type name="Magento\Catalog\Model\Layer\Filter\Item">
         <plugin name="ln_filter_item_url" type="Mageplaza\LayeredNavigation\Plugins\Model\Layer\Filter\Item" sortOrder="1" />
     </type>
-    <type name="Magento\Swatches\Block\LayeredNavigation\RenderLayered">
-        <plugin name="ln_filter_item_swatch_url" type="Mageplaza\LayeredNavigation\Plugins\Block\RenderLayered" sortOrder="1" />
-    </type>
 </config>
