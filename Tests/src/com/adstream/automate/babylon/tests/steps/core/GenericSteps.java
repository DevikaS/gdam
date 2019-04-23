package com.adstream.automate.babylon.tests.steps.core;

import com.adstream.automate.babylon.JsonObjects.GenerateProxySet;
import com.adstream.automate.babylon.JsonObjects.TranscodingAgency;
import com.adstream.automate.babylon.JsonObjects.VideoProxySet;
import com.adstream.automate.babylon.JsonObjects.XMPMapping;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.winium.ftp.desktop.WiniumFTPRemote;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.page.Control;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.IO;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import org.hamcrest.Matcher;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Pending;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 15:54
 */
public class GenericSteps extends BaseStep {
    @Given("{I have |}refreshed the page")
    @When("{I |}refresh the page")
    @Then("{I |}refresh the page")
    public static void refreshPage() {
        getSut().getWebDriver().navigate().refresh();
        Common.sleep(10000);
    }

    @Given("{I |}returned to previous page")
    @When("{I |}return to previous page")
    public void comeBack() {
        getSut().getWebDriver().navigate().back();
    }

    @Given("{I |}refreshed the page without delay")
    @When("{I |}refresh the page without delay")
    public static void refreshPageWithoutDelay() {
        getSut().getWebDriver().navigate().refresh();
        if(getSut().getWebDriver().isAlertPresent())
        {
            try {
                Alert alert = getSut().getWebDriver().switchTo().alert();
                alert.accept();
            } catch (NoAlertPresentException e) {
                log.debug("No Modal Browser dialog present..Proceed Mate");
            }
        }
    }

    @Then("{I should see |}alert text is '$text'")
    public static void checkAlert(String text) {
        String actualMessage = getSut().getWebDriver().getAlertMessage();
        assertThat(actualMessage, equalTo(text));
    }

    @Then("{I should see |}alert text is like '$text'")
    public static void checkAlertByRegEx(String text) {
        String message = getSut().getWebDriver().getAlertMessage();
        assertThat(message, StringByRegExpCheck.matches(text));
    }

    @Then("{I should see |}text on page contains '$text'")
    public static void checkTextOnPage(String text) {
        Common.sleep(5000);
        String pageText = getSut().getWebDriver().getPageSource();
       assertThat(pageText, containsString(text));
    }

    @Given("{I |}clicked on element '$elementName'")
    @When("{I |}click on element '$elementName'")
    public static void clickElement(String elementName) {
        String pageUrl = getSut().getPageUrl();
        By elementLocator = getSut().getUIMap().getByPageUrl(pageUrl, elementName);
        getSut().getWebDriver().scrollToElement(getSut().getWebDriver().findElement(elementLocator));
        Common.sleep(1000);
        getSut().getWebDriver().click(elementLocator);
        Common.sleep(2000);
    }

    @Given("{I |}clicked on element '$elementName' without delay")
    @When("{I |}click on element '$elementName' without delay")
    public static void clickElementWithoutDelay(String elementName) {
        String pageUrl = getSut().getPageUrl();
        By elementLocator = getSut().getUIMap().getByPageUrl(pageUrl, elementName);
        getSut().getWebDriver().click(elementLocator);
    }

    @Given("{I |}clicked element '$elementName' on page '$pageName'")
    @When("{I |}click element '$elementName' on page '$pageName'")
    @Then("{I |}click element '$elementName' on page '$pageName'")
    public void clickElement(String elementName, String pageName) {
        // NGN-14650
        By elementLocator = null;
        if(pageName.equalsIgnoreCase("Roles") && (elementName.equalsIgnoreCase("CopyButton") || elementName.equalsIgnoreCase("SaveButton")))
            elementLocator = elementName.equalsIgnoreCase(("CopyButton")) ? By.cssSelector("button.mlm.copy") : By.cssSelector(".button.secondary.save");
        else
            elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);

        getSut().getWebDriver().waitUntilElementAppear(elementLocator);
        getSut().getWebDriver().click(elementLocator);
        Common.sleep(3000);
    }

    @Given("{I |}clicked element '$elementName' on page '$pageName' without delay")
    @When("{I |}click element '$elementName' on page '$pageName' without delay")
    public void clickElementWithoutDelay(String elementName, String pageName) {
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        getSut().getWebDriver().click(elementLocator);
    }

    @When("{I |}type in element '$elementName' on page '$pageName' text '$text'")
    public void typeInElement(String elementName, String pageName, String text) {
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        getSut().getWebDriver().click(elementLocator);
        getSut().getWebDriver().typeClean(elementLocator, text);
        Common.sleep(2000);
    }

    @When("{I |}type and hit enter in element '$elementName' on page '$pageName' with '$type' as '$text'")
    public void hitEnterInElement(String elementName, String pageName, String type, String text) {
        if(type.equals("email")){
             text = wrapUserEmailWithTestSession(text);
        }
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        getSut().getWebDriver().click(elementLocator);
        getSut().getWebDriver().typeClean(elementLocator, text + Keys.ENTER);
        Common.sleep(2000);
    }

    @When("{I |}type in element '$elementName' on page '$pageName' email '$text'")
    public void typeInElementEmail(String elementName, String pageName, String text) {
        String email = wrapUserEmailWithTestSession(text);
        typeInElement(elementName, pageName, email);
    }

    @Then("{I |}'$shouldState' see element '$elementName' on page '$pageName'")
    public void checkElementVisibility(String shouldState, String elementName, String pageName) {
        ExamplesTable elementsTable = new ExamplesTable(String.format("|element|\n|%s|", elementName));
        checkElementsVisibility(shouldState, pageName, elementsTable);
    }

    @Then("{I |}'$shouldState' see elements '$elements' on page '$pageName'")
    public void checkElementsVisibility(String shouldState, String elements, String pageName) {
        String tableString = "|element|";
        for (String element : elements.split(",")) {
            tableString += String.format("\n|%s|",element);
        }
        checkElementsVisibility(shouldState, pageName, new ExamplesTable(tableString));
    }

    // | element |
    @Then("{I |}'$shouldState' see following elements on page '$pageName': $elementsTable")
    public void checkElementsVisibility(String shouldState, String pageName, ExamplesTable elementsTable) {
        By elementLocator = null; // NGN-14650
        boolean should = shouldState.equals("should");
        for (Map<String, String> row : elementsTable.getRows()) {
            if(pageName.equalsIgnoreCase("Roles")) // NGN-14650
                elementLocator = By.xpath("//span[contains(.,'Create new Role')]"); // NGN-14650
            else // NGN-14650
             elementLocator = getSut().getUIMap().getByPageName(pageName, row.get("element"));
            assertThat("Is element " + row.get("element") + " visible, locator " + elementLocator.toString(),
                    getSut().getWebDriver().isElementVisible(elementLocator),
                    equalTo(should));
        }
    }

    @Then("I '$shouldState' see box '$elementName' on page '$pageName' with following fields: $fieldsTable")
    public void checkBoxElements(String shouldState, String elementName, String pageName, ExamplesTable fieldsTable) {
        boolean should = shouldState.equals("should");
        By boxLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        for (Map<String, String> row : fieldsTable.getRows()) {
            assertThat("Is jsElement " + row.get("field") + " visible, locator " + boxLocator.toString(),
                    new DojoSelect(getSut().getPageCreator().getBasePage(), boxLocator).getLabels(),
                    should ? hasItem(row.get("field")) : not(hasItem(row.get("field"))));
        }
    }

    // | element | state |
    // state: enabled, disabled, selected, visible, read only, not read only
    @Then("I should see elements on page '$pageName' in the following state: $fieldsTable")
    public void checkElementsState(String pageName, ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String elementName = row.get("element");
            String elementState = row.get("state");
            By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
            String reason = String.format("Is element %s is %s, locator %s", elementName, elementState, elementLocator.toString());
            Control element = new Control(getSut().getPageCreator().getBasePage(), elementLocator);

            boolean actualElementState = false;
            if (elementState.equalsIgnoreCase("enabled")) {
                actualElementState = !element.getAttribute("class").toLowerCase().contains("disabled")
                        && element.isEnabled();
            } else if (elementState.equalsIgnoreCase("disabled")) {
                actualElementState = element.getAttribute("class").toLowerCase().contains("disabled")
                        || !element.isEnabled();
            } else if (elementState.equalsIgnoreCase("selected")) {
                actualElementState = element.isSelected();
            }   else if (elementState.equalsIgnoreCase("unselected")) {
                actualElementState = !(element.isSelected());
            } else if (elementState.equalsIgnoreCase("visible")) {
                actualElementState = element.isVisible();
            } else if (elementState.equalsIgnoreCase("read only")) {
                actualElementState = element.getAttribute("readonly") != null
                        || element.getAttribute("class").contains("dijitReadOnly");
            } else if (elementState.equalsIgnoreCase("not read only")) {
                actualElementState = element.getAttribute("readonly") == null
                        && !element.getAttribute("class").contains("dijitReadOnly");
            } else {
                throw new IllegalArgumentException("Unknown state '" + elementState + "'");
            }
            assertThat(reason, actualElementState, equalTo(true));
        }
    }

    @When("I fill fields on page '$pageName' in the following values: $fieldsTable")
    public void fillFields(String pageName, ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String fieldName = row.get("field");
            String fieldValue = row.get("value");
            By fieldLocator = getSut().getUIMap().getByPageName(pageName, fieldName);
            Edit field = new Edit(getSut().getPageCreator().getBasePage(), fieldLocator); //todo add factory
            field.type(fieldValue);
    //        field.sendKeys(fieldValue);
        }
    }

    @Then("{I |}should see fields on page '$pageName' with following values: $fieldsTable")
    public void checkElementsValues(String pageName, ExamplesTable fieldsTable) {
        for (Map<String, String> row : fieldsTable.getRows()) {
            String fieldName = row.get("field");
            String expectedfieldValue;
            if (fieldName.equals("Email")) {
                String email=row.get("value");
                expectedfieldValue = wrapUserEmailWithTestSession(email);
            }  else {
                expectedfieldValue = row.get("value");
            }
            By fieldLocator = getSut().getUIMap().getByPageName(pageName, fieldName);
            Edit field = new Edit(getSut().getPageCreator().getBasePage(), fieldLocator);
            String actualFieldValue = field.getValue();
            String reason = "Check value of field \"" + fieldName + "\" and locator " + fieldLocator.toString();
            assertThat(reason, actualFieldValue, equalTo(expectedfieldValue));
        }
    }

    @Given("{I |}created file '$filePath' with length '$length' bytes")
    public static void createFile(String filePath, long length) {
        IO.createFileWithLength(getContext().testDataFolderName + filePath, length);
    }

    @Pending
    @When("{I |}press key '$keySequence' on element '$elementName' on page '$pageName'")
    public void presKey(String keySequence, String elementName, String pageName) throws NoSuchFieldException, IllegalAccessException {
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        String[] keys = keySequence.split("\\+");
        WebElement element = getSut().getWebDriver().findElement(elementLocator);
        if (keys.length == 1) {
            Keys controlKey = Keys.valueOf(keys[0].trim());
            element.sendKeys(controlKey);
        } else if (keys.length == 2) {
            Keys controlKey = Keys.valueOf(keys[0].trim());
            element.sendKeys(Keys.chord(controlKey,keys[1].trim()));
        }
    }
    @Then("I should see element '$elementName' with value '$value' on page '$pageName'")
    public void checkElementValue(String elementName, String value, String pageName){
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        WebElement element = getSut().getWebDriver().findElement(elementLocator);
        assertThat(element.getAttribute("value"),equalTo(value));
    }
    @Then("I should see element '$elementName' with text '$value' on page '$pageName'")
    public void checkElementText(String elementName, String value, String pageName){
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        WebElement element = getSut().getWebDriver().findElement(elementLocator);
        assertThat(element.getText().trim(),equalTo(value.trim()));
    }

    @Then("{I |}'$should' see element '$elementName' is selected on page '$pageName'")
    public void checkElementSelecting(String should, String elementName, String pageName) {
        boolean shouldState=should.equals("should");
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        WebElement element = getSut().getWebDriver().findElement(elementLocator);
        assertThat(element.isSelected(),equalTo(shouldState));
        }

    @When("{I |}change fields on page '$pageName' on following values: $fieldsTable")
    public void changeElementsValue(String pageName, ExamplesTable fieldsTable) {
        for (Map<String, String> row : fieldsTable.getRows()) {
            String fieldName = row.get("field");
            String newfieldValue;
            if (fieldName.equals("Email")) {
                String email=row.get("value");
                newfieldValue = wrapUserEmailWithTestSession(email);
            }  else {
                newfieldValue = row.get("value");
            }
            By fieldLocator = getSut().getUIMap().getByPageName(pageName, fieldName);
            getSut().getWebDriver().findElement(fieldLocator).clear();
            getSut().getWebDriver().findElement(fieldLocator).sendKeys(newfieldValue);
        }
    }

    @When("{I |}click on page '$pageName' on following elements: $elementsTable")
    public void clickElements(String pageName, ExamplesTable fieldsTable) {
        for (Map<String, String> row : fieldsTable.getRows()) {
            String elementName = row.get("element");
            By fieldLocator = getSut().getUIMap().getByPageName(pageName, elementName);
            getSut().getWebDriver().findElement(fieldLocator).click();
            Common.sleep(1500);
        }
    }

    @Given("{I |}waited for '$duration' seconds")
    @When("{I |}wait for '$duration' seconds")
    @Then("{I |}wait for '$duration' seconds")
    public void sleep(int duration) {
        Common.sleep(duration * 1000);
    }

    @Then("{I |}'$shouldSee' see '$elementName' element with following text '$text' on page '$pageName'")
    public void checkAppearingTextElement(String shouldSee,String elementName, String text, String pageName){
        boolean should = shouldSee.equals("should");
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        assertThat("Element visible", getSut().getWebDriver().isElementVisible(elementLocator), equalTo(should));
        if (should) {
            WebElement element = getSut().getWebDriver().findElement(elementLocator);
            assertThat(element.getText(), equalTo(text));
        }
    }

    @Then("I should see element '$elementName' on page '$pageName' in following state '$elementState'")
    public void checkElementState(String elementName, String pageName, String elementState) {
        By elementLocator = getSut().getUIMap().getByPageName(pageName, elementName);
        String reason = "Is element " + elementName + " " + elementState + ", locator " + elementLocator.toString();
        Control element = new Control(getSut().getPageCreator().getBasePage(),elementLocator);
        boolean actualElementState = false;
        switch (elementState.toLowerCase()) {
            case "enabled":
                actualElementState = !element.getAttribute("class").toLowerCase().contains("disabled") || element.isEnabled();
                break;
            case "disabled":
                actualElementState = element.getAttribute("class").toLowerCase().contains("disabled") || !element.isEnabled();
                break;
            case "selected":
                actualElementState = element.isSelected();
                break;
            case "visible":
                actualElementState = element.isVisible();
                break;
            case "invisible":
                actualElementState = !element.isVisible();
                break;
        }
        assertThat(reason, actualElementState, equalTo(true));
    }

    @When("I open url '$url'")
    public void openUrl(String url) {
        getSut().getWebDriver().get(url);
    }

    @Then("I '$condition' see that current url is '$partUrl'")
    public void checkCurrentUrl(String condition, String partUrl) {
        String url = TestsContext.getInstance().applicationUrl + partUrl;
        Matcher<String> matcher = condition.equalsIgnoreCase("should") ? equalTo(url) : not(equalTo(url));
        assertThat(getSut().getWebDriver().getCurrentUrl(), matcher);
    }

    @Then("I '$condition' see that header logo is default")
    public void checkHeaderLogo(String condition) {
        BasePage basePage = new BasePage(getSut().getWebDriver());
        assertThat(basePage.getHeaderLogoSrcAttribute().contains("header_a5_logo.png"), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("I '$condition' see that header has next color '$color'")
    public void checkHeaderColor(String condition, String color) {
        Common.sleep(1000);
        BasePage basePage = new BasePage(getSut().getWebDriver());
        assertThat(basePage.getHeaderStyleAttributeValue().contains(color), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' see that header with background color '$expectedColor'")
    public void checkHeaderBGColor(String condition, String expectedColor) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualColor = new BasePage(getSut().getWebDriver()).getHeaderBGColorValue();

        assertThat(actualColor, shouldState ? equalTo(expectedColor) : not(equalTo(expectedColor)));
    }

    @Given("I saved current url as scenario value with key '$key'")
    @When("I save current url as scenario value with key '$key'")
    public void saveCurrentURLAsScenarioValues(String key) {
        getData().addScenarioValue(key, getSut().getWebDriver().getCurrentUrl());
    }

    @When("I open url '$key' from scenario values")
    public void openUrlFromScenarioValues(String key) {
        getSut().getWebDriver().get(getData().getScenarioValue(key));
    }

    @Given("{I |}setted expired password for current user '$days' before today")
    @When("{I |}set expired password for current user '$days' before today")
    public void setExpiredPassword(int days) {
        String userEmail = getCoreApi().getCurrentUser().getEmail();
        DBCollection schemaCollection = getMongoDB().getCollection("user");
        BasicDBObject query = new BasicDBObject();
        query.put("_cm.common.email", userEmail);
        BasicDBObject filter = new BasicDBObject();
        filter.append("$set", new BasicDBObject().append("passwordExpirationDate", DateTime.now().minusDays(days).toDate()));
        schemaCollection.update(query, filter);
    }

    @Given("I have enabled the Asset Usage rights expiry job to run every 2 mins")
    @When("I have enable the Asset Usage rights expiry job to run every 2 mins")
    public void setUsageRightsExpiryJob() {
        DBCollection schemaCollection = getMongoDB().getCollection("settings");
        BasicDBObject query = new BasicDBObject();
        query.put("jobs.name", "UsageRightsExpiryNotification");
        BasicDBObject filter = new BasicDBObject();
        filter.append("$set", new BasicDBObject().append("jobs.$.cron", "0 0/2 * * * ?"));
        schemaCollection.update(query, filter);
    }

    @Given("I have enabled the Category Updated job to run every 1 min")
    @When("I have enable the Category Updated job to run every 1 min")
    public void setCategoryUpdatedJob() {
        DBCollection schemaCollection = getMongoDB().getCollection("settings");
        BasicDBObject query = new BasicDBObject();
        query.put("jobs.name", "CategoryStatisticsCalculationJob");
        BasicDBObject filter = new BasicDBObject();
        filter.append("$set", new BasicDBObject().append("jobs.$.cron", "0 0/1 * * * ?"));
        schemaCollection.update(query, filter);
    }

    //Copies the auto script file from codebase to FTP location and runs it
    @When("{I |}'$action' the file using '$autoScriptfileName' at '$ftpgridLocation'")
    public void addAndRunAutoScript(String action, String autoScript ,String ftpgridLocation) {
        WiniumFTPRemote r = new WiniumFTPRemote(getSut().getWebDriver());
        r.ftpAndExecuteAutoScripts(autoScript,ftpgridLocation);
    }

    //Start and stops the winium service.
    @Given("{I |'$winiumService' the winium service")
    @When("{I |}'$winiumService' the winium service")
    @Then("{I |}'$winiumService' the winium service")
    public void stopWinumService(String winiumService){
        WiniumFTPRemote r = new WiniumFTPRemote(getSut().getWebDriver());
        String winiumStopCommand = "taskkill /F /IM Winium.Desktop.Driver.exe";
        String  winiumStartCommand = "cmd /k C:\\winium\\Winium.Desktop.Driver.exe";

        if(winiumService.equalsIgnoreCase("stop")) {
            //isSession is set to null by default as the winium start service is not used
            r.winiumService(null, winiumStopCommand);
        }else{//To Do : This is temporarily not used as the winium start triggers the process in backend on remote machine
           // r.winiumService(null, winiumStartCommand);
        }
    }

    public static void removeXMPMappingFromMongo() {
        getMongoDB().getCollection("xml_json_map").drop();
    }

    @Then("{I |}should see following title '$title' of new window")
    public void checkTitleOfNewWindow(String title) {
        assertThat("Check title of new window: ", getSut().getWebDriver().switchToNewWindow().getTitle(), equalTo(title));
    }

    @Then("{I |}'$condition' able to see and access element '$elementName' on page '$pageName'")
    public void checkAccessOfElement(String condition,String elementName, String pageName) {
        ExamplesTable elementsTable = new ExamplesTable(String.format("|element|\n|%s|", elementName));
        By elementLocator = null;
        boolean should = condition.equals("should");
        for (Map<String, String> row : elementsTable.getRows()) {
            if(pageName.equalsIgnoreCase("Roles"))
                elementLocator = By.xpath("//span[contains(.,'Create new Role')]");
            else
                elementLocator = getSut().getUIMap().getByPageName(pageName, row.get("element"));
            assertThat("Is element " + row.get("element") + " visible, locator " + elementLocator.toString(),
                    getSut().getWebDriver().isElementVisible(elementLocator),
                    equalTo(should));
            if (getSut().getWebDriver().isElementVisible(elementLocator)) {
                getSut().getWebDriver().click(elementLocator);
                Common.sleep(2500);
                assertThat("Is element " + row.get("element") + " accessible",
                        getSut().getWebDriver().isElementVisible(By.xpath(String.format("//body[@class='%s'][contains(@id,'adstream_navigator_Controller_')]", elementName.toLowerCase()))),
                        equalTo(should));
            }
        }
    }

    @Then("{I |}'$condition' see the link '$linkName' on landing page")
    public void checkLibraryOnLandinPage(String condition,String linkName) {
        boolean shouldState=condition.equals("should");
        By elementLocator = By.xpath("//a[.='" + linkName + "']");
        assertThat("Is Library link visible",
                getSut().getWebDriver().isElementVisible(elementLocator),shouldState ? is(true) :is(false));

    }
}