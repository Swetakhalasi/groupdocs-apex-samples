public with sharing class GroupDocsSample03Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public Blob body { get; set; }
    public string name { get; set; }
    public string path { get { return (path != null)? path : ''; } set; }
    public string description { get; set;}
    public string guid { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        GD_StorageApi storageApi = new GD_StorageApi(api);
        if (path.endsWith('/') == false && path.endsWith('\\') == false) {
            path = path + '/';
        }
        if (path.startsWith('/')) {
            path = path.substringAfter('/');
        }
        if (path.startsWith('\\')) {
            path = path.substringAfter('\\');
        }
        GD_UploadResponse response = storageApi.Upload(cid, path + name, description, body);
        string status = response.status;
        if (status.containsIgnoreCase('ok')) {
            GD_UploadRequestResult result = response.result;
            this.guid = result.guid;
            this.error = null;
        }
        else {
            this.error = response.error_message;
        }
        return null;
    }
}