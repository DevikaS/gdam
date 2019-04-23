package com.adstream.automate.babylon.yadn;

import com.adstream.automate.gdn.activemq.*;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.IO;
import org.apache.activemq.command.ActiveMQQueue;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.TextMessage;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 05.08.13
 * Time: 16:01
 */
public class YADNMockService extends LoggingListener {
    protected final static Logger log = Logger.getLogger(YADNMockService.class);
    private static Properties properties;
    private static long delayBetweenMessagesMs;
    private static int messageSenderPoolThreadsCount;
    private static String messageProcessorClass;
    protected final Destination inQ;
    protected final ActiveMQService activeMQService;
    private Producer producer;
    private Consumer consumer;
    private ExecutorService messageSenderPool;
    private int messagesReceived = 0;
    private MessageProcessor messageProcessor;

    public static void main(String[] args){
        properties = IO.getProperties(new File("default.properties"));
        String activeMQQueue = properties.getProperty("activeMQ_queue","adstream.yadn.fake");
        String activeMQService = properties.getProperty("activeMQ_service","failover:(tcp://10.44.202.19:61616)");
        boolean matchExtensionToMediatype = Boolean.getBoolean(properties.getProperty("match_extension_to_mediatype","false")); //true - otherwise it will randomize
        delayBetweenMessagesMs = Long.parseLong(properties.getProperty("delay_between_messages_ms", "0"));
        messageSenderPoolThreadsCount = Integer.parseInt(properties.getProperty("message_sender_pool_threads_count", "4"));
        messageProcessorClass = properties.getProperty("message_processor_class", "com.adstream.automate.babylon.yadn.HardcodedMessageProcessor");

        PropertyConfigurator.configure("log4j.properties");
        YADNMockService service = new YADNMockService(new ActiveMQQueue(activeMQQueue),
                new ActiveMQService(activeMQService));
        service.startConsuming();
    }

    public YADNMockService(Destination inQ, ActiveMQService activeMQService) {
        this.inQ = inQ;
        this.activeMQService = activeMQService;
        messageSenderPool = Executors.newFixedThreadPool(messageSenderPoolThreadsCount);
        try {
            messageProcessor = (MessageProcessor) Class.forName(messageProcessorClass).getConstructor(Properties.class).newInstance(properties);
        } catch (Exception e) {
            throw new RuntimeException("Could not initialize message processor", e);
        }
    }

    protected Producer getProducer() throws JMSException {
        if (producer == null) {
            producer = activeMQService.createProducer();
        }
        return producer;
    }

    protected Consumer getConsumer() throws JMSException {
        if (consumer == null) {
            consumer = activeMQService.createConsumer(inQ);
        }
        return consumer;
    }

    protected void startConsuming() {
        try {
            getConsumer().startConsuming(this);
        } catch (JMSException e) {
            log.error(e);
        }
    }

    protected void stopConsuming() {
        try {
            getConsumer().endConsuming();
        } catch (JMSException e) {
            log.error(e);
        }
    }

    protected void sendTextMessage(List<TextMessage> messages) {
        if (messages == null) return;
        try {
            Iterator<TextMessage> messageIterator = messages.iterator();
            while (messageIterator.hasNext()) {
                getProducer().produce(messageIterator.next());
                if (messageIterator.hasNext()) {
                    Common.sleep(delayBetweenMessagesMs);
                }
            }
        } catch (Exception e) {
            log.error(e);
        }
    }

    @Override
    public void onMessage(final TextMessage message) {
        messageSenderPool.execute(new Runnable() {
            @Override
            public void run() {
                sendTextMessage(messageProcessor.replyTo(message));
            }
        });
        log.info("Processed " + ++messagesReceived + " messages");
    }
}
