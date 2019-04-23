package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Arti.Sharma on 17/01/2018.
 */
public class Criteria {
    private BudgetRegions BudgetRegion;

    private ContentType ContentType;

    private ProductionType ProductionType;

    private IsAIPE IsAIPE;

    private TotalCostAmount TotalCostAmount;

    private CostType CostType;

    public BudgetRegions getBudgetRegion ()
    {
        if (BudgetRegion == null) BudgetRegion = new BudgetRegions();
        return BudgetRegion;
    }

    public void setBudgetRegion (BudgetRegions budgetRegion)
    {
        if (BudgetRegion == null) BudgetRegion = new BudgetRegions();
        this.BudgetRegion = BudgetRegion;
    }

    public ContentType getContentType ()
    {
        if (ContentType == null) ContentType = new ContentType();
        return ContentType;
    }

    public void setContentType (ContentType ContentType)
    {
        if (ContentType == null) ContentType = new ContentType();
        this.ContentType = ContentType;
    }

    public ProductionType getProductionType ()
    {
        if (ProductionType == null) ProductionType = new ProductionType();
        return ProductionType;
    }

    public void setProductionType (ProductionType ProductionType)
    {
        if (ProductionType == null) ProductionType = new ProductionType();
        this.ProductionType = ProductionType;
    }

    public IsAIPE getIsAIPE ()
    {
        if (IsAIPE == null) IsAIPE = new IsAIPE();
        return IsAIPE;
    }

    public void setIsAIPE (IsAIPE IsAIPE)
    {
        if (IsAIPE == null) IsAIPE = new IsAIPE();
        this.IsAIPE = IsAIPE;
    }

    public CostType getCostType()
    {
        if (CostType == null) CostType = new CostType();
        return CostType;
    }

    public void setCostType(CostType CostType)
    {
        if (CostType == null) CostType = new CostType();
        this.CostType = CostType;
    }
    public TotalCostAmount getTotalCostAmount()
    {
        if (TotalCostAmount == null) TotalCostAmount = new TotalCostAmount();
        return TotalCostAmount;
    }

    public void setTotalCostAmount (TotalCostAmount TotalCostAmount)
    {
        if (TotalCostAmount == null) TotalCostAmount = new TotalCostAmount();
        this.TotalCostAmount = TotalCostAmount;
    }
}
