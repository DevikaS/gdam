package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.BaseTests;
import org.apache.http.Header;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;


/**
 * Created by Saritha.Dhanala on 19/04/2017.
 */
public class Media_CompleteS3UploadandPrepareforIngestion extends BaseTests {

    public Media_CompleteS3UploadandPrepareforIngestion() {
        apiCall = new HeadlessAPICalls();
    }

    private String fileId = null;
    private String s3StorageId = null;
    private String url = null;
    private Header[] headers = null;

    //This test is with the single filePartNumber
    @Test
    public void media_UploadFilesToS3StorageTest() throws IOException {
        String etagValue = null;
        int filePartNumber = 0;


        responsePayLoad = apiCall.mediaUploadWithTokenType("s3StorageAdmin");
        fileId = responsePayLoad.getId();
        s3StorageId = responsePayLoad.getStorageId();

        //Here I am passing the uploadId as "" blank
        responsePayLoad = apiCall.requestNewUploadSegment("s3StorageAdmin",fileId,filePartNumber,s3StorageId,"");
        String uploadId = responsePayLoad.getuploadId();
        url = responsePayLoad.getUrl();
        filePartNumber =  Integer.parseInt(responsePayLoad.getFilePartNumber());

        headers = apiCall.getEtag(url, ExpectedData.ASSETPATH);
        for (Header header : headers) {
           if(header.getName().equals("ETag")){
               etagValue = header.getValue().substring(1,header.getValue().length()-1);;
               break;
          }
        }

        Assert.assertNotNull(etagValue);

        String s = apiCall.completeS3Upload_PrepareForIngestion(fileId,s3StorageId,uploadId,etagValue,filePartNumber);
        Assert.assertEquals(s ,"\"Completed Successfully\"", "Cannot upload the file to S3 storage");

    }

    //This test is for files >5MB, here the file is divided in to two equal segments hence has the two etags and 2 filepartnumbers
    @Test
    public void media_UploadFilesToS3StorageTestWithTwoPartNumbers() throws IOException {

        int[] filePartNumber = new int[ExpectedData.NumberOfSegments];
        String[] partETags = new String[ExpectedData.NumberOfSegments];
        String uploadId = "";

       responsePayLoad = apiCall.mediaUploadWithTokenType("s3StorageAdmin");
       fileId = responsePayLoad.getId();
       s3StorageId = responsePayLoad.getStorageId();

        for(int i=1;i<=ExpectedData.NumberOfSegments;i++) {
            responsePayLoad = apiCall.requestNewUploadSegment("s3StorageAdmin", fileId, i, s3StorageId, uploadId);
            uploadId = responsePayLoad.getuploadId();
            url = responsePayLoad.getUrl();
            filePartNumber[i-1] = Integer.parseInt(responsePayLoad.getFilePartNumber());
            if(i==1) {
                 headers = apiCall.getEtag(url, ExpectedData.ASSETSEGMENTPATH1);
            }else if(i==2){
                headers = apiCall.getEtag(url, ExpectedData.ASSETSEGMENTPATH2);
            }
            for (Header header : headers) {
                if (header.getName().equals("ETag")) {
                    partETags[i-1] = header.getValue().substring(1,header.getValue().length()-1);
                    Assert.assertNotNull(partETags[i-1]);
                    break;
                }
            }

        }
        String s = apiCall.completeS3Upload_PrepareForIngestion(fileId,s3StorageId,uploadId,partETags,filePartNumber);
        Assert.assertEquals(s ,"\"Completed Successfully\"", "Cannot upload the file to S3 storage");

    }
}
