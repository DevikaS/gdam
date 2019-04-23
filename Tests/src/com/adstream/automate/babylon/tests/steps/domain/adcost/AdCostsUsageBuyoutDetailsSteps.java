package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsUsageBuyoutDetailsPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.utils.Common;
import org.apache.tools.ant.taskdefs.Touch;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.Months;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.is;

import static org.hamcrest.Matchers.is;

/**
 * Created by Raja.Gone on 16/05/2017.
 */
public class AdCostsUsageBuyoutDetailsSteps extends AdCostsHelperSteps {

    protected AdCostsUsageBuyoutDetailsPage openAdCostsUsageBuyoutDetailsPage() {
        AdCostsUsageBuyoutDetailsPage usageBuyoutDetailsPage = getSut().getPageCreator().getAdCostsUsageBuyoutDetailsPage();
        if (usageBuyoutDetailsPage.waitUntilUsageBuyoutDetailsPageVisible())
            return new AdCostsUsageBuyoutDetailsPage(getSut().getWebDriver());
        else
            throw new Error("Unable to open Usage-Buyout-Details page");
    }

    @Given("{I |}filled for '$costType' costType on buyout usage details page with following fields: $data")
    @When("{I |}fill for '$costType' costType on buyout usage  details page with following fields: $data")
    public void fillBuyoutUsageDetailsThrowUI(String costType, ExamplesTable data) {
        //openUsageBuyoutDetailsPage(costType);
        fillUsageDetails(data);
        clickButtonName("Continue");
    }

    @Given("{I |}filled for UsageBuyout cost on buyout usage details page with following fields: $data")
    @When("{I |}fill for UsageBuyout cost on buyout usage details page with following fields: $data")
    public void fillBuyoutUsageDetailsThrowUIx(ExamplesTable data) {
        fillUsageDetailsFieldsViaUI(data).clickBtnByName("Continue");
    }

    @Given("{I am |}on '$costType' costType buyout usage details page")
    @When("{I |}go to '$costType' costType buyout usage details page")
    @Alias("{I |}open '$costType' costType buyout usage details page")
    public AdCostsUsageBuyoutDetailsPage openUsageBuyoutDetailsPage() {
        return openAdCostsUsageBuyoutDetailsPage();
    }

    @Given("{I |}filled following fields on buyout usage details page: $data")
    @When("{I |}fill following fields on buyout usage details page: $data")
    @Alias("{I |}update following fields on buyout usage details page: $data")
    public void fillUsageDetails(ExamplesTable data) {
        AdCostsUsageBuyoutDetailsPage usageBuyoutDetailsPage = getSut().getPageNavigator().getAdCostsUsageBuyoutDetailsPage();
        for (MetadataItem row : wrapMetadataFields_Adcost(data, "FieldName", "FieldValue")) {
            usageBuyoutDetailsPage.fillFieldByName(row.getKey(), row.getValue());
        }
    }

    private AdCostsUsageBuyoutDetailsPage fillUsageDetailsFieldsViaUI(ExamplesTable fieldsTable) {
        AdCostsUsageBuyoutDetailsPage usageBuyoutDetailsPage = openUsageBuyoutDetailsPage();
        usageBuyoutDetailsPage.waitUntilAllFeildsLoads();

        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        // have to check with Manual QAs, need to change once fixed

        if (AdCostsData.containsField(AdCostsSchemaField.STARTDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.STARTDATE, row);
            if (checkDateFormatINddMMyyyy(date))
                usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.STARTDATE), date);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.TOUCHPOINTS, row, false)) {
            for (String touchPoints : AdCostsData.getField(AdCostsSchemaField.TOUCHPOINTS, row).split(",")) {
                usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TOUCHPOINTS), touchPoints);
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.AIRINGCOUNTRIES, row, false)) {
            for (String countryName : AdCostsData.getField(AdCostsSchemaField.AIRINGCOUNTRIES, row).split(",")) {
                usageBuyoutDetailsPage.fillFieldByName("Airing Country / Region", countryName);
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.ENDDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.ENDDATE, row);
            if (checkDateFormatINddMMyyyy(date))
                usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ENDDATE), date);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.EXCLUSIVITY, row, false)) {
            if (AdCostsData.getField(AdCostsSchemaField.EXCLUSIVITY, row).contains("yes, if yes specify category")) {
                usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.EXCLUSIVITY), AdCostsData.getField(AdCostsSchemaField.EXCLUSIVITY, row));
                if (AdCostsData.containsField(AdCostsSchemaField.EXCLUSIVITYCATEGORY, row, false)) {
                    for (String exclusiveCategory : AdCostsData.getField(AdCostsSchemaField.EXCLUSIVITYCATEGORY, row).split(",")) {
                        usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.EXCLUSIVITYCATEGORY), exclusiveCategory);
                    }
                }
            } else
                usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.EXCLUSIVITY), AdCostsData.getField(AdCostsSchemaField.EXCLUSIVITY, row));
        }

        if (AdCostsData.containsField(AdCostsSchemaField.NAME, row, false)) {
            usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NAME), getDictionaryValueByName("BuyoutName", AdCostsData.getField(AdCostsSchemaField.NAME, row)));
        }
        /*if (AdCostsData.containsField(AdCostsSchemaField.NAMEOFLICENSOR, row, false)) {
            usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NAMEOFLICENSOR), getDictionaryValueByName("LicensorName", AdCostsData.getField(AdCostsSchemaField.NAMEOFLICENSOR, row)));
        }*/
        if (AdCostsData.containsField(AdCostsSchemaField.MUSICTYPE, row, false)) {
            usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MUSICTYPE), getDictionaryValueByName("MusicTypes", AdCostsData.getField(AdCostsSchemaField.MUSICTYPE, row)));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.RIGHTS, row, false)) {
            usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.RIGHTS), getDictionaryValueByName("Rights", AdCostsData.getField(AdCostsSchemaField.RIGHTS, row)));
        }

        if (AdCostsData.containsField(AdCostsSchemaField.CONTRACTTOTAL, row, false)) {
            usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CONTRACTTOTAL), AdCostsData.getField(AdCostsSchemaField.CONTRACTTOTAL, row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.NOENDDATEPERPETUITY, row, false)) {
            usageBuyoutDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NOENDDATEPERPETUITY), AdCostsData.getField(AdCostsSchemaField.NOENDDATEPERPETUITY, row));
        }
        return usageBuyoutDetailsPage;
    }

    // Add/Edit ProductionDetails section
    @Given("{I |}added UsageBuyout details for cost title '$costTitle' with following fields: $data")
    @When("{I |}add UsageBuyout details for cost title '$costTitle' with following fields: $data")
    public void addProductionDetailsSectionviaCore(String costTitle, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        UpdateCostForm details = new UpdateCostForm();

        // details.getUpdateCostForm().setFormDefinitionId(""); // TODO: get form_defination_id and pass here
        String formDefinitionId = getFormDefinitionId("Buyout", "Usage/buyout Details");
        details.setFormDefinitionId(formDefinitionId);

        // Touchpoint bug id - ADC-1697(need to update once bug is fixed)
        if (AdCostsData.containsField(AdCostsSchemaField.TOUCHPOINTS, row, false)) {
            List<Touchpoints> touchPointsList = new ArrayList<>();
            String[] count = AdCostsData.getField(AdCostsSchemaField.TOUCHPOINTS, row).split(",");
            for (int i = 0; i < count.length; i++) {
                DictionaryEntries entry = getAdcostDictionaryEntryByName("MediaType%2FTouchPoints", count[i].trim());
//                DictionaryEntries entry = getAdcostDictionaryEntryByName("ExclusivityCategory", count[i].trim());
                Touchpoints touchpoints = new Touchpoints();
                touchpoints.setName(entry.getValue());
                touchpoints.setId(entry.getId());
                touchPointsList.add(touchpoints);
                details.getCostFormDetails().getData().setTouchpoints(touchPointsList);
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.AIRINGCOUNTRIES, row, false)) {
            List<AiringCountries> airingCountriesList = new ArrayList<>();
            String[] count = AdCostsData.getField(AdCostsSchemaField.AIRINGCOUNTRIES, row).split(",");
            for (int i = 0; i < count.length; i++) {
                TravelCountry entry = getCountryDetails(count[i].trim());
                AiringCountries airingCountries = new AiringCountries();
                airingCountries.setId(entry.getId());
                airingCountries.setName(entry.getName());
                airingCountriesList.add(airingCountries);
                details.getCostFormDetails().getData().setAiringCountries(airingCountriesList);
            }
        }
        DateTime startDate = null;
        if (AdCostsData.containsField(AdCostsSchemaField.STARTDATE, row, false)) {
            startDate = parseDateWithUTCZone(AdCostsData.getField(AdCostsSchemaField.STARTDATE, row));
            details.getCostFormDetails().getData().getContract().setStartDate(startDate);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.ENDDATE, row, false)) {
            DateTime endDate = parseDateWithUTCZone(AdCostsData.getField(AdCostsSchemaField.ENDDATE, row));
            details.getCostFormDetails().getData().getContract().setEndDate(endDate);
            Months months = Months.monthsBetween(startDate, endDate);
            details.getCostFormDetails().getData().getContract().setPeriod(Integer.toString(months.getMonths()));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.EXCLUSIVITY, row, false)) {
            String exlusivityValue = AdCostsData.getField(AdCostsSchemaField.EXCLUSIVITY, row);
            if (AdCostsData.getField(AdCostsSchemaField.EXCLUSIVITY, row).contains("yes, if yes specify category")) {
                details.getCostFormDetails().getData().getContract().setExclusivity(exlusivityValue);
                List<ExclusivityCategoryValues> exclusivityCategoryValuesList = new ArrayList<>();
                String[] exclusivityValues = AdCostsData.getField(AdCostsSchemaField.EXCLUSIVITYCATEGORY, row).split(",");
                for (int i = 0; i < exclusivityValues.length; i++) {
                    DictionaryEntries entry = getAdcostDictionaryEntryByName("ExclusivityCategory", exclusivityValues[i].trim());
                    ExclusivityCategoryValues exclusivityCategoryValues = new ExclusivityCategoryValues();
                    exclusivityCategoryValues.setId(entry.getId());
                    exclusivityCategoryValues.setName(entry.getValue());
                    exclusivityCategoryValuesList.add(exclusivityCategoryValues);
                    details.getCostFormDetails().getData().getContract().setExclusivityCategoryValues(exclusivityCategoryValuesList);
                }
            } else details.getCostFormDetails().getData().getContract().setExclusivity("no");
        }
        if (AdCostsData.containsField(AdCostsSchemaField.CONTRACTTOTAL, row, false))
            details.getCostFormDetails().getData().getContract().setContractTotal(Integer.parseInt(AdCostsData.getField(AdCostsSchemaField.CONTRACTTOTAL, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.NAME, row, false)) {
            String name = getDictionaryValueByName("BuyoutName", AdCostsData.getField(AdCostsSchemaField.NAME, row));
            details.getCostFormDetails().getData().setName(name);
        }
        /*if (AdCostsData.containsField(AdCostsSchemaField.NAMEOFLICENSOR, row, false)) {
            String name = getDictionaryValueByName("LicensorName", AdCostsData.getField(AdCostsSchemaField.NAMEOFLICENSOR, row));
            details.getCostFormDetails().getData().setNameOfLicensor(name);
        }*/
        List<Rights> right = new ArrayList<>();
        if (AdCostsData.containsField(AdCostsSchemaField.RIGHTS, row, false)) {
            String[] count = AdCostsData.getField(AdCostsSchemaField.RIGHTS, row).split(",");
            for (int i = 0; i < count.length; i++) {
                DictionaryEntries entry = getAdcostDictionaryEntryByName("Rights", count[i].trim());
                Rights rights = new Rights();
                rights.setName(entry.getValue());
                rights.setId(entry.getId());
                right.add(rights);
                details.getCostFormDetails().getData().setRights(right);
            }
        }
        else details.getCostFormDetails().getData().setRights(right);
        getAdcostApi().createUsageBuyOutDetails(details, getCostId(wrapVariableWithTestSession(costTitle)));
    }

    @Given("{I am} on usage buyout page of cost title '$costTitle'")
    @When("{I am} on usage buyout page of cost title '$costTitle'")
    public AdCostsUsageBuyoutDetailsPage openUsageBuyoutDetailPage(String costTitle) {
        String url = buildCostPageURL(wrapVariableWithTestSession(costTitle));
        return getSut().getPageNavigator().getAdCostsUsageBuyoutDetailsPage(url);
    }

    @Then ("{I |}'$condition' see following data for cost title '$costTitle' on usage buyout page:$data")
    public void verifyValuesUnderDiffFieldsOnExpectedAsetPage(String condition,String costTitle,ExamplesTable data) {
        AdCostsUsageBuyoutDetailsPage usageBuyoutDetailsPage = openUsageBuyoutDetailPage(costTitle);
        for (int i = 0; i < data.getRowCount(); i++) {
           Map<String, String> row = parametrizeTabularRow(data,i);
            if (row.get("FieldName").equals("Exclusivity Category")) {
                usageBuyoutDetailsPage.fillFieldByName("Exclusivity", "yes, if yes specify category");
                Common.sleep(1000);
            }
            assertThat("Check that value " + row.get("FieldValue") + "is available under following field " + row.get("FieldName"), usageBuyoutDetailsPage.verifyValuesForFieldsOnFormPage(row.get("FieldName"), wrapVariableWithTestSession(row.get("FieldValue"))), is(condition.equalsIgnoreCase("should")));
        }
    }

    @Then("{I |}'$condition' see fields contain following values on buyout usage details page for cost title1 '$costTitle':$data")
    public void checkValuesOnBuyoutUsageDetailsPage1(String condition,String costTitle, ExamplesTable data){
        AdCostsUsageBuyoutDetailsPage usageBuyoutDetailsPage = openUsageBuyoutDetailPage(costTitle);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (AdCostsData.containsField(AdCostsSchemaField.MEDIATOUCHPOINTS, row, false))
                for(String value:AdCostsData.getField(AdCostsSchemaField.MEDIATOUCHPOINTS,row).split(";"))
                    assertThat("Check values: ",usageBuyoutDetailsPage.verifyValuesForFieldsOnFormPage(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MEDIATOUCHPOINTS),
                            value.trim()), is(condition.equalsIgnoreCase("should")));
        }
    }

    @Then("{I |}'$should' see fields in following state:$data")
    public void checkFieldState(String condition,ExamplesTable data){
        AdCostsUsageBuyoutDetailsPage usageBuyoutDetailsPage = openUsageBuyoutDetailsPage();
        Map<String, String> row = parametrizeTabularRow(data);

        if (AdCostsData.containsField(AdCostsSchemaField.CONTRACTPERIODINMONTHS, row, false)) {
            String fieldName = AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CONTRACTPERIODINMONTHS);
            boolean actual = usageBuyoutDetailsPage.isFieldDisabled(fieldName,AdCostsData.getField(AdCostsSchemaField.CONTRACTPERIODINMONTHS, row));
            assertThat("Check field state:"+fieldName,actual);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.ENDDATE, row, false)) {
            String date = AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ENDDATE);
            boolean actual = usageBuyoutDetailsPage.isFieldDisabled(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ENDDATE),AdCostsData.getField(AdCostsSchemaField.ENDDATE, row));
            assertThat("Check field state:"+date,actual);
        }
    }
}