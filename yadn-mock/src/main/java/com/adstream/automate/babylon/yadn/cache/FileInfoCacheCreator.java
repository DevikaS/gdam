package com.adstream.automate.babylon.yadn.cache;

import adstream.yadn.*;
import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.gdn.activemq.ActiveMQService;
import com.adstream.automate.gdn.activemq.Consumer;
import com.adstream.automate.gdn.activemq.LoggingListener;
import com.adstream.automate.gdn.activemq.Producer;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.IO;
import com.adstream.automate.utils.Xml;
import org.apache.activemq.command.ActiveMQQueue;
import org.apache.activemq.command.ActiveMQTextMessage;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.TextMessage;
import javax.xml.bind.JAXBException;
import java.io.File;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * User: ruslan.semerenko
 * Date: 20.09.13 11:16
 */
public class FileInfoCacheCreator extends LoggingListener {
    private final static Logger log = Logger.getLogger(FileInfoCacheCreator.class);
    private static String[] filesDirectories;
    private static String outputDirectory;
    private static String amqIn;
    private static String amqOut;
    private static URL uploadUrl;
    private static String adgateNodeId;
    private final Destination inQ;
    private final ActiveMQService activeMQService;
    private Producer producer;
    private Consumer consumer;
    private BabylonServiceWrapper uploader;
    // FileID -> FileName
    private Map<String, String> filesCache = new HashMap<>();
    // FileID -> count
    private Map<String, Integer> transcodingJobsCount = new HashMap<>();

    public static void main(String[] args) throws Exception {
        Properties properties = IO.getProperties(new File("cache.creator.properties"));
        amqIn = properties.getProperty("activeMQ_queue_in", "adstream.yadn.response.fake");
        amqOut = properties.getProperty("activeMQ_queue_out", "adstream.yadn");
        String activeMQService = properties.getProperty("activeMQ_service", "failover:(tcp://10.0.25.17:61616)");
        uploadUrl = new URL(properties.getProperty("upload_url", "http://10.0.26.9:8484/adgate/files/a5_auto_incoming/"));
        adgateNodeId = properties.getProperty("adgate_node_id", "d7acf7be-9e69-4b66-9813-7fe2fed203fe");
        filesDirectories = properties.getProperty("files_directories", "").split(",");
        outputDirectory = properties.getProperty("output_directory", "xml");

        PropertyConfigurator.configure("log4j.properties");
        FileInfoCacheCreator service = new FileInfoCacheCreator(new ActiveMQQueue(amqIn), new ActiveMQService(activeMQService));
        service.startConsuming();
        service.sendUploadMessages();
    }

    public FileInfoCacheCreator(Destination inQ, ActiveMQService activeMQService) {
        this.inQ = inQ;
        this.activeMQService = activeMQService;
        createUploader();
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

    public void sendUploadMessages() {
        for (String filesDirectory : filesDirectories) {
            File dir = new File(filesDirectory);
            if (dir.exists() && dir.isDirectory()) {
                processDirectory(dir);
            }
        }
    }

    private void processDirectory(File dir) {
        File[] files = dir.listFiles();
        if (files == null) {
            files = new File[0];
        }
        for (File file : files) {
            if (file.isDirectory()) {
                continue;
            }
            try {
                log.info("Upload file: " + file.getAbsolutePath());
                //todo add case for GDN
                Map<String, String> uploadResult = uploader.prepareFileToUpload(file, null);
                String message = generateUploadMessage(file, uploadResult.get("tmpPath"));
                sendMessage(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private String generateUploadMessage(File file, String tmpPath) throws JAXBException {
        ObjectFactory of = new ObjectFactory();
        String elementId = Gen.generateGID(24);

        Metadata meta = of.createMetadata();
        meta.setId("2");
        Property prop = of.createProperty();
        prop.setName("isPlayout"); prop.setValue("false");
        meta.getProperty().add(prop);
        prop = of.createProperty();
        prop.setName("ElementID"); prop.setValue(elementId);
        meta.getProperty().add(prop);
        prop = of.createProperty();
        prop.setName("Path"); prop.setValue(file.getName());
        meta.getProperty().add(prop);
        prop = of.createProperty();
        prop.setName("Country"); prop.setValue("AF");
        meta.getProperty().add(prop);
        prop = of.createProperty();
        prop.setName("guise"); prop.setValue("master");
        meta.getProperty().add(prop);

        Upload upload = of.createUpload();
        upload.setArchive("false");
        upload.setExternalID("1.1|akka://KV01V-A5DA502/user/head/fsobject|" + elementId + "#1");
        upload.setFile(tmpPath);
        upload.setId("1");
        upload.setMetadata(meta);
        upload.setNode(adgateNodeId);
        upload.setSystem("adbank5");

        return Xml.convertXmlToString(upload);
    }

    private void sendMessage(String text) throws JMSException {
        // remove additional attributes due to SQL Exception in Fortress happens
        text = text.replace("encoding=\"UTF-8\" standalone=\"yes\"", "");
        TextMessage message = new ActiveMQTextMessage();
        message.setJMSDestination(new ActiveMQQueue(amqOut));
        message.setJMSReplyTo(new ActiveMQQueue(amqIn));
        message.setText(text);
        getProducer().produce(message);
    }

    private void createUploader() {
        uploader = new BabylonServiceWrapper(new FakeBabylonService(uploadUrl, Gen.generateGID(24)));
        uploader.logIn("", "");
    }

    public void onMessage(TextMessage message) {
        try {
            String text = getMessageBody(message);
            if (text.contains("<UploadJobResponse")) {
                processUploadJobResponse(text);
            } else if (text.contains("<TranscodeJobResponse")) {
                processTranscodeJobResponse(text);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String getMessageBody(TextMessage message) throws JMSException {
        String text = message.getText();
        int spacePosition = text.indexOf(" ");
        log.info("Got message: " + text.substring(1, spacePosition));
        return text;
    }

    private void processUploadJobResponse(String text) throws JAXBException {
        UploadJobResponse response = Xml.xmlStringToClass(UploadJobResponse.class, text);
        if (response.getStatus().equals("UploadedToStorage")) {
            String path = String.valueOf(System.currentTimeMillis());
            for (Property property : response.getMetadata().getProperty()) {
                if (property.getName().equals("Path")) {
                    path = property.getValue();
                }
            }
            saveXmlToFile(text, path + "-upl.xml");
            filesCache.put(response.getFileID(), path);
        }
    }

    private void processTranscodeJobResponse(String text) throws JAXBException {
        TranscodeJobResponse response = Xml.xmlStringToClass(TranscodeJobResponse.class, text);
        if (response.getStatus().equals("Completed")) {
            String fileId = response.getFileID();
            int counter = 0;
            if (transcodingJobsCount.containsKey(fileId)) {
                counter = transcodingJobsCount.get(fileId);
            }
            saveXmlToFile(text, filesCache.get(fileId) + "-" + counter + "-tcd.xml");
            transcodingJobsCount.put(fileId, counter + 1);
        }
    }

    private void saveXmlToFile(String text, String fileName) {
        log.info("Save file: " + fileName);
        IO.saveTextFile(new File(outputDirectory, fileName), text);
    }
}
