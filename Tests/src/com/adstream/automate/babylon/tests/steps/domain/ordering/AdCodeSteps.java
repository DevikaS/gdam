package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.CustomMetadataField;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.DateFormat;
import com.adstream.automate.babylon.JsonObjects.schema.Schema;
import com.adstream.automate.babylon.data.CustomMetadataSchemaName;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.admin.metadata.GlobalMetadataPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.elements.MetadataFieldSettingsBlock;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AdCodeManager;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.AdCodeContainer;
import com.adstream.automate.babylon.tests.steps.domain.MetadataSteps;
import com.google.gson.Gson;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 28.06.2014.
 */
public class AdCodeSteps extends MetadataSteps {

    private AdCodeManager getAdCodeManager() {
        return getMetadataPage().getAdCodeManager();
    }

    private Map<String, String> prepareAdCodeManagerFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Code Name")) row.put("Code Name", wrapVariableWithTestSession(row.get("Code Name")));
        if (row.containsKey("Date")) row.put("Date", String.valueOf(row.get("Date").equals("should")));
        if (row.containsKey("Metadata Elements")) row.put("Metadata Elements", String.valueOf(row.get("Metadata Elements").equals("should")));
        if (row.containsKey("Free Text")) row.put("Free Text", String.valueOf(row.get("Free Text").equals("should")));
        return row;
    }

    /**
     * This method applicable only to Adcost module, where we generate PGU number for a project
     */
    @Given("{I |}created new custom code '$fieldName' of schema '$schemaName' agency '$agencyName' by following fields: $fieldsTable")
    public void createCustomCodeForAdcostModule(String fieldName, String schemaName, String agencyName, ExamplesTable fieldsTable) {
        String agencyId = getAgencyIdByName(agencyName);
        String sName = CustomMetadataSchemaName.findByName(schemaName);
        Schema schema = getSchemaByName(sName, agencyId);
        if(!new Gson().toJsonTree(schema.getCmSectionProperties("common")).toString().contains("ProjectId")) {
            Map<String, String> rowData = parametrizeTabularRow(fieldsTable);
            CustomMetadata data = schema.getCmSectionProperties("common");
            String customCodeFieldName = String.format("%s_%s", fieldName.replaceAll("[^\\w]", ""), Long.toString(DateTime.now().getMillis()));
            CustomMetadata node = data.getOrCreateNode(customCodeFieldName);
            node.put("description", customCodeFieldName);
            node.put("description", fieldName);
            node.put("include_in_all", true);
            if (rowData.containsKey("Make it compulsory") && rowData.get("Make it compulsory").equalsIgnoreCase("true"))
                node.put("required", true);
            else node.put("required", false);

            node.put("type", "custom_code");
            node.put("validate", true);

            CustomMetadata view = node.getOrCreateNode("view");
            CustomMetadata e = view.getOrCreateNode("e");
            CustomMetadata e_group = e.getOrCreateNode("group");
            e_group.put("project_common", "_default");
            CustomMetadata e_order = e.getOrCreateNode("order");
            e_order.put("project_common", Integer.parseInt("1"));
            e.put("width", Integer.parseInt("1"));
            e.put("visible", true);
            e.put("isEditable", true);

            CustomMetadata v = view.getOrCreateNode("v");
            CustomMetadata v_group = v.getOrCreateNode("group");
            v_group.put("project_common", "_default");
            CustomMetadata v_order = v.getOrCreateNode("order");
            v_order.put("project_common", Integer.parseInt("1"));
            v.put("width", Integer.parseInt("1"));
            v.put("visible", true);
            view.put("schemaName", sName.concat(".agency.").concat(agencyId));


            List<AutoGeneratePattern> autoGeneratePatterns = new ArrayList<>();
            for (int i = 0; i < fieldsTable.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
                if (row.containsKey("Name") && !row.get("Name").isEmpty()) row.put("Name", (row.get("Name")));

                List<PatternItem> patternItems = new ArrayList<>();
                if (row.containsKey("Date Format") && !row.get("Date Format").isEmpty()) {
                    CustomMetadata patternItem = new CustomMetadata();
                    patternItem.put("type", PatternItemType.DATE);
                    patternItem.put("pattern", DateFormat.findByFormat(row.get("Date Format")));
                    patternItems.add(new PatternItem(patternItem));
                }
                if (row.containsKey("Free Text") && !row.get("Free Text").isEmpty()) {
                    for (String separator : row.get("Free Text").split(";")) {
                        CustomMetadata patternItem = new CustomMetadata();
                        patternItem.put("type", PatternItemType.SEPARATOR);
                        patternItem.put("character", separator);
                        patternItems.add(new PatternItem(patternItem));
                    }
                }
                if (row.containsKey("Sequential Number") && !row.get("Sequential Number").isEmpty()) {
                    CustomMetadata patternItem = new CustomMetadata();
                    patternItem.put("type", PatternItemType.SEQUENCE);
                    patternItem.put("characters", row.get("Sequential Number"));
                    patternItems.add(new PatternItem(patternItem));
                }
                if (row.containsKey("Metadata Elements") && !row.get("Metadata Elements").isEmpty()) {
                    for (String element : row.get("Metadata Elements").split(",")) {
                        String[] elementParts = element.split(":");
                        CustomMetadata patternItem = new CustomMetadata();
                        patternItem.put("type", PatternItemType.FIELD);
                        patternItem.put("path", CustomMetadataField.findByName(elementParts[0]).getAssetCommonPath());
                        patternItem.put("number_of_characters", elementParts[1]);
                        patternItems.add(new PatternItem(patternItem));
                    }
                }
                if (!row.containsKey("Name") || !row.containsKey("Sequential Number"))
                    throw new NullPointerException("Name and Sequential Number fields are missed, but they are required!");

                CustomMetadata pattern = new CustomMetadata();
                pattern.put("items", patternItems.toArray(new PatternItem[patternItems.size()]));
                pattern.put("name", row.get("Name"));
                pattern.put("enabled", row.containsKey("Enabled") && row.get("Enabled").equals("should"));
                if (row.containsKey("Market") && !row.get("Market").isEmpty()) {
                    String[] markets = row.get("Market").split(",");
                    String[] marketKeys = new String[markets.length];
                    for (int k = 0; k < markets.length; k++)
                        marketKeys[k] = getCoreApi().getMarketKey(markets[k]);
                    pattern.put("markets", marketKeys);
                }

                autoGeneratePatterns.add(new AutoGeneratePattern(pattern));
            }
            CustomMetadata autoGen = node.getOrCreateNode("autogenerate");
            autoGen.put("index", fieldsTable.getRowCount());
            autoGen.put("patterns", autoGeneratePatterns.toArray(new AutoGeneratePattern[autoGeneratePatterns.size()]));

            updateSchemaByName(sName, agencyId, schema);
        }
    }

    /**
     *  fieldName: Clock number, Custom code, etc
     *  schemaName: common, project, audio, digital, document, image, print, video
     *  | Name | Market | Date Format | Sequential Number | Free Text | Metadata Elements | Enabled |
     */
    @Given("{I |}update custom code '$fieldName' of schema '$schemaName' agency '$agencyName' by following fields: $fieldsTable")
    public void updateCustomCode(String fieldName, String schemaName, String agencyName, ExamplesTable fieldsTable) {
        String agencyId = getAgencyIdByName(agencyName);
        String sName = CustomMetadataSchemaName.findByName(schemaName);
        Schema schema = getSchemaByName(sName, agencyId);
        List<AutoGeneratePattern> autoGeneratePatterns = new ArrayList<>();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.containsKey("Name") && !row.get("Name").isEmpty()) row.put("Name", wrapVariableWithTestSession(row.get("Name")));

            List<PatternItem> patternItems = new ArrayList<>();
            if (row.containsKey("Date Format") && !row.get("Date Format").isEmpty()) {
                CustomMetadata patternItem = new CustomMetadata();
                patternItem.put("type", PatternItemType.DATE);
                patternItem.put("pattern", DateFormat.findByFormat(row.get("Date Format")));
                patternItems.add(new PatternItem(patternItem));
            }
            if (row.containsKey("Sequential Number") && !row.get("Sequential Number").isEmpty()) {
                CustomMetadata patternItem = new CustomMetadata();
                patternItem.put("type", PatternItemType.SEQUENCE);
                patternItem.put("characters", row.get("Sequential Number"));
                patternItems.add(new PatternItem(patternItem));
            }
            if (row.containsKey("Free Text") && !row.get("Free Text").isEmpty()) {
                for (String separator : row.get("Free Text").split(";")) {
                    CustomMetadata patternItem = new CustomMetadata();
                    patternItem.put("type", PatternItemType.SEPARATOR);
                    patternItem.put("character", separator);
                    patternItems.add(new PatternItem(patternItem));
                }
            }
            if (row.containsKey("Metadata Elements") && !row.get("Metadata Elements").isEmpty()) {
                for (String element : row.get("Metadata Elements").split(",")) {
                    String[] elementParts = element.split(":");
                    CustomMetadata patternItem = new CustomMetadata();
                    patternItem.put("type", PatternItemType.FIELD);
                    patternItem.put("path", CustomMetadataField.findByName(elementParts[0]).getAssetCommonPath());
                    patternItem.put("number_of_characters", elementParts[1]);
                    patternItems.add(new PatternItem(patternItem));
                }
            }
            if (!row.containsKey("Name") || !row.containsKey("Sequential Number"))
                throw new NullPointerException("Name and Sequential Number fields are missed, but they are required!");

            CustomMetadata pattern = new CustomMetadata();
            pattern.put("items", patternItems.toArray(new PatternItem[patternItems.size()]));
            pattern.put("name", row.get("Name"));
            pattern.put("enabled", row.containsKey("Enabled") && row.get("Enabled").equals("should"));
            if (row.containsKey("Market") && !row.get("Market").isEmpty()) {
                String[] markets = row.get("Market").split(",");
                String[] marketKeys = new String[markets.length];
                for (int k = 0; k < markets.length; k++)
                    marketKeys[k] = getCoreApi().getMarketKey(markets[k]);
                pattern.put("markets", marketKeys);
            }

            autoGeneratePatterns.add(new AutoGeneratePattern(pattern));
        }
        CustomMetadata autoGen = new CustomMetadata();
        autoGen.put("index", fieldsTable.getRowCount());
        autoGen.put("patterns", autoGeneratePatterns.toArray(new AutoGeneratePattern[autoGeneratePatterns.size()]));
        schema.setAutoGenerate(sName, fieldName, new AutoGenerate(autoGen));
        updateSchemaByName(sName, agencyId, schema);
    }

    // allowState: allow, disallow
    @Given("{I |}'$allowState' special characters on AdCode Manager form of metadata page")
    @When("{I |}'$allowState' special characters on AdCode Manager form of metadata page")
    public void allowSpecialCharacters(String allowState) {
        getAdCodeManager().allowSpecChars(allowState.equals("allow"));
    }

    @When("{I |}create new custom code on AdCode Manager form of metadata page")
    public void createCustomCode() {
        getAdCodeManager().newAdCodeContainer();
    }

    // | Code Name | Market | Date | Date Format | Sequence Characters | Metadata Elements | Metadata Name | Metadata Characters | Free Text | Separator |
    // type: new, existing
    @Given("{I |}filled following fields for '$type' custom code on AdCode Manager form of metadata page: $fieldsTable")
    @When("{I |}fill following fields for '$type' custom code on AdCode Manager form of metadata page: $fieldsTable")
    public void fillAdCodeManagerForm(String type, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAdCodeManagerFormData(fieldsTable);
        switch (type) {
            case "new": getAdCodeManager().newAdCodeContainer().fill(row); break;
            case "existing": getAdCodeManager().getAdCodeByName(row.get("Code Name")).edit().fill(row); break;
            default: throw new IllegalArgumentException("Unknown type: " + type);
        }
    }

    // Step specific to Cost Module inorder to generate customCode's in specific format i.e 'PGUSSSS' format
    // | Code Name | Sequence Characters | Free Text | Separator |
    // type: new
    @Given("{I |}created new custom code for agency '$agencyName' specific to Cost Module with following details: $fieldsTable")
    @When("{I |}create new custom code for agency '$agencyName' specific to Cost Module with following details: $fieldsTable")
    public void fillAdCodeManagerFormForCostModule(String agencyName,ExamplesTable fieldsTable) {
        String agencyId = getAgencyIdByName(agencyName);
        String sName = CustomMetadataSchemaName.findByName("project");
        Schema schema = getSchemaByName(sName, agencyId);
        if(!new Gson().toJsonTree(schema.getCmSectionProperties("common")).toString().contains("ProjectId")) { // This check is tricky, though CustomCode gets deleted from UI when deleted but an entry still exists in backEnd
            PageNavigator pageFactory = getSut().getPageNavigator();
            GlobalMetadataPage metadataPage = pageFactory.getGlobalProjectMetadataPage(agencyId);

            if (!metadataPage.checkEditableMetadataButtonByName("ProjectId")) {
                metadataPage.clickCustomMetadataButtonByName("Custom Code");
                MetadataFieldSettingsBlock block = new MetadataFieldSettingsBlock(getMetadataPage());
                block.typeDescription("ProjectId");
                block.clickSaveButton();
                metadataPage.clickEditableMetadataButtonByName("ProjectId");

                Map<String, String> row = parametrizeTabularRow(fieldsTable);
                if (row.containsKey("Free Text"))
                    row.put("Free Text", String.valueOf(row.get("Free Text").equals("should")));
                AdCodeManager adCodeManager = getAdCodeManager();
                AdCodeContainer container = adCodeManager.newAdCodeContainer();
                adCodeManager.getAdCodeByName("New Custom Code").uncheckSequentialNumber();
                new PopUpWindow(getMetadataPage()).action.click();
                container.fill(row);
                adCodeManager.getAdCodeByName(row.get("Code Name")).checkSequentialNumber();
                block.clickSaveButton();
            }
        }
    }

    @When("{I |}'$action' custom code '$codeName' on AdCode Manager form of metadata page")
    public void doActionWithAdCodeManagerForm(String action, String codeName) {
        switch (action) {
            case "edit" : getAdCodeManager().getAdCodeByName(wrapVariableWithTestSession(codeName)).edit(); break;
            case "delete": getAdCodeManager().getAdCodeByName(wrapVariableWithTestSession(codeName)).getDeleteAdCodePopUp().clickOkBtn(); break;
            default: throw new IllegalArgumentException("Unknown action: " + action);
        }
    }

    // check: check, uncheck
    @When("{I |}'$check' active checkbox for custom code '$codeName' on AdCode Manager form of metadata page")
    public void tickCustomCodeActiveCheckBox(String check, String codeName) {
        getAdCodeManager().getAdCodeByName(wrapVariableWithTestSession(codeName)).selectActive(check.equals("check"));
    }

    @When("{I |} '$checkboxState' the sequential checkbox for the custom code '$codeName' on AdCode Manager form of metadata page")
    public void unCheckSequentialCheckbox(String checkboxState, String codeName) {
        if (checkboxState.equalsIgnoreCase("uncheck")) {
            getAdCodeManager().getAdCodeByName(wrapVariableWithTestSession(codeName)).uncheckSequentialNumber();
        }
    }

    @When("{I |}'$shouldState' see sequential checked for the custom code '$codeName'")
    @Then("{I |}'$shouldState' see sequential checked for the custom code '$codeName'")
    public void sequentialDefaultState(String condition,  String codeName)
    {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean sequentialState = getAdCodeManager().getAdCodeByName(wrapVariableWithTestSession(codeName)).verifySequentialState();
        assertThat("Check the state of sequential ", sequentialState,equalTo(expectedState));

    }

    @When("{I |}'$shouldState' see an sequential alert with warning message '$message' for the custom code '$codeName'")
    @Then("{I |}'$shouldState' see an sequential alert with warning message '$message' for the custom code '$codeName'")
    public void clickSequentialAlert(String shouldState, String message, String codeName) {
        if(new PopUpWindow(getMetadataPage()).isPopUpVisible()) {
            boolean expectedState = shouldState.equalsIgnoreCase("should");
            boolean sequentialMessage = new PopUpWindow(getMetadataPage()).getText(message);
            assertThat("Check sequential warning message", sequentialMessage, equalTo(expectedState));
            new PopUpWindow(getMetadataPage()).action.click();
        }
    }

    @When("{I |}delete metadata element with following name '$metadataName' and characters '$characters' for custom code on AdCode Manager form of metadata page")
    public void deleteMetadataElements(String metadataName, String characters) {
        getAdCodeManager().getAdCodeContainer().getMetadataElement(metadataName, characters).removeItem();
    }

    @When("{I |}delete following free text '$separator' for custom code on AdCode Manager form of metadata page")
    public void deleteFreeTextElements(String separator) {
        getAdCodeManager().getAdCodeContainer().getCustomText(separator).removeItem();
    }

    @Then("{I |}'$shouldState' see following custom code{s|} '$customCodeNames' on AdCode Manager form of metadata page")
    public void checkVisibilityCustomCodes(String shouldState, String customCodeNames) {
        List<String> visibleCustomCodeNames = getAdCodeManager().getVisibleAdCodeNames();
        for (String customCodeName: customCodeNames.split(","))
            assertThat("Check visibility custom code name: " + customCodeName, visibleCustomCodeNames, shouldState.equals("should")
                                                                               ? hasItem(wrapVariableWithTestSession(customCodeName))
                                                                               : not(hasItem(wrapVariableWithTestSession(customCodeName))));
    }

    // state: active, inactive
    @Then("{I |}should see '$state' custom code '$customCodeName' on AdCode Manager form of metadata page")
    public void checkCustomCodeActiveState(String state, String customCodeName) {
        assertThat("Check custom code active state: ", getAdCodeManager().getAdCodeByName(wrapVariableWithTestSession(customCodeName)).isActive(),
                                                       is(state.equals("active")));
    }

    // | Code Name | Market | Preview | Custom Code Format | Date | Date Format | Sequence Characters | Metadata Elements | Metadata Name | Metadata Characters | Free Text | Separator |
    @Then("{I |}should see following data for custom code '$customCodeName' on AdCode Manager form of metadata page: $fieldsTable")
    public void checkAdCodeManagerFormData(String customCodeName, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAdCodeManagerFormData(fieldsTable);
        AdCodeContainer adCodeContainer = getAdCodeManager().getAdCodeByName(wrapVariableWithTestSession(customCodeName)).edit();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), adCodeContainer.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    @Then("{I |}'$shouldState' see validation error for following fields '$fieldNamesList' on AdCode Manager form of metadata page")
    public void checkAdCodeManagerFormFieldsValidation(String shouldState, String fieldNamesList) {
        AdCodeContainer adCodeContainer = getAdCodeManager().getAdCodeContainer();
        for (String fieldName: fieldNamesList.split(","))
            assertThat("Check visibility validation for field: " + fieldName, adCodeContainer.isValidationFieldErrorVisible(fieldName), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see available following metadata names '$metadataNames' for custom code on AdCode Manager form of metadata page")
    public void checkAvailabilityMetadataNames(String shouldState, String metadataNames) {
        List<String> availableMetadataNames = getAdCodeManager().getAdCodeContainer().getAvailableMetadataNames();
        for (String metadataName: metadataNames.split(","))
            assertThat("Check availability metadata: " + metadataName, availableMetadataNames, shouldState.equals("should") ? hasItem(metadataName) : not(hasItem(metadataName)));
    }

    @Then("{I |}should see count '$count' metadata names for custom code on AdCode Manager form of metadata page")
    public void checkMetadataNamesCount(int count) {
        assertThat("Check metadata count: ", getAdCodeManager().getAdCodeContainer().getAvailableMetadataNamesCount(), equalTo(count));
    }

    // | Metadata Name | Metadata Characters | Position |
    @Then("{I |}should see metadata elements for custom code on following positions on AdCode Manager form of metadata page: $fieldsTable")
    public void checkMetadataElementsPositions(ExamplesTable fieldsTable) {
        AdCodeContainer adCodeContainer = getAdCodeManager().getAdCodeContainer();
        List<AdCodeContainer.MetadataElement> metadataElements = adCodeContainer.getMetadataElements();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            AdCodeContainer.MetadataElement metadataElement = adCodeContainer.getMetadataElement(row.get("Metadata Name"), row.get("Metadata Characters"), metadataElements);
            assertThat("Check position metadata element with name: " + row.get("Metadata Name"), metadataElement.getPosition(), equalTo(row.get("Position")));
        }
    }

    // | Separator | Position |
    @Then("{I |}should see free text for custom code on following positions on AdCode Manager form of metadata page: $fieldsTable")
    public void checkFreeTextPositions(ExamplesTable fieldsTable) {
        AdCodeContainer adCodeContainer = getAdCodeManager().getAdCodeContainer();
        List<AdCodeContainer.CustomText> customTexts = adCodeContainer.getCustomTextElements();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            AdCodeContainer.CustomText customText = adCodeContainer.getCustomText(row.get("Separator"), customTexts);
            assertThat("Check position for separator: " + row.get("Separator"), customText.getPosition(), equalTo(row.get("Position")));
        }
    }
}