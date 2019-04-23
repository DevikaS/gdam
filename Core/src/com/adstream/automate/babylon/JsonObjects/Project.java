package com.adstream.automate.babylon.JsonObjects;

import org.joda.time.DateTime;
import org.joda.time.LocalTime;

import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;

/**
 * User: ruslan.semerenko
 * Date: 04.04.12 18:06
 */
public class Project extends BaseObject {
    private transient String[] administrators;
    private Identity project;
    private CustomMetadata _ext;
    private CustomMetadata _cm;

    public boolean isTemplate() {
        return getSubtype().equals("project_template");
    }

    public String[] getAdministrators() {
        return administrators;
    }

    public void setAdministrators(String[] administrators) {
        this.administrators = administrators;
    }

    public String getLogo() {
        return getCmLogo().getString("c");
    }

    public void setLogo(String logo) {
        getCmLogo().put("c", logo);
    }

    public Identity getProject() {
        return project;
    }

    public void setProject(Identity project) {
        this.project = project;
    }

    public String getName() {
        return getCmCommon().getString("name");
    }

    public DateTime getPublishDate() {
        return getCmCommon().getDateTime("publishDate");
    }

    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    public void setPublishDate(String publishDate) {

        getCmCommon().put("publishDate", publishDate);
    }

    public void setPublishMessage(String publishMessage) {
        getCmCommon().put("publishMessage", publishMessage);
    }

    public String getPublishMessage() {
        return getCmCommon().getString("publishMessage");
    }

    public CustomMetadata getCampaignDates() {
        return getCmCommon().getOrCreateNode("campaignDates");
    }

    public DateTime getDateStart() {
        return getCampaignDates().getDateTime("start");
    }

    public DateTime getDateEnd() {
        return getCampaignDates().getDateTime("end");
    }



    public void setCampaignDates(DateTime start, DateTime end) {
        setDateStart(start);
        setDateEnd(end);

    }

    public void setDateStart(DateTime start) {
        getCampaignDates().put("start", start);
    }


    public void setDateEnd(DateTime end) {
        getCampaignDates().put("end", end);
    }

    public String getMediaType() {
        return getCmCommon().getStringArray("projectMediaType")[0];
    }

    public void setMediaType(String projectMediaType) {
        getCmCommon().put("projectMediaType", asList(projectMediaType));
    }

    public String getPublishDateTimeZone() {
        return getCmCommon().getString("publishDateTimezone");
    }

    public void setPublishDateTimeZone(String publishDateTimeZone) {
        getCmCommon().put("publishDateTimezone", publishDateTimeZone);
    }



    public String getJobNumber() {
        return getCmCommon().getString("jobNumber");
    }

    public void setJobNumber(String jobNumber) {
        getCmCommon().put("jobNumber", jobNumber);
    }

    public boolean isPublished() {
        return getCmCommon().getBoolean("published");
    }

    public void setPublished(boolean published) {
        getCmCommon().put("published", published);
    }

    public String getAdvertiser() {
        String[] advertiser = getCmCommon().getStringArray("advertiser");
        if (advertiser != null && advertiser.length > 0) {
            return advertiser[0];
        }
        return null;
    }

    public void setAdvertiser(String advertiser) {
        getCmCommon().put("advertiser", new String[] {advertiser});
    }

    public void setCostModuleNumber(String costModuleNumber) {
        getCmCommon().put("CostModuleNumber", costModuleNumber);
    }

    public String getBrand() {
        String[] brand = getCmCommon().getStringArray("brand");
        if (brand != null && brand.length > 0) {
            return brand[0];
        }
        return null;
    }

    public void setBrand(String brand) {
        getCmCommon().put("brand", new String[] {brand});
    }

    public CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Starts
    public String getSubBrand() {
        String[] sub_brand = getCmCommon().getStringArray("sub_brand");
        if (sub_brand != null && sub_brand.length > 0) {
            return sub_brand[0];
        }
        return null;
    }

    public void setSubBrand(String sub_brand) {
        getCmCommon().put("sub_brand", new String[] {sub_brand});
    }
    public String getProduct() {
        String[] product = getCmCommon().getStringArray("product");
        if (product != null && product.length > 0) {
            return product[0];
        }
        return null;
    }

    public void setProduct(String product) {
        getCmCommon().put("product", new String[] {product});
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Ends
    public CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    private CustomMetadata getCmLogo() {
        return getCm().getOrCreateNode("logo");
    }

    private CustomMetadata getExt() {
        if (_ext == null) {
            _ext = new CustomMetadata();
        }
        return _ext;
    }

    /*private HashMap<String, Content> folders;
    public HashMap<String, Content> getFolders() { return folders; }
    public void setFolders(HashMap<String, Content> folders) { this.folders = folders; } */


    private List<Content> folders;
     public List<Content> getFolders() { return folders; }
     public void setFolders(List<Content> folders) { this.folders = folders; }

    public void buildCustomFieldsAsArray(Map<String,String> customFields){
        for(Map.Entry<String,String> entry:customFields.entrySet()){
            getCmCommon().put(entry.getKey(), new String[] {entry.getValue()});
        }
    }

    public void buildCustomFieldsAsString(String key,String value){
            getCmCommon().put(key, value);
    }
}
