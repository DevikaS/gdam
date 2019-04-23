package com.adstream.automate.babylon.sut.pages.admin.watermarking;

import com.adstream.automate.babylon.sut.elements.controls.complex.LogoElement;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by Geethanjali.K on 11/02/2016
 */
public  class WaterMarkingManagementPage extends BaseAdminPage<WaterMarkingManagementPage> {
    private Edit waterMarkingText;
    private LogoElement waterMarkinglogo;
    private DojoCombo logoPosition;
    private DojoCombo textPosition;
    private DojoCombo logoPositionForUpload;

    private final static String ROOT_NODE = ".watermarking-content.phl.pvm.ng-scope";

    public WaterMarkingManagementPage(ExtendedWebDriver web) {
        super(web);
        logoPosition = new DojoCombo(this, By.cssSelector(".watermarking-content.phl.pvm.ng-scope div[class='b-schema-form ng-isolate-scope']:nth-child(3) div[class='b-schema-form-group__content b-schema-fields clearfix'] div:nth-child(1) a:nth-child(1)"));
        textPosition = new DojoCombo(this, By.cssSelector(".watermarking-content.phl.pvm.ng-scope div[class='b-schema-form ng-isolate-scope']:nth-child(3) div[class='b-schema-form-group__content b-schema-fields clearfix'] div:nth-child(4) a:nth-child(1)"));
        logoPositionForUpload = new DojoCombo(this,By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[1]//label//a"));
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getPageLocator()));
    }

    protected String getRootNode() {
        return ROOT_NODE;
    }

    protected By generatePageLocator(String partialLocator) {
        return By.cssSelector(String.format("%s %s", getRootNode(), partialLocator));
    }

    private By getPageLocator() {
        return By.cssSelector(getRootNode());
    }

    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code starts

    private By getWaterMarkingTextLocator() {
       // return By.cssSelector(".watermarking-content.phl.pvm.ng-scope div[class='b-schema-form ng-isolate-scope']:nth-child(3) div[class='b-schema-form-group__content b-schema-fields clearfix'] div:nth-child(3)>label>input");

        return By.cssSelector(".watermarking-content.phl.pvm.ng-scope div[class='b-schema-form ng-isolate-scope']:nth-child(3) div[class*='b-schema-form-group__content b-schema-fields clearfix'] div:nth-child(3)>label>input");
    }

    private DojoCombo getLogoPositionLocator() {
        return logoPosition;
    }

    private DojoCombo getTextPositionLocator() {
        return textPosition;
    }

    public void fillLogoOpacityLevel(String text)
    {
        web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[2]//label//input")).sendKeys(text);
    }

    public void fillTextOpacityLevel(String text)
    {
        web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[5]//label//input")).sendKeys(text);
    }



    public String getWaterMarkingTextValue() {
        return web.findElement(getWaterMarkingTextLocator()).getAttribute("value").trim();
    }

    public void fillWaterMarkingTextBox(String text) {
        web.sleep(3000);
       web.typeClean(getWaterMarkingTextLocator(), text);
    }


    public String getTextPositionValue() {
        return getTextPositionLocator().getAttribute("value").trim();
    }

    public void fillTextPositionComboBox(String text) {
        web.sleep(3000);
        getTextPositionLocator().selectByVisibleText(text);
    }

    public void fillLogoPosition(String text) {

        logoPositionForUpload.click();
        List<WebElement> position = web.findElements(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[1]//label//li"));
        for (int i = 1; i <= position.size() - 1; i++) {
            String actualList = web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[1]//label//li[" + i + "]")).getText();
            if (actualList.equalsIgnoreCase(text)) {
                web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[1]//label//li[" + i + "]")).click();
                break;
            }
        }
    }

    public void fillTextPosition(String text) {
        web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[4]//label//a")).click();
        List<WebElement> position = web.findElements(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[4]//label//li"));
        for (int i = 1; i <= position.size()-1; i++) {
            String actualList = web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[4]//label//li[" + i + "]")).getText();
            if (actualList.equalsIgnoreCase(text)) {
               web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[4]//label//li[" + i + "]")).click();
                break;
            }
        }
    }

    public void fillWatermarkDownloadFontPosition(String text) {
        web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[8]//label//a")).click();
        Common.sleep(2000);      List<WebElement> position = web.findElements(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[8]//label//li"));
        for (int i = 1; i <= position.size()-1; i++) {
            String actualList = web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[8]//label//li[" + i + "]")).getText();
            if (actualList.equalsIgnoreCase(text)) {
                web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[8]//label//li[" + i + "]")).click();
                break;
            }
        }
    }

    public void checkWatermarkUploadCheckbox() {
        web.findElement(By.xpath("//div[@groups='[defaultGroup]']/div[1]/div[1]/div[1]//label//input")).click();
    }

    public void checkWatermarkDownloadCheckbox() {
        web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[6]//label//input")).click();
    }

    public void enterWatermarkDownloadText(String text) {
        web.findElement(By.xpath("//div[@groups='[editGroup]']/div[1]/div[1]/div[7]//label/textarea")).sendKeys(text);
    }

    public void clickSaveButton() {
        web.click(By.cssSelector(".secondary.button.ng-scope"));
        Common.sleep(1000);
    }

    public void uploadLogoForWatermarkUpload(String logo) {
        web.findElement(By.xpath("//input[@class='uploadButton button']")).sendKeys(logo);
    }

    public boolean verifyWatermarkUploadPreviewForLogo()
    {
        return web.waitUntilElementAppear(By.xpath("//img[@class='watermarkImagePreview ng-scope top-right']")).isDisplayed();

    }

    public boolean verifyWatermarkUploadPreviewForText()
    {
        return web.waitUntilElementAppear(By.xpath("//div[@class='watermarkTextPreview ng-binding centre']")).isDisplayed();

    }


}