public with sharing class GroupDocsSampleAssemblyController {
    public String successMessage { get; set; }
    public string appCID { get; set; }
    public string appKEY { get; set; }
    public string baseURL { get { return ((baseUrl == null) ? 'https://api.groupdocs.com/v2.0' : baseUrl); } set; }
    public string templateGuid { get; set; }
    public Blob uTemplateBody { get; set; }
    public string uTemplateName { get; set; }
    public string selectedObject { get; set; }
    public string selectedObjectType { get; set; }
    public string saveFormat { get; set; }
    public string errorMessage { get; set; }
    public string objectFields { get; set; }
    public string jobId { get; set; }
    public string downloadLink { get; set; }
    public string jobStatus { get; set; }

    public List<SelectOption> getTypesOfObjets() {
        List<SelectOption> res = new List<SelectOption>();
        Map<String, Schema.SObjectType> objects = Schema.getGlobalDescribe();
        for(String name : objects.keySet())
        {
            Schema.SObjectType type = objects.get(name);
            String label = type.getDescribe().getLabel();
            res.add(new SelectOption(name, label));
        }
        return res;
    }
    
    public PageReference refreshObjects(){
        this.errorMessage = '';
        if (this.selectedObjectType == null) {
            this.errorMessage = 'Please, select object type before!';
        }
        return null;
    }

    public List<SelectOption> getObjects() {
        this.errorMessage = '';
        if (this.selectedObjectType == null) {
            return null;
        }
        Map<String, Schema.SObjectType> objects = Schema.getGlobalDescribe();
        SObjectType objToken = objects.get(this.selectedObjectType);
        if (objToken == null) {
            this.errorMessage = 'Object type is not found!';
        }
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap(); 
        Set<String> fieldSet = fields.keySet();
		// Get fields names
		List<String> namesOfFields = new List<String>();
        for(String field : fieldSet)
        {
            SObjectField fieldToken = fields.get(field);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            namesOfFields.add(selectedField.getName().toUpperCase());
        }
        objectFields = string.join(namesOfFields, ', ');
		//
        string query = 'SELECT ' + string.join(new List<string>(fieldSet), ',') + ' FROM ' + this.selectedObjectType + ' LIMIT 100';
        sobject [] records = Database.query(query);
        
        List<SelectOption> res = new List<SelectOption>();
        for (sObject sObj : records) {
            string name = (string) sObj.get('name');
            res.add(new SelectOption(name, name));
        }
        return res;
    }

    public List<SelectOption> getFormats() {
        List<SelectOption> res = new List<SelectOption>();
        res.add(new SelectOption('DOC', 'DOC'));
        return res;
    }

    public List<SelectOption> getTemplates() {
        if (this.appCID == null || this.appCID == '' || this.appKEY == null || this.appKEY == ''){
            this.errorMessage = 'Please, enter App CID and App Key';
            return null;
        }
        List<SelectOption> res = new List<SelectOption>();
        try {
            GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(this.appKey);
            GD_ApiClient api = new GD_ApiClient(securityHandler);
            GD_StorageApi storageApi = new GD_StorageApi(api, this.baseURL);
            GD_ListEntitiesResponse response = storageApi.ListEntities(this.appCID, '', null, null, null, null, null, null, null);
            string status = response.status;
            if (status.containsIgnoreCase('ok')) {
	            GD_ListEntitiesResult result = response.result;
                for (GD_FileSystemDocument document : result.files){
                    res.add(new SelectOption(document.guid, document.name));
                }
            }
        }
        catch (Exception e){
            this.errorMessage = e + '';
        }
        return res;
    }

    public PageReference runSample() {
        try {
            // Get object fields values
            Map<String, Schema.SObjectType> objects = Schema.getGlobalDescribe();
            SObjectType objToken = objects.get(this.selectedObjectType);
            if (objToken == null) {
                this.errorMessage = 'Object type is not found!';
            }
            DescribeSObjectResult objDef = objToken.getDescribe();
            Map<String, SObjectField> fields = objDef.fields.getMap(); 
            Set<String> fieldSet = fields.keySet();
            string query = 'SELECT ' + string.join(new List<string>(fieldSet), ',') + ' FROM ' + this.selectedObjectType + ' WHERE name=\'' + this.selectedObject + '\' LIMIT 1';
            sobject sObj = Database.query(query);
            
            List<GD_DatasourceField> body = new List<GD_DatasourceField>();
            for(String field : fieldSet)
            {
                SObjectField fieldToken = fields.get(field);
                DescribeFieldResult selectedField = fieldToken.getDescribe();
                string name = selectedField.getName();
                string value = string.valueOf(sObj.get(name));
                GD_DatasourceField datasourceField = new GD_DatasourceField();
                datasourceField.name = name;
                datasourceField.m_type = 'Text';
                List<string> values = new List<string>();
                values.add(value);
                datasourceField.values = values;
                body.add(datasourceField);
            }
            
            GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(this.appKey);
            GD_ApiClient api = new GD_ApiClient(securityHandler);
            GD_MergeApi mergeApi = new GD_MergeApi(api, this.baseURL);
            GD_MergeTemplateResponse response = mergeApi.MergeDatasourceFields(this.appCID, this.templateGuid, /*String targetType*/ this.saveFormat, /*String emailResults*/ null, /*String assemblyName*/ null, body);
            string status = response.status;
            if (status.containsIgnoreCase('ok')) {
	            GD_MergeTemplateResult result = response.result;
                this.jobId = string.valueOf((Integer) result.job_id);
			}
            else {
	            this.errorMessage = response.error_message;
            }
        }
        catch (Exception e){
            this.errorMessage = e + '';
        }

        return null;
    }

    public PageReference refresh() {
        return null;
    }


    public PageReference uploadTemplate() {
        if (this.appCID == null || this.appCID == '' || this.appKEY == null || this.appKEY == ''){
            return null;
        }
        try {
            GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(this.appKey);
            GD_ApiClient api = new GD_ApiClient(securityHandler);
            GD_StorageApi storageApi = new GD_StorageApi(api, this.baseURL);
            GD_UploadResponse response = storageApi.Upload(this.appCID, this.uTemplateName, '', this.uTemplateBody);
            string status = response.status;
            if (status.containsIgnoreCase('ok')) {
	            GD_UploadRequestResult result = response.result;
                this.successMessage = 'File Uploaded!';
            }
        }
        catch (Exception e){
            this.errorMessage = e + '';
        }
        return null;
    }
    
    public PageReference getDocumentLink(){
         try {
            GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(this.appKey);
            GD_ApiClient api = new GD_ApiClient(securityHandler);
            GD_AsyncApi asyncApi = new GD_AsyncApi(api, this.baseURL);
            GD_GetJobDocumentsResponse response = asyncApi.GetJobDocuments(this.appCID, this.jobId, 'json');
            string status = response.status;
            this.downloadLink = '';
            if (status.containsIgnoreCase('ok')) {
	            GD_GetJobDocumentsResult result = response.result;
                for (GD_JobInputDocument input : result.inputs){
                    if (input.guid == this.templateGuid){
                        for (GD_JobOutputDocument output : input.outputs){
                            this.downloadLink += output.url + '\n\r';
                        }
                        this.jobStatus = input.status;
                        break;
                    }
                }
            }
        }
        catch (Exception e){
            this.errorMessage = e + '';
        }
       return null;
    }
}