package com.adstream.automate.babylon.sut.pages.adbank.dashboard;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddNewPresentationPopUpWindow;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 08.02.12
 * Time: 20:02
 */
public class AdbankDashboardPage extends BaseAdBankPage<AdbankDashboardPage> {
    public AdbankDashboardPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("#app-menu"));
        web.waitUntilElementAppearVisible(By.cssSelector("#app-main"));
        web.waitUntilElementAppearVisible(By.cssSelector(".app-menu.nav"));
        web.waitUntilElementAppearVisible(By.cssSelector("#app-main .dashboard"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("#app-menu")));
        assertTrue(web.isElementVisible(By.cssSelector("#app-main")));
        assertTrue(web.isElementVisible(By.cssSelector(".app-menu.nav")));
        assertTrue(web.isElementVisible(By.cssSelector("#app-main .dashboard")));
    }

    public void typeFilterUserName(String name) {
        web.typeClean(By.xpath("//*[@data-role='userIdSelect']"), name);
        web.click(By.cssSelector("#adbank_shared_Autocomplete_0_popup0"));
    }

    public void clickFilterOnRecentActivitySection(){
        web.click(By.xpath(String.format("//span[contains(@data-role, 'activityFilterButton')]")));
    }

    public void clickCancelOnRecentActivitySection(){
        web.click(By.xpath(String.format("//span[contains(@data-role, 'activityCancelButton')]")));
    }

    public DojoCombo activityTypeBox;

    public void setActivityType(String activityType) {
        activityTypeBox.selectByVisibleText(activityType);
    }

    @Override
    public void init() {
        super.init();
        this.activityTypeBox = new DojoCombo(this, By.xpath("//*[@data-role='projectPanel']//*[@role='listbox']"));
    }

    public int getActivityItemsCount() {
        return web.findElementsToStrings(getRecentActivitiesLocator()).size();
    }

    public List<String> getRecentActivitiesList() {
        List<String> activities = new ArrayList<>();
        if (web.isElementPresent(getRecentActivitiesLocator())) {
            for (WebElement element : web.findElements(getRecentActivitiesLocator())) {
                activities.add(element.getText().replaceAll("\n.*$", "").replaceAll("\n", " "));
            }
        }
        return activities;
    }

    public List<String> getFilesFromProjectFilesSection() {
        By locator = By.cssSelector("[id*='dashboard_project_files'] .file-info a");
        return web.findElementsToStrings(locator, "innerHTML");
    }

    public List<String> getFilesFromLibraryFilesSection() {
        By locator = By.cssSelector("[id*='libraryFilesField'] .file-info a");
        return web.findElementsToStrings(locator, "innerHTML");
    }

    public List<String> getProjectsFromProjectsSection() {
        return web.findElementsToStrings(By.cssSelector("[id*='projects_list'] .row > .cell > .pls > .project_link"));
    }

    public List<String> getPresentationsFromPresentationsSection() {
        return web.findElementsToStrings(By.cssSelector(".pas .file-preview + .inline-block a"));
    }

    public List<String> getQuickStartLinksList() {
        return web.findElementsToStrings(By.cssSelector(".pas.white a"));
    }

    public String getPresentationAssetsCount(String presentationName) {
        String assetCounterText = web.findElement(By.xpath(String.format(
                "//*[contains(@class,'mls')][*/*[text()='%s']]//*[contains(@class,'tiny-text')]", presentationName))).getText();
        Matcher m = Pattern.compile("(\\d+)").matcher(assetCounterText);

        if (!m.find()) throw new IllegalStateException(String.format(
                    "Invalid asset counter '%s' for presentation '%s'", assetCounterText, presentationName));
        return m.group(1);
    }

    public String getPresentationTotalDuration(String presentationName) {
        return web.findElement(By.xpath(String.format(
                "//*[contains(@class,'phs')][*[contains(@class,'unit')]//*[.='%s']]//*[contains(.,'Duration')]/following-sibling::*",
                presentationName))).getText().trim();
    }

    public List<String> getApprovalsFileList() {
        return web.findElementsToStrings(By.cssSelector("[id*='adbank_dashboard_my_approvals'] .approval-item a"));
    }

    public String getPageCounterValue() {
        return web.findElement(By.cssSelector(".counterItems")).getText().trim();
    }

    public String getPageCounterActivities() {
        return web.findElement(By.cssSelector("[data-id=\"itemsCounterScroll\"]")).getText().trim();
    }

    public void clickStartNewProjectLink() {
        web.click(By.linkText("Start a new project"));
    }

    public void clickGoToTopButton() {
        web.click(By.cssSelector(".button-to-top"));
        web.sleep(2000);
    }

    public void clickSectionMinimizeButton(String section) {
        web.click(getSectionMinimizeButtonLocator(section));
        web.sleep(500);
    }

    public void clickSectionMaximizeButton(String section) {
        web.click(getSectionMaximizeButtonLocator(section));
        web.sleep(500);
    }

    public void clickExpandedLinkOnSection(String link, String section) {
        web.findElement(getCollapsedSectionLocator(section)).findElement(By.linkText(link)).click();
        web.sleep(500);
    }

    public void clickAssetThumbnailOnFilesSection(String sectionName, String asset) {
        Map<String,String> sectionLocatorMap = new HashMap<String,String>() { {
            put("Files in your projects", "//*[contains(@data-dojo-type,'project_files')]//a[normalize-space()='%s']");
            put("Latest Library Uploads", "//*[contains(@data-dojo-type,'libraryFiles')]//a[normalize-space()='%s']");} };
        web.clickThroughJavascript(By.xpath(String.format(sectionLocatorMap.get(sectionName), asset)));
    }

    public void clickFileLinkOnRecentActivitySection(String assetName, String activityMessage) {
        String xpath = String.format("//*[@data-type='tableRow'][.//*[contains(text(),'%s')]]//a[contains(text(),'%s')]", activityMessage, assetName);
        web.clickThroughJavascript(By.xpath(xpath));
    }

    public void clickPresentationOnPresentationsSection(String presentationName) {
        web.click(By.xpath(String.format("//*[contains(@class,'approval-item')]//a[.='%s']", presentationName)));
    }

    public void clickFileLinkOnApprovalsSection(String fileName) {
        web.click(By.xpath(String.format(
                "//*[contains(@id,'adbank_dashboard_my_approvals')]//*[contains(@class,'approval-item')]//a[.='%s']",
                fileName)));
    }

    public void openDelivery() {
        web.click(getNavigationTabLocator("Delivery"));
        web.sleep(1000);
    }

    public void switchSectionTab(String tab, String section) {
        web.click(By.xpath(getSectionTabXpath(tab, section)));
        web.sleep(500);
    }

    public void openUploadYourLibraryLinkInCurrentWindow() {
        String linkId = web.findElement(By.cssSelector("[data-dojo-type='common.plupload.noModalWindow']")).getAttribute("id");
        String script = String.format("var p = dojo.dijit.registry.byId('%s'); return p.src+'?'+p.getParams();", linkId);
        String plUploaderURL = (String)web.getJavascriptExecutor().executeScript(script);

        Pattern p = Pattern.compile("(https?://[\\w\\d\\-.:]+?)/");
        Matcher m = p.matcher(web.getCurrentUrl());

        if (m.find()) {
            web.navigate().to(m.group(1) + plUploaderURL);
        } else {
            throw new IllegalStateException(String.format("Invalid app url: '%s'", web.getCurrentUrl()));
        }
    }

    public void openExploreYourLibraryLink() {
        web.click(By.linkText("Explore your library"));
    }

    public AddNewPresentationPopUpWindow clickLinkCreateNewPresentation() {
        web.click(By.linkText("Create a new presentation"));
        return new AddNewPresentationPopUpWindow(this);
    }

    public void fillNewPresentationPopup(String presentationName, String description) {
        AddNewPresentationPopUpWindow popup = new AddNewPresentationPopUpWindow(this);
        popup.setName(presentationName);
        popup.setDescription(description);
        popup.action.click();
    }

    public void scrollDownToFooter() {
        web.scrollToElement(web.findElement(By.cssSelector(".footer.clearfix")));
        web.sleep(2000);
    }

    public boolean isItemsCounterVisible() {
        By locator = By.cssSelector(".fixed-informer");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isSectionCollapsed(String section) {
        return web.isElementVisible(getCollapsedSectionLocator(section));
    }
    //NGN-18839 GDAm Checklist Automation Code starts
    public boolean isBeemReelsExist() {
        return (web.findElement(By.xpath(".//*[@id='app-view']/div/div[2]/div[2]/div[1]/div/div[3]/div[1]/div[1]/div/span[1]")).getText().trim()).equalsIgnoreCase("BeamReels");
    }

    public boolean isCustomLogoExist(String client) {
        if(client.equalsIgnoreCase("Schawk")){
            return (web.findElement(By.cssSelector(".headerLogo")).getAttribute("src").trim()).equalsIgnoreCase("data:image/png;base64,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");
        }else if(client.equalsIgnoreCase("Beam")){
            return (web.findElement(By.cssSelector(".headerLogo")).getAttribute("src").trim()).equalsIgnoreCase("data:image/png;base64,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");
        }else if(client.equalsIgnoreCase("ElizabethArden")){
            return (web.findElement(By.cssSelector(".headerLogo")).getAttribute("src").trim()).equalsIgnoreCase("data:image/png;base64,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");
        }else if(client.equalsIgnoreCase("CustomBranding")){
            if((web.findElement(By.cssSelector(".headerLogo")).getAttribute("src").trim()).equalsIgnoreCase("data:image/png;base64,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")
                    &&(web.getTitle().equalsIgnoreCase("QA Beware!"))) {
                return true;
            }else{
                return false ;
            }
        }else if(client.equalsIgnoreCase("CustomBeamBranding")){
            if((web.findElement(By.cssSelector(".headerLogo")).getAttribute("src").trim()).equalsIgnoreCase("data:image/png;base64,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")
                    &&(web.getTitle().equalsIgnoreCase("QABeam Beware!"))) {
                return true;
            }else {
                return false;
            }
            }else{
           return false ;
        }
    }

    public boolean  isCustomBrandingFooter(){
        if (web.findElement(By.cssSelector(".footer.clearfix.blue")).getAttribute("style").contains("rgb(221, 9, 136)")&&web.findElement(By.cssSelector(".footer.clearfix.blue")).getAttribute("style").contains("rgb(12, 13, 14)"
        )                &&(web.findElement(By.xpath(".//*[@id='app-footer']/div/div[1]/span")).getText().equalsIgnoreCase("QA across the universe"))){
            return true;
        } else {
            return false;
        }
    }

    public boolean  isCustomBeamBrandingFooter(){
        if (web.findElement(By.cssSelector(".footer.clearfix.blue")).getAttribute("style").contains("rgb(36, 173, 207)")&&web.findElement(By.cssSelector(".footer.clearfix.blue")).getAttribute("style").contains("rgb(151, 204, 120)"
        )                &&(web.findElement(By.xpath(".//*[@id='app-footer']/div/div[1]/span")).getText().equalsIgnoreCase("QA across the universe"))){
            return true;
        } else {
            return false;
        }
    }
    public boolean isCustomBrandingHeader(){
        return web.findElement(By.cssSelector("[data-dojo-type='common.agencyHeader']")).getAttribute("style").contains("rgb(221, 9, 136)");
    }
    public boolean isCustomBeamBrandingHeader(){
        return web.findElement(By.cssSelector("[data-dojo-type='common.agencyHeader']")).getAttribute("style").contains("rgb(54, 97, 162)");
    }
    //NGN-18839 GDAm Checklist Automation Code Ends
    public boolean isSectionExpanded(String section) {
        return web.isElementVisible(getExpandedSectionLocator(section));
    }

    public boolean isSectionPresent(String section) {
        return web.isElementVisible(getSectionLocator(section));
    }

    public boolean isLinkPresentOnCollapsedSection(String linkText, String section) {
        return !web.findElement(getCollapsedSectionLocator(section)).findElements(By.linkText(linkText)).isEmpty();
    }

    public boolean isTextPresentOnExpandedSection(String text, String section) {
        String sectionText = web.findElement(getExpandedSectionLocator(section)).findElement(By.cssSelector(".center")).getText().trim();
        return sectionText.equalsIgnoreCase(text);
    }

    public boolean isSectionTabActive(String tab, String section) {
        return web.findElement(By.xpath(getSectionTabXpath(tab, section))).getAttribute("class").contains("active");
    }

    public void clickByLastTermsAndConditionInActivity() {
        web.click(By.cssSelector("[data-dojo-type='adbank.project.termsAndConditions_button']"));
    }

    public void clickLinkActivity(String link) {
        WebElement element = web.findElements(By.cssSelector(".clearfix.bottom .lastUnit .unit a.h4")).get(Integer.parseInt(link));
        element.click();
    }

    public boolean isMenuLinkVisible(String linkText) {
        return web.isElementVisible(By.linkText(linkText));
    }

    private By getSectionMinimizeButtonLocator(String section) {
        return By.xpath(String.format("%s//*[contains(@class,'minimaze-button')]", getSectionXpath(section)));
    }

    private By getSectionMaximizeButtonLocator(String section) {
        return By.xpath(String.format("%s//*[contains(@class,'maximaze-button')]", getSectionXpath(section)));
    }

    private By getCollapsedSectionLocator(String section) {
        return By.xpath(String.format("%s//*[contains(@class,'dashboard-box-collapsed')]", getSectionXpath(section)));
    }

    private By getExpandedSectionLocator(String section) {
        return By.xpath(String.format("%s//*[contains(@class,'dashboard-box')]", getSectionXpath(section)));
    }

    private By getSectionLocator(String section) {
        return By.xpath(getSectionXpath(section));
    }

    private By getRecentActivitiesLocator() {
        return  By.cssSelector("[data-dojo-type='adbank.dashboard.activities_list'] .row");
    }

    private String getSectionXpath(String section) {
        if (section.equalsIgnoreCase("approvals")) {
            return "//div[@data-dojo-type='adbank.dashboard.my_approvals']";
        } else if (section.equalsIgnoreCase("files in your projects")) {
            return "//div[@data-dojo-type='adbank.dashboard.project_files']";
        } else if (section.equalsIgnoreCase("my projects")) {
            return "//div[@data-dojo-type='adbank.dashboard.projects_list']";
        } else if (section.equalsIgnoreCase("recent activity")) {
            return "//div[contains(@class, 'dashboard-toggle-block mtm phm') and descendant::span[text()='Recent Activity']]";
        } else if (section.equalsIgnoreCase("presentations")) {
            return "//div[contains(@class, 'dashboard-toggle-block mtm') and descendant::span[text()='Presentations']]";
        } else if (section.equalsIgnoreCase("latest library uploads")) {
            return "//div[contains(@class, 'dashboard-toggle-block mtm') and descendant::span[text()='Latest Library Uploads']]";
        } else {
            throw new IllegalArgumentException(String.format("Unknown section name '%s' for dashboard page", section));
        }
    }

    private String getSectionTabXpath(String tab, String section) {
        String tabClass = null;

        if (section.equalsIgnoreCase("files in your projects")) {
            if (tab.equalsIgnoreCase("latest files added")) {
                tabClass = "latest-files";
            } else if (tab.equalsIgnoreCase("latest added by you")) {
                tabClass = "your-files";
            }
        } else if (section.equalsIgnoreCase("approvals")) {
            if (tab.equalsIgnoreCase("submitted")) {
                tabClass = "submitted";
            } else if (tab.equalsIgnoreCase("received")) {
                tabClass = "pending";
            }
        }

        if (tabClass == null)
            throw new IllegalArgumentException(String.format("Unknown tab name '%s' for section '%s'", tab, section));

        return String.format("%s//*[contains(@class,'%s')]", getSectionXpath(section), tabClass);
    }

    private By getNavigationTabLocator(String name) {
        return By.xpath("//*[contains(@class,'app-menu')]//a[.='" + name + "']");
    }


    /**
     * @author a.sobolev 27.10.2014
     * New inner class DashboardActivityFilter for DashboardPage
     * If we want to create ActivityFilter object, we need to pass
     * DashboardPage object to DashboardActivityFilter constructor.
     */

    public class DashboardActivityFilter {
        private DojoCombo action;
        private AdbankDashboardPage page;

        public DashboardActivityFilter(AdbankDashboardPage page) {
            action = new DojoCombo(page, By.cssSelector(".lib-select.dijitSelect"));
            this.page = page;
        }

        public void chooseFilter(String actionValue, String user) {
            action = new DojoCombo(this.page, By.cssSelector("[data-role='actionTypeSelect']"));
            action.selectByVisibleText(actionValue);
            Common.sleep(1000);
            if (user.isEmpty()) {
                clearUserField();
            }
            web.findElement(getUserFieldLocator()).sendKeys(user);
            Common.sleep(1000);
            web.click(getButtonFilterLocator());
            Common.sleep(1000);
        }

        public void clearUserField() {
            web.findElement(getUserFieldLocator()).clear();
        }

        private By getUserFieldLocator() {
            return By.cssSelector("[data-role='userIdSelect']");
        }

        private By getButtonFilterLocator() {
            return By.cssSelector("[data-role='activityFilterButton']");
        }
    }
}