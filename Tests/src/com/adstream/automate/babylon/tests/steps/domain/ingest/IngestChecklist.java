package com.adstream.automate.babylon.tests.steps.domain.ingest;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNDeliveryDoc;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNDestinations;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNStatus;
import com.adstream.automate.babylon.JsonObjects.gdn.IngestDoc;
import com.adstream.automate.babylon.tests.steps.domain.ordering.OrderingHelperSteps;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.joda.time.DateTime;
import org.testng.Assert;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.util.Date;
import java.util.*;

/**
 * Created by Ramababu.Bendalam on 27/07/2016.
 */
public class IngestChecklist extends OrderingHelperSteps {

    public final long sleep = 8000;

    public void checkIngestlist(BabylonServiceWrapper a5RestService,String assetId,IngestDoc ingestdoc, Map<String,String> row) throws UnsupportedEncodingException, MalformedURLException {
        if (row.containsKey("comment"))
            Assert.assertEquals(ingestdoc.getComment(), row.get("comment"), "comment was not set on ingestdoc");
        if(row.containsKey("closedCaptionStatus"))
            Assert.assertEquals(ingestdoc.getAsset().getClosedCaptionStatus(), row.get("closedCaptionStatus"),
                    "Closed caption status was not set to "+""+row.get("closedCaptionStatus"));
        if(row.containsKey("watermarkingInitialised"))
            Assert.assertTrue(ingestdoc.getAsset().getWatermarkingInitialised(), "watermarking initialised is not set to" + "" + row.get("watermarkingInitialised"));
        if (row.containsKey("tapeNumber")){
            String tapeNumber = row.get("tapeNumber");
            if (!tapeNumber.equals("Null")) {
                Assert.assertEquals(ingestdoc.getAsset().getTapeNumber(), row.get("tapeNumber"), "tapenumber was not correct");
            } else if (tapeNumber.equals("Null")) {
                Assert.assertNull(ingestdoc.getAsset().getTapeNumber());
            }
        }
        if (row.containsKey("masterArrivedComment")) {
            String masterArrivedComment = row.get("masterArrivedComment");
            if (!masterArrivedComment.equals("Null")) {
                Assert.assertEquals(ingestdoc.getAsset().getMasterArrivedComment(), row.get("masterArrivedComment"), "masterArrivedComment was not correct");
            } else if (masterArrivedComment.equals("Null")) {
                Assert.assertNull(ingestdoc.getAsset().getMasterArrivedComment());
            }
        }
        if (row.containsKey("masterArrivedDate")) {
            String masterarriveddate =  row.get("masterArrivedDate");
            if(!masterarriveddate.equals("Null")) {
                Date currDate = new Date();
                DateTimeUtils dateFormat = new DateTimeUtils();
                String currentDate = dateFormat.formatDate(currDate, "yyyy-MM-dd");
                String actualDate = dateFormat.formatDate(ingestdoc.getAsset().getMasterArrivedDate(), "yyyy-MM-dd");
                Assert.assertEquals(actualDate, currentDate, "masterArrivedDate was not correct");
            } else if(masterarriveddate.equals("Null")){
                Assert.assertNull(ingestdoc.getAsset().getMasterArrivedDate());
            }
        }
        if (row.containsKey("status")) {
            String status = row.get("status");
            if (!status.equals("Null")) {
                if(status.equals("New")){
                    ingestStatusNotNull(a5RestService,assetId);
                    Assert.assertEquals(ingestCompletedStatusCheck(a5RestService,assetId), status, "status was not set to" + status);
                }
                else {
                    ingestStatusNotNull(a5RestService,assetId);
                    Assert.assertEquals(ingestStatusCheck(a5RestService,assetId), status, "status was not set to" + status);}
            } else if (status.equals("Null")) {
              Assert.assertNull(ingestStatusNull(a5RestService,assetId));

            }
        }
        if(row.containsKey("clockNumber")) {
            if (row.containsKey("status") && row.get("status").equals("Null")) {
                Assert.assertNull(ingestStatusNull(a5RestService, assetId));
            } else {
                IngestDoc ingestdoc1 = ingestStatusNotNull(a5RestService, assetId);
                Assert.assertEquals(ingestdoc1.getAsset().getUnique(), wrapVariableWithTestSession(row.get("clockNumber")),
                        "ClockNumber was not set to " + "" + wrapVariableWithTestSession(row.get("clockNumber")));
            }
        }

        if(row.containsKey("Title")){
            Assert.assertEquals(ingestdoc.getAsset().getTitle(), wrapVariableWithTestSession(row.get("Title")),
                    "Title was not set to "+""+ wrapVariableWithTestSession(row.get("Title")));
        }

        if(row.containsKey("Advertiser")){
            Assert.assertEquals(ingestdoc.getAsset().getAdvertiser(), wrapVariableWithTestSession(row.get("Advertiser")),
                    "Advertiser was not set to "+""+wrapVariableWithTestSession(row.get("Advertiser")));
        }
        if(row.containsKey("Duration")){
            Assert.assertEquals(ingestdoc.getAsset().getDuration(), wrapVariableWithTestSession(row.get("Duration")),
                    "Duration was not set to "+""+wrapVariableWithTestSession(row.get("Duration")));
        }

        if(row.containsKey("First Air Date")){
            DateTimeUtils dateFormat = new DateTimeUtils();
            String currentDate = dateFormat.formatDate(DateTime.parse(row.get("First Air Date")), "yyyy-MM-dd");
            String actualDate = dateFormat.formatDate(ingestdoc.getAsset().getFirstAirDate(), "yyyy-MM-dd");
            Assert.assertEquals(actualDate, currentDate, "First Air Date was not correct");
        }
    }

    public String ingestStatusCheck(BabylonServiceWrapper a5RestService,String assetId) throws MalformedURLException, UnsupportedEncodingException {
        IngestDoc ingestdoc = a5RestService.getIngestId(assetId);
        int i = 1;
        do {
            if (java.util.Arrays.asList(GDNStatus.INGEST_STATUS_INITIAL.getgdnStatus()).contains(ingestdoc.getStatus())) {
                Common.sleep(sleep);
            }
            ingestdoc = a5RestService.getIngestId(assetId);
            i++;
        }
        while (java.util.Arrays.asList(GDNStatus.INGEST_STATUS_INITIAL.getgdnStatus()).contains(ingestdoc.getStatus()) && i <= 5);

        return ingestdoc.getStatus();
    }

    public String ingestCompletedStatusCheck(BabylonServiceWrapper a5RestService,String assetId) throws MalformedURLException, UnsupportedEncodingException {
        IngestDoc ingestdoc = a5RestService.getIngestId(assetId);
        int i = 1;
        do {
            if (java.util.Arrays.asList(GDNStatus.INGEST_STATUS_COMPLETED.getgdnStatus()).contains(ingestdoc.getStatus())) {
                Common.sleep(sleep);
            }
            ingestdoc = a5RestService.getIngestId(assetId);
            i++;
        }
        while (java.util.Arrays.asList(GDNStatus.INGEST_STATUS_COMPLETED.getgdnStatus()).contains(ingestdoc.getStatus()) && i <= 5);

        return ingestdoc.getStatus();
    }



     public IngestDoc ingestStatusNull(BabylonServiceWrapper a5RestService,String assetId) throws MalformedURLException, UnsupportedEncodingException {
        IngestDoc ingestdoc = a5RestService.getIngestId(assetId);
        int i = 1;
        do {
            if (ingestdoc != null) {
                Common.sleep(sleep);
                }
            ingestdoc = a5RestService.getIngestId(assetId);
            i++;
        }
        while (ingestdoc != null && i <= 5);

        return ingestdoc;
    }

    public IngestDoc ingestStatusNotNull(BabylonServiceWrapper a5RestService,String assetId) throws MalformedURLException, UnsupportedEncodingException {
        IngestDoc ingestdoc = a5RestService.getIngestId(assetId);
        int i = 1;
        do {
            if (ingestdoc == null) {
                Common.sleep(sleep);
            }
            ingestdoc = a5RestService.getIngestId(assetId);
            i++;
        }
        while (ingestdoc == null && i <= 5);

        return ingestdoc;
    }
}
