public with sharing class GroupDocsSample15Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public GD_DocumentViewsResult result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_DocApi docApi = buildGDRequest();
		GD_DocumentViewsResponse response = docApi.GetDocumentViews(this.cid, null, null);
        string errmsg = parseResponse(response);
    	this.error = (errmsg == null) ? null : errmsg;
        return null;
    }

	public GD_DocApi buildGDRequest() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        return new GD_DocApi(api);
        return null;
	}

	public string parseResponse(GD_DocumentViewsResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        this.result = response.result;
        return null;
	}
}