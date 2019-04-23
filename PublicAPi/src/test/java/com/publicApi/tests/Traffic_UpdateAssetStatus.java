package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import com.publicApi.utilities.ResponseParser;
import org.testng.Assert;
import org.testng.annotations.Test;


/**
 * Created by Saritha.Dhanala on 10/04/2017.
 * API-567---Internal endpoint for asset status update
 */
public class Traffic_UpdateAssetStatus extends OrdersBaseTest {
    public Traffic_UpdateAssetStatus() {
        apiCall = new HeadlessAPICalls();
    }
    AssetsIngestGDN_RegisterAFileInGDN ingest = null;
    Traffic response = null;

    //Asset is ingested -- updated from TVC Ingested OK to New status -- reingested.
    @Test
    public void traffic_updateAssetStatusToNewAndReIngest() {

        String qcAssetId = createOrder();
        // Ingest Asset
        response = ingestAsset(qcAssetId);
        waitFor(60000); //Delay for the GDN to send the asset status change

        //get QCed asset and check the schema
        String expectedStatus = apiCall.getQCAsset(qcAssetId, ExpectedData.TVCIngestedOK).getMeta().getCommon().getStatus();
        Assert.assertEquals(response.getStatus(), expectedStatus, "Asset is not ingested");

        //Update from TVC Ingested OK to New status
        String assetStatusUpdate = apiCall.assetsIngest_UpdateAssetStatus(qcAssetId, ExpectedData.NEWAssetStatus);
        Assert.assertTrue(assetStatusUpdate.contains("true"));

        //Check the staus is updated to New
        String assetStatusAfterUpdate = apiCall.getQCAsset(qcAssetId, ExpectedData.NEWAssetStatus).getMeta().getCommon().getStatus();
        Assert.assertEquals(assetStatusAfterUpdate, ExpectedData.NEWAssetStatus, "Asset is not updated to New");

        //reingested the asset
        response = ingestAsset(qcAssetId);

        waitFor(60000);

        //get QCed asset and check the schema
        expectedStatus = apiCall.getQCAsset(qcAssetId, response.getStatus()).getMeta().getCommon().getStatus();
        Assert.assertEquals(response.getStatus(), expectedStatus, "Asset is not ingested");

    }

    //Asset is ingested -- updated from TVC Ingested OK to New status --New to Uploading files status --Uploading Files to Cancelled status
    @Test
    public void traffic_updateAssetStatusToNewToUploadingFilesToCancelled() {

        String qcAssetId = createOrder();
        // Ingest Asset
        response = ingestAsset(qcAssetId);

        waitFor(60000); //Delay for the GDN to send the asset status change

        Assert.assertEquals(response.getStatus(), ExpectedData.TVCIngestedOK, "Asset is not ingested");

        //Update asset status from TVC Ingested OK to New status
        String assetStatusUpdate = apiCall.assetsIngest_UpdateAssetStatus(qcAssetId, ExpectedData.NEWAssetStatus);
        Assert.assertTrue(assetStatusUpdate.contains("true"));

        //Update asset status from New to Uploading Files
        assetStatusUpdate = apiCall.assetsIngest_UpdateAssetStatus(qcAssetId, ExpectedData.UploadingFilesStatus);
        Assert.assertTrue(assetStatusUpdate.contains("true"));

        //Verify status is updated to UploadingFiles and schema
        String assetStatusAfterUpdate = apiCall.getQCAsset(qcAssetId, ExpectedData.UploadingFilesStatus).getMeta().getCommon().getStatus();
        Assert.assertEquals(assetStatusAfterUpdate, ExpectedData.UploadingFilesStatus, "Asset is not updated to Uploading Files");

        //Update asset status from Uploading Files to Cancelled
        assetStatusUpdate = apiCall.assetsIngest_UpdateAssetStatus(qcAssetId, ExpectedData.Cancelled);
        Assert.assertTrue(assetStatusUpdate.contains("true"));

        //Verify staus is updated to Cancelled and schema
        assetStatusAfterUpdate = apiCall.getQCAsset(qcAssetId, ExpectedData.Cancelled).getMeta().getCommon().getStatus();
        Assert.assertEquals(assetStatusAfterUpdate, ExpectedData.Cancelled, "Asset is not updated to Cancelled");

    }


    private String createOrder(){
        responsePayLoad=null;
        responsePayLoad = apiCall.createOrder();
        setOrderId(responsePayLoad.getId());

        responsePayLoad = apiCall.createItem(getOrderId());
        setItemId(responsePayLoad.getId());

        String responseStr=apiCall.addDestinationItems(getOrderId(), getItemId());
        setDestinationId(ResponseParser.getDestinationId(responseStr));

        //process the draft order
        responsePayLoad = apiCall.processDraftorders(getOrderId(), getItemId(),"Library");

        waitFor(60000); // Wait for order to available in Traffic

        response=apiCall.traffic_GetOrderItem(getItemId());
        //returns qcAssetId
        return response.getDestinations()[0].getQcAssetId();
    }

    private Traffic ingestAsset(String qcAssetId){
        ingest = new AssetsIngestGDN_RegisterAFileInGDN();
        response = ingest.ingestAsset(qcAssetId, ExpectedData.BU_STORAGE_ID,ExpectedData.PRIMARY_BU_ID);
        return response;
    }
}
