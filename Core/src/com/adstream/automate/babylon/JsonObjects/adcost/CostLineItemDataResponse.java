package com.adstream.automate.babylon.JsonObjects.adcost;
import org.joda.time.DateTime;
/**
 * Created by Arti.Sharma on 28/07/2017.
 */
public class CostLineItemDataResponse {
    private String localCurrencyId;
    private String templateSectionId;
    private String name;
    private Integer valueInLocalCurrency;
    private String costStageRevisionId;
    private String id;
    private String templateSectionName;
    private Integer valueInDefaultCurrency;
    private String ownerId;
    private String createdById;
    private DateTime created;
    private DateTime modified;
    private String symbol;
    public Integer getValueInLocalCurrency() {
        return valueInLocalCurrency;
    }
    public void setValueInLocalCurrency(Integer valueInLocalCurrency) {
        this.valueInLocalCurrency = valueInLocalCurrency;
    }
    public String getLocalCurrencyId ()
    {
        return localCurrencyId;
    }
    public void setLocalCurrencyId (String localCurrencyId)
    {
        this.localCurrencyId = localCurrencyId;
    }
    public String getTemplateSectionId ()
    {
        return templateSectionId;
    }
    public void setTemplateSectionId (String templateSectionId)
    {
        this.templateSectionId = templateSectionId;
    }
    public String getName ()
    {
        return name;
    }
    public void setName (String name)
    {
        this.name = name;
    }
    public Integer getValueInDefaultCurrency ()
    {
        return valueInDefaultCurrency;
    }
    public void setValueInDefaultCurrency (Integer valueInDefaultCurrency)
    {
        this.valueInDefaultCurrency = valueInDefaultCurrency;
    }
    public String getCostStageRevisionId ()
    {
        return costStageRevisionId;
    }
    public void setCostStageRevisionId (String costStageRevisionId)
    {
        this.costStageRevisionId = costStageRevisionId;
    }
    public String getId ()
    {
        return id;
    }
    public void setId (String id)
    {
        this.id = id;
    }
    public String getTemplateSectionName ()
    {
        return templateSectionName;
    }
    public void setTemplateSectionName (String templateSectionName)
    {
        this.templateSectionName = templateSectionName;
    }
    public String getOwnerId ()
    {
        return ownerId;
    }
    public void setOwnerId (String ownerId)
    {
        this.ownerId = ownerId;
    }
    public String getCreatedById ()
    {
        return createdById;
    }
    public void setCreatedById (String createdById)
    {
        this.createdById = createdById;
    }
    public DateTime getCreated ()
    {
        return created;
    }
    public void setCreated (DateTime created)
    {
        this.created = created;
    }
    public DateTime getModified ()
    {
        return modified;
    }
    public void setModified (DateTime modified)
    {
        this.modified = modified;
    }
    public String getSymbol ()
    {
        return symbol;
    }
    public void setSymbol (String symbol)
    {
        this.symbol = symbol;
    }
}