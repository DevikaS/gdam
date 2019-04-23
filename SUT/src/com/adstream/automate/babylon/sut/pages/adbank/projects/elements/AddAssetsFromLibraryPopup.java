package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import org.openqa.selenium.By;

 /**
 * User: lynda-k
 * Date: 02.09.14
 * Time: 10:32
 */
public class AddAssetsFromLibraryPopup extends PopUpWindow {
     public AddAssetsFromLibraryPopup(Page parentPage) {
         super(parentPage);
         action = new Button(parentPage, generateLocator("[ng-click='save()']"));
     }

     public void fillQueryField(String query) {
         web.typeClean(By.cssSelector("[ng-model='query']"), query);
     }


     public void selectFileByName(String name) {
         new Checkbox(parentPage, getFileRowCheckboxLocatorByName(name)).select();
     }

     public void deselectFileByName(String name) {
         new Checkbox(parentPage, getFileRowCheckboxLocatorByName(name)).deselect();
     }

     private By getFileRowCheckboxLocatorByName(String name) {
         return By.xpath(String.format("//*[contains(@ng-repeat,'searchResult')][.//*[normalize-space()='%s']]//input", name));
     }
}