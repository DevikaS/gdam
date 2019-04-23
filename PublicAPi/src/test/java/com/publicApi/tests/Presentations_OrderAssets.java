package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Presentations_OrderAssets extends LibraryBaseTests {


    @Test
    public void orderAssetPresentationTest() {

        String[] assetsIDs = new String[2]; // test is for 2 assets
        apiCall = new HeadlessAPICalls();

        //create First asset
        responsePayLoad = apiCall.createAsset();
        assetsIDs[0]=responsePayLoad.getId();

        //create Second asset
        responsePayLoad = apiCall.createAsset();
        assetsIDs[1] = responsePayLoad.getId();

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        //add assets to Presentation
        responsePayLoad = apiCall.addPresentationAssets(getPresentationId(), assetsIDs[0]);
        responsePayLoad = apiCall.addPresentationAssets_WithTwoAssets(getPresentationId(), assetsIDs[1]);

        // Get Current Order of assets in presentation
        expected_list.add(responsePayLoad.getAssets().getList()[1].get_id());
        expected_list.add(responsePayLoad.getAssets().getList()[0].get_id());

        responsePayLoad=apiCall.orderPresentationAssets(getPresentationId(), assetsIDs[1],assetsIDs[0]);

        // After running order endpoint, check assets order in presentation
        actual_list.add(responsePayLoad.getAssets().getList()[0].get_id());
        actual_list.add(responsePayLoad.getAssets().getList()[1].get_id());

        Assert.assertEquals(actual_list,expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }
}
