package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsItemsPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.io.File;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * Created by Raja.Gone on 12/05/2017.
 */
public class AdCostsItemsSteps  extends AdCostsHelperSteps {

    protected AdCostsItemsPage openAdCostsCostsItemsPage() {
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();
        if (costsItemsPage.waitUntilCostsItemsVisible())
            return costsItemsPage;
        else
            throw new Error("Unable to open Cost Items page");
    }

    @Given("{I am |}on costs item page of '$costType'")
    @When("{I |}on costs item page of '$costType'")
    public AdCostsItemsPage costsItemsPage(String costType) {
        return openAdCostsCostsItemsPage();
    }

    @Given("{I |}filled Cost Line Items with following fields for cost title '$costTitle': $data")
    @When("{I |}fill Cost Line Items with following fields for cost title '$costTitle': $data")
    public void fillDetailsOnCostItemsPage(String costTitle, ExamplesTable data) {
        openCostItemPage(costTitle);
        fillCostItemsDetails(data).clickBtnByName("Continue");
        checkForCostitemPageDisappeared();
    }

    @Given("{I |}filled Cost Line Items with following fields: $data")
    @When("{I |}fill Cost Line Items with following fields: $data")
    public void fillDetailsOnCostItemsPage(ExamplesTable data) {
        fillCostItemsDetails(data).clickBtnByName("Continue");
    }

    @Given("{I |}selected cost currency as '$currency' for '$costSection' on cost items page")
    @When("{I |}select cost currency as '$currency' for '$costSection' on cost items page")
    public void selectCurrencyTypeOnCostItemsPage(String currency, String costSection) {
        selectCurrencyType(currency, costSection);
    }

    @Given("{I |}filled Payment details section on cost items page with following details:$data")
    @When("{I |}fill Payment details section on cost items page with following details:$data")
    public void fillPaymentDetailsSection(ExamplesTable data) {
        fillCostItemsDetails(data);
    }

    @Given("{I am} on cost items page of cost title '$costTitle'")
    @When("{I am} on cost items page of cost title '$costTitle'")
    public AdCostsItemsPage openCostItemPage(String costTitle) {
        String url = buildCostPageURL(wrapVariableWithTestSession(costTitle));
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage(url);
        if (costsItemsPage.waitUntilCostsItemsVisible())
            return costsItemsPage;
        else
            throw new Error("Unable to open Cost Items page");
    }

    @Given("{I |}upload following budget form on cost item section for cost title '$costTitle':$data")
    @When("{I |}upload following budget form on cost item section for cost title '$costtitle':$data")
    public void uploadBudgetFormOnCostItemSectionViaAPI(String costTitle,ExamplesTable filesTable){
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costStageRevisionId = getCostRevisionId(costId,costStageId);

        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            uploadDocs(row.get("FileName"), row.get("FormName"), costId,costStageId,costStageRevisionId, false);
        }
    }

    protected String uploadDocs(String fileName, String formName,String costId,String costStageId,String costStageRevisionId, boolean checkBadRequest){
        String filePath = getFilePath(fileName);
        File file = new File(filePath);

        BudgetFormsWrapper budgetFormsWrapper = new BudgetFormsWrapper(costId,costStageId, costStageRevisionId,file,formName);
        return getAdcostApi().uploadBudgetFormInCostLineItem(budgetFormsWrapper, checkBadRequest);
    }

    @Then("{I |}'$conditon' able to upload following budget form on cost item section for cost title '$costtitle':$data")
    public void checkUploadBudgetFormViaAPI(String condition,String costTitle,ExamplesTable filesTable){
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costStageRevisionId = getCostRevisionId(costId,costStageId);

        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            String response = uploadDocs(row.get("FileName"), row.get("FormName"), costId,costStageId,costStageRevisionId, true);
            assertThat("Check upload API response that user not able to upload incorrect form: "+response , response.equalsIgnoreCase("Status code: 400 , Reason: Bad Request"), equalTo(condition.equalsIgnoreCase("should not")));
        }
    }

    @Given("{I |}{added|edited} cost item details for cost title '$costTitle' with '$currencyFormat' currency:$data")
    @When("{I |}{add|edit} cost item details for cost title '$costTitle' with '$currencyFormat' currency:$data")
    public void addCostItemsViaCore(String costTitle, String currencyFormat, ExamplesTable fieldsTable) {
        Items items= null;
        CostLineItemData lineItemData;
        List<CostLineItemData> costLineData = new ArrayList<>();
        CostLineItems lineItems = new CostLineItems();

        CostTemplates[] templates = getAdcostApi().getCostTemplates();
        String currencyId = getCurrencyId(currencyFormat);
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        boolean isPaymentDetails = false;
        ArrayList<String> requestedCostItems = new ArrayList<String>();

        for (int i = 0; i < (fieldsTable.getHeaders().size()); i++) {
            String headerName = fieldsTable.getHeaders().get(i);
            if (headerName.equals(AdCostsSchemaField.IONUMBER.toString())) {
                isPaymentDetails = true;
                continue;
            }
            /*if (headerName.equals(AdCostsSchemaField.FINALASSETAPPROVALDATE.toString())) {
                isPaymentDetails = true;
                continue;
            }*/
            if (costs.getCostType().equals("Production"))
                items = getTemplateSectionDetails(templates, costs, headerName);
            else if (costs.getCostType().equals("Buyout") || costs.getCostType().equals("Trafficking") )
                items = getTemplateSectionDetailsForUsageBuyout(templates, costs, headerName);
            else
                throw new IllegalArgumentException("Check Cost Type. Found unknown costType: " + costs.getCostType());

            lineItemData = new CostLineItemData();
            lineItemData.setName(items.getName());
            for (int j = 0; j < fieldsTable.getRowCount(); j++) {
                Map<String, String> row = parametrizeTabularRow(fieldsTable, j);
                if (row.containsKey(headerName))
                    requestedCostItems.add(items.getName());
                    lineItemData.setValue(Integer.parseInt(row.get(headerName)));
            }
            lineItemData.setLocalCurrencyId(currencyId);
            lineItemData.setTemplateSectionId(items.getId());
            costLineData.add(lineItemData);
        }

        String costId = costs.getId();
        String costStageId = getCostStageId(costId);
        lineItems.setCostId(costId);
        lineItems.setCostStageId(getCostStageId(costId));
        String objectId = getCostRevisionId(costId, costStageId);
        lineItems.setRevisionId(objectId);
        CostLineItemDataResponse[] listCostLineItems = getAdcostApi().getCostLineItemDetails(costId,costStageId,objectId);
        checkForExistingCostItem(listCostLineItems, requestedCostItems,costLineData );
        lineItems.setCostLineItemData(costLineData);

        getAdcostApi().createCostLineItemData(lineItems);
        if(isPaymentDetails)
            submitCostItemDetails(objectId, fieldsTable);
    }

    private List<CostLineItemData> checkForExistingCostItem(CostLineItemDataResponse[] listCostLineItems, List<String> itemlist, List<CostLineItemData> costLineData){
        for (CostLineItemDataResponse item : listCostLineItems) {
            if (itemlist.contains(item.getName()))
                continue;
            CostLineItemData lineItemData = new CostLineItemData();
            lineItemData.setName(item.getName());
            lineItemData.setValue(item.getValueInDefaultCurrency());
            lineItemData.setLocalCurrencyId(item.getLocalCurrencyId());
            lineItemData.setValueInLocalCurrency(item.getValueInLocalCurrency());
            lineItemData.setTemplateSectionId(item.getTemplateSectionId());
            costLineData.add(lineItemData);
        }
        return costLineData;
    }

    @Given("{I |}{completed|submitted} cost item details for cost title '$costTitle':$data")
    @When("{I |}{complet|submit} cost item details for cost title '$costTitle':$data")
    public void submitCostItemDetails(String objectId, ExamplesTable fieldsTable) {
        Data data = new Data();
        String name = "PaymentDetails";
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        CustomData customData = getAdcostApi().getIoNumber(objectId,name);
        if ((customData!=null)) {
            if (customData.getData().contains("ioNumber")) {
                String[] testvar = customData.getData().split("\"ioNumber\": \"");
                String iONumber = testvar[1].substring(0, 10);
                if (iONumber.matches("[0-9]+") && iONumber.length() == 10)
                    data.setIoNumber(iONumber);
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.IONUMBER, row, false)) {
            String ioNumber = AdCostsData.getField(AdCostsSchemaField.IONUMBER, row);
            checkIOnumberLength(ioNumber);
            data.setIoNumber(ioNumber);}
        /*if (AdCostsData.containsField(AdCostsSchemaField.FINALASSETAPPROVALDATE, row, false)) {
            DateTime finalAssetApprovalDate = parseDateWithUTCZone(AdCostsData.getField(AdCostsSchemaField.FINALASSETAPPROVALDATE, row));
            data.setFinalAssetApprovalDate(finalAssetApprovalDate);
        }*/
        getAdcostApi().createIoNumber(objectId, name, data);
    }

    @Then("{I |}'$should' see following details in '$subTotalSectionName' section on cost items page: $data")
    public void checkDetailsInSubTotalSection(String condition, String subTotalSectionName, ExamplesTable data) {
        AdCostsItemsPage.SubTotalCurrencyDetails subTotalDetails = openAdCostsCostsItemsPage().getSubTotalDetails();
        subTotalDetails.loadSubTotalCurrencyDetails(subTotalSectionName);

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Original Estimate"))
                assertThat("Check '" + row.containsKey("Original Estimate") + "' value on Cost Items page: ",
                        subTotalDetails.getOriginalEstimate().equals(row.get("Original Estimate")), is(condition.equalsIgnoreCase("should")));
            if (row.containsKey("Original Estimate local"))
                assertThat("Check '" + row.containsKey("Original Estimate local") + "' value on Cost Items page: ",
                        subTotalDetails.getOriginalEstimateLocal().equals(row.get("Original Estimate local")), is(condition.equalsIgnoreCase("should")));
        }
    }

    @Then("{I |}'$should' see project grand total as '$totalCurrency' on cost items page")
    public void checkProjectGrandTotal(String condition, String totalCurrency) {
        AdCostsItemsPage.SubTotalCurrencyDetails subTotalDetails = openAdCostsCostsItemsPage().getSubTotalDetails();
        assertThat("Check 'Project Grand Total' value on Cost Items page: ",
                subTotalDetails.getProjectGrandTotal().equals(totalCurrency), is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$should' see below financial year balance in BillingExpensingTermsPerFinancialYear table for cost title '$costTitle': $data")
    public void checkBillingExpensingTermsPerFinancialYearTable(String condition,String costTitle, ExamplesTable data){
       AdCostsItemsPage costsItemsPage = openCostItemPage(costTitle);

        // Validate cellValues
        int columnCounter = 0;
        for(String s: data.getHeaders()){
            columnCounter++;
            for (int i = 0; i < data.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(data, i);
                String expected = row.get(s.toString());
                String actual = costsItemsPage.getBillingTableDetails().getCellValue(i+2,columnCounter);
                assertThat("Check 'Billing/Expensing terms per financial year' Tabel: ",
                        actual,condition.equals("should")?is(expected):not(is(expected)));
            }
        }

        // Validate headers
        columnCounter = 0;
        for(String s: data.getHeaders()){
            columnCounter++;
            String expectedHeader = s;
            String actualHeader = costsItemsPage.getBillingTableDetails().getCellValue(1,columnCounter);
            assertThat("Check Fiscal year headers in 'Billing/Expensing terms per financial year' Tabel: ",
                    actualHeader,condition.equals("should")?is(expectedHeader):not(is(expectedHeader)));
        }
    }

    @When("{I |}update numberOfMonthsInContractTermPerFY in BillingExpensingTermsPerFinancialYear table for cost title '$costTitle':$data")
    public void updateNumberOfMonthsInContractTermPerFY(String costTitle, ExamplesTable data){
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();

        for (int i = 0; i < data.getRowCount(); i++) {
            int columnCounter = 0;
            Map<String, String> row = parametrizeTabularRow(data, i);
            Set<String> set = row.keySet();
            Iterator<String> iterator = set.iterator();
            while (iterator.hasNext()) {
                String headerName = iterator.next();
                if(!headerName.equals("Item description")){
                    columnCounter++;
                    costsItemsPage.getBillingTableDetails().updateContractMonthCellValue(row.get(headerName),columnCounter);
                }
            }
        }
    }

    @Then("{I |}'$should' see below numberOfMonthsInContractTermPerFY in BillingExpensingTermsPerFinancialYear table for cost title '$costTitle':$data")
    public void checkNumberOfMonthsInContractTermPerFY(String condition,String costTitle, ExamplesTable data) {
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();
        int columnCounter = 0;
        for(String s: data.getHeaders()){
            columnCounter++;
            for (int i = 0; i < data.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(data, i);
                String expected = row.get(s.toString());
                String actual = null;
                if(s.equals("Total") || s.equals("Item description"))
                    actual = costsItemsPage.getBillingTableDetails().getCellValue(i+3,columnCounter);
                else
                    actual = costsItemsPage.getBillingTableDetails().getContractMonthCellValue(i+3,columnCounter);

                assertThat("Check 'No. of months in contract term per FY' Tabel: ",
                        actual,condition.equals("should")?is(expected):not(is(expected)));
            }
        }
    }

    // Not Editable || Editable
    @Then("{I |}'$should' see below fields in numberOfMonthsInContractTermPerFY in BillingExpensingTermsPerFinancialYear table:$data")
    public void checkFieldsStateInNumberOfMonthsInContractTermPerFY(String condition,ExamplesTable data) {
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            int columnCounter = 1;
            Map<String, String> row = parametrizeTabularRow(data, i);
            Set<String> set = row.keySet();
            Iterator<String> iterator = set.iterator();
            while (iterator.hasNext()) {
                columnCounter++;
                String headerName = iterator.next();
                String expected = row.get(headerName);
                String actual = costsItemsPage.getBillingTableDetails().isFieldEditable(columnCounter);
                assertThat(actual, condition.equals("should") ? is(expected) : not(is(expected)));
            }
        }
    }

    @When("{I |}update billing table with below data for cost title '$costTitle':$data")
    public void fillBillingTable(String costTitle,ExamplesTable data) {
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();

        int numberOfColumnHeaders = costsItemsPage.getBillingTableDetails().getColumnHeaderCount();

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            Set<String> set = row.keySet();
            Iterator<String> iterator = set.iterator();
            int columnCounter = 1;
            int rowNumber = 0;
            while (iterator.hasNext()) {
                String headerName = iterator.next();
                if (!headerName.equals("Item description")) {
                    columnCounter++;
                    String actualHeaderName = costsItemsPage.getBillingTableDetails().getColumnHeaderName(columnCounter);
                    if(!(row.get(headerName).isEmpty() || row.get(headerName).equals(null)) && headerName.equalsIgnoreCase(actualHeaderName)) {
                        costsItemsPage.getBillingTableDetails().updateBillingTable(row.get("Item description"), row.get(headerName), columnCounter);
                        Common.sleep(3000); // sown down before next update
                        costsItemsPage.getBillingTableDetails().isTotalUpdated(row.get("Item description"), row.get(headerName), columnCounter);
                    }
                }
            }
        }
    }

    @Then("{I |}'$should' see billing table updated as below for cost title '$costTitle':$data")
    public void checkDataInBillingTable(String condition, String costTitle,ExamplesTable data) {
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();
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
                    actualRowData = costsItemsPage.getBillingTableDetails().getDataInRow(row.get(headerName));
                } else
                    expectedRowData.add(row.get(headerName));
            }

            assertThat(actualRowData, condition.equals("should") ? is(expectedRowData) : not(is(expectedRowData)));
        }
    }

    // '$local' = local | default
    @Then("{I |}'$should' following data for '$local' currency in Cost items section for cost title '$costTitle: $data")
    public void checkLocalDataInCostItemsSection(String condition, String local, String costTitle, ExamplesTable data){
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            Set<String> set = row.keySet();
            Iterator<String> iterator = set.iterator();
            List<String> actualRowData = new ArrayList<>();
            List<String> expectedRowData = new ArrayList<>();
            while (iterator.hasNext()) {
                String headerName = iterator.next();
                if (headerName.equals("Item description")) {
                    if (local.equalsIgnoreCase("local"))
                        actualRowData = costsItemsPage.getLocalDataInRow(row.get(headerName));
                    else if(local.equalsIgnoreCase("default")) {
                        expectedRowData.add(row.get(headerName));
                        actualRowData = costsItemsPage.getDefaultDataInRow(row.get(headerName));
                    }
                    else throw new IllegalArgumentException("Unknown currency type: "+local+". Should be 'local' or 'default");
                } else
                    expectedRowData.add(row.get(headerName));
            }

            assertThat(actualRowData, condition.equals("should") ? is(expectedRowData) : not(is(expectedRowData)));
        }
    }

    // Disabled | Enabled
    @Then("{I |}'$should' see following fields in Cost items section for cost title '$costTitle:$data")
    public void checkFieldStatus(String condition, String costTitle, ExamplesTable data){
        AdCostsItemsPage costItemsDetails = openAdCostsCostsItemsPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            String expectedState= row.get("State");
            String actualState = costItemsDetails.getFieldStatus(row.get("FieldName"));
            assertThat(actualState,condition.equals("should")?is(expectedState):not(is(expectedState)));
        }
    }


    @Then("{I |}'$should' see billing table on cost items page")
    public void checkIfBillingTableVisible(String condition){
        AdCostsItemsPage costItemsDetails = openAdCostsCostsItemsPage();
        assertThat(costItemsDetails.getBillingTableDetails().isBillingTableVisisble(),
                condition.equals("should") ? is(true) : is(false));
    }

    private AdCostsItemsPage fillCostItemsDetails(ExamplesTable data) {
        AdCostsItemsPage costItemsDetails = openAdCostsCostsItemsPage();
        costItemsDetails.waitUntilCostsLineItemsLoaded();
        Map<String, String> row = parametrizeTabularRow(data);

        if (AdCostsData.containsField(AdCostsSchemaField.IONUMBER, row, false)) {
            String ioNumber = AdCostsData.getField(AdCostsSchemaField.IONUMBER, row);
            checkIOnumberLength(ioNumber);
            costItemsDetails.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.IONUMBER), ioNumber);
            AdCostsData.removeExtraField(AdCostsSchemaField.IONUMBER, row);
        }

        /*if (AdCostsData.containsField(AdCostsSchemaField.FINALASSETAPPROVALDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.FINALASSETAPPROVALDATE, row);
            if (checkDateFormatINddMMyyyy(date)) {
                costItemsDetails.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.FINALASSETAPPROVALDATE), date);
                AdCostsData.removeExtraField(AdCostsSchemaField.FINALASSETAPPROVALDATE, row);
            }
        }*/
        // ToDo: For PO#; Shopping Cart #; GR#

        Iterator iterator = row.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry rowEntry = (Map.Entry)iterator.next();
            Common.sleep(200);
            if ((costItemsDetails.getBillingTableDetails().isBillingTableVisisble())& (costItemsDetails.getFieldStatus(rowEntry.getKey().toString()).equals("Disabled"))){
               costItemsDetails.getBillingTableDetails().updateBillingTable(rowEntry.getKey().toString(),rowEntry.getValue().toString(),2);
               Common.sleep(3000);
               costItemsDetails.getBillingTableDetails().isTotalUpdated(rowEntry.getKey().toString(),rowEntry.getValue().toString(),2);
            }else {
                costItemsDetails.fillFieldByName(rowEntry.getKey().toString(), rowEntry.getValue().toString()); }
            Common.sleep(1000);
        }

        return costItemsDetails;
    }

    private void selectCurrencyType(String currency, String costSection) {
        openAdCostsCostsItemsPage().fillCurrency(currency, costSection);
    }

    private String getCurrencyId(String currencyFormat) {
        AdcostCurrency[] currency = getAdcostApi().getAdcostCurrnecy();
        for (AdcostCurrency curr : currency) {
            if (curr.getCode().equals(currencyFormat)) {
                return curr.getId();
            }
        }
        throw new IllegalArgumentException("Check Currency Format, found unknown format: " + currencyFormat);
    }

    private Items getTemplateSectionDetails(CostTemplates[] templates, Costs costs, String costLineItemName) {
        for (CostTemplates temp : templates)
            if (temp.getCostType().equals(costs.getCostType()))
                for (Versions versions : temp.getVersions())
                    for (ProductionDetails productionDetails : versions.getProductionDetails())
                        if (productionDetails.getType().equals(costs.getContentType().toLowerCase()))
                            for (Forms forms : productionDetails.getForms())
                                if (forms.getLabel().contains(costs.getProductionType()))
                                    for (CostLineItemSections sections : forms.getCostLineItemSections())
                                        for (Items items : sections.getItems())
                                            if (items.getLabel().equals(costLineItemName)) {
                                                items.setId(sections.getId());
                                                return items;
                                            }
        throw new IllegalArgumentException("Check Cost Line Item Name. Found unknown name: " + costLineItemName);
    }

    private Items getTemplateSectionDetailsForUsageBuyout(CostTemplates[] templates, Costs costs, String costLineItemName) {
        for (CostTemplates temp : templates)
            if (temp.getCostType().equals(costs.getCostType()))
                for (Versions versions : temp.getVersions())
                    for (ProductionDetails productionDetails : versions.getProductionDetails())
                        for (Forms forms : productionDetails.getForms())
                            for (CostLineItemSections sections : forms.getCostLineItemSections())
                               for (Items items : sections.getItems())
                                  if (items.getLabel().equals(costLineItemName)) {
                                    items.setId(sections.getId());
                                    return items;
                                  }
        throw new IllegalArgumentException("Check Cost Line Item Name. Found unknown name: " + costLineItemName);
    }

    private CostLineItems buildCostLineItemDetails(String costId,String costStageId,String revisionId) {
        List<CostLineItemData> costLineData = new ArrayList<>();
        CostLineItems lineItems = new CostLineItems();
        CostLineItemData lineItemData = null;
        CostLineItemDataResponse[] items = getAdcostApi().getCostLineItemDetails(costId,costStageId,revisionId);
        for (CostLineItemDataResponse itemData : items) {
            lineItemData = new CostLineItemData();
            lineItemData.setName(itemData.getName());
            lineItemData.setTemplateSectionId(itemData.getTemplateSectionId());
            lineItemData.setValue(itemData.getValueInLocalCurrency());
            lineItemData.setLocalCurrencyId(itemData.getLocalCurrencyId());
            costLineData.add(lineItemData);
        }
        lineItems.setCostLineItemData(costLineData);
        return lineItems;
    }

    private void checkIOnumberLength(String ioNumber){
        if(ioNumber.length()!=10)
            throw new IllegalArgumentException("Check IO# length. Expected 10 char's but found "+ioNumber.length()+" :"+ioNumber);
    }

    public void fillPolicyexceptionSection(AdCostsItemsPage costsItemsPage, ExamplesTable data){
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            costsItemsPage.clickBtnByName("Add Exception");
            costsItemsPage.waitUntilAddPolicyExceptionSectionAppears();
            fillPolicyExceptionFieldsViaUI(row, costsItemsPage);
            costsItemsPage.clickBtnByName("Save");
            costsItemsPage.waitUntilCostsItemsVisible();
        }
    }

    @Given("{I |}filled the policy exception on cost item page for cost title '$costTitle' and click continue:$data")
    @When("{I |}fill the policy exception on cost item page for cost title '$costTitle' and click continue:$data")
    public void fillPolicyexceptionSectionAndContinue(String costTitle, ExamplesTable data){
        AdCostsItemsPage costsItemsPage =  openCostItemPage(costTitle);
        fillPolicyexceptionSection(costsItemsPage, data);
        clickButtonName("Continue");
    }

    @Given("{I |}filled the policy exception on cost item page:$data")
    @When("{I |}fill the policy exception on cost item page:$data")
    public void fillPolicyexceptionAndContinue(ExamplesTable data){
        AdCostsItemsPage costsItemsPage = getSut().getPageCreator().getAdCostsItemsPage();
        fillPolicyexceptionSection(costsItemsPage, data);
    }

    private void fillPolicyExceptionFieldsViaUI(Map<String, String> row, AdCostsItemsPage costsItemsPage) {
        if (row.get("Exception type") != null && !row.get("Exception type").isEmpty()) {
            costsItemsPage.fillFieldByName("Exception type", row.get("Exception type"));
        }
        if (row.get("Reason") != null && !row.get("Reason").isEmpty()) {
            costsItemsPage.fillFieldByName("Reason", row.get("Reason"));
        }
        if (row.get("Cost implication") != null && !row.get("Cost implication").isEmpty()) {
            costsItemsPage.fillFieldByName("Cost implication", row.get("Cost implication"));
        }
    }

    @Then("{I |}'$condition' see following data in Policy Exception section on Cost item page:$data")
    public void validateFieldsInPolicyexceptionSection(String condition, ExamplesTable data) {
        AdCostsItemsPage costsItemsPage = getSut().getPageCreator().getAdCostsItemsPage();
        AdCostsItemsPage.PolicyExceptionSection policyExceptionSection = costsItemsPage.getPolicyexceptionSection();
        List<String> expectedValues= new ArrayList<>();
        List<String> actualValues= new ArrayList<>();
        actualValues = policyExceptionSection.loadPolicyexceptionTable();
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
        assertThat("Check details in 'Policy Exception' section on Cost Item page: ",actualValues.containsAll(expectedValues));
    }

    @Then("{I |}'$condition' see following Cost Line Items populated on cost item page:$data")
    public void checkDetailsOnCostItemsPage(String condition,ExamplesTable data) {
        AdCostsItemsPage costItemsDetails = openAdCostsCostsItemsPage();
        Map<String, String> row = parametrizeTabularRow(data);
        Iterator iterator = row.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry rowEntry = (Map.Entry)iterator.next();
            assertThat("Check following " +rowEntry.getKey().toString()+" costitem field:",
                    costItemsDetails.checkCostDetailFieldByName(rowEntry.getKey().toString().trim()),
                    condition.equalsIgnoreCase("should")?is(rowEntry.getValue().toString()):not(is(rowEntry.getValue().toString())));
        }
    }

    @Then("{I }'$should' see following Cost Line Items: $data")
    public void checkCostLineItems(String should,ExamplesTable data){
        AdCostsItemsPage costItemsDetails = getSut().getPageNavigator().getAdCostsItemsPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.containsKey("Section Name")) {
                List<String> expectedLineItems = new ArrayList<>();
                for(String expected: row.get("Cost Line Items").split(";"))
                            expectedLineItems.add(expected);
                List<String> actualLineItems = costItemsDetails.getCostsItemsBySection(row.get("Section Name"));
                assertThat(actualLineItems,should.equalsIgnoreCase("should")?is(expectedLineItems):not(is(expectedLineItems)));
            }
        }
    }

    @Then ("{I |}'$condition' see sections currency as '$currency' on cost item page for cost title '$costTitle'")
    public void checkSectionsCurrency(String condition, String currency, String costTitle){
        AdCostsItemsPage costsItemsPage = openCostItemPage(costTitle);
        assertThat("Check Sections currency on Cost Item Page: ", costsItemsPage.checkCurrencyOnCostItePage(currency), is(condition.equalsIgnoreCase("should")));
    }

    @Then ("{I |}'$condition' able to edit the currency field on cost item page for different sections for costTitle '$costTitle'")
    public void checkCurrencyFieldEditableOrNot(String condition, String costTitle){
        AdCostsItemsPage costsItemsPage = openCostItemPage(costTitle);
        Common.sleep(1000);
        assertThat("Check currency field is editable: ", costsItemsPage.verifyCurrencyFieldIsEditable(), is(condition.equalsIgnoreCase("should")));
    }

    @When ("{I |} change the all sections currency to '$currency' on cost item page for cost title '$costTitle'")
    public void editCostSectionsCurrency(String currency, String costTitle){
        AdCostsItemsPage costsItemsPage = openCostItemPage(costTitle);
        costsItemsPage.editCurrencyOnCostSections(currency);
    }

    @Then ("{I |}'$condition' see following currency symbols for grand total on cost Item page:$data")
    public void checkGrandTotalCurrencies(String condition, ExamplesTable data) {
        AdCostsItemsPage costsItemsPage = openAdCostsCostsItemsPage();
        Common.sleep(2000);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data,i);
            assertThat("Check grand Total currency symbol for " + row.get("CurrencyGroup") + " Currency is "+row.get("Currency Symbol"), costsItemsPage.checkGrandTotalCurrency(row.get("CurrencyGroup"), row.get("Currency Symbol")), is(condition.equalsIgnoreCase("should")));
        }
    }

    @Given("{I |}filled direct vendor details on Cost Item Page for '$costType' cost:$data")
    @When("{I |}fill direct vendor details on Cost Item Page for '$costType' cost:$data")
    public void fillUsageBuyoutVendorDetailOnCostItemPage(String costType, ExamplesTable data){
        AdCostsItemsPage itemPage = getSut().getPageCreator().getAdCostsItemsPage();
        Map<String, String> row = parametrizeTabularRow(data);
        Vendors vendors = null;
        if ((AdCostsData.containsField(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR, row, false))) {
            vendors = null;
            String[] fieldValues = AdCostsData.getField(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR, row).split(";");
            vendors = loadVendorListPerNonProductionost(costType, fieldValues[0].trim());
            fillCategoryFields(itemPage, AdCostsData.getPrimaryFieldName(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR), fieldValues, vendors.getName(), costType);
        }
    }

    private void fillCategoryFields(AdCostsItemsPage itemPage,String categoryName,String[] fieldValues, String fieldValue,String category){
        itemPage.fillFieldByName(categoryName, fieldValue);
        Common.sleep(300);
        if(fieldValues.length>1 && !fieldValues[1].isEmpty()) {
           itemPage.selectCurrencyForActivateDirectBilling(category, fieldValues[1].trim());
           Common.sleep(500);
        }
    }

    @Then("{I |}'$condition' see following vendor dropdown on cost item page:$data")
    public void checkVendorDropdownExistsOnCostItemPage(String condition, ExamplesTable data){
        AdCostsItemsPage costItemPage = getSut().getPageCreator().getAdCostsItemsPage();
        Map<String,String> row = parametrizeTabularRow(data);
        costItemPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR), wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR, row)));
        assertThat("Check Vendor "+ wrapVariableWithTestSession(row.get("Vendor to which payment will go"))+ " visible under dropdown: ",
                costItemPage.checkVendorDropdownExists(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR),wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR, row))),is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' see following radio button when selects a vendor from Dropdown on cost item page:$data")
    public void checkRadioButtonsOnCostItemPage(String condition, ExamplesTable data){
        AdCostsItemsPage costItemPage = getSut().getPageCreator().getAdCostsItemsPage();
        Map<String,String> row = parametrizeTabularRow(data);
        if (row.containsKey("Activate Direct Billing")){
            assertThat("Check Activate Direct Billing button when selects vendor on cost item page: ",
                costItemPage.checkRadioButtonsOnCostItemPage("Activate Direct Billing",row.get("Activate Direct Billing")),is(condition.equalsIgnoreCase("should")));
        }

        if (row.containsKey("Do Not Activate Direct Billing")){
            assertThat("Check Do Not Activate Direct Billing button when selects vendor on cost item page: ",
                    costItemPage.checkRadioButtonsOnCostItemPage("Do Not Activate Direct Billing",row.get("Do Not Activate Direct Billing")),is(condition.equalsIgnoreCase("should")));
        }
    }


    @Then("{I |}'$condition' see successful message for vendor '$vendorName' setup on cost item page")
    public void checkVendorSetupMessage(String condition, String vendorName){
        AdCostsItemsPage costItemPage = getSut().getPageCreator().getAdCostsItemsPage();
        String expectedMessage = String.format(wrapVariableWithTestSession(vendorName).concat(" is set up for direct billing"));
        assertThat("Check successful vendor setup message on cost item page",costItemPage.checkSuccessfulMessage(),condition.equals("should") ? is(expectedMessage) :not(is(expectedMessage)));
    }

    @When ("{I |}edit vendor currency with following fields for cost title '$costTitle' on cost item page:$data")
    public void editVendorPmntCurrency(String costTitle, ExamplesTable data){
        AdCostsItemsPage costItemPage = openCostItemPage(costTitle);
        Map<String,String> row = parametrizeTabularRow(data);
        if((row.containsKey("Usage Buyout Contract Payment Currency")))
            costItemPage.selectCurrencyForActivateDirectBilling("UsageBuyoutContract", row.get("Usage Buyout Contract Payment Currency"));

        if((row.containsKey("Distribution & Trafficking Payment Currency")))
            costItemPage.selectCurrencyForActivateDirectBilling("DistributionTrafficking", row.get("Distribution & Trafficking Payment Currency"));
    }

    @Then ("{I |}'$condition' see sections currency as '$currency' on cost item page")
    public void checkCurrencyOfSections(String condition, String currency){
        Common.sleep(2000);
        AdCostsItemsPage costsItemsPage = getSut().getPageCreator().getAdCostsItemsPage();
        assertThat("Check Sections currency on Cost Item Page: ", costsItemsPage.checkCurrencyOnCostItePage(currency), is(condition.equalsIgnoreCase("should")));
    }

    @Then ("{I |}'$condition' able to edit the currency field for catagory '$category' on cost item page for costTitle '$costTitle'")
    public void checkCurrencyFieldEditableOrNot(String condition, String category, String costTitle){
        AdCostsItemsPage costItemPage = openCostItemPage(costTitle);
        assertThat("Check currency field is editable: ", costItemPage.verifyCurrencyFieldIsEditable(category), is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' be able to add vendor '$vendorName' on the fly")
    public void checkIfAddVendorOnTheFly(String condition, String vendorName){
        AdCostsItemsPage costsItemsPage = getSut().getPageCreator().getAdCostsItemsPage();
        costsItemsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR), wrapVariableWithTestSession(vendorName));
        assertThat("Check on the fly Vendor addition: ",
                costsItemsPage.checkVendorCanBeAddedOnFly(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.USAGEBUYOUTTRAFFICVENDOR),wrapVariableWithTestSession(vendorName)),is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' see Usage Vendor Section on cost item page")
    public void checkUsagevendorSectionPresent(String condition){
        AdCostsItemsPage costsItemsPage = getSut().getPageCreator().getAdCostsItemsPage();
        assertThat("Check Usage Vendor Section Present: ",
                costsItemsPage.checkUsageVendorSectionExists(),is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$should' see toast message as '$message' on budget page")
    public void checkToastMessage(String condition, String message){
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();
        String actualMessage = costsItemsPage.getToastMessage();
        assertThat("Check 'Grand Total' toast message: ",
                actualMessage,condition.equalsIgnoreCase("should")?is(message):not(is(message)));
    }

    @Then("{I |}'$should' see toast message '$message' visible on budget page")
    public void isToastMessageVisible(String condition, String message){
        AdCostsItemsPage costsItemsPage = getSut().getPageNavigator().getAdCostsItemsPage();
        boolean expected = condition.equalsIgnoreCase("should")?true:false;
        boolean actualMessage = costsItemsPage.isToastMessageVisible(message);
        assertThat("Check 'Grand Total' toast message: ",actualMessage,is(expected));
    }

    @Then ("{I |}'$condition' able to edit the vendor field '$fieldName' on cost item page for costTitle '$costTitle'")
    public void checkVendorFieldEditableOrNot(String condition, String fieldName, String costTitle){
        AdCostsItemsPage costItemPage = getSut().getPageCreator().getAdCostsItemsPage();
        assertThat("Check Vendor field is editable: ", costItemPage.verifyVendorFieldIsEditable(fieldName), is(condition.equalsIgnoreCase("should")));
    }

    private void checkForCostitemPageDisappeared(){
        AdCostsItemsPage itemsPage = new AdCostsItemsPage(getSut().getWebDriver());
        itemsPage.waitUntilCostItemPageDisappears();
    }
}