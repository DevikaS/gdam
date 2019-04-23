package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.*;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.TransferOrderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.*;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 20.08.13
 * Time: 19:48
 */
public class TrafficEditOrderItemPage extends OrderItemPage {

    public TrafficEditOrderItemPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
    }

    public void isLoaded() throws Error {
        super.isLoaded();
    }
}