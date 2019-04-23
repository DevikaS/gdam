package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 15.08.12
 * Time: 17:10
 */
public class MoveCopyPopUpWindow extends AbstractMovePopUpWindow {

    public MoveCopyPopUpWindow(Page parentPage) {
        super(parentPage);
    }

    public void clickWantToCopyFilesToAnotherProjectLink() {
        web.click(By.linkText("Want to copy files to another project?"));
    }

    public void clickWantToMoveFilesToAnotherProjectLink() {
        web.click(By.linkText("Want to move files to another project?"));
    }
    public void clickWantToMoveFilesToAnotherProjectLinkforOtherLocale(String localeMore) {
        if (localeMore.equalsIgnoreCase("German")) {
            web.click(By.linkText("Möchten Sie die Datei(en) in ein anderes Projekt verschieben?"));
        }
    }

    public boolean isSearchFieldVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow .ui-input"));
    }

    public List<String> getAllFoundObjects() {
        By locator = By.cssSelector(".project-result.plxs.pvxs.pointer");
        List<String> result = new ArrayList<String>();
        if (web.isElementPresent(locator)) {
            for (String str : web.findElementsToStrings(locator)) {
                if (!str.isEmpty()) {
                    result.add(str);
                }
            }
        }
        return result;
    }

    public WebElement getProjectElementOnTreeContainer() {
        return web.findElement(By.cssSelector(".popupWindow .team_tree_container.mtxs .tree-root span + span"));
    }

    public String getProjectElementOnTreeContainerText() {
        return getProjectElementOnTreeContainer().getText();
    }

    public boolean isProjectElementOnTreeContainerVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow .team_tree_container.mtxs .h5.bold"));
    }

    public WebElement getFolderElementOnTreeContainerByLink(String link) {
        return web.findElement(By.linkText(link));
    }

    public void clickByFolderElementOnTreeContainerByLink(String link) {
        if(web.isElementVisible(By.xpath(String.format("//*[contains(@class,'popupWindow') and not(contains(@style,'display: none'))]//a[text()='%s']", link)))){
            web.click(By.xpath(String.format("//*[contains(@class,'popupWindow') and not(contains(@style,'display: none'))]//a[text()='%s']", link)));
        }else{
            web.click(By.xpath(String.format("//*[contains(@class,'popupWindow') and not(contains(@style,'display: none'))]//span[text()='%s']", link)));
        }

    }

    public boolean isFolderElemenyOnTreeContainerVisible(String link) {
        return web.isElementVisible(By.xpath(String.format("//a[text()='%s']", link)));
    }

    public boolean isFileNameAsTitleVisible(String fileName) {
        return web.isElementVisible(By.xpath(String.format("//*[@dojoattachpoint = 'titleNode' and contains(text(), '%s')]", fileName)));
    }

    public String getFileNameAsTitleText(String fileName) {
        return web.findElement(By.xpath(String.format("//*[@dojoattachpoint = 'titleNode' and contains(text(), '%s')]", fileName))).getText();
    }

    public String getPleaseSelectLabelText() {
        return web.findElement(By.cssSelector(".mhm.ptm.clearfix  span.p")).getText();
    }

    public boolean isMoveButtonDisabled() {
        return web.isElementPresent(By.cssSelector(".button.action.capitalize.secondary.mrs.disabled"));
    }

    public void clickMoveCopyButton() {
        web.click(By.cssSelector(".button.action.capitalize.secondary.mrs"));
        web.sleep(1000);
    }

    public List<WebElement> getArrowCenteredElements() {
        return web.findElements(By.cssSelector(".relative.hasItems.size1of1.folder.folder_tree_item.tree-item > .arrow.centered"));
    }

    public void clickArrowElementByFolderName(String folderName, int num) {
        By elementLocator = By.xpath(String.format("(//a[text()='%s']//ancestor::li[contains(@class,'folder_tree_item')]/div[@class='arrow centered'])[%s]", folderName, num));
        if (web.isElementVisible(elementLocator)) {
            web.click(elementLocator);
        }
    }

    public void clickArrowElementByFolderNameWithCheckActivity(String folderName, int num) {
        By elementLocator = By.xpath(String.format("(//a[text()='%s']//ancestor::li[contains(@class,'folder_tree_item')]/div[@class='arrow centered'])[%s]", folderName, num));
        By liElementLocator = By.xpath(String.format("(//a[text()='%s']//ancestor::li[contains(@class,'folder_tree_item')])[%s]", folderName, num));
        if (web.isElementVisible(elementLocator)) {
            if (!web.findElement(liElementLocator).getAttribute("class").contains("active")) {
                web.click(elementLocator);
            }
        }
    }

    public void clickCancelLink() {
        web.click(By.cssSelector(".popupWindow .cancel"));
    }

    public void clickCloseButton() {
        web.click(By.cssSelector(".popupWindow .icon-remove.close.prxs.mrm"));
    }

    public boolean isMoveCopyPopupVisible(String title) {
        return web.isElementVisible(By.xpath(String.format("//*[contains(@class,'popupWindow')][*[contains(@class,'windowHead')]//*[contains(text(),'%s')]]", title)));
    }

    public void clickRootFolder(){
        web.findElement(By.xpath("//*[@data-dojo-type='adbank.files.copy_folder_tree_item']/div[@class='arrow']")).click();
        web.sleep(2000);
    }

    public boolean isFoldersTreeVisible(){
        return (web.isElementVisible(By.xpath("//*[@data-dojo-type='adbank.files.copy_folder_tree_item']/div[@class='arrow centered']")));
    }
}