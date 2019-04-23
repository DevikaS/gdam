package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.page.Page;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 31.10.12
 * Time: 18:55
 */
public abstract class AbstractMovePopUpWindow extends AbstractPopUpWindow {
    public AbstractMovePopUpWindow(Page parentPage) {
        super(parentPage);
    }

    public void typeSearchText(String text) {
        web.typeClean(getSearchInputLocator(), text);
        web.sleep(1000);
    }

    public void clickSearchButton() {
        web.click(getSearchButtonLocator());
        web.sleep(1000);
    }

    public List<String> getAvailableForSearchProjectsListAsText() {
        if (getAvailableForSearchProjectsList().size() == 0) return null;
        List<String> result = new ArrayList<String>();
        for (WebElement webElement: getAvailableForSearchProjectsList()) {
            result.add(webElement.getText());
        }
        return result;
    }

    public List<WebElement> getAvailableForSearchProjectsList() {
        return web.findElements(By.cssSelector(".project-result.plxs.pvxs.pointer"));
    }

    private By getSearchButtonLocator() {
        return By.cssSelector(".button.unit.no-padding.search-button");
    }

    private By getSearchInputLocator() {
        return By.cssSelector(".popupWindow .ui-input");
    }

    public void clickRootFolderAssetPOPUP(){
        web.findElement(By.xpath("//*[@data-dojo-type='adbank.files.copy_folder_tree_item']/div[@class='arrow']")).click();
        web.sleep(2000);
    }

}
