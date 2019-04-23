package com.adstream.automate.gdn.activemq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jms.*;;



/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 19.03.13
 * Time: 14:45
 * To change this template use File | Settings | File Templates.
 */
public class Producer {
    protected final static Logger log = LoggerFactory.getLogger(ActiveMQService.class);
    protected final Connection connection;
    private String name = "no name producer";

    public Producer(Connection connection) {
        this.connection = connection;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void produce(TextMessage message) throws JMSException {
        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        try {
            MessageProducer producer = session.createProducer(message.getJMSDestination());
            producer.setDeliveryMode(DeliveryMode.PERSISTENT);
            log.debug("OUT Message: " + message.getText() + "\n To: " + message.getJMSDestination() + "\n Replay to: " + message.getJMSReplyTo());
            producer.send(message);
        } catch (Exception e) {
            log.error(e.toString());
        } finally {
            session.close();
        }
    }
}
