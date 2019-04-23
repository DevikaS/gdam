package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsLayoutPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 02.11.12
 * Time: 15:16

 */
public class LibraryPresentationsLayoutSteps extends LibraryPresentationsSteps {
    public AdbankLibraryPresentationsLayoutPage getLibraryPresentationsPage() {
        return getSut().getPageCreator().getLibraryPresentationsLayoutPage();
    }

    public AdbankLibraryPresentationsLayoutPage getLibraryPresentationsPage(String presentationId) {
        return getSut().getPageNavigator().getLibraryPresentationsLayoutPage(presentationId);
    }

    @Given("I am on the presentation '$presentationName' layout page")
    @When("{I |}go to the presentation '$presentationName' layout page")
    public AdbankLibraryPresentationsLayoutPage openPresentationsLayoutPage(String presentationName) {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getLibraryPresentationsLayoutPage(getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId());
    }

    @When("I click check box '$name' with metadata for current presentation layout page")
    public void clickSuitableCheckBox(String name) {
        getSut().getPageCreator().getLibraryPresentationsLayoutPage().clickMetaDataCheckBox(name);
    }

    @When("I click cancel button on the current presentation layout page")
    public void clickCancelOnThePresentationLayoutPage() {
        getSut().getPageCreator().getLibraryPresentationsLayoutPage().clickCancelButton();
    }

    @When("I save current presentation layout")
    public void saveCurrentPresentationLayout() {
        AdbankLibraryPresentationsLayoutPage libraryPresentationsLayoutPage = getSut().getPageCreator().getLibraryPresentationsLayoutPage();
        libraryPresentationsLayoutPage.clickSaveButton();
    }

    @When("I click preview presentation link for current presentation layout")
    public void clickPreviewLink() {
        AdbankLibraryPresentationsLayoutPage libraryPresentationsLayoutPage = getSut().getPageCreator().getLibraryPresentationsLayoutPage();
        libraryPresentationsLayoutPage.clickPreviewPresentationLink();
        System.out.println();
    }

    @When("I click element '$elementName' on the current layout presentation page")
    public void clickElementByName(String elementName) {
        AdbankLibraryPresentationsLayoutPage libraryPresentationsLayoutPage = getSut().getPageCreator().getLibraryPresentationsLayoutPage();
        if (elementName.startsWith("CB_")) libraryPresentationsLayoutPage.clickMetaDataCheckBox(elementName.replaceAll("CB_", ""));
        else if (elementName.startsWith("RB_")) {
            libraryPresentationsLayoutPage.clickTypeOfShow(elementName.replaceAll("RB_", ""));
        }
    }

    @When("I set metadata '$fieldName' in the state '$state'")
    public void setMetadatIntoState(String fieldName, String state) {
        AdbankLibraryPresentationsLayoutPage libraryPresentationsLayoutPage = getSut().getPageCreator().getLibraryPresentationsLayoutPage();
        for (String field: fieldName.split(",")) {
            libraryPresentationsLayoutPage.setMetaDateCheckBoxInRequiredState(field, state);
        }
    }

    @When("I set following reel view for current presentation '$viewType'")
    public void setReelsView(String viewType) {
        AdbankLibraryPresentationsLayoutPage libraryPresentationsLayoutPage = getSut().getPageCreator().getLibraryPresentationsLayoutPage();
        if (viewType.equalsIgnoreCase("slider")) libraryPresentationsLayoutPage.clickTypeOfShow("slider");
        else if (viewType.equalsIgnoreCase("horizontal")) {
            libraryPresentationsLayoutPage.clickTypeOfShow("classic");
            libraryPresentationsLayoutPage.clickThumbnailViewHorizontal();
        }
        else if (viewType.equalsIgnoreCase("grid")) {
            libraryPresentationsLayoutPage.clickTypeOfShow("classic");
            libraryPresentationsLayoutPage.clickThumbnailViewGrid();
        }
        else Assert.fail("Parameter viewType is incorrect");
    }

    @When("{I |}select following fields in section '$sectionName' for agency '$agency' on presentation '$presentationName' layout tab: $data")
    public void selectMetadataFields(String sectionName, Agency agency, String presentationName, ExamplesTable data) {
        AdbankLibraryPresentationsLayoutPage page = openPresentationsLayoutPage(presentationName);
        for (Map<String,String> row : parametrizeTableRows(data))
            page.selectCustomMetadataField(agency.getName(), sectionName, row.get("FieldName"));
        page.clickSaveButton();
       // page.clickSaveButton();
        Common.sleep(3000);
    }

    @Then("I should see presentation '$presentationName' assets url")
    public void checkPresentationAssetsUrl(String presentationName){
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        assertThat(getSut().getWebDriver().getCurrentUrl(), containsString("presentations/".concat(presentationId).concat("/assets")));
    }

    // | Element | State |
    @Then("I should see Layout tab for current presentation with the following settings: $layoutTable")
    public void checkLayoutTab(ExamplesTable layoutTable) {
        AdbankLibraryPresentationsLayoutPage libraryPresentationsLayoutPage = getSut().getPageCreator().getLibraryPresentationsLayoutPage();
        for (int i = 0; i < layoutTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(layoutTable, i);
            if (row.get("Element")!=null && !row.get("Element").isEmpty()) {
                boolean shouldState = (row.get("State") != null && !row.get("State").isEmpty()) && (row.get("State").equalsIgnoreCase("checked") || (row.get("State").equalsIgnoreCase("selected")));
                if (row.get("Element").startsWith("CB_")) {
                    assertThat(libraryPresentationsLayoutPage.isMetaDataCheckBoxChecked(row.get("Element").replaceAll("CB_", "")), equalTo(shouldState));
                }
                if (row.get("Element").startsWith("RB_")) {
                    assertThat(libraryPresentationsLayoutPage.isTypeOfShowRBSelected(row.get("Element").replaceAll("RB_", "")), equalTo(shouldState));
                }
            }
        }
    }

    // | FieldName |
    @Then("{I |}'$condition' see following fields in section '$sectionName' for agency '$agency' on presentation '$presentationName' layout tab: $data")
    public void checkMetadataFields(String condition, String sectionName, Agency agency, String presentationName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList = openPresentationsLayoutPage(presentationName).getCustomMetadataFieldsList(agency.getName(), sectionName);

        for (Map<String,String> row : parametrizeTableRows(data)) {
            String expectedField = row.get("FieldName");
            assertThat(actualFieldsList, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }
}