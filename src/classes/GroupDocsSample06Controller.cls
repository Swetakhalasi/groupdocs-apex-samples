public with sharing class GroupDocsSample06Controller {
    public string cid { get; set; }
    public string pkey { get; set; }
    public string baseUrl { get { return ((baseUrl == null) ? 'https://api.groupdocs.com/v2.0' : baseUrl); } set; }
    public string error { get; set; }
    public Blob document { get; set; }
    public string documentName { get; set; }
    public string documentType { get; set; }
    public Blob signature { get; set; }
    public string signatureName { get; set; }
    public string signatureType { get; set; }
    public Integer left { get { return ((left == null) ? 100 : left); } set; }
    public Integer top { get { return ((top == null) ? 100 : top); } set; }
    public Integer width { get { return ((width == null) ? 100 : width); } set; }
    public Integer height { get { return ((height == null) ? 100 : height); } set; }
    public string result { get; set; }
    

    public PageReference runSample() {
        try {
            GD_GroupDocsSecurityHandler securityHandler = new GD_GroupDocsSecurityHandler(this.pkey);
            GD_ApiClient api = new GD_ApiClient(securityHandler);
            GD_SignatureApi signatureApi = new GD_SignatureApi(api, this.baseUrl);
            GD_SignatureSignDocumentDocumentSettings docSettings = new GD_SignatureSignDocumentDocumentSettings();
            docSettings.name = this.documentName;
            docSettings.data = 'data:' + this.documentType + ';base64,'  + EncodingUtil.base64Encode(this.document);

            GD_SignatureSignDocumentSignerSettings signSettings = new GD_SignatureSignDocumentSignerSettings();
            signSettings.name = this.signatureName;
            signSettings.data = 'data:' + this.signatureType + ';base64,'  + EncodingUtil.base64Encode(this.signature);
            signSettings.top = this.top;
            signSettings.left = this.left;
            signSettings.width = this.width;
            signSettings.height = this.height;
            
            List<GD_SignatureSignDocumentDocumentSettings> documents = new List<GD_SignatureSignDocumentDocumentSettings>();
            documents.add(docSettings);
            List<GD_SignatureSignDocumentSignerSettings> signers = new List<GD_SignatureSignDocumentSignerSettings>();
            signers.add(signSettings);
            
            GD_SignatureSignDocumentSettings body = new GD_SignatureSignDocumentSettings();
            body.documents = documents;
            body.signers = signers;
            GD_SignatureSignDocumentsResponse response = signatureApi.SignDocument(this.cid, body);
            string status = response.status;
            if (status.containsIgnoreCase('ok')) {
                GD_SignatureSignDocumentsResult result = response.result;
                for (GD_SignatureSignDocumentInfo document : result.documents) {
                    this.result = 'https://apps.groupdocs.com/document-viewer/Embed/' + document.documentId + '?quality=50&use_pdf=False&download=False&print=False';
                    break;
                }
                this.error = null;
            }
            else {
                this.error = response.error_message;
            }
        }
        catch (Exception e) {
            this.error = e + '';
        }
        return null;
    }

}