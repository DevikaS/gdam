package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyOverviewPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.EditAgencyPopup;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Map;
import java.util.Random;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * User: lynda-k
 * Date: 12.06.14
 * Time: 12:00
 */
public class AgencyOverviewSteps extends BaseStep {

    private AgencyOverviewPage getAgencyOverviewPage() {
        return getSut().getPageCreator().getAgencyOverviewPage();
    }

    private void fillingAgencyFields(EditAgencyPopup popup, ExamplesTable data) {
        for (Map<String,String> field : parametrizeTableRows(data)) {
            String name = field.get("FieldName");
            String value = field.get("FieldValue");

            if (name.equals("Name")) {
                popup.fillNameField(wrapVariableWithTestSession(value));
            } else if (name.equals("Description")) {
                popup.fillDescriptionField(value);
            } else if (name.equals("Pin")) {
                popup.fillPinField(value);
            } else if (name.equals("Type")) {
                popup.fillTypeField(value);
            } else if (name.equals("Market")) {
                popup.fillMarketField(value);
            } else if (name.equals("DestinationID")) {
                popup.fillDestinationIdField(value);
            } else if (name.equals("DestinationIDUnique")) {
                Random randomGenerator = new Random();
                popup.fillDestinationIdField(value+Integer.valueOf(randomGenerator.nextInt(1000)));
            }else if (name.equals("Time Zone")) {
                popup.fillTimeZoneField(value);
            } else if (name.equals("Country")) {
                popup.fillCountryField(value);
            } else if (name.equals("SAP Country")) {
                popup.fillSAPCountryField(value);
            } else if (name.equals("SAP Enabled")) {
                popup.fillEnableSAPEnabledCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("SAP ID")) {
                popup.fillSAPIdField(value);
            } else if (name.equals("Client Code")) {
                popup.fillClientCodeField(value);
            } else if (name.equals("Storage")) {
                popup.fillStorageField(value);
            } else if (name.equals("Ingest Location")) {
                popup.fillIngestLocationField(value);
            } else if (name.equals("A4 Agency ID")) {
                popup.fillA4AgencyIdField(value);
            } else if (name.equals("footer-text")) {
                popup.fillFooterTextField(value);
            } else if (name.equals("footer-text-color")) {
                popup.fillFooterTextColorField(value);
            } else if (name.equals("footer-color")) {
                popup.fillFooterColorField(value);
            } else if (name.equals("BU Labels")) {
                popup.fillBULabelsField(asList(value.split(",")));
            } else if (name.equals("A4 User Email")) {
                popup.fillA4UserEmailField(wrapUserEmailWithTestSession(value));
            } else if (name.equals("A4 User Password")) {
                popup.fillA4UserPasswordField(value);
            } else if (name.equals("A4 Create Asset")) {
                popup.fillA4CreateAssetCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("Branding color")) {
                popup.fillBrandingColorField(value);
                //} else if (name.equals("Branding logo")) {
                //    popup.fillBrandingLogoField(value);
            } else if (name.equals("Branding link color")) {
                popup.fillBrandingLinkColorField(value);
            } else if (name.equals("Auto accept shared categories")) {
                popup.fillAutoAcceptorField(wrapUserEmailWithTestSession(value));
            } else if (name.equals("Allow extend dictionaries when accepting shared assets")) {
                popup.fillAllowExtendDictionariesCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("Enable Finder")) {
                popup.fillEnableFinderStyleProjectView(Boolean.parseBoolean(value));
            } else if (name.equals("Publish Projects Immediately by Default")) {
                popup.fillPublishProjectOnCreateCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("Hide Template field on Create New Project forms")) {
                popup.fillHideTemplateOnProjectCreateCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("User Self Registers")) {
                popup.fillUserSelfRegistersCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("Enable Projects Module")) {
                popup.fillEnableProjectsModuleCheckbox(Boolean.parseBoolean(value));
                // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Starts
            }else if (name.equals("Enable Work Requests Feature")) {
                popup.fillEnableWorkRequestssModuleCheckbox(Boolean.parseBoolean(value));
            }else if (name.equals("Enable Presentations Feature")) {
                popup.fillEnablePresentationsModuleCheckbox(Boolean.parseBoolean(value));
            }else if (name.equals("Enable Delivery Module")) {
                popup.fillEnableDeliveryModuleCheckbox(Boolean.parseBoolean(value));
                // NGN-16213 - QAA: Global Admin defines Applications available to BU - By Geethanjali- code Ends
            } else if (name.equals("Enable Library Module")) {
                popup.fillEnableLibraryModuleCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("Enable Approvals Feature")) {
                popup.fillEnableApprovalsModuleCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Enable Annotations Feature")) {
                popup.fillEnableAnnotationsModuleCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Enable Auto Close Approval")) {
                popup.fillEnableAutoCloseApprovalCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Enable Media Supplier")) {
                popup.fillEnableMediaSupplierCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Default Save in Library")) {
                popup.fillEnableDefaultSaveInLibraryCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Allow User to Change Save in Library")) {
                popup.fillEnableAllowUserToChangeSaveInLibraryCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Enable Project Access Rules")) {
                popup.fillEnableProjectAccessRulesCheckbox(Boolean.parseBoolean(value));
                // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code starts
            }else if (name.equalsIgnoreCase("Enable Traffic Module")) {
                popup.fillEnableTrafficModuleCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Enable Ingest Module")) {
                popup.fillEnableIngestModuleCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Enable Reporting Module")) {
                popup.fillEnableReportingModuleCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Enable Dashboard feature")) {
                popup.fillEnableDashboardfeatureCheckbox(Boolean.parseBoolean(value));
                // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code Ends
            } else if (name.equalsIgnoreCase("Default Value of Manage Conversion Flag")) {
                popup.fillDefaultValueOfManageConversionFlagCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Allow User to Change Manage Conversion Flag")) {
                popup.fillAllowUserToChangeManageConversionFlagCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Enables TASKS Module")) {
                popup.fillEnablesTasksModuleCheckbox(Boolean.parseBoolean(value));
            }
        }
    }

    @Given("{I am |}on agency '$agencyName' overview page")
    @When("{I |}go to agency '$agencyName' overview page")
    public AgencyOverviewPage openAgencyOverviewPage(Agency agency) {
        return getSut().getPageNavigator().getAgencyOverviewPage(agency.getId());
    }

    @Given("{I |}filled following fields for agency '$agencyName' on Edit agency popup: $data")
    @When("{I |}fill following fields for agency '$agencyName' on Edit agency popup: $data")
    public void fillAgencyFields(Agency agency, ExamplesTable data) {
        EditAgencyPopup popup = openAgencyOverviewPage(agency).getEditAgencyPopUp();
        fillingAgencyFields(popup, data);
    }

    @Given("{I |}updated agency '$agencyName' with following fields on agency overview page: $data")
    @When("{I |}update agency '$agencyName' with following fields on agency overview page: $data")
    public void editAgency(Agency agency, ExamplesTable data) {
        EditAgencyPopup popup = openAgencyOverviewPage(agency).getEditAgencyPopUp();
        fillingAgencyFields(popup, data);
        WebElement Button = getSut().getWebDriver().findElement(By.cssSelector(".button"));
        getSut().getWebDriver().getJavascriptExecutor().executeScript("arguments[0].scrollIntoView(true);",Button );
        popup.clickAction();
    }

    @Given("{I |}updated agency '$agency' trigger repeat interval")
    @When("{I |}update agency '$agency' trigger repeat interval")
    public void updateTrigger(Agency agency) {
        DBCollection collection = getMongoDB().getCollection("triggers");
        BasicDBObject query = new BasicDBObject();
        query.put("_id", String.format("%sAutoAcceptGroup/%sAutoAcceptTrigger", agency.getId(), agency.getId()));
        BasicDBObject filter = new BasicDBObject();
        filter.append("$set", new BasicDBObject().append("repeatInterval", 30*1000).append("nextFireTime", DateTime.now().plusSeconds(20).toDate()));
        collection.update(query, filter);
    }

    @Then("{I |}'$condition' see following fields on agency overview page: $data")
    public void checkFieldsOnPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> actualFields = getAgencyOverviewPage().getFullFieldsMap();
        for (MetadataItem expectedField : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            if(expectedField.getKey().equalsIgnoreCase("DestinationID")){
                for(  MetadataItem actualField : actualFields ) {
                    if (actualField.getKey().equalsIgnoreCase("DestinationID")) {
                        assertThat("Destination Id did not Match", actualField.getValue().contains(expectedField.getValue()), is(shouldState));
                        break;
                    }
                }
                }else {
                    if (expectedField.getKey().equals("Auto accept shared categories")) {
                        if (expectedField.getValue() == null || expectedField.getValue().isEmpty()) {
                            expectedField.setValue("");
                        } else if (!expectedField.getValue().equalsIgnoreCase("false")) {
                            expectedField.setValue(String.format("true (%s)", new EmailSteps().getUserFullName(expectedField.getValue())));
                        }
                    }
                    assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
                }
        }
    }

    // fieldNamesList: Market, DestinationID, etc
    @Then("{I |}'$shouldState' see following fields '$fieldNamesList' on Edit agency popup")
    public void checkAgencyPopUpFieldsVisibility(String shouldState, String fieldNamesList) {
        EditAgencyPopup popup = getAgencyOverviewPage().getEditAgencyPopUp();
        boolean should = shouldState.equalsIgnoreCase("should");
        for (String fieldName: fieldNamesList.split(",")) {
            boolean isFieldVisible;
            switch (fieldName) {
                case "Market" : isFieldVisible = popup.isMarketFieldVisible(); break;
                case "DestinationID": isFieldVisible = popup.isDestinationIdFieldVisible(); break;
                default: throw new IllegalArgumentException("Unknown field: " + fieldName);
            }
            assertThat("Check visibility of " + fieldName, isFieldVisible, is(should));
        }
    }

    // fieldNamesList: DestinationID, etc
    @Then("{I |}'$shouldState' see validation error for following fields '$fieldNamesList' on Edit agency popup")
    public void checkAgencyPopUpFieldsValidation(String shouldState, String fieldNamesList) {
        EditAgencyPopup popup = getAgencyOverviewPage().getEditAgencyPopUp();
        boolean should = shouldState.equalsIgnoreCase("should");
        for (String fieldName: fieldNamesList.split(",")) {
            switch (fieldName) {
                case "DestinationID": assertThat("Check validation for field " + fieldName, popup.isDestinationIdFieldValidationErrorVisible(), is(should)); break;
                default: throw new IllegalArgumentException("Unknown field: " + fieldName);
            }
        }
    }
    // fieldName: Type, Market, etc
    @Then("{I |}'$shouldState' see following values '$values' for field '$fieldName' on Edit agency popup")
    public void checkAgencyPopUpFieldValues(String shouldState, String values, String fieldName) {
        EditAgencyPopup popup = getAgencyOverviewPage().getEditAgencyPopUp();
        boolean should = shouldState.equalsIgnoreCase("should");
        List<String> fieldValues;
        switch (fieldName) {
            case "Type": fieldValues = popup.getTypeFieldValues(); break;
            case "Market": fieldValues = popup.getMarketFieldValues(); break;
            default: throw new IllegalArgumentException("Unknown field: " + fieldName);
        }
        for (String value: values.split(","))
            assertThat("Check availability values for field: " + fieldName, fieldValues, should ? hasItem(value) : not(hasItem(value)));
    }
    // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code Starts
    @Then("{I |}'$condition' see following fields on agency overview page For diffrent agency '$Type' Types: $data")
    public void checkFieldsOnPageCopyBU(String condition, String Type, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<MetadataItem> actualFields = getAgencyOverviewPage().getFullFieldsMap();
        if(Type.equalsIgnoreCase("TV Broadcaster")){
            for(  MetadataItem expectedField : wrapMetadataFields(data, "FieldName", "FieldValue")){
                if(expectedField.getKey().equalsIgnoreCase("DestinationID")){
                    for(  MetadataItem actualField : actualFields ) {
                        if (actualField.getKey().equalsIgnoreCase("DestinationID"))
                            assertThat("Destination Id did not Match" ,actualField.getValue().contains(expectedField.getValue()), is(shouldState));
                    }
                }else {
                    assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
                }
            }
        }
        if(Type.equalsIgnoreCase("TV Broadcaster Hub")){
            for(  MetadataItem expectedField : wrapMetadataFields(data, "HubFieldName", "HubFieldValue")){

                assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
            }
        }
        if(Type.equalsIgnoreCase("agency")){
            for(  MetadataItem expectedField : wrapMetadataFields(data, "AgencyFieldName", "AgencyFieldValue")){

                assertThat(actualFields, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
            }
        }

    }
    // NGN-16212 - QAA: Global Admin can Copy BU - By Geethanjali- code Ends
}