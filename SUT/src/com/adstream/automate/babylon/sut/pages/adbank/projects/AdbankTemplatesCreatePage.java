package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.elements.controls.complex.LogoElement;
import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.*;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 08.02.12
 * Time: 20:02
 */
public class AdbankTemplatesCreatePage extends BaseAdBankPage {
    private LogoElement logo;
    public Button saveButton;
    public Link cancelLink;
    public DojoEdit nameEdit;
    public Edit jobNumberEdit;
    public DojoDateTextBox startDateBox;
    public DojoDateTextBox endDateBox;
    public DojoDateTextBox publishDateBox;
    public DojoCombo mediaTypeBox;
    public DojoCombo administratorsBox;
    public DojoCombo templateName;
    public Button addAdministratorButton;
    public DojoCombo selectProjectAgencyBox;

    private String textFieldLocatorFormat = "//*[contains(@class,'schemaDataField')]//label[normalize-space()='%s']//*[contains(@data-dojo-type, 'TextField')]";
    private String multilineFieldLocatorFormat = "//*[contains(@class,'schemaDataField')]//label[.//*[normalize-space()='%s']]//textarea";
    private String comboboxLocatorFormat = "//*[contains(@class,'schema_field')]//label[normalize-space()='%s']/following-sibling::*[@role='combobox']";
    private String dateFieldLocatorFormat = "//*[contains(@class,'schema_field')]//*[normalize-space()='%s']//*[@role='combobox']";
    private String autoSuggestLocatorFormat = "//*[contains(@class,'schema_field')]//label[normalize-space()='%s']/following-sibling::*[@role='autosuggest']";
    private String phoneFieldLocatorFormat = "//*[contains(@class,'schemaDataField')]//*[.//label[normalize-space()='%s']]//*[contains(@data-dojo-type, 'PhoneField')]/input";
    private String radioButtonsFieldLocatorFormat = "//*[@data-dojo-type='common.prop_schema.radioButtons'][label[normalize-space()='%s']]";
    private String adCodeButtonLocatorFormat    = ".button.secondary.unit[data-role='%s']";


    public AdbankTemplatesCreatePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
        this.logo = new LogoElement(web);
        this.saveButton = new Button(this, By.name("save"));
        this.cancelLink = new Link(this, By.className("cancel"));
        this.nameEdit = new DojoEdit(this, By.name("_cm.common.name"));
        this.jobNumberEdit = new Edit(this, By.name("_cm.common.jobNumber"));
       // this.startDateBox = new DojoDateTextBox(this,By.xpath("//*[.='Start date']/following-sibling::div/div[contains(@class,'startdate')]"));
        //this.endDateBox = new DojoDateTextBox(this,By.xpath("//*[.='End date']/following-sibling::div/div[contains(@class,'startdate')]"));
        this.startDateBox = new DojoDateTextBox(this,By.xpath("//*[.='Start date']/following-sibling::div/div/input[contains(@id, 'common_prop_schema_DateTextBox')]"));
        this.endDateBox = new DojoDateTextBox(this,By.xpath("//*[.='End date']/following-sibling::div/div/input[contains(@id, 'common_prop_schema_DateTextBox')]"));
        this.publishDateBox = new DojoDateTextBox(this, By.xpath("//*[.='Publish on']/following-sibling::div/div/input[contains(@id, 'adbank_project_DateTextBox')]"));
        this.mediaTypeBox = new DojoCombo(this, By.xpath("//*[@role='combobox'][*/*[@name='_cm.common.projectMediaType']]"));
        this.administratorsBox = new DojoCombo(this, By.cssSelector(".test_users"));
        this.addAdministratorButton = new Button(this, By.xpath("//button[text()='Add']"));
        this.templateName = new DojoCombo(this, By.className("templateSelector"));
        this.selectProjectAgencyBox = new DojoCombo(this, getSelectProjectAgencyLocator());

    }

    @Override
    public void load() {
        super.load();
        saveButton.visible();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-role='schemedContent']"));
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(saveButton.isVisible());
        assertTrue(web.isElementVisible(By.cssSelector("[data-role='schemedContent']")));
    }

    public void save() {
        saveButton.click();
    }

    public String getName() {
        return nameEdit.getValue();
    }

    public void setName(String name) {
        nameEdit.setValue(name);
    }

    public void setJobNumber(String jobNumber) {
        jobNumberEdit.type(jobNumber);
    }

    public void setStartDate(String startDate) {
        startDateBox.setDisplayedValue(startDate);
        startDateBox.slotChange();
    }

    public void setEndDate(String endDate) {
        endDateBox.setDisplayedValue(endDate);
        endDateBox.slotChange();
    }

    public void setPublishDate(String publishDate) {
        publishDateBox.setDisplayedValue(publishDate);
    }
    public List<String> getAllMetadataFieldsNames() {
        return web.findElementsToStrings(By.cssSelector(".schema_field_wrapper .schema_field label"));
    }

    public String getMultilineFieldRowsCount(String fieldName) {
        return web.findElement(By.xpath(String.format(multilineFieldLocatorFormat, fieldName))).getAttribute("rows").trim();
    }

    public List<String> getAllRequiredMetadataFieldsNames() {
        return web.findElementsToStrings(By.cssSelector("[data-role='schemedContent'] .required_field"));
    }

    public List<String> getComboboxFieldValuesByName(String fieldName) {
        return new DojoCombo(this, By.xpath(String.format(comboboxLocatorFormat, fieldName))).getValues();
    }

    // fieldsType variable may be in the following states:
    //      when required - method return only required fields list
    //      when all - method return all fields list
    public List<Map<String,String>> getProjectFieldsList(String fieldsType) {
        List<Map<String,String>> projectFieldsList = new ArrayList<>();

        By fieldsNamesLocator;

        if (fieldsType.equalsIgnoreCase("required")) {
            fieldsNamesLocator = By.cssSelector("[data-role='schemedContent'] .required_field");
        } else if (fieldsType.equalsIgnoreCase("all")) {
            fieldsNamesLocator = By.cssSelector(".projects_action_form_popup label>div:first-child,.projects_action_form_popup .label");
        } else {
            throw new IllegalArgumentException(String.format("Unknown fields type '%s'", fieldsType));
        }

        for (String fieldName : web.findElementsToStrings(fieldsNamesLocator)) {
            Map<String,String> projectField = new HashMap<>();

            By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
            By multilineFieldLocator = By.xpath(String.format(multilineFieldLocatorFormat, fieldName));
            By comboboxLocator = By.xpath(String.format(comboboxLocatorFormat, fieldName));
            By dateFieldLocator = By.xpath(String.format(dateFieldLocatorFormat, fieldName));
            By autoSuggestLocator = By.xpath(String.format(autoSuggestLocatorFormat, fieldName));
            By phoneFieldLocator = By.xpath(String.format(phoneFieldLocatorFormat, fieldName));
            By radioButtonsFieldLocator = By.xpath(String.format(radioButtonsFieldLocatorFormat, fieldName));

            // remove previously selected auto complete items
            if (web.isElementPresent(autoSuggestLocator)) {
                String value = "";
                for (String item : new DojoAutoSuggest(this, autoSuggestLocator).getDisplayedItems())
                    value += String.format("%s,", item);
                projectField.put(fieldName, value.replaceAll(",$",""));
            } else if (web.isElementPresent(textFieldLocator)) {
                projectField.put(fieldName, web.findElement(textFieldLocator).getAttribute("value"));
            } else if (web.isElementPresent(multilineFieldLocator)) {
                projectField.put(fieldName, web.findElement(multilineFieldLocator).getText().trim());
            } else if (web.isElementPresent(phoneFieldLocator)) {
                projectField.put(fieldName, web.findElement(phoneFieldLocator).getAttribute("value"));
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                String fieldValue = "";
                WebElement parentElement = web.findElement(radioButtonsFieldLocator);
                for (WebElement element : parentElement.findElements(By.xpath(".//input")))
                    if (element.isSelected())
                        fieldValue = element.getAttribute("value").trim();

                projectField.put(fieldName, fieldValue);
            } else if (web.isElementPresent(comboboxLocator)) {
                projectField.put(fieldName, new DojoCombo(this, comboboxLocator).getSelectedLabel());
            } else if (web.isElementPresent(dateFieldLocator)) {
                projectField.put(fieldName, new DojoCombo(this, dateFieldLocator).getSelectedLabel());
            }

            projectFieldsList.add(projectField);
        }

        if (web.isElementPresent(By.cssSelector(".section>label"))) {
            Map<String,String> projectField = new HashMap<>();
            String fieldName = web.findElement(By.cssSelector(".section>label")).getText().trim();
            String fieldValue = new DojoCombo(this, By.cssSelector(".section [role='combobox']")).getSelectedLabel();
            projectField.put(fieldName, fieldValue);
            projectFieldsList.add(projectField);
        }

        return projectFieldsList;
    }

    public String getMediaType() {
        return mediaTypeBox.getSelectedLabel();
    }

    public void setMediaType(String mediaType) {
        mediaTypeBox.selectByVisibleText(mediaType);
    }

    public String getSelectProjectAgency() {
        return selectProjectAgencyBox.getSelectedLabel();
    }

    public void setSelectProjectAgency(String selectProjectAgency) {
        if (isSelectProjectAgencyExist() && !getSelectProjectAgency().equals(selectProjectAgency)) {
            WebElement formFooter = web.findElement(By.cssSelector("[data-role='schemedContent'] .formFooter"));
            selectProjectAgencyBox.selectByVisibleText(selectProjectAgency);
            web.waitUntilElementChanged(formFooter);
        }
    }

    public List<String> getAllRadioButtonsValues(String fieldName) {
        String fieldValue;
        List<String> result = new ArrayList<>();
        By radioButtonsFieldLocator = By.xpath(String.format(radioButtonsFieldLocatorFormat, fieldName));
        By comboboxLocator = By.xpath(String.format(comboboxLocatorFormat, fieldName));
        WebElement parentElement;
        if (web.isElementPresent(radioButtonsFieldLocator)){
            parentElement = web.findElement(radioButtonsFieldLocator);
            for (WebElement element : parentElement.findElements(By.xpath(".//input"))) {
                fieldValue = element.getAttribute("value").trim();
                if (!fieldValue.isEmpty())
                    result.add(fieldValue);
            }
            return result;
        }
        else if (web.isElementPresent(comboboxLocator)) {
            return new DojoCombo(this, comboboxLocator).getValues();
        }
        return null;
    }

    public void addAdministrator(String administrator) {
        web.typeClean(By.cssSelector(".test_users .dijitInputInner"), administrator);
        web.sleep(1000);
        new DojoCombo(this, By.className("test_users")).selectByVisibleText(administrator);
        web.sleep(1000);
        addAdministratorButton.click();
    }

    public List<String> getAdministrators() {
        By adminNames = By.cssSelector(".admin_list .unit:first-child");
        if (!web.isElementPresent(adminNames)) return new ArrayList<>();
        return web.findElementsToStrings(adminNames);
    }

    public void removeAdministrator(User user) {
        String name = user.getFullName() == null ? user.getEmail() : user.getFullName();
        String locator = String.format("//div[normalize-space(.)='%s']/following-sibling::div/a", name);
        web.click(By.xpath(locator));
    }

    public AdbankTemplatesCreatePage fill(Map<String,String> fields) {

        if (fields.get("Business Unit") != null && !fields.get("Business Unit").isEmpty()) {
            setSelectProjectAgency(fields.get("Business Unit"));
            Common.sleep(1000);
        }
        if (fields.get("JobNumber") != null) setJobNumber(fields.get("JobNumber"));
        if (fields.get("StartDate") != null) {

            setStartDate(fields.get("StartDate"));
        }
        if (fields.get("EndDate") != null) setEndDate(fields.get("EndDate"));
        if (fields.get("Name") != null) setName(fields.get("Name"));
        if (fields.get("MediaType") != null) setMediaType(fields.get("MediaType"));
        if (fields.get("FullUserName") != null){
            addAdministrator(fields.get("FullUserName"));
        }else if(fields.get("Administrators") != null)
            for (String admin : fields.get("Administrators").split(","))
                addAdministrator(admin);

        if (fields.get("Logo") != null)
            logo.uploadLogo(fields.get("Logo"));
        if(fields.get("Publish Date") != null) {
            setPublishDate(fields.get("Publish Date"));
        }

        return this;
    }

    public AdbankTemplatesCreatePage fillClientProject(Map<String,String> fields) {
        if (fields.get("Name") != null) setName((fields.get("Name")));
        if (fields.get("Project Type") != null)
        {
            DojoCombo projectType = new DojoCombo(this, By.xpath("//*[contains(@data-schema-path,'_cm.common.ProjectType')]/div[2]"));
            DojoAutoSuggest autoSuggestCountry = new DojoAutoSuggest(this, By.xpath("//*[contains(@name,'_cm.common.Country')]"));
            DojoCombo brand = new DojoCombo(this, By.xpath("//*[contains(@data-schema-path,'_cm.common.advertiser')]/div[2]"));
            DojoEdit desc = new DojoEdit(this, By.xpath(" //*[contains(@name,'_cm.common.Description')]"));
            projectType.selectByVisibleText(fields.get("Project Type"));
            brand.selectByVisibleText(fields.get("Brand"));
            autoSuggestCountry.selectByVisibleText(fields.get("Country"));
            desc.setValue(fields.get("Description"));
            List<WebElement> radioBtns = web.findElements(By.xpath(".//*[contains(@name,'_cm.common.IsActive')]"));
            if(fields.get("Administrators") != null)
                for (String admin : fields.get("Administrators").split(","))
                    addAdministrator(admin);
            for(WebElement isActiveBtn:radioBtns){
              if(isActiveBtn.getAttribute("value").equalsIgnoreCase(fields.get("Is Active"))){
                  isActiveBtn.click();
               }
            }
        }
        if (fields.get("ProjectID")!= null) {
            if (fields.get("ProjectID").equalsIgnoreCase("Auto")) {
                web.findElement(By.cssSelector(".button.secondary.unit[data-role=\"adCodeAutoButton\"]")).click();
            } else {
                setJobNumber(fields.get("ProjectID"));
            }
        }
        return this;
    }

    public void uploadLogo(String logoPath) {
        logo.uploadLogo(logoPath);
    }

    public void uploadLogoBig(String logoPath) {
        logo.uploadLogoBig(logoPath);
    }

    public boolean disabledCustomCodeFieldByName(String fieldName) {
        By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
        return !web.findElement(textFieldLocator).isEnabled();
    }

    public void publishImmediately(String fieldValue){
        String checkBoxLocator = "//input[@type='checkbox']/following-sibling::span[contains(text(),'Publish Immediately')]";
        if(web.isElementPresent(By.xpath(checkBoxLocator))){
            if(fieldValue.equalsIgnoreCase("should"))
                new Checkbox(this, By.xpath(checkBoxLocator)).select();
        }
    }

    public void fillFieldByName(String fieldName, String fieldValues) {

        By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
        By multilineFieldLocator = By.xpath(String.format(multilineFieldLocatorFormat, fieldName));
        By comboboxLocator = By.xpath(String.format(comboboxLocatorFormat, fieldName));
        By dateFieldLocator = By.xpath(String.format(dateFieldLocatorFormat, fieldName));
        By autoSuggestLocator = By.xpath(String.format(autoSuggestLocatorFormat, fieldName));
        By phoneFieldLocator = By.xpath(String.format(phoneFieldLocatorFormat, fieldName));
        By radioButtonsFieldLocator = By.xpath(String.format(radioButtonsFieldLocatorFormat, fieldName));
        By autoProjectbuttonLocator = By.cssSelector(String.format(adCodeButtonLocatorFormat,fieldName));

        // remove autosuggest items

        if (web.isElementPresent(autoSuggestLocator)) new DojoAutoSuggest(this, autoSuggestLocator).clear();

        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(autoSuggestLocator)) {
                DojoAutoSuggest autoSuggest = new DojoAutoSuggest(this, autoSuggestLocator);

                if (autoSuggest.getAvailableItems().contains(fieldValue)) {
                    autoSuggest.selectByVisibleText(fieldValue);
                } else {
                    autoSuggest.selectItemOnFly(fieldValue);
                }
            }
            else if (web.isElementPresent(comboboxLocator))
            {
                DojoCombo combobox = new DojoCombo(this, comboboxLocator);

                if (combobox.getValues().contains(fieldValue)) {
                    combobox.selectByVisibleText(fieldValue);
                } else {
                    combobox.selectValueOnFly(fieldValue);
                }
            }
            else if (web.isElementPresent(dateFieldLocator))
            {
                new DojoCombo(this, dateFieldLocator).selectByVisibleText(fieldValue);
                web.click(dateFieldLocator);
            }
            else if (web.isElementPresent(textFieldLocator)) {
                web.typeClean(textFieldLocator, fieldValue);
            } else if (web.isElementPresent(autoProjectbuttonLocator)) {
                web.click(autoProjectbuttonLocator);
            } else if (fieldName.equalsIgnoreCase("IncludeFiles")) {
                if (fieldValue.contains("true")) web.click(By.name("cloneFiles"));
            } else if (web.isElementPresent(multilineFieldLocator)) {
                web.typeClean(multilineFieldLocator, fieldValue);
            } else if (web.isElementPresent(phoneFieldLocator)) {
                web.typeClean(phoneFieldLocator, fieldValue);
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                WebElement element = web.findElement(radioButtonsFieldLocator);
                element.findElement(By.xpath(String.format(".//*[@value='%s']", fieldValue))).click();
            } else if (web.isElementPresent(getSelectProjectAgencyLocator())) {
                setSelectProjectAgency(fieldValue);
            } else if (web.isElementPresent(templateName.getLocator())) {
                templateName.selectByVisibleText(fieldValue);
                Common.sleep(1000);
            }   else if (fieldName.equalsIgnoreCase("AllowCreateProjects")) {
                if (fieldValue.equalsIgnoreCase("true")) web.click(getFlagOfPublicTemplateLocator());
            }  else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }
    public AdbankTemplatesCreatePage fillClientTemplate(Map<String,String> fields) {
        if (fields.get("Name") != null) setName((fields.get("Name")));
        if (fields.get("Project Type") != null)
        {
            DojoCombo projectType = new DojoCombo(this, By.xpath("//*[contains(@data-schema-path,'_cm.common.ProjectType')]/div[2]"));
            DojoAutoSuggest autoSuggestCountry = new DojoAutoSuggest(this, By.xpath("//*[contains(@name,'_cm.common.Country')]"));
            DojoCombo brand = new DojoCombo(this, By.xpath("//*[contains(@data-schema-path,'_cm.common.advertiser')]/div[2]"));
            DojoEdit desc = new DojoEdit(this, By.xpath(" //*[contains(@name,'_cm.common.Description')]"));
            projectType.selectByVisibleText(fields.get("Project Type"));
            brand.selectByVisibleText(fields.get("Brand"));
            autoSuggestCountry.selectByVisibleText(fields.get("Country"));
            desc.setValue(fields.get("Description"));
            List<WebElement> radioBtns = web.findElements(By.xpath(".//*[contains(@name,'_cm.common.IsActive')]"));
            for(WebElement isActiveBtn:radioBtns){
                if(isActiveBtn.getAttribute("value").equalsIgnoreCase(fields.get("Is Active"))){
                    isActiveBtn.click();
                }
            }
        }
        if (fields.get("ProjectID")!= null) {
            if (fields.get("ProjectID").equalsIgnoreCase("Auto")) {
                web.findElement(By.cssSelector(".button.secondary.unit[data-role=\"adCodeAutoButton\"]")).click();
            } else {
                setJobNumber(fields.get("ProjectID"));
            }
        }
        return this;
    }
    public boolean isFieldHaveSize(String fieldName, String fieldSize) {
        if (fieldSize.equalsIgnoreCase("Full Width")) {
            fieldSize = "size1of1";
        } else if (fieldSize.equalsIgnoreCase("Half Width")) {
            fieldSize = "size1of2";
        } else {
            throw new IllegalArgumentException(String.format("Unexpected field size '%s'", fieldSize));
        }

        By fieldLocator = By.xpath(String.format("//*[@data-role='schemedContent']//*[contains(@class,'%s')][normalize-space()='%s']", fieldSize, fieldName));

        return web.isElementPresent(fieldLocator);
    }


    public boolean isFieldDisabled(String fieldName) {
        By fieldLocator = By.xpath(String.format(
                "//*[contains(@class,'schemaDataField')][.//label[normalize-space()='%s']]//div[@aria-disabled='true']", fieldName));
        return web.isElementPresent(fieldLocator);
    }

    public byte[] getLogo() {
        return getDataByUrl(logo.getImageSrc());
    }

    public boolean isAdminPresent(User user) {
        String name = user.getEmail();
        if (user.getSubtype().equals("user") && user.getFullName() != null && !user.getFullName().isEmpty())
            if(web.isElementPresent(By.xpath(String.format("//div[@class='admin_list']//div[normalize-space(.)='%s']", user.getFullName())))){
            name = user.getFullName();
            }
        String locator = String.format("//div[@class='admin_list']//div[normalize-space(.)='%s']", name);
        return web.isElementPresent(By.xpath(locator));
    }

    public boolean isAdminPresentByEmail(String email) {
        String locator = String.format("//div[@class='admin_list']//div[normalize-space(.)='%s']", email);
        return web.isElementPresent(By.xpath(locator));
    }

    public int getAdministratorsCount() {
        return web.findElements(By.cssSelector(".admin_list > *")).size();
    }

    public boolean isDeleteAdminPresent(User user) {
        String locator = String.format("//div[.='%s']/following-sibling::div/a", user.getFullName());
        return web.isElementPresent(By.xpath(locator));
    }

    public boolean isOwnersSectionVisible() {
        return web.isElementVisible(getOwnersSectionCssLocator());
    }

    public boolean isFlagOfPublicTemplate() {
        return web.isElementVisible(getFlagOfPublicTemplateLocator())
                && web.isElementPresent(getFlagOfPublicTemplateLocator());
    }

    public void waitUntilPopUpDisappears() {
             web.waitUntilElementDisappear(getPopUpTitleLocator());
    }

    public void checkAllowOtherUsersInMyAgencyUseThisTemplate() {
        new Checkbox(this, By.cssSelector(".popupWindow [data-role='isPublicTemplateWidjet']")).select();
    }

    public boolean isSelectProjectAgencyExist() {
        return web.isElementPresent(getSelectProjectAgencyLocator());
    }

    private By getOwnersSectionCssLocator() {
        return By.cssSelector("[data-dojo-type='adbank.shared.user_administrators']");
    }

    private By getFlagOfPublicTemplateLocator() {
        return By.cssSelector("[data-dojo-type=\"adbank.templates.isPublicTemplate\"]");
    }

    private By getPopUpTitleLocator() {

        return By.cssSelector(".popupWindow:not([style*='display: none'])>.windowHead");
    }

    private By getSelectProjectAgencyLocator() {
        return By.xpath("//*[@role='combobox'][*/*[@data-role='agency-selector']]");
    }
}