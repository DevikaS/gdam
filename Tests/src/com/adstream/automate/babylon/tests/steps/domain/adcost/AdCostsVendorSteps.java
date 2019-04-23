package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsVendorPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;


public class AdCostsVendorSteps extends AdCostsHelperSteps {

    @Given("{I am} on vendor section under admin page")
    @When("{I am} on vendor section under admin page")
    public AdCostsVendorPage openAdCostsVendorPage() {
        return getSut().getPageNavigator().getAdCostsVendorPage();
    }

    // action = created|updated|create|update
    @Given("{I |}'$action' vendor with following VendorDetails:$fieldsTable")
    @When("{I |}'$action' vendor with following VendorDetails:$fieldsTable")
    public void createVendorviaCore(String action, ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String vendorName = wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.VENDORNAME, row));
            String category = AdCostsData.getField(AdCostsSchemaField.CATEGORY, row);
            Vendors vendors = new Vendors();

            if (action.equalsIgnoreCase("created") || action.equalsIgnoreCase("create")) {
                checkForDuplicateVendor(vendorName, category);
                buildAddInformationSectionOfVendor(vendors, row);
                getAdcostApi().createVendors(vendors);
                Common.sleep(2000);
            } else if (action.equalsIgnoreCase("updated") || action.equalsIgnoreCase("update")) {
                getIdForExistingVendor(vendorName, vendors);
                buildAddInformationSectionOfVendor(vendors, row);
                getAdcostApi().updateVendors(vendors);
            } else
                throw new IllegalArgumentException("Found unknown action type: " + action + ". Should be 'created|updated|create|update");
        }
    }

    private void buildAddInformationSectionOfVendor(Vendors vendors, Map<String, String> row) {
        List<VendorCategoryModels> addCategory = new ArrayList<>();
        VendorCategoryModels categoryModels = new VendorCategoryModels();
        List<PaymentRules> addPymntRules = new ArrayList<>();
        PaymentRules payRules = new PaymentRules();
        Splits splits = new Splits();
        List<Splits> addSplits = new ArrayList<>();
        if (AdCostsData.containsField(AdCostsSchemaField.VENDORNAME, row, false))
            vendors.setName(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.VENDORNAME, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.CATEGORY, row, false))
            categoryModels.setName(AdCostsData.getField(AdCostsSchemaField.CATEGORY, row));
        if (AdCostsData.containsField(AdCostsSchemaField.SAPVENDORCODE, row, false))
            vendors.setSapVendorCode(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.SAPVENDORCODE, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.PREFERREDSUPPLIER, row, false))
            categoryModels.setIsPreferredSupplier(Boolean.parseBoolean(AdCostsData.getField(AdCostsSchemaField.PREFERREDSUPPLIER, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.DIRECTPAYMENT, row, false)) {
            if (AdCostsData.getField(AdCostsSchemaField.DIRECTPAYMENT, row).equals("true")) {
                categoryModels.setHasDirectPayment(Boolean.parseBoolean(AdCostsData.getField(AdCostsSchemaField.DIRECTPAYMENT, row)));
                if (AdCostsData.containsField(AdCostsSchemaField.DEFAULTCURRENCY, row, false)) {
                    AdcostCurrency[] currency = getAdcostApi().getAdcostCurrnecy();
                    for (AdcostCurrency cur : currency) {
                        if (cur.getCode().equals(AdCostsData.getField(AdCostsSchemaField.DEFAULTCURRENCY, row))) {
                            categoryModels.setDefaultCurrencyId(cur.getId());
                            break;
                        }
                    }
                }
                //hardcoded Aipe flag and AIPE value as we don't have AIPE functionality anymore, need to change method if passing from scenario
                /*splits.getstageSplits().setAipe(0);
                payRules.getCriteria().getIsAIPE().setFieldName("IsAIPE");
                payRules.getCriteria().getIsAIPE().setOperator("Equal");
                payRules.getCriteria().getIsAIPE().setValue("False");
                payRules.getCriteria().getIsAIPE().setText("False");*/
                if (AdCostsData.containsField(AdCostsSchemaField.COSTTOTALTYPE, row, false))
                    splits.setCostTotalType(AdCostsData.getField(AdCostsSchemaField.COSTTOTALTYPE, row));
                if (AdCostsData.containsField(AdCostsSchemaField.ORIGINALESTIMATE, row, false))
                    splits.getstageSplits().setOriginalEstimate(Double.parseDouble(AdCostsData.getField(AdCostsSchemaField.ORIGINALESTIMATE, row)));
                if (AdCostsData.containsField(AdCostsSchemaField.SKIPFIRSTPRESENTATION, row, false)) {
                    if (AdCostsData.getField(AdCostsSchemaField.SKIPFIRSTPRESENTATION, row).equals("true")) {
                        payRules.setSkipFirstPresentation(true);
                        splits.getstageSplits().setFirstPresentation(0);
                    } else {
                        payRules.setSkipFirstPresentation(false);
                        if (AdCostsData.containsField(AdCostsSchemaField.FIRSTPRESENTATION, row, false))
                        splits.getstageSplits().setFirstPresentation(Double.parseDouble(AdCostsData.getField(AdCostsSchemaField.FIRSTPRESENTATION, row)));
                    }
                }
                if (AdCostsData.containsField(AdCostsSchemaField.FINALACTUAL, row, false))
                    splits.getstageSplits().setFinalActual(Double.parseDouble(AdCostsData.getField(AdCostsSchemaField.FINALACTUAL, row)));
                addSplits.add(splits);
                payRules.getDefinition().setSplits(addSplits);
                if (AdCostsData.containsField(AdCostsSchemaField.BUDGETREGION, row, false)) {
                    BudgetRegions budget = getBudgetRegionId(AdCostsData.getField(AdCostsSchemaField.BUDGETREGION, row));
                    payRules.getCriteria().getBudgetRegion().setFieldName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.BUDGETREGION));
                    payRules.getCriteria().getBudgetRegion().setOperator("Equal");
                    payRules.getCriteria().getBudgetRegion().setValue(budget.getkey());
                    payRules.getCriteria().getBudgetRegion().setText(budget.getName());
                }
                if (AdCostsData.containsField(AdCostsSchemaField.COSTTYPE, row, false)) {
                    payRules.getCriteria().getCostType().setFieldName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.COSTTYPE));
                    payRules.getCriteria().getCostType().setOperator("Equal");
                    payRules.getCriteria().getCostType().setText(AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row));
                    if(AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row).equals("Usage/Buyout/Contract"))
                        payRules.getCriteria().getCostType().setValue("Buyout");
                    else if (AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row).equals("Trafficking/Distribution"))
                        payRules.getCriteria().getCostType().setValue("Trafficking");
                    else
                        payRules.getCriteria().getCostType().setValue(AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row));
                }
                if (AdCostsData.containsField(AdCostsSchemaField.CONTENTTYPE1, row, false)) {
                    if (AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row).equals("Usage/Buyout/Contract")|| AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row).equals("Trafficking/Distribution")){
                        payRules.getCriteria().getContentType().setFieldName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CONTENTTYPE1));
                        payRules.getCriteria().getContentType().setOperator("Equal");
                        payRules.getCriteria().getContentType().setValue("All");
                        payRules.getCriteria().getContentType().setText("All");
                    }else {
                        DictionaryEntries entries = new DictionaryEntries();
                        entries = getAdcostDictionaryEntryByName("ContentType", (AdCostsData.getField(AdCostsSchemaField.CONTENTTYPE1, row)));
                        payRules.getCriteria().getContentType().setFieldName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CONTENTTYPE1));
                        payRules.getCriteria().getContentType().setOperator("Equal");
                        payRules.getCriteria().getContentType().setValue(entries.getKey());
                        payRules.getCriteria().getContentType().setText(entries.getValue());
                    }
                }

                if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONTYPE1, row, false)) {
                    if (AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row).equals("Usage/Buyout/Contract") || AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row).equals("Trafficking/Distribution")) {
                        payRules.getCriteria().getProductionType().setFieldName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PRODUCTIONTYPE1));
                        payRules.getCriteria().getProductionType().setOperator("Equal");
                        payRules.getCriteria().getProductionType().setValue("All");
                        payRules.getCriteria().getProductionType().setText("All");
                    } else {
                        DictionaryEntries entries = new DictionaryEntries();
                        entries = getAdcostDictionaryEntryByName("ProductionType", (AdCostsData.getField(AdCostsSchemaField.PRODUCTIONTYPE1, row)));
                        payRules.getCriteria().getProductionType().setFieldName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PRODUCTIONTYPE1));
                        payRules.getCriteria().getProductionType().setOperator("Equal");
                        payRules.getCriteria().getProductionType().setValue(entries.getKey());
                        payRules.getCriteria().getProductionType().setText(entries.getValue());
                    }
                }
                if (AdCostsData.containsField(AdCostsSchemaField.TOTALCOSTAMOUNT, row, false)) {
                    String[] totalCost = AdCostsData.getField(AdCostsSchemaField.TOTALCOSTAMOUNT, row).split(";");
                    payRules.getCriteria().getTotalCostAmount().setFieldName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TOTALCOSTAMOUNT));
                    payRules.getCriteria().getTotalCostAmount().setOperator(totalCost[1]);
                    payRules.getCriteria().getTotalCostAmount().setValue(totalCost[0]);
                    payRules.getCriteria().getTotalCostAmount().setText(totalCost[0]);
                }
                if (AdCostsData.containsField(AdCostsSchemaField.RULENAME, row, false)) {
                    payRules.setName(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.RULENAME, row)));
                }
                addPymntRules.add(payRules);
                categoryModels.setPaymentRules(addPymntRules);
                addCategory.add(categoryModels);
                vendors.setVendorCategoryModels(addCategory);
            }
        }
    }

    private boolean checkForDuplicateVendor(String vendorName, String category) {
        Vendors[] vend = getAdcostApi().getVendors(vendorName).getVendors();
        for (Vendors ven : vend) {
            if ((ven.getName().equals((vendorName)))) {
                Vendors vendor = getAdcostApi().getVendorDetails(ven.getId());
                List<VendorCategoryModels> vendorCategoryModelses = vendor.getVendorCategoryModels();
                for (VendorCategoryModels models : vendorCategoryModelses)
                    if (models.getName().equals(category))
                return false;
            }
        } return true;
    }


    private void getIdForExistingVendor(String vendorName, Vendors vendors) {

        Vendors[] vend = getAdcostApi().getVendors(vendorName).getVendors();
        int count = 0;
        for (Vendors ven : vend) {
            if ((ven.getName().equals(vendorName))){
                  count++;
                vendors.setId(ven.getId());
                break;
            }
        }
        if (count == 0) {
            throw new IllegalArgumentException("Vendor detail not found'. : " + (vendorName) + "'");
        }
    }

    @Given("{I |}filled following data on vendor creation page to create new vendor:$fieldsTable")
    @When("{I |}filled following data on vendor creation page to create new vendor:$fieldsTable")
    public void createVendorWithDirectPaymentRulesViaCore(ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            AdCostsVendorPage vendorPage = openAdCostsVendorPage();
            vendorPage.clickNewBtnOnVendorPage("New");
            fillVendorFormViaUI(fieldsTable, vendorPage);
            vendorPage.clickActionOnPaymentRulePage("Save");
            Common.sleep(2000);
            vendorPage.saveVendors();
            Common.sleep(2000);
        }
    }

    @Then("{I |}'$condition' see following data for new created vendor '$vendor':$data")
    public void validateNewVendor(String condition, String vendor, ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        AdCostsVendorPage vendorPage = openAdCostsVendorPage();
        vendorPage.SearchForVendor(wrapVariableWithTestSession(vendor));
        int vendorsCount = vendorPage.getVendorsRowCount();
        for (int i = 1; i <= vendorsCount; i++) {
            for (Map.Entry<String, String> entry : row.entrySet()) {
                assertThat("Check field: " + entry.getKey(),
                        vendorPage.loadVendorDetails(i).contains(entry.getValue()), is(condition.equalsIgnoreCase("should")));
            }
        }
    }

    @Then("{I |} '$condition' see following vendor details for vendor '$vendor':$data")
    public void validateVendorDetails(String condition, String vendor, ExamplesTable data) {
        for (int rows = 0; rows < data.getRowCount(); rows++) {
            Map<String, String> row = parametrizeTabularRow(data, rows);
            AdCostsVendorPage vendorPage = openAdCostsVendorPage();
            AdCostsVendorPage.VendorDetails vendorDetails = vendorPage.getVendorDetailsSection();
            vendorPage.SearchForVendor(wrapVariableWithTestSession(vendor));
            Common.sleep(5000);
            int vendorsCount = vendorPage.getVendorsRowCount();
            for (int i = 1; i <= vendorsCount; i++) {
                    vendorPage.openVendorDetails(i);
                    if (AdCostsData.containsField(AdCostsSchemaField.CATEGORY, row, false))
                        vendorPage.clickEditCategoryOption(AdCostsData.getField(AdCostsSchemaField.CATEGORY, row));
                    vendorDetails.loadVendorDetail();
                    if (AdCostsData.containsField(AdCostsSchemaField.VENDORNAME, row, false))
                        assertThat("Check field SAP vendor Code: ",
                                vendorDetails.getSapVendorCode().equalsIgnoreCase(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.SAPVENDORCODE, row))), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.SAPVENDORCODE, row, false))
                        assertThat("Check field Vendor Name: ",
                                vendorDetails.getVendorName().equalsIgnoreCase(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.VENDORNAME, row))), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.CATEGORY, row, false))
                        assertThat("Check field Catagory: ",
                                vendorDetails.getCategory().contains(AdCostsData.getField(AdCostsSchemaField.CATEGORY, row)), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.DEFAULTCURRENCY, row, false))
                        assertThat("Check field Vendor Currency: ",
                                vendorDetails.getCurrency().contains(AdCostsData.getField(AdCostsSchemaField.DEFAULTCURRENCY, row)), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.BUDGETREGION, row, false))
                        assertThat("Check field Budget Region: ",
                                vendorDetails.getBudgetRegion().equalsIgnoreCase(AdCostsData.getField(AdCostsSchemaField.BUDGETREGION, row)), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.CONTENTTYPE1, row, false))
                        assertThat("Check field Content Type: ",
                                vendorDetails.getContentType().equalsIgnoreCase(AdCostsData.getField(AdCostsSchemaField.CONTENTTYPE1, row)), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONTYPE1, row, false))
                        assertThat("Check field Production Type: ",
                                vendorDetails.getProductionType().equalsIgnoreCase(AdCostsData.getField(AdCostsSchemaField.PRODUCTIONTYPE1, row)), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.TOTALCOSTAMOUNT, row, false))
                        assertThat("Check field Total Cost Amount: ",
                                vendorDetails.getTotalCostamount().equalsIgnoreCase(AdCostsData.getField(AdCostsSchemaField.TOTALCOSTAMOUNT, row)), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.ORIGINALESTIMATE, row, false))
                        assertThat("Check field Original Estimate Split: ",
                                vendorDetails.getpymntSplit().contains(("Original Estimate: ").concat(AdCostsData.getField(AdCostsSchemaField.ORIGINALESTIMATE, row)).concat(" %")), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.FINALACTUAL, row, false))
                         assertThat("Check field Final Actual Split: ",
                                vendorDetails.getpymntSplit().contains(("Final Actual: ").concat(AdCostsData.getField(AdCostsSchemaField.FINALACTUAL, row)).concat(" %")), is(condition.equalsIgnoreCase("should")));
                    if (AdCostsData.containsField(AdCostsSchemaField.FIRSTPRESENTATION, row, false))
                          assertThat("Check field Firest Presentation Split: ",
                                vendorDetails.getpymntSplit().contains(("First Presentation: ").concat(AdCostsData.getField(AdCostsSchemaField.FIRSTPRESENTATION, row)).concat(" %")), is(condition.equalsIgnoreCase("should")));
            }
        }
    }

    private void fillVendorFormViaUI(ExamplesTable fieldsTable, AdCostsVendorPage vendorPage) {

        Map<String, String> row = parametrizeTabularRow(fieldsTable);

        if (AdCostsData.containsField(AdCostsSchemaField.VENDORNAME, row, false))
            vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.VENDORNAME), wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.VENDORNAME, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.SAPVENDORCODE, row, false))
            vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SAPVENDORCODE), wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.SAPVENDORCODE, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.CATEGORY, row, false))
            vendorPage.fillFieldByName(AdCostsData.getField(AdCostsSchemaField.CATEGORY, row), AdCostsData.getField(AdCostsSchemaField.CATEGORY, row));
        if (AdCostsData.containsField(AdCostsSchemaField.DIRECTPAYMENT, row, false)){
            vendorPage.clickEditCategoryOption(AdCostsData.getField(AdCostsSchemaField.CATEGORY, row));
            vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DIRECTPAYMENT), AdCostsData.getField(AdCostsSchemaField.DIRECTPAYMENT, row));
            if (AdCostsData.containsField(AdCostsSchemaField.PREFERREDSUPPLIER, row, false))
                vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PREFERREDSUPPLIER), AdCostsData.getField(AdCostsSchemaField.PREFERREDSUPPLIER, row));
            if ((AdCostsData.getField(AdCostsSchemaField.DIRECTPAYMENT, row).equals("true") && AdCostsData.containsField(AdCostsSchemaField.DEFAULTCURRENCY, row, false)))
                vendorPage.fillDefaultCurrenyField(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DEFAULTCURRENCY), AdCostsData.getField(AdCostsSchemaField.DEFAULTCURRENCY, row));

            //hardcoded Aipe flag and AIPE value as we don't have AIPE functionality anymore
            vendorPage.clickNewBtnOnVendorPage("Add Rule");
            Common.sleep(500);
//            vendorPage.fillFieldByName("IsAIPE", "False");

            if (AdCostsData.containsField(AdCostsSchemaField.RULENAME, row, false))
                vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.RULENAME), wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.RULENAME, row)));
            if (AdCostsData.containsField(AdCostsSchemaField.BUDGETREGION, row, false))
                vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.BUDGETREGION), AdCostsData.getField(AdCostsSchemaField.BUDGETREGION, row));
            if (AdCostsData.containsField(AdCostsSchemaField.COSTTYPE, row, false))
                vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.COSTTYPE), AdCostsData.getField(AdCostsSchemaField.COSTTYPE, row));
            if (AdCostsData.containsField(AdCostsSchemaField.CONTENTTYPE1, row, false))
                vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CONTENTTYPE1), AdCostsData.getField(AdCostsSchemaField.CONTENTTYPE1, row));
            if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONTYPE1, row, false))
                vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PRODUCTIONTYPE1), AdCostsData.getField(AdCostsSchemaField.PRODUCTIONTYPE1, row));
            if (AdCostsData.containsField(AdCostsSchemaField.TOTALCOSTAMOUNT, row, false)) {
                vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TOTALCOSTAMOUNT), AdCostsData.getField(AdCostsSchemaField.TOTALCOSTAMOUNT, row));
                if (AdCostsData.containsField(AdCostsSchemaField.SKIPFIRSTPRESENTATION, row, false)) {
                    vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.SKIPFIRSTPRESENTATION), AdCostsData.getField(AdCostsSchemaField.SKIPFIRSTPRESENTATION, row));
                    if ((AdCostsData.getField(AdCostsSchemaField.SKIPFIRSTPRESENTATION, row).equals("false") && AdCostsData.containsField(AdCostsSchemaField.FIRSTPRESENTATION, row, false)))
                       vendorPage.fillPaymentSplitTable(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.FIRSTPRESENTATION), AdCostsData.getField(AdCostsSchemaField.FIRSTPRESENTATION, row));
                    }
                if (AdCostsData.containsField(AdCostsSchemaField.COSTTOTALTYPE, row, false))
                   vendorPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.COSTTOTALTYPE), AdCostsData.getField(AdCostsSchemaField.COSTTOTALTYPE, row));
                if (AdCostsData.containsField(AdCostsSchemaField.ORIGINALESTIMATE, row, false))
                   vendorPage.fillPaymentSplitTable(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ORIGINALESTIMATE), AdCostsData.getField(AdCostsSchemaField.ORIGINALESTIMATE, row));
                if (AdCostsData.containsField(AdCostsSchemaField.FINALACTUAL, row, false))
                   vendorPage.fillPaymentSplitTable(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.FINALACTUAL), AdCostsData.getField(AdCostsSchemaField.FINALACTUAL, row));
                }
            }
        }


    @Then ("{I |}'$condition' see error message while creating new vendor with duplicate SAP Vendor code using following data:$data")
    public void checkVendorCreationWithDupSAPId(String condition,ExamplesTable fieldsTable) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable);
            AdCostsVendorPage vendorPage = getSut().getPageCreator().getAdCostsVendorPage();
            vendorPage.clickNewBtnOnVendorPage("New");
            fillVendorFormViaUI(fieldsTable, vendorPage);
            vendorPage.saveVendors();
            assertThat("Check duplicate SAP Vendor code message: ",vendorPage.isWarningMessagePresent(),is(condition.equalsIgnoreCase("should")));

    }
}