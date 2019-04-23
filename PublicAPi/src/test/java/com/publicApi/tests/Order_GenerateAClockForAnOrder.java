package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.json.simple.parser.ParseException;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Saritha.Dhanala on 12/01/2017.
 *
 * PreRequsite : The Custom Code Generator for clock is set in Video Assets Metadata as : SSSSSSSSSSMMDDYYYY 18Characters[10 characters sequential number, Date 8characters]
 */
public class Order_GenerateAClockForAnOrder extends OrdersBaseTest {

    DateFormat dateFormat = null;
    Date date = null;

    @BeforeTest
     public void createOrder_GenerateAClockForAnOrder(){
         responsePayLoad = null;
        apiCall = new HeadlessAPICalls();
        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        dateFormat = new SimpleDateFormat("MMddyyyy");
        date = new Date();
    }

    //Default value of generatorIndex is 1 ,Clocknumber is 18Characters[10 characters sequential number, Date 8characters]
    @Test
    public void generateClockWithNoGeneratorIndexTest() {

        try {
            //Generate a clock for an order with generator index as empty field
            String clock = apiCall.generateAClockForAnOrder(getOrderId(), -1);


            //Get the first 10 characters which is a number
            String clock1 = clock.substring(0,10);

            //Get the last 8 characters which is a Date
            String actualDate = clock.substring(10,18);
            Assert.assertEquals(actualDate, dateFormat.format(date));

            //Again generate the clock for the above order with generator index as empty field
            clock = apiCall.generateAClockForAnOrder(getOrderId(), -1);
            String clock2 = clock.substring(0,10);

            //Get the last 8 characters which is a Date
            actualDate = clock.substring(10,18);
            Assert.assertEquals(actualDate, dateFormat.format(date));

            //Compare the the two clock numbers
            Assert.assertEquals(Integer.parseInt(clock2)-Integer.parseInt(clock1), 1 , "Sequential Number for clock is not generated");

        } catch (ParseException e) {
            e.printStackTrace();
        }

    }

    //Custom code clock number --- SSSSSSSSSSMMDDYYYY 18Characters [10 characters sequential number, Date 8characters]
    @Test
    public void generateClockWithGeneratorIndexTest() {

       try {
        //Generate a clock for an order with generator index as 1
        String clock = apiCall.generateAClockForAnOrder(getOrderId(), 1);


           //Get the first 10 characters which is a number
           String clock1 = clock.substring(0,10);

        //Get the last 8 characters which is a Date
        String actualDate = clock.substring(10,18);
        Assert.assertEquals(actualDate, dateFormat.format(date));

        //Again generate the clock for the above order with generator index as 1
        clock = apiCall.generateAClockForAnOrder(getOrderId(), 1);
           String clock2 = clock.substring(0,10);

        //Get the last 8 digits which is a Date
        actualDate = clock.substring(10,18);
        Assert.assertEquals(actualDate, dateFormat.format(date));

        //Compare the the two clock numbers
        Assert.assertEquals(Integer.parseInt(clock2)-Integer.parseInt(clock1), 1 , "Sequential Number for clock is not generated");

    } catch (ParseException e) {
        e.printStackTrace();
    }

    }

    //Clock number1 --  --- SSSSSSSSSSMMDDYYYY [18 charcters][10 characters sequential number, Date 8characters]
    //Clock number2 -- 0000000002CLOCK -- [15 characters]SSSSSSSSSSCLOCK [10 characters sequential number, Text 5 characters]
    @Test
    public void generateClockWithTwoIndicesTest() {

        try {
            //Generate a clock for an order with generator index as 1
            String clockWithIndex1 = apiCall.generateAClockForAnOrder(getOrderId(), 1);

            //Get the last 8 characters which is a Date
            String actualDate = clockWithIndex1.substring(10,18);
            Assert.assertEquals(actualDate, dateFormat.format(date));

            //Again generate the clock for the above order with generator index as 2
            String clockWithIndex2 = apiCall.generateAClockForAnOrder(getOrderId(), 2);

            //Get the last 5 characters
            String last5Characters = clockWithIndex2.substring(10,15);
            Assert.assertEquals(last5Characters, "CLOCK", "Second custom clock number is generated");

            //Compare the the two clock numbers
            Assert.assertNotEquals(clockWithIndex1, clockWithIndex2, "The two custom clocks are not different");

        } catch (ParseException e) {
            e.printStackTrace();
        }

    }

}
