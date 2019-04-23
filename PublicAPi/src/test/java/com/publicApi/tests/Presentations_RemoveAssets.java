package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 22/12/2015.
 */
public class Presentations_RemoveAssets extends LibraryBaseTests {

    @Test
    public void removeAssetPresentationTest() {

        apiCall = new HeadlessAPICalls();

        //create asset
        responsePayLoad = apiCall.createAsset();
        setAssetId(responsePayLoad.getId());

        responsePayLoad = apiCall.createPresentation();
        setPresentationId(responsePayLoad.getId());

        //add asset to presentation
        apiCall.addPresentationAssets(getPresentationId(), getAssetId());

        waitFor(4000); // Explicitly wait for few seconds before removing the asset from presentation, so that sync would be proper, otherwise 'remove presentation asset' would fail with 404 error

        Assert.assertTrue(apiCall.removePresentationAssets(getPresentationId(), getAssetId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
    }
}
