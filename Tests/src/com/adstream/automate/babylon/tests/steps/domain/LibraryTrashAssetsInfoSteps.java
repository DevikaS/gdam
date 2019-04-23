package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryTrashAssetsInfoPage;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


public class LibraryTrashAssetsInfoSteps extends LibrarySteps {

    @When("{I |}restore asset from library trash on opened asset details page")
    public void restoreAsset() {
        AdbankLibraryTrashAssetsInfoPage page = getSut().getPageCreator().getLibraryTrashAssetsInfoPage();
        page.clickMoreButton();
        page.clickRestoreButton().action.click();
    }

    @Then("{I |}'$condition' see edit link on removed asset details page")
    public void checkThatEditButtonPresent(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryTrashAssetsInfoPage().isEditLinkPresent();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' be able to play clip on removed asset details page")
    public void checkThatPlayerAvailable(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryTrashAssetsInfoPage().isPlayerAvailable();
        assertThat(actualState, is(expectedState));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields on opened deleted asset info page: $data")
    public void checkAssetInformation(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");
        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (MetadataItem expectedField : expectedFields)
            assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    // | SectionName | FieldName | FieldValue |
    // SectionName - is not required
    @Then("{I |}'$condition' see following '$fieldsType' fields in the following order on opened deleted asset info page: $data")
    public void checkAssetInformationOrderedAndPresented(String condition, String fieldsType, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> expectedFields = wrapMetadataFields(data, "FieldName", "FieldValue");
        List<MetadataItem> actualFields = getActualFileInfoFields(fieldsType);

        if (!data.getHeaders().contains("SectionName"))
            for (MetadataItem field : actualFields) field.setSection(null);

        for (int i = 0; i < expectedFields.size(); i++)
            assertThat(actualFields.get(i), shouldState ? equalTo(expectedFields.get(i)) : not(equalTo(expectedFields.get(i))));
    }

    private List<MetadataItem> getActualFileInfoFields(String fieldsType) {
        if (fieldsType.equalsIgnoreCase("asset information")) {
            return getSut().getPageCreator().getLibraryTrashAssetsInfoPage().getAssetInformationFields();
        } else if (fieldsType.equalsIgnoreCase("custom metadata")) {
            return getSut().getPageCreator().getLibraryTrashAssetsInfoPage().getCustomMetadataFields();
        } else if (fieldsType.equalsIgnoreCase("specification")) {
            return getSut().getPageCreator().getLibraryTrashAssetsInfoPage().getSpecificationFields();
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type given: '%s'", fieldsType));
        }
    }
}