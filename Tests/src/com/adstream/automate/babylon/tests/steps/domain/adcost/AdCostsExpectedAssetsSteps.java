package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.AdId;
import com.adstream.automate.babylon.JsonObjects.adcost.Costs;
import com.adstream.automate.babylon.JsonObjects.adcost.ExpectedAssets;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsExpectedAssetsPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.utils.Common;
import org.hamcrest.core.Is;
import org.hamcrest.core.IsNot;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.text.SimpleDateFormat;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Raja.Gone on 08/05/2017.
 */
public class AdCostsExpectedAssetsSteps extends AdCostsHelperSteps {

    protected AdCostsExpectedAssetsPage openAdCostsExpectedAssetsPage() {
        AdCostsExpectedAssetsPage expectedAssetsDetailsPage = getSut().getPageNavigator().getAdCostsExpectedAssetsPage();
        if (expectedAssetsDetailsPage.waitUntilExpectedAssetsPageVisible())
            return expectedAssetsDetailsPage;
        else
            throw new Error("Unable to open Expected-Assets page");
    }

    protected AdCostsExpectedAssetsPage getAdCostsExpectedAssetsPage() {
        return getSut().getPageNavigator().getAdCostsExpectedAssetsPage();
    }

    @Given("{I |}filled Expected Assets form with following details for cost title '$costTitle': $data")
    @When("{I |}fill Expected Assets form with following details for cost title '$costTitle': $data")
    public void createExpectedAssetsDetailsThrowUI(String costTitle, ExamplesTable data) {
        openExpectedAssetsPage(costTitle);
        createExpectedAssetsDetailsThrowUI(data);
    }

    @Given("{I |}filled Expected Assets form with following fields: $data")
    @When("{I |}fill Expected Assets form with following fields: $data")
    public void createExpectedAssetsDetailsThrowUI(ExamplesTable data) {
        fillNewExpectedAssetsForm(data).clickBtnByName("Continue");
    }

    @Given("{I am} on expected assets page of cost title '$costTitle'")
    @When("{I am} on expected assets page of cost title '$costTitle'")
    public AdCostsExpectedAssetsPage openExpectedAssetsPage(String costTitle) {
        String url = buildCostPageURL(wrapVariableWithTestSession(costTitle));
        AdCostsExpectedAssetsPage expectedAssetsDetailsPage = getSut().getPageNavigator().getAdCostsExpectedAssetsPage(url);
        if (expectedAssetsDetailsPage.waitUntilExpectedAssetsPageVisible()) {
            return expectedAssetsDetailsPage;
        }
        else
            throw new Error("Unable to open Expected-Assets page");
    }

    @Given("{I am |}on '$costType' expected assets page")
    @When("{I |}go to '$costType' expected assets page")
    @Alias("{I |}open '$costType' expected assets page")
    public AdCostsExpectedAssetsPage openExpectedAssetsDetailsPage() {
        return openAdCostsExpectedAssetsPage();
    }

    @Given("{I |}filled following fields on expected assets form page: $data")
    @When("{I |}fill following fields on expected assets form page: $data")
    @Alias("{I |}update following fields on expected assets form page: $data")
    public AdCostsExpectedAssetsPage fillNewExpectedAssetsForm(ExamplesTable data) {
        AdCostsExpectedAssetsPage expectedAssetsPage = openAdCostsExpectedAssetsPage();
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetFormPage expectedAssetsFormPage = expectedAssetsPage.getAdCostsExpectedAssetsFormPage();
        fillExpectedAssetDetailsViaUI(data,expectedAssetsFormPage);
        expectedAssetsPage.clickBtnOnAlert("Save");
        expectedAssetsFormPage.waitUntilExpectedAssetsFormPageDisappear();
        return expectedAssetsPage;
    }

    // $action = {Edit | Delete | Duplicate |}
    @Given("{I |}clicked '$action' option for asset title '$assetTitle' in assets section on expected assets page")
    @When("{I |}click '$action' option for asset title '$assetTitle' in assets section on expected assets page")
    public void performActioForAssets(String action, String assetTitle) {

        if (!(action.equals("Edit") || action.equals("Delete") || action.equals("Duplicate")))
            throw new IllegalArgumentException("Incorrect button name: " + action);

        AdCostsExpectedAssetsPage page = openAdCostsExpectedAssetsPage();
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetsSection assetsSectionDetails = page.getExpectedAssetsSection();
        int rowCount = assetsSectionDetails.getExpectedAssetsSectionsCount();
        String wrappedAssetTitle = wrapVariableWithTestSession(assetTitle);
        if (rowCount == 1) {
            page.selectOptionFromExpectedAssetsMenuItem(action, 0);
            if (action.equals("Delete"))
                page.clickBtnOnAlert("Yes");
        } else {
            checkForDuplicateAssetTitles(wrappedAssetTitle, rowCount);
            for (int i = 1; i <= rowCount; i++) {
                if (assetsSectionDetails.getAssetTitleForGivenSection(i).equals(wrappedAssetTitle)) {
                    page.selectOptionFromExpectedAssetsMenuItem(action, i);
                    if (action.equals("Delete"))
                        page.clickBtnOnAlert("Yes");
                    break;
                }
            }
        }
    }

    @Given("{I |}duplicated '$assetTitle' asset details on expected assets page")
    @When("{I |}duplicate '$assetTitle' asset details on expected assets page")
    public void duplicateExpectedAssetDetails(String assetTitle) {
        AdCostsExpectedAssetsPage page = openAdCostsExpectedAssetsPage();
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetsSection assetsSectionDetails = page.getExpectedAssetsSection();
        int rowCount = assetsSectionDetails.getExpectedAssetsSectionsCount();
        String wrappedAssetTitle = wrapVariableWithTestSession(assetTitle);
        for (int i = 1; i <= rowCount; i++) {
            if (assetsSectionDetails.getAssetTitleForGivenSection(i).equals(wrappedAssetTitle)) {
                page.selectOptionFromExpectedAssetsMenuItem("Duplicate", i);
                break;
            }
        }
    }


    @Given("{I |}edited asset with title '$assetTitle' in assets section with following fields: $data")
    @When("{I |}edit asset with title '$assetTitle' in assets section with following fields: $data")
    public void editAssetsThrowUI(String assetTitle, ExamplesTable data) {
        AdCostsExpectedAssetsPage expectedAssetsPage = openAdCostsExpectedAssetsPage();
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetsSection assetsSectionDetails = expectedAssetsPage.getExpectedAssetsSection();
        int rowCount = assetsSectionDetails.getExpectedAssetsSectionsCount();
        String wrappedAssetTitle = wrapVariableWithTestSession(assetTitle);
        if (rowCount == 1) {
            expectedAssetsPage.selectOptionFromExpectedAssetsMenuItem("Edit", 0);
            fillNewExpectedAssetsForm(data);
        } else {
            checkForDuplicateAssetTitles(wrappedAssetTitle, rowCount);
            for (int i = 1; i <= rowCount; i++) {
                if (assetsSectionDetails.getAssetTitleForGivenSection(i).equals(wrappedAssetTitle)) {
                    expectedAssetsPage.selectOptionFromExpectedAssetsMenuItem("Edit", i);
                    fillNewExpectedAssetsForm(data);
                    break;
                }
            }
        }
    }

    // $fields = {| Initiative | Asset Title | Length | Definition | Media/Touchpoint | OVAL | First Air/Insertion Date | Scrapped | Airing Country / Region | }
    @Then("{I |}'$should' see following fields on expected assets section on AdCosts expected assets page:$fields")
    public void checkExpectedAssetsDetailsThrowUI(String condition, ExamplesTable fields) {
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetsSection expectedAssetsSectionDetails = openAdCostsExpectedAssetsPage().getExpectedAssetsSection();
        assertThat("Check Row count in Expected Assets Section: ", expectedAssetsSectionDetails.getExpectedAssetsSectionsCount(),
                condition.equalsIgnoreCase("should")?is(fields.getRowCount()):not(is(fields.getRowCount())));

        for (int i = 0; i < fields.getRowCount(); i++) {
            List<String> expectedList = new ArrayList<>();
            List<String> actualList = new ArrayList<>();
            Map<String, String> row = parametrizeTabularRow(fields, i);
            expectedAssetsSectionDetails.loadDataInExpectedAssetsSection(i);
            if (AdCostsData.containsField(AdCostsSchemaField.INITIATIVE, row, false)) {
                String[] temp = AdCostsData.getField(AdCostsSchemaField.INITIATIVE, row).split(";");
                if (temp.length == 2) {
                    if (temp[1].equals("Add on fly"))
                       expectedList.add(wrapVariableWithTestSession(temp[0]));}
                else
                    expectedList.add(temp[0]);
                actualList.add(expectedAssetsSectionDetails.getInitiative());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ASSETTITLE, row, false)) {
                expectedList.add(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.ASSETTITLE, row)));
                actualList.add(expectedAssetsSectionDetails.getAssetTitle());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ADID, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.ADID, row));
                actualList.add(expectedAssetsSectionDetails.getAdId());
            }
            if (row.containsKey("Length")) {
                expectedList.add(row.get("Length"));
                actualList.add(expectedAssetsSectionDetails.getLength());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.DEFINATION, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.DEFINATION, row));
                actualList.add(expectedAssetsSectionDetails.getDefinition());
            }
            if (row.containsKey("Media / Touchpoint")) {
                expectedList.add(row.get("Media / Touchpoint"));
                actualList.add(expectedAssetsSectionDetails.getMediaTouchPoint());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.OVAL, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.OVAL, row));
                actualList.add(expectedAssetsSectionDetails.getOval());
            }
            if (row.containsKey("First Air / Insertion Date")) {
                expectedList.add(row.get("First Air / Insertion Date"));
                actualList.add(expectedAssetsSectionDetails.getFirstAirInsertionDate());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.SCRAPPED, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.SCRAPPED, row));
                actualList.add(expectedAssetsSectionDetails.getScrapped());
            }
            if (row.containsKey("Airing Country / Region")) {
                expectedList.add(row.get("Airing Country / Region"));
                actualList.add(expectedAssetsSectionDetails.getCountry());
            }

            for(String expected:expectedList)
                assertThat("Check Expected-Assets section: "+expected,actualList, condition.equalsIgnoreCase("should") ? hasItem(expected) : not(hasItem(expected)));
        }
    }

    @Then("{I |}'$should' see asset details '$assetTitle' in expected assets section")
    public void checkCostDetails(String condition, String assetTitle){
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetsSection expectedAssetsSectionDetails = openAdCostsExpectedAssetsPage().getExpectedAssetsSection();
        String actual = "false";
        if(expectedAssetsSectionDetails.isAssetDetailsPresent(wrapVariableWithTestSession(assetTitle)))
            actual = "true";
        assertThat(actual,condition.equals("should")? is("true"): is("false"));
    }

    @Then("{I |}'$should' see Expected Assets or Deliverables count as '$assetsCount' on Expected Assets page")
    public void checkExpectedAssetsCount(String condition,int assetsCount){
        AdCostsExpectedAssetsPage page = openAdCostsExpectedAssetsPage();
        String expectedString = "Expected Assets / Deliverables ("+assetsCount+")";
        assertThat("Check 'Expected Assets / Deliverables' count: ",page.getExpectedAssetsDeliverablesCount(), condition.equalsIgnoreCase("should")?is(expectedString):not(is(expectedString)));
    }

    @Given("{I |}added expected asset details for cost title '$costTitle':$data")
    @When("{I |}add expected asset details for cost title '$costTitle':$data")
    public void addExpectedAssetsviaCore(String costTitle, ExamplesTable fieldsTable) {

        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
            String costId = costs.getId();
            String costStageId = getCostStageId(costId);
            String costRevisionId = getCostRevisionId(costId, costStageId);

            ExpectedAssets details = new ExpectedAssets();
            details.setCostId(costId);
            details.setCostStageId(costStageId);
            details.setRevisionId(costRevisionId);
            details.setContentType(costs.getContentType());
            boolean coreApi = true;
            if (AdCostsData.containsField(AdCostsSchemaField.INITIATIVE, row, false))
                details.setInitiative(getDictionaryValueByName("Initiative", AdCostsData.getField(AdCostsSchemaField.INITIATIVE, row)));
            if (AdCostsData.containsField(AdCostsSchemaField.ASSETTITLE, row, false))
                details.setTitle(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.ASSETTITLE, row)));
            if (AdCostsData.containsField(AdCostsSchemaField.DURATION, row, false))
                details.setDuration(AdCostsData.getField(AdCostsSchemaField.DURATION, row));
            if (AdCostsData.containsField(AdCostsSchemaField.OVAL, row, false)) {
                details.setOvalTypeId(getDictionaryEntriesIdByName("OvalType", AdCostsData.getField(AdCostsSchemaField.OVAL, row)).getId());
                details.setOvalTypeName(AdCostsData.getField(AdCostsSchemaField.OVAL, row));
            }
            if (AdCostsData.containsField(AdCostsSchemaField.MEDIATOUCHPOINT, row, false)) {
                details.setMediaTypeId(getDictionaryEntriesIdByName("MediaType%2FTouchPoints", AdCostsData.getField(AdCostsSchemaField.MEDIATOUCHPOINT, row)).getId());
                details.setMediaTypeName(AdCostsData.getField(AdCostsSchemaField.MEDIATOUCHPOINT, row));
            }
            if (AdCostsData.containsField(AdCostsSchemaField.FIRSTAIRINSERTIONDATE, row, false)) {
                DateTime firstAirInsertionDate = parseDateWithUTCZone(AdCostsData.getField(AdCostsSchemaField.FIRSTAIRINSERTIONDATE, row));
                details.setFirstAirDate(firstAirInsertionDate);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.DEFINATION, row, false)) {
                String def = checkDefinationFieldValue(AdCostsData.getField(AdCostsSchemaField.DEFINATION, row));
                details.setDefinition(def);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.SCRAPPED, row, false)) {
                String scrapped = checkScrappedFieldValue(AdCostsData.getField(AdCostsSchemaField.SCRAPPED, row),coreApi);
                details.setScrapped(scrapped);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.COUNTRY, row, false)) {
                String[] countries = AdCostsData.getField(AdCostsSchemaField.COUNTRY, row).split(",");
                details.setAiringRegions(countries);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ADID, row, false)) {
                details.setAdId(generateAdId(details));
                details.setAdIdValid(false);
                details.setAdIdLocked(true);
            }

            details.setContentType(null);
            details.setMediaTypeName(null);
            details.setOvalTypeName(null);

            getAdcostApi().createExpectedAssets(details);
        }
    }

    private void checkForDuplicateAssetTitles(String assetTitle, int sectionsCount) {
        int counter = 0;
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetsSection assetsSection = openAdCostsExpectedAssetsPage().getExpectedAssetsSection();
        for (int i = 1; i <= sectionsCount; i++)
            if (assetsSection.getAssetTitleForGivenSection(i).equals(assetTitle))
                counter++;
        if (counter == sectionsCount)
            throw new AssertionError("Found multiple assets with same 'Asset Title': " + assetTitle);
        else if (counter == 0)
            throw new AssertionError("Couldn't found any asset with 'Asset Title': " + assetTitle);
    }

    private String checkDefinationFieldValue(String eitherHdOrSdOnly) {
        switch (eitherHdOrSdOnly) {
            case "HD":
                return eitherHdOrSdOnly;
            case "SD":
                return eitherHdOrSdOnly;
            default:
                throw new IllegalArgumentException("Unknown 'Defination' value: " + eitherHdOrSdOnly + ". Expected either 'HD' or 'SD'.");
        }
    }

    private String checkScrappedFieldValue(String eitherYesOrNoOnly, boolean coreApi) {
        if (coreApi){
            switch (eitherYesOrNoOnly) {
                case "Yes":
                    return "true";
                case "No":
                    return "false";
                default:
                    throw new IllegalArgumentException("Unknown 'Scrapped' value: " + eitherYesOrNoOnly + ". Expected either 'Yes' or 'No'.");
        }
        } else{
                switch (eitherYesOrNoOnly) {
                    case "Yes":
                        return "Yes";
                    case "No":
                        return "No";
                    default:
                        throw new IllegalArgumentException("Unknown 'Scrapped' value: " + eitherYesOrNoOnly + ". Expected either 'Yes' or 'No'.");
                }

        }
    }

    private String generateAdId(ExpectedAssets assets) {
        AdId adid = new AdId();
        adid.setMediaType(assets.getMediaTypeName());
        adid.setFormat(assets.getDefinition());
        adid.setCampaign(assets.getInitiative());
        adid.setTitle(assets.getTitle());
        adid.setLength(assets.getDuration());

        Date date = assets.getFirstAirDate().toDate();
        adid.setStartDate(new SimpleDateFormat("yyyy-MM-dd").format(date));

        adid.setCostId(assets.getCostId());
        adid.setContentType(assets.getContentType());
        adid.setVersion(assets.getOvalTypeName());

        String id = getAdcostApi().generateAdId(adid).getAdId();

        if (id == null || id.isEmpty())
            throw new IllegalStateException("Check Ad-Id generation");
        else return id;
    }

    private void fillExpectedAssetDetailsViaUI(ExamplesTable fieldsTable,AdCostsExpectedAssetsPage.AdCostsExpectedAssetFormPage expectedAssetsFormPage) {

       // AdCostsExpectedAssetsPage.AdCostsExpectedAssetFormPage expectedAssetsFormPage = getAdCostsExpectedAssetsPage().getAdCostsExpectedAssetsFormPage();
        expectedAssetsFormPage.waitUntilExpectedAssetsFormLoads();

        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            boolean coreApi = false;
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (AdCostsData.containsField(AdCostsSchemaField.OVAL, row, false)) {
                String ovalType = getDictionaryEntriesIdByName("OvalType", AdCostsData.getField(AdCostsSchemaField.OVAL, row)).getValue();
                expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.OVAL), ovalType);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.INITIATIVE, row, false)) {
                String[] temp = AdCostsData.getField(AdCostsSchemaField.INITIATIVE, row).split(";");
                if (temp.length == 2) {
                    if (temp[1].equals("Add on fly"))
                       expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.INITIATIVE), wrapVariableWithTestSession(temp[0]));
                }
                else
                    expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.INITIATIVE), getDictionaryValueByName("Initiative", temp[0]));
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ASSETTITLE, row, false))
                expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ASSETTITLE), wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.ASSETTITLE, row)));
            if (AdCostsData.containsField(AdCostsSchemaField.DURATION, row, false))
                expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DURATION), AdCostsData.getField(AdCostsSchemaField.DURATION, row));
            if (AdCostsData.containsField(AdCostsSchemaField.MEDIATOUCHPOINT, row, false)) {
                String mediaTouchPoint = getDictionaryEntriesIdByName("MediaType%2FTouchPoints", AdCostsData.getField(AdCostsSchemaField.MEDIATOUCHPOINT, row)).getValue();
                expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MEDIATOUCHPOINT), mediaTouchPoint);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.FIRSTAIRINSERTIONDATE, row, false)) {
                String date = AdCostsData.getField(AdCostsSchemaField.FIRSTAIRINSERTIONDATE, row);
                if (checkDateFormatINddMMyyyy(date))
                    expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.FIRSTAIRINSERTIONDATE), date);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.DEFINATION, row, false)) {
                String def = checkDefinationFieldValue(AdCostsData.getField(AdCostsSchemaField.DEFINATION, row));
                expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DEFINATION), def);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.SCRAPPED, row, false)) {
                String scrapped = checkScrappedFieldValue(AdCostsData.getField(AdCostsSchemaField.SCRAPPED, row), coreApi);
                expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SCRAPPED), scrapped);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.COUNTRY, row, false)) {
                for(String countryName:AdCostsData.getField(AdCostsSchemaField.COUNTRY,row).split(";"))
//                    expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.COUNTRY), countryName);
                    expectedAssetsFormPage.fillFieldByName("Airing Country", countryName);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ADID, row, false)) {
                expectedAssetsFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ADID), AdCostsData.getField(AdCostsSchemaField.ADID, row));
                getAdCostsExpectedAssetsPage().waitForAdIdSync();
            }
        }
    }

    @Then("{I |}'$condition' see following '$fieldValue' under '$fieldName' field on expected form page for cost title '$costTitle'")
    public void checkValuesOnExpectedAsetPage(String condition,String fieldValue, String fieldName, String costTitle){
        AdCostsExpectedAssetsPage expectedAssetsPage = openExpectedAssetsPage(costTitle);
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetFormPage expectedAssetsFormPage = expectedAssetsPage.getAdCostsExpectedAssetsFormPage();
        assertThat("Check that value " +fieldValue+ "is available under following field "+fieldName,expectedAssetsFormPage.verifyValuesForFieldsOnFormPage(fieldName,wrapVariableWithTestSession(fieldValue)), is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' see fields contains following values on ExpectedAssets form page for cost title '$costTitle':$data")
    public void checkValuesOnExpectedAsetFormPage(String condition,String costTitle, ExamplesTable data){
        AdCostsExpectedAssetsPage expectedAssetsPage = openExpectedAssetsPage(costTitle);
        AdCostsExpectedAssetsPage.AdCostsExpectedAssetFormPage expectedAssetsFormPage = expectedAssetsPage.getAdCostsExpectedAssetsFormPage();
        expectedAssetsFormPage.waitUntilExpectedAssetsFormLoads();
        Common.sleep(500);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            List<String> actualList = expectedAssetsFormPage.getFieldValues(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MEDIATOUCHPOINT));
            actualList.removeAll(Collections.singleton(""));
            if (AdCostsData.containsField(AdCostsSchemaField.MEDIATOUCHPOINT, row, false))
                for(String value:AdCostsData.getField(AdCostsSchemaField.MEDIATOUCHPOINT,row).split(";"))
                    assertThat("Check values: ",actualList,condition.equalsIgnoreCase("should")?hasItem(value.trim()):not(hasItem(value.trim())));
        }
    }

    // Linked Usage Cost: pass costTitle
    @Then("{I |}'$condition' see below information in downloaded Expected Assets for cost title '$costTitle':$data")
    public void checkExpectedAssetsDownloadInfo(String condition, String costTitle, ExamplesTable data){
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        String costId = costs.getId();
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId, costStageId);
        String actual = getAdcostApi().downloadExpectedAssets(costId,costStageId,costRevisionId);

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if(row.containsKey("Initiative"))
                assertThat("Check 'Initiative': "+actual,actual.contains(row.get("Initiative")));
            if(row.containsKey("Title"))
                assertThat("Check 'Title': "+actual,actual.contains(wrapVariableWithTestSession(row.get("Title"))));
            if(row.containsKey("Duration"))
                assertThat("Check 'Duration': "+actual,actual.contains(row.get("Duration")));
            if(row.containsKey("Media Type"))
                assertThat("Check 'Media Type': "+actual,actual.contains(row.get("Media Type")));
            if(row.containsKey("O/V/A/L Type"))
                assertThat("Check 'O/V/A/L Type': "+actual,actual.contains(row.get("O/V/A/L Type")));
            if(row.containsKey("First Air Date"))
                assertThat("Check 'First Air Date': "+actual,actual.contains(row.get("First Air Date")));
            if(row.containsKey("Scrapped"))
                assertThat("Check 'Scrapped': "+actual,actual.contains(row.get("Scrapped")));
            if(row.containsKey("Airing Country/Region"))
                assertThat("Check 'Airing Country/Region': "+actual,actual.contains(row.get("Airing Country/Region")));
            if(!row.get("Linked Usage Cost").isEmpty() && row.get("Linked Usage Cost")!=null) {
                Costs cost = getCostDetails(wrapVariableWithTestSession(row.get("Linked Usage Cost")));
                assertThat("Check 'Linked Usage Cost': "+actual, actual.contains(cost.getCostNumber()));
            }
        }
    }
}