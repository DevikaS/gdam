package com.adstream.automate.babylon.sut.pages.file.preview;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

public class AnnotationsPage extends BasePage {

    public AnnotationsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void clickOnPlayButton() {
        web.clickThroughJavascript(By.xpath("//*[@id='controls-container']/vg-play-pause-button/button"));
    }
    public void clickOnNewAnnotationButton() {
        Common.sleep(3000);
        web.clickThroughJavascript(By.xpath("//*[@id='no-annotations']//button"));
    }
    public void writeCommentInCommentsSection(String notes) {
        WebElement element = web.findElement(By.cssSelector("textarea[ng-model='data.annotations.data.active.annotation.Text']"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
        web.getJavascriptExecutor().executeScript("angular.element(arguments[0]).scope().data.annotations.data.active.annotation.Text = '"+notes+"';" +
                "angular.element(document.body).injector().get('$rootScope').$apply();", element);

        Common.sleep(2000);
    }
    public void editCommentInEditAnnotationSection(String notes) {
        WebElement element = web.findElement(By.cssSelector("textarea[ng-model='data.annotations.data.active.annotation.Text']"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
        web.getJavascriptExecutor().executeScript("angular.element(arguments[0]).scope().data.annotations.data.active.annotation.Text = '"+notes+"';" +
                "angular.element(document.body).injector().get('$rootScope').$apply();", element);
    }

    public void clickOnSaveButtonEditAnnotationSection() {
        WebElement element = web.findElement(By.cssSelector(".edit-annotation button.save"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
        Common.sleep(2000);
    }
    public void clickOnSaveButton() {
        WebElement element = web.findElement(By.cssSelector(".new-annotation-actions .save"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",element);
        Common.sleep(2000);
    }
    public void clickOnCancelButton() {
        web.clickThroughJavascript(By.cssSelector(".edit-annotation button.cancel"));
    }
    public void clickOnEditIcon() {
        web.clickThroughJavascript(By.cssSelector("#selected-annotation button[title='Edit Annotation']"));
    }
    public void clickOnDeleteIcon() {
        web.clickThroughJavascript(By.cssSelector("#selected-annotation button.annotation-button[title='Delete Annotation']"));
        web.switchTo().alert().accept();
    }
    public String annotationsCount() {
        return web.findElement(By.cssSelector("#selected-annotation .pager-count span")).getText();
    }

    public boolean isEditIconVisible() {
        return web.isElementVisible(By.cssSelector("#selected-annotation button[title='Edit Annotation']"));
    }

    public String getEditedText() {
        By by = By.cssSelector(".annotation.selected .active-annotation-text");
       if (web.isElementVisible(by)) {
           WebElement element = web.findElement(by);
           String str = web.getJavascriptExecutor().executeScript("return arguments[0].innerHTML;", element).toString();
           return str;
       }
       else
           return null;
    }

    public void clickOnReply() {
        web.clickThroughJavascript(By.cssSelector("article.leave-a-comment a"));

    }
    public void writeCommentInReplySection(String comment) {
        WebElement element = web.findElement(By.cssSelector("textarea[ng-model='newCommentData.Text']"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
        web.getJavascriptExecutor().executeScript("angular.element(arguments[0]).scope().newCommentData.Text = '"+comment+"';" +
                "angular.element(document.body).injector().get('$rootScope').$apply();", element);
    }

    public void clickOnSaveButtonInReplySection() {
        web.clickThroughJavascript(By.cssSelector("article.new-comment button.save"));
    }

    public boolean isDeleteIconVisibleInReplyCommentsSection() {
        return web.isElementVisible(By.cssSelector("a[title='Delete Comment'] i"));
    }

    public void clickOnDeleteIconInReplyCommentsSection(){
        Common.sleep(2000);
        web.clickThroughJavascript(By.cssSelector("a.annotation-pointer i"));
        web.switchTo().alert().accept();
    }
    public void clickOnCompare() {
        web.clickThroughJavascript(By.cssSelector("a[ng-click='compare()']"));
    }

    public boolean isCompareLinkDisplayed() {
        return web.findElement(By.cssSelector("a[ng-click='compare()']")).isDisplayed();
    }

    public void clickOnExitCompare() {
        web.clickThroughJavascript(By.cssSelector("a[ng-click='compare()']"));
    }

    public ArrayList<String> getAnnotationCommentsByUser(String user) {
        ArrayList<String> userComments = new ArrayList<>();
        List<WebElement> elements = web.findElements(By.xpath("//*[contains(@class, 'annotator-name')]/*[.='"+user+"']/../following-sibling::div[contains(@class, 'active-comment-text')]"));
        for (WebElement e : elements) {
            userComments.add(e.getText());
        }
        return userComments;
    }

    public void selectAnnotation() {
        web.clickThroughJavascript(By.className("annotation-content"));
        Common.sleep(1000);
    }

    public String getCurrentVersion() {
        return web.findElement(By.cssSelector("ul.revisions-menu a.icon-hover")).getText();
    }

    public boolean isCompareViewDisplayed() {
        return web.findElements(By.cssSelector("article.col-xs.gui")).size() > 1;
    }
}
