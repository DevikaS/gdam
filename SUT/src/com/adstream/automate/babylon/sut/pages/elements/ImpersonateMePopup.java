package com.adstream.automate.babylon.sut.pages.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * User: lynda-k
 * Date: 04.03.14
 * Time: 13:30
 */
public class ImpersonateMePopup extends PopUpWindow {
    public ImpersonateMePopup(Page parentPage) {
        super(parentPage);
        web.waitUntilElementAppearVisible(generateLocator());
    }

    public void setUser(String name, String email) {
        fillUserTextbox(name);
        web.click(By.xpath(String.format("//*[@role='option'][contains(.,'%s')][last()]", email)));
    }

    public void typeComment(String comment) {
        new Edit(parentPage, web.findElement(By.xpath("//textarea[contains(@name,'gaComment')]"))).type(comment);
    }

    public void typeEmail(String email) {
        fillUserTextbox(email);
       // new Edit(parentPage, web.findElement(By.xpath("//*[@role='option'][contains(.,'%s')][last()]"))).type(email);
    }

    public void fillUserTextbox(String value) {
        if (web.isElementPresent(generateLocator("[role='textbox']"))) {
            new Edit(parentPage, generateLocator("[role='textbox']")).typeWithInterval(value, 100);
        }
        else {
            new Edit(parentPage, web.findElement(By.xpath("//input[contains(@data-dojo-type, 'common.globalAdmin.impersonateEmail')]"))).typeWithInterval(value, 100);
        }

        web.sleep(500);
    }

    public List<String> getAvailableUserEmailsList() {
        List<String> result = new ArrayList<String>();

        for (String option : web.findElementsToStrings(By.cssSelector("[role='option']"))) {
            Matcher m = Pattern.compile("([\\w\\.\\+\\-]+@[\\w\\.\\+\\-]+)").matcher(option);
            if (m.find()) result.add(m.group(1));
        }
        return result;
    }
}
