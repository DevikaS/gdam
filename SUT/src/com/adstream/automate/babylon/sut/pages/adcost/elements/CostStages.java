package com.adstream.automate.babylon.sut.pages.adcost.elements;

/**
 * Created by Raja.Gone on 10/10/2017.
 */
public enum CostStages {
    ORIGINALESTIMATEWITHOUTSPACE("OriginalEstimate"),
    ORIGINALESTIMATELOCALWITHOUTSPACE("OriginalEstimate Local"),
    ORIGINALESTIMATEREVISIONWITHOUTSPACE("OriginalEstimate Revision"),
    ORIGINALESTIMATEREVISIONWITHOUTANYSPACE("OriginalEstimateRevision"),
    ORIGINALESTIMATEREVISIONLOCALWITHOUTSPACE("OriginalEstimate Revision Local"),
    ORIGINALESTIMATE("Original Estimate"),
    ORIGINALESTIMATELOCAL("Original Estimate Local"),
    ORIGINALESTIMATEREVISIONLOCAL("Original Estimate Revision Local"),
    ORIGINALESTIMATEREVISIONLOCALWITHSPACE("OriginalEstimateRevision Local"),
    ORIGINALESTIMATEREVISION("Original Estimate Revision"),
    FIRSTPRESENTATION("First Presentation"),
    FIRSTPRESENTATIONLOCAL("First Presentation Local"),
    FIRSTPRESENTATIONREVISION("First Presentation Revision"),
    FIRSTPRESENTATIONREVISIONLOCAL("First Presentation Revision Local"),
    FIRSTPRESENTATIONREVISIONLOCALWITHSPACE("FirstPresentationRevision Local"),
    FIRSTPRESENTATIONREVISIONWITHOUTANYSPACE("FirstPresentationRevision"),
    FINALACTUALLOCAL("Final Actual Local"),
    FINALACTUAL("Final Actual"),
    FINALACTUALLOCALWITHOUTSPACE("FinalActual Local"),
    FINALACTUALWITHOUTSPACE("FinalActual"),
    CURRENTREVISIONLOCAL("Current Revision Local"),
    CURRENTREVISION("Current Revision");

    private String costStages;

    CostStages(String costStages) {
        this.costStages = costStages;
    }

    @Override
    public String toString() {
        return costStages;
    }

    public static CostStages findByType(String type) {
        for (CostStages costStages: values())
            if (costStages.toString().equals(type))
                return costStages;
        throw new IllegalArgumentException("Unknown Cost Stage type: " + type);
    }
}
