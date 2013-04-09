### GroupDocs samples for SalesForce (Apex)

Samples how to use GroupDocs SDK for integration GroupDocs functional to SalesForce application.

## Now implemented next samples:
* Sample 1  - How to login to GroupDocs using the API
* Sample 2  - How to list files within GroupDocs Storage using the Storage API
* Sample 3  - How to upload a file to GroupDocs using the Storage API
* Sample 5  - How to copy / move a file using the GroupDocs Storage API
* Sample 6  - How to add a Signature to a document in GroupDocs Signature
* Sample 8  - How to return a URL representing a single page of a Document
* Sample 9  - How to generate an embedded Viewer URL for a Document
* Sample 10 - How to share a document to other users
* Sample 12 - How to list all annotations from document
* Sample 13 - How to add collaborator to doc with annotations
* Sample 14 - How to check the list of shares for a folder
* Sample 15 - How to check the number of document's views

## GroupDocs Assembly integration with SalesForce application

Steps for use sample:
* Login to salesforce site and go to GroupDocs application 'GroupDocs For Salesforce'.
* Go to 'Setup'
* Now you should create salesforce object type. Go to 'Create'=>'Objects'
* Click to button 'New custom object'
* Fill required fields and click 'Save'
* After save object type you should add few custon fields 
* Select Text type of field, but you can use any type for your fileds.
* Configure field properties. Click 'Next'=>'Next'=>'Save'
* After adding fields go to 'Tabs'
* You should cteate tab for your custom object
* Fill required data and click 'Next'=>'Next'
* Add new tab only to GroupDocs application and click 'Save'
* Now you should add few objects for your custom object type. Go to created tab
* Click 'New', fill values and save
* Now go to tab 'GroupDocs Assembly Sample'
* Fill GroupDocs App CID, App Key (get your appCID, appKey - http://groupdocs.com/docs/pages/viewpage.action?pageId=1409573)
* Select object type which you created ( for example 'SampleObject' )
* Click 'Load objects' button and select one of loaded object.
* In text area with name 'Fields to use in template' you can found constants for use it in template document (merge field in Microsoft Word).
* Create template file in Microsoft Word and use upload form for upload template file to GroupDocs account
* Select template file in GroupDocs account
* Click 'Merge' button. When merge is done, use button 'Get Document Link' for get link by Job ID
* You can download merged file by this link.

# Development

* Plugin implemented as salesforce tab 'GroupDocs Assembly Sample' in  application 'GroupDocs For Salesforce'.
* Functional part implemented in file 'GroupDocsSampleAssemblyController.cls'. View part implemented in file 'GroupDocsSampleAssembly.page'.
* Also in the controller are used SDK files. They have prefix in name like GD_*.
* Force.com IDE - http://wiki.developerforce.com/page/Force.com_IDE_Installation
* (I recommend use Force.com IDE for create new files and 'Visualforce Pages Development Mode Tools' for editing created files)
* Import project to Force.com IDE. Use developer accout for it (Trial account not working with API)
* During step with import components select 'classes' and 'pages' components.

###[Sign, Manage, Annotate, Assemble, Compare and Convert Documents with GroupDocs](http://groupdocs.com)
1. [Sign documents online with GroupDocs Signature](http://groupdocs.com/apps/signature)
2. [PDF, Word and Image Annotation with GroupDocs Annotation](http://groupdocs.com/apps/annotation)
3. [Online DOC, DOCX, PPT Document Comparison with GroupDocs Comparison](http://groupdocs.com/apps/comparison)
4. [Online Document Management with GroupDocs Dashboard](http://groupdocs.com/apps/dashboard)
5. [Doc to PDF, Doc to Docx, PPT to PDF, and other Document Conversions with GroupDocs Viewer](http://groupdocs.com/apps/viewer)
6. [Online Document Automation with GroupDocs Assembly](http://groupdocs.com/apps/assembly)
