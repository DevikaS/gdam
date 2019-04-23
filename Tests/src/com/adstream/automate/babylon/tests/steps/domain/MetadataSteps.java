package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.Localization;
import com.adstream.automate.babylon.JsonObjects.schema.*;
import com.adstream.automate.babylon.data.CustomMetadataFieldType;
import com.adstream.automate.babylon.data.CustomMetadataSchemaName;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.admin.metadata.MetadataPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.elements.MetadataFieldSettingsBlock;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.junit.Assert;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import java.util.*;
import java.util.List;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 29.05.13
 * Time: 13:39
 */
public class MetadataSteps extends BaseStep {

    @Given("{I am |}on the metadata page")
    @When("{I |}go to the metadata page")
    public void openAgencyMetadataPage() {
        getSut().getPageNavigator().getMetadataPage();
    }

    @Given("{I am |}on the global '$pageName' metadata page for agency '$agencyName'")
    @When("{I |}go to the global '$pageName' metadata page for agency '$agencyName'")
    public void openGlobalMetadataPage(String pageName, String agencyName) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        getSut().getWebDriver().navigate().refresh();
        String agencyId = getAgencyIdByName(agencyName);

        if (pageName.equalsIgnoreCase("common editable")) {
            pageFactory.getGlobalCommonEditableMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("common custom")) {
            pageFactory.getGlobalCommonEditableMetadataPage(agencyId);
            Common.sleep(5000);
            pageFactory.getGlobalCommonCustomMetadataPage(agencyId);
            Common.sleep(5000);
        } else if (pageName.equalsIgnoreCase("common ordering")) {
            pageFactory.getGlobalCommonOrderingMetadataPage(agencyId, "");
        } else if (pageName.equalsIgnoreCase("common traffic")) {
            pageFactory.getGlobalCommonTrafficMetadataPage(agencyId, "");
        } else if (pageName.equalsIgnoreCase("project")) {
            pageFactory.getGlobalProjectMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("adkit")) {
            pageFactory.getGlobalWorkRequestMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("audio asset")) {
            pageFactory.getGlobalAudioAssetMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("digital asset")) {
            pageFactory.getGlobalDigitalAssetMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("document asset")) {
            pageFactory.getGlobalDocumentAssetMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("image asset")) {
            pageFactory.getGlobalImageAssetMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("print asset")) {
            pageFactory.getGlobalPrintAssetMetadataPage(agencyId);
        } else if (pageName.equalsIgnoreCase("video asset")) {
            pageFactory.getGlobalVideoAssetMetadataPage(agencyId);
        } else {
            throw new IllegalArgumentException(String.format("Unknown global metadata page name '%s'", pageName));
        }
    }

    @Given("{I am |}on the '$pageName' metadata page")
    @When("{I |}go to the '$pageName' metadata page")
    public void openAgencyMetadataPage(String pageName) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        getSut().getWebDriver().navigate().refresh();

        if (pageName.equalsIgnoreCase("common editable")) {
            pageFactory.getCommonEditableMetadataPage();
        } else if (pageName.equalsIgnoreCase("common custom")) {
            pageFactory.getCommonCustomMetadataPage();
             pageFactory.getCommonCustomMetadataPage();

        } else if (pageName.equalsIgnoreCase("project")) {
            pageFactory.getProjectMetadataPage();
        } else if (pageName.equalsIgnoreCase("audio asset")) {
            pageFactory.getAudioAssetMetadataPage();
        } else if (pageName.equalsIgnoreCase("work request")) {
            pageFactory.getWorkRequestMetadataPage();
        } else if (pageName.equalsIgnoreCase("digital asset")) {
            pageFactory.getDigitalAssetMetadataPage();
        } else if (pageName.equalsIgnoreCase("document asset")) {
            pageFactory.getDocumentAssetMetadataPage();
        } else if (pageName.equalsIgnoreCase("image asset")) {
            pageFactory.getImageAssetMetadataPage();
        } else if (pageName.equalsIgnoreCase("print asset")) {
            pageFactory.getPrintAssetMetadataPage();
        } else if (pageName.equalsIgnoreCase("video asset")) {
            pageFactory.getVideoAssetMetadataPage();
        } else {
            throw new IllegalArgumentException(String.format("Unknown agency metadata page name '%s'", pageName));
        }
    }

    @Given("{I |}clicked '$buttonName' button in '$section' section on opened metadata page")
    @When("{I |}click '$buttonName' button in '$section' section on opened metadata page")
    public MetadataFieldSettingsBlock clickMetadataButton(String buttonName, String section) {
        buttonName = Localization.findByKey(buttonName);  // get actual button name that depends on UI localization
        if (section.equalsIgnoreCase("common metadata")) {
            return getMetadataPage().clickCommonMetadataButtonByName(buttonName);
        } else if (section.equalsIgnoreCase("editable metadata")) {
            return getMetadataPage().clickEditableMetadataButtonByName(buttonName);
        } else if (section.equalsIgnoreCase("custom metadata")) {
            return getMetadataPage().clickCustomMetadataButtonByName(buttonName);
        } else {
            throw new IllegalArgumentException(String.format("Unknown metadata section name '%s'", section));
        }
    }

    // | ItemName | Description |
    @Given("{I |}clicked hierarchy navigation bar item '$itemName' on opened Settings and Customization tab")
    @When("{I |}click hierarchy navigation bar item '$itemName' on opened Settings and Customization tab")
    public void clickHierarchyNavigationBarItem(String itemName) {
        new MetadataFieldSettingsBlock(getMetadataPage()).clickHierarchyNavigationBarItemByName(itemName);
    }

    @Given("{I |}filled Description field with text '$text' on opened Settings and Customization tab")
    @When("{I |}fill Description field with text '$text' on opened Settings and Customization tab")
    public void fillMetadataFieldDescription(String text) {
        new MetadataFieldSettingsBlock(getMetadataPage()).typeDescription(text);
    }

    @Given("{I |}filled Number of lines field with value '$text' on opened Settings and Customization tab")
    @When("{I |}fill Number of lines field with value '$text' on opened Settings and Customization tab")
    public void fillMetadataFieldLinesNumber(String text) {
        new MetadataFieldSettingsBlock(getMetadataPage()).typeNumberOfLines(text);
    }

    @Given("{I |}filled custom characters '$characters' for following field choice '$fieldChoice' on opened Settings and Customization tab")
    @When("{I |}fill custom characters '$characters' for following field choice '$fieldChoice' on opened Settings and Customization tab")
    public void fillMetadataFieldChoiceCustomCharacters(String characters, String fieldChoice) {
        new MetadataFieldSettingsBlock(getMetadataPage()).typeFieldChoiceCustomCharacters(fieldChoice, characters);
    }

    @Given("{I |}confirmed opened popup on Settings and Customization page")
    @When("{I |}confirm opened popup on Settings and Customization page")
    public void confirmUnHideChildFields() {
        new PopUpWindow(getMetadataPage()).action.click();
    }

    @Given("{I |}confirmed opened popup on Settings and Customization page if it appears")
    @When("{I |}confirm opened popup on Settings and Customization page if it appears")
    public void confirmUnHideChildFieldsIfItAppears() {
        if (new PopUpWindow(getMetadataPage()).isPopUpVisible())
          new PopUpWindow(getMetadataPage()).action.click();
          Common.sleep(2000);

    }

    @Given("{I |}saved metadata field settings")
    @When("{I |}save metadata field settings")
    public void saveMetadataField() {
        new MetadataFieldSettingsBlock(getMetadataPage()).clickSaveButton();
    }

    @Given("{I |}opened available metadata page '$page'")
    @When("{I |}open available metadata page '$page'")
    public void openMetadataPage(String page) throws InterruptedException {
        getMetadataPage().clickOnPageTab(page);
    }

    @Given("{I |}changed name of '$fieldType' metadata to new name '$description' in editable metadata section on opened metadata page")
    @When("{I |}change name of '$fieldType' metadata to new name '$description' in editable metadata section on opened metadata page")
    public void updateDescriptionCustomMetadataField(String fieldType, String descr) {
        MetadataFieldSettingsBlock page = getMetadataPage().clickEditableMetadataButtonByName(fieldType);
        page.typeDescription(descr);
        page.clickSaveButton();
    }

    // String => | Description | FieldSize | Compulsory | Hidden | Delivery |
    // only Description field must be required
    @Given("{I |}created '$fieldType' custom metadata field with following information on opened metadata page: $data")
    @When("{I |}create '$fieldType' custom metadata field with following information on opened metadata page: $data")
    public void createCustomMetadataField(String fieldType, ExamplesTable data) {
        CustomMetadataFieldType type = CustomMetadataFieldType.getForValue(fieldType);

        for (Map<String, String> row : parametrizeTableRows(data)) {
            MetadataFieldSettingsBlock page = getMetadataPage().clickCustomMetadataButtonByName(fieldType);

            boolean isDelivery = row.get("Delivery") != null && (Boolean.parseBoolean(row.get("Delivery")) || row.get("Delivery").equals("should"));

            page.typeDescription(row.get("Description"));
            if (isDelivery)
                page.tickMakeThisFieldAvailableInDelivery();

            if (type != CustomMetadataFieldType.SECTION_BREAK) {
                page.setMakeItCompulsoryCheckboxState(Boolean.parseBoolean(row.get("Compulsory")));
                page.setHideCheckboxState(Boolean.parseBoolean(row.get("Hidden")));
                if (type != CustomMetadataFieldType.RADIO_BUTTONS) {
                    page.selectFieldSize(row.get("FieldSize"));
                }
                switch(type) {
                    case ADDRESS:
                        break;
                    case RADIO_BUTTONS:
                        if (row.get("Descendants") != null) {
                            page.clickSaveButton();
                            for (String childItem : row.get("Descendants").split(",")) {
                                page.createRadioButtons(childItem);
                            }
                        }
                    case STRING:
                        break;
                    case DATE:
                    case PHONE:
                        page.selectDateFieldFormat(row.get("FieldFormat"));
                        break;
                    case CATALOGUE_STRUCTURE:
                        checkOnAdditionalMetadataField(row, page);
                        if (row.get("Descendants") != null) {
                            for (String childItem : row.get("Descendants").split(",")) {
                                page.clickSaveButton();
                                Common.sleep(1500);
                                page.clickLastAddHierarchyOption();
                                Common.sleep(500);
                                page.typeDescription(childItem);
                            }
                        }
                        break;
                    case HYPERLINK:
                    case DROPDOWN:
                        if (row.get("Descendants") != null) {
                            for (String childItem : row.get("Descendants").split(",")) {
                                page.clickSaveButton();
                                Common.sleep(1500);
                                page.createRadioButtons(childItem);
                            }
                            checkOnAdditionalMetadataField(row, page);
                        }
                        break;
                    case MULTILINE:
                        if (row.get("NumberOfLines") != null) {
                            page.typeNumberOfLines(row.get("NumberOfLines"));
                        }
                        break;
                    default:
                        Assert.fail(String.format("%s metadata field creation functionality is not implemented yet", fieldType));
                }
            }
            page.clickSaveButton();
            page.clickAvailableMetadataTab();
        }
        getSut().getWebDriver().navigate().refresh();
    }

    @Given("{I |}removed metadata field '$fieldName' from metadata page")
    @When("{I |}remove metadata field '$fieldName' from metadata page")
    public void removeMetadataField(String fieldName) {
        getMetadataPage().removeFieldOnMetadataPreview(fieldName);
    }

    /**
     * Creates custom metadata fields via core in specified agency fields schema
     *
     * @param schemaName
     *        section where cm field will be created (common, project, asset)
     *
     * @param agencyName
     *        agency name where fields should be created
     *
     * @param data
     *        data table with information about new field (it depends on schemaName parameter)
     *        when schema name equal 'asset' data table should contain 'Section' column,
     *        which can have value of (audio, digital, document, image, print, video)
     *        required info fields for all types => | FieldType | Description |
     *        additional not required fields
     *        String             => | Compulsory | Hidden | FieldSize |
     *        Multiline          => | Compulsory | Hidden | FieldSize | NumberOfLines |
     *        Date               => | Compulsory | Hidden | FieldSize | FieldFormat |
     *        Phone              => | Compulsory | Hidden | FieldSize | PhoneFormat |
     *        Hyperlink          => | Compulsory | Hidden | FieldSize | FieldFormat | AddHttp | WithText |
     *        Dropdown           => | Compulsory | Hidden | FieldSize | Choices |
     *        RadioButtons       => | Compulsory | Hidden | FieldSize | Choices |
     *        CatalogueStructure => | Compulsory | Hidden | FieldSize | Choices | Parent | AvailableInDelivery |
     *
     *        FieldType:     String, Multiline, Date, Dropdown, RadioButtons, CatalogueStructure
     *        Description:   any symbols from diapason \w+
     *        Compulsory:    true, false
     *        Hidden:        true, false
     *        FieldSize:     Half Width, Full Width
     *        NumberOfLines: number of lines for multiline field
     *        FieldFormat:   format of date field value one of MM/DD/YEAR, DD/MM/YEAR, Month DD, Year, DD Month, Year
     *                       format of hyperlink one of Link, TextLink (Link by default)
     *        AddHttp:       true, false populate hyperlink field with http:// or not (false by default)
     *        Choices:       comma separated word sequence (choice list)
     *        Parent:        parent CatalogueStructure field (when Parent given then Choices option will be ignored)
     *        AvailableInDelivery : true, false
     *        CommonForOrder: true, false
     *        AvailableForBilling: true, false
     */
    @Given("{I |}created following '$schemaName' custom metadata fields for agency '$agencyName': $data")
    @When("{I |}create following '$schemaName' custom metadata fields for agency '$agencyName': $data")
    public void createCustomMetadataFieldViaCore(String schemaName, String agencyName, ExamplesTable data) {
        String agencyId = getAgencyIdByName(agencyName);
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);
        ProjectSchema projectSchema = getCoreApiAdmin().getProjectSchema(agencyId);
        AssetElementCommonSchema assetElementCommonSchema = getCoreApiAdmin().getAssetElementCommonSchema(agencyId);

        for (Map<String,String> properties : parametrizeTableRows(data)) {
            properties.put("FieldId", String.format("%s_%s", properties.get("Description").replaceAll("[^\\w]", ""), Long.toString(DateTime.now().getMillis())));
            if (properties.get("FieldType").equalsIgnoreCase("dropdown") || properties.get("FieldType").equalsIgnoreCase("radioButtons") ||
                    (properties.get("FieldType").equalsIgnoreCase("catalogueStructure") && (properties.get("Parent") == null || properties.get("Parent").isEmpty()))) {
               List<CustomMetadata> choices = new ArrayList<CustomMetadata>();
                if (properties.get("Choices") != null && !properties.get("Choices").isEmpty()) {
                    for (String value : properties.get("Choices").split(",")) {
                        CustomMetadata choice = new CustomMetadata();

                        if (properties.get("Description").equals("Advertiser") || properties.get("Description").equals("Brand") || properties.get("Description").equals("Sub Brand") || properties.get("Description").equals("Product")) {
                            choice.put("key", wrapVariableWithTestSession(value));
                        } else {
                            choice.put("key", value);
                        }

                        choices.add(choice);
                    }
                }
                getCoreApiAdmin().createAgencyDictionary(agencyId, properties.get("FieldId"), choices);
            }

            if (schemaName.equalsIgnoreCase("common")) {
                properties.put("SchemaName", String.format("asset_element_project_common.agency.%s", agencyId));
                assetElementProjectCommonSchema.createCMField(properties);
            } else if (schemaName.equalsIgnoreCase("project")) {
                properties.put("SchemaName", String.format("project.agency.%s", agencyId));
                projectSchema.createCMField(properties);
            } else if (schemaName.equalsIgnoreCase("asset")) {
                properties.put("SchemaName", String.format("asset_element_common.agency.%s", agencyId));
                assetElementCommonSchema.createCMField(properties);
            } else {
                throw new IllegalArgumentException(String.format("Unknown schema name '%s', available schemas are common, project or asset", schemaName));
            }
        }

        getCoreApiAdmin().updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
        getCoreApiAdmin().updateProjectSchema(agencyId, projectSchema);
        getCoreApiAdmin().updateAssetElementCommonSchema(agencyId, assetElementCommonSchema);
    }

    // Make fields available in Delivery
    // fieldName: Advertiser, Brand, Sub Brand, Product, Campaign
    @Given("{I |}make '$fieldName' field from asset element project common schema available in Delivery for agenc{y|ies} '$agencyNames'")
    public void updateFieldProperties(String fieldName, String agencyNames) {
        for (String agencyName : agencyNames.split(",")) {
            String agencyId = getAgencyIdByName(agencyName);
            AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);
            if (!assetElementProjectCommonSchema.isFieldAvailableInDelivery(fieldName)) {
                assetElementProjectCommonSchema.makeFieldAvailableInDelivery(fieldName);
                getCoreApiAdmin().updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
            }
        }
    }

    /**
     * Creates custom metadata fields groups via core in specified agency cm fields schema
     *
     * @param schemaName
     *        section where cm field group will be created (common, project, asset)
     *
     * @param agencyName
     *        agency name where field group should be created
     *
     * @param data
     *        data table with information about new field group (it depends on schemaName parameter)
     *        when schema name equal 'asset' data table should contain 'Section' column,
     *
     *        required info field => | Description |
     *
     *        Description: Section break name (any symbols from diapason \w+)
     */
    @Given("{I |}created following '$sectionName' custom metadata section breaks for agency '$agencyName': $data")
    @When("{I |}create following '$sectionName' custom metadata section breaks for agency '$agencyName': $data")
    public void createCustomMetadataFieldGroupViaCore(String schemaName, String agencyName, ExamplesTable data) {
        String agencyId = getAgencyIdByName(agencyName);
        AssetSchema assetSchema = getCoreApiAdmin().getAssetSchema(agencyId);
        ProjectSchema projectSchema = getCoreApiAdmin().getProjectSchema(agencyId);
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);

        for (Map<String,String> properties : parametrizeTableRows(data)) {
            properties.put("GroupId", String.format("%s_%s", properties.get("Description").replaceAll("[^\\w]", ""), Long.toString(DateTime.now().getMillis())));

            if (schemaName.equalsIgnoreCase("common")) {
                assetElementProjectCommonSchema.createFieldGroup(properties);
                projectSchema.createFieldGroup(properties);
                properties.put("Section", "audio,video,print,document,digital,image,other");
                assetSchema.createFieldGroup(properties);
            } else if (schemaName.equalsIgnoreCase("project")) {
                projectSchema.createFieldGroup(properties);

            } else if (schemaName.equalsIgnoreCase("asset")) {
                assetSchema.createFieldGroup(properties);
            } else {
                throw new IllegalArgumentException(String.format("Unknown schema name '%s', available schemas are common, project or asset", schemaName));
            }
        }

        getCoreApiAdmin().updateAssetSchema(agencyId, assetSchema);
        getCoreApiAdmin().updateProjectSchema(agencyId, projectSchema);
        getCoreApiAdmin().updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
    }

    /**
     * Reorders custom metadata fields groups via core in specified agency cm fields schema
     *
     * @param schemaName
     *        section where cm field group will be created (common, project, asset)
     *
     * @param agencyName
     *        agency name where field group should be created
     *
     * @param data
     *        data table with information about new field group (it depends on schemaName parameter)
     *        when schema name equal 'asset' data table should contain 'Section' column,
     *
     *        required info field => | FieldGroupName |
     *
     *        FieldGroupName: Section break name (any symbols from diapason \w+)
     */
    @Given("{I |}reordered following '$sectionName' custom metadata section breaks for agency '$agencyName': $data")
    @When("{I |}reorder following '$sectionName' custom metadata section breaks for agency '$agencyName': $data")
    public void reorderCustomMetadataFieldGroupsViaCore(String schemaName, String agencyName, ExamplesTable data) {
        String agencyId = getAgencyIdByName(agencyName);
        AssetSchema assetSchema = getCoreApiAdmin().getAssetSchema(agencyId);
        ProjectSchema projectSchema = getCoreApiAdmin().getProjectSchema(agencyId);
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);

        List<Map<String,String>> parametrizedData = parametrizeTableRows(data);
        Collections.reverse(parametrizedData);

        for (Map<String,String> properties : parametrizedData) {
            if (schemaName.equalsIgnoreCase("common")) {
                assetElementProjectCommonSchema.reorderFieldGroups(properties.get("FieldGroupName"), "common");
                projectSchema.reorderFieldGroups(properties.get("FieldGroupName"), "common");
                assetSchema.reorderFieldGroups(properties.get("FieldGroupName"), "audio,video,print,document,digital,image,other");
            } else if (schemaName.equalsIgnoreCase("project")) {
                projectSchema.reorderFieldGroups(properties.get("FieldGroupName"), "common");
            } else if (schemaName.equalsIgnoreCase("asset")) {
                assetSchema.reorderFieldGroups(properties.get("FieldGroupName"), properties.get("Section"));
            } else {
                throw new IllegalArgumentException(String.format("Unknown schema name '%s', available schemas are common, project or asset", schemaName));
            }
        }

        getCoreApiAdmin().updateAssetSchema(agencyId, assetSchema);
        getCoreApiAdmin().updateProjectSchema(agencyId, projectSchema);
        getCoreApiAdmin().updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
    }

    /**
     * Moves custom metadata fields from group to other group via core in specified agency cm fields schema
     *
     * @param schemaName
     *        section where cm field group will be created (common, project, asset)
     *
     * @param fromGroup
     *        group where field is located
     *
     * @param toGroup
     *        group where field should be moved
     *
     * @param agencyName
     *        agency name where field group should be created
     *
     * @param data
     *        data table with information about new field group (it depends on schemaName parameter)
     *        when schema name equal 'asset' or 'common' data table should contain 'Section' column,
     *
     *        required info field => | FieldName |
     *
     *        FieldName: existing field name to move
     */
    @Given("{I |}moved following '$schemaName' custom metadata fields from group '$fromGroup' to group '$toGroup' in agency '$agencyName': $data")
    @When("{I |}move following '$schemaName' custom metadata fields from group '$fromGroup' to group '$toGroup' in agency '$agencyName': $data")
    public void moveFieldFromGroupToOtherGroupViaCore(String schemaName, String fromGroup, String toGroup, String agencyName, ExamplesTable data) {
        String agencyId = getAgencyIdByName(agencyName);
        AssetSchema assetSchema = getCoreApiAdmin().getAssetSchema(agencyId);
        ProjectSchema projectSchema = getCoreApiAdmin().getProjectSchema(agencyId);
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);
        AssetElementCommonSchema assetElementCommonSchema = getCoreApiAdmin().getAssetElementCommonSchema(agencyId);

        List<Map<String,String>> parametrizedData = parametrizeTableRows(data);
        Collections.reverse(parametrizedData);

        for (Map<String,String> properties : parametrizedData) {
            if (schemaName.equalsIgnoreCase("common")) {
                String fromGroupId = assetElementProjectCommonSchema.getGroupIdFromSectionByDescription("common", fromGroup);
                String toGroupId = assetElementProjectCommonSchema.getGroupIdFromSectionByDescription("common", toGroup);
                String fieldGroupContainer = "asset_element_project_common_common";

                if (properties.get("Section") != null) {
                    if (properties.get("Section").equalsIgnoreCase("common")) {
                        fieldGroupContainer = "asset_element_project_common_common";
                    } else if (properties.get("Section").equalsIgnoreCase("project")) {
                        fieldGroupContainer = "project_common";
                    } else {
                        fieldGroupContainer = "asset_" + properties.get("Section");
                    }
                }

                assetElementProjectCommonSchema.moveFieldFromGroupToOtherGroup("common", fieldGroupContainer, fromGroupId, toGroupId, properties.get("FieldName"));
            } else if (schemaName.equalsIgnoreCase("project")) {
                String fromGroupId = projectSchema.getGroupIdFromSectionByDescription("common", fromGroup);
                String toGroupId = projectSchema.getGroupIdFromSectionByDescription("common", toGroup);

                projectSchema.moveFieldFromGroupToOtherGroup("common", fromGroupId, toGroupId, properties.get("FieldName"));
            } else if (schemaName.equalsIgnoreCase("asset")) {
                String fromGroupId = assetSchema.getGroupIdFromSectionByDescription(properties.get("Section"), fromGroup);
                String toGroupId = assetSchema.getGroupIdFromSectionByDescription(properties.get("Section"), toGroup);

                assetElementCommonSchema.moveFieldFromGroupToOtherGroup(properties.get("Section"), fromGroupId, toGroupId, properties.get("FieldName"));
            } else {
                throw new IllegalArgumentException(String.format("Unknown schema name '%s', available schemas are common, project or asset", schemaName));
            }
        }

        getCoreApiAdmin().updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
        getCoreApiAdmin().updateProjectSchema(agencyId, projectSchema);
        getCoreApiAdmin().updateAssetElementCommonSchema(agencyId, assetElementCommonSchema);
    }

    @Given("{I |}updated following '$sectionName' custom metadata fields for agency '$agencyName': $data")
    @When("{I |}update following '$sectionName' custom metadata fields for agency '$agencyName': $data")
    public void updateCustomMetadataFieldViaCore(String schemaName, String agencyName, ExamplesTable data) {
        String agencyId = getAgencyIdByName(agencyName);
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);
        ProjectSchema projectSchema = getCoreApiAdmin().getProjectSchema(agencyId);
        AssetElementCommonSchema assetElementCommonSchema = getCoreApiAdmin().getAssetElementCommonSchema(agencyId);

        for (Map<String,String> properties : parametrizeTableRows(data)) {
            if (properties.get("FieldType").equalsIgnoreCase("dropdown") || properties.get("FieldType").equalsIgnoreCase("radioButtons") ||
                    (properties.get("FieldType").equalsIgnoreCase("catalogueStructure") && (properties.get("Parent") == null || properties.get("Parent").isEmpty()))) {

                if (properties.get("Choices") != null) {
                    List<CustomMetadata> choices = new ArrayList<CustomMetadata>();
                    for (String value : properties.get("Choices").split(",")) {
                        CustomMetadata choice = new CustomMetadata();

                        if (properties.get("Description").equals("Advertiser") || properties.get("Description").equals("Brand") || properties.get("Description").equals("Sub Brand") || properties.get("Description").equals("Product")) {
                            choice.put("key", wrapVariableWithTestSession(value));
                        } else {
                            choice.put("key", value);
                        }

                        choices.add(choice);
                    }

                    String sectionName;

                    if (schemaName.equalsIgnoreCase("common") || schemaName.equalsIgnoreCase("project")) {
                        sectionName = "common";
                    } else if (schemaName.equalsIgnoreCase("asset")) {
                        sectionName = properties.get("Section");
                    } else {
                        throw new IllegalArgumentException(String.format("Unknown schema name '%s', available schemas are common, project or asset", schemaName));
                    }

                    String dictionaryId = getDictionaryId(schemaName, sectionName, properties.get("Description"), agencyId);

                    getCoreApiAdmin().updateAgencyDictionaryValues(agencyId, dictionaryId, choices);
                }
            }

            if (schemaName.equalsIgnoreCase("common")) {
                properties.put("SchemaName", String.format("asset_element_project_common.agency.%s", agencyId));
                properties.put("FieldId", assetElementProjectCommonSchema.getCMFieldIdFromSectionByDescription("common", properties.get("Description")));
                assetElementProjectCommonSchema.updateCMField(properties);
            } else if (schemaName.equalsIgnoreCase("project")) {
                properties.put("SchemaName", String.format("project.agency.%s", agencyId));
                properties.put("FieldId", projectSchema.getCMFieldIdFromSectionByDescription("common", properties.get("Description")));
                projectSchema.updateCMField(properties);
            } else if (schemaName.equalsIgnoreCase("asset")) {
                properties.put("SchemaName", String.format("asset_element_common.agency.%s", agencyId));
                properties.put("FieldId", assetElementCommonSchema.getCMFieldIdFromSectionByDescription(properties.get("Section"), properties.get("Description")));
                assetElementCommonSchema.updateCMField(properties);
            } else {
                throw new IllegalArgumentException(String.format("Unknown schema name '%s', available schemas are common, project or asset", schemaName));
            }
        }

        getCoreApiAdmin().updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
        getCoreApiAdmin().updateProjectSchema(agencyId, projectSchema);
        getCoreApiAdmin().updateAssetElementCommonSchema(agencyId, assetElementCommonSchema);
    }

    @Given("{I |}created following catalogue structure items chains in '$sectionName' section of '$schemaName' schema for agency '$agencyName': $data")
    @When("{I |}create following catalogue structure items chains in '$sectionName' section of '$schemaName' schema for agency '$agencyName': $data")
    public void createCatalogueStructureChainsViaCore(String sectionName, String schemaName, String agencyName, ExamplesTable data) {
        createCatalogueStructureViaCore(sectionName,schemaName,agencyName,"with",data);
    }

    @Given("{I |}created following catalogue structure items chains in '$sectionName' section of '$schemaName' schema for agency '$agencyName' with custom characters and '$withSession' session: $data")
    @When("{I |}create following catalogue structure items chains in '$sectionName' section of '$schemaName' schema for agency '$agencyName' with custom characters and '$withSession' session: $data")
    public void createCatalogueStructureChainsWithCustomCharactersViaCore(String sectionName, String schemaName, String agencyName, String withSession, ExamplesTable data) {
        createCatalogueStructureViaCore(sectionName,schemaName,agencyName,withSession,data);
    }

    private void createCatalogueStructureViaCore(String sectionName, String schemaName, String agencyName, String withSession, ExamplesTable data){
        String agencyId = getAgencyIdByName(agencyName);
        List<String> catalogueItems = data.getHeaders();
        String catalogueRoot = catalogueItems.get(0);
        String dictionaryId = getDictionaryId(schemaName, sectionName, catalogueRoot, agencyId);
        CustomMetadata choices =  new CustomMetadata();
        choices.put("values", new ArrayList<CustomMetadata>());

        for (Map<String,String> row : parametrizeTableRows(data)) {
            List<String> items = new ArrayList<String>();
            for (String catalogueItem : catalogueItems) {
                if (catalogueItem.contains("Advertiser") || catalogueItem.contains("Brand") || catalogueItem.contains("Sub Brand") || catalogueItem.contains("Product") || catalogueItem.contains("Sector")){
                    if (withSession.equalsIgnoreCase("with"))
                        items.add(wrapVariableWithTestSession(row.get(catalogueItem)));
                    else
                        items.add((row.get(catalogueItem)));
                }
                else{

                    items.add((row.get(catalogueItem)));
                }
            }
            addValues(choices, items);
        }

        getCoreApiAdmin().updateAgencyDictionaryValues(agencyId, dictionaryId, (ArrayList<CustomMetadata>) choices.get("values"));
    }


    @Given("{I |}removed catalogue structure items '$items' on opened Settings and Customization page")
    @When("{I |}remove catalogue structure items '$items' on opened Settings and Customization page")
    public void removeCatalogueStructureItems(String items) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        for (String item : items.split(",")) page.removeHierarchyOptionByName(item);
    }

    @Given("{I |}removed radio buttons items '$items' on opened Settings and Customization page")
    @When("{I |}remove radio buttons items '$items' on opened Settings and Customization page")
    public void removeRadioButtonsItems(String items) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        for (String item : items.split(",")) page.clickDestroyButtonByName(item);
        page.clickSaveButton();
    }

    @Given("{I |}hidden metadata field '$fieldName' on opened metadata page")
    @When("{I |}hide metadata field '$fieldName' on opened metadata page")
    public void hideMetadataField(String fieldName) {
        MetadataFieldSettingsBlock page = getMetadataPage().clickEditableMetadataButtonByName(fieldName);
        page.checkHideCheckbox();
        page.clickSaveButton();
    }

    @Given("{I |}made metadata field '$fieldName' compulsory on opened metadata page")
    @When("{I |}make metadata field '$fieldName' compulsory on opened metadata page")
    public void makeMetadataFieldCompulsory(String fieldName) {
        MetadataFieldSettingsBlock page = getMetadataPage().clickEditableMetadataButtonByName(fieldName);
        page.checkMakeItCompulsory();
        page.clickSaveButton();
    }

    @Given("{I |}updated field '$fieldName' size to '$fieldSize' on opened metadata page")
    @When("{I |}update field '$fieldName' size to '$fieldSize' on opened metadata page")
    public void makeMetadataFieldCompulsory(String fieldName, String fieldSize) {
        MetadataFieldSettingsBlock page = getMetadataPage().clickEditableMetadataButtonByName(fieldName);
        page.selectFieldSize(fieldSize);
        page.clickSaveButton();
    }

    @Given("{I |}checked '$optionName' checkbox on following string fields on opened metadata page: $data")
    @When("{I |}check '$optionName' checkbox on following string fields on opened metadata page: $data")
    public void checkOptionOnStringFieldSettingsPage(String optionName, ExamplesTable data) {
        MetadataPage metadataPage = getMetadataPage();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            MetadataFieldSettingsBlock settingsBlock = metadataPage.clickEditableMetadataButtonByName(row.get("FieldName"));
            checkOptionOnStringFieldSettingsPage(optionName);
            settingsBlock.clickSaveButton();
            settingsBlock.clickAvailableMetadataTab();
        }
    }

    /*
    *   metadataNames: Advertiser, Brand, Sub Brand, Product etc
    *   schemaName: common, project, audio, digital, document, image, print, video
    *   | Make it common for order | Make this field available for billing |
     */
    @Given("{I |}updated metadata{s|} '$metadataNames' in schema '$schemaName' of agency '$agencyName' by following fields: $fields")
    public void updateSchemaFields(String metadataNames, String schemaName, String agencyName, ExamplesTable fields) {
        Map<String, String> row = parametrizeTabularRow(fields);
        for (Map.Entry<String, String> entry: row.entrySet())
            row.put(entry.getKey(), String.valueOf(entry.getValue().equals("should")));
        String agencyId = getAgencyIdByName(agencyName);
        String sName = CustomMetadataSchemaName.findByName(schemaName);
        Schema schema = getSchemaByName(sName, agencyId);
        for (String metadataName: metadataNames.split(",")) {
            if (row.containsKey("Make it common for order"))
                schema.setCommonForOrder(sName, metadataName, Boolean.parseBoolean(row.get("Make it common for order")));
            if (row.containsKey("Make this field available for billing"))
                schema.setAvailableForBilling(sName, metadataName, Boolean.parseBoolean(row.get("Make this field available for billing")));
        }
        updateSchemaByName(sName, agencyId, schema);
    }

    // optionNames are separated by comma
    @Given("{I |}checked '$optionNames' checkbox on opened string field Settings and Customization page")
    @When("{I |}check '$optionNames' checkbox on opened string field Settings and Customization page")
    public void checkOptionOnStringFieldSettingsPage(String optionNames) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        for (String optionName: optionNames.split(",")) {
            if (optionName.equalsIgnoreCase("make it compulsory")) {
                page.checkMakeItCompulsory();
            } else if (optionName.equalsIgnoreCase("mark as advertiser")) {
                page.tickMarkAsAdvertiser();
            } else if (optionName.equalsIgnoreCase("mark as product")) {
                page.tickMarkAsProduct();
            } else if (optionName.equalsIgnoreCase("mark as campaign")) {
                page.tickMarkAsCampaign();
            } else if (optionName.equalsIgnoreCase("hide")) {
                page.checkHideCheckbox();
            } else if (optionName.equalsIgnoreCase("add values on the fly")) {
                page.checkAddOnTheFly();
            } else if (optionName.equalsIgnoreCase("multiple choices")) {
                page.checkMultipleChoices();
            } else if (optionName.equalsIgnoreCase("display this field on your table view")) {
                page.tickDisplayThisFieldOnYourTableView();
            } else if (optionName.equalsIgnoreCase("display this field on your detailed view")) {
                page.tickDisplayThisFieldOnYourDetailedView();
            } else if (optionName.equalsIgnoreCase("mark as house number")) {
                page.tickMarkAsHouseNumber();
            } else if (optionName.equalsIgnoreCase("make this field available in delivery")) {
                page.tickMakeThisFieldAvailableInDelivery();
            } else if (optionName.equalsIgnoreCase("make it common for order")) {
                page.tickMakeItCommonForOrder();
            } else if (optionName.equalsIgnoreCase("make this field available for billing")) {
                page.tickMakeThisFieldAvailableForBilling();
            } else if (optionName.equalsIgnoreCase("visible on order summary")) {
                page.tickVisibleOnOrderSummary();
            } else if (optionName.equalsIgnoreCase("field is editable")) {
                page.tickFieldIsEditable();
            } else {
                throw new IllegalArgumentException(String.format("Unknown checkbox name '%s' for string field settings page", optionName));
            }
        }
    }

    // optionNames are separated by comma
    @Given("{I |}unchecked '$optionNames' checkbox on opened string field Settings and Customization page")
    @When("{I |}uncheck '$optionNames' checkbox on opened string field Settings and Customization page")
    public void uncheckOptionOnStringFieldSettingsPage(String optionNames) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        for (String optionName: optionNames.split(",")) {
            if (optionName.equalsIgnoreCase("make it compulsory")) {
                page.uncheckMakeItCompulsory();
            } else if (optionName.equalsIgnoreCase("mark as advertiser")) {
                page.unTickMarkAsAdvertiser();
            } else if (optionName.equalsIgnoreCase("mark as product")) {
                page.unTickMarkAsProduct();
            } else if (optionName.equalsIgnoreCase("hide")) {
                page.uncheckHideCheckbox();
            } else if (optionName.equalsIgnoreCase("add values on the fly")) {
                page.uncheckAddOnTheFly();
            } else if (optionName.equalsIgnoreCase("multiple choices")) {
                page.uncheckMultipleChoices();
            } else if (optionName.equalsIgnoreCase("display this field on your table view")) {
                page.unTickDisplayThisFieldOnYourTableView();
            } else if (optionName.equalsIgnoreCase("display this field on your detailed view")) {
                page.unTickDisplayThisFieldOnYourDetailedView();
            } else if (optionName.equalsIgnoreCase("field is editable")) {
                page.unTickFieldIsEditable();
            } else {
                throw new IllegalArgumentException(String.format("Unknown checkbox name '%s' for string field settings page", optionName));
            }
        }
    }

    // | Advertiser | Brand | Sub Brand | Product |
    @Given("{I |}created following Advertiser chain with checked '$options' checkbox on Settings and Customization page: $data")
    @When("{I |}create following Advertiser chain with checked '$options' checkbox on Settings and Customization page: $data")
    public void createAdvertiserChainWithOption(String options, ExamplesTable data) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            Common.sleep(5000);
            getMetadataPage().clickCommonMetadataButtonByName("Advertiser");

            List<String> advChain = new ArrayList<String>();
            advChain.add(row.get("Advertiser"));
            advChain.add(row.containsKey("Brand") ? row.get("Brand") : "");
            advChain.add(row.containsKey("Sub Brand") ? row.get("Sub Brand") : "");
            advChain.add(row.containsKey("Product") ? row.get("Product") : "");

            if (options != null)
                for (String option : options.split(","))
                    if (!option.equalsIgnoreCase("multiple choices") && !option.equalsIgnoreCase("make it compulsory"))
                        checkOptionOnStringFieldSettingsPage(option);

            for (Iterator<String> iterator = advChain.iterator(); iterator.hasNext(); ) {
                String chainItem = wrapVariableWithTestSession(iterator.next());

                if (chainItem != null && !chainItem.isEmpty()) {
                    if (options != null)
                        for (String option : options.split(","))
                            if (option.equalsIgnoreCase("multiple choices") || option.equalsIgnoreCase("make it compulsory"))
                                checkOptionOnStringFieldSettingsPage(option);

                    if (!page.isHierarchyOptionPresent(chainItem)) {
                        page.clickAddChoiceButton();
                        page.typeChoiceFieldName(chainItem);
                    }

                    page.clickSaveButton();

                    if (iterator.hasNext()) {
                        page.clickAvailableMetadataTab();
                        getMetadataPage().checkIfAvailableMetadataTabIsActive();
                        getMetadataPage().clickCommonMetadataButtonByName("Advertiser");

                        for (String item : advChain) {
                            page.clickInheritButtonByName(wrapVariableWithTestSession(item));
                            if (chainItem.equals(wrapVariableWithTestSession(item))) break;
                        }
                    }
                } else {
                    break;
                }
            }

            page.clickAvailableMetadataTab();
        }
    }

    // | ChainItem |
    @Given("{I |}created following Catalogue Structure chain for field '$fieldName' on opened metadata page in '$sectionName' section: $data")
    @When("{I |}create following Catalogue Structure chain for field '$fieldName' on opened metadata page in '$sectionName' section: $data")
    public void createCatalogueStructureChain(String fieldName, String sectionName, ExamplesTable data) {
        MetadataFieldSettingsBlock page = clickMetadataButton(fieldName, sectionName);

        for (Iterator<Map<String, String>> iterator = parametrizeTableRows(data).iterator(); iterator.hasNext(); ) {
            Map<String, String> row = iterator.next();

            if (row.get("ChainItem") != null && !row.get("ChainItem").isEmpty()) {
                if (!page.isHierarchyOptionPresent(row.get("ChainItem"))) {
                    page.clickAddChoiceButton();
                    page.typeChoiceFieldName(row.get("ChainItem"));
                }

                page.clickSaveButton();
                if (iterator.hasNext()) {
                    page.clickAvailableMetadataTab();
                    clickMetadataButton(fieldName, sectionName);

                    for (Map<String,String> item : parametrizeTableRows(data)) {
                        page.clickInheritButtonByName(item.get("ChainItem"));
                        if (row.get("ChainItem").equals(item.get("ChainItem"))) break;
                    }
                }
            } else {
                break;
            }
        }
    }

    @Given("{I |}created following Catalogue Structure chains on opened Settings and Customization page: $data")
    @When("{I |}create following Catalogue Structure chains on opened Settings and Customization page: $data")
    public void createCatalogueStructureChains(ExamplesTable data) {
        createCatalogueStructureChains(data, 0, null);
    }

    private void createCatalogueStructureChains(ExamplesTable data, int level, String parentItem) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        List<String> items = getCatalogueStructureItems(data, level, parentItem);
        page.addHierarchyChoices(items);
        if (level < data.getHeaders().size() - 1) {

            for (String item : items) {
                page.clickInheritButtonByName(item);
                createCatalogueStructureChains(data, level + 1, item);
            }
        }
        if (level > 0) {

            page.clickHierarchyNavigationBarItemByName(data.getHeaders().get(level - 1));
        }
    }

    private List<String> getCatalogueStructureItems(ExamplesTable data, int level, String parentItem) {
        Set<String> set = new LinkedHashSet<String>();
        String key = data.getHeaders().get(level);
        String parentKey = level > 0 ? data.getHeaders().get(level - 1) : null;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (parentKey != null && parentItem != null && !row.get(parentKey).equals(parentItem)) {
                continue;
            }
            set.add(row.get(key));
        }
        return new ArrayList<String>(set);
    }

    // | Advertiser | Brand | SubBrand | Product |
    @Given("{I |}created Advertiser chain with following values on Settings and Customization page: $data")
    @When("{I |}create Advertiser chain with following values on Settings and Customization page: $data")
    public void createAdvertiserChain(ExamplesTable data) {
        createAdvertiserChainWithOption(null, data);
    }

    // | ItemName | Description |
    @Given("{I |}updated Catalogue Structure '$fieldName' in section '$sectionName' with following descriptions: $data")
    @When("{I |}update Catalogue Structure '$fieldName' in section '$sectionName' with following descriptions: $data")
    public void updateCatalogueStructureWithDescription(String fieldName, String sectionName, ExamplesTable data) {
        MetadataFieldSettingsBlock page = clickMetadataButton(fieldName, sectionName);

        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.clickHierarchyNavigationBarItemByName(row.get("ItemName"));
            page.typeDescription(row.get("Description"));
            page.clickSaveButton();
        }
    }

    // | Item | Size |
    @Given("{I |}{select|updat}ed following catalogue structure items size on opened Settings and Customization page: $data")
    @When("{I |}{select|update} following catalogue structure items size on opened Settings and Customization page: $data")
    public void selectCatalogueStructureFieldSizes(ExamplesTable data) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.clickHierarchyNavigationBarItemByName(row.get("Item"));
            page.selectFieldSize(row.get("Size"));
            page.clickSaveButton();
        }
    }

    // | Item |
    @Given("{I |}checked '$optionName' following catalogue structure items on opened Settings and Customization page: $data")
    @When("{I |}check '$optionName' following catalogue structure items on opened Settings and Customization page: $data")
    public void selectCatalogueStructureItemsOption(String optionName, ExamplesTable data) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.clickHierarchyNavigationBarItemByName(row.get("Item"));

            if (optionName.equalsIgnoreCase("make it compulsory")) {
                page.checkMakeItCompulsory();
            } else if (optionName.equalsIgnoreCase("hide")) {
                page.checkHideCheckbox();
            } else if (optionName.equalsIgnoreCase("add values on the fly")) {
                page.checkAddOnTheFly();
            } else if (optionName.equalsIgnoreCase("multiple choices")) {
                page.checkMultipleChoices();
            } else {
                throw new IllegalArgumentException(String.format("Unknown checkbox name '%s' for string field settings page", optionName));
            }

            page.clickSaveButton();
            Common.sleep(2000);

        }
    }

    @Given("{I |}deleted Advertiser chain '$chainName' on opened Settings and Customization page")
    @When("{I |}delete Advertiser chain '$chainName' on opened Settings and Customization page")
    public void deleteAdvertiserChain(String chainName) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        page.clickDestroyButtonByName(wrapVariableWithTestSession(chainName));
        page.clickSaveButton();
    }

    // | FieldName | FromGroupName | ToGroupName |
    @Given("{I |}moved following '$schemaName' fields in section '$sectionName' for agency '$agencyName': $data")
    @When("{I |}move following '$schemaName' fields in section '$sectionName' for agency '$agencyName': $data")
    public void moveFieldsFromGroupToIntoGroup(String schemaName, String sectionName, String agencyName, ExamplesTable data) {
        String agencyId = getAgencyIdByName(agencyName);
        AssetSchema assetSchema = getCoreApiAdmin().getAssetSchema(agencyId);
        ProjectSchema projectSchema = getCoreApiAdmin().getProjectSchema(agencyId);
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);
        AssetElementCommonSchema assetElementCommonSchema = getCoreApiAdmin().getAssetElementCommonSchema(agencyId);
        List<Map<String,String>> fieldsInfo = new ArrayList<Map<String,String>>();

        for (Map<String, String> properties : parametrizeTableRows(data)) {
            Map<String, String> fieldInfo = new HashMap<String, String>();

            if (schemaName.equalsIgnoreCase("common")) {
                fieldInfo.put("FieldFromGroupId", assetElementProjectCommonSchema.getGroupIdFromSectionByDescription("common", properties.get("FromGroupName")));
                fieldInfo.put("FieldToGroupId", assetElementProjectCommonSchema.getGroupIdFromSectionByDescription("common", properties.get("ToGroupName")));
                fieldInfo.put("FieldId", assetElementProjectCommonSchema.getCMVisibleFieldIdFromSectionByDescription("common", properties.get("FieldName")));
            } else if (schemaName.equalsIgnoreCase("project")) {
                fieldInfo.put("FieldFromGroupId", projectSchema.getGroupIdFromSectionByDescription("common", properties.get("FromGroupName")));
                fieldInfo.put("FieldToGroupId", projectSchema.getGroupIdFromSectionByDescription("common", properties.get("ToGroupName")));
                fieldInfo.put("FieldId", projectSchema.getCMVisibleFieldIdFromSectionByDescription("common", properties.get("FieldName")));
            } else if (schemaName.equalsIgnoreCase("asset")) {
                fieldInfo.put("FieldFromGroupId", assetSchema.getGroupIdFromSectionByDescription(sectionName, properties.get("FromGroupName")));
                fieldInfo.put("FieldToGroupId", assetSchema.getGroupIdFromSectionByDescription(sectionName, properties.get("ToGroupName")));
                String fieldId = assetElementCommonSchema.getCMVisibleFieldIdFromSectionByDescription(sectionName, properties.get("FieldName"));
                fieldId = fieldId == null ? assetElementCommonSchema.getCMVisibleFieldIdFromSectionByDescription("common", properties.get("FieldName")) : fieldId;
                fieldId = fieldId == null ? assetElementProjectCommonSchema.getCMVisibleFieldIdFromSectionByDescription("common", properties.get("FieldName")) : fieldId;
                fieldInfo.put("FieldId", fieldId);
            } else {
                throw new IllegalArgumentException(String.format("Unknown schema name '%s'", schemaName));
            }

            fieldsInfo.add(fieldInfo);
        }

        getMetadataPage().moveFieldsFromGroupToOtherGroup(fieldsInfo);
    }

    // | FieldName |
    @Given("{I |}moved fields into group '$groupName' in following order in Active Metadata Preview block on opened metadata page: $data")
    @When("{I |}move fields into group '$groupName' in following order in Active Metadata Preview block on opened metadata page: $data")
    public void moveFieldsIntoGroup(String groupName, ExamplesTable data) {
        List<String> fieldsList = new ArrayList<String>();
        for (Map<String, String> row : parametrizeTableRows(data)) fieldsList.add(row.get("FieldName"));
        getMetadataPage().reorderFieldsIntoGroup(fieldsList, groupName);
    }

    // | GroupName |
    @Given("{I |}reordered metadata groups in following order in Active Metadata Preview block on opened metadata page: $data")
    @When("{I |}reorder metadata groups in following order in Active Metadata Preview block on opened metadata page: $data")
    public void reorderFieldGroups(ExamplesTable data) {
        List<String> groupNames = new ArrayList<String>();
        for (Map<String, String> row : parametrizeTableRows(data)) groupNames.add(row.get("GroupName"));
        getMetadataPage().reorderFieldGroups(groupNames);
    }

    // | Choice | Default |
    // 'Default' is optional and should be boolean
    @Given("{I |}added following {dropdown|radio} choices on opened Settings and Customization page: $data")
    @When("{I |}add following {dropdown|radio} choices on opened Settings and Customization page: $data")
    public void addDropdownChoices(ExamplesTable data) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());

        String defaultValue = null;
        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.clickAddChoiceButton();
            page.typeChoiceFieldName(row.get("Choice"));
            if (Boolean.parseBoolean(row.get("Default"))) {
                defaultValue = row.get("Choice");
            }
        }

        page.clickSaveButton();

        if (defaultValue != null) {
            page.selectDefaultValue(defaultValue);
            page.clickSaveButton();
        }

        getSut().getWebDriver().navigate().refresh();
    }

    @Given("{I |}set default value '$defaultValue' for {multi choice|radio button} field '$fieldName' in section '$sectionName' on Settings and Customization page")
    @When("{I |}set default value '$defaultValue' for {multi choice|radio button} field '$fieldName' in section '$sectionName' on Settings and Customization page")
    public void setDefaultValueForMultiChoiceField(String defaultValue, String fieldName, String sectionName) {
        MetadataFieldSettingsBlock page = clickMetadataButton(fieldName, sectionName);
        page.chooseDefaultDictionaryValue(defaultValue);
        page.clickSaveButton();
        getSut().getWebDriver().navigate().refresh();
    }

    @Given("{I |}set following default values chain for catalogue structure field '$fieldName' in section '$sectionName' on Settings and Customization page: $data")
    @When("{I |}set following default values chain for catalogue structure field '$fieldName' in section '$sectionName' on Settings and Customization page: $data")
    public void setDefaultValuesChainForCatalogueStructureField(String fieldName, String sectionName, ExamplesTable data) {
        MetadataFieldSettingsBlock page = clickMetadataButton(fieldName, sectionName);

        for (Map<String,String> row : parametrizeTableRows(data)) {
            page.chooseDefaultDictionaryValue(row.get("ChainItem"));
            page.clickSaveButton();
            if (page.isInheritButtonPresent(row.get("ChainItem"))) page.clickInheritButtonByName(row.get("ChainItem"));
        }
    }

    @Given("{I |}select item '$fieldValue' in '$fieldName' Active Metadata Preview combobox on opened metadata page")
    @When("{I |}select item '$fieldValue' in '$fieldName' Active Metadata Preview combobox on opened metadata page")
    public void selectItemInPreviewCombobox(String fieldValue, String fieldName) {
        getMetadataPage().selectItemInActiveMetadataPreviewDropdown(fieldName, fieldValue);
    }

    @Given("{I |}changed field name in description field to '$fieldName'")
    @When("{I |}change field name in description field to '$fieldName'")
    public void changeFieldName(String fieldName) {
        getMetadataPage().typeDescription(fieldName);
    }

    // expectedButtonNames are separated by comma
    @Then("{I |}'$condition' see button '$expectedButtonNames' in '$section' section on opened metadata page")
    public void checkThatButtonPresent(String condition, String expectedButtonNames, String section) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> buttonsList;
        MetadataPage page = getMetadataPage();

        if (section.equalsIgnoreCase("common metadata")) {
            buttonsList = page.getAllCommonMetadataButtonsNames();
        } else if (section.equalsIgnoreCase("editable metadata")) {
            buttonsList = page.getAllEditableMetadataButtonsNames();
        } else if (section.equalsIgnoreCase("custom metadata")) {
            buttonsList = page.getAllCustomMetadataButtonsNames();
        } else {
            throw new IllegalArgumentException(String.format("Unknown metadata section name '%s'", section));
        }

        List<String> actualButtonsList = new ArrayList<String>();
        for (String buttonName : buttonsList)
            actualButtonsList.add(buttonName.toLowerCase());

        for (String expectedButtonName: expectedButtonNames.split(",")) {
            expectedButtonName = expectedButtonName.toLowerCase();
            assertThat(actualButtonsList, shouldState ? hasItem(expectedButtonName) : not(hasItem(expectedButtonName)));
        }
    }

    // | FieldName |
    @Then("{I |}'$condition' see following fields in Active Metadata Preview block on opened metadata page: $data")
    public void checkThatFieldsPresent(String condition, ExamplesTable data) {
        String fields = "";

        for (Iterator<Map<String, String>> iterator = parametrizeTableRows(data).iterator(); iterator.hasNext(); )
            fields += iterator.hasNext() ? String.format("%s,", iterator.next().get("FieldName")) : iterator.next().get("FieldName");

        checkThatFieldPresent(condition, fields);
    }

    @Then("{I |}'$condition' see field '$fieldNames' in Active Metadata Preview block on opened metadata page")
    public void checkThatFieldPresent(String condition, String fieldNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList = getMetadataPage().getAllFieldsNamesFromActiveMetadataPreviewBlock();

        for (String expectedFieldName : fieldNames.split(","))
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFieldName) : not(hasItem(expectedFieldName)));
    }

    // | FieldName |
    @Then("{I |}'$condition' see following '$fieldType' fields in Active Metadata Preview block on opened metadata page: $data")
    public void checkThatFieldsPresent(String condition, String fieldType, ExamplesTable data) {
        CustomMetadataFieldType type = CustomMetadataFieldType.getForValue(fieldType);

        boolean shouldState = condition.equalsIgnoreCase("should");
        MetadataPage page = getMetadataPage();
        List<String> actualFields;

        if (type == CustomMetadataFieldType.DROPDOWN) {
            actualFields = page.getAllDropdownFieldsFromActiveMetadataPreviewBlock();
        } else if (type == CustomMetadataFieldType.MULTILINE) {
            actualFields = page.getAllMultilineFieldsFromActiveMetadataPreviewBlock();
        } else if (type == CustomMetadataFieldType.SECTION_BREAK) {
            actualFields = page.getAllVisibleBlocksFromActiveMetadataPreviewBlock();
        } else if (type == CustomMetadataFieldType.DATE) {
            actualFields = page.getAllVisibleDateFieldsFromActiveMetadataPreviewBlock();
        } else if (type == CustomMetadataFieldType.STRING) {
            actualFields = page.getAllVisibleStringFieldsFromActiveMetadataPreviewBlock();
        } else {
            throw new IllegalArgumentException(String.format("'%s' metadata field checking functionality is not implemented yet", fieldType));
        }

        for (Map<String, String> row : parametrizeTableRows(data))
            assertThat(actualFields, shouldState ? hasItem(row.get("FieldName")) : not(hasItem(row.get("FieldName"))));

    }

    // | FieldType | FieldName | FieldValue |
    @Then("{I |}'$condition' see following fields with selected values in Active Metadata Preview block on opened metadata page: $data")
    public void checkFieldsValuesOnPreview(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        MetadataPage page = getMetadataPage();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            String expectedFieldValue = row.get("FieldValue");
            String actualFieldValue;

            if (row.get("FieldType").equalsIgnoreCase("Dropdown")) {
                actualFieldValue = page.getDropdownFieldValueOnActiveMetadataPreviewBlock(row.get("FieldName"));
            } else if (row.get("FieldType").equalsIgnoreCase("RadioButtons")) {
                actualFieldValue = page.getRadioButtonsFieldValueOnActiveMetadataPreviewBlock(row.get("FieldName"));
            } else {
                throw new IllegalArgumentException(String.format("'%s' metadata field checking functionality is not implemented yet", row.get("FieldType")));
            }

            assertThat(actualFieldValue, shouldState ? equalTo(expectedFieldValue) : not(equalTo(expectedFieldValue)));
        }

    }

    // | Choice |
    @Then("{I |}'$condition' see following '$fieldType' '$fieldName' choices in Active Metadata Preview block on opened metadata page: $data")
    public void checkThatDropdownHasChoices(String condition, String fieldType, String fieldName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        MetadataPage page = getMetadataPage();

        List<String> actualChoices;

        if (fieldType.equalsIgnoreCase("dropdown")) {
            actualChoices = page.getAllDropdownChoicesByNameFromActiveMetadataPreviewBlock(fieldName);
        } else if (fieldType.equalsIgnoreCase("radio buttons")) {
            actualChoices = page.getAllRadioButtonsFieldChoicesByNameFromActiveMetadataPreviewBlock(fieldName);
        } else {
            throw new IllegalArgumentException(String.format("Unknown field type '%s'", fieldType));
        }

        for (Map<String, String> row : parametrizeTableRows(data))
            assertThat(actualChoices, shouldState ? hasItem(row.get("Choice")) : not(hasItem(row.get("Choice"))));
    }

    // | Choice |
    @Then("{I |}'$condition' see following radio button '$fieldName' choices in Active Metadata Preview block on opened metadata page: $data")
    public void checkThatRadioButtonsFieldHasChoices(String condition, String fieldName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        MetadataPage page = getMetadataPage();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            List<String> actualChoices = page.getAllRadioButtonsFieldChoicesByNameFromActiveMetadataPreviewBlock(fieldName);
            assertThat(actualChoices, shouldState ? hasItem(row.get("Choice")) : not(hasItem(row.get("Choice"))));
        }
    }

    @Then("{I |}'$condition' see {any|some} radio button '$fieldName' choices in Active Metadata Preview block on opened metadata page")
    public void checkThatRadioButtonsFieldHasSomeChoicesOnSettingsPage(String condition, String fieldName) {
        boolean actualState = condition.equalsIgnoreCase("should");
        boolean expectedState = getMetadataPage().getAllRadioButtonsFieldChoicesByNameFromActiveMetadataPreviewBlock(fieldName).isEmpty();

        assertThat(actualState, is(expectedState));
    }

    // | Choice |
    @Then("{I |}'$condition' see following choices on opened radio buttons field Settings and Customization page: $data")
    public void checkThatRadioButtonsFieldHasChoicesOnSettingsPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            List<String> actualChoices = page.getAllAddedChoices();
            assertThat(actualChoices, shouldState ? hasItem(row.get("Choice")) : not(hasItem(row.get("Choice"))));
        }
    }

    @Then("{I |}'$condition' see section break '$sectionBreakNames' in Active Metadata Preview block on opened metadata page")
    public void checkThatSectionBreakPresent(String condition, String sectionBreakNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualSectionBreakNamesList = getMetadataPage().getAllSectionBreakNamesFromActiveMetadataPreviewBlock();

        for (String expectedSectionBreakName : sectionBreakNames.split(","))
            assertThat(actualSectionBreakNamesList, shouldState ? hasItem(expectedSectionBreakName) : not(hasItem(expectedSectionBreakName)));
    }

    @Then("{I |}'$condition' see field '$fieldNames' marked as required in Active Metadata Preview block on opened metadata page")
    public void checkThatFieldMarkedAsRequired(String condition, String fieldNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldsList = getMetadataPage().getAllRequiredFieldsNamesFromActiveMetadataPreviewBlock();

        for (String expectedFieldName : fieldNames.split(","))
            assertThat(actualFieldsList, shouldState ? hasItem(expectedFieldName) : not(hasItem(expectedFieldName)));
    }

    @Then("{I |}'$condition' see multiline field '$fieldName' with rows count '$expectedCount' in Active Metadata Preview block on opened metadata page")
    public void checkThatMultilineFieldHasRows(String condition, String fieldName, String expectedCount) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualCount = getMetadataPage().getMultilineFieldRowsCount(fieldName);

        assertThat(actualCount, shouldState ? equalTo(expectedCount) : not(equalTo(expectedCount)));
    }

    @Then("{I |}'$condition' see Description field is red on opened Settings and Customization tab")
    public void checkThatDescriptionFieldIsRed(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new MetadataFieldSettingsBlock(getMetadataPage()).isDescriptionFieldRed();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Number of lines field is red on opened Settings and Customization tab")
    public void checkThatLinesNumberFieldIsRed(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new MetadataFieldSettingsBlock(getMetadataPage()).isLinesNumberFieldRed();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see error message '$expectedErrorMessage' next to Number of lines field on opened Settings and Customization tab")
    public void checkThatLinesNumberFieldIsRed(String condition, String expectedErrorMessage) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualErrorMessage = new MetadataFieldSettingsBlock(getMetadataPage()).getLinesNumberFieldErrorMessage();

        if (shouldState) {
            assertThat(actualErrorMessage, equalToIgnoringCase(expectedErrorMessage));
        } else {
            assertThat(actualErrorMessage, equalToIgnoringCase(""));
        }
    }

    // checkboxNames are separated by comma
    @Then("{I |}'$condition' see checked checkbox '$checkboxNames' on opened string field Settings and Customization page")
    public void checkThatCheckboxChecked(String condition, String checkboxNames) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        for (String checkboxName: checkboxNames.split(",")) {
            if (checkboxName.equalsIgnoreCase("Make it compulsory"))
                actualState = page.isCompulsoryCheckboxSelected();
            else if (checkboxName.equalsIgnoreCase("Make it readonly"))
                actualState = page.isMakeItReadOnlyCheckboxSelected();
            else if (checkboxName.equalsIgnoreCase("Mark as Advertiser"))
                actualState = page.isMarkAsAdvertiserCheckboxSelected();
            else if (checkboxName.equalsIgnoreCase("Mark as Product"))
                actualState = page.isMarkAsProductCheckboxSelected();
            else if (checkboxName.equalsIgnoreCase("Make this field available in Delivery"))
                actualState = page.isMakeThisFieldAvailableInDeliveryCheckBoxSelected();
            else if (checkboxName.equalsIgnoreCase("Display this field on your table view"))
                actualState = page.isDisplayThisFieldOnYourTableViewSelected();
            else if (checkboxName.equalsIgnoreCase("Display this field on your detailed view"))
                actualState = page.isDisplayThisFieldOnYourDetailedViewSelected();
            else if (checkboxName.equalsIgnoreCase("Make it common for order"))
                actualState = page.isMakeItCommonForOrderCheckBoxSelected();
            else if (checkboxName.equalsIgnoreCase("Mark as House Number"))
                actualState = page.isMarkAsHouseNumberSelected();
            else if (checkboxName.equalsIgnoreCase("Hide"))
                actualState = page.isHideCheckboxSelected();
            else {
                throw new IllegalArgumentException(String.format("Unknown checkbox name '%s' for string field settings page", checkboxName));
            }
            assertThat(actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see disabled checkbox 'Make it compulsory' on opened string field Settings and Customization page")
    public void checkThatCompulsoryCheckboxDisabled(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = new MetadataFieldSettingsBlock(getMetadataPage()).isCompulsoryCheckboxDisabled();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see field '$fieldNames' with size '$fieldSize' on opened Active Metadata Preview")
    public void checkFieldSize(String condition, String fieldNames, String fieldSize) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;
        MetadataPage page = getMetadataPage();

        for (String fieldName : fieldNames.split(",")) {
            actualState = page.isFieldHaveSize(fieldName, fieldSize);
            assertThat(actualState, is(expectedState));
        }
    }

    // | Advertiser | Brand | SubBrand | Product |
    @Then("{I |}'$condition' see following Advertiser chain on Settings and Customization page: $data")
    public void checkThatCompulsoryCheckboxDisabled(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            getMetadataPage().clickCommonMetadataButtonByName("Advertiser");

            if (row.get("Advertiser") != null && !row.get("Advertiser").isEmpty()) {
                String expectedAdvertiser = wrapVariableWithTestSession(row.get("Advertiser"));
                assertThat(page.getAllAddedChoices(), shouldState ? hasItem(expectedAdvertiser) : not(hasItem(expectedAdvertiser)));

                if (shouldState && row.get("Brand") != null && !row.get("Brand").isEmpty()) {
                    page.clickInheritButtonByName(expectedAdvertiser);
                    String expectedBrand = wrapVariableWithTestSession(row.get("Brand"));
                    assertThat(page.getAllAddedChoices(), hasItem(expectedBrand));

                    if (row.get("Sub Brand") != null && !row.get("Sub Brand").isEmpty()) {
                        page.clickInheritButtonByName(expectedBrand);
                        String expectedSubBrand = wrapVariableWithTestSession(row.get("Sub Brand"));
                        assertThat(page.getAllAddedChoices(), hasItem(expectedSubBrand));

                        if (row.get("Product") != null && !row.get("Product").isEmpty()) {
                            page.clickInheritButtonByName(expectedSubBrand);
                            String expectedProduct = wrapVariableWithTestSession(row.get("Product"));
                            assertThat(page.getAllAddedChoices(), hasItem(expectedProduct));
                        }
                    }
                }
            }

            getSut().getWebDriver().navigate().refresh();
        }
    }

    // | Description |
    @Then("{I |}'$condition' see following Catalogue Structure descriptions on opened Settings and Customization page: $data")
    public void checkCatalogueStructureDescriptions(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());
        List<String> actualDescriptions = page.getHierarchyNavigationBarItems();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            String expectedDescription = row.get("Description");
            assertThat(actualDescriptions, shouldState ? hasItem(expectedDescription) : not(hasItem(expectedDescription)));
        }
    }

    // | FieldName |
    @Then("{I |}'$condition' see metadata fields and groups in following order in Active Metadata Preview block on opened metadata page: $data")
    public void checkFieldOrderOnMetadataPreview(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldList = getMetadataPage().getAllVisibleFieldsAndBlocksFromActiveMetadataPreviewBlock();
        List<String> expectedFieldList = new ArrayList<String>();

        for (Map<String, String> row : parametrizeTableRows(data)) expectedFieldList.add(row.get("FieldName"));

        for (int i = 0; i < expectedFieldList.size(); i++) {
            assertThat(actualFieldList.get(i), shouldState ? equalTo(expectedFieldList.get(i)) : not(equalTo(expectedFieldList.get(i))));
        }
    }

    // | FieldName |
    @Then("{I |}'$condition' see following metadata fields and groups in Active Metadata Preview block on opened metadata page: $data")
    public void checkFieldsPresenceOnMetadataPreview(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFieldList = getMetadataPage().getAllVisibleFieldsAndBlocksFromActiveMetadataPreviewBlock();
        List<String> expectedFieldList = new ArrayList<String>();
        for (Map<String, String> row : parametrizeTableRows(data)) expectedFieldList.add(row.get("FieldName"));

        for (String expectedField : expectedFieldList) assertThat(actualFieldList, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
    }

    // | Item | Condition |
    @Then("{I |}should see following Catalogue Structure items with selected '$optionName' option on opened Settings and Customization page: $data")
    public void checkCatalogueStructureItemsOption(String optionName, ExamplesTable data) {
        MetadataFieldSettingsBlock page = new MetadataFieldSettingsBlock(getMetadataPage());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            boolean expectedState = row.get("Condition").equalsIgnoreCase("should");
            boolean actualState;

            page.clickHierarchyNavigationBarItemByName(row.get("Item"));

            if (optionName.equalsIgnoreCase("make it compulsory")) {
                actualState = page.isCompulsoryCheckboxSelected();
            } else if (optionName.equalsIgnoreCase("hide")) {
                actualState = page.isHideCheckboxSelected();
            } else if (optionName.equalsIgnoreCase("add values on the fly")) {
                actualState = page.isAddOnTheFlyCheckboxSelected();
            } else if (optionName.equalsIgnoreCase("multiple choices")) {
                actualState = page.isMultipleChoicesCheckboxSelected();
            } else {
                throw new IllegalArgumentException(String.format("Unknown checkbox name '%s' for string field settings page", optionName));
            }

            assertThat(actualState, is(expectedState));
        }
    }

    protected MetadataPage getMetadataPage() {
        return getSut().getPageCreator().getMetadataPage();
    }

    private CustomMetadata addValues(CustomMetadata result, List<String> items) {
        String key = items.remove(0);

        boolean hasKey = false;
        for (CustomMetadata value : (ArrayList<CustomMetadata>)result.get("values")) {
            if (key.equals(value.get("key"))) {
                hasKey = true;
                break;
            }
        }

        if (!hasKey) {
            CustomMetadata item = new CustomMetadata();
            String[] keyItem = key.split(";");
            if(keyItem.length>1){
                item.put("key", wrapVariableWithTestSession(keyItem[0]));
                item.put("additionalParameter", keyItem[1]);
            } else
            item.put("key", key);
            if (!items.isEmpty() && items.get(0) != null && !items.get(0).isEmpty()) item.put("values", new ArrayList<CustomMetadata>());
            ((ArrayList<CustomMetadata>)result.get("values")).add(item);
        }

        if (!items.isEmpty() && items.get(0) != null && !items.get(0).isEmpty()) {
            addValues(((ArrayList<CustomMetadata>)result.get("values")).get(((ArrayList<CustomMetadata>)result.get("values")).size() - 1), items);
        }
        return result;
    }

    public void checkOnAdditionalMetadataField(Map<String, String> row, MetadataFieldSettingsBlock page) {
        boolean isAddOnTheFly = row.containsKey("AddOnFly") && (Boolean.parseBoolean(row.get("AddOnFly")) || row.get("AddOnFly").equals("should"));
        boolean isMultipleChoices = row.containsKey("MultipleChoices") && (Boolean.parseBoolean(row.get("MultipleChoices")) || row.get("MultipleChoices").equals("should"));
        boolean isMakeItCompulsory = row.containsKey("Compulsory") && (Boolean.parseBoolean(row.get("Compulsory")) || row.get("Compulsory").equals("should"));
        boolean isMarkedAsProduct = row.containsKey("Mark As Product") && (Boolean.parseBoolean(row.get("Mark As Product")) || row.get("Mark As Product").equals("should"));

        if (isAddOnTheFly) page.checkAddOnTheFly();
        if (isMultipleChoices) page.checkMultipleChoices();
        if (isMakeItCompulsory) page.checkMakeItCompulsory();
        if (isMarkedAsProduct) page.tickMarkAsProduct();
    }

    private String getDictionaryId(String schemaName, String sectionName, String fieldName, String agencyId) {
        if (schemaName.equalsIgnoreCase("common")) {
            AssetElementProjectCommonSchema assetElementProjectCommonSchema = getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);
            return assetElementProjectCommonSchema.getFieldDictionaryIdFromSectionByDescription(sectionName, fieldName);
        } else if (schemaName.equalsIgnoreCase("project")) {
            ProjectSchema projectSchema = getCoreApiAdmin().getProjectSchema(agencyId);
            return projectSchema.getFieldDictionaryIdFromSectionByDescription(sectionName, fieldName);
        } else if (schemaName.equalsIgnoreCase("asset")) {
            AssetElementCommonSchema assetElementCommonSchema = getCoreApiAdmin().getAssetElementCommonSchema(agencyId);
            return assetElementCommonSchema.getFieldDictionaryIdFromSectionByDescription(sectionName, fieldName);
        } else {
            throw new IllegalArgumentException(String.format("Unknown schema name '%s', available schemas are common, project or asset", schemaName));
        }
    }

    protected Schema getSchemaByName(String schemaName, String agencyId) {
        if (CustomMetadataSchemaName.isCommonSchema(schemaName))
            return getCoreApiAdmin().getAssetElementProjectCommonSchema(agencyId);
        else if (CustomMetadataSchemaName.isProjectSchema(schemaName))
            return getCoreApiAdmin().getProjectSchema(agencyId);
        else if (CustomMetadataSchemaName.isAssetSchema(schemaName))
            return getCoreApiAdmin().getAssetElementCommonSchema(agencyId);
        else
            throw new IllegalArgumentException("Unknown schema: " + schemaName);
    }

    protected void updateSchemaByName(String schemaName, String agencyId, Schema schema) {
        if (CustomMetadataSchemaName.isCommonSchema(schemaName))
            getCoreApiAdmin().updateAssetElementProjectCommonSchema(agencyId, (AssetElementProjectCommonSchema)schema);
        else if (CustomMetadataSchemaName.isProjectSchema(schemaName))
            getCoreApiAdmin().updateProjectSchema(agencyId, (ProjectSchema)schema);
        else if (CustomMetadataSchemaName.isAssetSchema(schemaName))
            getCoreApiAdmin().updateAssetElementCommonSchema(agencyId, (AssetElementCommonSchema)schema);
        else
            throw new IllegalArgumentException("Unknown schema: " + schemaName);
    }

    // | FieldName |
    @Given("{I |}sorted common ordering fields into group '$groupName' in following order in Active Metadata Preview block on opened metadata page: $data")
    @When("{I |}sort common ordering fields into group '$groupName' in following order in Active Metadata Preview block on opened metadata page: $data")
    public void moveCommonOrderingFieldsIntoGroup(String groupName, ExamplesTable data) {
        List<String> fieldsList = new ArrayList<String>();
        for (Map<String, String> row : parametrizeTableRows(data)) fieldsList.add(row.get("FieldName"));
        getMetadataPage().reorderCommonOrderingFieldsIntoGroup(fieldsList, groupName);
    }

    @Given("{I |}set custom characters for catalogue structure field '$fieldName' in section '$sectionName' on Settings and Customization page: $data")
    @When("{I |}set custom characters  for catalogue structure field '$fieldName' in section '$sectionName' on Settings and Customization page: $data")
    public void setCustomCharactersForCatalogueStructureField(String fieldName, String sectionName, ExamplesTable data) {
        MetadataFieldSettingsBlock page = clickMetadataButton(fieldName, sectionName);

        for (Map<String,String> row : parametrizeTableRows(data)) {
            page.typeFieldChoiceCustomCharacters(wrapVariableWithTestSession(row.get("ChainItem")), row.get("CustomCharacters"));
            page.clickSaveButton();
            Common.sleep(100);
            if (page.isInheritButtonPresent(wrapVariableWithTestSession(row.get("ChainItem")))) page.clickInheritButtonByName(wrapVariableWithTestSession(row.get("ChainItem")));
        }
    }
}