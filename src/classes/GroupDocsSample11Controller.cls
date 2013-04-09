public with sharing class GroupDocsSample11Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string guid { get; set; }

    public string annType { get; set; }
    public List<string> annTypes { get; set; }
    public string boxx { get; set; }
    public string boxy { get; set; }
    public string boxw { get; set; }
    public string boxh { get; set; }
    public string anpx { get; set; }
    public string anpy { get; set; }
    public string rangp { get; set; }
    public string rangl { get; set; }
    public string text { get; set; }
    public string result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
    	/*
        GD_MgmtApi mgmt = buildGDRequest();
        GD_UserInfoResponse response = mgmt.GetUserProfile(cid);
        string errmsg = parseResponse(response);
    	this.error = (errmsg == null) ? null : errmsg;
    	*/
        return null;
    }

	public GD_MgmtApi buildGDRequest() {
		/*
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        return new GD_MgmtApi(api);
        */
        return null;
	}

	public string parseResponse(GD_UserInfoResponse response) {
		/*
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
        */
        return null;
	}
}