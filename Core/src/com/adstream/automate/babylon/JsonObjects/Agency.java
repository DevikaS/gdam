package com.adstream.automate.babylon.JsonObjects;

import com.adstream.automate.babylon.TestsContext;
import org.apache.commons.lang.ArrayUtils;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static java.util.Arrays.asList;

/**
 * User: ruslan.semerenko
 * Date: 02.04.12 16:31
 */
public class Agency extends BaseObject {
    private static final String PASSWORD_PATTERN = "((?=(.*[A-Z]){%d,})(?=(.*\\d){%d,}).{%d,})";

    private String country;
    private String[] partners;
    private CustomMetadata _cm;
    private CustomMetadata _sharingSettings;
    private Long _a4version;
    private String houseNumberSuffix;

    public Agency() {}

    public Agency(CustomMetadata cm) {
        super(cm);
        setPartners(cm.getStringArray("partners"));
        if (cm.containsKey("_cm")) {
            _cm = cm.getOrCreateNode("_cm");
        }
    }

    public String[] getPartners() {
        return partners;
    }

    public void setPartners(String[] partners) {
        this.partners = partners;
    }

    /*
    * Custom metadata Common fields
    */

    //TODO should return array
    public String getTimeZone() {
        String[] timeZone = getCmCommon().getStringArray("time_zone");
        if (timeZone == null || timeZone.length == 0) {
            return null;
        }
        return timeZone[0];
    }

    public void setTimeZone(String timeZone) {
        getCmCommon().put("time_zone", asList(timeZone));
    }

    public String getPin() {
        return getCmCommon().getString("pin");
    }

    public void setPin(String pin) {
        getCmCommon().put("pin", pin);
    }

    //TODO should return array
    public String getCountry() {
        String[] country = getCmCommon().getOrCreateNode("address").getStringArray("country");
        if (country == null || country.length == 0) {
            return null;
        }
        return country[0];
    }

    public void setCountry(String country) {
        getCmCommon().getOrCreateNode("address").put("country", asList(country));
    }

    public String getAgencyCountry() {
        return country;
    }

    public String getDescription() {
        return getCmCommon().getString("description");
    }

    public void setDescription(String description) {
        getCmCommon().put("description", description);
    }

    @Override
    public String getName() {
        String agencyName = getCmCommon().getString("name");
        if (agencyName == null) {
            agencyName = super.getName();
        }
        return agencyName;
    }

    @Override
    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    public String getStorageId() {
        return getCmCommon().getString("storageId");
    }

    public void setStorageId(String storageId) {
        getCmCommon().put("storageId", storageId);
    }

    public String getContactsMail() {
        return getCmCommonContacts().getString("mail");
    }

    public void setContactsMail(String mail) {
        getCmCommonContacts().put("mail", mail);
    }

    public String getContactsHelp() {
        return getCmCommonContacts().getString("help");
    }

    public void setContactsHelp(String help) {
        getCmCommonContacts().put("help", help);
    }

    public String[] getAgencyType() {
        return getCmCommon().getStringArray("agencyType");
    }

    public void setAgencyType(String... agencyType) {
        getCmCommon().put("agencyType", agencyType);
    }

    public String[] getLabels() {
        return getCmCommon().getStringArray("labels");
    }

    public void setLabels(String[] labels) {
        getCmCommon().put("labels", labels);
    }

    public Boolean isNVergeAllowed() {
        return getCmCommon().getBoolean("nVergeAllowed");
    }

    public void setNVergeAllowed(Boolean nVergeAllowed) {
        getCmCommon().put("nVergeAllowed", nVergeAllowed);
    }

    public String[] getIngestLocationId() {
        return getCmCommonIngestLocation().getStringArray("id");
    }

    public void setIngestLocationId(String[] id) {
        getCmCommonIngestLocation().put("id", id);
    }

    public String getIngestLocationName() {
        return getCmCommonIngestLocation().getString("name");
    }

    public void setIngestLocationName(String name) {
        getCmCommonIngestLocation().put("name", name);
    }

    public String[] getMarket() {
        return getCmCommon().getStringArray("market");
    }

    public void setMarket(String[] marketId) {
        getCmCommon().put("market", marketId);
    }

    public Integer getDestinationId() {
        return getCmCommon().getInteger("destinationID");
    }

    public void setDestinationId(Integer destinationID) {
        getCmCommon().put("destinationID", destinationID);
    }

    public Boolean isSpecialCharsAllowed() {
        return getCmCommon().getBoolean("specialChars");
    }

    public void setSpecialCharsAllowed(Boolean specialChars) {
        getCmCommon().put("specialChars", specialChars);
    }

    public Integer getRemindersDays() {
        return getCmCommon().getInteger("reminderDays");
    }

    public void setRemindersDays(Integer reminderDays) {
        getCmCommon().put("reminderDays", reminderDays);
    }

    public Boolean isReminderOnDeadlineDate() {
        return getCmCommon().getBoolean("reminderOnDeadline");
    }

    public void setReminderOnDeadlineDate(Boolean reminderOnDeadline) {
        getCmCommon().put("reminderOnDeadline", reminderOnDeadline);
    }

    public Boolean isReminderForExpired() {
        return getCmCommon().getBoolean("reminderForExpired");
    }

    public void setReminderForExpired(Boolean reminderForExpired) {
        getCmCommon().put("reminderForExpired", reminderForExpired);
    }

    public Boolean isSaveInLibrary() {
        return getCmCommon().getBoolean("SaveInLibrary");
    }

    public void setSaveInLibrary(Boolean saveInLibrary) {
        getCmCommon().put("saveInLibrary", saveInLibrary);
    }

    public Boolean isAllowToSaveInLibrary() {
        return getCmCommon().getBoolean("allowUserChangeSaveInLibrary");
    }

    public void setAllowToSaveInLibrary(Boolean AllowToSaveInLibrary) {
        getCmCommon().put("allowUserChangeSaveInLibrary", AllowToSaveInLibrary);
    }

    public Boolean isDefaultManageConversion() {
        return getCmCommon().getBoolean("defaultMC");
    }

    public void setDefaultManageConversion(Boolean defaultMC) {
        getCmCommon().put("defaultMC", defaultMC);
    }

    public Boolean isAllowToChangeManageConversion() {
        return getCmCommon().getBoolean("allowChangeMC");
    }


    public void setAllowToChangeManageConversion(Boolean AllowToChangeMC) {
        getCmCommon().put("allowChangeMC", AllowToChangeMC);
    }

    public Boolean isNonUniqueHouseNumber() {
        return getCmCommon().getBoolean("nonUniqueHouseNumber");
    }

    public void setNonUniqueHouseNumber(Boolean nonUniqueHouseNumber) {
        getCmCommon().put("nonUniqueHouseNumber", nonUniqueHouseNumber);
    }



    /*
    * Custom metadata common Applications fields
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
    // Qa-358-Frame Grabber changes starts
    public void setFrameGrabbersAccess(boolean isEnabled) {
    setAccess(ApplicationAccess.FRAMEGRABBER, isEnabled);
}
    // Qa-358-Frame Grabber changes Ends
    public boolean hasDashboardAccess() {
        return hasAccess(ApplicationAccess.DASHBOARD);
    }

    public void setDashboardAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.DASHBOARD, isEnabled);
    }

    public void setAdcostAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.ADCOST, isEnabled);
    }

    public boolean hasStreamlinedlibraryAccess() {
        return hasAccess(ApplicationAccess.STREAMLINED_LIBRARY);
    }

    public void setStreamlinedlibraryAccess(boolean isEnabled) {
        setAccess(ApplicationAccess.STREAMLINED_LIBRARY, isEnabled);
    }


     /*
    * Custom metadata Login fields
    */

    public String getCmLoginTextColor() {
        return getCmLogin().getString("text-color");
    }

    public void setCmLoginTextColor(String textColor) {
        getCmLogin().put("text-color", textColor);
    }

    public String getCmLoginFooterTextColor() {
        return getCmLogin().getString("footer-text-color");
    }

    public void setCmLoginFooterTextColor(String footerTextColor) {
        getCmLogin().put("footer-text-color", footerTextColor);
    }

    public String getCmLoginButtonColor() {
        return getCmLogin().getString("button-color");
    }

    public void setCmLoginButtonColor(String buttonColor) {
        getCmLogin().put("button-color", buttonColor);
    }

    public String getCmLoginLinkColor() {
        return getCmLogin().getString("link-color");
    }

    public void setCmLoginLinkColor(String linkColor) {
        getCmLogin().put("link-color", linkColor);
    }

    public String getCmLoginFooterColor() {
        return getCmLogin().getString("footer-color");
    }

    public void setCmLoginFooterColor(String footerColor) {
        getCmLogin().put("footer-color", footerColor);
    }

    public String getCmLoginBackgroundColor() {
        return getCmLogin().getString("background-color");
    }

    public void setCmLoginBackgroundColor(String backgroundColor) {
        getCmLogin().put("background-color", backgroundColor);
    }

    public String getCmLoginBackgroundAlign() {
        return getCmLogin().getString("background-align");
    }

    public void setCmLoginBackgroundAlign(String backgroundAlign) {
        if (asList("full", "left").contains(backgroundAlign))
            getCmLogin().put("background-align", backgroundAlign);
    }

    public String getCmLoginFooterText() {
        return getCmLogin().getString("footer-text");
    }

    public void setCmLoginFooterText(String footerText) {
        getCmLogin().put("footer-text", footerText);
    }

    public String getCmLoginMessage() {
        return getCmLogin().getString("message");
    }

    public void setCmLoginMessage(String message) {
        getCmLogin().put("message", message);
    }

    public void setCmLoginLogo(String base64String, DateTime dateTime, String mimeType) {
        getCmLogin().getOrCreateNode("logo").put("c", base64String);
        getCmLogin().getOrCreateNode("logo").put("m", dateTime);
        getCmLogin().getOrCreateNode("logo").put("t", mimeType);
    }

    public void setCmLoginBackground(String base64String, DateTime dateTime, String mimeType) {
        getCmLogin().getOrCreateNode("background").put("c", base64String);
        getCmLogin().getOrCreateNode("background").put("m", dateTime);
        getCmLogin().getOrCreateNode("background").put("t", mimeType);
    }

    public Integer getPasswordExpirationInDays() {
        return getCmPasswordSettings().getInteger("passwordExpirationInDays");
    }

    public void setPasswordExpirationInDays(Integer passwordExpirationInDays) {
        getCmPasswordSettings().put("passwordExpirationInDays", passwordExpirationInDays);
    }

    public String getPasswordRegEx() {
        return getCmPasswordSettingsPasswordRegEx().getString("pattern");
    }

    public void setPasswordRegEx(String pattern) {
        getCmPasswordSettingsPasswordRegEx().put("pattern", pattern);
    }

    public Integer getPasswordMinIncludingUppercase() {
        return getCmPasswordSettingsPasswordRegExDescription().getInteger("minIncludingUppercase");
    }

    public void setPasswordMinIncludingUppercase(Integer minIncludingUppercase) {
        getCmPasswordSettingsPasswordRegExDescription().put("minIncludingUppercase", minIncludingUppercase);
        setPasswordRegEx(String.format(PASSWORD_PATTERN,
                minIncludingUppercase, getPasswordMinimumIncludingNumbers(), getPasswordMinTotalLengthOfPassword()));
    }

    public Integer getPasswordMinTotalLengthOfPassword() {
        return getCmPasswordSettingsPasswordRegExDescription().getInteger("minTotalLengthOfPassword");
    }

    public void setPasswordMinTotalLengthOfPassword(Integer minTotalLengthOfPassword) {
        getCmPasswordSettingsPasswordRegExDescription().put("minTotalLengthOfPassword", minTotalLengthOfPassword);
        setPasswordRegEx(String.format(PASSWORD_PATTERN,
                getPasswordMinIncludingUppercase(), getPasswordMinimumIncludingNumbers(), minTotalLengthOfPassword));
    }

    public Integer getPasswordMinimumIncludingNumbers() {
        return getCmPasswordSettingsPasswordRegExDescription().getInteger("minimumIncludingNumbers");
    }

    public void setPasswordMinimumIncludingNumbers(Integer minimumIncludingNumbers) {
        getCmPasswordSettingsPasswordRegExDescription().put("minimumIncludingNumbers", minimumIncludingNumbers);
        setPasswordRegEx(String.format(PASSWORD_PATTERN,
                getPasswordMinIncludingUppercase(), minimumIncludingNumbers, getPasswordMinTotalLengthOfPassword()));
    }

    public Agency fixPasswordStrengthFieldsType() {
        getPasswordExpirationInDays();
        getPasswordRegEx();
        getPasswordMinIncludingUppercase();
        getPasswordMinTotalLengthOfPassword();
        getPasswordMinimumIncludingNumbers();
        return this;
    }

    /*
    * Custom metadata View fields
    */

    public String[] getCmViewBrandingSB() {
        return getCmView().getStringArray("brandingSB");
    }

    public void setCmViewBrandingSB(String... brandingSB) {
        getCmView().put("brandingSB", brandingSB);
    }

    public String getBrandingColor() {
        String[] brandingSB = getCmViewBrandingSB();
        if (brandingSB != null && brandingSB.length > 0) {
            return brandingSB[0];
        }
        return null;
    }

    public void setBrandingColor(String color) {
        String[] brandingSB = getCmViewBrandingSB();
        if (color == null) {
            color = "";
        }
        if (brandingSB == null) {
            brandingSB = new String[2];
        }
        brandingSB[0] = color;
        setCmViewBrandingSB(brandingSB);
    }

    public String getBrandingLogo() {
        String[] brandingSB = getCmViewBrandingSB();
        if (brandingSB != null && brandingSB.length > 1) {
            return brandingSB[1];
        }
        return null;
    }

    public void setBrandingLogo(String logo) {
        String[] brandingSB = getCmViewBrandingSB();
        if (logo == null) {
            logo = "";
        }
        if (brandingSB == null) {
            brandingSB = new String[2];
        }
        brandingSB[1] = logo;

        setCmViewBrandingSB(brandingSB);
    }

    /*
    * Custom metadata A4 fields
    */

    public String getCmA4Id() {
        return getCmA4().getString("id");
    }

    public void setCmA4Id(String id) {
        getCmA4().put("id", id);
    }

    public Boolean getCreateAssetInA4() {
        return getCmA4().getBoolean("createAssetInA4");
    }

    public void setCreateAssetInA4(Boolean createAssetInA4) {
        getCmA4().put("createAssetInA4", createAssetInA4);
    }

    public String getA4User() {
        return getCmA4().getString("user");
    }

    public void setA4User(String user) {
        getCmA4().put("user", user);
    }

    public String getA4AdvertiserField() {
        return getCmA4().getString("advertiser_field");
    }

    // advertiser_field: _cm.common.advertiser,_cm.common.brand,_cm.common.sub_brand,_cm.common.product
    public void setA4AdvertiserField(String advertiser_field) {
        getCmA4().put("advertiser_field", advertiser_field);
    }

    public String getA4ProductField() {
        return getCmA4().getString("product_field");
    }

    // product_field: _cm.common.advertiser,_cm.common.brand,_cm.common.sub_brand,_cm.common.product
    public void setA4ProductField(String product_field) {
        getCmA4().put("product_field", product_field);
    }

    public String getA4CampaignField() {
        return getCmA4().getString("campaign_field");
    }

    public void setA4CampaignField(String campaign_field) {
        getCmA4().put("campaign_field", campaign_field);
    }

     public String getA4SectorField() {
            return getCmA4().getString("sector_field");
     }

    public void setA4SectorField(String sector_field){
        getCmA4().put("sector_field", sector_field);
    }

    public String getA4BrandField() {
        return getCmA4().getString("brand_field");
    }

    public void setA4BrandField(String brand_field) {
        getCmA4().put("brand_field", brand_field);
    }

    public String getA4Password() {
        return getCmA4().getString("password");
    }

    public void setA4Password(String password) {
        getCmA4().put("password", password);
    }

    public String getA4AgencyId() {
        return getCmA4().getString("agencyId");
    }

    public void setA4AgencyId(String agencyId) {
        getCmA4().put("agencyId", agencyId);
    }

     /*
    * Custom metadata Finance fields
    */

    public String getSapCountry() {
        return getCmFinanceSap().getString("sapCountry");
    }

    public void setSapCountry(String sapCountry) {
        getCmFinanceSap().put("country", sapCountry);
    }

    public String getSapId() {
        return getCmFinanceSap().getString("id");
    }

    public void setSapId(String id) {
        getCmFinanceSap().put("id", id);
    }

    public void enableSAP(Boolean status) {
        getCmFinanceSap().put("enabled", status);
    }
    /*
    * Custom metadata Print fields
    */

    public String getCmPrintClientCode() {
        return getCmPrint().getString("clientCode");
    }

    public void setCmPrintClientCode(String clientCode) {
        getCmPrint().put("clientCode", clientCode);
    }

    /*
     * Custom metadata Project fields
     */

    public boolean getCmProjectFiltersEnabled() {
        return getFalseIfNull(getCmProject().getBoolean("filtersEnabled"));
    }

    public void setCmProjectFiltersEnabled(boolean enabled) {
        getCmProject().put("filtersEnabled", enabled);
    }

    public String[] getCmProjectFilterFields() {
        return getCmProject().getStringArray("filterFields");
    }

    public void setCmProjectFilterFields(String[] fields) {
        getCmProject().put("filterFields", fields);
    }

    /*
    * Sharing settings fields
    */

    public Boolean getSharingSettingsEnrichDictionary() {
        return getSharingSettings().getBoolean("enrichDictionary");
    }

    public void setSharingSettingsEnrichDictionary(Boolean enrichDictionary) {
        getSharingSettings().put("enrichDictionary", enrichDictionary);
    }

    /*
    * Custom metadata helpers
    */

    public CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    public CustomMetadata getCmCommonContacts() {
        return getCmCommon().getOrCreateNode("contacts");
    }

    private CustomMetadata getCmCommonIngestLocation() {
        return getCmCommon().getOrCreateNode("ingestLocation");
    }

    private CustomMetadata getCmCommonApplications() {
        return getCmCommon().getOrCreateNode("applications");
    }

    private boolean hasAccess(ApplicationAccess type) {
        return getFalseIfNull(getCmCommonApplications().getBoolean(type.toString()));
    }

    private void setAccess(ApplicationAccess type, boolean value) {
        getCmCommonApplications().put(type.toString(), value);
    }

    public CustomMetadata getCmLogin() {
        return getCm().getOrCreateNode("login");
    }

    private CustomMetadata getCmTraffic(){return getCm().getOrCreateNode("traffic");}

    public CustomMetadata getCmTrafficApprovers(){return getCmTraffic().getOrCreateNode("approvers");}

    private CustomMetadata getCmTrafficApproversLowres(){return getCmTrafficApprovers().getOrCreateNode("lowres");}

    private CustomMetadata getCmTrafficApproversMaster(){return getCmTrafficApprovers().getOrCreateNode("master");}

//    public void setCmTrafficApproverLowresUser(String value){
//        getCmTrafficApprovers().put("lowres",asList(value));
//    }

//    public void setCmTrafficApproverMasterUser(String value){
//        getCmTrafficApprovers().put("master",asList(value));
//    }
    public void setCmTrafficApproverLowresUser(List value){
        if(getCmTrafficApprovers().size() > 0) {
            if (getCmTrafficApprovers().get("lowres") != null) {
                List<List<String>> data = (java.util.List<java.util.List<String>>) (getCmTrafficApprovers().get("lowres"));
                List<String> k = new ArrayList<String>();
                Iterator itr = data.iterator();
                Boolean found=false;
                Iterator itr1 = value.iterator();
                if(!data.isEmpty()) {
                    for(Object newValue : value) {
                         while (itr.hasNext()) {
                            String mm = String.valueOf(itr.next());
                            if(!k.contains(mm))
                                 k.add(mm);
                            if (mm.equalsIgnoreCase(String.valueOf(newValue))) {
                                found = true;
                                break;
                            }

                        }
                        if(!found)
                            k.add(String.valueOf(newValue));
                        found=false;
                        itr = data.iterator();
                    }
                }
                else
                    k=value;
                getCmTrafficApprovers().put("lowres", k);
            }
            else
                getCmTrafficApprovers().put("lowres",value);
        }
        else
            getCmTrafficApprovers().put("lowres",value);
    }


    public void setCmTrafficApproverMasterUsernew(List value){
        List<String> approversToadd = new ArrayList<String>();
        for(int i=0; i<value.size();i++)
               {
                 Object temp = value.get(i);
                   approversToadd.add(String.valueOf(temp));
                   }
        getCmTrafficApprovers().put("master", approversToadd);

    }

    public void setCmTrafficApproverLowresUsernew(List value){
        List<String> approversToadd = new ArrayList<String>();
        for(int i=0; i<value.size();i++)
        {
            Object temp = value.get(i);
            approversToadd.add(String.valueOf(temp));
        }
        getCmTrafficApprovers().put("lowres", approversToadd);

    }

    public void setCmTrafficApproverMasterUser(List value){
        if(getCmTrafficApprovers().size() > 0) {
            if (getCmTrafficApprovers().get("master") != null) {
                List<List<String>> data = (java.util.List<java.util.List<String>>) (getCmTrafficApprovers().get("master"));
                List<String> k = new ArrayList<String>();
                Boolean found=false;
                if(!data.isEmpty()) {
                    for(Object newValue : value)
                    {
                        Iterator itr = data.iterator();
                         while (itr.hasNext())
                         {
                            String mm = String.valueOf(itr.next());
                            if(!k.contains(mm))
                                 k.add(mm);
                            if (mm.equalsIgnoreCase(String.valueOf(newValue))) {
                                found = true;
                                break;
                            }

                        }
                        if(!found)
                            k.add(String.valueOf(newValue));
                        found=false;
                    }
                }
                else
                    k=value;
                getCmTrafficApprovers().put("master", k);
            }
            else
                getCmTrafficApprovers().put("master",value);
        }
        else
            getCmTrafficApprovers().put("master",value);
    }

    public Boolean getCmTrafficEscalation(){
       return getCmTraffic().getBoolean("escalationEnabled");
    }

    public void setCmTrafficEscalation(boolean value){
       getCmTraffic().put("escalationEnabled", value);
    }

    public void getCmTrafficApprovalType (String value){
        getCmTraffic().put("approvalType", value);
    }

    public void setCmTrafficApprovalType (String value){
        getCmTraffic().put("approvalType", value);
    }

    private CustomMetadata getCmPasswordSettings() {
        return getCm().getOrCreateNode("passwordSettings");
    }

    private CustomMetadata getCmPasswordSettingsPasswordRegEx() {
        return getCmPasswordSettings().getOrCreateNode("passwordRegEx");
    }

    private CustomMetadata getCmPasswordSettingsPasswordRegExDescription() {
        return getCmPasswordSettingsPasswordRegEx().getOrCreateNode("description");
    }

    private CustomMetadata getCmA4() {
        return getCm().getOrCreateNode("a4");
    }

    private CustomMetadata getCmView() {
        return getCm().getOrCreateNode("view");
    }

    private CustomMetadata getCmFinance() {
        return getCm().getOrCreateNode("finance");
    }

    private CustomMetadata getCmFinanceSap() {
        return getCmFinance().getOrCreateNode("sap");
    }

    private CustomMetadata getCmPrint() {
        return getCm().getOrCreateNode("print");
    }

    private CustomMetadata getCmProject() {
        return getCm().getOrCreateNode("project");
    }

    private boolean getFalseIfNull(Boolean bool) {
        return bool == null ? false : bool;
    }

    /*
    * Sharing settings helpers
    */

    private CustomMetadata getSharingSettings() {
        if (_sharingSettings == null) _sharingSettings = new CustomMetadata();
        return _sharingSettings;
    }

    /*
    * Migration A4 -> A5
    */

    public Long get_a4version() {
        return _a4version;
    }

    public void set_a4version(Long _a4version) {
        this._a4version = _a4version;
    }

    public void setHouseNumberSuffix(String hnSuffix) {
        getCmCommon().put("houseNumberSuffix", hnSuffix);
    }
    public String getHouseNumber() {
        return houseNumberSuffix;
    }

    public String[] getHubMembers() {
        return getCmTraffic().getStringArray("hubmembers");
    }

    public void setHubMembers(String... agencyType) {
        getCmTraffic().put("hubmembers", agencyType);
    }

    public String getGroupingType(){
        return getCmTraffic().getString("groupingType");
    }

    public void setGroupingType(String value){
        getCmTraffic().put("groupingType", value);
    }

}