package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 19/06/2017.
 */
public class BaseProductionDetails {
    private ProductionDetails productionDetails;

    public ProductionDetails getProductionDetails ()
    {
        if (productionDetails == null) productionDetails = new ProductionDetails();
        return productionDetails;
    }

    public void setProductionDetails (ProductionDetails productionDetails)
    {
        this.productionDetails = productionDetails;
    }
}
