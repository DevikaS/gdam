package com.publicApi.tests;

import com.publicApi.tests.testsBase.OrdersBaseTest;

import java.io.IOException;
import java.util.HashMap;

public class Order_RemoveMediaItem extends OrdersBaseTest{

	public Order_RemoveMediaItem() throws IOException {
		super();
		}
	


	HashMap<String,String> addMediaItemResponseBody =null;
	HashMap<String,String> removeMediaItemResponseBody =null;
	HashMap<String,String> createItemResponseBody =null;
	HashMap<String,String> createOrderResponseBody = null;

	String orderId=null;
	String itemId=null;


	public void DELETE_removeMediaItem() throws IOException
	{
		/*
		try
		{
			// POST - Create Order - To get order ID
			apiCall = new HeadlessAPICalls(driver);
			createOrderResponseBody= apiCall.createOrder();

			// Verify: If a new order is created
			if(createOrderResponseBody.get("statusCode").equals("201"))
			{
				orderId=createOrderResponseBody.get("orderId");

				// POST CALL - CREATE ORDER ITEM
				createItemResponseBody = apiCall.createItem(orderId);

				if(createItemResponseBody.get("statusCode").equals("201"))
				{
					itemId=createItemResponseBody.get("itemId");
					
					// POST CALL - ADD DESTINATIONS
					addMediaItemResponseBody= apiCall.addMediaItem(orderId, itemId);

					if(addMediaItemResponseBody.get("statusCode").equals("200"))
					{
						if(apiCall.removeMediaItem(orderId, itemId))
						{							
							System.out.println("REMOVE MEDIA ITEM: End point - PASSED");
							Assert.assertTrue(true);
						} else {
							System.out.println("REMOVE MEDIA ITEM: End point - Failed - Unable to remove media item");
							Assert.fail("REMOVE MEDIA ITEM: End point - Failed - Unable to add destinations");
						}
					} else Assert.fail("REMOVE MEDIA ITEM: End point FAILED due to ADD MEDIA ITEM call RESPONDED with status code:"+addMediaItemResponseBody.get("statusCode"));
				} else Assert.fail("REMOVE MEDIA ITEM: END-POINT FAILED - Due to CREATE ITEM  call RESPONDED with status code: "+createItemResponseBody.get("statusCode"));
			} else Assert.fail("REMOVE MEDIA ITEM: END-POINT FAILED - Due to CREATE ORDER call RESPONDED with status code: "+createOrderResponseBody.get("statusCode"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			Assert.fail("REMOVE MEDIA ITEM: END-POINT FAILED");
		}*/
	}
}