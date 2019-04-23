package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionDetailsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibMultiEditAssetMetadataPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/**
 * Created by Janaki.Kamat on 06/10/2017.
 */
public class LibMultiEditAssetMetadataPageSteps extends NewLibraryAssetsViewSteps {

    @When("{I |}go to edit Asset Metadata page on '$collection' collection")
    @Given("{I |}go to edit Asset Metadata page on '$collection' collection")
    public LibMultiEditAssetMetadataPage openEditAssetMetadata(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickEditAssetMetadata();
    }

    @Given("{I |}'$actioned' metadata for '$fileNames' on '$collection' edit Asset Metadata page: $data")
    @When("{I |}'$action' metadata for '$fileNames'  on '$collection'  edit Asset Metadata page: $data")
    public void editAssetMetadata(String action,String fileNames, String collection, ExamplesTable data) throws ParseException {
        LibMultiEditAssetMetadataPage editAssetMetadataPage = openEditAssetMetadata(collection);
        editAssetMetadataPage.fillEditFilePopup(wrapMetadataFieldsAssets(data, "FieldName", "FieldValue"));
        action = action.toLowerCase();
        Common.sleep(1000);
        if (action.matches("save|saved")) {
            editAssetMetadataPage.save();
        } else if (action.matches("cancel|canceled")) {
            editAssetMetadataPage.cancel();
        }/* else if (action.matches("close|closed")) {
            editAssetMetadataPage.close();
        }*/ else {
            throw new IllegalArgumentException(String.format("Unknown action '%s' for edit file popup", action));
        }
    }


    @Then ("{I |} '$condition' see following '$fieldType' fields with expected values for assetType '$assetType' on opened Edit all selected asset popupNEWLIB: $data")
    public void checkDropdownFieldsValuesWithSizeCheckNewLib(String condition, String fieldType, String assetType,ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibMultiEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        List<String> actualValues;
        List<String> expectedValues = new ArrayList<String>();
        for (MetadataItem row : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if (fieldType.equalsIgnoreCase("dropdown")) {
                actualValues = editAssetMetadataPage.getAvailableComboBoxValues(row.getKey(), assetType);

            } else {
                throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldType));
            }
            for (String expectedValue : row.getValue().split(","))
                assertThat(actualValues, shouldState ? hasItem(expectedValue) : not(hasItem(expectedValue)));
        }
    }

    @When("{I |}click Edit Icon on  edit Asset Metadata page")
    public void clickEditAssetMetadataIcon() {
        LibMultiEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        editAssetMetadataPage.clickEditLink();
    }

    @When("{I |}delete '$title' on '$collection' edit Asset Metadata page")
    public void deleteAsset(String title,String collection) {
        LibMultiEditAssetMetadataPage editAssetMetadataPage = openEditAssetMetadata(collection);
        editAssetMetadataPage.removeAsset(title);
    }

    @Then("{I |}'$condition' see '$title' on edit Asset Metadata page")
    public void checkAssetTitle(String condition,String title) {
        Boolean expected = condition.equals("should");
        LibMultiEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        List<String> titleList=editAssetMetadataPage.getTitleNames();
        for(String tit:title.split(","))
          assertThat(editAssetMetadataPage.getTitleNames(), expected ? hasItem(tit) : not(hasItem(tit)));
    }


    @Then("{I |}'$condition' see '$editMessage' message")
    public void checkEditMessage(String condition,String editMessage) {
        Boolean expected = condition.equals("should");
        LibMultiEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        assertThat(String.format("%s Edit message should be displayed",editMessage),editAssetMetadataPage.getEditMessage().equalsIgnoreCase(editMessage));
    }

    @When("{I |}click '$editMessage' message")
    public void clickEditMessage(String editMessage) {
        LibMultiEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        editAssetMetadataPage.clickEditMessage(editMessage);
    }


    @Then("{I |}'$condition' see '$sectionNames' metadata sections")
    public void checkSectionNames(String condition,String sectionNames) {
        Boolean expected = condition.equals("should");
        LibMultiEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        List<String> names=editAssetMetadataPage.getSectionNames();
        for(String section:sectionNames.split(","))
            assertThat(names, expected ? hasItem(section.toUpperCase()) : not(hasItem(section)));
    }


    @Then("{I |}'$condition' see '$sectionNames' metadata section expanded")
    public void checkSectionExapnded(String condition,String sectionNames) {
        Boolean expected = condition.equals("should");
        LibMultiEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        List<String> names=editAssetMetadataPage.getSectionNames();
        for(String section:sectionNames.split(","))
        assertThat(String.format("%s section should be exapnded",section), expected ? editAssetMetadataPage.isSectionExpanded(section):!editAssetMetadataPage.isSectionExpanded(section));
    }

    @Then("{I |}should see below fields in Multi Edit Asset Metadata page:$data")
    public void checkLocalisationFields_MultiEdit(ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        LibMultiEditAssetMetadataPage multiEditAssetMetaDataPage = getSut().getPageCreator().getLibMultiEditAssetMetadataPage();
        if (row.containsKey("Metadata"))
            assertThat("Metadata is not localised", multiEditAssetMetaDataPage.getMetadata_Label().equalsIgnoreCase(row.get("Metadata")));
        if (row.containsKey("Product Information"))
            assertThat("Product Information is not localised", multiEditAssetMetaDataPage.getProductInfo_Label().equalsIgnoreCase(row.get("Product Information")));
        if (row.containsKey("Save and Close"))
            assertThat("Save and Close is not localised", multiEditAssetMetaDataPage.getSaveButton_Label().equalsIgnoreCase(row.get("Save and Close")));
        if (row.containsKey("Cancel"))
            assertThat("Cancel on page is not localised", multiEditAssetMetaDataPage.getCancelButton_Label().equalsIgnoreCase(row.get("Cancel")));
        if (row.containsKey("Edit Details"))
            assertThat("Edit Details on page is not localised", multiEditAssetMetaDataPage.getEditDetails_Label().equalsIgnoreCase(row.get("Edit Details")));
        if (row.containsKey("Edit One By One"))
            assertThat("Edit One By One on page is not localised", multiEditAssetMetaDataPage.getOneByOne_Label().equalsIgnoreCase(row.get("Edit One By One")));

    }
}
