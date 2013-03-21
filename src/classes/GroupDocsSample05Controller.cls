public with sharing class GroupDocsSample05Controller {

    public string cid { get; set; }
    public string pkey { get; set; }
    public string source { get; set; }
    public string destination { get; set; }
    public string move { get; set; }
    public string id { get; set; }
    public GD_DocumentInfo src { get; set; }
    public GD_DocumentInfo dst { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        
        GD_DocApi docApi = new GD_DocApi(api);
        GD_GetDocumentInfoResponse resp = docApi.GetDocumentMetadataByPath(cid, source);
        if (resp.status.containsIgnoreCase('ok') == false) {
            this.error = resp.error_message;
            return null;
        }
        this.id = resp.result.id + '';
        
        GD_StorageApi storageApi = new GD_StorageApi(api);
        GD_FileMoveResponse response = null;
        if (move == null) {
            response = storageApi.MoveFile(cid, destination, null, this.id, null);
        }
        else {
            response = storageApi.MoveFile(cid, destination, null, null, this.id);
        }
        string status = response.status;
        if (status.containsIgnoreCase('ok')) {
            this.src = response.result.src_file;
            this.dst = response.result.dst_file;
            this.error = null;
        }
        else {
            this.error = response.error_message;
        }
        return null;
    }
}