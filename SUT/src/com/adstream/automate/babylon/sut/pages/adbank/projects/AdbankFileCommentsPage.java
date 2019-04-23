package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileViewPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 03.10.12
 * Time: 17:42
 */
public class AdbankFileCommentsPage extends AdbankFileViewPage {
    public AdbankFileCommentsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(By.cssSelector("[data-dojo-type='adbank.files.comments'] > div"));
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[data-dojo-type='adbank.files.comments'] > div")));
    }

    public void clickComment() {
        web.click(By.cssSelector(".comment_form:not(.reply_form) .button"));
    }

    public void typeComment(String value) {
        web.typeClean(By.cssSelector("[name='text']"), value);
    }

    public boolean isCommentTextAreaVisible() {
        return web.isElementPresent(By.cssSelector("[name='text']")) && web.isElementVisible(By.cssSelector("[name='text']"));
    }

    public List<String> getListOfUsersWhoPostedComments() {
        return web.findElementsToStrings(By.cssSelector(".size1of1.clearfix.comment_answer.ptm.pbs .blue"));
    }

    public List<String> getListOfPostedComments() {
        web.sleep(2000);
        if (web.isElementPresent(By.cssSelector(".size1of1.comment_text.ptxs .p"))) {
            return web.findElementsToStrings(By.cssSelector(".size1of1.comment_text.ptxs .p"));
        } else {
            return new ArrayList<>();
        }
    }

    public List<String> getListOfChildComments() {
        return web.findElementsToStrings(By.cssSelector(".pll .size1of1.clearfix.comment_answer.ptm.pbs .p"));
    }

    public List<String> getListOfCommentDates() {
        List<String> result = new ArrayList<>();
        for (String date : web.findElementsToStrings(By.cssSelector(".date.prs")))
            result.add(date.replaceAll("([aA]|[pP])\\.([mM])\\.", "$1$2"));
        return result;
    }

    public void clickReplyLink(String commentId) {
        web.click(By.cssSelector("[data-reply='" + commentId + "']"));
    }

    public boolean isReplyLinkVisible(String commentId) {
        return web.isElementPresent(By.cssSelector("[data-reply='" + commentId + "']")) && web.isElementVisible(By.cssSelector("[data-reply='" + commentId + "']"));
    }

    public void typeReplyText(String commentId, String text) {
        web.typeClean(By.cssSelector("[data-reply='" + commentId + "'] [name='text']"), text);
    }

    public boolean isReplyTextVisible(String commentId) {
        return web.isElementPresent(By.cssSelector("[data-reply='" + commentId + "'] [name='text']")) && web.isElementVisible(By.cssSelector("[data-reply='" + commentId + "'] [name='text']"));
    }

    public void clickReplyButton(String commentId) {
        By locator = By.cssSelector("[data-reply='" + commentId + "'] .button.small");
        web.click(locator);
        web.waitUntilElementDisappear(locator);
    }

    public boolean isReplyButtonVisible(String commentId) {
        return web.isElementPresent(By.cssSelector("[data-reply='" + commentId + "'] .button.small")) && web.isElementVisible(By.cssSelector("[data-reply='" + commentId + "'] .button.small"));
    }

    public void clickRemoveLink(String commentId) {
        By locator = By.cssSelector("[data-remove='" + commentId + "']");
        web.click(locator);
        web.waitUntilElementDisappear(locator);
    }

    public boolean isRemoveLinkVisible(String commentId) {
        return web.isElementPresent(By.cssSelector("[data-remove='" + commentId + "']")) && web.isElementVisible(By.cssSelector("[data-remove='" + commentId + "']"));
    }

    public List<String> getDeletedComments() {
        return web.findElementsToStrings(By.cssSelector(".phm.pvs.mlxs"));
    }

    public List<byte[]> getListLogoOnPopup() {
        List<byte[]> result = new ArrayList<>();
        List<String> listOfLogoSrc = new ArrayList<>();
        for (WebElement webElement: web.findElements(By.cssSelector(".avatar.small.mrm.mls img"))) {
            listOfLogoSrc.add(webElement.getAttribute("src"));
        }
        for (String element: listOfLogoSrc) {
            result.add(getDataByUrl(element));
        }
        return result;
    }



}
