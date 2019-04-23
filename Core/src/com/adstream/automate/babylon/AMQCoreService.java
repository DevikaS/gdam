package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.gdn.Client;
import com.adstream.automate.babylon.JsonObjects.gdn.ClientXmlSerializer;
import com.adstream.automate.gdn.activemq.ActiveMQService;
import com.adstream.gdn.api.client.serialization.DeliveryJobResponse;
import com.adstream.gdn.api.client.serialization.TerminateJobResponse;
import com.adstream.gdn.api.client.serialization.TranscodeJobResponse;
import org.apache.activemq.command.ActiveMQQueue;

import javax.jms.JMSException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ramababu.Bendalam on 25/01/2016.
 */
public class AMQCoreService extends Client implements AMQService {


    protected String systemName;
    protected ClientXmlSerializer serializer = new ClientXmlSerializer();


    public AMQCoreService(ActiveMQService activeMQService) {
           this(TestsContext.getInstance().TestSystemQueue, activeMQService);
    }

    public AMQCoreService(String inQ, ActiveMQService amq) {
           this(inQ,amq, "adbank5");

    }

    public AMQCoreService(String inQ, ActiveMQService activeMQService, String systemName) {
        super(new ActiveMQQueue(inQ), activeMQService);
        this.systemName = systemName;
    }


    @Override
    protected String getName() {
        return getSystemName();
    }

    public String getSystemName() {
        return systemName;
    }

    public String getInQ() {
        return inQ.toString().replaceAll("queue://", "");

    }

    public void closeConnection(){

        try {
            getConsumer().closeConnection();
        } catch (JMSException e) {
            log.error(e.toString());
        }
    }


    public List<DeliveryJobResponse> receiveDeliveryJobResponseCommon(int count, String response, List<String> deliveryJobExtId) {
        List<DeliveryJobResponse> deliveryJobResponseList = new ArrayList<>();
        for (String jobResponse : consume(count, 60 * 60 * 100, true, response,deliveryJobExtId.toArray(new String[deliveryJobExtId.size()]))) {
            deliveryJobResponseList.add((DeliveryJobResponse) serializer.deserializeJobResponseJava(jobResponse));
        }
        return deliveryJobResponseList;
    }

    public List<TerminateJobResponse> receiveTerminateJobResponse(int count, String response, List<String> externalID) {
        List<TerminateJobResponse> terminateJobResponseList = new ArrayList<>();
        for (String jobResponse : consume(count, 60 * 60 * 100, true, response,externalID.toArray(new String[externalID.size()]))) {
            terminateJobResponseList.add((TerminateJobResponse) serializer.deserializeJobResponseJava(jobResponse));
        }
        return terminateJobResponseList;

        }


    public List<TranscodeJobResponse> receiveTranscodeJobResponseCommon(int count, String response, List<String> externalID) {
        List<TranscodeJobResponse> transcodeJobResponseList = new ArrayList<TranscodeJobResponse>();
        for (String jobResponse : consume(count, 60 * 60 * 100, true, response,externalID.toArray(new String[externalID.size()]))) {
            transcodeJobResponseList.add((TranscodeJobResponse) serializer.deserializeJobResponseJava(jobResponse));
        }
        return transcodeJobResponseList;
    }

}
