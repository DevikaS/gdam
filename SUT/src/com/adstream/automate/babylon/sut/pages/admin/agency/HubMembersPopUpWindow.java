package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;

/**
 * User: Devika Subramanian
 * Date: 15.06.16
 */
public class HubMembersPopUpWindow extends PopUpWindow {
    public HubMembersPopUpWindow(Page parentPage) {
        super(parentPage);

    }

    @Override
    public void clickAction() {
        web.click(By.xpath("//button[@class='button secondary mrs ng-binding']"));
        web.waitUntilElementDisappear(generateLocator());
    }

    public void addSuperHubMembers(String superHubMembers) {
        web.waitUntilElementAppear(By.xpath("//a[@class='select2-choice']"));
      /*  long start = System.currentTimeMillis();
        long timeOut=2000;
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 1);
            if (System.currentTimeMillis() - start > 25000) {
                throw new TimeoutException("Timeout during waiting for add Hub Members page");
            }
        } while (!web.isElementVisible(By.xpath("//a[@class='select2-choice']")));*/
        web.findElement(By.xpath("//a[@class='select2-choice']")).click();
        Common.sleep(5000);
        web.findElement(By.xpath("//input[@type='text'][@role='combobox']")).sendKeys(superHubMembers);
        int hubCount = web.findElements(By.xpath("//ul[@class='select2-results']/li")).size();
        for (int hub = 1; hub <= hubCount; hub++) {
            String hubList = web.findElement(By.xpath("//ul[@class='select2-results']/li[" + hub + "]")).getText();
            if (hubList.contains(superHubMembers)) {
                web.findElement(By.xpath("//ul[@class='select2-results']/li[" + hub + "]")).click();
                break;
            }
        }
        web.findElement(By.xpath("//button[contains(text(),'Add')]")).click();

    }


    public void groupDestinationForHouseNumber(int j, String houseNumber)
    {


        web.findElement(By.xpath("//div[@class='itemsList clearfix size1of1']/div[" + j +"]//input")).clear();
            web.findElement(By.xpath("//div[@class='itemsList clearfix size1of1']/div[" + j +"]//input")).sendKeys(houseNumber);


    }



    public String verifySaveMessage() {
        String text = web.findElement(By.xpath("//div[@class='message warning']")).getText();
        return text;
    }

}


