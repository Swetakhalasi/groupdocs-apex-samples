public with sharing class GroupDocsSample08Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public String guid { get; set; }
    public string page { get; set; }
    public string url { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        GD_DocApi docApi = new GD_DocApi(api);
        GD_GetImageUrlsResponse response = docApi.GetDocumentPagesImageUrls(cid, guid, Integer.valueOf(page), 1, '600x800', null, false, null);
        string status = response.status;
        if (status.containsIgnoreCase('ok')) {
            GD_GetImageUrlsResult result = response.result;
            this.url = result.url.get(0);
            this.error = null;
        }
        else {
            this.error = response.error_message;
        }
        return null;
    }
}