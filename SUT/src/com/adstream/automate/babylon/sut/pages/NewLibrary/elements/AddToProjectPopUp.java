package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by devika on 10/04/2018.
 */
public class AddToProjectPopUp extends LibPopUpWindow {

    private By serachForProject = By.xpath("//input[@aria-label='Search for a project']");
    private By addHere = By.xpath("//md-content//footer//span[.='add here']");
    private By cancel = By.xpath("//md-content//footer//span[.='cancel']");
    private By selectSearchResult = By.xpath("//ul[@class='md-autocomplete-suggestions']/li/md-autocomplete-parent-scope/span");

    public AddToProjectPopUp(Page parentPage) {
        super(parentPage, "copy-assets-to-project[dialog-title='Add to project']");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));

    }

    public void addToProjectFolder(String project,String folder) {
        web.findElement(serachForProject).sendKeys(project);
        Common.sleep(1000);
        web.findElement(serachForProject).click();
        Common.sleep(1000);
        web.waitUntilElementAppear(selectSearchResult);
        web.findElement(selectSearchResult).click();
        web.waitUntilElementAppear(By.xpath("//ads-ui-tree-item[@name='" + project + "']//span[@code='chevron-fill-down']"));
        web.findElement(By.xpath("//ads-ui-tree-item[@name='" + project + "']//span[@code='chevron-fill-down']")).click();
        web.waitUntilElementAppear(By.xpath("//ads-ui-tree-item[@name='" + folder + "']//div[@class='tree-item-title link']//span"));
        web.findElement(By.xpath("//ads-ui-tree-item[@name='" + folder + "']//div[@class='tree-item-title link']//span")).click();

    }

    public void clickAdd()
    {
        WebElement element = web.findElement(addHere);
        web.clickThroughJavascript(element);
    }

    public void typeSearchText(String project) {
        web.findElement(serachForProject).sendKeys(project);
        Common.sleep(1000);
        web.findElement(serachForProject).click();
        web.waitUntilElementAppear(selectSearchResult);

    }

    public List<String> getAvailableForSearchProjectsListAsText() {
        ArrayList<String> result = new ArrayList<String>();
        return web.findElementsToStrings(By.xpath("//ul[@class='md-autocomplete-suggestions']/li"));

    }

    public void cancelPopup()
    {
        WebElement element = web.findElement(cancel);
        web.clickThroughJavascript(element);
    }



    public boolean isFolderExist(String folderName,String path)
    {
        boolean isFolder=false;
        String[] parts;
        int i;
        List<String> result=null;
        parts = path.split("/");
        if (parts.length == 1) {
            isFolder= web.isElementVisible(By.xpath("//ads-ui-tree-item[contains(@name,'" + folderName + "')]"));
        }
        else {
            for (i = 0; i < parts.length; i++) {
                if (web.isElementVisible(By.xpath("//ads-ui-tree-item[contains(@name,'" + parts[i] + "')]//span[@code='chevron-fill-down']"))) {
                    web.findElement(By.xpath("//ads-ui-tree-item[contains(@name,'" + parts[i] + "')]//span[@code='chevron-fill-down']")).click();
                    Common.sleep(2000);
                }
                isFolder = web.isElementVisible(By.xpath("//ads-ui-tree-item[contains(@name,'" + folderName + "')]"));
            }
        }
        return isFolder;
    }
    public void clickRootFolder(String project)
    {
        web.findElement(serachForProject).sendKeys(project);
        Common.sleep(1000);
        web.findElement(serachForProject).click();
        web.waitUntilElementAppear(selectSearchResult);
        web.findElement(selectSearchResult).click();
        web.findElement(By.xpath("//ads-ui-tree-item[contains(@name,'"+project+"')]//span[@code='chevron-fill-down']")).click();
    }

    public boolean verifyMessage(String message)
    {
        return web.isElementVisible(By.xpath("//ads-md-toast//*[contains(.,'" + message +"')]"));
    }



    public boolean verifyButtonState() {
        boolean state;
        WebElement ele = web.findElement(By.xpath("//ads-md-button[@state='primary']/button"));
        state = ele.isEnabled();
        return state;

    }

}
