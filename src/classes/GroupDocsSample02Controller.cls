public with sharing class GroupDocsSample02Controller {
    public String cid { get; set; }
    public String pkey { get; set; }
    public List<GD_FileSystemFolder> folders { get; set; }
    public List<GD_FileSystemDocument> files { get; set; }

    public PageReference runSample() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        GD_StorageApi storageApi = new GD_StorageApi(api);
        GD_ListEntitiesResponse response = storageApi.ListEntities(this.cid, '', null, null, null, null, null, null, null);
        string status = response.status;
        if (status.containsIgnoreCase('ok')) {
            GD_ListEntitiesResult result = response.result;
            this.folders = result.folders;
            this.files = result.files;
        }
        
        /*
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
        */
        return null;
    }
}