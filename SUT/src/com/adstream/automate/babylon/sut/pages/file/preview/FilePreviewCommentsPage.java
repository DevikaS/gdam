package com.adstream.automate.babylon.sut.pages.file.preview;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: lynda-k
 * Date: 25.12.13
 * Time: 12:00
 */
public class FilePreviewCommentsPage extends FilePreviewPage {

    public FilePreviewCommentsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void typeComment(String value) {
        web.typeClean(getCommentFieldLocator(), value);
    }

    public void typeReplyComment(String value) {
        web.typeClean(getReplyCommentFieldLocator(), value);
    }

    public void clickCommentButton() {
        web.click(getCommentButtonLocator());
    }

    public void clickReplyButton() {
        web.click(getReplyButtonLocator());
    }

    public void clickReplyLink(String content) {
        web.click(getReplyLinkLocatorByContent(content));
    }

    public int getCommentsCount() {
        By locator = By.className("comment_answer");
        return web.isElementPresent(locator) ? web.findElements(locator).size() : 0;
    }

    public List<Map<String,String>> getCommentsList() {
        web.navigate().refresh();
        List<Map<String,String>> comments = new ArrayList<>();

        List<String> userNames = web.isElementPresent(getCommentsUserNamesLocator())
                ? web.findElementsToStrings(getCommentsUserNamesLocator()) : new ArrayList<String>();
        List<String> contents = web.isElementPresent(getCommentsContentsLocator())
                ? web.findElementsToStrings(getCommentsContentsLocator()) : new ArrayList<String>();
        List<String> dates = web.isElementPresent(getCommentsDatesLocator())
                ? web.findElementsToStrings(getCommentsDatesLocator()) : new ArrayList<String>();

        for (int i = 0; i < getCommentsCount(); i++) {
            Map<String,String> comment = new HashMap<>();
            comment.put("UserName", userNames.get(i));
            comment.put("Content", contents.get(i));
            comment.put("Date", dates.get(i).split(" ")[0]);
            comments.add(comment);
        }

        return comments;
    }

    private By getCommentFieldLocator() {
        return By.name("text");
    }

    private By getReplyCommentFieldLocator() {
        return By.cssSelector(".reply_form [name='text']");
    }

    private By getCommentButtonLocator() {
        return By.cssSelector(".comment_form:not(.reply_form) .button");
    }

    private By getReplyButtonLocator() {
        return By.xpath("//*[contains(@class,'button') and contains(.,'Reply')]");
    }

    private By getCommentsUserNamesLocator() {
        return By.cssSelector("[id*='files_comments'] .blue");
    }

    private By getCommentsContentsLocator() {
        return By.cssSelector("[id*='files_comments'] .comment_text .p");
    }

    private By getCommentsDatesLocator() {
        return By.cssSelector("[id*='files_comments'] .date");
    }

    private By getReplyLinkLocatorByContent(String content) {
        return By.xpath(String.format("//*[contains(@class,'text') and contains(.,'%s')]//*[@name='reply']", content));
    }
}
