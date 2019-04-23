package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 22/06/2017.
 */
public class CostLineItemData {

    private String localCurrencyId;

    private String templateSectionId;

    private String name;

    private Integer value;

    private Integer valueInLocalCurrency;

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

    public Integer getValue ()
    {
        return value;
    }

    public void setValue (Integer value)
    {
        this.value = value;
    }

}
