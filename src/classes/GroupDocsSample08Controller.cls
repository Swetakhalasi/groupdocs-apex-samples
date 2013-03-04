public with sharing class GroupDocsSample08Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string page { get; set; }
    public string url { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        GD_StorageApi storageApi = new GD_StorageApi(api);
/*
        string status = response.status;
        if (status.containsIgnoreCase('ok')) {
            GD_UploadRequestResult result = response.result;
            this.guid = result.guid;
            this.error = null;
        }
        else {
            this.error = response.error_message;
        }
*/
        return null;
    }
}