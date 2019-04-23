package com.adstream.automate.babylon.tests.steps.domain.ingest;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNDeliveryDoc;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNDestinations;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNStatus;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.tests.steps.domain.ordering.OrderingHelperSteps;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.TimeoutException;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

/**
 * Created by Ramababu.Bendalam on 01/11/2016.
 */
public class GdnDocFinder extends OrderingHelperSteps {


    public final long sleep = 8000; //8 sec

    public void deliveryDocCheck(BabylonServiceWrapper a5RestService,String clockNumber, String userId, long timeOut) throws MalformedURLException, UnsupportedEncodingException {
        int i = 1;
        List<GDNDeliveryDoc> gdnDeliveryDoc = a5RestService.getDeliveryDoc(clockNumber, userId);
        do {
            if (gdnDeliveryDoc == null){
                Common.sleep(timeOut);}
            gdnDeliveryDoc = a5RestService.getDeliveryDoc(clockNumber, userId);
            i++;
        } while (gdnDeliveryDoc == null && i<=5);
    }

    public void deliveryStatusCheck(BabylonServiceWrapper a5RestService,String clockNumber, String userId, int j,int k, long timeOut) throws MalformedURLException, UnsupportedEncodingException {
        List<GDNDeliveryDoc> gdnDeliveryDoc = a5RestService.getDeliveryDoc(clockNumber, userId);
        List<GDNDestinations> destinations = gdnDeliveryDoc.get(k).getDestinations();

            int i = 1;
            do {
                if (java.util.Arrays.asList(GDNStatus.GDN_STATUS_INITIAL.getgdnStatus()).contains(destinations.get(j).getGdnStatus())) {
                    Common.sleep(timeOut);
                }
                gdnDeliveryDoc = a5RestService.getDeliveryDoc(clockNumber, userId);
                destinations = gdnDeliveryDoc.get(k).getDestinations();
                i++;
            }
            while (java.util.Arrays.asList(GDNStatus.GDN_STATUS_INITIAL.getgdnStatus()).contains(destinations.get(j).getGdnStatus()) && i <= 5);

        }



}
