package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.admin.holidays.HolidaysPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

/**
 * Created by Raja.Gone on 16/02/2016.
 */
public class HolidaysSteps extends BaseStep {

    public HolidaysPage getHolidayPage()
    {
        return getSut().getPageNavigator().getHolidaysPage();
    }

    @Given("{I am |}on {the|} holidays page")
    public HolidaysPage onHolidaysPage() {
        return getSut().getPageNavigator().getHolidaysPage();
    }

    @Given("{I am |}select country as '$country' on {the|} holidays page")
    public void selectCountry(String countryName) {
        getSut().getPageNavigator().getHolidaysPage().setCountry(countryName);
    }

    @Given("{I am |}select following details on holidays page: $fields")
    public void selectCountry(ExamplesTable fields) {
        HolidaysPage holidays = getHolidayPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fields, i);

            // Mandatory fields
            holidays.setCountry(parameters.get("Country"));
            holidays.setYear(parameters.get("Year"));

            // Optional field
            if (parameters.containsKey("Month")&& !parameters.get("Month").isEmpty())
                holidays.setMonth(parameters.get("Month"));
        }
    }

    // Date Format: dd/mm/yyyy
    @Given("{I am |}add following dates to holidays list: $fields")
    public void addHoliday(ExamplesTable fields) {
        HolidaysPage holidays = getHolidayPage();
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fields, i);
            holidays.addHoliday(parameters.get("Date"),parameters.get("Description"));
        }
    }

}
