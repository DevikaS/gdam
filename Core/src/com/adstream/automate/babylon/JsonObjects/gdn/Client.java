package com.adstream.automate.babylon.JsonObjects.gdn;

import com.adstream.automate.gdn.activemq.ActiveMQService;
import com.adstream.automate.gdn.activemq.Consumer;
import com.adstream.automate.gdn.activemq.Listener;
import com.adstream.automate.gdn.activemq.LoggingListener;
import com.adstream.automate.gdn.activemq.Producer;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Xml;
import org.apache.commons.lang.ArrayUtils;
import com.adstream.automate.gdn.activemq.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.TextMessage;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;


/**
 * Created by Ramababu.Bendalam on 25/01/2016.
 */
public abstract class Client {

    protected final static Logger log = LoggerFactory.getLogger(Client.class);
    protected final Destination inQ;
    //  protected final Destination outQ;
    protected final ActiveMQService activeMQService;
    BlockingQueue<TextMessage> drop;
    private Consumer consumer;
    private Producer producer;
    private long defaultTimeout;
    protected LoggingListener listener;

    protected abstract String getName();



    public Client(Destination inQ, ActiveMQService activeMQService) {
        this.inQ = inQ;
        this.activeMQService = activeMQService;
        setDefaultTimeout(3);
    }

    public static String[] removeNullAndEmptyElements(String[] stringArray) {
        List<String> list = new ArrayList<String>();
        for (String s : stringArray) {
            if (s != null && s.length() > 0) {
                list.add(s);
            }
        }
        return list.toArray(new String[list.size()]);
    }


    public void setDefaultTimeout(int minutes) {
        defaultTimeout = minutes * 60 * 1000;
    }


    public <E> List<E> transformTo(List<TextMessage> st, Class<E> clazz) {
        List<E> result = new ArrayList<E>();
        for (TextMessage s : st) {
            try {
                result.add(Xml.xmlStringToClass(clazz, s.getText()));
            } catch (Exception e) {
                log.error(e.toString());
            }
        }
        return result;
    }

    public Consumer getConsumer() throws JMSException {
        if (consumer == null) {
            consumer = activeMQService.createConsumer(inQ);
        }
        return consumer;
    }

    public Producer getProducer() throws JMSException {
        if (producer == null) {
            producer = activeMQService.createProducer();
            producer.setName(getName());
        }
        return producer;
    }

    protected LoggingListener getListener() {
        if (null == listener) {
            listener = new Listener(getMessageQ()) {
            };
            listener.setName(getName());
        }
        return listener;
    }

    protected BlockingQueue<TextMessage> getMessageQ() {
        if (drop == null) {
            drop = new LinkedBlockingQueue<TextMessage>();
        }
        return drop;
    }

    public void startConsuming() {
        try {
            getConsumer().startConsuming(getListener());
        } catch (JMSException e) {
            log.error(e.toString());
        }
    }

    public void stopConsuming() {
        try {
            getConsumer().endConsuming();
        } catch (JMSException e) {
            log.error(e.toString());
        }
    }

   public List<String> unpackConsumedMessages(List<TextMessage> messages) {
        List<String> unpackedMessages = new ArrayList<String>();
        for (TextMessage textMessage : messages) {
            try {
                unpackedMessages.add(textMessage.getText());
            } catch (JMSException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        }
        return unpackedMessages;
    }

    public List<String> consume(int expectedCount, long timeout, boolean expectEmptyResult, String response, String... filters) {
        return consume(expectedCount, timeout, expectEmptyResult, true,response, filters);
    }

    public List<String> consume(int expectedCount, long timeout, boolean expectEmptyResult, boolean throwErrorIfNoMessage,String response, String... filters) {
        int totalGot = 0;
        List<TextMessage> filteredMessages = new ArrayList<TextMessage>();
        long exitTime = System.currentTimeMillis() + timeout;
        startConsuming();
        while (System.currentTimeMillis() < exitTime) {
            List<TextMessage> filter = filter(deQMessages(getMessageQ()),response, filters);
            filteredMessages.addAll(filter);
            totalGot += filteredMessages.size();
            if (filteredMessages.size() > 0 || filters.length == 0) {
               if (filteredMessages.size() >= expectedCount) {
                    stopConsuming();
                    return unpackConsumedMessages(filteredMessages);
                }
            }
            Common.sleep(1000);
        }
        stopConsuming();
        if (expectEmptyResult) {
            return unpackConsumedMessages(filteredMessages);
        }
        if (throwErrorIfNoMessage)
            throw new Error("Time Out after " + timeout / 1000 + "sec, message filter " + ArrayUtils.toString(filters));
        return null;
    }

    protected List<TextMessage> deQMessages(BlockingQueue<TextMessage> q) {
        List<TextMessage> result = new ArrayList<TextMessage>();
        while (q.size() > 0) {
            try {
                result.add(q.take());
            } catch (InterruptedException e) {
                log.error(e.toString());
                e.printStackTrace();
            }
        }
        return result;
    }

    protected String getText(TextMessage message) {
        if (message == null) return "";
        String text = "";
        try {
            text = message.getText();
        } catch (JMSException e) {
            log.error(e.toString());
            e.printStackTrace();
        }
        return text;
    }

    protected List<TextMessage> filter(List<TextMessage> messages,String response, String... filters) {
        List<TextMessage> result = new ArrayList<TextMessage>();
        for (TextMessage message : messages) {
            /*
            *  Catch UnknownMessageException for job
            * */
//            String[] tempFilters = new String[filters.length + 1];
//            tempFilters[0] = "UnknownMessageException";
//            for (int i = 0; i < filters.length; i++)
//            {
//                tempFilters[i + 1] = filters[i].replace("JobResponse", "Job");
//            }
//            boolean expectUME = false;
//            for (String f : filters)
//            {
//                if (f.contains(tempFilters[0]))
//                {
//                    expectUME = true;
//                }
//            }
//            if (expectUME) {
//                if (isMessageNotAcceptable(message, tempFilters)) {
//                    result.add(message);
//                }
//            } else {
//                if (isMessageNotAcceptable(message, tempFilters)) {
//                    log.error(message.toString());
//                    throw new Error("UnknownMessageException message received for sent job");
//                }

            if (isMessageAcceptable(message,response, filters)) {
                result.add(message);
            }
        }
        return result;
    }

    protected boolean isMessageNotAcceptable(TextMessage message, String... filters) {
        String[] notNullFilters = removeNullAndEmptyElements(filters);
        int matchesCount = 0;
        for (String filter : notNullFilters) {
            if (getText(message).contains(filter)) {
                matchesCount++;
            }
        }
        return matchesCount == notNullFilters.length;
    }

    protected boolean isMessageAcceptable(TextMessage message,String response, String... filters) {
        String[] notNullFilters = removeNullAndEmptyElements(filters);
        for (String filter : notNullFilters) {
            if (getText(message).contains(filter) && getText(message).contains(response)) {
                return true;
            }
        }
        return false;
    }

}



