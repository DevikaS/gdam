package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created by Raja.Gone on 15/05/2017.
 */
public class AdCostsSupportingDocumentsPage extends BaseAdCostPage<AdCostsSupportingDocumentsPage> {

    private String supportingDocumentsPageFormat = "//cost-supporting-documents";
    By supportingDocumentsPageLocator = By.xpath(supportingDocumentsPageFormat);
    public AdCostsSupportingDocumentsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilSupportingDocumentsPageVisible() { return web.isElementVisible(supportingDocumentsPageLocator); }

    public String getCurrentUserID(){ return getUserId(); }

    public void waitUntilSupportingDcoumentsSectionToLoad() { web.waitUntilElementAppearVisible(By.xpath(supportingDocumentsPageFormat.concat("//section")));}

    public void uploadSupportingDocumentsViaUI(String filePath,String formName){
        String docLocatorFormat = String.format("//div[@id='sd-doc-name'][.='%s']/../following-sibling::label//input",formName);
        web.findElement(By.xpath(docLocatorFormat)).sendKeys(filePath);
    }

    public void uploadAdditionalSupportingDocumentsViaUI(String filePath,String formName){
        String docLocatorFormat = String.format("//div[@id='sd-doc-name'][.='%s']/../following-sibling::label//input",formName);
        web.findElement(By.xpath(docLocatorFormat)).sendKeys(filePath);
    }

    public String getUploadedFileName(String formName){
        String docLocatorFormat = String.format("//div[@id='sd-doc-name'][.='%s']/following-sibling::div//span",formName);
        if(web.isElementVisible(By.xpath(docLocatorFormat)))
            return web.findElement(By.xpath(docLocatorFormat)).getText();
        else
            return "false";
    }

    public Boolean checkRemoveOption(String formName){
        String docLocatorFormat = String.format("//div[@id='sd-doc-name'][.='%s']/../following-sibling::h5",formName);
        return web.isElementVisible(By.xpath(docLocatorFormat));
    }

    public void removeAdditionalSupportingDocument(String formName){
        String docLocatorFormat = String.format("//div[@id='sd-doc-name'][.='%s']/../following-sibling::h5//span",formName);
        web.findElement(By.xpath(docLocatorFormat)).click();
    }
}
