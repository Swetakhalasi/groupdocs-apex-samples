public with sharing class GroupDocsSample01Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string fname { get; set; }
    public string lname { get; set; }
    public string nickname { get; set; }
    public string primaryemail { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_MgmtApi mgmt = buildGDRequest();
        GD_UserInfoResponse response = mgmt.GetUserProfile(cid);
        string errmsg = parseResponse(response);
    	this.error = (errmsg == null) ? null : errmsg;
        return null;
    }

	public GD_MgmtApi buildGDRequest() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        return new GD_MgmtApi(api);
	}

	public string parseResponse(GD_UserInfoResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        GD_UserInfoResult result = response.result;
        GD_UserInfo userInfo = result.user;
        this.fname = userInfo.firstname;
        this.lname = userInfo.lastname;
        this.nickname = userinfo.nickname;
        this.primaryemail = userInfo.primary_email;
        return null;
	}
}