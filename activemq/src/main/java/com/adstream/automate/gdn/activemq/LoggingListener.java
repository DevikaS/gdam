package com.adstream.automate.gdn.activemq;

import org.apache.activemq.command.ActiveMQTextMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 19.03.13
 * Time: 12:58
 */
public abstract class LoggingListener implements MessageListener {
    protected final static Logger log = LoggerFactory.getLogger(LoggingListener.class);
    protected String name = "noname";

    protected TextMessage processMessage(Message message) {
        if (message instanceof TextMessage) {
          try {
               ((TextMessage) message).getText();
               message.getJMSDestination();
               message.getJMSReplyTo();
               message.getJMSPriority();
               return (ActiveMQTextMessage) message;
            }  catch (JMSException e) {
                log.error("Can't extract text from received message", e);
            }
        } else {
            log.warn("Unexpected non-text message received.");
        }
        return null;
    }

    public final void onMessage(Message message) {
        TextMessage textMessage = processMessage(message);
        if (textMessage != null) onMessage(textMessage);
    }

    public abstract void onMessage(TextMessage message);

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
