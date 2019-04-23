package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Order_ListItems extends OrdersBaseTest{

	@Test
	public void listItemsTest()	{

		apiCall = new HeadlessAPICalls();

		responsePayLoad= apiCall.createOrder();
		setOrderId(responsePayLoad.getId());

		responsePayLoad = apiCall.createItem(getOrderId());

        waitFor(10000);

		String response = apiCall.listItems(getOrderId());

 		Assert.assertTrue(response.contains(getOrderId()),
				this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
	}
}