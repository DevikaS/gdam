package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsProductionDetailsPage;
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
import org.joda.time.format.DateTimeFormat;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import static java.util.Arrays.asList;
import static java.util.Arrays.sort;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * Created by Raja.Gone on 26/04/2017.
 */
public class AdCostsProductionDetailsSteps extends AdCostsHelperSteps {

    protected AdCostsProductionDetailsPage openAdCostsProductionDetailsPage() {
        AdCostsProductionDetailsPage prodDetailsPage = getSut().getPageNavigator().getAdCostsProductionDetailsPage();
        if (prodDetailsPage.waitUntilProdDetailsPageVisible())
            return prodDetailsPage;
        else
            throw new Error("Unable to open Production-Details page");
    }

    @Given("{I |}filled Production Details with following fields for cost title '$costTitle': $data")
    @When("{I |}fill Production Details with following fields for cost title '$costTitle': $data")
    public void createProdCostDetailsThrowUI(String costTitle, ExamplesTable data) {
        openProdDetailPage(costTitle);
        fillProductionDetailsSectionViaUI(data).clickBtnByName("Continue");
    }

    @Given("{I |}filled Production Details with following fields: $data")
    @When("{I |}fill Production Details with following fields: $data")
    public void createProdCostDetailsThrowUI(ExamplesTable data) {
        fillProductionDetailsSectionViaUI(data).clickBtnByName("Continue");
    }

    @Given("{I am |}on '$costType' production details page")
    @When("{I |}go to '$costType' production details page")
    @Alias("{I |}open '$costType' production details page")
    public AdCostsProductionDetailsPage openProductionDetailsPage(String costType) {
        return openAdCostsProductionDetailsPage();
    }

    @Given("{I am} on production details page of cost title '$costTitle'")
    @When("{I am} on production details page of cost title '$costTitle'")
    public AdCostsProductionDetailsPage openProdDetailPage(String costTitle) {
        String url = buildCostPageURL(wrapVariableWithTestSession(costTitle));
        AdCostsProductionDetailsPage prodDetailsPage =getSut().getPageNavigator().getAdCostsProductionDetailsPage(url);
        if (prodDetailsPage.waitUntilProdDetailsPageVisible())
            return prodDetailsPage;
        else
            throw new Error("Unable to open Production-Details page");
    }


    @Given("{I |}filled following fields on production details page: $data")
    @When("{I |}fill following fields on production details page: $data")
    @Alias("{I |}update following fields on production details page: $data")
    public void fillProdDetails(ExamplesTable data) {
        fillProductionDetailsSectionViaUI(data);
    }

    @Given("{I |}filled Travel Cost form  with following details for cost title '$costTitle': $data")
    @When("{I |}fill Travel Cost form  with following details for cost title '$costTitle': $data")
    public void fillTravelCostFormThrowUI(String costTitle, ExamplesTable data) {
        AdCostsProductionDetailsPage.AdCostsTravelCostFormPage travelCostFormPage = fillTravelCostDetailsViaUI(data);
        String travelCostFormLocator = travelCostFormPage.getTravelCostFormLocator();
        clickButtonName("Save", travelCostFormLocator);
    }

    @Then("{I |}'$should' see following fields on travel details section on Adcost production details page:$fields")
    public void checkTravelDetailsThrowUI(String condition, ExamplesTable fields) {
        AdCostsProductionDetailsPage.TravelDetailsSection travelCostDetails = openAdCostsProductionDetailsPage().getTravelCostDetails();
        assertThat("Check Row count in Travel Details Section: ", travelCostDetails.getRowsInTravelDetailsSection(),
                condition.equalsIgnoreCase("should")?is(fields.getRowCount()):not(is(fields.getRowCount())));
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            String wrappedTravellerName = wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.TRAVELLERNAME, row));
            travelCostDetails.loadTravelDetailsSection(wrappedTravellerName);
            if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERNAME, row, false)) {
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERNAME) + "' value on Travel details section: ", travelCostDetails.getTravelerName(),
                        condition.equalsIgnoreCase("should") ? is(wrappedTravellerName) : not(is(wrappedTravellerName)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERROLE, row, false)) {
                String travellerRole = AdCostsData.getField(AdCostsSchemaField.TRAVELLERROLE, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERROLE) + "' value on Travel details section: ",
                        travelCostDetails.getTravelerRole(), condition.equalsIgnoreCase("should") ? is(travellerRole) : not(is(travellerRole)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERSHOOTCITY, row, false)) {
                String shootCity = AdCostsData.getField(AdCostsSchemaField.TRAVELLERSHOOTCITY, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERSHOOTCITY) + "' value on Travel details section: ",
                        travelCostDetails.getShootCity(), condition.equalsIgnoreCase("should")?is(shootCity):not(is(shootCity)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERNOOFDAYS, row, false)) {
                String travellerDays = AdCostsData.getField(AdCostsSchemaField.TRAVELLERNOOFDAYS, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERNOOFDAYS) + "' value on Travel details section: ",
                        travelCostDetails.getDays(), condition.equalsIgnoreCase("should")?is(travellerDays):not(is(travellerDays)));
            }if (AdCostsData.containsField(AdCostsSchemaField.TRAVELTYPE, row, false)) {
                String travelType = AdCostsData.getField(AdCostsSchemaField.TRAVELTYPE, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELTYPE) + "' value on Travel details section: ",
                        travelCostDetails.getTravelType(), condition.equalsIgnoreCase("should")?is(travelType):not(is(travelType)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TOTALAGENCYTRAVELCOSTS, row, false)) {
                String totalAgencyTravelCosts = AdCostsData.getField(AdCostsSchemaField.TOTALAGENCYTRAVELCOSTS, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TOTALAGENCYTRAVELCOSTS) + "' value on Travel details section: ",
                        travelCostDetails.getTotalAgencyTravelCosts(),condition.equalsIgnoreCase("should")?is(totalAgencyTravelCosts):not(is(totalAgencyTravelCosts)));
            }
        }
    }

    @Then("{I |}'$should' see traveler name '$travelerName' in travel costs section on production details page")
    public void checkTravelDetails(String condition, String travelerName){
        AdCostsProductionDetailsPage.TravelDetailsSection travelCostDetails = openAdCostsProductionDetailsPage().getTravelCostDetails();
        String actual = "false";
        if(travelCostDetails.isTravellerDetailsPresent(wrapVariableWithTestSession(travelerName)))
            actual = "true";
        assertThat(actual,condition.equalsIgnoreCase("should")? is("true"): is("false"));
    }

    // $action = {Edit | Delete | Duplicate |}
    @Given("{I |}clicked '$action' option for traveler name '$travelerName' in travel costs section on production details page")
    @When("{I |}click '$action' option for traveler name '$travelerName' in travel costs section on production details page")
    public void performActioForTravelCost(String action, String travelerName) {
        if (!(action.equals("Edit") || action.equals("Delete") || action.equals("Duplicate")))
            throw new IllegalArgumentException("Incorrect button name: " + action);
        AdCostsProductionDetailsPage.TravelDetailsSection travelCostDetails = openAdCostsProductionDetailsPage().getTravelCostDetails();
        int rowCount = travelCostDetails.getRowsInTravelDetailsSection();
        String wrappedTravellerName = wrapVariableWithTestSession(travelerName);
        checkForDuplicateTravellerName(wrappedTravellerName, rowCount);
        for (int i = 0; i <= rowCount; i++) {
            travelCostDetails.loadTravelDetailsSection(wrappedTravellerName);
            if (travelCostDetails.getTravelerName().equals(wrappedTravellerName)) {
                travelCostDetails.selectOptionFromTravelCostMenuItem(action, travelCostDetails.getRowCount(wrappedTravellerName));
                break;
            }
        }
    }

    @Given("{I |}duplicated travel details for traveler name '$travelerName' in production details page")
    @When("{I |}duplicate travel details for traveler name '$travelerName' in production details page")
    public void duplicateTravelDetails(String travelerName) {
        AdCostsProductionDetailsPage.TravelDetailsSection travelCostDetails = openAdCostsProductionDetailsPage().getTravelCostDetails();
        int rowCount = travelCostDetails.getRowsInTravelDetailsSection();
        String wrappedTravellerName = wrapVariableWithTestSession(travelerName);
        for (int i = 0; i <= rowCount; i++) {
            travelCostDetails.loadTravelDetailsSection(wrappedTravellerName);
            if (travelCostDetails.getTravelerName().equals(wrappedTravellerName)) {
                travelCostDetails.selectOptionFromTravelCostMenuItem("Duplicate", travelCostDetails.getRowCount(wrappedTravellerName));
                break;
            }
        }
    }

    @Given("{I |}edited travel cost details for travelerName '$travelerName' in travel cost section with following fields: $data")
    @When("{I |}edit travel cost details for travelerName '$travelerName' in travel cost section with following fields: $data")
    public void editTravelCostThrowUI(String travelerName, ExamplesTable data) {
        AdCostsProductionDetailsPage.TravelDetailsSection travelCostDetails = openAdCostsProductionDetailsPage().getTravelCostDetails();
        int rowCount = travelCostDetails.getRowsInTravelDetailsSection();
        String wrappedTravellerName = wrapVariableWithTestSession(travelerName);
        checkForDuplicateTravellerName(wrappedTravellerName, rowCount);

        for (int i = 0; i <= rowCount; i++) {
            travelCostDetails.loadTravelDetailsSection(wrappedTravellerName);
            if (travelCostDetails.getTravelerName().equals(wrappedTravellerName)) {
                travelCostDetails.selectOptionFromTravelCostMenuItem("Edit", i);
                fillTravelCostFormThrowUI("", data);
                break;
            }
        }
    }

    // | Name of Traveller | Role of Traveller | Days | Region of travel | Country of travel | Shoot City | Travel (e.g., Air/Train Tickets) | Total Agency Travel Costs | Does travel cover other content Types | Comments| If Yes, Which? |
    @Given("{I |}added following Travel Details for cost title '$costTitle':$fieldsTable")
    @When("{I |}add following Travel Details for cost title '$costTitle':$fieldsTable")
    public void createTravelCostviaCore(String costTitle, ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String costId = getCostId(wrapVariableWithTestSession(costTitle));
            String costStageId = getCostStageId(costId);
            String costRevisionId = getCostRevisionId(costId, costStageId);
            TravelDetails details = new TravelDetails();
            details.setRevisionId(costRevisionId);
            details.setCostId(costId);
            details.setStageId(costStageId);
            if (AdCostsData.containsField(AdCostsSchemaField.NAMEOFTRAVELLER, row, false)) {
                details.setName(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.NAMEOFTRAVELLER, row)));
                CheckIfTravelDetailsAlreadyExists(details);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ROLEOFTRAVELLER, row, false)) {
                String travellerRole = getTravellerRole(AdCostsData.getField(AdCostsSchemaField.ROLEOFTRAVELLER, row)).getValue();
                details.setRole(travellerRole);
            }
            if (AdCostsData.containsField(AdCostsSchemaField.SHOOTDAYS, row, false))
                details.setShootDays(Integer.parseInt(AdCostsData.getField(AdCostsSchemaField.SHOOTDAYS, row)));
            if (AdCostsData.containsField(AdCostsSchemaField.DESTINATIONREGION, row, false)) {
                String regionName = AdCostsData.getField(AdCostsSchemaField.DESTINATIONREGION, row);
                TravelRegions regions = getRegionByName(regionName);
                details.setRegion(regions.getName());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.COUNTRYOFTRAVEL, row, false))
                details.setCountry(getCountryDetails(AdCostsData.getField(AdCostsSchemaField.COUNTRYOFTRAVEL, row)).getName());
            if (AdCostsData.containsField(AdCostsSchemaField.SHOOTCITY, row, false)) {
                String shootCity = getShootCity(AdCostsData.getField(AdCostsSchemaField.SHOOTCITY, row)).getValue().split(" ")[0];
                details.setShootCity(shootCity);
                details.setPerDiem(Double.parseDouble(getPerDiemsCost(shootCity)));
            }
            if (AdCostsData.containsField(AdCostsSchemaField.MODEOFTRAVEL, row, false))
                details.setTravelType(AdCostsData.getField(AdCostsSchemaField.MODEOFTRAVEL, row));
            if (AdCostsData.containsField(AdCostsSchemaField.TRANSPORTATIONCOSTFEE, row, false))
                details.setTravelTypeCost(Integer.parseInt(AdCostsData.getField(AdCostsSchemaField.TRANSPORTATIONCOSTFEE, row)));
            if (AdCostsData.containsField(AdCostsSchemaField.DOESTRAVELCOVEROTHERCONTENTTYPES, row, false))
                if (AdCostsData.getField(AdCostsSchemaField.DOESTRAVELCOVEROTHERCONTENTTYPES, row).contains("Yes")) {
                    details.setOtherContentType(true);
                    if (AdCostsData.containsField(AdCostsSchemaField.IFYESWHICH, row, false)) {
                        String[] linkContentType = AdCostsData.getField(AdCostsSchemaField.IFYESWHICH, row).split(",");
                        details.setLinkContentType(linkContentType);
                    }
                } else
                    details.setOtherContentType(false);
            else
                details.setOtherContentType(false);
            if (AdCostsData.containsField(AdCostsSchemaField.TRAVELDETAILSCOMMENTS, row, false))
                details.setComments(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.TRAVELDETAILSCOMMENTS, row)));
            details.setTotalCost((details.getShootDays() * details.getPerDiem()) + details.getTravelTypeCost());
            getAdcostApi().createTravelCostDetails(details);
        }
    }

    // $action = Delete
    @Given("{I |}'$action' travel details of '$travellerName' for cost title '$costTitle'")
    @When("{I |}'$action' travel details of '$travellerName' for cost title '$costTitle'")
    public void actioOnTravelCostDetail(String action, String travellerName, String costTitle) {
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getAdcostApi().getCostStage(costId).getId();
        String costRevisionId = getAdcostApi().getCostStageRevision(costId, costStageId).getId();
        TravelDetails details = new TravelDetails();
        details.setName(wrapVariableWithTestSession(travellerName));
        details.setCostStageRevisionId(costRevisionId);
        details.set_costId(costId);
        details.setRevisionId(costRevisionId);
        details.setCostId(costId);
        details.setStageId(costRevisionId);
        checkForDuplicateTravellerName(details);
        String travelCostId = getTravelCostDetails(details).getId();
        details.setId(travelCostId);

        if (action.equals("Delete"))
            getAdcostApi().deleteTravelCostDetails(details);
    }

    @Then("{I |}'$condition' see info as '$contentProductionType' on Production details page")
    public void verifyText(String condition, String contentProductionType) {
        AdCostsProductionDetailsPage page = openAdCostsProductionDetailsPage();
        assertThat("Info not as expected on Production details", condition.equalsIgnoreCase("should") ? page.getFormInfoText().equals(contentProductionType) : !page.getFormInfoText().equals(contentProductionType));
    }


    // Add/Edit ProductionDetails section
    @Given("{I |}added production details for cost title '$costTitle' with following fields: $data")
    @When("{I |}add production details for cost title '$costTitle' with following fields: $data")
    public void addProductionDetailsSectionviaCore(String costTitle, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);

        BaseProductionDetails details = new BaseProductionDetails();
        details.getProductionDetails().getData().setAiring("NotForAir"); // TODO: Need to determine on what field this value depends on
        if (AdCostsData.containsField(AdCostsSchemaField.FIRSTSHOOTDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.FIRSTSHOOTDATE, row);
            if (checkDateFormatINddMMyyyy(date)) {
                DateTime firstShootDate = parseDateWithUTCZone(date);
                details.getProductionDetails().getData().setFirstShootDate(firstShootDate);
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.NUMBEROFSHOOTDAYS, row, false))
            details.getProductionDetails().getData().setShootDays(Integer.parseInt(AdCostsData.getField(AdCostsSchemaField.NUMBEROFSHOOTDAYS, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.DIRECTOR, row, false)) {
            String directorName = checkDirectorName(AdCostsData.getField(AdCostsSchemaField.DIRECTOR, row));
            details.getProductionDetails().getData().setDirector(directorName);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.SHOOTCOUNTRY, row, false)) {
            TravelCountry country = getCountryDetails(AdCostsData.getField(AdCostsSchemaField.SHOOTCOUNTRY, row));
            if (AdCostsData.containsField(AdCostsSchemaField.RETOUCHINGCOMPANY, row, false)) {
                details.getProductionDetails().getData().getShootCountry().setName(country.getName());
                if (AdCostsData.containsField(AdCostsSchemaField.SHOOTCITY, row, false)) {
                    for (Cities cityName : country.getCities())
                        if (cityName.getName().equals(AdCostsData.getField(AdCostsSchemaField.SHOOTCITY, row))) {
                            details.getProductionDetails().getData().getShootCountry().setId(cityName.getCountryId());
                            details.getProductionDetails().getData().getShootCity().setCountryId(cityName.getCountryId());
                            details.getProductionDetails().getData().getShootCity().setName(cityName.getName());
                            details.getProductionDetails().getData().getShootCity().setCountryCapital(cityName.getCountryCapital());
                            details.getProductionDetails().getData().getShootCity().setIsCapital(cityName.getIsCapital());
                            details.getProductionDetails().getData().getShootCity().setId(cityName.getId());
                            break;
                        }
                }
            } else {
                details.getProductionDetails().getData().getPrimaryShootCountry().setName(country.getName());
                if (AdCostsData.containsField(AdCostsSchemaField.SHOOTCITY, row, false)) {
                    for (Cities cityName : country.getCities())
                        if (cityName.getName().equals(AdCostsData.getField(AdCostsSchemaField.SHOOTCITY, row))) {
                            details.getProductionDetails().getData().getPrimaryShootCountry().setId(cityName.getCountryId());
                            details.getProductionDetails().getData().getPrimaryShootCity().setCountryId(cityName.getCountryId());
                            details.getProductionDetails().getData().getPrimaryShootCity().setName(cityName.getName());
                            details.getProductionDetails().getData().getPrimaryShootCity().setCountryCapital(cityName.getCountryCapital());
                            details.getProductionDetails().getData().getPrimaryShootCity().setIsCapital(cityName.getIsCapital());
                            details.getProductionDetails().getData().getPrimaryShootCity().setId(cityName.getId());
                            break;
                        }
                }
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.RECORDINGDATE, row);
            if (checkDateFormatINddMMyyyy(date)) {
                DateTime recordingDate = parseDateWithUTCZone(date);
                details.getProductionDetails().getData().setRecordingDate(recordingDate);
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGDAYS, row, false))
        details.getProductionDetails().getData().setRecordingDays(Integer.parseInt(AdCostsData.getField(AdCostsSchemaField.RECORDINGDAYS, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGCOUNTRY, row, false)) {
            TravelCountry country = getCountryDetails(AdCostsData.getField(AdCostsSchemaField.RECORDINGCOUNTRY, row));
            details.getProductionDetails().getData().getPrimaryShootCountry().setName(country.getName());
            if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGCITY, row, false)) {
                for (Cities cityName : country.getCities())
                    if (cityName.getName().equals(AdCostsData.getField(AdCostsSchemaField.RECORDINGCITY, row))) {
                        details.getProductionDetails().getData().getRecordingCountry().setId(cityName.getCountryId());
                        details.getProductionDetails().getData().getRecordingCity().setCountryId(cityName.getCountryId());
                        details.getProductionDetails().getData().getRecordingCity().setName(cityName.getName());
                        details.getProductionDetails().getData().getRecordingCity().setCountryCapital(cityName.getCountryCapital());
                        details.getProductionDetails().getData().getRecordingCity().setIsCapital(cityName.getIsCapital());
                        details.getProductionDetails().getData().getRecordingCity().setId(cityName.getId());
                        break;
                    }
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PHOTOGRAPHERNAME, row, false)) {
            String photographerName = checkPhotographerName(AdCostsData.getField(AdCostsSchemaField.PHOTOGRAPHERNAME, row));
            details.getProductionDetails().getData().setPhotographerName(photographerName);
        }

        Vendors vendors = null;
        VendorCategoryModels vendorCategoryModels = null;
        if (AdCostsData.containsField(AdCostsSchemaField.POSTPRODUCTIONCOMPANY, row, false)) {
            vendors = null;
            vendors = loadVendorListPerProductionCategory("PostProduction", AdCostsData.getField(AdCostsSchemaField.POSTPRODUCTIONCOMPANY, row));
            vendorCategoryModels = getVendorCategoryModels("PostProduction",vendors);
            details.getProductionDetails().getData().getPostProductionCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getPostProductionCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getPostProductionCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getPostProductionCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getPostProductionCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getPostProductionCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getPostProductionCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.POSTPRODUCTIONCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.POSTPRODUCTIONCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getPostProductionCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getPostProductionCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONCOMPANY, row, false)) {
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("Production", AdCostsData.getField(AdCostsSchemaField.PRODUCTIONCOMPANY, row));
            vendorCategoryModels = getVendorCategoryModels("Production",vendors);
            details.getProductionDetails().getData().getProductionCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getProductionCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getProductionCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getProductionCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getProductionCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getProductionCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getProductionCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.PRODUCTIONCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getProductionCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getProductionCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.TALENTCOMPANY, row, false)) {
            vendors = null;
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("Talent", AdCostsData.getField(AdCostsSchemaField.TALENTCOMPANY, row));
            vendorCategoryModels = getVendorCategoryModels("Talent",vendors);
            details.getProductionDetails().getData().getTalentCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getTalentCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getTalentCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getTalentCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getTalentCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getTalentCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getTalentCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.TALENTCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.TALENTCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getTalentCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getTalentCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANY, row, false)) {
            vendors = null;
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("AudioMusic", AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANY, row));
            vendorCategoryModels = getVendorCategoryModels("AudioMusic",vendors);
            details.getProductionDetails().getData().getMusicCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getMusicCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getMusicCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getMusicCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getMusicCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getMusicCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getMusicCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getMusicCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getMusicCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANYCGI, row, false)) {
            vendors = null;
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("AudioMusic", AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANYCGI, row));
            vendorCategoryModels = getVendorCategoryModels("AudioMusic",vendors);
            details.getProductionDetails().getData().getMusicCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getMusicCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getMusicCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getMusicCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getMusicCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getMusicCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getMusicCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getMusicCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getMusicCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.CGIANIMAIONCOMPANY, row, false)) {
            vendors = null;
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("CGI", AdCostsData.getField(AdCostsSchemaField.CGIANIMAIONCOMPANY, row));
            vendorCategoryModels = getVendorCategoryModels("CGI",vendors);
            details.getProductionDetails().getData().getCgiAnimationCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getCgiAnimationCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getCgiAnimationCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getCgiAnimationCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getCgiAnimationCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getCgiAnimationCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getCgiAnimationCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.CGIANIMAIONCOMPANYCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.CGIANIMAIONCOMPANYCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getCgiAnimationCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getCgiAnimationCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }

        if (AdCostsData.containsField(AdCostsSchemaField.DIGITALDEVELOPMENTCOMPANY, row, false)) {
            vendors = null;
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("DigitalDevelopment", AdCostsData.getField(AdCostsSchemaField.DIGITALDEVELOPMENTCOMPANY, row));
            vendorCategoryModels = getVendorCategoryModels("DigitalDevelopment", vendors);
            details.getProductionDetails().getData().getDigitalDevelopmentCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getDigitalDevelopmentCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getDigitalDevelopmentCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getDigitalDevelopmentCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getDigitalDevelopmentCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getDigitalDevelopmentCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getDigitalDevelopmentCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.DIGITALDEVELOPMENTCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.DIGITALDEVELOPMENTCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")) {
                    details.getProductionDetails().getData().getDigitalDevelopmentCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);
                } else
                    details.getProductionDetails().getData().getDigitalDevelopmentCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }

        if (AdCostsData.containsField(AdCostsSchemaField.RETOUCHINGCOMPANY, row, false)) {
            vendors = null;
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("Retouching", (AdCostsData.getField(AdCostsSchemaField.RETOUCHINGCOMPANY, row)));
            vendorCategoryModels = getVendorCategoryModels("Retouching",vendors);
            details.getProductionDetails().getData().getRetouchingCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getRetouchingCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getRetouchingCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getRetouchingCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getRetouchingCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getRetouchingCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getRetouchingCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.RETOUCHINGCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.RETOUCHINGCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getRetouchingCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getRetouchingCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }

        if (AdCostsData.containsField(AdCostsSchemaField.PHOTOGRAPHERCOMPANY, row, false)) {
            vendors = null;
            vendorCategoryModels = null;
            vendors = loadVendorListPerProductionCategory("Photography", AdCostsData.getField(AdCostsSchemaField.PHOTOGRAPHERCOMPANY, row));
            vendorCategoryModels = getVendorCategoryModels("Photography",vendors);
            details.getProductionDetails().getData().getPhotographerCompany().setId(vendors.getId());
            details.getProductionDetails().getData().getPhotographerCompany().setName(vendors.getName());
            details.getProductionDetails().getData().getPhotographerCompany().setSapVendorCode(vendors.getSapVendorCode());
            details.getProductionDetails().getData().getPhotographerCompany().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
            details.getProductionDetails().getData().getPhotographerCompany().setProductionCategory(vendorCategoryModels.getName());
            details.getProductionDetails().getData().getPhotographerCompany().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            details.getProductionDetails().getData().getPhotographerCompany().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            if (AdCostsData.containsField(AdCostsSchemaField.PHOTOGRAPHERCOMPANYACTIVATEDIRECTBILLING, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.PHOTOGRAPHERCOMPANYACTIVATEDIRECTBILLING, row).equals("Yes")){
                    details.getProductionDetails().getData().getPhotographerCompany().setIsDirectPayment(true);
                    details.getProductionDetails().getData().getDirectPaymentVendor().setIsDirectPayment(true);}
                else
                    details.getProductionDetails().getData().getPhotographerCompany().setIsDirectPayment(false);
                details.getProductionDetails().getData().getDirectPaymentVendor().setId(vendors.getId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setName(vendors.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setSapVendorCode(vendors.getSapVendorCode());
                details.getProductionDetails().getData().getDirectPaymentVendor().setHasDirectPayment(vendorCategoryModels.getHasDirectPayment());
                details.getProductionDetails().getData().getDirectPaymentVendor().setProductionCategory(vendorCategoryModels.getName());
                details.getProductionDetails().getData().getDirectPaymentVendor().setDefaultCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
                details.getProductionDetails().getData().getDirectPaymentVendor().setCurrencyId(vendorCategoryModels.getDefaultCurrencyId());
            }
        }
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        getAdcostApi().createProductionDetails(costId, details);
        Common.sleep(1000); // slow down cost creation process
    }

    // via UI
    private void checkForDuplicateTravellerName(String travelerName, int rowCount) {
        int counter = 0;
        AdCostsProductionDetailsPage.TravelDetailsSection section = openAdCostsProductionDetailsPage().getTravelCostDetails();
        List<String> travellerNameList = new ArrayList<>();
        for (int i = 1; i <= rowCount; i++) {
            travellerNameList.add(section.getTravelerNameForGivenSection(i));
            counter++;
        }

        if (Collections.frequency(travellerNameList,travelerName)>=2)
            throw new AssertionError("Ambiguity: Found multiple Travel Costs with same 'Traveler name'. : " + travelerName + "'. For obvious reasons traveller name should be unique in auto scenario's");
        else if (counter == 0)
            throw new AssertionError("Couldn't found any Travel Costs with 'Traveler name': " + travelerName);
    }

    private AdCostsProductionDetailsPage fillProductionDetailsSectionViaUI(ExamplesTable fieldsTable) {
        AdCostsProductionDetailsPage prodPage = openAdCostsProductionDetailsPage();
        prodPage.waitUntilAllFeildsLoads();
        Map<String, String> row = parametrizeTabularRow(fieldsTable);

        Vendors vendors = null;
        if (AdCostsData.containsField(AdCostsSchemaField.POSTPRODUCTIONCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.POSTPRODUCTIONCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("PostProduction", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.POSTPRODUCTIONCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.PRODUCTIONCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("Production", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PRODUCTIONCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.TALENTCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.TALENTCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("Talent", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TALENTCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("AudioMusic", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MUSICCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANYCGI, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANYCGI,row).split(";");
            vendors = loadVendorListPerProductionCategory("Music", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MUSICCOMPANYCGI),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.CGIANIMAIONCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.CGIANIMAIONCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("CGI",fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CGIANIMAIONCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.DIGITALDEVELOPMENTCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.DIGITALDEVELOPMENTCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("DigitalDevelopment", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DIGITALDEVELOPMENTCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PHOTOGRAPHERCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.PHOTOGRAPHERCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("Photography", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PHOTOGRAPHERCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.RETOUCHINGCOMPANY, row, false)) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.RETOUCHINGCOMPANY,row).split(";");
            vendors = loadVendorListPerProductionCategory("Retouching", fieldValues[0].trim());
            fillCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.RETOUCHINGCOMPANY),fieldValues,vendors.getName());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PHOTOGRAPHERNAME, row, false)) {
            String photographerName = checkPhotographerName(AdCostsData.getField(AdCostsSchemaField.PHOTOGRAPHERNAME, row));
            prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PHOTOGRAPHERNAME), photographerName);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.STILLIMAGENUMBEROFSHOOTDAYS, row, false))
            prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.STILLIMAGENUMBEROFSHOOTDAYS), AdCostsData.getField(AdCostsSchemaField.STILLIMAGENUMBEROFSHOOTDAYS, row));
        if (AdCostsData.containsField(AdCostsSchemaField.FIRSTSHOOTDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.FIRSTSHOOTDATE, row);
            if (checkDateFormatINddMMyyyy(date))
                prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.FIRSTSHOOTDATE), date);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.NUMBEROFSHOOTDAYS, row, false))
            prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NUMBEROFSHOOTDAYS), AdCostsData.getField(AdCostsSchemaField.NUMBEROFSHOOTDAYS, row));
        if (AdCostsData.containsField(AdCostsSchemaField.DIRECTOR, row, false)) {
            String directorName = checkDirectorName(AdCostsData.getField(AdCostsSchemaField.DIRECTOR, row));
            prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DIRECTOR), directorName);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.SHOOTCOUNTRY, row, false)) {
            TravelCountry country = getCountryDetails(AdCostsData.getField(AdCostsSchemaField.SHOOTCOUNTRY, row));
            prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SHOOTCOUNTRY), country.getName());
            if (AdCostsData.containsField(AdCostsSchemaField.SHOOTCITY, row, false)) {
                for (Cities cityName : country.getCities())
                    if (cityName.getName().equals(AdCostsData.getField(AdCostsSchemaField.SHOOTCITY, row)))
                        prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SHOOTCITY), cityName.getName());
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.RECORDINGDATE, row);
            if (checkDateFormatINddMMyyyy(date))
                prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.RECORDINGDATE), date);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGDAYS, row, false))
            prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.RECORDINGDAYS), AdCostsData.getField(AdCostsSchemaField.RECORDINGDAYS, row));
        if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGCOUNTRY, row, false)) {
            TravelCountry country = getCountryDetails(AdCostsData.getField(AdCostsSchemaField.RECORDINGCOUNTRY, row));
            prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.RECORDINGCOUNTRY), country.getName());
            if (AdCostsData.containsField(AdCostsSchemaField.RECORDINGCITY, row, false)) {
                for (Cities cityName : country.getCities())
                    if (cityName.getName().equals(AdCostsData.getField(AdCostsSchemaField.RECORDINGCITY, row)))
                        prodPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.RECORDINGCITY), cityName.getName());
            }
        }
        return prodPage;
    }

    private AdCostsProductionDetailsPage.AdCostsTravelCostFormPage fillTravelCostDetailsViaUI(ExamplesTable fieldsTable) {
        AdCostsProductionDetailsPage.AdCostsTravelCostFormPage travelCostFormPage = openAdCostsProductionDetailsPage().getTravelCostFormPage();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            TravelDetails details = new TravelDetails();
            if (AdCostsData.containsField(AdCostsSchemaField.NAMEOFTRAVELLER, row, false)) {
                String travellerName = wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.NAMEOFTRAVELLER, row));
                details.setName(travellerName);
                CheckIfTravelDetailsAlreadyExists(details);
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NAMEOFTRAVELLER), travellerName);}
            if (AdCostsData.containsField(AdCostsSchemaField.ROLEOFTRAVELLER, row, false)) {
                String travellerRole = getTravellerRole(AdCostsData.getField(AdCostsSchemaField.ROLEOFTRAVELLER, row)).getValue();
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ROLEOFTRAVELLER), travellerRole);}
            if (AdCostsData.containsField(AdCostsSchemaField.SHOOTDAYS, row, false))
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SHOOTDAYS), AdCostsData.getField(AdCostsSchemaField.SHOOTDAYS, row));
            if (AdCostsData.containsField(AdCostsSchemaField.DESTINATIONREGION, row, false)) {
                String regionName = getRegionByName(AdCostsData.getField(AdCostsSchemaField.DESTINATIONREGION, row)).getName();
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DESTINATIONREGION), regionName);}
            if (AdCostsData.containsField(AdCostsSchemaField.COUNTRYOFTRAVEL, row, false)) {
                String travellerCountry = getCountryDetails(AdCostsData.getField(AdCostsSchemaField.COUNTRYOFTRAVEL, row)).getName();
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.COUNTRYOFTRAVEL), travellerCountry);}
            if (AdCostsData.containsField(AdCostsSchemaField.SHOOTCITY, row, false)) {
                if(getShootCity(AdCostsData.getField(AdCostsSchemaField.SHOOTCITY, row)).getValue()!=null);
                   travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SHOOTCITY), AdCostsData.getField(AdCostsSchemaField.SHOOTCITY, row));}
            if (AdCostsData.containsField(AdCostsSchemaField.MODEOFTRAVEL, row, false))
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MODEOFTRAVEL), AdCostsData.getField(AdCostsSchemaField.MODEOFTRAVEL, row));
            if (AdCostsData.containsField(AdCostsSchemaField.TRANSPORTATIONCOSTFEE, row, false))
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRANSPORTATIONCOSTFEE), AdCostsData.getField(AdCostsSchemaField.TRANSPORTATIONCOSTFEE, row));
            if (AdCostsData.containsField(AdCostsSchemaField.DOESTRAVELCOVEROTHERCONTENTTYPES, row, false)) {
                if (AdCostsData.getField(AdCostsSchemaField.DOESTRAVELCOVEROTHERCONTENTTYPES, row).equalsIgnoreCase("Yes")) {
                    travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DOESTRAVELCOVEROTHERCONTENTTYPES), "true");
                    if (AdCostsData.containsField(AdCostsSchemaField.IFYESWHICH, row, false))
                            travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.IFYESWHICH), AdCostsData.getField(AdCostsSchemaField.IFYESWHICH, row)); }}
            if (AdCostsData.containsField(AdCostsSchemaField.TRAVELDETAILSCOMMENTS, row, false))
                travelCostFormPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELDETAILSCOMMENTS), AdCostsData.getField(AdCostsSchemaField.TRAVELDETAILSCOMMENTS, row));
        }
        return travelCostFormPage;
    }

    private void fillCategoryFields(AdCostsProductionDetailsPage prodPage,String categoryName,String[] fieldValues, String fieldValue){
        prodPage.fillFieldByName(categoryName, fieldValue);
        Common.sleep(300);
        if(fieldValues.length>1 && !fieldValues[1].isEmpty()) {
            if (fieldValues[1].trim().equalsIgnoreCase("true")) {
                prodPage.selectActivateDirectBilling(categoryName);
                clickButtonNameOnFormPage("Activate");
                Common.sleep(500);
                if(fieldValues.length>2 && !fieldValues[2].isEmpty())
                    prodPage.selectCurrencyForActivateDirectBilling(categoryName, fieldValues[2].trim());
                    Common.sleep(500);
            }
        }
    }

    @Then("{I |}'$should' see following '$vendorName' vendor under '$category' category for cost title '$costTitle'")
    public void checkTravelDetailsThroughUI(String condition, String vendorName, String category, String costTitle) {
        AdCostsProductionDetailsPage productionDetailsPage = openProdDetailPage(wrapVariableWithTestSession(costTitle));
        assertThat("Check vendor" + vendorName + "vendor under following category: " + category, productionDetailsPage.checkVendorPresentUnderCategory(category, wrapVariableWithTestSession(vendorName)), is(condition.equalsIgnoreCase("should")));

    }

    @Given("{I |}edited Production Details with following fields for cost title '$costTitle': $data")
    @When("{I |}edit Production Details with following fields for cost title '$costTitle': $data")
    public void editProdCostDetailsThrowUI(String costTitle, ExamplesTable data) {
        AdCostsProductionDetailsPage prodPage = openProdDetailPage(costTitle);
        Map<String, String> row = parametrizeTabularRow(data);
        if (AdCostsData.containsField(AdCostsSchemaField.POSTPRODUCTIONCOMPANY, row, false)) {
            editCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.POSTPRODUCTIONCOMPANY),AdCostsData.getField(AdCostsSchemaField.POSTPRODUCTIONCOMPANY,row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONCOMPANY, row, false)) {
            editCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PRODUCTIONCOMPANY),AdCostsData.getField(AdCostsSchemaField.PRODUCTIONCOMPANY,row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.TALENTCOMPANY, row, false)) {
            editCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TALENTCOMPANY),AdCostsData.getField(AdCostsSchemaField.TALENTCOMPANY,row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANY, row, false)) {
            editCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MUSICCOMPANY),AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANY,row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.MUSICCOMPANYCGI, row, false)) {
            editCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.MUSICCOMPANYCGI),AdCostsData.getField(AdCostsSchemaField.MUSICCOMPANYCGI,row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.CGIANIMAIONCOMPANY, row, false)) {
            editCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CGIANIMAIONCOMPANY),AdCostsData.getField(AdCostsSchemaField.CGIANIMAIONCOMPANY,row));
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PHOTOGRAPHERCOMPANY, row, false)) {
            editCategoryFields(prodPage,AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PHOTOGRAPHERCOMPANY),AdCostsData.getField(AdCostsSchemaField.PHOTOGRAPHERCOMPANY,row));
        }
       prodPage.clickBtnByName("Continue");
    }

    private void editCategoryFields(AdCostsProductionDetailsPage prodPage,String categoryName, String fieldValue){
        if(!fieldValue.isEmpty())
            prodPage.selectCurrencyForActivateDirectBilling(categoryName, fieldValue.trim());
    }

    @Then ("{I |}'$condition' able to edit the currency field for catagory '$category' on production detail page for costTitle '$costTitle'")
    public void checkCurrencyFieldEditableOrNot(String condition, String category, String costTitle){
        AdCostsProductionDetailsPage prodPage = openProdDetailPage(costTitle);
        assertThat("Check currency field is editable: ", prodPage.verifyCurrencyFieldIsEditable(category), is(condition.equalsIgnoreCase("should")));
    }

    @Then ("{I |}'$condition' be able to edit the vendor field '$catgname' on production detail page for costTitle '$costTitle'")
    public void checkVendorFieldEditableOrNot(String condition, String catgName, String costTitle){
        AdCostsProductionDetailsPage productionDetailsPage = openProdDetailPage(costTitle);
        assertThat("Check Vendor field is editable: ", productionDetailsPage.verifyVendorFieldIsEditable(catgName), is(condition.equalsIgnoreCase("should")));
    }

    @Then ("{I |}'$condition' able to edit the activate vendor radio buttons for category '$catgName' on production detail page for costTitle '$costTitle'")
    public void checkActivateVendorFieldEditableOrNot(String condition, String catgName,String costTitle){
        AdCostsProductionDetailsPage productionDetailsPage = getSut().getPageCreator().getAdCostsProductionDetailsPage();
        assertThat("Check Activate Vendor fields are editable: ", productionDetailsPage.verifyActivatevendorFieldIsEditable(catgName), is(condition.equalsIgnoreCase("should")));
    }
}