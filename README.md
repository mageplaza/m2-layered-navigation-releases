# Magento 2 Layered Navigation Releases

Magento 2 Layered Navigation Release Notes is a git repository that update all Mageplaza Layered Navigation Patches, Release notes. To upgrade Mageplaza Layered Navigation, you can download *-patch.sh file and apply to your store instantly without issue.
Explore [Mageplaza Layered Navigation here](https://www.mageplaza.com/magento-2-layered-navigation-extension/)

## v2.3.2
Released on  2017-09-27
Release notes: 

- Compatible with Magento 2.2.x



## v2.3.1
Released on  2017-08-10
Release notes: 

Fix bugs



## v2.3.0
Released on  2017-06-14
Release notes: 

- Fix bugs
- Improvement:
    + Multiple all product pages
    + Rating slider
    + Seo Url work with button submit



## v2.2.1
Released on  2017-05-17
Release notes: 

- Hotfix ajax loading on swatch attribute



## v2.2.0
Released on  2017-05-17
Release notes: 

- Compatible with Magento 2.0.x
- Support catalog search navigation
- Compatible with mobile screen, theme
- Fix some bugs



## v2.0.0
Released on  2017-01-20
Release notes: 

- Improve code performance
- Release Layered Navigation Pro package



## v1.2.0
Released on  2016-12-24
Release notes: 

- Fix bugs:
    + Error when disable module
- Improvement:
    + Update comment
    + Multiple filter swatch attribute



## v1.1.4
Released on  2016-11-23
Release notes: 

- Compilation issue
* Improvement coding style and performance



## v1.1.3
Released on  2016-10-31
Release notes: 

- Improvement
    + add multiple filter for swatch attributes



## v1.1.2
Released on  2016-10-13
Release notes: 

fix bug filter query + compatible with module Solr enterprise



## v1.1.1
Released on  2016-09-29
Release notes: 

Re-package module



## v1.1.0
Released on  2016-09-28
Release notes: 

re-initital module



## v1.0.1
Released on  2016-07-29



## Changed files

### v2.3.2 to v2.3.1
~~~
 README.md     | 77 +++++++++++++++++++----------------------------------------
 USER-GUIDE.md | 77 +++++++++++++++++++----------------------------------------
 composer.json |  2 +-
 3 files changed, 51 insertions(+), 105 deletions(-)
~~~
### v2.3.1 to v2.3.0
~~~
 Api/Search/Document.php                     |  20 +-
 CHANGELOG                                   |   1 -
 Controller/Search/Result/Index.php          | 200 +++----
 Helper/Data.php                             | 108 ++--
 LICENSE                                     |   1 -
 Model/Layer/Filter.php                      | 318 +++++-----
 Model/Layer/Filter/Attribute.php            | 296 +++++-----
 Model/Layer/Filter/Category.php             | 252 ++++----
 Model/Layer/Filter/Price.php                | 462 +++++++--------
 Model/ResourceModel/Fulltext/Collection.php | 888 ++++++++++++++--------------
 Model/Search/FilterGroupBuilder.php         | 122 ++--
 Model/Search/SearchCriteriaBuilder.php      |  96 +--
 Plugin/Block/Swatches/RenderLayered.php     | 146 ++---
 Plugin/Controller/Category/View.php         |  64 +-
 Plugin/Model/Adapter/Preprocessor.php       |  56 +-
 Plugin/Model/Layer/Filter/Item.php          | 204 +++----
 README.md                                   |  59 +-
 USER-GUIDE.md                               |  58 --
 composer.json                               |   5 +-
 i18n/af_ZA.csv                              |  11 -
 i18n/ar_SA.csv                              |  11 -
 i18n/be_BY.csv                              |  11 -
 i18n/ca_ES.csv                              |  11 -
 i18n/cs_CZ.csv                              |  11 -
 i18n/da_DK.csv                              |  11 -
 i18n/de_DE.csv                              |  11 -
 i18n/el_GR.csv                              |  11 -
 i18n/en_US.csv                              |   2 +-
 i18n/es_ES.csv                              |  11 -
 i18n/fi_FI.csv                              |  11 -
 i18n/fr_FR.csv                              |  11 -
 i18n/he_IL.csv                              |  11 -
 i18n/hu_HU.csv                              |  11 -
 i18n/it_IT.csv                              |  11 -
 i18n/ja_JP.csv                              |  11 -
 i18n/ko_KR.csv                              |  11 -
 i18n/nl_NL.csv                              |  11 -
 i18n/no_NO.csv                              |  11 -
 i18n/pl_PL.csv                              |  11 -
 i18n/pt_BR.csv                              |  11 -
 i18n/pt_PT.csv                              |  11 -
 i18n/ro_RO.csv                              |  11 -
 i18n/ru_RU.csv                              |  11 -
 i18n/sr_SP.csv                              |  11 -
 i18n/sv_SE.csv                              |  11 -
 i18n/tr_TR.csv                              |  11 -
 i18n/uk_UA.csv                              |  11 -
 i18n/vi_VN.csv                              |  11 -
 i18n/zh_CN.csv                              |  11 -
 i18n/zh_TW.csv                              |  11 -
 view/frontend/templates/layer.phtml         |   6 +-
 view/frontend/templates/layer/filter.phtml  |   2 +-
 view/frontend/templates/layer/view.phtml    |   7 -
 view/frontend/web/js/view/layer.js          |  16 -
 54 files changed, 1630 insertions(+), 2089 deletions(-)
~~~
### v2.3.0 to v2.2.1
~~~
 Controller/Search/Result/Index.php | 7 ++-----
 Model/Layer/Filter/Price.php       | 8 ++++----
 Plugin/Model/Layer/Filter/Item.php | 4 ++--
 etc/adminhtml/menu.xml             | 2 +-
 4 files changed, 9 insertions(+), 12 deletions(-)
~~~
### v2.2.1 to v2.2.0
~~~
~~~
### v2.2.0 to v2.0.0
~~~
 .../Plugin}/Swatches/RenderLayered.php             |  65 +++---
 Controller/Plugin/Category/View.php                |  63 ++++++
 Controller/Search/Result/Index.php                 | 142 -------------
 Helper/Data.php                                    |  44 ++--
 Model/Layer/Filter.php                             | 191 ------------------
 Model/Layer/Filter/Attribute.php                   | 129 ++++++++++--
 Model/Layer/Filter/Category.php                    | 174 +++++++---------
 Model/Layer/Filter/Decimal.php                     | 137 +++++++++++++
 Model/Layer/Filter/FilterInterface.php             |  80 ++++++++
 Model/Layer/Filter/Price.php                       | 181 ++++++++---------
 .../Model => Model/Plugin}/Layer/Filter/Item.php   |  57 +++---
 Model/ResourceModel/Fulltext/Collection.php        | 222 +++++++++++++--------
 .../layer.phtml => Model/Search/FilterGroup.php    |  27 ++-
 Model/Search/FilterGroupBuilder.php                | 110 ++++------
 .../Search/SearchCriteria.php                      |  28 ++-
 Model/Search/SearchCriteriaBuilder.php             |  93 ++++-----
 Plugin/Controller/Category/View.php                |  65 ------
 Plugin/Model/Adapter/Preprocessor.php              |  60 ------
 composer.json                                      |   5 +-
 etc/acl.xml                                        |   9 +-
 etc/adminhtml/menu.xml                             |   4 +-
 etc/adminhtml/system.xml                           |   4 +-
 etc/config.xml                                     |   2 +-
 etc/di.xml                                         |  20 +-
 etc/frontend/di.xml                                |  22 +-
 etc/module.xml                                     |   2 +-
 i18n/en_US.csv                                     |  11 -
 registration.php                                   |   2 +-
 view/adminhtml/web/css/source/_module.less         |   2 +-
 .../layout/catalog_category_view_type_layered.xml  |  19 +-
 .../frontend/layout/catalogsearch_result_index.xml |  46 -----
 view/frontend/requirejs-config.js                  |   8 +-
 view/frontend/templates/filter.phtml               |  44 ++++
 view/frontend/templates/layer/filter.phtml         |  54 -----
 view/frontend/templates/layer/view.phtml           |  69 -------
 view/frontend/templates/products.phtml             |  17 +-
 view/frontend/templates/view.phtml                 |  67 +++++++
 view/frontend/web/css/source/_module.less          |   4 +-
 view/frontend/web/js/action/submit-filter.js       |  15 +-
 view/frontend/web/js/model/loader.js               |   2 +-
 view/frontend/web/js/view/layer.js                 |  45 ++---
 41 files changed, 1060 insertions(+), 1281 deletions(-)
~~~
### v2.0.0 to v1.2.0
~~~
 Helper/Data.php                                    |  34 +-
 Model/Config/Source/ActiveFilter.php               |  43 +
 Model/Layer/Filter/Attribute.php                   | 397 ++++-----
 Model/Layer/Filter/Category.php                    | 192 ++--
 Model/Layer/Filter/Decimal.php                     | 254 +++---
 Model/Layer/Filter/FilterInterface.php             |  80 --
 Model/Layer/Filter/Price.php                       |  78 +-
 Model/ResourceModel/Fulltext/Collection.php        | 981 ++++++++++-----------
 Model/Search/FilterGroup.php                       |   1 +
 Model/Search/FilterGroupBuilder.php                |   1 +
 Model/Search/SearchCriteria.php                    |   1 +
 Model/Search/SearchCriteriaBuilder.php             |   1 +
 .../Swatches => Plugins/Block}/RenderLayered.php   |  12 +-
 .../Controller}/Category/View.php                  |   9 +-
 .../Plugin => Plugins/Model}/Layer/Filter/Item.php |  55 +-
 etc/adminhtml/system.xml                           |  19 +
 etc/config.xml                                     |   7 +
 etc/di.xml                                         |   5 +-
 etc/frontend/di.xml                                |   6 +-
 etc/module.xml                                     |   2 +-
 registration.php                                   |  19 -
 .../layout/catalog_category_view_type_layered.xml  |   2 -
 view/frontend/requirejs-config.js                  |  27 -
 view/frontend/templates/filter.phtml               |  69 +-
 view/frontend/templates/view.phtml                 |  76 +-
 view/frontend/web/css/source/_module.less          |   5 -
 view/frontend/web/js/action/submit-filter.js       |  74 --
 view/frontend/web/js/layer.js                      | 165 ++++
 view/frontend/web/js/model/loader.js               |  44 -
 view/frontend/web/js/price/slider.js               |  64 ++
 view/frontend/web/js/view/layer.js                 | 234 -----
 31 files changed, 1361 insertions(+), 1596 deletions(-)
~~~
### v1.2.0 to v1.1.4
~~~
 Helper/Data.php                                    |  64 +-
 Model/Config/Source/ActiveFilter.php               |  43 -
 Model/Layer/Filter/Attribute.php                   |  53 +-
 Model/Layer/Filter/Category.php                    |  26 +-
 Model/Layer/Filter/Decimal.php                     |  26 +-
 Model/Layer/Filter/Price.php                       |  80 +-
 Model/ResourceModel/Fulltext/Collection.php        | 969 ++++++++++-----------
 Model/Search/FilterGroup.php                       |  33 +-
 Model/Search/FilterGroupBuilder.php                |  90 +-
 Model/Search/SearchCriteria.php                    |  33 +-
 Model/Search/SearchCriteriaBuilder.php             |  82 +-
 Plugins/Block/RenderLayered.php                    | 119 ++-
 Plugins/Controller/Category/View.php               |  62 +-
 Plugins/Model/Layer/Filter/Item.php                | 145 ++-
 composer.json                                      |   5 +-
 etc/acl.xml                                        |  26 +-
 etc/adminhtml/menu.xml                             |  26 +-
 etc/adminhtml/system.xml                           |  46 +-
 etc/config.xml                                     |  31 +-
 etc/di.xml                                         |  21 -
 etc/frontend/di.xml                                |  26 +-
 etc/module.xml                                     |  26 +-
 view/adminhtml/web/css/source/_module.less         |  20 -
 .../layout/catalog_category_view_type_layered.xml  |  25 +-
 view/frontend/templates/filter.phtml               |  57 +-
 view/frontend/templates/products.phtml             |  27 +-
 view/frontend/templates/view.phtml                 | 132 +--
 view/frontend/web/css/source/_module.less          |  38 -
 view/frontend/web/js/layer.js                      |  61 +-
 view/frontend/web/js/price/slider.js               |  32 +-
 30 files changed, 1007 insertions(+), 1417 deletions(-)
~~~
### v1.1.4 to v1.1.3
~~~
 Helper/Data.php                                    | 21 +--------
 Model/Layer/Filter/Attribute.php                   | 14 ------
 Model/Layer/Filter/Category.php                    | 14 +-----
 Model/Layer/Filter/Decimal.php                     | 14 +-----
 Model/Layer/Filter/Price.php                       | 14 +-----
 Model/ResourceModel/Fulltext/Collection.php        | 14 +-----
 Model/Search/FilterGroup.php                       | 15 +-----
 Model/Search/FilterGroupBuilder.php                | 26 ++--------
 Model/Search/SearchCriteria.php                    | 15 +-----
 Model/Search/SearchCriteriaBuilder.php             | 26 ++--------
 Plugins/Block/RenderLayered.php                    | 45 ------------------
 Plugins/Controller/Category/View.php               | 28 +----------
 Plugins/Model/Layer/Filter/Item.php                | 20 --------
 README.md                                          |  2 +-
 SearchAdapter/Filter/Builder/Term.php              | 55 ++++++++++++++++++++++
 composer.json                                      |  4 ++
 etc/acl.xml                                        |  6 +--
 etc/adminhtml/menu.xml                             | 16 -------
 etc/adminhtml/system.xml                           | 16 -------
 etc/config.xml                                     | 16 -------
 etc/di.xml                                         |  6 +++
 etc/frontend/di.xml                                | 17 +------
 etc/module.xml                                     | 16 -------
 .../layout/catalog_category_view_type_layered.xml  | 17 +------
 view/frontend/templates/filter.phtml               | 16 -------
 view/frontend/templates/products.phtml             | 16 ++-----
 view/frontend/templates/view.phtml                 | 16 -------
 27 files changed, 93 insertions(+), 392 deletions(-)
~~~
### v1.1.3 to v1.1.2
~~~
 Plugins/Block/RenderLayered.php     | 41 -------------------------------------
 Plugins/Model/Layer/Filter/Item.php |  4 +---
 etc/frontend/di.xml                 |  3 ---
 3 files changed, 1 insertion(+), 47 deletions(-)
~~~
### v1.1.2 to v1.1.1
~~~
 Model/Layer/Filter/Attribute.php            | 25 +++++--------
 Model/ResourceModel/Fulltext/Collection.php |  6 +++-
 SearchAdapter/Filter/Builder/Term.php       | 55 -----------------------------
 etc/di.xml                                  |  7 ----
 view/frontend/templates/view.phtml          | 17 ---------
 5 files changed, 13 insertions(+), 97 deletions(-)
~~~
### v1.1.1 to v1.1.0
~~~
 etc/acl.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
~~~
### v1.1.0 to v1.0.1
~~~
 Helper/Data.php                                    |  13 --
 Model/Layer/Filter/Attribute.php                   |  32 +---
 Model/Layer/Filter/Category.php                    | 133 ----------------
 Model/Layer/Filter/Decimal.php                     | 153 ------------------
 Model/Layer/Filter/Price.php                       | 173 ---------------------
 Model/ResourceModel/Fulltext/Collection.php        |  70 ++-------
 Model/Search/FilterGroup.php                       |  12 --
 Model/Search/FilterGroupBuilder.php                |  55 -------
 Model/Search/SearchCriteria.php                    |  12 --
 Model/Search/SearchCriteriaBuilder.php             |  51 ------
 Plugins/Controller/Category/View.php               |  12 +-
 Plugins/Model/Layer/Filter/Item.php                |  17 +-
 README.md                                          |   5 +-
 composer.json                                      |   4 +-
 etc/acl.xml                                        |  37 -----
 etc/adminhtml/menu.xml                             |   7 -
 etc/adminhtml/system.xml                           |  27 ++--
 etc/di.xml                                         |   3 -
 etc/module.xml                                     |   1 -
 view/adminhtml/web/css/source/_module.less         |   6 -
 .../layout/catalog_category_view_type_layered.xml  |  29 ++--
 view/frontend/templates/filter.phtml               |   9 +-
 view/frontend/web/js/layer.js                      |  50 +++---
 23 files changed, 74 insertions(+), 837 deletions(-)
~~~
