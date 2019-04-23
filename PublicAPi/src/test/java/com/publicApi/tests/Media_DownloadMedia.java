package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.json.simple.parser.ParseException;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * Created by Nirmala.Sankaran on 30/11/2015.
 */
public class Media_DownloadMedia extends ProjectsBaseTest {

    String elementId = null;


    @Test
    public void downloadMediaTest() throws IOException, ParseException, InterruptedException {

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.uploadAsset();

        setUrl(responsePayLoad.getUrl());
        setMediaId(responsePayLoad.getId());

        setReference(ExpectedData.ASSETPATH);
        setMediaName(ExpectedData.ASSETFILENAME);

        Assert.assertTrue(apiCall.mediaUploadToGdn(getUrl(), getReference()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, 'Media Upload to GDN");


        //Complete Asset
        responsePayLoad = apiCall.completeAsset(getMediaId(), getMediaName());
        elementId = responsePayLoad.getId();

        Thread.sleep(10000); // Explicitly wait to finish 'completeAsset', so that files are available to download

        Assert.assertTrue(apiCall.downloadMedia(elementId, getMediaId()),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed,'Unable to download media");
    }
}
