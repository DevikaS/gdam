package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 31/05/2017.
 */
public class Costs {

    private String costType;

    private String id;

    private String title;

    private String costNumber;

    private String contentType;

    private String productionType;

    private String budgetRegionName;

    private String contentTypeValue;

    public String getContentTypeValue() {
        return contentTypeValue;
    }

    public void setContentTypeValue(String contentTypeValue) {
        this.contentTypeValue = contentTypeValue;
    }

    public String getBudgetRegionName() {
        return budgetRegionName;
    }

    public void setBudgetRegionName(String budgetRegionName) {
        this.budgetRegionName = budgetRegionName;
    }

    private String modifiedDate;

    private String createdDate;

    private String userModifiedDate;

    public String getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(String modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getUserModifiedDate() {
        return userModifiedDate;
    }

    public void setUserModifiedDate(String userModifiedDate) {
        this.userModifiedDate = userModifiedDate;
    }

    public String getCostNumber() {
        return costNumber;
    }

    public void setCostNumber(String costNumber) {
        this.costNumber = costNumber;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getTitle ()
    {
        return title;
    }

    public void setTitle (String title)
    {
        this.title = title;
    }

    public String getContentType ()
    {
        return contentType;
    }

    public void setContentType (String contentType)
    {
        this.contentType = contentType;
    }

    public String getProductionType() {
        return productionType;
    }

    public void setProductionType(String productionType) {
        this.productionType = productionType;
    }

    public String getCostType() {
        return costType;
    }

    public void setCostType(String costType) {
        this.costType = costType;
    }
}
