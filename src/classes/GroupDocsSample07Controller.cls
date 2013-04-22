public with sharing class GroupDocsSample07Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public List<string> images { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        if (this.images == null) {
	       	this.images = new  List<string>();
        }
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(this.pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        GD_StorageApi storageApi = new GD_StorageApi(api);
        GD_ListEntitiesResponse response = storageApi.ListEntities(this.cid, '', null, null, null, null, null, null, null);
        string status = response.status;
        if (status.containsIgnoreCase('ok')) {
            GD_ListEntitiesResult result = response.result;
            List<GD_FileSystemDocument> docs = result.files;
	        for (GD_FileSystemDocument document : docs) {
                if (document.thumbnail != null) {
                    this.images.add('5');
                    this.images.add(document.thumbnail);
                }
            }
        }
        else {
            this.error = response.error_message;
        }
        return null;
    }
}