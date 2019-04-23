package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrdersListPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Select;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.concurrent.TimeoutException;
/**
 * Created by denysb on 12/11/2015.
 */
public class TrafficNewTabPopUp extends PopUpWindow {

    private static final By tabNameField = By.cssSelector("[placeholder='Enter new tab name']");
    private static final By tabTypeField = By.cssSelector("[ng-model=\"$tabConfigModalCtrl.tab.tabType\"]");
    private static final By dataRangselecteDropDown =By.cssSelector("[ng-model=\"$tabConfigModalCtrl.tab.dateRange\"]");
    private static final By saveButtonLocator = By.cssSelector(".btn.btn-primary");
    private static final By addRuleButtonLocator = By.cssSelector("[ng-click=\"$tabRulesCtrl.addRule()\"]");
    private static final By addConditionLocator = By.cssSelector("[ng-click=\"$tabRuleCtrl.addCondition()\"]");
    private static final By shareTabSelector = By.cssSelector("[ng-model=\"$tabConfigModalCtrl.tab.public\"]");
    private static final By conditionFieldSelector = By.cssSelector("[ng-model=\"$tabRuleConditionCtrl.condition.schema\"]");
    private static final By optionsListSelector = By.cssSelector(".uib-typeahead-match");
    private static final By optionClick=By.cssSelector("[ng-model*='selectedConditionsField']>div");
    private static final By valueTypeFieldSelector = By.cssSelector("[ng-model=\"$tabRuleConditionCtrl.condition.value\"]");
    private static final By marketMetadataFieldSelector = By.cssSelector("[ng-model=\"$marketSelectorCtrl.selected\"]");
    private static final By marketMetadataValueSelector = By.cssSelector("[ng-model=\"$marketSelectorCtrl.selected\"]");
    private static final By filterByStatus=By.xpath("//input[@placeholder='Select Status filters']");
    private Button addRule;
    private Edit nameField;
    private static final By matchTypeEnterSelector = By.cssSelector("input[placeholder='And']");
   // private static final By conditionTypeEnterSelector = By.cssSelector("[ng-model=\"$tabRuleConditionCtrl.condition.value\"]");
    private static final By conditionTypeFieldSelector = By.cssSelector("[ng-model=\"$tabRuleConditionCtrl.condition.type\"]");
    private Select typeField;
    private Select dataRangeDropDown;
    private Button saveButton;

    public TrafficNewTabPopUp(Page parentPage) {
        super(parentPage);
        nameField = new Edit(parentPage,tabNameField);
        typeField = new Select(parentPage,tabTypeField);
        dataRangeDropDown = new Select(parentPage,dataRangselecteDropDown);
        saveButton = new Button(parentPage,saveButtonLocator);
        addRule = new Button(parentPage, addRuleButtonLocator);
    }

    public TrafficNewTabPopUp(ExtendedWebDriver driver) {
        this(new TrafficOrdersListPage(driver));
    }


    public void fillNameAndTypeForNewTrafficTab(String name, String type, String dataRange){
        nameField.type(name);
        if (!type.equals("")) typeField.select(getTabType(type));
        dataRangeDropDown.select(dataRange);
    }

    public void fillMarketMetadataSchemaField(String schema){
        WebElement schemaSelectorElement = web.findElement(marketMetadataValueSelector);
        web.typeClean(marketMetadataValueSelector, "Sp");
        fillConditionField(schema);
    }

    public void clickOnAddConditionLink(){
        web.findElement(addConditionLocator).click();
    }

    protected String getTabType(String tabType) {
        String type = tabType.replace("(","").replace(")","").replace(" ","_");
        if (type.equalsIgnoreCase(TabType.ORDER_ITEM_CLOCK.toString()))
            return TabType.ORDER_ITEM_CLOCK.getTabType();
        else if (type.equalsIgnoreCase(TabType.ORDER_ITEM_SEND.toString()))
            return TabType.ORDER_ITEM_SEND.getTabType();
        else if (type.equalsIgnoreCase(TabType.ORDER.toString()))
            return TabType.ORDER.getTabType();
        else if (type.equalsIgnoreCase(TabType.CLOCK.toString()))
            return TabType.CLOCK.getTabType();
        else
            throw new IllegalArgumentException("Unknown Tab type: " + tabType);
    }

    public void clickAddRuleButton(){
        web.click(addRuleButtonLocator);
    }

    public void selectShareTabCheckbox(){
        web.click(shareTabSelector);
    }

    public void selectMatchType(Integer numberOfMatchElement,String match){
       // List<WebElement> list = web.findElements(By.cssSelector("[ng-model=\"$tabRuleCtrl.rule.operator\"]"));
        org.openqa.selenium.support.ui.Select matchSelect ;
        List<WebElement> matchSelectList = web.findElements(By.cssSelector("[ng-model=\"$tabRuleCtrl.rule.operator\"]" ));
        //List<WebElement> list2 = web.findElements(matchTypeEnterSelector);
        if(matchSelectList.size() >= numberOfMatchElement){
            matchSelect= new org.openqa.selenium.support.ui.Select(matchSelectList.get(numberOfMatchElement));
            matchSelect.selectByVisibleText(match);

        }
    }

    public void addNewConditions(Integer count, String condition,String filterType, String value){
        List<WebElement> conditionFieldSelectorElementsList = web.findElements(conditionFieldSelector);
        conditionFieldSelectorElementsList.get(count).sendKeys(condition);
        fillConditionField(condition);
        List<WebElement> conditionTypeFieldSelectorElementsList = web.findElements(conditionTypeFieldSelector);
        //List<WebElement> conditionEnterTypeElementsList = web.findElements(conditionTypeEnterSelector);
        conditionTypeFieldSelectorElementsList.get(count).click();
        fillField(conditionTypeFieldSelectorElementsList.get(count), filterType);
        List<WebElement> valueElementsList = web.findElements(valueTypeFieldSelector);
        value=computeDateValue(value);
        fillField(valueElementsList.get(count), value);
    }

    private String computeDateValue(String value){
        if(value.equalsIgnoreCase("Yesterday")) {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, -1);
            value = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
        }
        return value;
    }

    public void fillField(WebElement element, String value){
        element.sendKeys(value);
        element.sendKeys(Keys.ENTER);
    }

    public void fillConditionField(String value){
        web.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
        List<WebElement> li=web.findElements(By.xpath("//li[@role='option']"));
        for(WebElement w:li){
            if(w.getText().equalsIgnoreCase(value)) {
                web.scrollToElement(w);
                w.click();
                break;
            }
        }
    }

    public void clickSaveButton(){
        saveButton.click();
    }

    public List<WebElement> getTabRulesList(){
        return web.findElements(By.cssSelector(".row tab-rule"));
    }

    public void fillFilterByStatus(String value){
        web.findElement(filterByStatus).sendKeys(value);
        web.findElement(filterByStatus).sendKeys(Keys.ENTER);
    }


    public boolean verifyTabOptions(String option)
    {
        boolean isOption;
        try {
            isOption = web.findElement(By.xpath("//option[@label='" + option + "']")).isDisplayed();
        }
        catch(Exception e)
        {
            isOption=false;
        }
        return isOption;
    }

    public void deleteTabRuleWithCondition(String condition){
        List<WebElement> rules=getTabRulesList();
        try {
            for (WebElement rule : rules) {
                List<WebElement> conds = rule.findElements(By.cssSelector(".row tab-rule-condition"));
                for (WebElement cc : conds) {
                    List<WebElement>  list=cc.findElements(By.cssSelector("[ng-model=\"$tabRuleConditionCtrl.condition.schema\"]"));
                    Common.sleep(5000);
                    for(WebElement li:list)  {
                        if (li.getAttribute("value").equalsIgnoreCase(condition)) {
                            rule.findElement(By.cssSelector("[ng-click=\"$tabRuleConditionCtrl.deleteCondition()\"]")).click();
                            if(list.size()==1)
                                rule.findElement(By.cssSelector("[ng-click=\"$tabRuleCtrl.removeRule()\"]")).click();
                        }}
                }
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
