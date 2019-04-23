package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.Asset;
import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import org.joda.time.DateTime;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 12.08.13
 * Time: 18:40
 */
public class OrderItem extends BaseObject {
    private CustomMetadata _cm;
    private CustomMetadata a4;
    private CustomMetadata order;
    private Asset[] assets;
    private String assetId;
    private String orderId;
    private String[] status;
    // for confirmed item with enabled QC & Ingest only
    private String[] ingestViewStatus;
    private AssetElement assetElement;
    private String approvalStatus;
    // for confirmed order without media content
    private String qcAssetId;

    public Asset[] getAssets() {
        return assets;
    }

    public void setAssets(Asset[] assets) {
        this.assets = assets;
    }

    public String getAssetId() {
        return assetId;
    }

    public void setAssetId(String assetId) {
        this.assetId = assetId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String[] getStatus() {
        return status;
    }

    public void setStatus(String[] status) {
        this.status = status;
    }

    public String[] getIngestViewStatus() {
        return ingestViewStatus;
    }

    public void setIngestViewStatus(String[] ingestViewStatus) {
        this.ingestViewStatus = ingestViewStatus;
    }

    public AssetElement getAssetElement() {
        return assetElement;
    }

    public void setAssetElement(AssetElement assetElement) {
        this.assetElement = assetElement;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getQCAssetId() {
        return qcAssetId;
    }

    public void setQCAssetId(String qcAssetId) {
        this.qcAssetId = qcAssetId;
    }

    /*
    * Custom metadata fields
    */

    // _cm.tv
    public String getTvMarket() {
        return getCmTV().getString("market");
    }

    public void setTvMarket(String tvMarket) {
        getCmTV().put("market", tvMarket);
    }

    public String getTvMarketCountry(){
        return getCmTV().getString("marketCountry");
    }

    public void setTvMarketCountry(String marketCountry) {
        getCmTV().put("marketCountry", marketCountry);
    }

    public String[] getTVMarketId() {
        return getCmTV().getStringArray("marketId");
    }

    public void setTVMarketId(String[] marketId) {
        getCmTV().put("marketId", marketId);
    }

    public Integer getTvOrderReference() {
        return getCmTV().getInteger("orderReference");
    }

    public void setTvOrderReference(Integer orderReference) {
        getCmTV().put("orderReference", orderReference);
    }

    // _cm.metadata
    public String[] getMetadataSubtitlesRequired() {
        return getCmMetadata().getStringArray("subtitlesRequired");
    }

    public void setMetadataSubtitlesRequired(String[] subtitlesRequired) {
        getCmMetadata().put("subtitlesRequired", subtitlesRequired);
    }

    // metadata of Spain market
    public String getClave() {
        return getCmMetadata().getString("clave");
    }

    public void setClave(String clave) {
        getCmMetadata().put("clave", clave);
    }

    public String[] getWatermarkingRequired() {
        return getCmMetadata().getStringArray("watermarkingRequired");
    }

    public void setWatermarkingRequired(String[] watermarkingRequired) {
        getCmMetadata().put("watermarkingRequired", watermarkingRequired);
    }

    public String getWatermarkingCode() {
        return getCmMetadata().getString("watermarkingCode");
    }

    public void setWatermarkingCode(String watermarkingCode) {
        getCmMetadata().put("watermarkingCode", watermarkingCode);
    }

    public String[] getWatermarkingBrand() {
        return getCmMetadata().getStringArray("brand");
    }

    public void setWatermarkingBrand(String[] brand) {
        getCmMetadata().put("brand", brand);
    }

    public String[] getModel() {
        return getCmMetadata().getStringArray("model");
    }

    public void setModel(String[] model) {
        getCmMetadata().put("model", model);
    }

    public String getProductDescription() {
        return getCmMetadata().getString("productDescription");
    }

    public void setProductDescription(String productDescription) {
        getCmMetadata().put("productDescription", productDescription);
    }

    public String getCreativeDescription() {
        return getCmMetadata().getString("creativeDescription");
    }

    public void setCreativeDescription(String creativeDescription) {
        getCmMetadata().put("creativeDescription", creativeDescription);
    }

    public String[] getSector() {
        return getCmMetadata().getStringArray("sector");
    }

    public void setSector(String[] sector) {
        getCmMetadata().put("sector", sector);
    }

    public String[] getGroup() {
        return getCmMetadata().getStringArray("group");
    }

    public void setGroup(String[] group) {
        getCmMetadata().put("group", group);
    }

    public String[] getWatermarkingProduct() {
        return getCmMetadata().getStringArray("product");
    }

    public void setWatermarkingProduct(String[] product) {
        getCmMetadata().put("productwm", product);
    }

    // metadata of Brazil market
    public String getType() {
        return getCmMetadata().getString("type");
    }

    public void setType(String type) {
        getCmMetadata().put("type", type);
    }

    public String getMarketSegment() {
        return getCmMetadata().getString("marketSegment");
    }

    public void setMarketSegment(String marketSegment) {
        getCmMetadata().put("marketSegment", marketSegment);
    }

    public String getCRT() {
        return getCmMetadata().getString("crt");
    }

    public void setCRT(String crt) {
        getCmMetadata().put("crt", crt);
    }

    public DateTime getDateOfAncineReg() {
        return getCmMetadata().getDateTime("dateOfAncineReg");
    }

    public void setDateOfAncineReg(DateTime dateOfAncineReg) {
        getCmMetadata().put("dateOfAncineReg", dateOfAncineReg);
    }

    public String getDirector() {
        return getCmMetadata().getString("director");
    }

    public void setDirector(String director) {
        getCmMetadata().put("director", director);
    }

    public String getNumberOfVersions() {
        return getCmMetadata().getString("numberOfVersions");
    }

    public void setNumberOfVersions(String numberOfVersions) {
        getCmMetadata().put("numberOfVersions", numberOfVersions);
    }

    public String getCNPJ() {
        return getCmMetadata().getString("cnpj");
    }

    public void setCNPJ(String cnpj) {
        getCmMetadata().put("cnpj", cnpj);
    }

    // metadata of France market
    public String[] getMentions() {
        return getCmMetadata().getStringArray("mentions");
    }

    public void setMentions(String[] mentions) {
        getCmMetadata().put("mentions", mentions);
    }

    public String[] getTypeDeMentions() {
        return getCmMetadata().getStringArray("typeDeMentions");
    }

    public void setTypeDeMentions(String[] typeDeMentions) {
        getCmMetadata().put("typeDeMentions", typeDeMentions);
    }

    // arpp metadata of France market
    public String getARPPVersionNumber() {
        return getCmArppMetadata().getString("version");
    }

    public void setARPPVersionNumber(String version) {
        getCmArppMetadata().put("version", version);
    }

    public String getARPPSubmissionNumber() {
        return getCmArppMetadata().getString("sNumber");
    }

    public void setARPPSubmissionNumber(String sNumber) {
        getCmArppMetadata().put("sNumber", sNumber);
    }

    public String getARPPSubmissionResults() {
        return getCmArppMetadata().getString("sResults");
    }

    public void setARPPSubmissionResults(String sResults) {
        getCmArppMetadata().put("sResults", sResults);
    }

    public String getARPPSubmissionCommentsCode() {
        return getCmArppMetadata().getString("sCommentsCode");
    }

    public void setARPPSubmissionCommentsCode(String sCommentsCode) {
        getCmArppMetadata().put("sCommentsCode", sCommentsCode);
    }

    public String getARPPSubmissionDetails() {
        return getCmArppMetadata().getString("sDetails");
    }

    public void setARPPSubmissionDetails(String sDetails) {
        getCmArppMetadata().put("sDetails", sDetails);
    }

    // metadata of Disney Pan Nordic market
    public String getDisneyCode() {
        return getCmMetadata().getString("disneyCode");
    }

    public void setDisneyCode(String disneyCode) {
        getCmMetadata().put("disneyCode", disneyCode);
    }

    // metadata of Switzerland market
    public String getSuisa() {
        return getCmMetadata().getString("suisa");
    }

    public void setSuisa(String suisa) {
        getCmMetadata().put("suisa", suisa);
    }

    public String[] getLanguage() {
        return getCmMetadata().getStringArray("language");
    }

    public void setLanguage(String[] language) {
        getCmMetadata().put("language", language);
    }

    // metadata of Germany market
    public String getMotivnummer() {
        return getCmMetadata().getString("motivnummer");
    }

    public void setMotivnummer(String motivnummer) {
        getCmMetadata().put("motivnummer", motivnummer);
    }

    // metadata of Austria market
    public String getSujectAkm() {
        return getCmMetadata().getString("sujetAkm");
    }

    public void setSujectAkm(String sujetAkm) {
        getCmMetadata().put("sujetAkm", sujetAkm);
    }

    // metadata of Belgium market
    public String getMbcidCode() {
        return getCmMetadata().getString("mbcidCode");
    }

    public void setMbcidCode(String mbcidCode) {
        getCmMetadata().put("mbcidCode", mbcidCode);
    }

    // metadata of Chile market
    public String getMegatimeCode() {
        return getCmMetadata().getString("megatimeCode");
    }

    public void setMegatimeCode(String megatimeCode) {
        getCmMetadata().put("megatimeCode", megatimeCode);
    }

    // metadata of Netherlands market
    public String getDeliveryTitle() {
        return getCmMetadata().getString("deliveryTitle");
    }

    public void setDeliveryTitle(String deliveryTitle) {
        getCmMetadata().put("deliveryTitle", deliveryTitle);
    }

    // metadata of Australia market
    public String getCadNo() {
        return getCmMetadata().getString("cadNo");
    }

    public void setCadNo(String cadNo) {
        getCmMetadata().put("cadNo", cadNo);
    }

    //metadata of Mexico market
    public String getTelevisaId() {
        return getCmMetadata().getString("televisaId");
    }

    public void setTelevisaId(String televisaId) {
        getCmMetadata().put("televisaId", televisaId);
    }

    // metadata of Venezuela market
    public String getRifCode() {
        return getCmMetadata().getString("rifCode");
    }

    public void setRifCode(String rifCode) {
        getCmMetadata().put("rifCode", rifCode);
    }

    // metadata of Sweden market
    public String[] getMediaSubType() {
        return getCmMetadata().getStringArray("mediaSubtype");
    }

    public void setMediaSubType(String[] mediaSubtype) {
        getCmMetadata().put("mediaSubtype", mediaSubtype);
    }

    public String[] getVersion() {
        return getCmMetadata().getStringArray("version");
    }

    public void setVersion(String[] version) {
        getCmMetadata().put("version", version);
    }

    // _cm.common
    public DateTime getFirstAirDate() {
        return getCmCommon().getDateTime("firstAirDate");
    }

    public void setFirstAirDate(DateTime firstAirDate) {
        getCmCommon().put("firstAirDate", firstAirDate);
    }

    public String[] getFormat() {
        return getCmCommon().getStringArray("format");
    }

    public void setFormat(String[] format) {
        getCmCommon().put("format", format);
    }

    public String getDuration() {
        return getCmCommon().getString("duration");
    }

    public void setDuration(String duration) {
        getCmCommon().put("duration", duration);
    }

    public String getAdditionalInformation() {
        return getCmCommon().getString("additionalInformation");
    }

    public void setAdditionalInformation(String additionalInformation) {
        getCmCommon().put("additionalInformation", additionalInformation);
    }

    public String getClockNumber() {
        return getCmCommon().getString("clockNumber");
    }

    public void setClockNumber(String clockNumber) {
        getCmCommon().put("clockNumber", clockNumber);
    }

    public String getTitle() {
        return getCmCommon().getString("title");
    }

    public void setTitle(String title) {
        getCmCommon().put("title", title);
    }

    public String getItemType() {
        return getCmCommon().getString("item_type");
    }

    public void setItemType(String itemType) {
        getCmCommon().put("item_type", itemType);
    }

    public Document[] getUploadedFiles() {
        return getCmCommon().getArrayForClass("uploadedFiles", Document.class);
    }

    public void setUploadedFiles(Document[] documents) {
        getCmCommon().put("uploadedFiles", documents);
    }

    public String[] getMediaAgency() {
        return getCmCommon().getStringArray("mediaAgency");
    }

    public void setMediaAgency(String[] mediaAgency) {
        getCmCommon().put("mediaAgency", mediaAgency);
    }

    public String[] getCreativeAgency() {
        return getCmCommon().getStringArray("creativeAgency");
    }

    public void setCreativeAgency(String[] creativeAgency) {
        getCmCommon().put("creativeAgency", creativeAgency);
    }

    public String[] getPostHouse() {
        return getCmCommon().getStringArray("posthouse");
    }

    public void setPostHouse(String[] posthouse) {
        getCmCommon().put("posthouse", posthouse);
    }

    // _cm.media
    public String[] getUploadRequestAssignees() {
        return getCmMediaUploadRequest().getStringArray("assignees");
    }

    public void setUploadRequestAssignees(String[] assignees) {
        getCmMediaUploadRequest().put("assignees", assignees);
    }

    public String getUploadRequestPostHouse() {
        return getCmMediaUploadRequest().getString("postHouse");
    }

    public void setUploadRequestPostHouse(String postHouse) {
        getCmMediaUploadRequest().put("postHouse", postHouse);
    }

    public String getUploadRequestArrivalTime() {
        return getCmMediaUploadRequest().getString("arrivalTime");
    }

    public void setUploadRequestArrivalTime(String arrivalTime) {
        getCmMediaUploadRequest().put("arrivalTime", arrivalTime);
    }

    public String getUploadRequestMessage() {
        return getCmMediaUploadRequest().getString("message");
    }

    public void setUploadRequestMessage(String message) {
        getCmMediaUploadRequest().put("message", message);
    }

    public Boolean isUploadRequestAlreadySupplied() {
        return getCmMediaUploadRequest().getBoolean("alreadySupplied");
    }

    public void setUploadRequestAlreadySupplied(Boolean alreadySupplied) {
        getCmMediaUploadRequest().put("alreadySupplied", alreadySupplied);
    }

    public DateTime getUploadRequestDeadlineDate() {
        return getCmMediaUploadRequest().getDateTime("deadlineDate");
    }

    public void setUploadRequestDeadlineDate(DateTime deadlineDate) {
        getCmMediaUploadRequest().put("deadlineDate", deadlineDate);
    }

    public Integer getUploadRequestDaysBeforeFirstAirDate() {
        return getCmMediaUploadRequest().getInteger("daysBeforeFirstAirDate");
    }

    public void setUploadRequestDaysBeforeFirstAirDate(int daysBeforeFirstAirDate) {
        getCmMediaUploadRequest().put("daysBeforeFirstAirDate", daysBeforeFirstAirDate);
    }

    public String[] getUploadRequestUploadType() {
        return getCmMediaUploadRequest().getStringArray("uploadType");
    }

    public void setUploadRequestUploadType(String[] uploadType) {
        getCmMediaUploadRequest().put("uploadType", uploadType);
    }

    //_cm.asset
    public String[] getAdvertiser() {
        return getCmAssetCommon().getStringArray("advertiser");
    }

    public void setAdvertiser(String[] advertiser) {
        getCmAssetCommon().put("advertiser", advertiser);
    }

    public String[] getProduct() {
        return getCmAssetCommon().getStringArray("product");
    }

    public void setProduct(String[] product) {
        getCmAssetCommon().put("product", product);
    }

    public String[] getBrand() {
        return getCmAssetCommon().getStringArray("brand");
    }

    public void setBrand(String[] brand) {
        getCmAssetCommon().put("brand", brand);
    }

    public String[] getSubBrand() {
        return getCmAssetCommon().getStringArray("sub_brand");
    }

    public void setSubBrand(String[] subBrand) {
        getCmAssetCommon().put("sub_brand", subBrand);
    }

    public String getCampaign() {
        return getCmAssetCommon().getString("Campaign");
    }

    public void setCampaign(String campaign) {
        getCmAssetCommon().put("Campaign", campaign);
    }

    //_cm.nonBroadcastDestinations
    public NonBroadcastDestinationItem[] getNonBroadcastDestinationItems() {
        return getCmNonBroadcastDestinations().getArrayForClass("items", NonBroadcastDestinationItem.class);
    }

    public void setNonBroadcastDestinationItems(NonBroadcastDestinationItem[] nonBroadcastDestinationItems) {
        getCmNonBroadcastDestinations().put("items", nonBroadcastDestinationItems);
    }

    //_cm.productionServices
    public ProductionServiceItem[] getProductionServicesItems() {
        return getCmProductionServices().getArrayForClass("items", ProductionServiceItem.class);
    }

    public void setProductionServiceItems(ProductionServiceItem[] productionServiceItems) {
        getCmProductionServices().put("items", productionServiceItems);
    }

    // _cm.destinations
    public DestinationItem[] getDestinationItems() {
        return getCmDestinations().getArrayForClass("items", DestinationItem.class);
    }

    public void setDestinationItems(DestinationItem[] destinationItems) {
        getCmDestinations().put("items", destinationItems);
    }

    public Integer getCountTotalDestinations() {
        return getCmDestinationsCount().getInteger("total");
    }

    public Integer getCountAtDestination() {
        return getCmDestinationsCount().getInteger("atDestination");
    }

    public Integer getCountCanceled() {
        return getCmDestinationsCount().getInteger("cancelled");
    }

    // a4 part
    public String getA4Advertiser() {
        return getA4().getString("advertiser");
    }

    public void setA4Advertiser(String advertiser) {
        getA4().put("advertiser", advertiser);
    }

    public String getA4Product() {
        return getA4().getString("product");
    }

    public void setA4Product(String product) {
        getA4().put("product", product);
    }

    public String getA4Campaign() {
        return getA4().getString("campaign");
    }

    public void setA4Campaign(String campaign) {
        getA4().put("campaign", campaign);
    }

    public DateTime getA4StatusChangedTime() {
        return getA4().getDateTime("status_changed");
    }

    public void setA4StatusChangedTime(DateTime statusChanged) {
        getA4().put("status_changed", statusChanged);
    }

    // order part
    public String getA4OrderId() {
        return getOrder().getString("a4OrderId");
    }

    public void setA4OrderId(String a4OrderId) {
        getOrder().put("a4OrderId", a4OrderId);
    }

    public String getJobNumber() {
        return getOrder().getString("jobNumber");
    }

    public void setJobNumber(String jobNumber) {
        getOrder().put("jobNumber", jobNumber);
    }

    public String getPONumber() {
        return getOrder().getString("poNumber");
    }

    public void setPONumber(String poNumber) {
        getOrder().put("poNumber", poNumber);
    }

    public String getOrderStatus() {
        return getOrder().getString("orderStatus");
    }

    public void setOrderStatus(String orderStatus) {
        getOrder().put("orderStatus", orderStatus);
    }

     /*
    * Private helpers
    */

    public CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    private CustomMetadata getA4() {
        if (a4 == null) a4 = new CustomMetadata();
        return a4;
    }

    private CustomMetadata getOrder() {
        if (order == null) order = new CustomMetadata();
        return order;
    }

    private CustomMetadata getCmTV() {
        return getCm().getOrCreateNode("tv");
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    private CustomMetadata getCmMedia() {
        return getCm().getOrCreateNode("media");
    }

    private CustomMetadata getCmMediaUploadRequest() {
        return getCmMedia().getOrCreateNode("uploadRequest");
    }

    private CustomMetadata getCmMetadata() {
        return getCm().getOrCreateNode("metadata");
    }

    private CustomMetadata getCmArppMetadata() {
        return getCm().getOrCreateNode("arpp");
    }

    private CustomMetadata getCmAsset() {
        return getCm().getOrCreateNode("asset");
    }

    private CustomMetadata getCmAssetCommon() {
        return getCmAsset().getOrCreateNode("common");
    }

    private CustomMetadata getCmAssetVideo() {
        return getCmAsset().getOrCreateNode("video");
    }

    private CustomMetadata getCmNonBroadcastDestinations() {
        return getCm().getOrCreateNode("nonBroadcastDestinations");
    }

    private CustomMetadata getCmProductionServices() {
        return getCm().getOrCreateNode("productionServices");
    }

    private CustomMetadata getCmDestinations() {
        return getCm().getOrCreateNode("destinations");
    }

    private CustomMetadata getCmDestinationsCount() {
        return getCmDestinations().getOrCreateNode("count");
    }
}