package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Order_RemoveItem extends OrdersBaseTest{

	@Test
	public void removeItemTest() {
		apiCall = new HeadlessAPICalls();

		responsePayLoad= apiCall.createOrder();
		setOrderId(responsePayLoad.getId());

		responsePayLoad = apiCall.createItem(getOrderId());
		setItemId(responsePayLoad.getId());

		Assert.assertTrue(apiCall.removeItem(getOrderId(), getItemId()),
				this.getClass().getSimpleName().toUpperCase()+": End Point Failed");
	}
}