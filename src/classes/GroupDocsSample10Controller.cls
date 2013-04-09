public with sharing class GroupDocsSample10Controller {
    protected GD_ApiClient api { get; set; }
    public string cid { get; set; }
    public string pkey { get; set; }
    public string guid { get; set; }
    public string email { get; set; }
    public double fileId { get; set; }
    public string result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_StorageApi storageApi = buildGDRequest();
        GD_ListEntitiesResponse response = storageApi.ListEntities(this.cid, '', 0, null, null, null, null, null, false);
        string errmsg = parseResponse(response);
        if (errmsg == null) {
            this.error = errmsg;
            return null;
        }
        GD_DocApi docApi = buildGDDocApi();
        List<string> users = new List<string>();
        users.add(this.email);
        GD_SharedUsersResponse responseDocApi = docApi.ShareDocument(this.cid, string.valueOf(this.fileId), users);
        if (responseDocApi.status.containsIgnoreCase('ok') == false) {
	    	this.error = responseDocApi.error_message;
        }
        return null;
    }

	public GD_StorageApi buildGDRequest() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        this.api = new GD_ApiClient(securityHandler);
        return new GD_StorageApi(api);
	}

	public string parseResponse(GD_ListEntitiesResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        GD_ListEntitiesResult result = response.result;
        for (GD_FileSystemDocument document : result.files) {
            if (document.guid == this.guid) {
                this.fileId = document.id;
                break;
            }
        }
        return null;
	}
    
    public GD_DocApi buildGDDocApi() {
        return new GD_DocApi(this.api);
    }
}