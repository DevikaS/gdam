package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Order_ListOrders extends OrdersBaseTest{

	@Test
	public void listOrdersTest() {
			apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.listOrders(),
					this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
	}
}
