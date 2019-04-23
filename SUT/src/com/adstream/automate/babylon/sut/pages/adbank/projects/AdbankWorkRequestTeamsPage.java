package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdBankTeamsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 18.05.12 20:22
 */
public class AdbankWorkRequestTeamsPage extends AdBankTeamsPage {
    public AdbankWorkRequestTeamsPage(ExtendedWebDriver web) {
        super(web);
    }


    private By getActivitiesLocatorCss() {
        return By.cssSelector(".unit.size5of6");
    }

    public List<String> getActivityList() {
        List<String> activities = new ArrayList<>();
        for (WebElement activityContainer : web.findElements(getActivitiesLocatorCss())) {
            activities.add(activityContainer.getText().replaceAll("\n", " "));
        }

        return activities;
    }
}
