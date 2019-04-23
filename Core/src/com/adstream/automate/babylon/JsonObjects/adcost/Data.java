package com.adstream.automate.babylon.JsonObjects.adcost;

import org.joda.time.DateTime;

import java.util.List;

/**
 * Created by Raja.Gone on 08/06/2017.
 */
public class Data {
    private String agencyCurrency;

    private Boolean isAIPE;

    private String[] agencyProducer;

    private BudgetRegions budgetRegion;

    private String IsCurrencyChanged;

    private Organisation organisation;

    private String projectId;

    private ContentType contentType;

    private ProductionType productionType;

    private String initialBudgetCurrencySymbol;

    private Integer initialBudget;

    private String title;

    private String description;

    private String campaign;

    private String agencyTrackingNumber;

    private Boolean isNewBuyout;
    private UsageType usageType;
    private UsageBuyoutType usageBuyoutType;
    private String smoId;
    private String smoName;
    private String financialYear;
    private String extensionCostNumber;
    private String approvalStage;
    private String costNumber;
    private DateTime airInsertionDate;

    public String getCostType() {
        return costType;
    }

    public void setCostType(String costType) {
        this.costType = costType;
    }

    private String costType;

    public String getAgencyCurrency ()
    {
        return agencyCurrency;
    }

    public void setAgencyCurrency (String agencyCurrency)
    {
        this.agencyCurrency = agencyCurrency;
    }

    public Boolean getIsAIPE ()
    {
        return isAIPE;
    }

    public void setIsAIPE (Boolean isAIPE)
    {
        this.isAIPE = isAIPE;
    }

    public String[] getAgencyProducer ()
    {
    return agencyProducer;
    }

    public void setAgencyProducer (String[] agencyProducer)
    {
    this.agencyProducer = agencyProducer;
    }

    public String getFinancialYear ()
    {
        return financialYear;
    }

    public void setFinancialYear (String financialYear)
    {
        this.financialYear = financialYear;
    }

    public String getIsCurrencyChanged ()
    {
        return IsCurrencyChanged;
    }

    public void setIsCurrencyChanged (String IsCurrencyChanged)
    {
        this.IsCurrencyChanged = IsCurrencyChanged;
    }

    public Organisation getOrganisation ()
    {
        if (organisation == null) organisation = new Organisation();
        return organisation;
    }

    public void setOrganisation (Organisation organisation)
    {
        this.organisation = organisation;
    }

    public String getProjectId ()
    {
        return projectId;
    }

    public void setProjectId (String projectId)
    {
        this.projectId = projectId;
    }

    public ContentType getContentType ()
    {
        if (contentType == null) contentType = new ContentType();
        return contentType;
    }

    public void setContentType (ContentType contentType)
    {
        if (contentType == null) contentType = new ContentType();
        this.contentType = contentType;
    }

    public ProductionType getProductionType ()
    {
        if (productionType == null) productionType = new ProductionType();
        return productionType;
    }

    public void setProductionType (ProductionType productionType)
    {
        if (productionType == null) productionType = new ProductionType();
        this.productionType = productionType;
    }

    public BudgetRegions getBudgetRegion ()
    {
        if (budgetRegion == null) budgetRegion = new BudgetRegions();
        return budgetRegion;
    }

    public void setBudgetRegion (BudgetRegions budgetRegione)
    {
        if (budgetRegion == null) budgetRegion = new BudgetRegions();
        this.budgetRegion = budgetRegion;
    }

    public String getInitialBudgetCurrencySymbol ()
    {
        return initialBudgetCurrencySymbol;
    }

    public void setInitialBudgetCurrencySymbol (String initialBudgetCurrencySymbol)
    {
        this.initialBudgetCurrencySymbol = initialBudgetCurrencySymbol;
    }

    public Integer getInitialBudget ()
    {
        return initialBudget;
    }

    public void setInitialBudget (Integer initialBudget)
    {
        this.initialBudget = initialBudget;
    }

    public String getTitle ()
    {
        return title;
    }

    public void setTitle (String title)
    {
        this.title = title;
    }

    public String getDescription ()
    {
        return description;
    }

    public void setDescription (String description)
    {
        this.description = description;
    }

    public String getCampaign ()
    {
        return campaign;
    }

    public void setCampaign (String campaign)
    {
        this.campaign = campaign;
    }

    public String getAgencyTrackingNumber ()
    {
        return agencyTrackingNumber;
    }

    public void setAgencyTrackingNumber (String agencyTrackingNumber)
    {
        this.agencyTrackingNumber = agencyTrackingNumber;
    }

    private CgiAnimationCompany cgiAnimationCompany;

    private DigitalDevelopmentCompany digitalDevelopmentCompany;

    private RetouchingCompany retouchingCompany;

    private PhotographerCompany photographerCompany;

    private DirectPaymentVendor directPaymentVendor;

    private PrimaryShootCountry primaryShootCountry;

    private ShootCountry shootCountry;

    private RecordingCountry recordingCountry;

    private int shootDays;

    private int recordingDays;

    private ProductionCompany productionCompany;

    private PrimaryShootCity primaryShootCity;

    private ShootCity shootCity;

    private RecordingCity recordingCity;

    private MusicCompany musicCompany;

    private String director;

    private String photographerName;

    private String airing;

    private PostProductionCompany postProductionCompany;

    private TalentCompany talentCompany;

    private DateTime firstShootDate;

    private DateTime recordingDate;

    public CgiAnimationCompany getCgiAnimationCompany ()
    {
        if (cgiAnimationCompany == null) cgiAnimationCompany = new CgiAnimationCompany();
        return cgiAnimationCompany;
    }

    public void setCgiAnimationCompany (CgiAnimationCompany cgiAnimationCompany)
    {
        this.cgiAnimationCompany = cgiAnimationCompany;
    }

    public DigitalDevelopmentCompany getDigitalDevelopmentCompany ()
    {
        if (digitalDevelopmentCompany == null) digitalDevelopmentCompany = new DigitalDevelopmentCompany();
        return digitalDevelopmentCompany;
    }

    public void setDigitalDevelopmentCompany (DigitalDevelopmentCompany digitalDevelopmentCompany)
    {
        this.digitalDevelopmentCompany = digitalDevelopmentCompany;
    }

    public RetouchingCompany getRetouchingCompany ()
    {
        if (retouchingCompany == null) retouchingCompany = new RetouchingCompany();
        return retouchingCompany;
    }

    public void setRetouchingCompany (RetouchingCompany RetouchingCompany)
    {
        this.retouchingCompany = RetouchingCompany;
    }

    public PhotographerCompany getPhotographerCompany ()
    {
        if (photographerCompany == null) photographerCompany = new PhotographerCompany();
        return photographerCompany;
    }

    public void setPhotographerCompany (PhotographerCompany PhotographerCompany)
    {
        this.photographerCompany = PhotographerCompany;
    }


    public PrimaryShootCountry getPrimaryShootCountry ()
    {
        if (primaryShootCountry == null) primaryShootCountry = new PrimaryShootCountry();
        return primaryShootCountry;
    }

    public void setPrimaryShootCountry (PrimaryShootCountry primaryShootCountry)
    {
        this.primaryShootCountry = primaryShootCountry;
    }

    public ShootCountry getShootCountry ()
    {
        if (shootCountry == null) shootCountry = new ShootCountry();
        return shootCountry;
    }

    public void setShootCountry (ShootCountry shootCountry)
    {
        this.shootCountry = shootCountry;
    }

    public RecordingCountry getRecordingCountry ()
    {
        if (recordingCountry == null) recordingCountry = new RecordingCountry();
        return recordingCountry;
    }

    public void setrecordingCountry (RecordingCountry recordingCountry)
    {
        this.recordingCountry = recordingCountry;
    }

    public int getShootDays ()
    {
        return shootDays;
    }

    public void setShootDays (int shootDays)
    {
        this.shootDays = shootDays;
    }

    public int getRecordingDays ()
    {
        return recordingDays;
    }

    public void setRecordingDays (int recordingDays)
    {
        this.recordingDays = recordingDays;
    }

    public ProductionCompany getProductionCompany ()
    {
        if (productionCompany == null) productionCompany = new ProductionCompany();
        return productionCompany;
    }

    public void setProductionCompany (ProductionCompany productionCompany)
    {
        this.productionCompany = productionCompany;
    }

    public PrimaryShootCity getPrimaryShootCity ()
    {
        if (primaryShootCity == null) primaryShootCity = new PrimaryShootCity();
        return primaryShootCity;
    }

    public void setPrimaryShootCity (PrimaryShootCity primaryShootCity)
    {
        this.primaryShootCity = primaryShootCity;
    }

    public ShootCity getShootCity ()
    {
        if (shootCity == null) shootCity = new ShootCity();
        return shootCity;
    }

    public void setShootCity (ShootCity shootCity)
    {
        this.shootCity = shootCity;
    }

    public RecordingCity getRecordingCity ()
    {
        if (recordingCity == null) recordingCity = new RecordingCity();
        return recordingCity;
    }

    public void setRecordingCity (RecordingCity recordingCity)
    {
        this.recordingCity = recordingCity;
    }

    public MusicCompany getMusicCompany ()
    {
        if (musicCompany == null) musicCompany = new MusicCompany();
        return musicCompany;
    }

    public void setMusicCompany (MusicCompany musicCompany)
    {
        this.musicCompany = musicCompany;
    }

    public String getDirector ()
    {
        return director;
    }

    public void setDirector (String director)
    {
        this.director = director;
    }

    public String getPhotographerName ()
    {
        return photographerName;
    }

    public void setPhotographerName (String photographerName)
    {
        this.photographerName = photographerName;
    }

    public String getAiring ()
    {
        return airing;
    }

    public void setAiring (String airing)
    {
        this.airing = airing;
    }

    public PostProductionCompany getPostProductionCompany ()
    {
        if (postProductionCompany == null) postProductionCompany = new PostProductionCompany();
        return postProductionCompany;
    }

    public void setPostProductionCompany (PostProductionCompany postProductionCompany)
    {
        this.postProductionCompany = postProductionCompany;
    }

    public TalentCompany getTalentCompany ()
    {
        if (talentCompany == null) talentCompany = new TalentCompany();
        return talentCompany;
    }

    public void setTalentCompany (TalentCompany talentCompany)
    {
        this.talentCompany = talentCompany;
    }

    public DateTime getFirstShootDate ()
    {
        return firstShootDate;
    }

    public void setFirstShootDate (DateTime firstShootDate)
    {
        this.firstShootDate = firstShootDate;
    }

    public DateTime getRecordingDate ()
    {
        return recordingDate;
    }

    public void setRecordingDate (DateTime recordingDate)
    {
        this.recordingDate = recordingDate;
    }

    private String grNumber;

    private String poNumber;

    private String ioNumber;

    private DateTime finalAssetApprovalDate;

    public String getGrNumber ()
    {
        return grNumber;
    }

    public void setGrNumber (String grNumber)
    {
        this.grNumber = grNumber;
    }

    public String getPoNumber ()
    {
        return poNumber;
    }

    public void setPoNumber (String poNumber)
    {
        this.poNumber = poNumber;
    }

    public String getIoNumber ()
    {
        return ioNumber;
    }

    public void setIoNumber (String ioNumber)
    {
        this.ioNumber = ioNumber;
    }

    public DateTime getFinalAssetApprovalDate ()
    {
        return finalAssetApprovalDate;
    }

    public void setFinalAssetApprovalDate (DateTime finalAssetApprovalDate)
    {
        this.finalAssetApprovalDate = finalAssetApprovalDate;
    }


    public String getApprovalStage() {
        return approvalStage;
    }

    public void setApprovalStage(String approvalStage) {
        this.approvalStage = approvalStage;
    }

    public String getExtensionCostNumber() {
        return extensionCostNumber;
    }

    public void setExtensionCostNumber(String extensionCostNumber) {
        this.extensionCostNumber = extensionCostNumber;
    }

    public String getSmoName() {
        return smoName;
    }

    public void setSmoName(String smoName) {
        this.smoName = smoName;
    }

    public String getSmoId() {
        return smoId;
    }

    public void setSmoId(String smoId) {
        this.smoId = smoId;
    }

    public UsageBuyoutType getUsageBuyoutType() {
        if (usageBuyoutType == null) usageBuyoutType = new UsageBuyoutType();
        return usageBuyoutType;
    }

    public void setUsageBuyoutType(UsageBuyoutType usageBuyoutType) {
        this.usageBuyoutType = usageBuyoutType;
    }

    public UsageType getUsageType() {
        if (usageType == null) usageType = new UsageType();
        return usageType;
    }

    public void setUsageType(UsageType usageType) {
        this.usageType = usageType;
    }

    public Boolean getNewBuyout() {
        return isNewBuyout;
    }

    public void setNewBuyout(Boolean newBuyout) {
        isNewBuyout = newBuyout;
    }

    public Boolean getAIPE() {
        return isAIPE;
    }

    public void setAIPE(Boolean AIPE) {
        isAIPE = AIPE;
    }

    public String getCostNumber() {
        return costNumber;
    }

    public void setCostNumber(String costNumber) {
        this.costNumber = costNumber;
    }

    private String nameOfLicensor;

    private Contract contract;

    private String name;

    private List<Rights> rights;

    private List<AiringCountries> airingCountries;

    private List<Touchpoints> touchpoints;

    public String getNameOfLicensor ()
    {
        return nameOfLicensor;
    }

    public void setNameOfLicensor (String nameOfLicensor)
    {
        this.nameOfLicensor = nameOfLicensor;
    }

    public Contract getContract ()
    {
        if(contract==null) contract= new Contract();
        return contract;
    }

    public void setContract (Contract contract)
    {
        this.contract = contract;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public List<Rights> getRights ()
    {
        return rights;
    }

    public void setRights (List<Rights> rights)
    {
        this.rights = rights;
    }

    public List<AiringCountries> getAiringCountries ()
    {
        return airingCountries;
    }

    public void setAiringCountries (List<AiringCountries> airingCountries)
    {
        this.airingCountries = airingCountries;
    }

    public List<Touchpoints> getTouchpoints ()
    {
        return touchpoints;
    }

    public void setTouchpoints (List<Touchpoints> touchpoints)
    {
        this.touchpoints = touchpoints;
    }

    public String producedAsset;

    public TalentDecisionRights talentDecisionRights;

    public EntourageTravel entourageTravel;

    public String getProducedAsset ()
    {
        return producedAsset;
    }

    public void setProducedAsset (String producedAsset)
    {
        this.producedAsset = producedAsset;
    }

    public TalentDecisionRights getTalentDecisionRights ()
    {
        if(talentDecisionRights==null) talentDecisionRights= new TalentDecisionRights();
        return talentDecisionRights;
    }

    public void setTalentDecisionRights (TalentDecisionRights talentDecisionRights)
    {
        this.talentDecisionRights = talentDecisionRights;
    }

    public EntourageTravel getEntourageTravel ()
    {
        if(entourageTravel==null) entourageTravel= new EntourageTravel();
        return entourageTravel;
    }

    public void setEntourageTravel (EntourageTravel entourageTravel)
    {
        this.entourageTravel = entourageTravel;
    }

    public DateTime getAirInsertionDate ()
    {
        return airInsertionDate;
    }

    public void setAirInsertionDate (DateTime airInsertionDate)
    {
        this.airInsertionDate = airInsertionDate;
    }

    public DirectPaymentVendor getDirectPaymentVendor ()
    {
        if (directPaymentVendor == null) directPaymentVendor = new DirectPaymentVendor();
        return directPaymentVendor;
    }

    public void setDirectPaymentVendor (DirectPaymentVendor directPaymentVendor)
    {
        this.directPaymentVendor = directPaymentVendor;
    }

}
