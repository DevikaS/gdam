package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.lang.String;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/7/13
 * Time: 7:35 PM

 */
@XmlType(propOrder = {
        "agencyGUID",
        "agencyName",
        "addressGUID",
        "phone",
        "fax",
        "primaryUserGUID",
        "pin",
        "creditLimit",
        "currentBalance",
        "preferredReportingFormat",
        "disabled",
        "abn",
        "acn",
        "myOBCustomerNumber",
        "lastFlatRateBillingDate",
        "lastDiscountDate",
        "organisationTypeID",
        "destinationID",
        "pricingBand",
        "discountType",
        "billedFrom",
        "statementFrequency",
        "statementFrequencyDetail",
        "billingFrequency",
        "billingFrequencyDetail",
        "billingStatementText",
        "includedAdbankMonths",
        "includedAdbankDeactivate",
        "lastStatementNumber",
        "lastStatementTotal",
        "statementStartDate",
        "statementEndDate",
        "creditUsageAlert",
        "receivedLocationID",
        "netPricing",
        "preventAssetArchive",
        "crazyBilling",
        "copyAccounts",
        "allowBasicOrderEntry",
        "taxFree",
        "roleID",
        "accountsRecipients",
        "logoFileName",
        "logoWidth",
        "logoHeight",
        "resellerAgencyGUID",
        "userGroupGUID",
        "isTrusted",
        "paperworkHub",
        "countryCode",
        "fileStorageID",
        "validated",
        "sapModificationDate",
        "receivedLocation",
        "agencyReseller",
        "imageBank",
        "imageBankURL",
        "receivedLocationID1",
        "adapt",
        "adCode",
        "adCode_x0020_Clock_x0020_ReadOnly",
        "adId",
        "adstreamOfficeID",
        "allow_x0020_proxy_x0020_download",
        "defaultAdbankGroup",
        "download_x0020_via_x0020_Web",
        "first_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report",
        "isOrderCompleteNotify",
        "languageCode",
        "new_x0020_discussion",
        "onlineEnableBilling",
        "pubId",
        "sapInstanceID",
        "send_x0020_via_x0020_Admail",
        "share",
        "show_x0020_Creative_x0020_Playground",
        "upload",
        "revisionA4"

})
public class Agency {
    private String agencyGUID;
    private String agencyName;
    private String addressGUID;
    private String primaryUserGUID;
    private String pin;
    private String creditLimit;
    private String currentBalance;
    private boolean disabled;
    private String organisationTypeID;
    private String pricingBand;
    private String discountType;
    private String statementFrequency;
    private boolean includedAdbankDeactivate;
    private String creditUsageAlert;
    private String receivedLocationID;
    private boolean netPricing;
    private boolean preventAssetArchive;
    private boolean crazyBilling;
    private boolean copyAccounts;
    private boolean allowBasicOrderEntry;
    private boolean taxFree;
    private String accountsRecipients;
    private boolean isTrusted;
    private String countryCode;
    private String fileStorageID;
    private boolean validated;
    private String sapModificationDate;
    private String receivedLocation;
    private boolean imageBank;
    private String imageBankURL ;
    private String receivedLocationID1;
    private boolean adapt;
    private boolean adCode;
    private boolean adCode_x0020_Clock_x0020_ReadOnly;
    private boolean adId;
    private String adstreamOfficeID;
    private boolean allow_x0020_proxy_x0020_download;
    private String defaultAdbankGroup;
    private boolean download_x0020_via_x0020_Web;
    private boolean first_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report;
    private String languageCode;
    private boolean new_x0020_discussion;
    private boolean pubId;
    private String sapInstanceID;
    private boolean send_x0020_via_x0020_Admail;
    private boolean share;
    private boolean show_x0020_Creative_x0020_Playground;
    private boolean upload;
    private long revisionA4;
    private String phone;
    private String fax;
    private String preferredReportingFormat;
    private String abn;
    private String acn;
    private String myOBCustomerNumber;
    private String lastFlatRateBillingDate;
    private String lastDiscountDate;
    private String destinationID;
    private String billedFrom;
    private String statementFrequencyDetail;
    private String billingFrequency;
    private String billingFrequencyDetail;
    private String billingStatementText;
    private String includedAdbankMonths;
    private String lastStatementNumber;
    private String lastStatementTotal;
    private String statementStartDate;
    private String statementEndDate;
    private String roleID;
    private String logoFileName;
    private String logoWidth;
    private String logoHeight;
    private String resellerAgencyGUID;
    private String paperworkHub;
    private String userGroupGUID;
    private String agencyReseller;
    private String isOrderCompleteNotify;
    private String onlineEnableBilling;



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

    @XmlElement(name = "AddressGUID")
    public String getAddressGUID() {
        return addressGUID;
    }

    public void setAddressGUID(String addressGUID) {
        this.addressGUID = addressGUID;
    }

    @XmlElement(name = "PrimaryUserGUID")
    public String getPrimaryUserGUID() {
        return primaryUserGUID;
    }

    public void setPrimaryUserGUID(String primaryUserGUID) {
        this.primaryUserGUID = primaryUserGUID;
    }

    @XmlElement(name = "PIN")
    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    @XmlElement(name = "CreditLimit")
    public String getCreditLimit() {
        return creditLimit;
    }

    public void setCreditLimit(String creditLimit) {
        this.creditLimit = creditLimit;
    }

    @XmlElement(name = "CurrentBalance")
    public String getCurrentBalance() {
        return currentBalance;
    }

    public void setCurrentBalance(String currentBalance) {
        this.currentBalance = currentBalance;
    }

    @XmlElement(name = "Disabled")
    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    @XmlElement(name = "OrganisationTypeID")
    public String getOrganisationTypeID() {
        return organisationTypeID;
    }

    public void setOrganisationTypeID(String organisationTypeID) {
        this.organisationTypeID = organisationTypeID;
    }

    @XmlElement(name = "PricingBand")
    public String getPricingBand() {
        return pricingBand;
    }

    public void setPricingBand(String pricingBand) {
        this.pricingBand = pricingBand;
    }

    @XmlElement(name = "DiscountType")
    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    @XmlElement(name = "StatementFrequency")
    public String getStatementFrequency() {
        return statementFrequency;
    }

    public void setStatementFrequency(String statementFrequency) {
        this.statementFrequency = statementFrequency;
    }

    @XmlElement(name = "IncludedAdbankDeactivate")
    public boolean isIncludedAdbankDeactivate() {
        return includedAdbankDeactivate;
    }

    public void setIncludedAdbankDeactivate(boolean includedAdbankDeactivate) {
        this.includedAdbankDeactivate = includedAdbankDeactivate;
    }

    @XmlElement(name = "CreditUsageAlert")
    public String getCreditUsageAlert() {
        return creditUsageAlert;
    }

    public void setCreditUsageAlert(String creditUsageAlert) {
        this.creditUsageAlert = creditUsageAlert;
    }

    @XmlElement(name = "ReceivedLocationID")
    public String getReceivedLocationID() {
        return receivedLocationID;
    }

    public void setReceivedLocationID(String receivedLocationID) {
        this.receivedLocationID = receivedLocationID;
    }

    @XmlElement(name = "NetPricing")
    public boolean getNetPricing() {
        return netPricing;
    }

    public void setNetPricing(boolean netPricing) {
        this.netPricing = netPricing;
    }

    @XmlElement(name = "PreventAssetArchive")
    public boolean getPreventAssetArchive() {
        return preventAssetArchive;
    }

    public void setPreventAssetArchive(boolean preventAssetArchive) {
        this.preventAssetArchive = preventAssetArchive;
    }

    @XmlElement(name = "CrazyBilling")
    public boolean getCrazyBilling() {
        return crazyBilling;
    }

    public void setCrazyBilling(boolean crazyBilling) {
        this.crazyBilling = crazyBilling;
    }

    @XmlElement(name = "CopyAccounts")
    public boolean getCopyAccounts() {
        return copyAccounts;
    }

    public void setCopyAccounts(boolean copyAccounts) {
        this.copyAccounts = copyAccounts;
    }

    @XmlElement(name = "AllowBasicOrderEntry")
    public boolean getAllowBasicOrderEntry() {
        return allowBasicOrderEntry;
    }

    public void setAllowBasicOrderEntry(boolean allowBasicOrderEntry) {
        this.allowBasicOrderEntry = allowBasicOrderEntry;
    }

    @XmlElement(name = "TaxFree")
    public boolean getTaxFree() {
        return taxFree;
    }

    public void setTaxFree(boolean taxFree) {
        this.taxFree = taxFree;
    }

    @XmlElement(name = "AccountsRecipients")
    public String getAccountsRecipients() {
        return accountsRecipients;
    }

    public void setAccountsRecipients(String accountsRecipients) {
        this.accountsRecipients = accountsRecipients;
    }

    @XmlElement(name = "IsTrusted")
    public boolean getIsTrusted() {
        return isTrusted;
    }

    public void setIsTrusted(boolean trusted) {
        isTrusted = trusted;
    }

    @XmlElement(name = "CountryCode")
    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    @XmlElement(name = "FileStorageID")
    public String getFileStorageID() {
        return fileStorageID;
    }

    public void setFileStorageID(String fileStorageID) {
        this.fileStorageID = fileStorageID;
    }

    @XmlElement(name = "Validated")
    public boolean getValidated() {
        return validated;
    }

    public void setValidated(boolean validated) {
        this.validated = validated;
    }

    @XmlElement(name = "SAPModificationDate")
    public String getSapModificationDate() {
        return sapModificationDate;
    }

    public void setSapModificationDate(String sapModificationDate) {
        this.sapModificationDate = sapModificationDate;
    }

    @XmlElement(name = "ReceivedLocation")
    public String getReceivedLocation() {
        return receivedLocation;
    }

    public void setReceivedLocation(String receivedLocation) {
        this.receivedLocation = receivedLocation;
    }

    @XmlElement(name = "ImageBank")
    public boolean getImageBank() {
        return imageBank;
    }

    public void setImageBank(boolean imageBank) {
        this.imageBank = imageBank;
    }

    @XmlElement(name = "ImageBankURL")
    public String getImageBankURL() {
        return imageBankURL;
    }

    public void setImageBankURL(String imageBankURL) {
        this.imageBankURL = imageBankURL;
    }

    @XmlElement(name = "ReceivedLocationID1")
    public String getReceivedLocationID1() {
        return receivedLocationID1;
    }

    public void setReceivedLocationID1(String receivedLocationID1) {
        this.receivedLocationID1 = receivedLocationID1;
    }

    @XmlElement(name = "Adapt")
    public boolean getAdapt() {
        return adapt;
    }

    public void setAdapt(boolean adapt) {
        this.adapt = adapt;
    }

    @XmlElement(name = "AdCode")
    public boolean getAdCode() {
        return adCode;
    }

    public void setAdCode(boolean adCode) {
        this.adCode = adCode;
    }

    @XmlElement(name = "AdCode_x0020_Clock_x0020_ReadOnly")
    public boolean getAdCode_x0020_Clock_x0020_ReadOnly() {
        return adCode_x0020_Clock_x0020_ReadOnly;
    }

    public void setAdCode_x0020_Clock_x0020_ReadOnly(boolean adCode_x0020_Clock_x0020_ReadOnly) {
        this.adCode_x0020_Clock_x0020_ReadOnly = adCode_x0020_Clock_x0020_ReadOnly;
    }

    @XmlElement(name = "AdId")
    public boolean getAdId() {
        return adId;
    }

    public void setAdId(boolean adId) {
        this.adId = adId;
    }

    @XmlElement(name = "AdstreamOfficeID")
    public String getAdstreamOfficeID() {
        return adstreamOfficeID;
    }

    public void setAdstreamOfficeID(String adstreamOfficeID) {
        this.adstreamOfficeID = adstreamOfficeID;
    }

    @XmlElement(name = "Allow_x0020_proxy_x0020_download")
    public boolean getAllow_x0020_proxy_x0020_download() {
        return allow_x0020_proxy_x0020_download;
    }

    public void setAllow_x0020_proxy_x0020_download(boolean allow_x0020_proxy_x0020_download) {
        this.allow_x0020_proxy_x0020_download = allow_x0020_proxy_x0020_download;
    }

    @XmlElement(name = "DefaultAdbankGroup")
    public String getDefaultAdbankGroup() {
        return defaultAdbankGroup;
    }

    public void setDefaultAdbankGroup(String defaultAdbankGroup) {
        this.defaultAdbankGroup = defaultAdbankGroup;
    }

    @XmlElement(name = "Download_x0020_via_x0020_Web")
    public boolean getDownload_x0020_via_x0020_Web() {
        return download_x0020_via_x0020_Web;
    }

    public void setDownload_x0020_via_x0020_Web(boolean download_x0020_via_x0020_Web) {
        this.download_x0020_via_x0020_Web = download_x0020_via_x0020_Web;
    }

    @XmlElement(name = "First_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report")
    public boolean getFirst_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report() {
        return first_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report;
    }

    public void setFirst_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report(boolean first_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report) {
        this.first_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report = first_x0020_air_x0020_date_x0020_in_x0020_Delivery_x0020_report;
    }

    @XmlElement(name = "LanguageCode")
    public String getLanguageCode() {
        return languageCode;
    }

    public void setLanguageCode(String languageCode) {
        this.languageCode = languageCode;
    }

    @XmlElement(name = "New_x0020_discussion")
    public boolean getNew_x0020_discussion() {
        return new_x0020_discussion;
    }

    public void setNew_x0020_discussion(boolean new_x0020_discussion) {
        this.new_x0020_discussion = new_x0020_discussion;
    }

    @XmlElement(name = "PubId")
    public boolean getPubId() {
        return pubId;
    }

    public void setPubId(boolean pubId) {
        this.pubId = pubId;
    }

    @XmlElement(name = "SAP.InstanceID")
    public String getSapInstanceID() {
        return sapInstanceID;
    }

    public void setSapInstanceID(String sapInstanceID) {
        this.sapInstanceID = sapInstanceID;
    }

    @XmlElement(name = "Send_x0020_via_x0020_Admail")
    public boolean getSend_x0020_via_x0020_Admail() {
        return send_x0020_via_x0020_Admail;
    }

    public void setSend_x0020_via_x0020_Admail(boolean send_x0020_via_x0020_Admail) {
        this.send_x0020_via_x0020_Admail = send_x0020_via_x0020_Admail;
    }

    @XmlElement(name = "Share")
    public boolean getShare() {
        return share;
    }

    public void setShare(boolean share) {
        this.share = share;
    }

    @XmlElement(name = "Show_x0020_Creative_x0020_Playground")
    public boolean getShow_x0020_Creative_x0020_Playground() {
        return show_x0020_Creative_x0020_Playground;
    }

    public void setShow_x0020_Creative_x0020_Playground(boolean show_x0020_Creative_x0020_Playground) {
        this.show_x0020_Creative_x0020_Playground = show_x0020_Creative_x0020_Playground;
    }

    @XmlElement(name = "Upload")
    public boolean getUpload() {
        return upload;
    }

    public void setUpload(boolean upload) {
        this.upload = upload;
    }

    @XmlElement(name = "RevisionA4")
    public long getRevisionA4() {
        return revisionA4;
    }

    public void setRevisionA4(long revisionA4) {
        this.revisionA4 = revisionA4;
    }

    @XmlElement(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @XmlElement(name = "fax")
    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    @XmlElement(name = "StatementFrequencyDetail")
    public String getStatementFrequencyDetail() {
        return statementFrequencyDetail;
    }

    public void setStatementFrequencyDetail(String statementFrequencyDetail) {
        this.statementFrequencyDetail = statementFrequencyDetail;
    }

    @XmlElement(name = "BilledFrom")
    public String getBilledFrom() {
        return billedFrom;
    }

    public void setBilledFrom(String billedFrom) {
        this.billedFrom = billedFrom;
    }

    @XmlElement(name = "DestinationID")
    public String getDestinationID() {
        return destinationID;
    }

    public void setDestinationID(String destinationID) {
        this.destinationID = destinationID;
    }

    @XmlElement(name = "LastDiscountDate")
    public String getLastDiscountDate() {
        return lastDiscountDate;
    }

    public void setLastDiscountDate(String lastDiscountDate) {
        this.lastDiscountDate = lastDiscountDate;
    }

    @XmlElement(name = "LastFlatRateBillingDate")
    public String getLastFlatRateBillingDate() {
        return lastFlatRateBillingDate;
    }

    public void setLastFlatRateBillingDate(String lastFlatRateBillingDate) {
        this.lastFlatRateBillingDate = lastFlatRateBillingDate;
    }

    @XmlElement(name = "MYOBCustomerNumber")
    public String getMyOBCustomerNumber() {
        return myOBCustomerNumber;
    }

    public void setMyOBCustomerNumber(String myOBCustomerNumber) {
        this.myOBCustomerNumber = myOBCustomerNumber;
    }

    @XmlElement(name = "ACN")
    public String getAcn() {
        return acn;
    }

    public void setAcn(String acn) {
        this.acn = acn;
    }

    @XmlElement(name = "ABN")
    public String getAbn() {
        return abn;
    }

    public void setAbn(String abn) {
        this.abn = abn;
    }

    @XmlElement(name = "PreferredReportingFormat")
    public String getPreferredReportingFormat() {
        return preferredReportingFormat;
    }

    public void setPreferredReportingFormat(String preferredReportingFormat) {
        this.preferredReportingFormat = preferredReportingFormat;
    }

    @XmlElement(name = "BillingStatementText")
    public String getBillingStatementText() {
        return billingStatementText;
    }

    public void setBillingStatementText(String billingStatementText) {
        this.billingStatementText = billingStatementText;
    }

    @XmlElement(name = "BillingFrequency")
    public String getBillingFrequency() {
        return billingFrequency;
    }

    public void setBillingFrequency(String billingFrequency) {
        this.billingFrequency = billingFrequency;
    }

    @XmlElement(name = "BillingFrequencyDetail")
    public String getBillingFrequencyDetail() {
        return billingFrequencyDetail;
    }

    public void setBillingFrequencyDetail(String billingFrequencyDetail) {
        this.billingFrequencyDetail = billingFrequencyDetail;
    }

    @XmlElement(name = "StatementEndDate")
    public String getStatementEndDate() {
        return statementEndDate;
    }

    public void setStatementEndDate(String statementEndDate) {
        this.statementEndDate = statementEndDate;
    }

    @XmlElement(name = "LastStatementNumber")
    public String getLastStatementNumber() {
        return lastStatementNumber;
    }

    public void setLastStatementNumber(String lastStatementNumber) {
        this.lastStatementNumber = lastStatementNumber;
    }

    @XmlElement(name = "LastStatementTotal")
    public String getLastStatementTotal() {
        return lastStatementTotal;
    }

    public void setLastStatementTotal(String lastStatementTotal) {
        this.lastStatementTotal = lastStatementTotal;
    }

    @XmlElement(name = "StatementStartDate")
    public String getStatementStartDate() {
        return statementStartDate;
    }

    public void setStatementStartDate(String statementStartDate) {
        this.statementStartDate = statementStartDate;
    }

    @XmlElement(name = "isOrderCompleteNotify")
    public String getIsOrderCompleteNotify() {
        return isOrderCompleteNotify;
    }

    public void setIsOrderCompleteNotify(String orderCompleteNotify) {
        isOrderCompleteNotify = orderCompleteNotify;
    }

    @XmlElement(name = "AgencyReseller")
    public String getAgencyReseller() {
        return agencyReseller;
    }

    public void setAgencyReseller(String agencyReseller) {
        this.agencyReseller = agencyReseller;
    }

    @XmlElement(name = "UserGroupGUID")
    public String getUserGroupGUID() {
        return userGroupGUID;
    }

    public void setUserGroupGUID(String userGroupGUID) {
        this.userGroupGUID = userGroupGUID;
    }

    @XmlElement(name = "PaperworkHub")
    public String getPaperworkHub() {
        return paperworkHub;
    }

    public void setPaperworkHub(String paperworkHub) {
        this.paperworkHub = paperworkHub;
    }

    @XmlElement(name = "ResellerAgencyGUID")
    public String getResellerAgencyGUID() {
        return resellerAgencyGUID;
    }

    public void setResellerAgencyGUID(String resellerAgencyGUID) {
        this.resellerAgencyGUID = resellerAgencyGUID;
    }

    @XmlElement(name = "LogoHeight")
    public String getLogoHeight() {
        return logoHeight;
    }

    public void setLogoHeight(String logoHeight) {
        this.logoHeight = logoHeight;
    }

    @XmlElement(name = "LogoWidth")
    public String getLogoWidth() {
        return logoWidth;
    }

    public void setLogoWidth(String logoWidth) {
        this.logoWidth = logoWidth;
    }

    @XmlElement(name = "LogoFileName")
    public String getLogoFileName() {
        return logoFileName;
    }

    public void setLogoFileName(String logoFileName) {
        this.logoFileName = logoFileName;
    }

    @XmlElement(name = "RoleID")
    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    @XmlElement(name = "IncludedAdbankMonths")
    public String getIncludedAdbankMonths() {
        return includedAdbankMonths;
    }

    public void setIncludedAdbankMonths(String includedAdbankMonths) {
        this.includedAdbankMonths = includedAdbankMonths;
    }

    @XmlElement(name = "Online.EnableBilling")
    public String getOnlineEnableBilling() {
        return onlineEnableBilling;
    }

    public void setOnlineEnableBilling(String onlineEnableBilling) {
        this.onlineEnableBilling = onlineEnableBilling;
    }
}
