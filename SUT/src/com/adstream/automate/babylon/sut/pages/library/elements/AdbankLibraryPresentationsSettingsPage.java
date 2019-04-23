package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 29.10.12
 * Time: 9:42
 */
public class AdbankLibraryPresentationsSettingsPage extends AdbankLibraryPresentationsPage {
    private DojoCombo expirationDate;
    private Checkbox enableAutoPlayCheckbox;

    public AdbankLibraryPresentationsSettingsPage(ExtendedWebDriver web) {
        super(web);
        expirationDate = new DojoCombo(this, By.cssSelector(".date"));
        enableAutoPlayCheckbox = new Checkbox(this,By.cssSelector(".settings [name='autoPlay']"));
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector(".settings"));
        web.waitUntilElementAppearVisible(By.cssSelector(".reels-sidebar"));
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector(".settings")));
        assertTrue(web.isElementVisible(By.cssSelector(".reels-sidebar")));
    }

    public void fillPresentationNameField(String name) {
        web.typeClean(By.name("name"), name);
    }

    public void fillDescriptionField(String description) {
        web.typeClean(By.name("description"), description);
        web.sleep(200);
    }

    public void fillBetweenAssetField(String duration) {
        web.typeClean(By.name("betweenAsset"), duration);
        web.sleep(200);
    }

    public void fillNoDurationForField(String duration) {
        web.typeClean(By.name("noDurationFor"), duration);
        web.sleep(200);
    }

    public void clickSaveButton() {
        web.click(By.name("Save"));
    }

    public void clickCancelLink() {
        web.click(By.cssSelector(".settings .cancel"));
    }

    public String getFieldValue(String fieldName) {
        if (fieldName.equalsIgnoreCase("name")) {
            return web.findElement(By.cssSelector(".settings [name='name']")).getAttribute("value").trim();
        } else if (fieldName.equalsIgnoreCase("description")) {
            return web.findElement(By.cssSelector(".settings [name='description']")).getText().trim();
        } else {
            throw new IllegalArgumentException(String.format("Unexpected field name '%s'", fieldName));
        }
    }
     // NGN- 16214-QAA: Presentations / Reels autoplay code change starts
    public boolean isAutoPlayChecked() {
            return enableAutoPlayCheckbox.isSelected();
    }

     public void checkAutoplayElement(String action,boolean state) {
        if(action.equalsIgnoreCase("uncheck")) {
            if (!state && (web.findElement(By.cssSelector(".settings [name='autoPlay']")).isSelected())) {
                enableAutoPlayCheckbox.click();
            }
        }else{
            if (state && !(web.findElement(By.cssSelector(".settings [name='autoPlay']")).isSelected())) {
                enableAutoPlayCheckbox.click();
            }
        }
    }
    // NGN- 16214-QAA: Presentations / Reels autoplay code change Ends
}