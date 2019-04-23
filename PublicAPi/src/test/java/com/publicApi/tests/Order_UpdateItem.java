package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.RequestPayLoads;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.apache.http.entity.StringEntity;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.nio.charset.StandardCharsets;

public class Order_UpdateItem extends OrdersBaseTest {
    @Test
    public void updateItemTest() {
        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        RequestPayLoads payload = new RequestPayLoads();
        StringEntity entity = new StringEntity(payload.updateItemPayLoad(), StandardCharsets.UTF_8);
        responsePayLoad = apiCall.updateItem(getOrderId(), getItemId(),entity);

        // VERIFY - Important fields in response payload
        actual_list.add(responsePayLoad.getStatus()[0]);
        actual_list.add(responsePayLoad.getMeta().getTv().getMarket());
        actual_list.add(responsePayLoad.getMeta().getTv().getMarketCountry());
        actual_list.add(responsePayLoad.getMeta().getTv().getMarketId()[0].toString());
        actual_list.add(responsePayLoad.getMeta().getCommon().getFirstAirDate());
        actual_list.add(responsePayLoad.getMeta().getCommon().getFormat()[0].toString());
        actual_list.add(responsePayLoad.getMeta().getCommon().getDuration());
        actual_list.add(responsePayLoad.getMeta().getCommon().getAdditionalInformation());
        actual_list.add(responsePayLoad.getMeta().getCommon().getTitle());
        actual_list.add(responsePayLoad.getMeta().getCommon().getItem_type());
        actual_list.add(responsePayLoad.getMeta().getMetadata().getSubtitlesRequired()[0].toString());
//			actual_list.add(responsePayLoad.getMeta().getAsset().getDictionaryMetaData().getBrand()[0].toString());
//			actual_list.add(responsePayLoad.getMeta().getAsset().getDictionaryMetaData().getAdvertiser()[0].toString());
        actual_list.add(responsePayLoad.getDocumentType());
        actual_list.add(responsePayLoad.getType());

        expected_list.add("awaiting_media");
        expected_list.add(ExpectedData.MARKET);
        expected_list.add(ExpectedData.MARKETCOUNTRY);
        expected_list.add(ExpectedData.MARKETID);
        expected_list.add(ExpectedData.FIRSTAIRDATE_EDIT);
        expected_list.add(ExpectedData.FORMAT_EDIT);
        expected_list.add(ExpectedData.DURATION_EDIT);
        expected_list.add(ExpectedData.ADDITIONALINFORMATION_EDIT);
        expected_list.add(ExpectedData.TITLE);
        expected_list.add("delivery");
        expected_list.add(ExpectedData.SUBTITLESREQUIRED);
//			expected_list.add(ExpectedData.BRAND);
//			expected_list.add(ExpectedData.ADVERTISER);
        expected_list.add("order");
        expected_list.add("tv_order_item");

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }
}