package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.04.13
 * Time: 16:57
 */
public class UserGroup extends BaseObject {
     private CustomMetadata _cm;

    public String getName() {
        return getCmCommon().getString("name");
    }

    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    protected CustomMetadata getCm() {
        if (_cm == null) {
            _cm = new CustomMetadata();
        }
        return _cm;
    }

    protected CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }
}