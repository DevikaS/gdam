package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.admin.agency.*;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.EditAgencyPopup;
import com.adstream.automate.babylon.sut.pages.admin.branding.AdminLoginPage;
import com.adstream.automate.babylon.sut.pages.admin.branding.AdminSystemBrandingPage;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: Devika Subramanian
 * Date: 15.02.16
 * Time:
 */
public class AgencyMarketPageSteps extends BaseStep {

    private AgencyMarketPage getAgencyMarketPage() {
        return getSut().getPageCreator().getAgencyMarketPage();
    }

    @Given("{I am |}on agency '$agencyName' market page")
    @When("{I |}go to agency '$agencyName' market page")
    public AgencyMarketPage openAgencyMarketPage(Agency agency) {
        return getSut().getPageNavigator().getAgencyMarketPage(agency.getId());
    }

    @Given("{I am |}on agency '$agencyName' create market page")
    @When("{I |}go to agency '$agencyName' create market page")
    public AgencyCreateMarketPage openAgencyCreateMarketPage(Agency agency) {
        return getSut().getPageNavigator().getAgencyCreateMarketPage(agency.getId());
    }

    @Given("{I am |}on agency '$agencyName' destination page")
    @When("{I |}go to agency '$agencyName' destination page")
    public DestinationPage openDestinationPage(Agency agency) {
        return getSut().getPageNavigator().getDestinationPage(agency.getId());
    }

    @Given("{I |} create custom '$customMarket' market")
    @When("{I |} create custom '$customMarket' market")
    public void createCustomMarket(String customMarket){
        AgencyCreateMarketPage page = getSut().getPageCreator().getAgencyCreateMarketPage();
        page.createCustomMarket(customMarket);
    }

    @Given("{I |} edit custom '$editcustomMarket' market details")
    @When("{I |} edit custom '$editcustomMarket' market details")
    public void editCustomMarket(String editcustomMarket){
        AgencyEditMarketPage page = getSut().getPageCreator().getAgencyEditMarketPage();
        page.editCustomMarkeName(editcustomMarket);
    }

    @Given("{I |} add destination group to custom market")
    @When("{I |} add destination group to custom market")
    public void addDestinationGroupToMarket(){
        AgencyEditMarketPage page = getSut().getPageCreator().getAgencyEditMarketPage();
        page.addDestinationGroup();

    }

    @Given("{I |} select the meta market '$metaMarket' on edit market page")
    @When("{I |} select the meta market '$metaMarket' on edit market page")
    public void selectMetaMarketOnEditMarketPage(String metaMarket){
        AgencyEditMarketPage page = getSut().getPageCreator().getAgencyEditMarketPage();
        page.selectMetaMarket(metaMarket);

    }

    @Given("{I |} select the default market '$defaultMarket' on edit market page")
    @When("{I |} select the default market '$defaultMarket' on edit market page")
    public void selectDefaultMarketOnEditMarketPage(String defaultMarket){
        AgencyEditMarketPage page = getSut().getPageCreator().getAgencyEditMarketPage();
        page.selectDefaultMarket(defaultMarket);

    }

    @Given("{I |} click on save button on edit market page")
    @When("{I |} click on save button on edit market page")
    public void clickSaveOnEditMarketPage(){
        AgencyEditMarketPage page = getSut().getPageCreator().getAgencyEditMarketPage();
        page.clickSave();

    }

    @Given("{I |} click on custom '$customMarket' market")
    @When("{I |} click on custom '$customMarket' market")
    public void clickCustomMarket(String customMarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        page.clickCustomMarket(customMarket);
    }

    @Given("{I |} delete the custom market")
    @When("{I |} delete the custom market")
    public void deleteCustomMarket( ){
        AgencyEditMarketPage page = getSut().getPageCreator().getAgencyEditMarketPage();
        AgencyDeleteMarketPopUpWindow deleteCustomMarketPopUpWindow = page.deleteCustomMarket();
        deleteCustomMarketPopUpWindow.clickAction();
    }

    @Given("{I |} select the market '$market' from dropdown on destination page")
    @When("{I |} select the market '$market' on destination page")
    public void selectMarketFromList(String market ){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
        page.selectMarkets(market);

    }

    @Given("{I |} select the default market '$market' on destination page")
    @When("{I |} select the default market '$market' on destination page")
    public void selectDefaultMarket(String market ){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
        page.selectDefaultMarket(market);

    }

    @Given("{I |} select the meta market '$market' on destination page")
    @When("{I |} select the meta market '$market' on destination page")
    public void selectMetaMarket(String market ){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
        page.selectMetaMarket(market);

    }

    @Then("{I |} should see the destination groups for the market on destination page")
    public void checkDestinationGroupsForMarket(){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
      int cnt = page.checkDestinationGroupsForMarket();

    }

    @Then("{I |} should see the group of markets '$markets' displayed on destination page")
    public void getGroupOfMarkets(String markets ){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
        List<String> listOfMarkets = page.getMarkets();
        for (String type: markets.split(","))
        {

            assertThat("Check list of Markets: " + type, listOfMarkets, hasItem(type));
        }

    }

    @Then("{I |}'$should' see default market on destination page")
    public void checkDefaultMarketOnDestination(String condition){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        int countOfdefaultMarkets = page.getCountOfDefaultmarkets();
        String defaultMarkets = Integer.toString(countOfdefaultMarkets);
        assertThat("0",shouldState ? not(is(equalToIgnoringWhiteSpace(defaultMarkets))) : is(equalToIgnoringWhiteSpace(defaultMarkets)));
    }

    @Then("{I |}'$should' see meta market on destination page")
    public void checkMetaMarketOnDestination(String condition){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        int countOfMetaMarkets = page.getCountOfMetamarkets();
        String metaMarkets = Integer.toString(countOfMetaMarkets);
        assertThat("0",shouldState ? not(is(equalToIgnoringWhiteSpace(metaMarkets))) : is(equalToIgnoringWhiteSpace(metaMarkets)));
    }


    @Then("{I |}'$should' see default market '$market' on market page")
    public void checkDefaultMarketIsDisplayed(String condition,String defaultMarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean expectedStateForDefaultMarket = page.checkdefaultMarketDisplayed(defaultMarket);
        assertThat(true, shouldState ? equalTo(expectedStateForDefaultMarket) : not(expectedStateForDefaultMarket));

    }
    @Then("{I |}'$should' see the following markets on market page: $fieldsTable")
    public void checkMarketsOnMarketPage(String condition,ExamplesTable fieldsTable){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fieldsTable, i);
            if (parameters.get("Type").contains("meta")) {
                boolean expectedStateForMetaMarket = page.checkMetaMarketDisplayed(parameters.get("Market"));
                assertThat(true, shouldState ? equalTo(expectedStateForMetaMarket) : not(expectedStateForMetaMarket));
            }
            else if(parameters.get("Type").contains("default"))
            {
                boolean expectedStateForDefaultMarket = page.checkdefaultMarketDisplayed(parameters.get("Market"));
                assertThat(true, shouldState ? equalTo(expectedStateForDefaultMarket) : not(expectedStateForDefaultMarket));
            }
        }
    }

    @Then("{I |}'$should' see meta market '$market' on market page")
    public void checkMetaMarketIsDisplayed(String condition,String metamarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean expectedStateForMetaMarket = page.checkMetaMarketDisplayed(metamarket);
        assertThat(true, shouldState ? equalTo(expectedStateForMetaMarket) : not(expectedStateForMetaMarket));

    }

    @Given("{I |}'$should' see custom market '$customMarket' on market page")
    @When("{I |}'$should' see custom market '$customMarket' on market page")
    @Then("{I |}'$should' see custom market '$customMarket' on market page")
    public void checkCustomMarketIsDisplayed(String condition,String customMarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualCustomMarket = page.checkCustomMarketIsDisplayed(customMarket);
        String actualMarket = actualCustomMarket.substring(2);
        assertThat(actualMarket, shouldState ? is(equalToIgnoringWhiteSpace(customMarket)) : not(is(equalToIgnoringWhiteSpace(customMarket))));

    }

    @Given("{I |} hide the custom '$customMarket' market on market page")
    @When("{I |} hide the custom '$customMarket' market on market page")
    public void hideCustomMarket(String customMarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        page.hideCustomMarket(customMarket);

    }

    @Given("{I |} hide the meta '$metaMarket' market on market page")
    @When("{I |} hide the meta '$metaMarket' market on market page")
    public void hideMetaMarket(String metaMarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        page.hideMetaMarket(metaMarket);

    }

    @Given("{I |} hide the default '$defaultMarket' market on market page")
    @When("{I |} hide the default '$defaultMarket' market on market page")
    public void hideDefaultMarket(String defaultMarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        page.hideDefaultMarket(defaultMarket);

    }

    @Then("{I |} should see the custom market '$customMarket' deleted on market page")
    public void deleteCustomMarket(String customMarket){
        AgencyMarketPage page = getSut().getPageCreator().getAgencyMarketPage();
        boolean isDeleted = page.checkCustomMarketIsDeleted(customMarket);
        assertThat(false, equalTo(isDeleted));
    }

    @Then("{I |} should see the destination groups added for custom market on edit market page")
    public void checkDestinationGroupsAddedForCustomMarket(){
        AgencyEditMarketPage page = getSut().getPageCreator().getAgencyEditMarketPage();
        boolean isDislplayed = page.checkDestinationGroupsAddedForCustomMarket();
        assertThat(true, equalTo(isDislplayed));
    }

    @Then("{I |}'$should' see the following markets on destination page: $fieldsTable")
    public void checkMarketsOnDestinationPage(String condition,ExamplesTable fieldsTable){
        DestinationPage page = getSut().getPageCreator().getDestinationPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fieldsTable, i);
            if (parameters.get("Type").contains("meta")) {
                int countOfMetaMarkets = page.getCountOfMetamarkets();
                String metaMarkets = Integer.toString(countOfMetaMarkets);
                assertThat("0",shouldState ? not(is(equalToIgnoringWhiteSpace(metaMarkets))) : is(equalToIgnoringWhiteSpace(metaMarkets)));
            }
            else if(parameters.get("Type").contains("default"))
            {
                int countOfdefaultMarkets = page.getCountOfDefaultmarkets();
                String defaultMarkets = Integer.toString(countOfdefaultMarkets);
                assertThat("0",shouldState ? not(is(equalToIgnoringWhiteSpace(defaultMarkets))) : is(equalToIgnoringWhiteSpace(defaultMarkets)));
            }
        }
    }


}
