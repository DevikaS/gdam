package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddUsageRightsPopUp;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created by balastryk-d on 02.12.2014.
 */
public class AdbankBatchUsageRightEditPopUp extends AddUsageRightsPopUp {

    public AdbankBatchUsageRightEditPopUp(Page parentPage) {
        super(parentPage);
      action = new Button(parentPage, generateLocator(".button[data-role='save']"));
    }

    public void clickOkOnConfirmationDialog(){
        if(web.isElementPresent(By.xpath("//*[@class='windowHead'][descendant::span[text()='Confirmation']]"))){
            web.findElement(By.cssSelector("[name='Ok']")).click();
        }
    }

    public void clickOnSave()
    {action.click();
        Common.sleep(2000);
    }

    public void openTabOnAdbankBatchUsageRightEditPopUp(String value){
        if(!web.findElement(generateLocator("a[data-role='" + value + "']")).getAttribute("class").equals("active")){
            web.findElement(generateLocator("a[data-role='" + value + "']")).click();
        }
    }
}
