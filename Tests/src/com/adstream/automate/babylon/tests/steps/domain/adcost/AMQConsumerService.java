package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.AMQRequestQueue;
import com.adstream.automate.babylon.TestsContext;
import com.google.gson.Gson;
import org.apache.activemq.ActiveMQSslConnectionFactory;
import javax.jms.*;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class AMQConsumerService {

    private static final String BROKERKEYSTORE = "broker.ks";
    private static final String BROKERKEYPASSWORD = "adstream";
    private static final String TRUSTSTORE = "client.ks";
    private static final String TRUSTSTOREPASSWORD = "adstream";
    private static final String PUBLICAMQUSERNAME = "admin";
    private static final String PUBLICAMQPASSWORD = "xiet2jei7ohF";
    private static Map<String, AMQRequestQueue> queueMap = new ConcurrentHashMap<String, AMQRequestQueue>();

    public void removeMessageFromQueue(String key){ queueMap.remove(key); }

    public Map<String, AMQRequestQueue> consumeAMQMessages(){
        try {
            AMQRequestQueue queue=null;
            Gson gson = new Gson();
            ActiveMQSslConnectionFactory sslConnectionFactory = new ActiveMQSslConnectionFactory();
            sslConnectionFactory.setKeyStore(BROKERKEYSTORE);
            sslConnectionFactory.setKeyStorePassword(BROKERKEYPASSWORD);
            sslConnectionFactory.setTrustStore(TRUSTSTORE);
            sslConnectionFactory.setTrustStorePassword(TRUSTSTOREPASSWORD);
            sslConnectionFactory.setUserName(PUBLICAMQUSERNAME);
            sslConnectionFactory.setPassword(PUBLICAMQPASSWORD);

            sslConnectionFactory.setBrokerURL(TestsContext.getInstance().amqExternalHostName.toString());
            Connection con = sslConnectionFactory.createConnection();
            Session session = con.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Destination destination = session.createQueue(TestsContext.getInstance().amqAdcostExternalQueue.toString());
            MessageConsumer consumer = session.createConsumer(destination);
            con.start();

            while(true) {
                Message message = consumer.receive(1000);
                if (message instanceof TextMessage) {
                    TextMessage textMessage = (TextMessage) message;
                    String text = textMessage.getText();
                    queue = gson.fromJson(text,AMQRequestQueue.class);
                    try {
                        queueMap.put(queue.getAction().getPayload().getCostNumber(),queue);
                    } catch(Exception e){
                        continue;
                    }
                } else {
                    con.stop();
                    break;
                }
            }
            consumer.close();
            session.close();
            con.stop();
            con.close();
            return queueMap;
        } catch (Exception e) {
            throw new Error(e);
        }
    }
}