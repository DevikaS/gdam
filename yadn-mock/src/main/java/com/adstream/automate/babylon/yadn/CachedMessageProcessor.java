package com.adstream.automate.babylon.yadn;

import adstream.yadn.*;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.Xml;
import org.apache.commons.io.IOUtils;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

/**
 * User: ruslan.semerenko
 * Date: 20.09.13 17:28
 */
public class CachedMessageProcessor extends MessageProcessor {
    private boolean randomFileGUID;
    // FileName -> XML
    private Map<String, String> uploadMessages = new HashMap<String, String>();
    private Map<String, List<String>> transcodeMessages = new HashMap<String, List<String>>();

    public CachedMessageProcessor(java.util.Properties properties) {
        super(properties);
        String xmlDirectory = properties.getProperty("com.adstream.automate.babylon.yadn.CachedMessageProcessor.xmlDirectory");
        randomFileGUID = Boolean.parseBoolean(
                properties.getProperty("com.adstream.automate.babylon.yadn.CachedMessageProcessor.randomFileGUID", "true"));
        if (xmlDirectory == null) {
            throw new IllegalArgumentException("Please define com.adstream.automate.babylon.yadn.CachedMessageProcessor.xmlDirectory property");
        }
        try {
            loadXmlFiles(xmlDirectory);
        } catch (IOException e) {
            throw new RuntimeException("Could not load xml cache", e);
        }
    }

    private void loadXmlFiles(String xmlDirectory) throws IOException {
        File[] files = new File(xmlDirectory).listFiles();
        if (files != null) {
            for (File file : files) {
                String fileName = file.getName();
                String xml = new String(IOUtils.toByteArray(new FileReader(file)));
                if (fileName.endsWith("-upl.xml")) {
                    fileName = fileName.substring(0, fileName.length() - "-upl.xml".length());
                    uploadMessages.put(fileName, xml);
                } else if (fileName.endsWith("-tcd.xml")) {
                    fileName = fileName.substring(0, fileName.length() - "-*-tcd.xml".length());
                    if (!transcodeMessages.containsKey(fileName)) {
                        transcodeMessages.put(fileName, new ArrayList<String>());
                    }
                    List<String> messages = transcodeMessages.get(fileName);
                    messages.add(xml);
                }
            }
            log.info(String.format("Xml cache load complete. Processed %d files.", files.length));
        } else {
            throw new IllegalArgumentException("Could not found directory " + xmlDirectory);
        }
    }

    private <T> T getResponse(Upload upload, Map<String, T> map) {
        String fileName = getFileName(upload);
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
        Property randomFileNameProperty = getPropertyByName(upload.getMetadata().getProperty(), "RandomFileName");
        String randomFileName = randomFileNameProperty == null ? null : randomFileNameProperty.getValue();
        if (map.containsKey(fileName)) {
            log.debug("Message found by file name");
            return map.get(fileName);
        } else if (map.containsKey(ext)) {
            log.debug("Message found by file extension");
            return map.get(ext);
        } else if (map == uploadMessages) {
            List<String> keys = new ArrayList<String>(map.keySet());
            String key = keys.get(Gen.getInt(keys.size()));
            log.debug("Get random message. Set message as " + key);
            upload.getMetadata().getProperty().add(new Property("RandomFileName", key));
            return map.get(key);
        } else if (map.containsKey(randomFileName)) {
            log.debug("Set transcode message for random file");
            return map.get(randomFileName);
        } else {
            log.debug("Transcode message not found");
            return (T) new ArrayList<String>();
        }
    }

    private String getExtension(Upload upload) {
        String fileName = getFileName(upload);
        int dotPosition = fileName.lastIndexOf(".");
        return dotPosition == -1 ? "" : fileName.substring(dotPosition);
    }

    private String getElementId(String externalId) {
        int start = externalId.lastIndexOf("|") + 1;
        int end = externalId.indexOf("#", start);
        return externalId.substring(start, end);
    }

    private String getFileId(Upload upload) {
        List<Property> properties = upload.getMetadata().getProperty();
        Property property = getPropertyByName(properties, "FileID");
        if (property == null) {
            property = new Property("FileID", UUID.randomUUID().toString());
            properties.add(property);
        }
        return property.getValue();
    }

    @Override
    public String prepareUploadJobResponse(Upload upload) throws Exception {
        String xml = getResponse(upload, uploadMessages);
        UploadJobResponse jobResponse = Xml.xmlStringToClass(UploadJobResponse.class, xml);
        if (randomFileGUID) {
            String ext = getExtension(upload);
            jobResponse.setFileID(getFileId(upload));
            jobResponse.setFileName(getFileId(upload) + ext);
        }
        jobResponse.setMessageID(upload.getExternalID());
        getPropertyByName(jobResponse.getMetadata().getProperty(), "ElementID").setValue(getElementId(upload.getExternalID()));
        jobResponse.setNode(upload.getNode());
        return Xml.convertXmlToString(jobResponse, UploadJobResponse.class);
    }

    @Override
    public List<String> prepareTranscodeJobResponse(Upload upload) throws Exception {
        List<String> responses = new ArrayList<String>();
        for (String xml : getResponse(upload, transcodeMessages)) {
            TranscodeJobResponse jobResponse = Xml.xmlStringToClass(TranscodeJobResponse.class, xml);
            jobResponse.setMessageID(upload.getExternalID());
            if (randomFileGUID) {
                jobResponse.setFileID(getFileId(upload));
                for (TranscodeFile transcodeFile : jobResponse.getTranscodeFiles().getTranscodeFile()) {
                    transcodeFile.setFileID(UUID.randomUUID().toString());
                    transcodeFile.setFileName(transcodeFile.getFileName().replaceFirst("\\w{8}(-\\w{4}){4}\\w{8}", getFileId(upload)));
                }
            }
            responses.add(Xml.convertXmlToString(jobResponse));
        }
        return responses;
    }
}
