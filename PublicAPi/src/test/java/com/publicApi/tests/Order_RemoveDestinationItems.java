package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

public class Order_RemoveDestinationItems extends OrdersBaseTest{

	@Test
	public void removeDestinationItemsTest() {
		apiCall = new HeadlessAPICalls();

		responsePayLoad= apiCall.createOrder();
		setOrderId(responsePayLoad.getId());

		responsePayLoad = apiCall.createItem(getOrderId());
		setItemId(responsePayLoad.getId());

		apiCall.addDestinationItems(getOrderId(), getItemId());

		boolean isDestinationRemoved = apiCall.removeOrderItemDestination(getOrderId(), getItemId());
		Assert.assertTrue(isDestinationRemoved,
				this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

		// AFTER DELETE CALL, re-add the same destination. addDestinationItems should PASS
		apiCall.addDestinationItems(getOrderId(), getItemId());
	}
}