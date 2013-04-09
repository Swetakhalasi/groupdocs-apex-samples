public with sharing class GroupDocsSample12Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string guid { get; set; }
    public List<GD_AnnotationInfo> result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_AntApi antApi = buildGDRequest();
        GD_ListAnnotationsResponse response = antApi.ListAnnotations(this.cid, this.guid);
        string errmsg = parseResponse(response);
    	this.error = (errmsg == null) ? null : errmsg;
        return null;
    }

	public GD_AntApi buildGDRequest() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        return new GD_AntApi(api);
        return null;
	}

	public string parseResponse(GD_ListAnnotationsResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        GD_ListAnnotationsResult result = response.result;
        this.result = result.annotations;
        return null;
	}
}