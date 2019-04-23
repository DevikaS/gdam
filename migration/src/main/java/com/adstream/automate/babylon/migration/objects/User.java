package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/7/13
 * Time: 7:35 PM
 */
public class User {
    private String userGUID;
    private String password;
    private String agencyGUID;
    private String agencyName;
    private String firstName;
    private String lastName;
    private String position;
    private String email;
    private boolean useHTMLEmail;
    private boolean disabled;
    private boolean isDeptAdmin;
    private String mobilePhone;
    private String searchResultsPerPage;
    private String defaultVideoAdbankTypeID;
    private String defaultAudioAdbankTypeID;
    private String defaultPrintAdbankTypeID;
    private String preferredSearchResultID;
    private String defaultStreamingTypeID;
    private String userTypeID;
    private String orderViewLevelID;
    private String directPhone;
    private String loginGUID;
    private String searchDatePreference;
    private boolean showBillingInfo;
    private String fullName;
    private boolean defaultCaption;
    private boolean showDetailsThumbnailSearch;
    private boolean defaultHoldForApproval;
    private String userType;
    private boolean isEditable;

    @XmlElement(name = "UserGUID")
    public String getUserGUID() {
        return userGUID;
    }

    public void setUserGUID(String userGUID) {
        this.userGUID = userGUID;
    }

    @XmlElement(name = "Password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @XmlElement(name = "AgencyGUID")
    public String getAgencyGUID() {
        return agencyGUID;
    }

    public void setAgencyGUID(String agencyGUID) {
        this.agencyGUID = agencyGUID;
    }

    @XmlElement(name = "AgencyName")
    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    @XmlElement(name = "FirstName")
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @XmlElement(name = "LastName")
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @XmlElement(name = "Position")
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @XmlElement(name = "Email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @XmlElement(name = "UseHTMLEmail")
    public boolean isUseHTMLEmail() {
        return useHTMLEmail;
    }

    public void setUseHTMLEmail(boolean useHTMLEmail) {
        this.useHTMLEmail = useHTMLEmail;
    }

    @XmlElement(name = "Disabled")
    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    @XmlElement(name = "IsDeptAdmin")
    public boolean isDeptAdmin() {
        return isDeptAdmin;
    }

    public void setDeptAdmin(boolean deptAdmin) {
        isDeptAdmin = deptAdmin;
    }

    @XmlElement(name = "MobilePhone")
    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    @XmlElement(name = "SearchResultsPerPage")
    public String getSearchResultsPerPage() {
        return searchResultsPerPage;
    }

    public void setSearchResultsPerPage(String searchResultsPerPage) {
        this.searchResultsPerPage = searchResultsPerPage;
    }

    @XmlElement(name = "DefaultVideoAdbankTypeID")
    public String getDefaultVideoAdbankTypeID() {
        return defaultVideoAdbankTypeID;
    }

    public void setDefaultVideoAdbankTypeID(String defaultVideoAdbankTypeID) {
        this.defaultVideoAdbankTypeID = defaultVideoAdbankTypeID;
    }

    @XmlElement(name = "DefaultAudioAdbankTypeID")
    public String getDefaultAudioAdbankTypeID() {
        return defaultAudioAdbankTypeID;
    }

    public void setDefaultAudioAdbankTypeID(String defaultAudioAdbankTypeID) {
        this.defaultAudioAdbankTypeID = defaultAudioAdbankTypeID;
    }

    @XmlElement(name = "DefaultPrintAdbankTypeID")
    public String getDefaultPrintAdbankTypeID() {
        return defaultPrintAdbankTypeID;
    }

    public void setDefaultPrintAdbankTypeID(String defaultPrintAdbankTypeID) {
        this.defaultPrintAdbankTypeID = defaultPrintAdbankTypeID;
    }

    @XmlElement(name = "PreferredSearchResultID")
    public String getPreferredSearchResultID() {
        return preferredSearchResultID;
    }

    public void setPreferredSearchResultID(String preferredSearchResultID) {
        this.preferredSearchResultID = preferredSearchResultID;
    }

    @XmlElement(name = "DefaultStreamingTypeID")
    public String getDefaultStreamingTypeID() {
        return defaultStreamingTypeID;
    }

    public void setDefaultStreamingTypeID(String defaultStreamingTypeID) {
        this.defaultStreamingTypeID = defaultStreamingTypeID;
    }

    @XmlElement(name = "UserTypeID")
    public String getUserTypeID() {
        return userTypeID;
    }

    public void setUserTypeID(String userTypeID) {
        this.userTypeID = userTypeID;
    }

    @XmlElement(name = "OrderViewLevelID")
    public String getOrderViewLevelID() {
        return orderViewLevelID;
    }

    public void setOrderViewLevelID(String orderViewLevelID) {
        this.orderViewLevelID = orderViewLevelID;
    }

    @XmlElement(name = "DirectPhone")
    public String getDirectPhone() {
        return directPhone;
    }

    public void setDirectPhone(String directPhone) {
        this.directPhone = directPhone;
    }

    @XmlElement(name = "LoginGUID")
    public String getLoginGUID() {
        return loginGUID;
    }

    public void setLoginGUID(String loginGUID) {
        this.loginGUID = loginGUID;
    }

    @XmlElement(name = "SearchDatePreference")
    public String getSearchDatePreference() {
        return searchDatePreference;
    }

    public void setSearchDatePreference(String searchDatePreference) {
        this.searchDatePreference = searchDatePreference;
    }

    @XmlElement(name = "ShowBillingInfo")
    public boolean isShowBillingInfo() {
        return showBillingInfo;
    }

    public void setShowBillingInfo(boolean showBillingInfo) {
        this.showBillingInfo = showBillingInfo;
    }

    @XmlElement(name = "FullName")
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    @XmlElement(name = "DefaultCaption")
    public boolean isDefaultCaption() {
        return defaultCaption;
    }

    public void setDefaultCaption(boolean defaultCaption) {
        this.defaultCaption = defaultCaption;
    }

    @XmlElement(name = "ShowDetailsThumbnailSearch")
    public boolean isShowDetailsThumbnailSearch() {
        return showDetailsThumbnailSearch;
    }

    public void setShowDetailsThumbnailSearch(boolean showDetailsThumbnailSearch) {
        this.showDetailsThumbnailSearch = showDetailsThumbnailSearch;
    }

    @XmlElement(name = "DefaultHoldForApproval")
    public boolean isDefaultHoldForApproval() {
        return defaultHoldForApproval;
    }

    public void setDefaultHoldForApproval(boolean defaultHoldForApproval) {
        this.defaultHoldForApproval = defaultHoldForApproval;
    }

    @XmlElement(name = "UserType")
    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    @XmlElement(name = "IsEditable")
    public boolean isEditable() {
        return isEditable;
    }

    public void setEditable(boolean editable) {
        isEditable = editable;
    }
}
