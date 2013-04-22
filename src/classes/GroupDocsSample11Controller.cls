public with sharing class GroupDocsSample11Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string guid { get; set; }

    public string annType { get; set; }
    public List<string> annTypes { get; set; }
    public double boxx { get; set; }
    public double boxy { get; set; }
    public double boxw { get; set; }
    public double boxh { get; set; }
    public Integer anpx { get; set; }
    public Integer anpy { get; set; }
    public Integer rangp { get; set; }
    public Integer rangl { get; set; }
    public string text { get; set; }
    public string result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        GD_AntApi antApi = buildGDRequest();
        GD_AnnotationInfo requestBody = buildRequestBody();
        GD_CreateAnnotationResponse response = antApi.CreateAnnotation(this.cid, this.guid, requestBody);
        string errmsg = parseResponse(response);
    	this.error = (errmsg == null) ? null : errmsg;
        return null;
    }

	public GD_AntApi buildGDRequest() {
        GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(this.pkey);
        GD_ApiClient api = new GD_ApiClient(securityHandler);
        return new GD_AntApi(api);
	}

    public GD_AnnotationInfo buildRequestBody() {
        GD_AnnotationInfo annotationInfo = new GD_AnnotationInfo();
        annotationInfo.m_type = 'text';
        annotationInfo.createdOn = Datetime.now().getTime();
        
        GD_AnnotationReplyInfo annotationReplyInfo = new GD_AnnotationReplyInfo();
        annotationReplyInfo.text = this.text;
        annotationReplyInfo.repliedOn = Datetime.now().getTime();
        List<GD_AnnotationReplyInfo> annotationReplyInfoList = new List<GD_AnnotationReplyInfo>();
        annotationReplyInfoList.add(annotationReplyInfo);
        annotationInfo.replies = annotationReplyInfoList;
        
        GD_Rectangle rectangle = new GD_Rectangle();
        rectangle.x = this.boxx;
        rectangle.y = this.boxy;
        rectangle.width = this.boxw;
        rectangle.height = this.boxh;
        GD_Range range = new GD_Range();
        range.position = this.rangp;
        range.length = this.rangl;
        GD_Point point = new GD_Point();
        point.x = this.anpx;
        point.y = this.anpy;
        annotationInfo.box = rectangle;
        annotationInfo.range = range;
        annotationInfo.annotationPosition = point;
        
        return annotationInfo;
    }
    
	public string parseResponse(GD_CreateAnnotationResponse response) {
        string status = response.status;
        if (status.containsIgnoreCase('ok') == false) {
            return response.error_message;
        }
        this.result = response.result.documentGuid;
        return null;
	}
}