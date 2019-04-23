package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;

/**
 * Created by Raja.Gone on 10/05/2016.
 */
public class OrderEditSummaryPage extends BaseOrderingPage<OrderingPage> {

    private Button doneBtn;

    public OrderEditSummaryPage(ExtendedWebDriver web) {
        super(web);
        doneBtn = new Button(this, By.xpath("//button[contains(.,'Done')]"));
    }

    public void clickDoneButtton()
    {
        doneBtn.click();
    }
}
