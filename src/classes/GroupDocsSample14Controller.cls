public with sharing class GroupDocsSample14Controller {
    protected GD_ApiClient apiClient { get; set; }
    public string cid { get; set; }
    public string pkey { get; set; }
    public string fpath { get; set; }
    public double folderId { get; set; }
    public GD_SharedUsersResult result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_StorageApi storageApi = buildGDStorageApi();
        GD_DocApi docApi = buildGDDocApi();
        
        GD_ListEntitiesResponse response = storageApi.ListEntities(this.cid, '', null, null, null, null, null, null, null);
        string errmsg = parseStorageResponse(response);
        if (this.folderId != null && errmsg == null) {
            GD_SharedUsersResponse sharedResponse = docApi.GetFolderSharers(this.cid, string.valueOf(this.folderId));
            errmsg = parseDocResponse(sharedResponse);
        }
        return null;
    }

	public GD_DocApi buildGDDocApi() {
        return new GD_DocApi(this.apiClient);
	}

    public GD_StorageApi buildGDStorageApi() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        this.apiClient = new GD_ApiClient(securityHandler);
        return new GD_StorageApi(this.apiClient);
	}

	public string parseStorageResponse(GD_ListEntitiesResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        GD_ListEntitiesResult result = response.result;
        for (GD_FileSystemFolder folder : result.folders) {
            if (folder.name == this.fpath) {
                this.folderId = folder.id;
                break;
            }
        }
        return null;
	}
	public string parseDocResponse(GD_SharedUsersResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        this.result = response.result;
        return null;
	}
}