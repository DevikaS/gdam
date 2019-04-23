package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibChangeMediaPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditFilePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibWorkRequestPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.utils.Common;
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
 * Created by Janaki.Kamat on 14/06/2017.
 */
public class LibWorkRequestPopupSteps extends LibraryHelperSteps{


    @Given("{I |}clicked Add to Work Request button on '$collection' library page")
    @When("{I |}click Add to Work Request button on '$collection' library page")
    public LibWorkRequestPopup openWorkFlowRequest(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickNewWorkRequestButton();
    }

    @Then("{I |}'$condition' be on the Create New Work Request popup on '$collection' pageNEWLIB")
    public void checkThatWorkFlowReqestPopupIsOpened(String condition,String collection) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            LibWorkRequestPopup libWorkRequestPopup = new LibWorkRequestPopup(getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection)));
        } catch (Exception e) {
            actualState = false;
        } finally {
            assertThat(actualState, is(expectedState));
        }
    }

  @Then("{I |}'$condition' see metadata field '$fieldNames' marked as required on New Worflow Request popup on '$collection' page")
    public void checkThatMetadataFieldMarkedAsRequiredOnNewProjectPopup(String condition, String fieldNames,String collection) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList =(new LibWorkRequestPopup(getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection)))).getRequiredFieldsNames();

        for (String expectedFieldName : fieldNames.split(","))
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFieldName) : not(hasItem(expectedFieldName)));
    }


    @Given("{I |}filled following fields on Create New Work Request popup on '$collection' pageNEWLIB:$data")
    @When("{I |}fill following fields on Create New Work Request popup on '$collection' pagNEWLIB:$data")
    public void fillPopupFields(String collection,ExamplesTable data) {
        LibWorkRequestPopup libWorkRequestPopup=new LibWorkRequestPopup(getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection)));
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (asList("Start date", "End date").contains(row.getKey())) {
                DateTime dataTime = parseDateTime(row.getValue(), TestsContext.getInstance().storiesDateTimeFormat);
                row.setValue(dataTime.toString("MM/dd/yy").replaceFirst("^0+(?!$)", ""));
            }
            libWorkRequestPopup.fillWorkRequestByName(row.getKey(),"Work request project administrators".contains(row.getKey())?wrapUserEmailWithTestSession(row.getValue()) :row.getValue());
        }
       libWorkRequestPopup.clickSave();
    }


    @Then("{I |}'$condition' see following fields with value on work request popup from collection '$collectionName'NEWLIB: $data")
    public void checkFieldsValuesOnEditAssetPopupNewLib(String condition,String collectionName, ExamplesTable data) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean shouldState = condition.equalsIgnoreCase("should");
        page.openPopup().clickNewWorkRequestButton();
        LibWorkRequestPopup libWorkRequestPopup=new LibWorkRequestPopup(page);
        String actualValue="";
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
                String expectValue=wrapVariableWithTestSession(row.get("FieldValue"));
                actualValue = libWorkRequestPopup.verifyMetadataOnWorkRequestAssetPopup(row.get("FieldName"));
                   assertThat(actualValue, shouldState ? equalTo(expectValue.trim()) : not(equalTo(expectValue.trim())));



        }

    }


     }






