package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

/**
 * Created by Janaki.Kamat on 28/07/2017.
 */
public class LibImpersonatePopup extends LibPopUpWindow {
    private String emailLocator = "md-autocomplete[placeholder=\"Enter the name/email address\"] input[placeholder=\"Enter the name/email address\"]";
    private String commentLocator = "ads-md-textarea[model=\"$ctrl.comment\"]";
    public LibImpersonatePopup(Page parentPage) {
        super(parentPage,"ads-ui-impersonate");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
   }

    public void typeUserEmails(String email) {
        web.findElement(By.xpath("//input[@aria-label='Enter the name/email address']")).sendKeys(email);
        web.findElement(By.xpath("//input[@aria-label='Enter the name/email address']")).click();
        Common.sleep(2000);
        web.findElement(By.xpath("//ul[@class='md-autocomplete-suggestions md-contact-chips-suggestions']/li/md-autocomplete-parent-scope//span[@class='md-contact-email ng-binding']")).click();
        WebElement element = web.findElement(By.xpath("//textarea[@ng-model='$ctrl.model']"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
        web.getJavascriptExecutor().executeScript("angular.element(arguments[0]).scope().$ctrl.model = 'Autotest';" +
                "angular.element(document.body).injector().get('$rootScope').$apply();", element);
       // System.out.println("==============="+web.getJavascriptExecutor().executeScript("return arguments[0].value;", element));

    }

    public void enterComment(String message) {
          web.typeClean(generateLocator(commentLocator), message);
    }

    public void clickImpersonate(){
        action.click();
    }
}
