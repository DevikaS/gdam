package com.adstream.automate.gdn.activemq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jms.*;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 19.03.13
 * Time: 13:15
 * To change this template use File | Settings | File Templates.
 */
public class Consumer {
    protected final static Logger log = LoggerFactory.getLogger(ActiveMQService.class);
    protected final Destination queue;
    protected final Connection connection;
    private MessageConsumer consumer;
    private Session session;


    public Consumer(Connection connection, Destination queue) {
        this.queue = queue;
        this.connection = connection;

    }

    public void startConsuming(MessageListener messageListener) {
        try {
            // Create a Session
            if (session == null){
                session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            }
            // Create a MessageConsumer from the Session to the Topic or Queue
            //connection.createConnectionConsumer(queue,"*")
            consumer = session.createConsumer(queue);
            consumer.setMessageListener(messageListener);
           // connection.start();
            } catch (JMSException e) {
            log.error(e.toString());
        }
    }

    public void endConsuming() {
        try {
            if (consumer != null) consumer.close();
            if (session != null) session.close();
            } catch (JMSException e) {
            log.error(e.toString());
        }
    }


    public void closeConnection() {
        try {
            if (connection != null) connection.close();
        } catch (JMSException e) {
            log.error(e.toString());
        }
    }




}
