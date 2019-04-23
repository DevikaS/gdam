package com.adstream.automate.babylon;

import com.adstream.gdn.api.client.serialization.DeliveryJobResponse;
import com.adstream.gdn.api.client.serialization.TerminateJobResponse;
import com.adstream.gdn.api.client.serialization.TranscodeJobResponse;

import java.util.List;

/**
 * Created by Ramababu.Bendalam on 24/07/2017.
 */
public interface AMQService {

 public List<DeliveryJobResponse> receiveDeliveryJobResponseCommon(int count, String response, List<String> deliveryJobExtId);
 public List<TerminateJobResponse> receiveTerminateJobResponse(int count, String response, List<String> externalID);
 public List<TranscodeJobResponse> receiveTranscodeJobResponseCommon(int count, String response, List<String> externalID);
 public void closeConnection();
}
