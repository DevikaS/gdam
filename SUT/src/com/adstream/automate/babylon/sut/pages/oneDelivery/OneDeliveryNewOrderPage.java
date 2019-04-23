package com.adstream.automate.babylon.sut.pages.oneDelivery;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

public class OneDeliveryNewOrderPage extends OneDeliveryBasePage {

    private String marketLoc = "//input[@class='search']";
    private String assigneesLoc="//input[@name='assignees']";

    public OneDeliveryNewOrderPage(ExtendedWebDriver web){
        super(web);
    }

    public void fillFieldByName(String fieldName, String fieldValue) {
      if(fieldName.equalsIgnoreCase("Select Market")) {
          By by = By.xpath(marketLoc);
          web.click(by);
          web.typeClean(by,fieldValue);
          web.click(By.xpath("//span[.='"+fieldValue+"']"));
      }

      if(fieldName.equalsIgnoreCase("Who is supplying the media"))
          web.typeClean(By.xpath(assigneesLoc),fieldValue);
    }
}