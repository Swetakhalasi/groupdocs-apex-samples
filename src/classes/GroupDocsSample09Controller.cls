public with sharing class GroupDocsSample09Controller {
    public string guid { get; set; }
    public string width { get { return (this.width == null) ? '800' : this.width; } set; }
    public string height { get { return (this.height == null) ? '600' : this.height; } set; }
    public string result { get; set; }
    public string error { get; set; }

    public PageReference runSample() {
        this.result = 'https://apps.groupdocs.com/document-viewer/embed/' + this.guid;
        return null;
    }
}