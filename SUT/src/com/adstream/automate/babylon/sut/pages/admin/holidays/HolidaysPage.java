package com.adstream.automate.babylon.sut.pages.admin.holidays;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created by Raja.Gone on 16/02/2016.
 */
public class HolidaysPage extends BasePage {

    private By countryLocator = By.cssSelector(".select2-arrow>b");
    private By selectCountryLocator = By.xpath("//ul[@id='select2-results-2']/li");
    private By monthLocator = By.xpath("//*[@id='s2id_autogen3']/a/span[2]/b");
    private By selectMonthLocator = By.xpath("//ul[@id='select2-results-4']/li");
    private By addHolidaysLocator = By.cssSelector(".spriteicon.i16x16_simple-plus");
    private Edit selectYearLocator;
    private Edit dateFieldLocator;
    private Edit descriptionFieldLocator;
    private Button addHolidayBtn;

    public HolidaysPage(ExtendedWebDriver web) {
        super(web);
        selectYearLocator = new Edit(this,By.xpath("//input[@ng-model='searchOptions.year']"));
        dateFieldLocator = new Edit(this,By.xpath("//input[@datepicker-options='dateOptions']"));
        descriptionFieldLocator = new Edit(this,By.xpath("//input[@ng-model='holidayModel.description']"));
        addHolidayBtn = new Button(this, By.cssSelector(".secondary.button"));
    }

    public void setCountry(String country)
    {
        selectCountryName(country);
    }

    public void setMonth(String month)
    {
        selectMonth(month);
    }

    public void setYear(String year){
        selectYearLocator.type(year);
    }

    public void addHoliday(String holidayDate, String description) {
        web.findElement(addHolidaysLocator).click();
        dateFieldLocator.type(holidayDate);
        descriptionFieldLocator.type(description);
        addHolidayBtn.click();
    }

    private By getCountryLocator() { return countryLocator; }

    private By getMonthLocator() { return monthLocator; }

    private void selectCountryName(String countryName) {
        web.findElement(getCountryLocator()).click();
        List<WebElement> marketCountry = web.findElements(selectCountryLocator);

        for (int i = 0; i < marketCountry.size(); i++) {
            if (marketCountry.get(i).getText().contains(countryName)) {
                marketCountry.get(i).click();
                break;
            }
        }
    }

    private void selectMonth(String monthName) {
        web.findElement(getMonthLocator()).click();
        List<WebElement> month = web.findElements(selectMonthLocator);

        for (int i = 0; i < month.size(); i++) {
            if (month.get(i).getText().contains(monthName)) {
                month.get(i).click();
                break;
            }
        }
    }

}
