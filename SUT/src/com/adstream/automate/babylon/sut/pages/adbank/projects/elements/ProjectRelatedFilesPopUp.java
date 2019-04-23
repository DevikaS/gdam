package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * Created by sobolev-a on 23.06.2014.
 */
public class ProjectRelatedFilesPopUp extends PopUpWindow {

    public ProjectRelatedFilesPopUp(Page parentPage) {
        super(parentPage);
    }

    public void typeRelatedFileName(String fileName) {
        web.typeClean(By.cssSelector("[ng-model=\"query\"]"), fileName);
    }


    public void selectFollowingRelatedFiles(String fileName) {
        web.click(By.xpath(String.format("//span[normalize-space(text())='%s']/ancestor::div[3]//input", fileName)));
    }

    public void clickSaveButton() {
        web.click(By.cssSelector("[ng-click='save()']"));
    }

}
