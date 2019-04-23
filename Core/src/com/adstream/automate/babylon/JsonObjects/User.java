package com.adstream.automate.babylon.JsonObjects;

import com.adstream.automate.babylon.JsonObjects.ordering.DeliveryAccessRule;
import com.adstream.automate.babylon.TestsContext;
import org.apache.commons.lang.ArrayUtils;

import java.util.List;

import static java.util.Arrays.asList;

/**
 * User: ruslan.semerenko
 * Date: 02.04.12 15:57
 */
public class User extends BaseObject {
    private CustomMetadata _cm;
    private String password;
    private String customEmail;
    private BaseObject[] roles;
    private List<String> _permissions;
    private boolean registered;
    private String email;
    private String fullName;
    private String lastName;
    private String firstName;
    private String key;
    private String secret;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }


    public User() {}

    public User(CustomMetadata cm) {
        super(cm);
        if (cm.containsKey("_cm")) {
            _cm = cm.getOrCreateNode("_cm");
        }
        setPassword(cm.getString("password"));
        setRoles(cm.getArrayForClass("roles", BaseObject.class));
    }

    public String getPassword() {

        return password;
    }

    public User setPassword(String password) {
        this.password = password;
        return this;
    }

    public BaseObject[] getRoles() {
        if (roles == null)
            roles = new BaseObject[0];
        return roles;
    }

    public void setRoles(BaseObject[] roles) {
        this.roles = roles;
    }

    public List<String> getPermissions() {
        return _permissions;
    }

    public void setPermissions(List<String> permissions) {
        this._permissions = permissions;
    }

    public boolean isRegistered() {
        return registered;
    }

    public void setRegistered(boolean registered) {
        this.registered = registered;
    }

    public String getUserEmail() {
        return email;
    }

    public String getUserFullName() {
        return fullName;
    }

    public String getUserLastName() {
        return lastName;
    }

    public String getUserFirstName() {
        return firstName;
    }

    public boolean isEasyUser() {
        return getSubtype().equals("easyuser");
    }

    /*
    * Custom metadata Common fields
    */

    public String getEmail() {
        String email = getCmCommon().getString("email");

        return email != null ? email : this.email;
    }

    public User setEmail(String email) {
        getCmCommon().put("email", email);
        return this;
    }

    public String getLanguage() {
        String[] language = getCmCommon().getStringArray("language");
        return language == null || language.length == 0 ? null : language[0];
    }

    public void setLanguage(String language) {
        getCmCommon().put("language", asList(language));
    }

    public String getFirstName() {
        return (String)getCmCommon().get("firstName");
    }

    public void setFirstName(String firstName) {
        getCmCommon().put("firstName", firstName);
    }

    public String getLastName() {
        return getCmCommon().getString("lastName");
    }

    public void setLastName(String lastName) {
        getCmCommon().put("lastName", lastName);
    }

    public String getFullName() {
        return getCmCommon().getString("fullName");
    }

    public void setFullName(String fullName) {
        getCmCommon().put("fullName", fullName);
    }

    public String getPhoneNumber() {
        return getCmCommon().getString("phoneNumber");
    }

    public void setPhoneNumber(String phoneNumber) {
        getCmCommon().put("phoneNumber", phoneNumber);
    }

    public String getMobileNumber() {
        return getCmCommon().getString("mobileNumber");
    }

    public void setMobileNumber(String mobileNumber) {
        getCmCommon().put("mobileNumber", mobileNumber);
    }

    public String getCmCommonFax() {
        return getCmCommon().getString("fax");
    }

    public void setCmCommonFax(String fax) {
        getCmCommon().put("fax", fax);
    }

    public String getSkypeNumber() {
        return getCmCommon().getString("skypeNumber");
    }

    public void setSkypeNumber(String skypeNumber) {
        getCmCommon().put("skypeNumber", skypeNumber);
    }

    public String getGoogleTalkContact() {
        return getCmCommon().getString("gTalkContact");
    }

    public void setGoogleTalkContact(String gTalkContact) {
        getCmCommon().put("gTalkContact", gTalkContact);
    }

    public String getAdvertiser() {
        return getCmCommon().getString("advertiser");
    }

    public void setAdvertiser(String advertiser) {
        getCmCommon().put("advertiser", advertiser);
    }

    public String getCompany() {
        return getCmCommon().getString("company");
    }

    public void setCompany(String company) {
        getCmCommon().put("company", company);
    }

    public String getJobTitle() {
        return getCmCommon().getString("jobTitle");
    }

    public void setJobTitle(String jobTitle) {
        getCmCommon().put("jobTitle", jobTitle);
    }

    public void setDisabled(Boolean disabled) {
        getCmCommon().put("disabled", disabled);
    }

    public Boolean getDisabled() {
        return getFalseIfNull(getCmCommon().getBoolean("disabled"));
    }

    public Boolean isDisabled() {
        return getDisabled();
    }

    public void setPasswordNeverExpires(Boolean passwordNeverExpires) {
        getCmCommon().put("passwordNeverExpires", passwordNeverExpires);
    }

    public Boolean isPasswordNeverExpires() {
        return getFalseIfNull(getCmCommon().getBoolean("passwordNeverExpires"));
    }

    public String getLogo() {
        return getCmLogo().getString("c");
    }

    public void setLogo(String logo) {
        getCmLogo().put("c", logo);
    }

    //Expected base64
    public void setLogo(byte [] logo) {
        getCmLogo().put("c", new String (logo));
    }

    public void removeLogo() {
        getCm().remove("logo");
    }

    /*
    * Custom metadata Views fields
    */

    public void setAccess(ApplicationAccess... access) {
        for (ApplicationAccess accessItem : ApplicationAccess.values()) {
            if(accessItem.name().equalsIgnoreCase("adcost"))
                if(!TestsContext.getInstance().isAdcost.toString().equalsIgnoreCase("true"))
                    continue;
            setAccess(accessItem, ArrayUtils.contains(access, accessItem));
        }
    }

    public void setFullAccess() {
        for (ApplicationAccess accessItem : ApplicationAccess.values()) {
            if(accessItem.name().equalsIgnoreCase("adcost"))
                if(!TestsContext.getInstance().isAdcost.toString().equalsIgnoreCase("true"))
                    continue;
            setAccess(accessItem, true);
        }
    }

    public boolean hasLibraryAccess() {
        return hasAccess(ApplicationAccess.LIBRARY);
    }

    public void setLibraryAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.LIBRARY, isEnabled);
    }

    public boolean hasDeliveryAccess() {
        return hasAccess(ApplicationAccess.DELIVERY);
    }

    public void setDeliveryAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.DELIVERY, isEnabled);
    }

    public boolean hasFoldersAccess() {
        return hasAccess(ApplicationAccess.FOLDERS);
    }

    public void setFoldersAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.FOLDERS, isEnabled);
    }

    public boolean hasTrafficAccess() {
        return hasAccess(ApplicationAccess.TRAFFIC);
    }

    public void setTrafficAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.TRAFFIC, isEnabled);
    }

    public boolean hasWorkRequestsAccess() {
        return hasAccess(ApplicationAccess.WORK_REQUESTS);
    }

    public void setWorkRequestsAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.WORK_REQUESTS, isEnabled);
    }

    public boolean hasApprovalsAccess() {
        return hasAccess(ApplicationAccess.APPROVALS);
    }

    public void setApprovalsAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.APPROVALS, isEnabled);
    }

    public boolean hasAnnotationsAccess() {
        return hasAccess(ApplicationAccess.ANNOTATIONS);
    }

    public void setAnnotationsAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.ANNOTATIONS, isEnabled);
    }

    public boolean hasPresentationsAccess() {
        return hasAccess(ApplicationAccess.PRESENTATIONS);
    }

    public void setPresentationsAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.PRESENTATIONS, isEnabled);
    }

    public boolean hasDashboardAccess() {
        return hasAccess(ApplicationAccess.DASHBOARD);
    }

    public void setDashboardAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.DASHBOARD, isEnabled);
    }
    public boolean hasStreamlinedlibraryAccess() {
        return hasAccess(ApplicationAccess.STREAMLINED_LIBRARY);
    }

    public void setStreamlinedlibraryAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.STREAMLINED_LIBRARY, isEnabled);
    }


    public boolean hasMediaManagerAccess() {
        return hasAccess(ApplicationAccess.MEDIAMANAGER);
    }

    public UserDateFormat getDateTimeFormatter() {
       // System.out.println(UserDateFormat.getForLanguage(getLanguage()));
        return UserDateFormat.getForLanguage(getLanguage());
    }

    /*
    * Custom metadata Ordering fields
    */

    public DeliveryAccessRule[] getDeliveryAccessRules() {
        return getCmOrdering().getArrayForClass("accessRules", DeliveryAccessRule.class);
    }

    public void setDeliveryAccessRules(DeliveryAccessRule[] deliveryAccessRules) {
        getCmOrdering().put("accessRules", deliveryAccessRules);
    }

    public Boolean isNotifyAboutConfirmation() {
        return getCmOrdering().getBoolean("notifyAboutConfirmation");
    }

    public void setNotifyAboutConfirmation(Boolean notifyAboutConfirmation) {
        getCmOrdering().put("notifyAboutConfirmation", notifyAboutConfirmation);
    }

    /*
    * Private helpers
    */

    private CustomMetadata getCm() {
        if (_cm == null) {
            _cm = new CustomMetadata();
        }
        return _cm;
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    private CustomMetadata getCmOrdering() {
        return getCm().getOrCreateNode("ordering");
    }

    private CustomMetadata getCmView() {
        return getCm().getOrCreateNode("view");
    }

    private CustomMetadata getCmViewAccess() {
        return getCmView().getOrCreateNode("access");
    }

    private boolean hasAccess(ApplicationAccess type) {
        return getFalseIfNull(getCmViewAccess().getBoolean(type.toString()));
    }

    private void setAccess(ApplicationAccess type, boolean value) {
        getCmViewAccess().put(type.toString(), value);
    }

    private CustomMetadata getCmLogo() {
        return getCm().getOrCreateNode("logo");
    }

    private boolean getFalseIfNull(Boolean bool) {
        return bool == null ? false : bool;
    }

    public String getCustomEmail() { return customEmail; }

    public void setCustomEmail(String customEmail) {
        this.customEmail = customEmail;
    }
}