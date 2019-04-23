package com.adstream.automate.babylon.JsonObjects;

/**
 * User: ruslan.semerenko
 * Date: 18.05.12 20:07
 */
public class Role extends BaseObject {
    public static final String GROUP_GLOBAL = "global";
    public static final String GROUP_PROJECT = "project";
    public static final String GROUP_LIBRARY = "library";
    public static final String GROUP_SYSTEM = "system";
    public static final String GROUP_UNDEFINED = "undefined";

  //  public static final String GROUP_GLOBAL_ROLE = "global role";
  //  public static final String GROUP_PROJECT_ROLE = "project role ";
  //  public static final String GROUP_LIBRARY_ROLE = "library role";


    private String group;
    private CustomMetadata _cm;

    public String[] getAllow() {
        return getCmCommon().getStringArray("allow");
    }

    public void setAllow(String[] allow) {
        getCmCommon().put("allow", allow);
    }

    public String[] getDeny() {
        return getCmCommon().getStringArray("deny");
    }

    public void setDeny(String[] deny) {
        getCmCommon().put("deny", deny);
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Override
    public String getName() {
        return getCmCommon().getString("name");
    }

    @Override
    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    private CustomMetadata getCm() {
        if (_cm == null) {
            _cm = new CustomMetadata();
        }
        return _cm;
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }
}
