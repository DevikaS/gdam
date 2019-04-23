package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.OrdersBaseTest;
import org.testng.Assert;

/*= * Created by Raja.Gone on 28/11/2016.
 */
public class AssetsIngestGDN_RegisterAFileInGDN extends OrdersBaseTest{

    private String payLoad=null;

    public String getPayLoad() {
        return payLoad;
    }

    public void setPayLoad(String payLoad) {
        this.payLoad = payLoad;
    }


    public Traffic ingestAsset(String qcAssetId, String storageId, String agencyId){

        Traffic response = null;
        try {
            apiCall = new HeadlessAPICalls();

            // register the job in GDN
            String fileSize= "332015";
            String fileName = System.getProperty("user.dir")+"//src//test//resources//Fish-Ad.zip";

            constructPayloadToRegisterJob(storageId, qcAssetId, agencyId,fileSize);

            responsePayLoad = apiCall.assetsIngestGDN_RegisterAFileInGDN(getPayLoad());

            String fileUriInGDN = responsePayLoad.getRegisterJobResponse().getFileUri();
            String fileIdInGDN= responsePayLoad.getRegisterJobResponse().getFileID();

            String fileUploadLocationInGDN = fileUriInGDN.concat("/").concat(fileIdInGDN).concat("_master.zip");

            // Upload media to GDN location
            apiCall.mediaUploadToGdn(fileUploadLocationInGDN, fileName);

            waitFor(60000); // Wait for media to upload to GDN

            // Get ingestId
            Traffic[] responsePayLoad=apiCall.assetsIngest_FindAssetIngestItems(qcAssetId);

            String status = "TVC Ingested OK";

            response =apiCall.assetsIngest_UpdateIngest(responsePayLoad, status,fileSize,fileIdInGDN);

            waitFor(16966); // Wait for Ingestion process to complete
        } catch (Exception e){
            Assert.fail("Ingestion failed: "+e.getMessage());
        }

        return response;
    }


    // Construct payload in XML format
    private void constructPayloadToRegisterJob(String storageId, String qcAssetId, String agencyId, String fileSize){

        setPayLoad("<RegisterJob xsi:type=\"RegisterJob\" xmlns=\"urn:adstream:yadn\" xmlns:xs=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                "  <ExternalID>"+agencyId+"</ExternalID>\n" +
                "  <Priority>9</Priority>\n" +
                "  <System>adbank5</System>\n" +
                "  <StorageID>"+storageId+"</StorageID>\n" +
                "  <Capabilities>http-upload</Capabilities>\n" +
                "  <FileName>"+qcAssetId+"_Master.zip</FileName>\n" +
                "  <Size>"+fileSize+"</Size>\n" +
                "  <Metadata>\n" +
                "    <property name=\"Path\">"+qcAssetId+"_Master.zip</property>\n" +
                "    <property name=\"Filepath\">/"+agencyId+"/20170101/"+qcAssetId+"/"+qcAssetId+"_Master.zip</property>\n" +
                "    <property name=\"ElementID\">"+qcAssetId+"</property>\n" +
                "    <property name=\"AgencyID\">"+agencyId+"</property>\n" +
                "  </Metadata>\n" +
                "  <IsIngested>false</IsIngested>\n" +
                "</RegisterJob>\n");
    }
}