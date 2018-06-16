diff --git a/Model/Layer/Filter/Attribute.php b/Model/Layer/Filter/Attribute.php
index 4de573e..c775464 100644
--- a/Model/Layer/Filter/Attribute.php
+++ b/Model/Layer/Filter/Attribute.php
@@ -67,7 +67,11 @@ class Attribute extends AbstractFilter
         $productCollection = $this->getLayer()
             ->getProductCollection();
         if(sizeof($attributeValue) > 1){
-			$productCollection->addFieldToFilter($attribute->getAttributeCode(), array('in' => $attributeValue));
+			$valueFilter = array();
+			foreach($attributeValue as $value){
+				$valueFilter[] = array('eq' => $value);
+			}
+			$productCollection->addFieldToFilter($attribute->getAttributeCode(), array('ln_filter' => $valueFilter));
         } else {
             $productCollection->addFieldToFilter($attribute->getAttributeCode(), $attributeValue[0]);
         }
@@ -116,9 +120,6 @@ class Attribute extends AbstractFilter
 
         $productSize = $collection->getSize();
 
-        $itemData = [];
-        $checkCount = false;
-
         $options = $attribute->getFrontend()
             ->getSelectOptions();
         foreach ($options as $option) {
@@ -131,28 +132,18 @@ class Attribute extends AbstractFilter
             $count = isset($optionsFacetedData[$value]['count'])
                 ? (int)$optionsFacetedData[$value]['count']
                 : 0;
-            if($count > 0){
-                $checkCount = true;
-            }
             // Check filter type
             if (
                 $this->getAttributeIsFilterable($attribute) === static::ATTRIBUTE_OPTIONS_ONLY_WITH_RESULTS
-                && (!$this->isOptionReducesResults($count, $productSize))// || $count === 0)
+                && (!$this->isOptionReducesResults($count, $productSize) || $count === 0)
             ) {
                 continue;
             }
-
-            $itemData[] = [
+            $this->itemDataBuilder->addItemData(
                 $this->tagFilter->filter($option['label']),
                 $value,
                 $count
-            ];
-        }
-
-        if($checkCount) {
-            foreach ($itemData as $value) {
-                $this->itemDataBuilder->addItemData($value[0], $value[1], $value[2]);
-            }
+            );
         }
 
         return $this->itemDataBuilder->build();
diff --git a/Model/ResourceModel/Fulltext/Collection.php b/Model/ResourceModel/Fulltext/Collection.php
index e8b7ca1..333ed9f 100644
--- a/Model/ResourceModel/Fulltext/Collection.php
+++ b/Model/ResourceModel/Fulltext/Collection.php
@@ -304,7 +304,11 @@ class Collection extends \Magento\Catalog\Model\ResourceModel\Product\Collection
 
 		$this->getSearchCriteriaBuilder();
 		$this->getFilterBuilder();
-		if (!is_array($condition) || !in_array(key($condition), ['from', 'to'])) {
+		if (!empty($condition['ln_filter'])) {
+			$this->filterBuilder->setField($field);
+			$this->filterBuilder->setValue($condition['ln_filter']);
+			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
+		} elseif (!is_array($condition) || !in_array(key($condition), ['from', 'to'])) {
 			$this->filterBuilder->setField($field);
 			$this->filterBuilder->setValue($condition);
 			$this->searchCriteriaBuilder->addFilter($this->filterBuilder->create());
diff --git a/SearchAdapter/Filter/Builder/Term.php b/SearchAdapter/Filter/Builder/Term.php
deleted file mode 100644
index a3f2df5..0000000
--- a/SearchAdapter/Filter/Builder/Term.php
+++ /dev/null
@@ -1,55 +0,0 @@
-<?php
-/**
- * Copyright © 2016 Magento. All rights reserved.
- * See COPYING.txt for license details.
- */
-namespace Mageplaza\LayeredNavigation\SearchAdapter\Filter\Builder;
-
-use Magento\Framework\Search\Request\Filter\Term as TermFilterRequest;
-use Magento\Framework\Search\Request\FilterInterface as RequestFilterInterface;
-use Magento\Solr\SearchAdapter\FieldMapperInterface;
-use Magento\Solr\SearchAdapter\Filter\Builder\Term as SourceTerm;
-use Magento\Solr\SearchAdapter\Filter\Builder\FilterInterface;
-use Magento\Solr\SearchAdapter\Filter\Builder;
-use Solarium\QueryType\Select\Query\Query;
-
-class Term extends SourceTerm implements FilterInterface
-{
-	/**
-	 * @var FieldMapperInterface
-	 */
-	private $mapper;
-
-	/**
-	 * @param FieldMapperInterface $mapper
-	 */
-	public function __construct(FieldMapperInterface $mapper)
-	{
-		$this->mapper = $mapper;
-	}
-
-	/**
-	 * @param RequestFilterInterface|TermFilterRequest $filter
-	 * @return string
-	 */
-	public function buildFilter(RequestFilterInterface $filter)
-	{
-		$values = $filter->getValue();
-		if(is_array($values) && array_key_exists('in', $values)){
-			$values = $values['in'];
-		}
-		return implode(
-			' ' . Query::QUERY_OPERATOR_OR . ' ',
-			array_map(
-				function ($value) use ($filter) {
-					return sprintf(
-						'%s:"%s"',
-						$this->mapper->getFieldName($filter->getField()),
-						$value
-					);
-				},
-				(array)$values
-			)
-		);
-	}
-}
diff --git a/etc/di.xml b/etc/di.xml
index 2fe778a..25d6974 100644
--- a/etc/di.xml
+++ b/etc/di.xml
@@ -21,11 +21,4 @@
             <argument name="collectionFactory" xsi:type="object">Mageplaza\LayeredNavigation\Model\ResourceModel\Fulltext\CollectionFactory</argument>
         </arguments>
     </type>
-
-    <!-- Enterprise -->
-    <type name="Magento\Solr\SearchAdapter\Filter\Builder">
-        <arguments>
-            <argument name="term" xsi:type="object">Mageplaza\LayeredNavigation\SearchAdapter\Filter\Builder\Term</argument>
-        </arguments>
-    </type>
 </config>
diff --git a/view/frontend/templates/view.phtml b/view/frontend/templates/view.phtml
index afe0ea3..d8e12d8 100644
--- a/view/frontend/templates/view.phtml
+++ b/view/frontend/templates/view.phtml
@@ -50,23 +50,6 @@
             <div id="ln_overlay" class="ln_overlay">
                 <img src="<?php /* @escapeNotVerified */ echo $block->getViewFileUrl('images/loader-1.gif'); ?>" alt="Loading...">
             </div>
-            <style type="text/css">
-                .ln_overlay{
-                    background-color: #FFFFFF;
-                    height: 100%;
-                    left: 0;
-                    opacity: 0.5;
-                    filter: alpha(opacity = 50);
-                    position: absolute;
-                    top: 0;
-                    width: 100%;
-                    z-index: 555;
-                    display:none;
-                }
-                .ln_overlay img {
-                    top: 30%;left: 45%;display: block;position: absolute;
-                }
-            </style>
         </div>
     </div>
 <?php endif; ?>
