package com.adstream.automate.babylon.yadn;

import adstream.yadn.ObjectFactory;
import adstream.yadn.Property;
import adstream.yadn.Upload;
import com.adstream.automate.utils.Xml;
import org.apache.activemq.command.ActiveMQTextMessage;
import org.apache.log4j.Logger;

import javax.jms.JMSException;
import javax.jms.TextMessage;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * User: ruslan.semerenko
 * Date: 20.09.13 17:26
 */
public abstract class MessageProcessor {
    protected final static ObjectFactory objectFactory = new ObjectFactory();
    protected final Logger log = Logger.getLogger(this.getClass());

    public MessageProcessor(Properties properties) {}

    public abstract String prepareUploadJobResponse(Upload upload) throws Exception;
    public abstract List<String> prepareTranscodeJobResponse(Upload upload) throws Exception;

    public List<TextMessage> replyTo(TextMessage message) {
        try {
            if (message.getText().contains("<yadn:Upload")) {
                Upload upload = transformTo(message, Upload.class);
                log.info("Process upload job for file " + getFileName(upload));
                List<TextMessage> replyMessages = new ArrayList<TextMessage>();
                replyMessages.add(prepareReplyMessage(message, prepareUploadJobResponse(upload)));
                for (String jobResponse : prepareTranscodeJobResponse(upload)) {
                    replyMessages.add(prepareReplyMessage(message, jobResponse));
                }
                return replyMessages;
            }
        } catch (Exception e) {
            log.error(e);
        }
        return null;
    }

    protected <E> E transformTo(TextMessage st, Class<E> clazz) {
        try {
            return Xml.xmlStringToClass(clazz, st.getText());
        } catch (Exception e) {
            log.error(e);
        }

        return null;
    }

    protected TextMessage prepareReplyMessage(TextMessage message, String text) throws JMSException {
        TextMessage replyMessage = new ActiveMQTextMessage();
        replyMessage.setJMSPriority(message.getJMSPriority());
        replyMessage.setJMSDeliveryMode(message.getJMSDeliveryMode());
        replyMessage.setJMSDestination(message.getJMSReplyTo());
        replyMessage.setText(text);
        return replyMessage;
    }

    protected Property getPropertyByName(List<Property> properties, String name) {
        for (Property property : properties) {
            if (property.getName().equals(name)) {
                return property;
            }
        }
        return null;
    }

    protected String getFileName(Upload upload) {
        return getPropertyByName(upload.getMetadata().getProperty(), "Path").getValue();
    }
}
