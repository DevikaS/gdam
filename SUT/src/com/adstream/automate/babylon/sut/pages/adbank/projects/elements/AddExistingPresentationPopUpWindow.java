package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 12.10.12
 * Time: 11:17

 */
public class AddExistingPresentationPopUpWindow extends PopUpWindow {

    public AddExistingPresentationPopUpWindow(Page parentPage) {
        super(parentPage);
    }

    public void clickPresentation(String presentationId) {
        web.click(By.cssSelector(".list-item.valign-middle.pointer.paxs[data-item-id='" + presentationId + "']"));
    }

    public boolean isSaveButtonDisabled() {
        By locator = By.cssSelector(".button.save.secondary.mrs.disabled");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public String getTitle() {
        return web.findElement(generateLocator("[id*='title']")).getText().trim();
    }

    public String getFileNames() {
        return web.findElement(generateLocator(".file-names.bold")).getText().trim();
    }

    public List<String> getPresentationList() {
        return web.findElementsToStrings(By.cssSelector(".list-item.valign-middle.pointer.paxs[data-item-id]"));
    }
}
