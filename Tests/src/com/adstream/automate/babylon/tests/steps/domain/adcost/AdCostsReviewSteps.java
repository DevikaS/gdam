package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsReviewPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.babylon.sut.pages.adcost.elements.CostStages;
import com.adstream.automate.utils.Common;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.hamcrest.Matchers;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;

import java.text.SimpleDateFormat;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.core.IsNot.not;

/**
 * Created by Raja.Gone on 22/05/2017.
 */
public class AdCostsReviewSteps extends AdCostsHelperSteps {

    protected AdCostsReviewPage openAdCostsReviewPage(String costId,String revisionId) {
        return getSut().getPageNavigator().getAdCostsReviewPage(costId, revisionId);
    }

    @Given("{I am |}on cost review page of cost item with title '$costTitle'")
    @When("{I am |}on cost review page of cost item with title '$costTitle'")
    public AdCostsReviewPage getCostsReviewPage(String costTitle) {
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId,costStageId);
        AdCostsReviewPage costsReviewPage= openAdCostsReviewPage(costId,costRevisionId);
        if (costsReviewPage.waitUntilCostReviewPageVisible())
            return costsReviewPage;
        else
            throw new Error("Unable to open Cost Review page");
    }

    // $TabName = {COST DETAILS || PAYMENT SUMMARY  }
    @Given("{I |}selected '$tabName' tab on cost review page")
    @When("{I |}select '$tabName' tab on cost review page")
    public void selectTabsByName(String tabName) { getSut().getPageCreator().getAdCostsReviewPage().selectTabName(tabName); }

    // $TabName = {COST DETAILS || PAYMENT SUMMARY  }
    @Given("{I }selected '$tabName' tab on cost review page of cost item with title '$costTitle'")
    @When("{I }select '$tabName' tab on cost review page of cost item with title '$costTitle'")
    public void selectTabsByName(String tabName, String costTitle) { getCostsReviewPage(costTitle).selectTabName(tabName); }

    // $btnName = {Next Stage || Cancel Cost  }
    // $action = {Confirm || Cancel || Yes, cancel this cost || No  || Approve}
    @Given("{I |}clicked '$btnName' button and '$action' on cost review page")
    @When("{I |}click '$btnName' button and '$action' on cost review page")
    public void selectbtnsByName(String btnName, String action) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        String parentlocator=null;
        if (btnName.equals("Approve"))
            parentlocator= reviewPage.parentLocatorApproveButton;
        else
            parentlocator = reviewPage.selectOptionOnHeader(btnName);
        reviewPage.clickBtnByName(btnName, parentlocator);
        reviewPage.clickBtnByNameOnFormReviewPage(action);
        if((action.equalsIgnoreCase("Confirm"))||(action.equalsIgnoreCase("Approve")) || action.equalsIgnoreCase("Yes, reopen this cost"))
            reviewPage.waitForCostReviewPageToDisappear();
        if(action.equalsIgnoreCase("Yes, recall this cost")|| (action.equalsIgnoreCase("Yes, request this cost to be reopened")))
            reviewPage.waitUntilCostReviewPageVisible();

    }

    @Given("{I |}clicked '$btnName' button and '$action' on cost review page for policy exception")
    @When("{I |}click '$btnName' button and '$action' on cost review page for policy exception")
    public void actionForPolicyException(String btnName, String action) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        String parentlocator=null;
        if(btnName.equals("Approve Exceptions") || btnName.equals("Reject Exceptions"))
            parentlocator= reviewPage.parentLocatorPolicyException;
        reviewPage.clickBtnByName(btnName, parentlocator);
        reviewPage.clickBtnByNameOnFormPage(action);
        reviewPage.waitUntilCostReviewPageVisible();
    }


    @Given("{I |}clicked '$btnName' button and '$action' on cost review page for policy exceptions approval as well")
    @When("{I |}click '$btnName' button and '$action' on cost review page for policy exceptions approval as well")
    public void clickApproveCostandPolicyException(String btnName, String action) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        String parentlocator= reviewPage.parentLocatorApproveButton;
        reviewPage.clickBtnByName(btnName, parentlocator);
        reviewPage.tickPolicyExceptionApprovalOption();
        reviewPage.clickBtnByNameOnFormPage(action);
        reviewPage.waitForCostReviewPageToDisappear();
        Common.sleep(2000);
    }
    /* | Cost Title | Description | Cost Type | Usage/Buyout/Contract Type | Adcost#  | Agency Name | Agency Location | Agency Producer/Art Buyer | Target Budget Amount | Agency Tracking Number | Budget Region      | Campaign  | Organisation | Agency Currency |
     | Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity  | Start Date | End Date   | Contract Period (In Months) |
     | Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager   | Glam Squad | Security |
     Approvals = | Brand Approver | Technical Approver |
     Payment Summary = | PO Number      | Original Estimate Currency Format | Production | PostProduction | AgencyCosts | Stage Cost Total | Original Estimate | Total Cost Total |*/
    @Then("{I |}'$should' see following data in '$sectionName' section on Cost Review page: $data")
    public void checkFieldValues(String condition, String sectionName, ExamplesTable data) {
        switch (sectionName) {
            case "Cost Details":
                validateFieldsInCostDetailsSection(condition, data);
                break;
            case "Production Details":
                validateFieldsInProductionDetailsSection(data, condition);
                break;
            case "Expected Assets":
                validateFieldsInExpectedAssetsSection(data, condition);
                break;
            case "Cost":
                validateFieldsInCostItemsSection(data, condition);
                break;
            case "Supporting Documents":
                validateFieldsInSupportingDocsSection(data, condition);
                break;
            case "Approvals":
                validateFieldsInApprovalsSection(data, condition);
                break;
            case "Usage/Buyout details":
                validateFieldsInUsageBuyoutDetailsSection(data, condition);
                break;
            case "Negotiated Terms":
                validateFieldsInNegotiatedTermsSection(data, condition);
                break;
            case "Associated assets":
                validateFieldsInAssociatedAssetsSection(data,condition);
                break;
            case "Cost Items":
                validateFieldsInCostItemsSection(data, condition);
                break;
            case "Distribution":
                validateFieldsInApprovalsSection(data, condition);
                break;
            case "Travel Costs":
                validateFieldsInTravelCostsSection(data, condition);
                break;
            case "Payment Summary":
                paymentStagesAmountNew(condition,data);
                break;
            case "Value Reporting":
                validateFieldsInValueReportingSection(data,condition);
                break;
            case "Policy Exception":
                validateFieldsInPolicyexceptionSection(data,condition);
                break;
            case "I/O# Owner":
                validateFieldsInIOOwnerSection(data,condition);
                break;
            default:
                throw new IllegalArgumentException("Unknown Section Name: " + sectionName);
        }
    }

    private Map<String, String> prepareCostDetailFields(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (AdCostsData.containsField(AdCostsSchemaField.COSTTITLE, row, false)) {
            String costTitle = AdCostsData.getField(AdCostsSchemaField.COSTTITLE, row);
            row.put(AdCostsSchemaField.COSTTITLE.toString(), wrapVariableWithTestSession(costTitle));
        } if (AdCostsData.containsField(AdCostsSchemaField.AGENCYTRACKINGNUMBER, row, false)) {
            String agencyTrackingNumber = AdCostsData.getField(AdCostsSchemaField.AGENCYTRACKINGNUMBER, row);
            row.put(AdCostsSchemaField.AGENCYTRACKINGNUMBER.toString(), wrapVariableWithTestSession(agencyTrackingNumber));
        } if (AdCostsData.containsField(AdCostsSchemaField.DESCRIPTION, row, false)) {
            String description = AdCostsData.getField(AdCostsSchemaField.DESCRIPTION, row);
            row.put(AdCostsSchemaField.DESCRIPTION.toString(), wrapVariableWithTestSession(description));
        } if (AdCostsData.containsField(AdCostsSchemaField.NAMEOFTRAVELLER, row, false)) {
            String nameOfTraveller = AdCostsData.getField(AdCostsSchemaField.NAMEOFTRAVELLER, row);
            row.put(AdCostsSchemaField.NAMEOFTRAVELLER.toString(), wrapVariableWithTestSession(nameOfTraveller));
        } if (AdCostsData.containsField(AdCostsSchemaField.ASSETTITLE, row, false)) {
            String assetTitle = AdCostsData.getField(AdCostsSchemaField.ASSETTITLE, row);
            row.put(AdCostsSchemaField.ASSETTITLE.toString(), wrapVariableWithTestSession(assetTitle));
        }  if (AdCostsData.containsField(AdCostsSchemaField.AGENCYNAME, row, false)) {
            String userName = AdCostsData.getField(AdCostsSchemaField.AGENCYNAME, row);
            User user=getData().getUserByType(userName);
            if(user==null)
                    user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
            row.put(AdCostsSchemaField.AGENCYNAME.toString(), user.getAgency().getName());
        } if (AdCostsData.containsField(AdCostsSchemaField.CREATOR, row, false)) {
            String costCreator = getUsersFullName(AdCostsData.getField(AdCostsSchemaField.CREATOR, row));
            row.put(AdCostsSchemaField.CREATOR.toString(), (costCreator.toUpperCase()));
        } if (AdCostsData.containsField(AdCostsSchemaField.AGENCYLOCATION, row, false)) {
            String agencyLocation = AdCostsData.getField(AdCostsSchemaField.AGENCYLOCATION, row);
            row.put(AdCostsSchemaField.AGENCYLOCATION.toString(), agencyLocation);
        } if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERNAME, row, false)) {
            String travellerName = AdCostsData.getField(AdCostsSchemaField.TRAVELLERNAME, row);
            row.put(AdCostsSchemaField.TRAVELLERNAME.toString(), wrapVariableWithTestSession(travellerName));
        } if (AdCostsData.containsField(AdCostsSchemaField.PROJECTNAME, row, false)) {
            String projectName = AdCostsData.getField(AdCostsSchemaField.PROJECTNAME, row);
            projectName = getProjectByNameAsGlobalAdmin(projectName);
            row.put(AdCostsSchemaField.PROJECTNAME.toString(), projectName);
        } if (AdCostsData.containsField(AdCostsSchemaField.BRAND, row, false)) {
            String brand = AdCostsData.getField(AdCostsSchemaField.BRAND, row);
            if(!brand.contains("DefaultBrand"))
                brand = wrapVariableWithTestSession(brand);
            row.put(AdCostsSchemaField.BRAND.toString(), brand);
        } if (AdCostsData.containsField(AdCostsSchemaField.SECTOR, row, false)) {
            String sector = AdCostsData.getField(AdCostsSchemaField.SECTOR, row);
            if(!sector.contains("DefaultSector"))
                sector = wrapVariableWithTestSession(sector);
            row.put(AdCostsSchemaField.SECTOR.toString(), sector);
        }
        return row;
    }

    @Then ("{I |}'$condition' see following fields in cost stage section on cost review page:$data")
    public void validateStatusInCostStageSection(String condition, ExamplesTable data){
        AdCostsReviewPage.CostStageSection costStage = getSut().getPageCreator().getAdCostsReviewPage().getCostStageSection();
        Map<String, String> row = parametrizeTabularRow(data);
        if (row.get("Stage")!=null) {
            assertThat("Check field: Cost Stage" ,
                    costStage.getFieldValueInCostStageSection("Stage",row.get("Stage")).equals(row.get("Stage")), is(condition.equalsIgnoreCase("should")));
        }
        if (row.get("Status")!=null) {
            assertThat("Check field: Cost status" ,
                    costStage.getFieldValueInCostStageSection("Status",row.get("Status")).equals(row.get("Status")), is(condition.equalsIgnoreCase("should")));
        }
    }

    private void validateFieldsInCostDetailsSection(String condition, ExamplesTable data) {
        AdCostsReviewPage.CostDetailsSection costDetails = getSut().getPageCreator().getAdCostsReviewPage().getCostDetailsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(), costDetails.getFieldValueInCostDetailsSection(entry.getKey()),
                    condition.equalsIgnoreCase("should")?is(entry.getValue().toUpperCase()):not(is(entry.getValue().toUpperCase())));
        }
    }

    private void validateFieldsInUsageBuyoutDetailsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.UsageBuyoutDetailsSection usageBuyOutDetails = getSut().getPageCreator().getAdCostsReviewPage().getUsageBuyoutDetailsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),
                    usageBuyOutDetails.getFieldValueInUsageBuyoutDetailsSection(entry.getKey()).equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
        }
    }

    private void validateFieldsInNegotiatedTermsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.NegotiatedTermsSection negotiatedTerms = getSut().getPageCreator().getAdCostsReviewPage().getNegotiatedTermsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),
                    negotiatedTerms.getFieldValueInNegotiatedTermsSection(entry.getKey()).equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
        }
    }

    // | Section Name | Original Estimate | Final Actual Local | Final Actual  |
    @Then ("{I |}should see following data in cost section on Cost Review page:$data")
    public void validateDataInCostItemsSection(ExamplesTable data) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.CostItemsSection costItemsSection = reviewPage.getCostItemsSection();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            String[] allSections;
            String sectionName="";
            String itemSectionName = "";
            allSections = row.get("Section Name").split(";");
            if (allSections.length==2){
               itemSectionName=allSections[0];
               sectionName=allSections[1];
            }
            if (allSections.length==1)
               sectionName = allSections[0];
            if (allSections.length>2)
                throw new IllegalArgumentException("Found wrong section names n data: "+allSections.length);
            if (sectionName.equalsIgnoreCase("Grand Total"))
                costItemsSection.loadDataInGrandTotalSection();
            else
                costItemsSection.loadDataInCostLineItems(sectionName, itemSectionName);

            String assertionText = "Check '"+sectionName+"' cost for: ";
            if (row.containsKey(CostStages.ORIGINALESTIMATEWITHOUTSPACE.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATEWITHOUTSPACE,
                        costItemsSection.getOriginalEstimateWithOutSpace(), equalTo(row.get(CostStages.ORIGINALESTIMATEWITHOUTSPACE.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATE.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATE,
                        costItemsSection.getOriginalEstimate(), equalTo(row.get(CostStages.ORIGINALESTIMATE.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATELOCAL.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATELOCAL,
                        costItemsSection.getOriginalEstimateLocal(), equalTo(row.get(CostStages.ORIGINALESTIMATELOCAL.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATELOCALWITHOUTSPACE.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATELOCALWITHOUTSPACE,
                        costItemsSection.getOriginalEstimateLocalWithOutSpace(), equalTo(row.get(CostStages.ORIGINALESTIMATELOCALWITHOUTSPACE.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATEREVISIONLOCALWITHOUTSPACE.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATEREVISIONLOCALWITHOUTSPACE,
                        costItemsSection.getOriginalEstimateRevisionLocalWithOutSpace(), equalTo(row.get(CostStages.ORIGINALESTIMATEREVISIONLOCALWITHOUTSPACE.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATEREVISIONWITHOUTSPACE.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATEREVISIONWITHOUTSPACE,
                        costItemsSection.getOriginalEstimateRevisionWithOutSpace(), equalTo(row.get(CostStages.ORIGINALESTIMATEREVISIONWITHOUTSPACE.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATEREVISIONLOCAL.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATEREVISIONLOCAL,
                        costItemsSection.getOriginalEstimateRevisionLocal(), equalTo(row.get(CostStages.ORIGINALESTIMATEREVISIONLOCAL.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATEREVISION.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATEREVISION,
                        costItemsSection.getOriginalEstimateRevision(), equalTo(row.get(CostStages.ORIGINALESTIMATEREVISION.toString())));
            if (row.containsKey(CostStages.FIRSTPRESENTATIONLOCAL.toString()))
                assertThat(assertionText + CostStages.FIRSTPRESENTATIONLOCAL,
                        costItemsSection.getFirstPresentationLocal(), equalTo(row.get(CostStages.FIRSTPRESENTATIONLOCAL.toString())));
            if (row.containsKey(CostStages.FIRSTPRESENTATION.toString()))
                assertThat(assertionText + CostStages.FIRSTPRESENTATION,
                        costItemsSection.getFirstPresentation(), equalTo(row.get(CostStages.FIRSTPRESENTATION.toString())));
            if (row.containsKey(CostStages.FIRSTPRESENTATIONREVISIONLOCAL.toString()))
                assertThat(assertionText + CostStages.FIRSTPRESENTATIONREVISIONLOCAL,
                        costItemsSection.getFirstPresentationRevisionLocal(), equalTo(row.get(CostStages.FIRSTPRESENTATIONREVISIONLOCAL.toString())));
            if (row.containsKey(CostStages.FIRSTPRESENTATIONREVISION.toString()))
                assertThat(assertionText + CostStages.FIRSTPRESENTATIONREVISION,
                        costItemsSection.getFirstPresentationRevision(), equalTo(row.get(CostStages.FIRSTPRESENTATIONREVISION.toString())));
            if (row.containsKey(CostStages.FINALACTUALLOCAL.toString()))
                assertThat(assertionText + CostStages.FINALACTUALLOCAL,
                        costItemsSection.getFinalActualLocal(), equalTo(row.get(CostStages.FINALACTUALLOCAL.toString())));
            if (row.containsKey(CostStages.FINALACTUAL.toString()))
                assertThat(assertionText + CostStages.FINALACTUAL, costItemsSection.getFinalActual(), equalTo(row.get(CostStages.FINALACTUAL.toString())));
            if (row.containsKey(CostStages.FINALACTUALLOCALWITHOUTSPACE.toString()))
                assertThat(assertionText + CostStages.FINALACTUALLOCALWITHOUTSPACE,
                        costItemsSection.getFinalActualLocalWithOutSpace(), equalTo(row.get(CostStages.FINALACTUALLOCALWITHOUTSPACE.toString())));
            if (row.containsKey(CostStages.FINALACTUALWITHOUTSPACE.toString()))
                assertThat(assertionText + CostStages.FINALACTUALWITHOUTSPACE, costItemsSection.getFinalActualWithOutSpace(), equalTo(row.get(CostStages.FINALACTUALWITHOUTSPACE.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATEREVISIONLOCALWITHSPACE.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATEREVISIONLOCALWITHSPACE,
                        costItemsSection.getOriginalEstimateRevisionLocalWithSpace(), equalTo(row.get(CostStages.ORIGINALESTIMATEREVISIONLOCALWITHSPACE.toString())));
            if (row.containsKey(CostStages.ORIGINALESTIMATEREVISIONWITHOUTANYSPACE.toString()))
                assertThat(assertionText + CostStages.ORIGINALESTIMATEREVISIONWITHOUTANYSPACE,
                        costItemsSection.getOriginalEstimateRevisionWithOutAnySpace(), equalTo(row.get(CostStages.ORIGINALESTIMATEREVISIONWITHOUTANYSPACE.toString())));
            if (row.containsKey(CostStages.FIRSTPRESENTATIONREVISIONLOCALWITHSPACE.toString()))
                assertThat(assertionText + CostStages.FIRSTPRESENTATIONREVISIONLOCALWITHSPACE,
                        costItemsSection.getFirstPresentationRevisionLocalWithSpace(), equalTo(row.get(CostStages.FIRSTPRESENTATIONREVISIONLOCALWITHSPACE.toString())));
            if (row.containsKey(CostStages.FIRSTPRESENTATIONREVISIONWITHOUTANYSPACE.toString()))
                assertThat(assertionText + CostStages.FIRSTPRESENTATIONREVISIONWITHOUTANYSPACE,
                        costItemsSection.getFirstPresentationRevisionWithOutAnySpace(), equalTo(row.get(CostStages.FIRSTPRESENTATIONREVISIONWITHOUTANYSPACE.toString())));
            if (row.containsKey(CostStages.CURRENTREVISIONLOCAL.toString()))
                assertThat(assertionText + CostStages.CURRENTREVISIONLOCAL,
                        costItemsSection.getCurrentRevisionLocal(), equalTo(row.get(CostStages.CURRENTREVISIONLOCAL.toString())));
            if (row.containsKey(CostStages.CURRENTREVISION.toString()))
                assertThat(assertionText + CostStages.CURRENTREVISION,
                        costItemsSection.getCurrentRevision(), equalTo(row.get(CostStages.CURRENTREVISION.toString())));
        }
    }

    @Then ("{I |}should see following data in payment line items on payment summary page:$data")
    public void validateDataInPaymentLineItem(ExamplesTable data) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        getSut().getWebDriver().navigate().refresh();
        reviewPage.selectTabName("PAYMENT SUMMARY");
        AdCostsReviewPage.PaymentSummaryTabNew paymentSummaryTabNew = reviewPage.getPaymentSummaryTabNew();

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            paymentSummaryTabNew.loadPaymentLineItemsForStage(checkPaymentStageName(row.get("Stage")));
            List<String> actualValues = new ArrayList<>();
            List<String> expectedValues = new ArrayList<>();
            String fieldName = null;

            if (row.containsKey("STILL IMAGE PRODUCTION COST")) {
                fieldName = "STILL IMAGE PRODUCTION COST";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getStillImageProduction());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("STILL IMAGE POST PRODUCTION COST")) {
                fieldName = "STILL IMAGE POST PRODUCTION COST";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getStillImagePostProduction());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("PRODUCTION COST")) {
                fieldName ="PRODUCTION COST";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getVideoProduction());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("POST PRODUCTION COST")) {
                fieldName ="POST PRODUCTION COST";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getVideoPostProduction());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("TECHNICAL FEE (IF APPLICABLE)")) {
                fieldName = "TECHNICAL FEE (IF APPLICABLE)";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getTechnicalFee());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("INSURANCE (IF NOT COVERED BY P&G)")) {
                fieldName = "INSURANCE (IF NOT COVERED BY P&G)";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getInsurance());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("OTHER COSTS")) {
                fieldName = "OTHER COSTS";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getOtherCosts());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("TALENT FEES")) {
                fieldName = "TALENT FEES";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getTalentFees());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }

            if (row.containsKey("Cost Total")) {
                fieldName = "Cost Total";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getCostTotal());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            assertThat("Check details in 'Payment group Line Item' section on Cost Review page: ",actualValues,equalTo(expectedValues));
            reviewPage.selectTabName("OVERVIEW");
        }
    }

    private void validateFieldsInCostItemsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.CostItemsSection costItemsSection = getSut().getPageCreator().getAdCostsReviewPage().getCostItemsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),
                    costItemsSection.getFieldValueInCostTermsSection(entry.getKey()).equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
        }
    }

    private void validateFieldsInSupportingDocsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.SupportingDocsSection supportingDocs = getSut().getPageCreator().getAdCostsReviewPage().getSupportingDocsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            //supportingDocs.loadSupportingDocs(entry.getKey());
            assertThat("Check field: " + entry.getKey(),
                    supportingDocs.getDocumentName(entry.getKey()).equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
        }
    }

    private void validateFieldsInApprovalsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.ApprovalsSection approvalsSection = getSut().getPageCreator().getAdCostsReviewPage().getApprovalsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        String sectionName;
        for (Map.Entry<String, String> entry : row.entrySet()) {
            sectionName = approvalsSection.getApproverSectionLocator(entry.getKey());
            int approversCount = approvalsSection.getApproversCount(sectionName);
            for (int i = 1; i <= approversCount; i++) {
                approvalsSection.loadApprovalName(i, sectionName);
                assertThat("Check field: " + entry.getKey(),
                        approvalsSection.getApproverName().equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
            }
        }
    }

    private void validateFieldsInExpectedAssetsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.ExpectedAssetsSection expectedAssetsSection = getSut().getPageCreator().getAdCostsReviewPage().getExpectedAssetsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),
                    expectedAssetsSection.getFieldValueInExpectedAssetsSection(entry.getKey()).equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
        }
    }

    private void validateFieldsInProductionDetailsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.ProductionDetailsSection productionDetailsSection = getSut().getPageCreator().getAdCostsReviewPage().getProductionDetailsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),
                    productionDetailsSection.getFieldValueInProductionDetailsSection(entry.getKey()).equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
        }
    }

    private void validateFieldsInTravelCostsSection(ExamplesTable data, String condition) {
        AdCostsReviewPage.TravelCostsSection travelCostsSection = getSut().getPageCreator().getAdCostsReviewPage().getTravelCostsSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),
                    travelCostsSection.getFieldValueInTravelCostsSection(entry.getKey()).equals(entry.getValue()), is(condition.equalsIgnoreCase("should")));
        }
    }

    private void validateFieldsInAssociatedAssetsSection(ExamplesTable data, String condition) {
        for (int i = 0; i < data.getRowCount(); i++) {
            AdCostsReviewPage.AssociatedAssetsSection associatedAssetsSection = getSut().getPageCreator().getAdCostsReviewPage().getAssociatedAssetsSection();
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Ad-ID")) {
                Costs costs = getCostDetails(wrapVariableWithTestSession(row.get("Ad-ID")));
                String costId = costs.getId();
                String costStageId = getCostStageId(costId);
                String costRevisionId = getCostRevisionId(costId, costStageId);
                ExpectedAssets[] assets = getAdcostApi().getExpectedAssets(costId, costStageId, costRevisionId);
                for (ExpectedAssets asset : assets) {
                    if (asset.getTitle().equals(wrapVariableWithTestSession(row.get("Asset name")))) {
                        associatedAssetsSection.loadData(i);
                        assertThat(associatedAssetsSection.getAdID(), condition.equals("should") ? is(asset.getAdId()) : not(is(asset.getAdId())));
                        if (row.containsKey("Asset name"))
                           assertThat(associatedAssetsSection.getAssetName(), condition.equals("should") ? is(wrapVariableWithTestSession(row.get("Asset name"))) : not(is(wrapVariableWithTestSession(row.get("Asset name")))));
                        if (row.containsKey("Initiative"))
                            assertThat(associatedAssetsSection.getInitiative(), condition.equals("should") ? is(row.get("Initiative")) : not(is(row.get("Initiative"))));
                        if (row.containsKey("Associated Cost"))
                            assertThat(associatedAssetsSection.getAssociatedCost(), condition.equals("should") ? is(costs.getCostNumber()) : not(is(costs.getCostNumber())));
                    }
                }
            }
        }
    }

    @Then ("{I |}'$condition' see following data in payment summary section on Cost Review page:$data")
    public void paymentStagesAmountNew(String condition, ExamplesTable data){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        getSut().getWebDriver().navigate().refresh();
        reviewPage.selectTabName("PAYMENT SUMMARY");
        AdCostsReviewPage.PaymentSummaryTabNew paymentSummaryTabNew = reviewPage.getPaymentSummaryTabNew();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            paymentSummaryTabNew.loadDataForStage(checkPaymentStageName(row.get("Stage")));
            List<String> actualValues = new ArrayList<>();
            List<String> expectedValues = new ArrayList<>();
            String fieldName = null;

            if (row.containsKey("Aipe payment amount")) {
                fieldName = "Aipe payment amount";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getAipePaymentAmount());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("Original Estimate payment amount")) {
                fieldName = "Original Estimate payment amount";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getOriginalEstimatePaymentAmount());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("First Presentation payment amount")) {
                fieldName ="First Presentation payment amount";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getFirstPresentationPaymentAmount());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("Final Actual payment amount")) {
                fieldName ="Final Actual payment amount";
                 actualValues.add(fieldName+": "+paymentSummaryTabNew.getFinalActualPaymentAmount());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (row.containsKey("PO Total")) {
                fieldName = "PO Total";
                actualValues.add(fieldName+": "+paymentSummaryTabNew.getPoTotal());
                expectedValues.add(fieldName+": "+row.get(fieldName));
            }
            if (condition.equalsIgnoreCase("should"))
            assertThat("Check details in 'Payment Summary' section on Cost Review page: ",actualValues,equalTo(expectedValues));
            else
            assertThat("Check details in 'Payment Summary' section on Cost Review page: ",actualValues,is(not(equalTo(expectedValues))));
        }
    }


    // | Document Format | Document Name | Download Button |
    @Then("{I |}'$condition' see following data for '$formName' supporting document on Cost Review page: $data")
    public void checkSupportingDocDetails(String condition, String formName, ExamplesTable data) {
        AdCostsReviewPage.SupportingDocsSection supportingDocs = getSut().getPageCreator().getAdCostsReviewPage().getSupportingDocsSection();
        supportingDocs.loadSupportingDocs(formName);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Document Format"))
                assertThat("Check 'Document Format': ",
                        supportingDocs.getDocumentFormat().equals(row.get("Document Format")), is(condition.equalsIgnoreCase("should")));
            if (row.containsKey("Document Name"))
                assertThat("Check 'Document Name': ",
                        supportingDocs.getDocumentName().equals(row.get("Document Name")), is(condition.equalsIgnoreCase("should")));
            if (row.containsKey("Download Button")) {
                boolean buttonState = row.get("Download Button").equalsIgnoreCase("should");
                assertThat("Check 'Download' button: ", supportingDocs.isDownloadButton() == buttonState);
            }
        }
    }

    @Then("{I |}'$condition' see total '$docType' count as '$count' on Cost Review page")
    public void checkSupportingDocsCount(String condition, String docType,int expectedCount) {
        AdCostsReviewPage.SupportingDocsSection supportingDocs = getSut().getPageCreator().getAdCostsReviewPage().getSupportingDocsSection();
        int actual = 0;
        if(docType.equalsIgnoreCase("Supporting Documents"))
            actual = supportingDocs.getSupportingDocsCount();
        if(docType.equalsIgnoreCase("Additional Supporting Documents"))
            actual = supportingDocs.getAdditionalSupportingDocsCount();
        assertThat("Check Count in Supporting Documents section: Expected = "+expectedCount+"\n Actual = "+actual,
                actual == expectedCount, is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$should' be able to download below supporting documents on Cost Review page for cost title '$costTitle':$data")
    public void checkSupportingDocsDownload(String condition, String costTitle,ExamplesTable data){
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costStageRevisionId = getCostRevisionId(costId,costStageId);
        SupportingDocuments[] documents = getAdcostApi().getSupportingDocuments(costId,costStageId,costStageRevisionId);

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            String supportingDocumentId = null;
            for(SupportingDocuments docs:documents) {
                if(!row.get("FormName").equalsIgnoreCase("Additional supporting document")) {
                    if (docs.getName().equalsIgnoreCase(row.get("FormName"))) {
                    supportingDocumentId = docs.getId();
                    break;
                    }
                } else if(row.get("FormName").equalsIgnoreCase("Additional supporting document")) {
                    if (docs.getKey().equalsIgnoreCase("AdditionalDocument")) {
                        supportingDocumentId = docs.getId();
                        break;
                    }
                }
            }
            HttpResponse response = getAdcostApi().downloadSupportingDocuments(costId,costStageId,costStageRevisionId,supportingDocumentId,row.get("FormName"));
            for(Header header : response.getAllHeaders()){
                if(row.containsKey("Content-Length"))
                    if(header.getName().equalsIgnoreCase("content-Length")) {
                        assertThat("Check 'Content-length' for: "+row.get("FormName"), header.getValue().equalsIgnoreCase(row.get("Content-Length")), equalTo(true));
                        break;
                    }
                if(row.containsKey("FileName"))
                    if(header.getName().equalsIgnoreCase("Content-Disposition")) {
                        assertThat("Check file name in 'Content-Disposition': "+row.get("FormName"), header.getValue().contains(row.get("FileName")));
                        break;
                    }
            }
        }
    }

    @Then("{I |}'$should' see following data in '$sectionName' section for '$estimateType' on Cost Review page: $data")
    public void checkFieldValuesInCostItemSection(String condition, String sectionName, String estimateType, ExamplesTable data) {
        AdCostsReviewPage.CostItemsSection costItemsSection = getSut().getPageCreator().getAdCostsReviewPage().getCostItemsSection();

        switch (sectionName) {
            case "Cost Details":
                validateFieldsInCostDetailsSection(condition, data);
                break;
            default:
                throw new IllegalArgumentException("Unknown Section Name: " + sectionName);
        }
    }

    // Traveller name | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs
    @Then("{I |}'$should' see following fields in Travel Details section on Cost Review page:$fields")
    public void checkTravelDetailsSection(String condition,ExamplesTable fields) {
        AdCostsReviewPage.TravelCostsSection travelCostsSection = getSut().getPageCreator().getAdCostsReviewPage().getTravelCostsSection();
        assertThat("Check Row count in Travel Details Section: ", travelCostsSection.getRowsInTravelDetailsSection(),
                condition.equalsIgnoreCase("should")?is(fields.getRowCount()):not(is(fields.getRowCount())));
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fields, i);
            String wrappedTravellerName = wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.TRAVELLERNAME, row));
            travelCostsSection.loadTravelDetailsSection(wrappedTravellerName);
            if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERNAME, row, false)) {
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERNAME) + "' value on Travel details section: ", travelCostsSection.getTravelerName(),
                        condition.equalsIgnoreCase("should") ? is(wrappedTravellerName) : not(is(wrappedTravellerName)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERROLE, row, false)) {
                String travellerRole = AdCostsData.getField(AdCostsSchemaField.TRAVELLERROLE, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERROLE) + "' value on Travel details section: ",
                        travelCostsSection.getTravelerRole(), condition.equalsIgnoreCase("should") ? is(travellerRole) : not(is(travellerRole)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERSHOOTCITY, row, false)) {
                String shootCity = AdCostsData.getField(AdCostsSchemaField.TRAVELLERSHOOTCITY, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERSHOOTCITY) + "' value on Travel details section: ",
                        travelCostsSection.getShootCity(), condition.equalsIgnoreCase("should")?is(shootCity):not(is(shootCity)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TRAVELLERNOOFDAYS, row, false)) {
                String travellerDays = AdCostsData.getField(AdCostsSchemaField.TRAVELLERNOOFDAYS, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELLERNOOFDAYS) + "' value on Travel details section: ",
                        travelCostsSection.getDays(), condition.equalsIgnoreCase("should")?is(travellerDays):not(is(travellerDays)));
            }if (AdCostsData.containsField(AdCostsSchemaField.TRAVELTYPE, row, false)) {
                String travelType = AdCostsData.getField(AdCostsSchemaField.TRAVELTYPE, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TRAVELTYPE) + "' value on Travel details section: ",
                        travelCostsSection.getTravelType(), condition.equalsIgnoreCase("should")?is(travelType):not(is(travelType)));
            } if (AdCostsData.containsField(AdCostsSchemaField.TOTALAGENCYTRAVELCOSTS, row, false)) {
                String totalAgencyTravelCosts = AdCostsData.getField(AdCostsSchemaField.TOTALAGENCYTRAVELCOSTS, row);
                assertThat("Check '" + AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TOTALAGENCYTRAVELCOSTS) + "' value on Travel details section: ",
                        travelCostsSection.getTotalAgencyTravelCosts(),condition.equalsIgnoreCase("should")?is(totalAgencyTravelCosts):not(is(totalAgencyTravelCosts)));
            }
        }
    }

    @Then("{I |}'$should' see Expected Assets or Deliverables count as '$assetsCount' on Cost Review page")
    public void checkExpectedAssetsCount(String condition,int assetsCount){
        AdCostsReviewPage.ExpectedAssetsSection expectedAssetsSection = getSut().getPageCreator().getAdCostsReviewPage().getExpectedAssetsSection();
        String expectedString = "Expected Assets / Deliverables ("+assetsCount+")";
        assertThat("Check 'Expected Assets / Deliverables' count: ",expectedAssetsSection.getExpectedAssetsCount(),
                condition.equalsIgnoreCase("should")?is(expectedString):not(is(expectedString)));
    }

    @Then("{I |}'$should' see following fields in expected assets section on Cost Review page:$data")
    public void checkExpectedAssetsSection(String condition, ExamplesTable fields){
        AdCostsReviewPage.ExpectedAssetsSection expectedAssetsSection = getSut().getPageCreator().getAdCostsReviewPage().getExpectedAssetsSection();
        assertThat("Check Row count in Expected Assets Section: ",expectedAssetsSection.getExpectedAssetsSectionsCount(),
                condition.equalsIgnoreCase("should")?is(fields.getRowCount()):not(is(fields.getRowCount())));

        for (int i = 0; i < fields.getRowCount(); i++) {
            List<String> expectedList = new ArrayList<>();
            List<String> actualList = new ArrayList<>();
            Map<String, String> row = parametrizeTabularRow(fields, i);
            expectedAssetsSection.loadDataInExpectedAssetsSection(i);
            if (AdCostsData.containsField(AdCostsSchemaField.INITIATIVE, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.INITIATIVE, row));
                actualList.add(expectedAssetsSection.getInitiative());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ASSETTITLE, row, false)) {
                expectedList.add(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.ASSETTITLE, row)));
                actualList.add(expectedAssetsSection.getAssetTitle());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.ADID, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.ADID, row));
                actualList.add(expectedAssetsSection.getAdId());
            }
            if (row.containsKey("Length")) {
                expectedList.add(row.get("Length"));
                actualList.add(expectedAssetsSection.getLength());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.DEFINATION, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.DEFINATION, row));
                actualList.add(expectedAssetsSection.getDefinition());
            }
            if (row.containsKey("Media / Touchpoint")) {
                expectedList.add(row.get("Media / Touchpoint"));
                actualList.add(expectedAssetsSection.getMediaTouchPoint());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.OVAL, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.OVAL, row));
                actualList.add(expectedAssetsSection.getOval());
            }
            if (row.containsKey("First Air / Insertion Date")) {
                expectedList.add(row.get("First Air / Insertion Date"));
                actualList.add(expectedAssetsSection.getFirstAirInsertionDate());
            }
            if (AdCostsData.containsField(AdCostsSchemaField.SCRAPPED, row, false)) {
                expectedList.add(AdCostsData.getField(AdCostsSchemaField.SCRAPPED, row));
                actualList.add(expectedAssetsSection.getScrapped());
            }
            if (row.containsKey("Airing Country / Region")) {
                expectedList.add(row.get("Airing Country / Region"));
                actualList.add(expectedAssetsSection.getCountry());
            }

            for(String expected:expectedList)
                assertThat("Check Expected-Assets section: "+expected,actualList, condition.equalsIgnoreCase("should") ? hasItem(expected) : not(hasItem(expected)));
        }
    }

    // $approverType = | Brand Approver | Technical Approver |
    // $action = {Approve || Request Changes }
    @Given( "'$userName' as a '$approverType' selected '$action' button on Cost Review page")
    @When( "'$userName' as a '$approverType' selects '$action' button on Cost Review page")
    public void actionInApprovalSection(String userName, String approverType, String action){
        AdCostsReviewPage.ApprovalsSection approvalsSection = getSut().getPageCreator().getAdCostsReviewPage().getApprovalsSection();
        String sectionName = approvalsSection.getApproverSectionLocator(approverType);
        int approversCount = approvalsSection.getApproversCount(sectionName);
        boolean isApprover = false;
        for (int i = 1; i <= approversCount; i++) {
            approvalsSection.loadApprovalName(i, sectionName);
            if(userName.equals(approvalsSection.getApproverName())){
                approvalsSection.clickButtonInApproverSection(approverType,action);
                approvalsSection.selectBtnNameOnPopUp("Approval");
                isApprover = true;
                break;
            }
        }
        assertThat("Check if '"+userName+"' is a '"+approverType+"'",isApprover);
    }

    @Then("{I |}'$should' see following data in billing table on Cost Review page for cost title '$costTitle': $data")
    public void checkBillingDataOnCostReviewPage(String condition, String costTitle, ExamplesTable data){
        AdCostsReviewPage costsReviewPage = getSut().getPageCreator().getAdCostsReviewPage();

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            Set<String> set = row.keySet();
            Iterator<String> iterator = set.iterator();
            List<String> actualRowData = new ArrayList<>();
            List<String> expectedRowData = new ArrayList<>();
            while (iterator.hasNext()) {
                String headerName = iterator.next();
                if (headerName.equals("Item description")) {
                    expectedRowData.add(row.get(headerName));
                    actualRowData = costsReviewPage.getBillingTable().getDataInRow(row.get(headerName));
                } else
                    expectedRowData.add(row.get(headerName));
            }

            assertThat(actualRowData, condition.equals("should") ? is(expectedRowData) : not(is(expectedRowData)));
        }
    }

    private String checkPaymentStageName(String stageName){
        switch (stageName){
            case "Aipe payment amount":
                return "Aipe payment amount";
            case "Original Estimate payment amount":
                return "Original Estimate payment amount";
            case "First Presentation payment amount":
                return "First Presentation payment amount";
            case "Final Actual payment amount":
                return "Final Actual payment amount";
            case "PO Total":
                return "PO Total";
            case "Aipe":
                return "Aipe";
            case "Original Estimate":
                return "Original Estimate";
            case "Final Actual":
                return "Final Actual";
            case "First Presentation":
                return "First Presentation";
            default:
                throw new IllegalArgumentException("Found unknown Payment Stage name: "+stageName);
        }
    }

    @When("{I |}select '$version' revision from '$stage' beacon drop down on Cost Review page")
    public void selectCurrentRevisionVersion(String version, String stage){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        reviewPage.selectCurrentRevisionVersion(version,stage);
    }

    private void validateFieldsInValueReportingSection(ExamplesTable data, String condition) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.ValueReportingSection valueReportingSection = reviewPage.getValueReportingSection();
        reviewPage.scrollToValueReportingSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),
                    valueReportingSection.getFieldValueInValueReportngSection(entry.getKey()),condition.equalsIgnoreCase("should")?is(entry.getValue()):not(is(entry.getValue())));
        }
    }

    @Then("{I |}should see '$stage' stage with '$version' version on Cost Review page")
    public void checkCurrentRevisionVersion(String stage, String version){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        assertThat("Check stage name"+stage+ ": ",reviewPage.getStageName(stage),equalTo(stage));
        assertThat("Check version number for" +stage+ ": ", reviewPage.getStageVersion(),equalTo(version));
    }

    @Then("{I |}should see Current Revision as '$version' on Cost Review page")
    public void checkCurrentRevisionVersion(String version){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        assertThat("Check Current Revision version number: ", reviewPage.getCurrentRevisionVersion(),equalTo(version));
    }

    @Then("{I |}'$shouldState' see status as '$status' in '$stage' beacon on Cost Review page")
    public void checkCurrentRevisionStatus(String shouldState,String status, String stage){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        List<String> actualStatus = reviewPage.getAllStatusFromCurrenRevisionBecaon(stage);
        for(String state:status.split(";"))
            assertThat("Check available Status: " + state, actualStatus,shouldState.equals("should")?hasItem(state):not(hasItem(state)));
    }

    @Then("{I |}'$should' see following linked assets are clickable on Cost Review page:$data")
    public void checkLinkedAssetsAreClickable(String should, ExamplesTable data){
        for (int i = 0; i < data.getRowCount(); i++) {
            AdCostsReviewPage.AssociatedAssetsSection associatedAssetsSection = getSut().getPageCreator().getAdCostsReviewPage().getAssociatedAssetsSection();
            Map<String, String> row = parametrizeTabularRow(data, i);
            Costs costs = getCostDetails(wrapVariableWithTestSession(row.get("Associated Cost")));
            String actualLink = associatedAssetsSection.selectAssociatedCost(costs.getCostNumber(), wrapVariableWithTestSession(row.get("Asset name")));
            String expectedLink = String.format(getContext().applicationUrl+"/costs/#/costs/items?costId=%s",costs.getId());
            assertThat(actualLink,should.equals("should")?is(expectedLink):not(is(expectedLink)));
        }
    }

    @Given("{I |}edited the value reporting section with following data and click '$action' the changes:$data")
    @When("{I |}edit the value reporting section with following data and click '$action' the changes:$data")
    public void editValueReportingSection(String action, ExamplesTable data) {
        AdCostsReviewPage reviewPage= getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.ValueReportingSection valueReportingSection = reviewPage.getValueReportingSection();
        String btnName = "Edit Value Reporting";
        String parentlocator = reviewPage.selectOptionOnHeader(btnName);
        reviewPage.clickBtnByName(btnName, parentlocator);
        valueReportingSection.waitUntilValueReportingFormLoaded();
        fillValueReportingFieldsViaUI(data, valueReportingSection);
        Common.sleep(1000);
        valueReportingSection.actionOnValueReportingSection(action);
        Common.sleep(2000);
    }

    private void fillValueReportingFieldsViaUI(ExamplesTable fieldsTable, AdCostsReviewPage.ValueReportingSection valueReportingSection) {

        Map<String, String> row = parametrizeTabularRow(fieldsTable);

        if (row.get("Activity") != null && !row.get("Activity").isEmpty()) {
            Common.sleep(200);
            valueReportingSection.fillFieldByName("Activity", row.get("Activity"));
        }
        if (row.get("Cost avoidance") != null && !row.get("Cost avoidance").isEmpty()) {
            valueReportingSection.fillFieldByName("Cost avoidance", row.get("Cost avoidance"));
        }
        if (row.get("Value added") != null && !row.get("Value added").isEmpty()) {
            valueReportingSection.fillFieldByName("Value added", row.get("Value added"));
        }
        if (row.get("Hard savings current stage") != null && !row.get("Hard savings current stage").isEmpty()) {
            valueReportingSection.fillFieldByName("Hard savings current stage", row.get("Hard savings current stage"));
        }
        if (row.get("Proven strategy") != null && !row.get("Proven strategy").isEmpty()) {
            Common.sleep(200);
            valueReportingSection.fillFieldByName("Proven strategy", row.get("Proven strategy"));
        }
    }

    @Given("{I |}edited the value reporting section for cost Title '$costTitle' with following data:$data")
    @When("{I |}edit the value reporting section for cost Title '$costTitle' with following data:$data")
    public void editValueReportingViaAPI(String costTitle,ExamplesTable data){
        Map<String, String> row = parametrizeTabularRow(data);
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId,costStageId);
        ValueReportingDetails getDetails = getAdcostApi().getValueReportingdetails(costId,costRevisionId);
        ValueReportingDetails reportingDetails = new ValueReportingDetails();
        reportingDetails.setCostId(costId);
        reportingDetails.setCostStageRevisionId(costRevisionId);
        reportingDetails.setId(getDetails.getId());
        if (row.get("Proven strategy") != null && !row.get("Proven strategy").isEmpty()) {
            DictionaryEntries entries = new DictionaryEntries();
            entries = getAdcostDictionaryEntryByName("ProvenStrategy", (row.get("Proven strategy")));
            reportingDetails.setProvenStrategy(entries.getValue());
        }
        if (row.get("Activity") != null && !row.get("Activity").isEmpty()) {
            reportingDetails.setActivity(row.get("Activity"));
        }
        if (row.get("Cost avoidance") != null && !row.get("Cost avoidance").isEmpty()) {
            reportingDetails.setCostAvoidance(Integer.parseInt(row.get("Cost avoidance")));
        }
        if (row.get("Value added") != null && !row.get("Value added").isEmpty()) {
            reportingDetails.setValueAdded(Integer.parseInt(row.get("Value added")));
        }
        if (getDetails.getHardSavings()> 0) {
            reportingDetails.setHardSavings(getDetails.getHardSavings());
            reportingDetails.setHardSavingsDisabled(true);
        }else
            reportingDetails.setHardSavingsDisabled(false);
        if (row.get("Total savings") != null && !row.get("Total savings").isEmpty()) {
            reportingDetails.setTotalSavings(Integer.parseInt(row.get("Total savings")));
        }
        getAdcostApi().editValueReportingdetails(costId,costRevisionId,reportingDetails);
    }

    private int getIntegerForStringInput(String amount){
       String amt=  amount.substring(2).trim();
       return Integer.parseInt(amt);
    }

    @Then ("{I |}'$condition' see Edit Value Reporting button on cost review page for cost title '$costTitle'")
    public void checkValueReportingButtonEnabled(String condition, String costTitle){
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId,costStageId);
        AdCostsReviewPage costsReviewPage= openAdCostsReviewPage(costId,costRevisionId);
        AdCostsReviewPage.ValueReportingSection reportingSection = costsReviewPage.getValueReportingSection();

        assertThat("Check 'Edit Value Reporting' button not visible: " , reportingSection.verifyEditalueReportingButtonPresent(), equalTo(condition.equalsIgnoreCase("should")));
    }

    public void validateFieldsInPolicyexceptionSection(ExamplesTable data, String condition) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.PolicyExceptionSection policyExceptionSection = reviewPage.getPolicyexceptionSection();
        List<String> expectedValues= new ArrayList<>();
        List<String> actualValues= new ArrayList<>();
        actualValues = policyExceptionSection.loadPolicyexceptionTableOnReviewPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.get("Exception type") != null && !row.get("Exception type").isEmpty()) {
                expectedValues.add("Exception Type: "+row.get("Exception type"));
            }
            if (row.get("Reason") != null && !row.get("Reason").isEmpty()) {
                expectedValues.add("Reason: "+row.get("Reason"));
            }
            if (row.get("Cost implication") != null && !row.get("Cost implication").isEmpty()) {
                expectedValues.add("Cost Implication: "+row.get("Cost implication"));
            }
            if (row.get("Status") != null && !row.get("Status").isEmpty()) {
                expectedValues.add("Status: "+row.get("Status"));
            }
        }

        for(String exp:expectedValues)
            assertThat("Check details in 'Policy Exception' section on Cost Review page: ",actualValues,condition.equalsIgnoreCase("should")?hasItem(exp):not(hasItem(exp)));
    }

    @Then("{I |}should see following data for policy exception approval during normal Cost Approval process:$data")
    public void clickCostActionOnReviewPage(ExamplesTable data) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        Map<String, String> row = parametrizeTabularRow(data);
        String parentlocator= reviewPage.parentLocatorApproveButton;
        reviewPage.clickBtnByName("Approve", parentlocator);
        assertThat("Check 'Policy Exception Checkbox' is selcted or not: " , reviewPage.verifyPolicyExceptionCheckboxSelected(), equalTo(row.get("PolicyExceptionChecked").equalsIgnoreCase("should")));
        assertThat("Check 'Approve Button on Form Page' is enabled or not: " , reviewPage.verifyApproveBtnEnabledOrNot(), equalTo(row.get("ApproveButtonEnabled").equalsIgnoreCase("should")));
        reviewPage.clickBtnByNameOnFormPage("Cancel");
    }

    @Then ("{I |}'$condition' see value reporting section on review page for cost Title '$costTitle'")
    public void checkValueReportingSectionAndButton(String condition, String costTitle){
        AdCostsReviewPage costsReviewPage = getCostsReviewPage(costTitle);
        assertThat("Check 'Edit Value Reporting' button not visible: " , costsReviewPage.verifyIfValueReportingSectionPresent(), equalTo(condition.equalsIgnoreCase("should")));

    }

    @Then("{I |}'$shouldState' see following data in value reporting section on '$status' status of '$stage' stage:$data")
    public void checkPrevStageValueReporting(String shouldState,String status, String stage, ExamplesTable data){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        List<String> actualStatus = reviewPage.getAllStatusFromCurrenRevisionBecaon(stage);
        for(String state:actualStatus)
            if (state.equals(status)) {
                reviewPage.selectPreviousStageVersion(status);
                break;
            }
        validateFieldsInValueReportingSection(data, shouldState);
    }

    @Then ("{I |}'$condtion' see hard savings field is disabled")
    public void verifyHardCodedValueField(String condition){
        AdCostsReviewPage reviewPage= getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.ValueReportingSection valueReportingSection = reviewPage.getValueReportingSection();
        String btnName = "Edit Value Reporting";
        String parentlocator = reviewPage.selectOptionOnHeader(btnName);
        reviewPage.clickBtnByName(btnName, parentlocator);
        valueReportingSection.waitUntilValueReportingFormLoaded();
        assertThat("Check Hard Savings Field is disabled: " , valueReportingSection.verifyHardSavingField(), equalTo(condition.equalsIgnoreCase("should")));
        valueReportingSection.actionOnValueReportingSection("Cancel");
    }

    @Given("{I |}clicked '$btnName' button and '$action' on cost review page with following rejection msg '$msg'")
    @When("{I |}click '$btnName' button and '$action' on cost review page with following rejection msg '$msg'")
    public void selectbtnsByName(String btnName, String action, String msg) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        String parentlocator=null;
        parentlocator = reviewPage.selectOptionOnHeader(btnName);
        reviewPage.clickBtnByName(btnName, parentlocator);
        reviewPage.enterRejectionReasonOnFormReviewPage(msg);
        reviewPage.clickBtnByNameOnFormReviewPage(action);
    }

    @Then ("{I |}'$condition' see following fields of rejection detail in distribution details section on cost review page:$data")
    public void validateRejectionInCostStageSection(String condition, ExamplesTable data){
        AdCostsReviewPage.ApprovalsSection approvalsSection = getSut().getPageCreator().getAdCostsReviewPage().getApprovalsSection();
        Map<String, String> row = parametrizeTabularRow(data);
        if (row.get("User Name")!=null) {
            assertThat("Check field: User Name" ,
                    approvalsSection.getFieldValueInDistributionSection("User Name",row.get("User Name")).contains(row.get("User Name")), is(condition.equalsIgnoreCase("should")));
        }
        if (row.get("Timestamp")!=null) {
            Date today = new Date();
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd MMM yyyy");
            String expectedDate = DATE_FORMAT.format(today);
            assertThat("Check field: Timestamp" ,
                    approvalsSection.getFieldValueInDistributionSection("Timestamp",row.get("Timestamp")).contains(expectedDate), is(condition.equalsIgnoreCase("should")));
        }
        if (row.get("Stage")!=null) {
            assertThat("Check field: Cost stage" ,
                    approvalsSection.getFieldValueInDistributionSection("Stage",row.get("Stage")).equals(row.get("Stage")), is(condition.equalsIgnoreCase("should")));
        }
        if (row.get("Comments")!=null) {
            assertThat("Check field: Rejection Reason" ,
                    approvalsSection.getFieldValueInDistributionSection("Comments",row.get("Comments")).equals(row.get("Comments")), is(condition.equalsIgnoreCase("should")));
        }
    }

    @Then("{I |}'$condition' land on cost review page for cost title '$costTitle'")
    public void verifyLandingPage(String condition, String costTitle){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        String baseUrl = TestsContext.getInstance().applicationUrl.toString().replace("http:", "https:");
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId,costStageId);
        String desiredUrl= String.format(baseUrl+"/costs/#/costs/items/review?costId=%s&revisionId=%s",costId,costRevisionId);

        assertThat("Check Review Page url",reviewPage.verifyCurrentUrl(desiredUrl),is(condition.equalsIgnoreCase("should")));
    }

    private void validateFieldsInIOOwnerSection(ExamplesTable data, String condition) {
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.ApprovalsSection approvalsSection = reviewPage.getApprovalsSection();
        reviewPage.scrollToIOOwnerSection();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            if (entry.getKey().equalsIgnoreCase("I/O# Owner TimeStamp")) {
                Date today = new Date();
                SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd MMM yyyy");
                String expectedDate = DATE_FORMAT.format(today);
                assertThat("Check field: I/O#Owner TimeStamp" ,
                        approvalsSection.getFieldValueInDistributionSection(entry.getKey(),entry.getValue()).contains(expectedDate), is(condition.equalsIgnoreCase("should")));
            } else
            assertThat("Check field: " + entry.getKey(),
                    approvalsSection.getFieldValueInDistributionSection(entry.getKey(),entry.getValue()),condition.equalsIgnoreCase("should")?is(entry.getValue()):not(is(entry.getValue())));
        }
    }

    @Then ("{I |}'$condition' see '$ioOwner' email in io owner is hyperlinked on cost review page")
    public void checkEmailInIoOwnerIsHyperlinked(String condition, String ioOwner){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.ApprovalsSection approvalsSection = reviewPage.getApprovalsSection();
        assertThat("Check 'ioOwner' email is hyperlinked: " , approvalsSection.checkIfIoOwnerisHyperlinked(ioOwner), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then ("{I |}'$condition' see IO Owner section on cost review page")
    public void checkIOOwnerSectionPresent(String condition){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        AdCostsReviewPage.ApprovalsSection approvalsSection = reviewPage.getApprovalsSection();
        assertThat("Check I/O# Owner section should present ", approvalsSection.checkIOOwnerSectionPresent(),is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$should' following timestamps on cost review page for cost title '$costTitle':$data")
    public void checkTimeStamps(String condition, String costTitle,ExamplesTable data){
        AdCostsReviewPage reviewPage = getSut().getPageCreator().getAdCostsReviewPage();
        String costTitleWrap = wrapVariableWithTestSession(costTitle);
        Costs costs = getCostDetails(costTitleWrap);

        Map<String, String> row = parametrizeTabularRow(data, 0);
        if(row.containsKey("Created")){
            String date = costs.getCreatedDate();
            checkTime("Created",date,condition,reviewPage);
        }
        if(row.containsKey("Submitted")){
            String date = costs.getUserModifiedDate();
            checkTime("Submitted",date,condition,reviewPage);
        }
    }

    private void checkTime(String fieldName, String date,String condition,AdCostsReviewPage reviewPage){
        String format = "dd/MM/yyyy HH:mm:ss";
        DateTime d = DateTime.parse(date);
        String expected = fieldName.concat(": ").concat(d.toString(format));
        assertThat("Check 'Cost "+fieldName+"' details on Cost-Review page: ",
                reviewPage.getTimeStampsByFiledName(fieldName), condition.equalsIgnoreCase("should")?is(expected):not(is(expected)));
    }

    public String checkDownloadResponseHeaders(String response, String headerType) {
        String downloadedFileName = null;
        if (response.contains(headerType)) {
            String[] temp = response.split("filename=");
            downloadedFileName = temp[1];
        }
        return downloadedFileName;
    }
}