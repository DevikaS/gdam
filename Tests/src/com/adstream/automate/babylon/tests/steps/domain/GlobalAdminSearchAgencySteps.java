package com.adstream.automate.babylon.tests.steps.domain;


import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.GlobalAdminSearchAgencyPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.SearchAgencyModelForm;
import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.AgencyList;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.NewAgencyPopup;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;
import java.util.Map;
import java.util.Random;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by Geethanjali.K on 20-01-2016-NGN16208
 */
public class GlobalAdminSearchAgencySteps extends UserSteps {

    private GlobalAdminSearchAgencyPage openGlobalAdminSearchAgencyPage() {
        return getSut().getPageNavigator().getGlobalAdminSearchAgencyPage();
    }

    private GlobalAdminSearchAgencyPage getGlobalAdminSearchAgencyPage() {
        return getSut().getPageCreator().getGlobalAdminSearchAgencyPage();
    }

    private SearchAgencyModelForm getSearchAgencyModelForm() {
        return getGlobalAdminSearchAgencyPage().getSearchAgencyModelForm();
    }

    private AgencyList getAgencyList() {
        return getGlobalAdminSearchAgencyPage().getAgencyList();
    }

    private Map<String, String> prepareSearchAgencyFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Business_Unit name") && !row.get("Business_Unit name").isEmpty()) row.put("Business_Unit name", wrapAgencyName(row.get("Business_Unit name")));
        if (row.containsKey("Type") && !row.get("Type").isEmpty()) row.put("Type", row.get("Type"));
        if (row.containsKey("Country") && !row.get("Country").isEmpty()) row.put("Country", row.get("Country"));
        if (row.containsKey("Storage") && !row.get("Storage").isEmpty()) row.put("Storage",row.get("Storage"));

        return row;
    }

    private Map<String, String> prepareSearchAgencyWithoutTestSessionFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Business_Unit name") && !row.get("Business_Unit name").isEmpty()) row.put("Business_Unit name", row.get("Business_Unit name"));
        if (row.containsKey("Type") && !row.get("Type").isEmpty()) row.put("Type", row.get("Type"));
        if (row.containsKey("Country") && !row.get("Country").isEmpty()) row.put("Country", row.get("Country"));
        if (row.containsKey("Storage") && !row.get("Storage").isEmpty()) row.put("Storage",row.get("Storage"));

        return row;
    }

    @Given("{I am |}on the global search BU page")
    @When("{I |}go to the global search BU page")
    public GlobalAdminSearchAgencyPage goToGlobalAdminSearchAgencyPage() {
        return openGlobalAdminSearchAgencyPage();
    }

    // | Type | Country | Business Unit |
    @When("{I |}fill following fields on the global search BU page: $fieldsTable")
    public void fillGlobalSearchAgencyForm(ExamplesTable fieldsTable) {
        getSearchAgencyModelForm().fill(prepareSearchAgencyFormData(fieldsTable));
    }

    // | Type | Country | Business Unit |
    @When("{I |}fill following fields on the global search BU page without Testsession: $fieldsTable")
    public void fillGlobalSearchWithoutTestSessionAgencyForm(ExamplesTable fieldsTable) {
        getSearchAgencyModelForm().fill(prepareSearchAgencyWithoutTestSessionFormData(fieldsTable));
    }

    @When("{I |}do searching on the global search BU page")
    public void searchAgency() {
        getSearchAgencyModelForm().search();
    }

    // | Type | Country | Business Unit |
    @Then("{I |}should see following datas on the global search users page: $fieldsTable")
    public void checkGlobalSearchUsersFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareSearchAgencyFormData(fieldsTable);
        SearchAgencyModelForm form = getSearchAgencyModelForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }



    //  | Business Unit | Type | Country | Storage |
    @Then("{I |}should see following BU s on the global search Agency page: $fieldsTable")
    public void checkAgencyList(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Business Unit name")) row.put("Business Unit name", wrapAgencyName(row.get("Business Unit name")));
        if (row.containsKey("Type")) row.put("Type", String.valueOf((row.get("Type"))));
        if (row.containsKey("Country")) row.put("Country",row.get("Country"));
       // if (row.containsKey("Storage")) row.put("Storage", row.get("Storage"));
      //  if (row.containsKey("Business Unit")) row.put("Business Unit", wrapAgencyName(row.get("Business Unit")));
        AgencyList.Agency agency = getAgencyList().getAgencyByName(row.get("Business Unit name"));
        if (row.containsKey("Business Unit name")) assertThat("Check business unit: ", agency.getBusinessUnit(), equalTo(row.get("Business Unit name")));
        if (row.containsKey("Type")) assertThat("Check Agency Type: ", agency.getType(), equalTo(row.get("Type")));
        if (row.containsKey("Country")) assertThat("Check Country of Agency: ", agency.getCountry(), equalTo(row.get("Country")));
    }



    @Then("{I |}'$shouldState' see no results on the global search Agency page")
    public void checkNoOneAgencyVisibility(String shouldState) {
        assertThat("Check no results on global search agency page ", getAgencyList().getEmptyMessage(), containsString("No results to display"));
    }

    @Given("{I |}create copy of BU '$agencyName' with following fields on Global Admin search agency page: $data")
    @When("{I |}create copy of BU '$agencyName' with following fields on Global Admin search agency page: $data")
    public void CopyBU(String agency, ExamplesTable data) {
        NewAgencyPopup popup = openGlobalAdminSearchAgencyPage().clickNewBU();
        fillingAgencyFields(popup, data, agency);
        popup.clickActionNoDelay();
    }

     @Then("{I should see |}message {warning|success} '$message' on creating copy of BU '$agencyName' with following fields on Global Admin search agency page: $data")
    public void CopyBUandCheckWarningMessage(String message,String agency, ExamplesTable data) {
        NewAgencyPopup popup = openGlobalAdminSearchAgencyPage().clickNewBU();
        BasePage page = getSut().getPageCreator().getBasePage();
        fillingAgencyFields(popup, data, agency);
        popup.clickActionNoDelay();
        if (!message.trim().isEmpty()) {
            String actualMessage = page.getPopUpNotificationMessage();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }
    }

    @Given("{I |}create copy of agency '$agencyName' with following fields on Global Admin search agency page: $data")
    @When("{I |}create copy of agency '$agencyName' with following fields on Global Admin search agency page: $data")
    public void AddAgency(String agency, ExamplesTable data) {
        NewAgencyPopup popup = openGlobalAdminSearchAgencyPage().clickNewBU();
        fillingAgencyFields(popup, data, agency);
        popup.clickAction();
        String page_url = getSut().getPageUrl();
        String startAgencyUrl = "/units#/units/";
        int startIndex = page_url.indexOf("startAgencyUrl") + startAgencyUrl.length()+1;
        int endIndex = page_url.indexOf("/overview", startIndex);
        String agencyid = page_url.substring(startIndex, endIndex);
        storeInAgency(popup,agency,agencyid);
    }

    public void storeInAgency(NewAgencyPopup popup, String agency,String agencyid ) {
        Agency newDesiredAgency = new Agency();  // todo agency builder
        newDesiredAgency.setName(popup.getNameFieldValue());
        newDesiredAgency.setId(agencyid);
        getData().addAgency(newDesiredAgency.getName(), newDesiredAgency);
    }

    private void fillingAgencyFields(NewAgencyPopup popup, ExamplesTable data, String agency ) {
        for (Map<String,String> field : parametrizeTableRows(data)) {
            String name = field.get("FieldName");
            String value = field.get("FieldValue");
            if(name.equals("CopyExistingBU")) {
                popup.fillCopyExistingBUField(wrapVariableWithTestSession(value));
                Common.sleep(4000);
            }else if (name.equals("Name")) {
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
                if(value!=null && !value.isEmpty()){
                Random randomGenerator = new Random();
                popup.fillDestinationIdField(value+randomGenerator.nextInt(1000));
                }
            } else if (name.equals("Time Zone")) {
                popup.fillTimeZoneField(value);
            } else if (name.equals("Country")) {
                popup.fillCountryField(value);
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
            } else if (name.equals("Enable Library Module")) {
                popup.fillEnableLibraryModuleCheckbox(Boolean.parseBoolean(value));
            } else if (name.equals("Enable Approvals Module")) {
                popup.fillEnableApprovalsModuleCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Enable Annotations Module")) {
                popup.fillEnableAnnotationsModuleCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Enable Auto Close Approval")) {
                popup.fillEnableAutoCloseApprovalCheckbox(Boolean.parseBoolean(value));
            } else if (name.equalsIgnoreCase("Enable Media Supplier")) {
                popup.fillEnableMediaSupplierCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Default Save in Library")) {
                popup.fillEnableDefaultSaveInLibraryCheckbox(Boolean.parseBoolean(value));
            }else if (name.equalsIgnoreCase("Allow User to Change Save in Library")) {
                popup.fillEnableAllowUserToChangeSaveInLibraryCheckbox(Boolean.parseBoolean(value));
            }
        }
    }



}