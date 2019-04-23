package com.adstream.automate.babylon.sut.pages.library;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryPage;
import com.adstream.automate.babylon.sut.pages.library.collections.AdbankLibraryPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.AbstractControl;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.HashMap;
import java.util.Map;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 30.08.12 18:37
 */
public class AdbankAddFileToLibraryPage extends BaseLibraryPage<AdbankAddFileToLibraryPage> {
    public Edit id;
    public DojoCombo client;
    public DojoCombo campaign;
    public Edit title;
    public DojoSelect mediaType;
    public DojoSelect subType;
    public Edit duration;
    public Edit width;
    public Edit height;
    public DojoSelect screen;
    public Edit fileType;
    public Edit fileSize;
    public Button save;
    public Link cancel;
    public DojoCombo advertiser;
    public DojoCombo brand;
    public DojoCombo subBrand;
    public DojoCombo product;
    public Edit clockNumber;
    private Button autoCodeBtn;
    private Map<String, AbstractControl> controls = new HashMap<>();

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getAddFileToLibraryFormLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getAddFileToLibraryFormLocator()));
    }

    public AdbankAddFileToLibraryPage(ExtendedWebDriver web) {
        super(web);

        controls.put("ID", id = new Edit(this, By.name("_cm.common.name"))); // ID - is absent now. Obligatory field is name
        controls.put("Title", title = new Edit(this, By.name("_cm.common.name")));
        controls.put("Media Type", mediaType = new DojoSelect(this, By.cssSelector("[data-schema-path*='mediaType'] .dijitComboBox")));
        controls.put("Sub Media Type", subType = new DojoSelect(this, By.cssSelector("[data-schema-path*='mediaSubType'] .dijitComboBox")));
        controls.put("Duration", duration = new Edit(this, By.cssSelector("[name*='duration']")));
        controls.put("Width", width = new Edit(this, By.name("metadata.width")));
        controls.put("Height", height = new Edit(this, By.name("metadata.height")));
        controls.put("Screen", screen = new DojoSelect(this, By.cssSelector("[data-schema-path*='screen'] .dijitComboBox")));
        controls.put("File Type", fileType = new Edit(this, By.cssSelector("[data-schema-path='moveto#metadata.fileType'] .ui-input")));
        controls.put("File Size", fileSize = new Edit(this, By.cssSelector("[data-schema-path='moveto#metadata.fileSize'] .ui-input")));

        controls.put("Advertiser", advertiser = new DojoCombo(this, By.cssSelector("[data-schema-path*='asset_element_project_common#_cm.common.advertiser'] [role='combobox']")));
        controls.put("Brand", brand = new DojoCombo(this, By.cssSelector("[data-schema-path*='asset_element_project_common#_cm.common.brand'] [role='combobox']")));
        controls.put("Sub Brand", subBrand = new DojoCombo(this, By.cssSelector("[data-schema-path*='asset_element_project_common#_cm.common.sub_brand'] [role='combobox']")));
        controls.put("Product", product = new DojoCombo(this, By.cssSelector("[data-schema-path*='asset_element_project_common#_cm.common.product'] [role='combobox']")));
        controls.put("Clock number", clockNumber = new Edit(this, getClockNumberLocator()));

        save = new Button(this, By.name("save"));
        cancel = new Link(this, By.className("cancel"));
        autoCodeBtn = new Button(this, By.cssSelector("[data-role='adCodeAutoButton']"));
    }

    public void fill(Map<String, String> fields) {
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            setValue(entry.getKey(), entry.getValue());
        }
    }

    public AdbankLibraryPage clickSaveBtn() {
        if(save.enabled(4000))
        save.click();
        return new AdbankLibraryPage(web);
    }


    public NewAdbankLibraryPage clickSaveBtnNewLib() {
        if(save.enabled(4000))
            save.click();
        return new NewAdbankLibraryPage(web);
    }
    public void generateAutoCode() {
        clickAutoCodeBtn();
        getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return !webDriver.findElement(getClockNumberLocator()).getAttribute("value").isEmpty();
            }
        });
    }

    public void pushAutoCodeButton() {
        clickAutoCodeBtn();
    }

    public String getFieldValue(String field) {
        AbstractControl control = getControl(field);
        String value = null;
        web.sleep(2000);
        if (control.isExists() && control.isVisible()) {
            if (control instanceof Edit) value = control.getValue();
            if (control instanceof DojoCombo) value = ((DojoCombo) control).getDisplayedValue();
            if (control instanceof DojoSelect) value = ((DojoSelect) control).getSelectedLabel();
        }
        if (value == null) value = "";
        return value;
    }

    public boolean isIdFieldHighlighted() {
        return web.isElementPresent(By.cssSelector("[name='_cm.common.name'].error"));
    }

    public boolean isClientFieldHighlighted() {
        return web.isElementPresent(By.xpath("//*[.='Client']/following-sibling::div[contains(@class,'dijitComboBoxError ')]"));
    }

    public boolean isProductFieldHighlighted() {
        return web.isElementPresent(By.xpath("//*[.='Product']/following-sibling::div[contains(@class,'dijitComboBoxError ')]"));
    }

    public void selectProduct(String visibleText){
        DojoCombo product = new DojoCombo(this, By.xpath("//label[text()='Product']/..//input[contains(@id,'dijit_form_FilteringSelect')]"));
        product.selectByVisibleText(visibleText);
    }

    public void setId(String id){
        WebElement idField = web.findElement(By.xpath("//label[text()='ID']/../input"));
        idField.clear();
        idField.sendKeys(id);
    }

    private void clickAutoCodeBtn() {
        autoCodeBtn.click();
    }

    private void setValue(String field, String value) {
        AbstractControl control = getControl(field);
        if (control.isExists() && control.isVisible()) {
            if (control instanceof Edit) {
                ((Edit) control).sendKeys("");
                ((Edit) control).type(value);
            }
            if (control instanceof DojoCombo) {
                if (((DojoCombo) control).getValues().contains(value)) {
                    ((DojoCombo) control).selectByVisibleText(value);
                } else {
                    ((DojoCombo) control).selectValueOnFly(value);
                }
            }
            web.sleep(1000);
        }
    }

    private AbstractControl getControl(String field) {
        if (controls.containsKey(field)) return controls.get(field);
        throw new IllegalArgumentException(String.format("Unknown field '%s'", field));
    }

    private By getClockNumberLocator() {
        return By.name("_cm.video.clockNumber");
    }

    private By getAddFileToLibraryFormLocator() {
        return By.cssSelector(".multiple_asset_form .assetActionForm");
    }
}