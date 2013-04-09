public with sharing class GroupDocsSample13Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string guid { get; set; }
    public string collab { get; set; }
    public GD_SetCollaboratorsResult result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_AntApi antApi = buildGDRequest();
        List<String> body = new List<String>();
        body.add(this.collab);
        GD_SetCollaboratorsResponse response = antApi.SetAnnotationCollaborators(this.cid, this.guid, 'v2.0', body);
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

	public string parseResponse(GD_SetCollaboratorsResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        this.result = response.result;
        return null;
	}
}