package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Arti.Sharma on 14/12/2017.
 */
public class ValueReportingDetails {

    private String provenStrategy;

    private String costStageRevisionId;

    private String costId;

    private String id;

    private String activity;

    private String currencySymbol;

    private boolean hardSavingsDisabled;

    private Integer costAvoidance;

    private Integer valueAdded;

    private Integer hardSavings;

    private Integer totalSavings;

    private ProductionDetails productionDetails;

    public String getProvenStrategy()
    {
        return provenStrategy;
    }

    public void setProvenStrategy(String provenStrategy)
    {
        this.provenStrategy = provenStrategy;
    }

    public String getcostStageRevisionId()
    {
        return costStageRevisionId;
    }

    public void setCostStageRevisionId(String costStageRevisionId)
    {
        this.costStageRevisionId = costStageRevisionId;
    }

    public String getCostId()
    {
        return costId;
    }

    public void setCostId(String costId)
    {
        this.costId = costId;
    }

    public String getId()
    {
        return id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public String getActivity()
    {
        return activity;
    }

    public void setActivity(String activity)
    {
        this.activity = activity;
    }

    public String getCurrencySymbol()
    {
        return currencySymbol;
    }

    public void setCurrencySymbol(String currencySymbol)
    {
        this.currencySymbol = currencySymbol;
    }

    public int getValueAdded()
    {
        return valueAdded;
    }

    public void setValueAdded(int valueAdded)
    {
        this.valueAdded = valueAdded;
    }

    public int getCostAvoidance()
    {
        return costAvoidance;
    }

    public void setCostAvoidance(int costAvoidance)
    {
        this.costAvoidance = costAvoidance;
    }

    public int getHardSavings()
    {
        return hardSavings;
    }

    public void setHardSavings(int hardSavings)
    {
        this.hardSavings = hardSavings;
    }

    public int getTotalSavings()
    {
        return totalSavings;
    }

    public void setTotalSavings(int totalSavings)
    {
        this.totalSavings = totalSavings;
    }

    public boolean getHardSavingsDisabled()
    {
        return hardSavingsDisabled;
    }

    public void setHardSavingsDisabled(boolean hardSavingsDisabled)
    {
        this.hardSavingsDisabled = hardSavingsDisabled;
    }

}
