package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Nirmala.Sankaran on 21/12/2015.
 */
public class Asset_SearchAsset extends LibraryBaseTests{

    @Test
    public void searchAssetWithDESCTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        //searchAsset
        Assert.assertTrue(apiCall.searchAssetWithOrder_DESC(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }

    @Test
    public void searchAssetTest() {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        //searchAsset
        Assert.assertTrue(apiCall.searchAssets(),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
