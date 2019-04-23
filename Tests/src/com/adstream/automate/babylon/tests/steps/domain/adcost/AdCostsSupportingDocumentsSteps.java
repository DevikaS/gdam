package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.SupportingDocsWrapper;
import com.adstream.automate.babylon.JsonObjects.adcost.SupportingDocuments;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsSupportingDocumentsPage;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import com.google.gson.*;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.io.File;
import java.util.Map;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.MatcherAssert.assertThat;


/**
 * Created by Raja.Gone on 15/05/2017.
 */
public class AdCostsSupportingDocumentsSteps extends AdCostsHelperSteps {

    protected AdCostsSupportingDocumentsPage openAdCostsSupportingDocumentsPage() {
        AdCostsSupportingDocumentsPage supportingDocumentsPage = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage();
        if (supportingDocumentsPage.waitUntilSupportingDocumentsPageVisible())
            return new AdCostsSupportingDocumentsPage(getSut().getWebDriver());
        else
            throw new Error("Unable to open Supporting-Documents page");
    }

    protected void uploadDocs(String fileName, String formName,String costId,String costStageId,String costStageRevisionId){
        String filePath = getFilePath(fileName);
        File file = new File(filePath);

        SupportingDocuments[] docsCount = getAdcostApi().getSupportingDocuments(costId,costStageId,costStageRevisionId);
        String supportingDocumentId = null;
        for(SupportingDocuments docs:docsCount) {
            if (docs.getName().equalsIgnoreCase(formName)) {
                supportingDocumentId = docs.getId();
                break;
            }
        }
        SupportingDocsWrapper supportingDocsWrapper = new SupportingDocsWrapper(costId,costStageId,costStageRevisionId,supportingDocumentId,file,formName);
        getAdcostApi().uploadSupportingDocumentsInAdCost(supportingDocsWrapper);
    }

    protected void uploadDocs_new(String fileName, String formName,String costId,String costStageId,String costStageRevisionId){
        try {
        String filePath = getFilePath(fileName);
        File file = new File(filePath);

        SupportingDocuments[] docsCount = getAdcostApi().getSupportingDocuments(costId,costStageId,costStageRevisionId);
        String supportingDocumentId = null;
        for(SupportingDocuments docs:docsCount) {
            if (docs.getName().equalsIgnoreCase(formName)) {
                supportingDocumentId = docs.getId();
                break;
            }
        }
        SupportingDocsWrapper supportingDocsWrapper = new SupportingDocsWrapper(costId,costStageId,costStageRevisionId,supportingDocumentId,file,formName);
        HttpResponse response = getAdcostApi().uploadSupportingDocumentsInAdCostRegisterUpload(supportingDocsWrapper);
        getAdcostApi().uploadAdcostSupportingDocsCompleteUpload(supportingDocsWrapper,EntityUtils.toString(response.getEntity()));
        } catch (Exception e){
        throw new Error(e.getCause());
        }
    }

    protected void uploadAdditionalSupportingDocuments(String fileName, String formName,String costId,String costStageId,String costStageRevisionId){
        try {
            String filePath = getFilePath(fileName);
            File file = new File(filePath);
            SupportingDocsWrapper supportingDocsWrapper = new SupportingDocsWrapper(costId, costStageId, costStageRevisionId, "", file, formName);
            HttpResponse response = getAdcostApi().uploadSupportingDocumentsInAdCostRegisterUpload(supportingDocsWrapper);
            getAdcostApi().uploadAdditionalSupportingDocumentsInAdCostCompleteUpload(supportingDocsWrapper, EntityUtils.toString(response.getEntity()));
        } catch (Exception e){
            throw new Error(e.getCause());
        }
    }

    protected HttpResponse checkUploadDocsFileSize(String fileName, String formName,String costId,String costStageId,String costStageRevisionId){
            String filePath = getFilePath(fileName);
            File file = new File(filePath);

            SupportingDocuments[] docsCount = getAdcostApi().getSupportingDocuments(costId,costStageId,costStageRevisionId);
            String supportingDocumentId = null;
            for(SupportingDocuments docs:docsCount) {
                if (docs.getName().equalsIgnoreCase(formName)) {
                    supportingDocumentId = docs.getId();
                    break;
                }
            }
            SupportingDocsWrapper supportingDocsWrapper = new SupportingDocsWrapper(costId,costStageId,costStageRevisionId,supportingDocumentId,file,formName);
            return getAdcostApi().uploadSupportingDocumentsInAdCostRegisterUpload(supportingDocsWrapper);
    }

    private void uploadDocsViaUI(ExamplesTable filesTable){
        AdCostsSupportingDocumentsPage supportingDocumentsPage = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage();
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            if(!row.get("FormName").equalsIgnoreCase("Additional supporting document"))
                supportingDocumentsPage.uploadSupportingDocumentsViaUI(getFilePath(row.get("FileName")),row.get("FormName"));
            else
                supportingDocumentsPage.uploadAdditionalSupportingDocumentsViaUI(getFilePath(row.get("FileName")),row.get("FormName"));
        }
    }

    @Given("{I |}clicked '$btnName' button on Supporting Documents page")
    @When("{I |}click '$btnName' button on Supporting Documents page")
    public void clickButtonOnSupportingDcos(String btnName){
        AdCostsSupportingDocumentsPage supportingDocumentsPage = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage();
        GenericSteps.refreshPageWithoutDelay();
        supportingDocumentsPage.waitUntilSupportingDcoumentsSectionToLoad();
        supportingDocumentsPage.clickBtnByName(btnName);
    }

    @Given("{I |}uploaded '$filePath' file into '$formName' form for '$costTitle' cost title")
    @When("{I |}upload '$filePath' file into '$formName' form for '$costTitle' cost title")
    public void uploadAdCostSupportingDocuments(String filePath, String formName, String costTitle) {
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costStageRevisionId = getCostRevisionId(costId,costStageId);
        uploadDocs_new(filePath, formName, costId,costStageId,costStageRevisionId);
    }

    @Given("{I am} on supporting documents page of cost title '$costTitle'")
    @When("{I am} on supporting documents of cost title '$costTitle'")
    public AdCostsSupportingDocumentsPage openCostItemPage(String costTitle) {
        String url = buildCostPageURL(wrapVariableWithTestSession(costTitle));
        return getSut().getPageNavigator().getAdCostsSupportingDocumentsPage(url);
    }

    @Given("{I |}uploaded following supporting documents to cost title '$costTitle': $filesTable")
    @When("{I |}upload following supporting documents to cost title '$costTitle': $filesTable")
    public void uploadMultipleFiles(String costTitle, ExamplesTable filesTable){
        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costStageRevisionId = getCostRevisionId(costId,costStageId);

        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            if(!row.get("FormName").equalsIgnoreCase("Additional supporting document"))
                uploadDocs_new(row.get("FileName"), row.get("FormName"), costId,costStageId,costStageRevisionId);
            else
                uploadAdditionalSupportingDocuments(row.get("FileName"), row.get("FormName"), costId,costStageId,costStageRevisionId);
        }
    }

    @Given("{I |}uploaded following supporting documents to cost title '$costTitle' and click continue: $filesTable")
    @When("{I |}upload following supporting documents to cost title '$costTitle' and click continue: $filesTable")
    public void uploadMultipleFilesAndContinue(String costTitle, ExamplesTable filesTable){
        getSut().getPageNavigator().getAdCostsSupportingDocumentsPage().waitUntilSupportingDcoumentsSectionToLoad();

        String costId = getCostId(wrapVariableWithTestSession(costTitle));
        String costStageId = getCostStageId(costId);
        String costStageRevisionId = getCostRevisionId(costId,costStageId);

        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            if(!row.get("FormName").equalsIgnoreCase("Additional supporting document"))
                uploadDocs_new(row.get("FileName"), row.get("FormName"), costId,costStageId,costStageRevisionId);
            else
                uploadAdditionalSupportingDocuments(row.get("FileName"), row.get("FormName"), costId,costStageId,costStageRevisionId);
        }
        clickButtonOnSupportingDcos("Continue");
    }

    @Given("{I |}uploaded following supporting documents via UI to cost title '$costTitle': $filesTable")
    @When("{I |}upload following supporting documents via UI to cost title '$costTitle': $filesTable")
    public void uploadMultipleFilesViaUI(String costTitle, ExamplesTable filesTable){
        uploadDocsViaUI(filesTable);
    }

    @Given("{I |}uploaded following supporting documents via UI to cost title '$costTitle' and click continue: $filesTable")
    @When("{I |}upload following supporting documents via UI to cost title '$costTitle' and click continue: $filesTable")
    public void uploadMultipleFilesAndContinueViaUI(String costTitle, ExamplesTable filesTable){
        uploadDocsViaUI(filesTable);
        Common.sleep(1000);
        getSut().getPageNavigator().getAdCostsSupportingDocumentsPage().clickBtnByName("Continue");
    }

    @Then("{I |}'$should' see below supporting documents:$filesTable")
    public void checkUploadedDocuments(String condition, ExamplesTable filesTable){
        AdCostsSupportingDocumentsPage supportingDocumentsPage = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage();
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            String actual = supportingDocumentsPage.getUploadedFileName(row.get("FormName"));
            String expected = "false";
            if(condition.equalsIgnoreCase("should"))
                expected = row.get("FileName");
            assertThat("Check Supporting documents visibility of '"+ row.get("FormName")+"': ",actual, is(expected));
        }
    }

    // | FormName | Condition  |
    @Then("{I |}see remove option for below on supporting documents:$filesTable")
    public void checkSupportingDocumentsOption(ExamplesTable filesTable){
        AdCostsSupportingDocumentsPage supportingDocumentsPage = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage();
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Boolean expected = false;
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            Boolean actual = supportingDocumentsPage.checkRemoveOption(row.get("FormName"));
            if(row.get("Condition").equalsIgnoreCase("should"))
                expected = true;
            assertThat("Check remove option for '"+ row.get("FormName")+"': ",actual,is(expected));
        }
    }

    @Given("{I |}removed below additional supporting documents:$filesTable")
    @When("{I |}remove below additional supporting documents:$filesTable")
    public void removeSupportingDocs(ExamplesTable filesTable){
        AdCostsSupportingDocumentsPage supportingDocumentsPage = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage();
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            supportingDocumentsPage.removeAdditionalSupportingDocument(row.get("FormName"));
            clickButtonNameOnFormPage("Yes");
        }
    }

    @Then("{I |}'$should' be able to upload following documents to cost title '$costTitle':$filesTable")
    public void checkSupportingDocumentsFileSize(String condition, String costTitle,ExamplesTable filesTable){
        try {
            String costId = getCostId(wrapVariableWithTestSession(costTitle));
            String costStageId = getCostStageId(costId);
            String costStageRevisionId = getCostRevisionId(costId, costStageId);

            for (int i = 0; i < filesTable.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(filesTable, i);
                HttpResponse response = checkUploadDocsFileSize(row.get("FileName"), row.get("FormName"), costId, costStageId, costStageRevisionId);
                String actual = EntityUtils.toString(response.getEntity());
                boolean isActual = false;
                boolean expected = false;

                if (response.getStatusLine().getStatusCode() >= 500)
                    throw new Error("Unable to upload '" + row.get("FileName") + "' document to '" + row.get("FormName") + "'. Check supporting document form name or GDN is down \n" +
                            "Status code: " + response.getStatusLine().getStatusCode() + " Reason: " + response.getStatusLine().getReasonPhrase());
                if (response.getStatusLine().getStatusCode() == 400) {
                    JsonParser jsonParser = new JsonParser();
                    JsonElement element = jsonParser.parse(actual);
                    JsonObject result = element.getAsJsonObject();
                    JsonArray array = result.getAsJsonArray("messages");
                    System.out.println(array.get(0).getAsString());
                    isActual = array.get(0).getAsString().equalsIgnoreCase("File size shoudl be less than or equal to 20 MB");
                    expected = !condition.equalsIgnoreCase("should");
                }
                if ((response.getStatusLine().getStatusCode() == 200 || response.getStatusLine().getStatusCode() == 201)) {
                    isActual = response.getStatusLine().getReasonPhrase().equalsIgnoreCase("Created");
                    expected = condition.equalsIgnoreCase("should");
                }
                assertThat("Check upload document file size", isActual, is(expected));
            }
        }catch (Exception e){
            throw new Error(e.getCause());
        }
    }

    @Then("{I |}'$condition' see toast message as '$message'")
    public void checkToastMessage(String condition, String expectedMessage){
        String actualMessage = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage().getToastMessage();
        assertThat("Check Warning message on Supporting Documents page: ",actualMessage,condition.equalsIgnoreCase("should")?is(expectedMessage):not(is(expectedMessage)));
    }

    @Then("{I |}'$condition' see toast message for following files:$data")
    public void checkToastMessage(String condition, ExamplesTable data){
        AdCostsSupportingDocumentsPage page = getSut().getPageNavigator().getAdCostsSupportingDocumentsPage();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if(!row.get("FormName").equalsIgnoreCase("Additional supporting document"))
                page.uploadSupportingDocumentsViaUI(getFilePath(row.get("FileName")),row.get("FormName"));
            else
                page.uploadAdditionalSupportingDocumentsViaUI(getFilePath(row.get("FileName")),row.get("FormName"));
            String actualMessage = page.getToastMessage();
            String expectedMessage= row.get("Message");
            assertThat("Check Warning message on Supporting Documents page: ",actualMessage,
                    condition.equalsIgnoreCase("should")?is(expectedMessage):not(is(expectedMessage)));
        }
    }
}