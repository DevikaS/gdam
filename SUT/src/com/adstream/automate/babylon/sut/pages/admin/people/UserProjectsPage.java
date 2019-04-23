package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 17.04.14
 * Time: 13:01
 */
public class UserProjectsPage extends UsersPage {
    private static final By PROJECTS_LIST_CONTAINER = By.cssSelector("[data-role='peopleProjectsList']");

    public UserProjectsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(PROJECTS_LIST_CONTAINER);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(PROJECTS_LIST_CONTAINER));
    }

    public List<Map<String,String>> getVisibleProjectFields(List<String> fields) {
        List<Map<String,String>> projectFieldsList = new ArrayList<Map<String,String>>();

        List<String> names = web.findElementsToStrings(By.cssSelector("#selectedUser .itemsList .row .size4of5 > a"));
        List<String> logos = new ArrayList<String>();
        if (fields.contains("Logo")) logos = web.findElementsToStrings(By.cssSelector("#selectedUser .itemsList .row img.mts"), "src");

        List<String> jobNumbers = new ArrayList<String>();
        if (fields.contains("JobNumber")) jobNumbers = web.findElementsToStrings(By.cssSelector("#selectedUser .itemsList .row .size3of5 > a"));

        for (int i = 0; i < names.size(); i++) {
            Map<String,String> projectFields = new HashMap<String, String>();
            if (fields.contains("Logo")) projectFields.put("LogoSize", Integer.toString(getDataByUrl(logos.get(i)).length));
            if (fields.contains("JobNumber")) projectFields.put("JobNumber", jobNumbers.get(i));
            if (fields.contains("ProjectName")) projectFields.put("ProjectName", names.get(i));
            projectFieldsList.add(projectFields);
        }

        return projectFieldsList;
    }

    public List<Map<String,String>> getFullMapOfVisibleProjectFields(List<String> fields) {
        List<Map<String,String>> projects = getVisibleProjectFields(fields);

        while (isNextButtonActiveOnUserDetails()) {
            clickNextButtonOnUserDetails();
            projects.addAll(getVisibleProjectFields(fields));
        }

        return projects;
    }

    public int getVisibleProjectsCount() {
        By locator = By.cssSelector("#peopleSelectedUserContent .row");
        return web.isElementPresent(locator) ? web.findElements(locator).size() : 0;
    }

    public int getVisibleProjectsPageNumber() {
        String pageNumber = web.findElement(By.cssSelector("#selectedUser .current")).getText().trim();
        return Integer.parseInt(pageNumber.split("\\s")[1]);
    }
}