package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.UpdateCostForm;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsNegotiatedTermsPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

/**
 * Created by Raja.Gone on 17/05/2017.
 */
public class AdCostsNegotiatedTermsSteps extends AdCostsHelperSteps {

    protected AdCostsNegotiatedTermsPage openAdCostsNegotiatedTermsPage() {
        AdCostsNegotiatedTermsPage negotiatedTermsPage = getSut().getPageCreator().getAdCostsNegotiatedTermsPage();
        if (negotiatedTermsPage.waitUntilNegotiatedTermsPageVisible())
            return new AdCostsNegotiatedTermsPage(getSut().getWebDriver());
        else
            throw new Error("Unable to open Negotiated-Terms page");
    }

    @Given("{I |}filled for '$costType' costType on negotiated terms page with following fields: $data")
    @When("{I |}fill for '$costType' costType on negotiated terms page with following fields: $data")
    public void fillBuyoutUsageDetailsThrowUI(String costType, ExamplesTable data) {
        openAdCostsNegotiatedTermsPage();
        fillNegotiatedTermsDetails(data);
        clickButtonName("Continue");
    }

    @Given("{I |}filled for UsageBuyout cost on negotiated terms page with following fields: $data")
    @When("{I |}fill for UsageBuyout cost on negotiated terms page with following fields: $data")
    public void filNegotiatedTermsThroughUI(ExamplesTable data) {
         fillNegotiatedTermsDetailsViaUI(data).clickBtnByName("Continue");
    }

    @Given("{I am |}on '$costType' costType negotiated terms page")
    @When("{I |}go to '$costType' costType negotiated terms page")
    @Alias("{I |}open '$costType' costType negotiated terms page")
    public AdCostsNegotiatedTermsPage openUsageBuyoutDetailsPage() {
        return openAdCostsNegotiatedTermsPage();
    }

    @Given("{I |}filled following fields on negotiated terms page: $data")
    @When("{I |}fill following fields on negotiated terms page: $data")
    @Alias("{I |}update following fields on negotiated terms page: $data")
    public void fillNegotiatedTermsDetails(ExamplesTable data) {
        AdCostsNegotiatedTermsPage negotiatedTermsPage = getSut().getPageNavigator().getAdCostsNegotiatedTermsPage();
        for (MetadataItem row : wrapMetadataFields_Adcost(data, "FieldName", "FieldValue")) {
            negotiatedTermsPage.fillFieldByName(row.getKey(), row.getValue());
        }
    }

    public AdCostsNegotiatedTermsPage fillNegotiatedTermsDetailsViaUI(ExamplesTable data) {
        AdCostsNegotiatedTermsPage negotiatedTermsPage = openAdCostsNegotiatedTermsPage();
        Map<String, String> row = parametrizeTabularRow(data);

        if (AdCostsData.containsField(AdCostsSchemaField.PRODUCEDASSET, row, false))
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PRODUCEDASSET), AdCostsData.getField(AdCostsSchemaField.PRODUCEDASSET, row));
        if (AdCostsData.containsField(AdCostsSchemaField.MAKEUPARTIST, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MAKEUPARTIST), AdCostsData.getField(AdCostsSchemaField.MAKEUPARTIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.HAIRSTYLIST, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.HAIRSTYLIST), AdCostsData.getField(AdCostsSchemaField.HAIRSTYLIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.NAILARTIST, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NAILARTIST), AdCostsData.getField(AdCostsSchemaField.NAILARTIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.WARDROBEARTIST, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.WARDROBEARTIST), AdCostsData.getField(AdCostsSchemaField.WARDROBEARTIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.CELEBRITY, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CELEBRITY), AdCostsData.getField(AdCostsSchemaField.CELEBRITY, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MANAGER, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MANAGER), AdCostsData.getField(AdCostsSchemaField.MANAGER, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.GLAMSQUAD, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.GLAMSQUAD), AdCostsData.getField(AdCostsSchemaField.GLAMSQUAD, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.SECURITY, row, false)) {
            negotiatedTermsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SECURITY), AdCostsData.getField(AdCostsSchemaField.SECURITY, row));
        }
        return negotiatedTermsPage;
    }

    @Given("{I |}added negotiated terms page for cost title '$costTitle' with following fields: $data")
    @When("{I |}add negotiated terms page for cost title '$costTitle' with following fields: $data")
    public void addNegitiatedTermaSectionviaCore(String costTitle, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        UpdateCostForm details = new UpdateCostForm();

        String formDefinitionId = getFormDefinitionId("Buyout", "Negotiated Terms");
        details.setFormDefinitionId(formDefinitionId);

        if (AdCostsData.containsField(AdCostsSchemaField.PRODUCEDASSET, row, false))
            details.getCostFormDetails().getData().setProducedAsset(AdCostsData.getField(AdCostsSchemaField.PRODUCEDASSET, row));
        if (AdCostsData.containsField(AdCostsSchemaField.MAKEUPARTIST, row, false)) {
            details.getCostFormDetails().getData().getTalentDecisionRights().setMakeupArtist(AdCostsData.getField(AdCostsSchemaField.MAKEUPARTIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.HAIRSTYLIST, row, false)) {
            details.getCostFormDetails().getData().getTalentDecisionRights().setHairStylist(AdCostsData.getField(AdCostsSchemaField.HAIRSTYLIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.NAILARTIST, row, false)) {
            details.getCostFormDetails().getData().getTalentDecisionRights().setNailArtist( AdCostsData.getField(AdCostsSchemaField.NAILARTIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.WARDROBEARTIST, row, false)) {
            details.getCostFormDetails().getData().getTalentDecisionRights().setWardrobeArtist(AdCostsData.getField(AdCostsSchemaField.WARDROBEARTIST, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.CELEBRITY, row, false)) {
            details.getCostFormDetails().getData().getEntourageTravel().setCelebrity(AdCostsData.getField(AdCostsSchemaField.CELEBRITY, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MANAGER, row, false)) {
            details.getCostFormDetails().getData().getEntourageTravel().setManager(AdCostsData.getField(AdCostsSchemaField.MANAGER, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.GLAMSQUAD, row, false)) {
            details.getCostFormDetails().getData().getEntourageTravel().setGlamSquad(AdCostsData.getField(AdCostsSchemaField.GLAMSQUAD, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.SECURITY, row, false)) {
            details.getCostFormDetails().getData().getEntourageTravel().setSecurity(AdCostsData.getField(AdCostsSchemaField.SECURITY, row));
        }

        getAdcostApi().createNegotiatedTerms(details, getCostId(wrapVariableWithTestSession(costTitle)));


    }
}
