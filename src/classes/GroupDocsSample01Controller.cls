public with sharing class GroupDocsSample01Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string fname { get; set; }
    public string lname { get; set; }
    public string nickname { get; set; }
    public string primaryemail { get; set; }

    public PageReference runSample() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        GD_MgmtApi mgmt = new GD_MgmtApi(api);
        GD_UserInfoResponse response = mgmt.GetUserProfile(cid);
        string status = response.status;
        if (status.containsIgnoreCase('ok')) {
            GD_UserInfoResult result = response.result;
            GD_UserInfo userInfo = result.user;
            this.fname = userInfo.firstname;
            this.lname = userInfo.lastname;
            this.nickname = userinfo.nickname;
            this.primaryemail = userInfo.primary_email;
        }
        return null;
    }
}