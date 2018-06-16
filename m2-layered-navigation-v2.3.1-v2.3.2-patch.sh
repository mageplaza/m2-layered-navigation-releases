diff --git a/README.md b/README.md
index 397c22a..7a04410 100644
--- a/README.md
+++ b/README.md
@@ -1,79 +1,52 @@
 ## Documentation
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/#solution-1-ready-to-paste
+- Installation guide: https://docs.mageplaza.com/kb/installation.html
 - User Guide: https://docs.mageplaza.com/layered-navigation-m2/
 - Product page: https://www.mageplaza.com/magento-2-layered-navigation-extension/
-- FAQs: https://www.mageplaza.com/faqs/
 - Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
 - Changelog: https://www.mageplaza.com/changelog/m2-layered-navigation.txt
 - License agreement: https://www.mageplaza.com/LICENSE.txt
 
+
+
 ## How to install
 
-### Install ready-to-paste package (Recommended)
+### Method 1: Install ready-to-paste package (Recommended)
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
+- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
+- Installation guide: https://docs.mageplaza.com/kb/installation.html
 
-## How to upgrade
 
-1. Backup
 
-Backup your Magento code, database before upgrading.
+### Method 2: Manually install via composer
 
-2. Remove GiftCard folder 
+1. Access to your server via SSH
+2. Create a folder (Not Magento root directory) in called: `mageplaza`, 
+3. Download the zip package at https://store.mageplaza.com/my-downloadable-products.html
+4. Upload the zip package to `mageplaza` folder.
 
-In case of customization, you should backup the customized files and modify in newer version. 
-Now you remove `app/code/Mageplaza/GiftCard` folder. In this step, you can copy override GiftCard folder but this may cause of compilation issue. That why you should remove it.
 
-3. Upload new version
-Upload this package to Magento root directory
+3. Add the following snippet to `composer.json`
 
-4. Run command line:
+```
+	{
+		"repositories": [
+		 {
+		 "type": "artifact",
+		 "url": "mageplaza/"
+		 }
+		]
+	}
+```
+
+4. Run composer command line
 
 ```
+composer require mageplaza/layered-navigation-m2
 php bin/magento setup:upgrade
 php bin/magento setup:static-content:deploy
 ```
 
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
-
-
-## Support
-
-- FAQs: https://www.mageplaza.com/faqs/
-- https://mageplaza.freshdesk.com/
-- support@mageplaza.com
-
-
-## Documentation
-
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
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
 ## FAQs
 
 
diff --git a/USER-GUIDE.md b/USER-GUIDE.md
index 397c22a..7a04410 100644
--- a/USER-GUIDE.md
+++ b/USER-GUIDE.md
@@ -1,79 +1,52 @@
 ## Documentation
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/#solution-1-ready-to-paste
+- Installation guide: https://docs.mageplaza.com/kb/installation.html
 - User Guide: https://docs.mageplaza.com/layered-navigation-m2/
 - Product page: https://www.mageplaza.com/magento-2-layered-navigation-extension/
-- FAQs: https://www.mageplaza.com/faqs/
 - Get Support: https://mageplaza.freshdesk.com/ or support@mageplaza.com
 - Changelog: https://www.mageplaza.com/changelog/m2-layered-navigation.txt
 - License agreement: https://www.mageplaza.com/LICENSE.txt
 
+
+
 ## How to install
 
-### Install ready-to-paste package (Recommended)
+### Method 1: Install ready-to-paste package (Recommended)
 
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
+- Download the latest version at https://store.mageplaza.com/my-downloadable-products.html
+- Installation guide: https://docs.mageplaza.com/kb/installation.html
 
-## How to upgrade
 
-1. Backup
 
-Backup your Magento code, database before upgrading.
+### Method 2: Manually install via composer
 
-2. Remove GiftCard folder 
+1. Access to your server via SSH
+2. Create a folder (Not Magento root directory) in called: `mageplaza`, 
+3. Download the zip package at https://store.mageplaza.com/my-downloadable-products.html
+4. Upload the zip package to `mageplaza` folder.
 
-In case of customization, you should backup the customized files and modify in newer version. 
-Now you remove `app/code/Mageplaza/GiftCard` folder. In this step, you can copy override GiftCard folder but this may cause of compilation issue. That why you should remove it.
 
-3. Upload new version
-Upload this package to Magento root directory
+3. Add the following snippet to `composer.json`
 
-4. Run command line:
+```
+	{
+		"repositories": [
+		 {
+		 "type": "artifact",
+		 "url": "mageplaza/"
+		 }
+		]
+	}
+```
+
+4. Run composer command line
 
 ```
+composer require mageplaza/layered-navigation-m2
 php bin/magento setup:upgrade
 php bin/magento setup:static-content:deploy
 ```
 
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
-
-
-## Support
-
-- FAQs: https://www.mageplaza.com/faqs/
-- https://mageplaza.freshdesk.com/
-- support@mageplaza.com
-
-
-## Documentation
-
-- Installation guide: https://www.mageplaza.com/install-magento-2-extension/
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
 ## FAQs
 
 
diff --git a/composer.json b/composer.json
index 1f9f8a9..024a4cf 100644
--- a/composer.json
+++ b/composer.json
@@ -5,7 +5,7 @@
     "mageplaza/module-core": "*"
   },
   "type": "magento2-module",
-  "version": "2.3.1",
+  "version": "2.2.0",
   "license": "Mageplaza License",
   "authors": [
     {
