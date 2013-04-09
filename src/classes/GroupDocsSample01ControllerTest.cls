public class GroupDocsSample01ControllerTest {
	public static final string cid = 'testCid';
	public static final string pkey = 'testPkey';
	public static GroupDocsSample01Controller controller = null;
	public static GD_UserInfoResponse response = null;

	@isTest
	public static void buildGDRequestTest() {
		controller = new GroupDocsSample01Controller();
		controller.cid = cid;
		controller.pkey = pkey;
		
		GD_MgmtApi mgmtApi = controller.buildGDRequest();
		System.assertNotEquals(mgmtApi, null);
	}

	@isTest
	public static void parseResponseTest() {
		controller = new GroupDocsSample01Controller();

		GD_UserInfoResponse sampleResponse = new GD_UserInfoResponse();
		GD_UserInfoResult result = new GD_UserInfoResult();
		GD_UserInfo userInfo = new GD_UserInfo();

		sampleResponse.status = 'fail';
		sampleResponse.error_message = 'err';
		sampleResponse.result = result;

		string errmsg = controller.parseResponse(sampleResponse);
		System.assertEquals(errmsg, sampleResponse.error_message);
	    System.assertEquals(errmsg, sampleResponse.error_message);

		sampleResponse.status = 'ok';
		
		result.user = userInfo;

        userInfo.firstname = 'testfirstname';
        userInfo.lastname = 'testlastname';
        userinfo.nickname = 'testnickname';
        userInfo.primary_email = 'testprimary_email';

		errmsg = controller.parseResponse(sampleResponse);
		System.assertEquals(errmsg, null);
		
		System.assertEquals(controller.fname, userInfo.firstname);
		System.assertEquals(controller.lname, userInfo.lastname);
		System.assertEquals(controller.nickname, userInfo.nickname);
		System.assertEquals(controller.primaryemail, userInfo.primary_email);
	}
}