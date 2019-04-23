package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import java.io.File;
import static com.thoughtworks.selenium.SeleneseTestBase.fail;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 08.11.12
 * Time: 11:54

 */
public class AdbankLibraryPresentationsBrandingPage extends AdbankLibraryPresentationsPage {

    public AdbankLibraryPresentationsBrandingPage(ExtendedWebDriver web) {
        super(web);
    }

    public void clickLightTheme() {
        web.click(By.cssSelector(".theme.light .icon.mbs"));
    }

    public void clickSaveButton() {
        web.click(By.name("Save"));
    }

    public void clickCancelButton() {
        web.click(By.cssSelector(".mbm.mtl.clearfix.controls .cancel"));
    }

    public boolean isLightThemeChecked() {
        return web.findElement(By.cssSelector(".theme.light")).getAttribute("class").contains("checked");
    }

    public void clickDarkTheme() {
        web.click(By.cssSelector(".theme.dark .icon.mbs"));
    }

    public boolean isDarkThemeChecked() {
        return web.findElement(By.cssSelector(".theme.dark")).getAttribute("class").contains("checked");
    }

    public boolean isLogoThumbnailEmpty() {
        By locator = By.cssSelector("[data-dojo-type='library.presentations.uploadTitle'] .image");
        return !(web.isElementPresent(locator) && web.isElementVisible(locator));
    }

    public boolean isLogoFileNameVisible() {
        By locator = By.cssSelector("[data-dojo-type='library.presentations.uploadTitle'] .bold");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public String getLogoName() {
        return web.findElement(By.cssSelector(".mlm.mtm .inline-block.valign-middle.mlm .bold")).getText();
    }

    public boolean isBackgroundFileNameVisible() {
        By locator = By.cssSelector("[data-dojo-type='library.presentations.uploadBackground'] .bold");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public String getBackgroundFileName() {
        return web.findElement(By.cssSelector(".backgroundOptions .inline-block.valign-middle.mlm .bold")).getText();
    }

    public boolean isBackgroundThumbnailEmpty() {
        By locator = By.cssSelector("[data-dojo-type='library.presentations.uploadBackground'] .image[style*='url']");
        return !(web.isElementPresent(locator) && web.isElementVisible(locator));
    }

    public boolean isScaleToFitScreenRBSelected() {
        return web.findElement(By.cssSelector("[value='scale']")).isSelected();
    }

    public void clickScaleToFitScreen() {
        web.click(By.cssSelector("[value='scale']"));
    }

    public boolean isTileRBSelected() {
        return web.findElement(By.cssSelector("[value='tile']")).isSelected();
    }

    public void clickTile() {
        web.click(By.cssSelector("[value='tile']"));
    }

    public boolean isRemoveLogoLinkVisible() {
        if (!web.isElementPresent(By.cssSelector(".mlm.mtm .inline-block.valign-middle.mlm .remove.mls"))) return true;
        return web.isElementVisible(By.cssSelector(".mlm.mtm .inline-block.valign-middle.mlm .remove.mls"));
    }

    public PopUpWindow clickRemoveLogoLink() {
        web.click(By.cssSelector(".mlm.mtm .inline-block.valign-middle.mlm .remove.mls"));
        return new PopUpWindow(this);
    }

    public boolean isRemoveBackgroundLinkVisible() {
        if (!web.isElementPresent(By.cssSelector(".backgroundOptions .inline-block.valign-middle.mlm .remove.mls"))) return true;
        return web.isElementVisible(By.cssSelector(".backgroundOptions .inline-block.valign-middle.mlm .remove.mls"));
    }

    public PopUpWindow clickRemoveBackgroundLink() {
        web.click(By.cssSelector(".backgroundOptions .inline-block.valign-middle.mlm .remove.mls"));
        return new PopUpWindow(this);
    }

    public void uploadLogo(String logo) {
        if (logo != null && !logo.isEmpty()) {
            web.findElement(By.cssSelector("[id*='Title'] [name='file']")).sendKeys(logo);
            if (!web.isAlertPresent()) web.waitUntilElementAppearVisible(By.cssSelector(".inline-block.titlePreview.imageHolder .image"));
        }
    }

    public void uploadLogoWithoutWaiting(String logo) {
        if (logo != null && !logo.isEmpty()) {
            web.findElement(By.cssSelector("[id*='Title'] [name='file']")).sendKeys(logo);
            Common.sleep(500);
        }
    }

    public void uploadBackground(String backgroundFile) {
        if (backgroundFile != null && !backgroundFile.isEmpty()) {
            File file = new File(backgroundFile);
            if (!file.exists()) throw new IllegalArgumentException(String.format("Background file %s does not exist", file.toString()));
            web.findElement(By.cssSelector("[id*='Background'] [name='file']")).sendKeys(backgroundFile);
            if (!web.isAlertPresent()) {
                long startTime = System.currentTimeMillis();
                while (isBackgroundThumbnailEmpty()) {
                    Common.sleep(500);
                    if (System.currentTimeMillis() - startTime > 15000) fail("Background is not uploaded");
                }
            }
        }
    }

    public void uploadBackgroundWithoutWaiting(String backgroundFile) {
        if (backgroundFile != null && !backgroundFile.isEmpty()) {
            web.findElement(By.cssSelector("[id*='Background'] [name='file']")).sendKeys(backgroundFile);
        }
    }
}
