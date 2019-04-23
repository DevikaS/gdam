package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.Costs;
import com.adstream.automate.babylon.JsonObjects.adcost.ExpectedAssets;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsAssociatedAssetsPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;
import static org.hamcrest.core.IsNot.not;

/**
 * Created by Raja.Gone on 12/01/2018.
 */
public class AdCostsAssociatedAssetsSteps extends AdCostsHelperSteps {


    protected String buildCostPageURL(String costTitle){
        String costId = getCostId(costTitle);
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId,costStageId);
        StringBuilder urlBuilder = new StringBuilder();
        urlBuilder.append("costId=").append(costId).append("&revisionId=").append(costRevisionId);
        return urlBuilder.toString();
    }

    @Given("{I am} on Associated Assets page of cost title '$costTitle'")
    @When("{I am} on Associated Assets page of cost title '$costTitle'")
    public AdCostsAssociatedAssetsPage openAssociatedAssetsPage(String costTitle) {
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId,costStageId);

        return getSut().getPageNavigator().getAdCostsAssociatedAssets(costId,costRevisionId);
    }

    @When("{I |}link following adId of an existing assets for cost title '$costTitle':$data")
    public void linkAdIdOfAnExpectedAsset(String costTitle,ExamplesTable data) {
        AdCostsAssociatedAssetsPage associatedAssetsPage = getSut().getPageCreator().getAdCostsAssociatedAssetsPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Cost Title")) {
                Costs costs = getCostDetails(wrapVariableWithTestSession(row.get("Cost Title")));
                String costId = costs.getId();
                String costStageId = getCostStageId(costId);
                String costRevisionId = getCostRevisionId(costId, costStageId);
                ExpectedAssets[] assets = getAdcostApi().getExpectedAssets(costId, costStageId, costRevisionId);
                for (ExpectedAssets asset : assets) {
                    if (asset.getTitle().equals(wrapVariableWithTestSession(row.get("Asset Title")))) {
                        associatedAssetsPage.searchAdId(asset.getAdId());
                        associatedAssetsPage.clickAdd();
                        Common.sleep(1000); // slow-down linking assets process
                    }
                }
            }
        }
    }

    // Pass 'Cost title' for 'Ad-ID' & 'Associated Cost' fields
    @Then("{I |}'$should' see following data added to Associated Assets section: $data")
    public void checkDataInAssociatedAssetsSection(String condition, ExamplesTable data) {
        AdCostsAssociatedAssetsPage associatedAssetsPage = getSut().getPageCreator().getAdCostsAssociatedAssetsPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Ad-ID")) {
                Costs costs = getCostDetails(wrapVariableWithTestSession(row.get("Ad-ID")));
                String costId = costs.getId();
                String costStageId = getCostStageId(costId);
                String costRevisionId = getCostRevisionId(costId, costStageId);
                ExpectedAssets[] assets = getAdcostApi().getExpectedAssets(costId, costStageId, costRevisionId);
                for (ExpectedAssets asset : assets) {
                   if (asset.getTitle().equals(wrapVariableWithTestSession(row.get("Asset name")))) {
                        AdCostsAssociatedAssetsPage.LinkedExpectedAssets linkedExpectedAssets = associatedAssetsPage.getLinkedExpectedAssetsSection();
                        linkedExpectedAssets.loadData(i);
                        assertThat(linkedExpectedAssets.getAdID(), condition.equals("should") ? is(asset.getAdId()) : not(is(asset.getAdId())));
                        if (row.containsKey("Asset name"))
                            assertThat(linkedExpectedAssets.getAssetName(), condition.equals("should") ? is(wrapVariableWithTestSession(row.get("Asset name"))) : not(is(wrapVariableWithTestSession(row.get("Asset name")))));
                       if (row.containsKey("Initiative"))
                                assertThat(linkedExpectedAssets.getInitiative(), condition.equals("should") ? is(row.get("Initiative")) : not(is(row.get("Initiative"))));
                        if (row.containsKey("Associated Cost"))
                            assertThat(linkedExpectedAssets.getAssociatedCost(), condition.equals("should") ? is(costs.getCostNumber()) : not(is(costs.getCostNumber())));
                    }
                }
            }
        }
    }

    @When("{I |}click associated cost link of asset name '$assetName' for cost title '$costTitle'")
    public void clickAssociatedCostLink(String assetName,String costTitle){
        AdCostsAssociatedAssetsPage associatedAssetsPage = getSut().getPageCreator().getAdCostsAssociatedAssetsPage();
        AdCostsAssociatedAssetsPage.LinkedExpectedAssets linkedExpectedAssets = associatedAssetsPage.getLinkedExpectedAssetsSection();
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        linkedExpectedAssets.selectAssociatedCost(costs.getCostNumber(),wrapVariableWithTestSession(assetName));
    }

    @Then("{I |}'$should' see associated cost opens in a new {tab|window} for cost title '$costTitle'")
    public void checkAssociatedCostOpening(String condition,String costTitle){
        AdCostsAssociatedAssetsPage associatedAssetsPage = getSut().getPageCreator().getAdCostsAssociatedAssetsPage();
        AdCostsAssociatedAssetsPage.LinkedExpectedAssets linkedExpectedAssets = associatedAssetsPage.getLinkedExpectedAssetsSection();
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        String costId = costs.getId();
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId, costStageId);
        String expectedURL = String.format(getContext().applicationUrl+"/costs/#/costs/items/forms/cost-details?costId=%s&revisionId=%s",costId,costRevisionId);
        assertThat(linkedExpectedAssets.isCostDetailsPageLoaded(expectedURL),condition.equals("should")?is(expectedURL):not(is(expectedURL)));
    }

    @Then("{I |}'$should' see linked assets count as '$count'")
    public void checkLinkedAssetsCount(String condition, String count){
        AdCostsAssociatedAssetsPage associatedAssetsPage = getSut().getPageCreator().getAdCostsAssociatedAssetsPage();
        AdCostsAssociatedAssetsPage.LinkedExpectedAssets linkedExpectedAssets = associatedAssetsPage.getLinkedExpectedAssetsSection();
        assertThat(Integer.toString(linkedExpectedAssets.getLinkedAssetsCount()),condition.equals("should")?is(count):not(is(count)));
    }

    @When("{I |}delete linked adid of asset name '$assetName' for cost title '$costTitle'")
    public void deleteLinkedAsset(String assetName, String costTitle){
        AdCostsAssociatedAssetsPage associatedAssetsPage = getSut().getPageCreator().getAdCostsAssociatedAssetsPage();
        AdCostsAssociatedAssetsPage.LinkedExpectedAssets linkedExpectedAssets = associatedAssetsPage.getLinkedExpectedAssetsSection();
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        linkedExpectedAssets.deleteAssociatedCost(costs.getCostNumber(),wrapVariableWithTestSession(assetName));
    }

    @Then("{I |}'$should' see error message as '$message'")
    public void checkErrorMessage(String condition, String message){
        AdCostsAssociatedAssetsPage associatedAssetsPage = getSut().getPageCreator().getAdCostsAssociatedAssetsPage();
        AdCostsAssociatedAssetsPage.LinkedExpectedAssets linkedExpectedAssets = associatedAssetsPage.getLinkedExpectedAssetsSection();
        assertThat(linkedExpectedAssets.getErrorMessage(),condition.equals("should")?is(message):not(is(message)));
    }

    @Then("{I |}'$condition' see below information in downloaded Associated Assets for cost title '$costTitle':$data")
    public void checkAssociatedAssetsDownloadInfo(String condition, String costTitle, ExamplesTable data){
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        String costId = costs.getId();
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId, costStageId);
        String actual = getAdcostApi().downloadAssociatedAssets(costId,costRevisionId);

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if(row.containsKey("Initiative"))
                assertThat("Check 'Initiative': "+actual,actual.contains(row.get("Initiative")));
            if(row.containsKey("Title"))
                assertThat("Check 'Title': "+actual,actual.contains(wrapVariableWithTestSession(row.get("Title"))));
            if(row.containsKey("Duration"))
                assertThat("Check 'Duration': "+actual,actual.contains(row.get("Duration")));
            if(row.containsKey("Media Type"))
                assertThat("Check 'Media Type': "+actual,actual.contains(row.get("Media Type")));
            if(row.containsKey("O/V/A/L Type"))
                assertThat("Check 'O/V/A/L Type': "+actual,actual.contains(row.get("O/V/A/L Type")));
            if(row.containsKey("First Air Date"))
                assertThat("Check 'First Air Date': "+actual,actual.contains(row.get("First Air Date")));
            if(row.containsKey("Scrapped"))
                assertThat("Check 'Scrapped': "+actual,actual.contains(row.get("Scrapped")));
            if(row.containsKey("Airing Country/Region"))
                assertThat("Check 'Airing Country/Region': "+actual,actual.contains(row.get("Airing Country/Region")));
            if(row.containsKey("Linked Usage Cost")) {
                Costs cost = getCostDetails(wrapVariableWithTestSession(row.get("Linked Usage Cost")));
                assertThat("Check 'Linked Usage Cost': "+actual, actual.contains(cost.getCostNumber()));
            }
        }
    }
}