package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created by Janaki.Kamat on 04/05/2017.
 */

public class LibEditFilePopup extends LibPopUpWindow {
    private static final By sectionLocator= By.cssSelector("//ads-ui-sch-form-group");
    private static final By sectionDividerLocator=By.cssSelector("//ads-md-divider/span[text()=\"%s\"]");
    private static final By fieldSelectorsLocator=By.cssSelector("//ads-ui-sch-field-edit");
    private String comboBoxValueFormat = "//div[@class=\"option ui-select-choices-row-inner\"]//span";
    private String multiSelectFormat="//*[@class=\"ui-select-choices-group\"]//li[@ng-repeat=\"option in $select.items\"]";

    public LibEditFilePopup(Page parent){
        super(parent,"ads-ui-file-form[mode=\"'edit'\"]");
        Common.sleep(2000);
        web.waitUntilElementAppear(generateLocator());
        action=new Button(parentPage, By.cssSelector("ads-md-button[click=\"$ctrl.submit()\"] button"));
    }

    public List<String> getSectionNames() {
        return web.findElementsToStrings(By.xpath("form[class=\"margin-bottom-10 ng-pristine ng-valid ng-valid-pattern ng-valid-required\"] ads-md-divider[ng-show=\"$ctrl.group.description && $ctrl.isGroupVisibleForEdit()\"] span"));
    }

    public void fillEditFilePopup(List<MetadataItem> fields) {
        for (MetadataItem field : fields)
          for(String value:field.getValue().split(","))
            fillFieldByName(field.getKey(), value.trim(), field.getSection());
    }

    public void expandSection(String name){
        List<WebElement> expandSection = web.findElements(By.cssSelector("[click=\"$ctrl.toggle()\"] button"));
        for(WebElement elem:expandSection) {
            if(!web.isElementVisible(By.cssSelector(String.format("[placeholder=\"%s\"]",name)))) {
                if (!elem.findElement(By.cssSelector("span[code^=\"chevron-outline\"]")).getAttribute("code").equalsIgnoreCase("chevron-outline-up")) {
                    web.scrollToElement(elem);
                    elem.click();
                    Common.sleep(1000);
                }
            }
            else
                break;
        }
    }
    public void fillFieldByName(String name, String value, String section) {
        expandSection(name);
        if (web.isElementPresent(By.xpath(getDateFieldLocator(name, section)))) {
            fillDateBoxField(name, value, section);
        } else if (web.isElementPresent(By.xpath(getComboboxFieldLocator(name, section)))) {
            fillComboboxField(name, value, section);
        } else if (web.isElementPresent(getTextFieldLocator(name, section))) {
            fillTextField(name, value, section);
        } else if (web.isElementPresent(By.xpath(getMultiSelectFieldLocator(name, section)))) {
            fillMultiSelectField(name, value, section);
        } else {
            String message = String.format("Field '%s' is not present on Edit File popup", name);
            if (section != null) message += String.format(" in section '%s'", section);
            throw new IllegalArgumentException(message);

        }
    }


    private By getTextFieldLocator(String name, String section) {
        String format = "%s//ads-md-input[@placeholder='%s']//input";
        return By.xpath(String.format(format, getSectionXpathString(section), name));
    }


    public List<String> getAvailableComboBoxValuesOnEditAssetPopup(String fieldName,String sectionName)
    {
        List<String> values=null;
          if(!sectionName.equalsIgnoreCase("general")) //All section needs to be expanded other than general
          {
              if(web.isElementVisible(By.xpath("//ads-accordion[contains(@description,'"+sectionName+"')]//ads-md-button"))) //different assets have different sections
              {
                  WebElement ele = web.findElement(By.xpath("//ads-accordion[contains(@description,'"+sectionName+"')]//ads-md-button"));
                  web.scrollToElement(ele);
                  ele.click();
              }
          }
          if(web.isElementVisible(getSelectFieldLocator(fieldName))) {
              web.scrollToElement(web.findElement(getSelectFieldLocator(fieldName)));
              web.findElement(getSelectFieldLocator(fieldName)).click();
              Common.sleep(1000);
              values = web.findElementsToStrings(By.xpath("//div[contains(@class,'ui-select-choices-row ng-scope')]//span"));
          }
          if(web.isElementVisible(getMultiSelectFieldLocator(fieldName))) {
                web.scrollToElement(web.findElement(getMultiSelectFieldLocator(fieldName)));
                web.findElement(getMultiSelectFieldLocator(fieldName)).click();
                Common.sleep(1000);
                values = web.findElementsToStrings(By.xpath("//ul[contains(@class,'ui-select-choices')]//li[contains(@id,'ui-select-choices')]"));
            }
            return values;
    }


    private By getMultiSelectFieldLocator(String fieldName) {

        return By.xpath(String.format("//ads-ui-sch-field-edit//ads-md-multiselect[@label='%s']//span[contains(@class,'icon-arrow')]", fieldName));
    }

    private By getSelectFieldLocator(String fieldName) {

        return By.xpath(String.format("//ads-ui-sch-field-edit//ads-ui-select-dictionary[@label='%s']//span[contains(@class,'icon-arrow')]", fieldName));
    }

    public List<String> getAvailableComboBoxValuesWithScroll(String field,String scrollOption)
    {

        By locator = By.xpath(String.format("//ads-ui-sch-field-edit//ads-ui-select-dictionary[@label='%s']//span[contains(@class,'icon-arrow')]", field));
        web.scrollToElement(web.findElement(locator));
        web.findElement(locator).click();
        Common.sleep(1000);
        web.scrollToElement(web.findElement(By.xpath("//div[@class='ui-select-choices-row ng-scope']//span[contains(.,'"+scrollOption+"')]")));
        List<String> values = web.findElementsToStrings(By.xpath("//div[contains(@class,'ui-select-choices-row ng-scope')]//span"));
        return values;
    }

    public Boolean verifyPresenceOfMetadataFieldsOnEditPopup(String fieldName)
    { boolean isExist = false;
        try{
        web.isElementVisible(By.xpath("//ads-ui-sch-field-edit//*[@label='"+fieldName+"']"));} //* works for both input and dropdown control
        catch(Exception e){}
        return isExist;
    }



    public String verifyMetadataValuesOnEditAssetPopup(String fieldName,String sectionName)
    {
        String value="";
        WebElement ele = web.findElement(By.xpath("//ads-accordion[@description='" + sectionName + "']"));
        web.scrollToElement(ele);
        if (web.isElementVisible(By.xpath("//ads-accordion[@description='" + sectionName + "']//span[@code='chevron-outline-down']"))) {
            web.findElement(By.xpath("//ads-accordion[@description='" + sectionName + "']//span[@code='chevron-outline-down']")).click();
        }

        if (web.isElementVisible(By.xpath("//ads-ui-sch-field-edit//ads-ui-select-dictionary[@label='" + fieldName + "']"))) {
            value = web.findElement(By.xpath("//ads-ui-sch-field-edit//*[@placeholder='" + fieldName + "']")).getText();
        }
        if (web.isElementVisible(By.xpath("//ads-ui-sch-field-edit//ads-md-multiselect[@label='" + fieldName + "']"))) {
            value = web.findElement(By.xpath("//ads-ui-sch-field-edit//*[@placeholder='" + fieldName + "']//ul[@class='select2-choices']")).getText();
        }
        if (web.isElementVisible(By.xpath("//ads-ui-sch-field-edit//ads-md-input[@placeholder='" + fieldName + "']"))) {
            value = web.findElement(By.xpath("//ads-ui-sch-field-edit//*[@placeholder='" + fieldName + "']//input")).getAttribute("value");
        }

    return value;
    }

    public boolean verifyFieldsDisabledOnEditAssetPopup(String fieldName,String sectionName)
    {
     boolean flag=false;
        WebElement ele = web.findElement(By.xpath("//ads-accordion[@description='" + sectionName + "']"));
        web.scrollToElement(ele);
        if (web.isElementVisible(By.xpath("//ads-accordion[@description='" + sectionName + "']//span[@code='chevron-outline-down']"))) {
            web.findElement(By.xpath("//ads-accordion[@description='" + sectionName + "']//span[@code='chevron-outline-down']")).click();
        }

        if (web.isElementVisible(By.xpath("//ads-ui-sch-field-edit//ads-ui-select-dictionary//div[@title='"+fieldName+"']"))) {
            flag = web.isElementVisible(By.xpath("//ads-ui-sch-field-edit//ads-ui-select-dictionary//div[@title='"+fieldName+"'][@disabled='disabled']"));
        }


        return flag;
    }



    private String getMultiSelectFieldLocator(String name, String section) {
        String format = "%s//ads-md-multiselect[@placeholder='%s']//input";
        return String.format(format, getSectionXpathString(section), name);
    }

    private String getComboboxFieldLocator(String name, String section) {
        String format = "%s//ads-ui-select-dictionary[@placeholder='%s']//input";
        return String.format(format, getSectionXpathString(section), name);
    }

    private String getDateFieldLocator(String name, String section) {
        String format = "%s//ads-md-datepicker[@placeholder='%s']//md-input-container//input";
        return String.format(format, getSectionXpathString(section), name);
    }

    private By getComboInputSelector(String name, String value, String section){
        String comboInputFormat="%s//ads-md-dictionary[@placeholder='%s']//md-autocomplete-wrap/input";
        return By.xpath(String.format(comboInputFormat,getSectionXpathString(section),name));
    }


    public void fillComboboxField(String name, String value, String section) {
        if(web.isElementPresent(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]",getSectionXpathString(section),name)))) {
            web.scrollToElement(web.findElement(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]",getSectionXpathString(section),name))));
            web.click(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name)));
         }
        else
        web.findElement(By.xpath(getComboboxFieldLocator(name, section))).clear();
        if(!value.isEmpty()) {
           try {
               if (web.isElementPresent(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name)))) {
                   web.scrollToElement(web.findElement(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name))));
                   web.click(By.xpath(String.format("%s//ads-ui-select-dictionary[@placeholder='%s']//*[@ng-click=\"$ctrl.clearModel()\"]", getSectionXpathString(section), name)));
               } else {
                   WebElement elem = web.findElement(By.xpath(getComboboxFieldLocator(name, section)));
                   web.scrollToElement(elem);
                   elem.click();
                   elem.sendKeys(value);
                   web.waitUntilElementAppear(By.xpath("//ads-ui-select-dictionary//div[contains(@class,'ui-select-choices-row-inner')]//span[contains(text(),'" + value + "')]"));
                   web.findElement(By.xpath("//ads-ui-select-dictionary//div[contains(@class,'ui-select-choices-row-inner')]//span[contains(text(),'" + value + "')]")).click();

               }
           }
            catch(Exception e){
                if(web.isElementPresent(By.xpath("/*//*[contains(text(),\"No matches found\")]")))
                    web.click(By.xpath("/*//*[contains(text(),\"No matches found\")]"));
            }}
      }


    public void fillMultiSelectField(String name, String value, String section) {
        WebElement elem=web.findElement(By.xpath(getMultiSelectFieldLocator(name, section)));
        if(!value.trim().isEmpty()) {
            web.scrollToElement(elem);
            web.findElement(By.xpath(String.format("%s//ads-md-multiselect[@placeholder='%s']", getSectionXpathString(section), name))).click();
            web.typeClean(By.xpath(getMultiSelectFieldLocator(name, section)), value);
            web.findElement(By.xpath("//*[@class=\"ui-select-choices-group\"]//li[@ng-repeat=\"option in $select.items\"]//span[contains(text(),'"+value+"')]")).click();
        }

        else{
            List<WebElement> elements=web.findElements(By.xpath(String.format("*//ads-md-multiselect[@placeholder=\"%s\"]//a[@ng-click=\"$selectMultiple.removeChoice($index)\"]",name)));
            for(WebElement link:elements){
                web.scrollToElement(link);
                link.click();
                Common.sleep(2000);
            }}

    }


    private String getSectionXpathString(String section) {
        if (section == null)
            return "";
        else
            return String.format("//ads-ui-sch-form-group[.//span[normalize-space()=normalize-space('%s')]]/div[@class=\"layout-wrap ng-scope layout-align-start-start layout-row\"]", section.toUpperCase());
    }

    public void fillDateBoxField(String name, String value, String section) {
       web.scrollToElement(web.findElement(By.xpath(getDateFieldLocator(name, section))));
      // web.getJavascriptExecutor().executeScript("arguments[0].setAttribute('value', arguments[1])",web.findElement(By.xpath(getDateFieldLocator(name, section))),value);
        web.typeClean(By.xpath(getDateFieldLocator(name, section)), value + Keys.ENTER);
        web.sleep(1000);
    }

    public void fillTextField(String name, String value, String section) {
        web.scrollToElement(web.findElement(getTextFieldLocator(name, section)));
     //   Common.sleep(1000);
        web.typeClean(getTextFieldLocator(name, section), value + Keys.ENTER);
        web.sleep(1000);
    }

    private void waitUntilEditFilePopUpAppears() {
        web.waitUntilElementAppearVisible(getFormLocator());
        web.sleep(1000);
    }

    private By getFormLocator() {
        return By.cssSelector("[class=\"asset-page layout-align-space-between-stretch layout-row edit-mode\"]");
    }

    public void save() {
        Common.sleep(2000);
       // web.findElement(By.xpath("//ads-md-input[@placeholder='Title']//input")).click();
        web.scrollToElement(action.getWebElement());
        web.getJavascriptExecutor().executeScript("arguments[0].click();",action.getWebElement());
        Common.sleep(3000);
        web.waitUntilElementDisappear(generateLocator());

    }

    public void saveAndAccept() {
        Common.sleep(2000);
        web.scrollToElement(web.findElement(By.xpath("//ads-md-button//button[..//span[contains(text(),'Save and accept')]]")));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-md-button//button[..//span[contains(text(),'Save and accept')]]")));
        web.waitUntilElementAppear(By.xpath(".//*[contains(text(),\"Asset successfully accepted\")]"));
        web.waitUntilElementDisappear(generateLocator());

    }

    public String getErrorMessage(String field){
        return web.findElement(By.xpath(String.format("//ads-md-dictionary[@placeholder=\"%s\"]//ng-message[@when=\"noMatch\"]",field))).getText();
    }

    public boolean checkButtonEnabled(String button){
        boolean enabled=true;
        switch(button){
            case "save":
                enabled = action.isEnabled();
                break;
            default:
                throw new IllegalArgumentException(String.format("%s button does not exist",button));
        }
        return enabled;
    }



}

