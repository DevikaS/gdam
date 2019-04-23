package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 9/26/14
 * Time: 5:45 PM
 * To change this template use File | Settings | File Templates.
 */
public class ContentBatchUpdate {
    private CustomMetadata _cm;
    private String _id;
    private String _subtype;

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String get_subtype() {
        return _subtype;
    }

    public void set_subtype(String _subtype) {
        this._subtype = _subtype;
    }

    public CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    public CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }



}
