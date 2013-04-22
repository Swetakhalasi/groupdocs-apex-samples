public with sharing class GroupDocsSample04Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string guid { get; set; }
    public string link { get; set; }
    public string error { get; set; }
    
    public PageReference runSample() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        GD_StorageApi storageApi = new GD_StorageApi(api);
        Blob data = storageApi.GetFile(cid, guid);
        this.link = EncodingUtil.base64Encode(data);
        return null;
    }
}