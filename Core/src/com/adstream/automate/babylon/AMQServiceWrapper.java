package com.adstream.automate.babylon;

import com.adstream.gdn.api.client.serialization.DeliveryJobResponse;
import com.adstream.gdn.api.client.serialization.TerminateJobResponse;
import com.adstream.gdn.api.client.serialization.TranscodeJobResponse;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ramababu.Bendalam on 24/07/2017.
 */
public class AMQServiceWrapper {

    private Logger log = Logger.getLogger(this.getClass());
    private AMQService service;

    public AMQServiceWrapper(AMQService service) {
        this.service = service;
    }


    public List<DeliveryJobResponse> receiveDeliveryJobResponseCommon(int count, String response, List<String> deliveryJobExtId) {

        return service.receiveDeliveryJobResponseCommon(count,response,deliveryJobExtId);
    }

    public List<TerminateJobResponse> receiveTerminateJobResponse(int count, String response, List<String> externalID) {

        return service.receiveTerminateJobResponse(count,response,externalID);

    }


    public List<TranscodeJobResponse> receiveTranscodeJobResponseCommon(int count, String response, List<String> externalID) {

        return service.receiveTranscodeJobResponseCommon(count,response,externalID);
    }

    public void closeConnection(){
       service.closeConnection();
    }
}
