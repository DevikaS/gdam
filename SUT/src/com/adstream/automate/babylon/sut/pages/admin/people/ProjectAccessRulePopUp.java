package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Devika Subramanian
 * Date: 11/04/16
 * Time: 17:38
 * To change this template use File | Settings | File Templates.
 */
public class ProjectAccessRulePopUp extends PopUpWindow {

    public ProjectAccessRulePopUp(Page parentPage) {
        super(parentPage);
    }


    @Override
    public void clickAction() {
        web.click(By.xpath("//a[@data-role='cancel']"));
        web.waitUntilElementDisappear(generateLocator());
    }

    public void selectProjectRole(String projectRole) {

        web.findElement(By.xpath("//table[@id='dijit_form_Select_1']/tbody/tr/td[1]")).click();
        List<WebElement> roleList = web.findElements(By.xpath("//table[@id='dijit_form_Select_1_menu']/tbody/tr"));
        for (int i = 1; i <= roleList.size(); i++) {
            String actualList = web.findElement(By.xpath("//table[@id='dijit_form_Select_1_menu']/tbody/tr[" + i + "]")).getText();
            if (actualList.equalsIgnoreCase(projectRole)) {
                web.findElement(By.xpath("//table[@id='dijit_form_Select_1_menu']/tbody/tr[" + i + "]")).click();
                break;
            }
        }
    }

    public void selectProjectRuleMetaData(String metaData, String metaValue) {


        if (metaData.contains("Advertiser")) {
            web.findElement(By.xpath("//table[@id='dijit_form_Select_2']/tbody/tr/td[1]")).click();
            List<WebElement> advList = web.findElements(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr"));
            for (int i = 1; i <= advList.size(); i++) {
                String actualList = web.findElement(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr[" + i + "]")).getText();
                if (actualList.equalsIgnoreCase(metaData)) {
                    web.findElement(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr[" + i + "]")).click();
                    break;
                }
            }

        }
        if (metaData.contains("Project Type")) {
            web.findElement(By.xpath("//table[@id='dijit_form_Select_2']/tbody/tr/td[1]")).click();
            List<WebElement> projList = web.findElements(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr"));
            for (int i = 1; i <= projList.size(); i++) {
                String actualList = web.findElement(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr[" + i + "]")).getText();
                if (actualList.equalsIgnoreCase(metaData)) {
                    web.findElement(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr[" + i + "]")).click();
                    break;
                }
            }
        }

        if(metaData.contains("Campaign")) {

            web.findElement(By.xpath("//table[@id='dijit_form_Select_2']/tbody/tr/td[1]")).click();
            List<WebElement> campList = web.findElements(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr"));
            for (int i = 1; i <= campList.size(); i++) {
                String actualList = web.findElement(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr[" + i + "]")).getText();
                if (actualList.equalsIgnoreCase(metaData)) {
                    web.findElement(By.xpath("//table[@id='dijit_form_Select_2_menu']/tbody[@class='dijitReset']/tr[" + i + "]")).click();
                    web.findElement(By.xpath("//div[contains(@id,'widget_dijit_form_TextBox')]//input")).sendKeys(metaValue);
                    Common.sleep(2000);
                    // break;
                }
            }
        }

    }




    public void clickSave() {

        web.click(By.xpath("//button[@data-role='add-condition']"));

        web.click(By.xpath("//button[@data-role='save']"));

    }
}



