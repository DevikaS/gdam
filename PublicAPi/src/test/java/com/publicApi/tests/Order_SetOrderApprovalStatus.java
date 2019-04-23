package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.annotations.Test;

public class Order_SetOrderApprovalStatus extends OrdersBaseTest{

	@Test
	public void setOrderApprovalStatusTest() {
		apiCall = new HeadlessAPICalls();
		responsePayLoad= apiCall.createOrder();
		setOrderId(responsePayLoad.getId());

		responsePayLoad= apiCall.createItem(getOrderId());
		setItemId(responsePayLoad.getId());

		responsePayLoad= apiCall.setOrderApprovalStatus(getOrderId(), getItemId());
	}
}