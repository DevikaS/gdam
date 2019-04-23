package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.AbstractControl;
import com.adstream.automate.page.controls.*;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.Map;
/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 27.08.13
 * Time: 0:31
 */

public abstract class AbstractForm {
    protected BasePage parent;
    protected Map<String, AbstractControl> controls;

    protected abstract void initControls();
    protected abstract void loadForm();
    protected abstract void unloadForm();
    protected abstract String getRootNode();

    public AbstractForm(BasePage parent) {
        this.parent = parent;
        waitUntilLoadSpinnerDisappears();
        loadForm();
        Common.sleep(2000);
    }

    public void fill(Map<String, String> fields) {
        for (Map.Entry<String, String> field : fields.entrySet()) {
            String fieldName = field.getKey();
            String fieldValue = field.getValue();
            if (getControls().containsKey(fieldName)) {
                AbstractControl control = getControls().get(fieldName);
                if (control instanceof Edit) {
                    if (control.isEnabled())
                        ((Edit) control).type(fieldValue,1000);}
                else if (control instanceof Checkbox){
                    ((Checkbox) control).setSelected(Boolean.parseBoolean(fieldValue));
                    Common.sleep(3000);}
                else if (control instanceof DojoCombo) {
                    if (control.isEnabled()){
                        try {
                            ((DojoCombo) control).selectValueOnFly(fieldValue);
                        }catch(Exception e){
                            ((DojoCombo) control).selectByVisibleText(fieldValue);
                        }
                    }
            }
                else if (control instanceof DojoSelect) {
                    ((DojoSelect)control).selectByVisibleText(fieldValue);
                    getDriver().sleep(1000);
                } else if (control instanceof DojoTextBox)
                    ((DojoTextBox) control).setDisplayedValue(fieldValue);
                else if (control instanceof DojoDateTextBox) {
                    ((DojoDateTextBox) control).setDisplayedValue(fieldValue);
                    ((DojoDateTextBox) control).slotChange();
                } else if (control instanceof DojoAutoSuggest) {
                    DojoAutoSuggest autoSuggest = ((DojoAutoSuggest) control);
                    autoSuggest.clear();   // to clear previously selected values in the control
                    autoSuggest.selectByVisibleText(fieldValue);
                    getDriver().sleep(100);
                }
                else
                    throw new IllegalStateException("Unknown class of control: " + control.getClass());
            } else
                throw new IllegalArgumentException("Unknown field name: " + fieldName);
        }
    }

    public String getFieldValue(String fieldName) {
        if (getControls().containsKey(fieldName)) {
            AbstractControl control = getControls().get(fieldName);
            if (control instanceof Edit)
                return control.getValue();
            else if (control instanceof Checkbox)
                return String.valueOf(((Checkbox) control).isSelected());
            else if (control instanceof DojoCombo)
                return ((DojoCombo) control).getDisplayedValue();
            else if (control instanceof DojoSelect)
                return ((DojoSelect) control).getDisplayedValue();
            else if (control instanceof DojoTextBox)
                return ((DojoTextBox) control).getDisplayedValue();
            else if (control instanceof DojoDateTextBox)
                return ((DojoDateTextBox) control).getDisplayedValue();
            else if (control instanceof DojoAutoSuggest) {
                DojoAutoSuggest autoSuggest = ((DojoAutoSuggest) control);
                return autoSuggest.getDisplayedItems().size() > 0 ? autoSuggest.getDisplayedItems().get(0) : autoSuggest.getDisplayedValue(); // returned first item, but can use getText() method or build custom string, if need to see full text in the control
            }
            else
                throw new IllegalStateException("Unknown class of control: " + control.getClass());
        }
        throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    public boolean isValidationFieldErrorVisible(String fieldName) {
        if (getControls().containsKey(fieldName)) {
            AbstractControl control = getControls().get(fieldName);
            if (control instanceof DojoCombo || control instanceof DojoTextBox || control instanceof DojoDateTextBox) {
                WebElement dojoElement = control.getWebElement();
                return dojoElement.getAttribute("class").contains("dijitTextBoxError");
            } else if (control instanceof Edit || control instanceof Checkbox) {
                WebElement controlElement = control.getWebElement();
                if (controlElement.getAttribute("class").contains("ui-input")) {
                    return controlElement.getAttribute("class").contains("error") || controlElement.getAttribute("class").contains("ng-invalid");
                } else {
                    WebElement rootElement = controlElement.findElement(By.xpath("ancestor::*[@widgetid][1]"));
                    return rootElement.getAttribute("class").contains("dijitTextBoxError");
                }
            }
            else
                throw new IllegalStateException("Unknown class of control: " + control.getClass());
        }
        throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    public boolean isFieldVisible(String fieldName) {
        if (getControls().containsKey(fieldName))
            return getControls().get(fieldName).isVisible();
        throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    public boolean isFieldEnabled(String fieldName) {
        if (getControls().containsKey(fieldName))
            return getControls().get(fieldName).isEnabled();
        throw new IllegalArgumentException("Unknown field name: " + fieldName);
    }

    protected Map<String, AbstractControl> getControls() {
        if (controls == null) {
            controls = new HashMap<>();
            initControls();
        }
        return controls;
    }

    protected void initControlsForAU(){};
    protected Map<String, AbstractControl> getControlsForAU() {
        if (controls == null) {
            controls = new HashMap<>();
            initControlsForAU();
        }
        return controls;
    }

    public void fillForAU(Map<String, String> fields) {
        for (Map.Entry<String, String> field : fields.entrySet()) {
            String fieldName = field.getKey();
            String fieldValue = field.getValue();
            if (getControlsForAU().containsKey(fieldName)) {
                AbstractControl control = getControlsForAU().get(fieldName);
                if (control instanceof Edit) {
                    if (control.isEnabled()) ((Edit) control).type(fieldValue); }
                else if (control instanceof Checkbox)
                    ((Checkbox) control).setSelected(Boolean.parseBoolean(fieldValue));
                else if (control instanceof DojoCombo) {
                    if (control.isEnabled()) ((DojoCombo) control).selectByVisibleText(fieldValue); }
                else if (control instanceof DojoSelect) {
                    ((DojoSelect)control).selectByVisibleText(fieldValue);
                    getDriver().sleep(100);
                } else if (control instanceof DojoTextBox)
                    ((DojoTextBox) control).setDisplayedValue(fieldValue);
                else if (control instanceof DojoDateTextBox) {
                    ((DojoDateTextBox) control).setDisplayedValue(fieldValue);
                    ((DojoDateTextBox) control).slotChange();
                } else if (control instanceof DojoAutoSuggest) {
                    DojoAutoSuggest autoSuggest = ((DojoAutoSuggest) control);
                    autoSuggest.clear();   // to clear previously selected values in the control
                    autoSuggest.selectByVisibleText(fieldValue);
                }
                else
                    throw new IllegalStateException("Unknown class of control: " + control.getClass());
            } else
                throw new IllegalArgumentException("Unknown field name: " + fieldName);
        }
    }

    protected ExtendedWebDriver getDriver() {
        return parent.getDriver();
    }

    protected void waitUntilLoadSpinnerDisappears() {
        getDriver().waitUntilElementDisappear(By.className("orders-spinner"));
    }

    protected By getAutoCompleteItemLocator() {
        return  By.className("ac-result-list-item");
    }

    protected By generateFormElementLocator(String partialLocator) {
        return By.cssSelector(String.format("%s %s", getRootNode(), partialLocator));
    }
}