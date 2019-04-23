package com.adstream.automate.babylon.yadn;

import adstream.yadn.*;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.Xml;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 06.08.13
 * Time: 15:03
 */
public class HardcodedMessageProcessor extends MessageProcessor {
    public HardcodedMessageProcessor(java.util.Properties properties) {
        super(properties);
    }

    @Override
    public String prepareUploadJobResponse(Upload upload) throws Exception {
        UploadJobResponse uploadResponce = objectFactory.createUploadJobResponse();
        uploadResponce.setFileID(Gen.generateGID());
        uploadResponce.setStatus("UploadedToStorage");
        uploadResponce.setFileName(Gen.generateGID());
        uploadResponce.setFileSize(Gen.getInt(99999) + "");
        uploadResponce.setFileDirectory("\\" + Gen.generateGID() + "\\");
        uploadResponce.setMessageID(upload.getExternalID());
        uploadResponce.setMD5(Gen.generateGID());
        uploadResponce.setCRC(Gen.getInt(99999) + "");
        uploadResponce.setNode(upload.getNode());
        uploadResponce.setSpecDBDocID("f2:image:unspecified");
        Metadata uploadMeta = objectFactory.createMetadata();
        Set<String> keys = SpecMap.getMap().keySet();
        int keyIndex = Gen.getInt(keys.size());
        uploadMeta.getProperty().addAll(SpecMap.getMap().get(keys.toArray()[keyIndex]));
        uploadMeta.getProperty().addAll(upload.getMetadata().getProperty());
        uploadResponce.setMetadata(uploadMeta);

        return Xml.convertXmlToString(uploadResponce, UploadJobResponse.class);
    }

    @Override
    public List<String> prepareTranscodeJobResponse(Upload upload) throws Exception {
        TranscodeJobResponse transcodeResponce = objectFactory.createTranscodeJobResponse();
        transcodeResponce.setMessageID(upload.getExternalID());
        transcodeResponce.setStatus("Completed");
        transcodeResponce.setIsDefault("true");
        transcodeResponce.setFileID(Gen.generateGID());
        transcodeResponce.setFileStorage(Gen.generateGID());
        TranscodeFiles transcodeFiles = objectFactory.createTranscodeFiles();
        List<TranscodeProperties> propertiesList = TranscodePropertiesHolder.getAllProperies();
        transcodeFiles.setId(propertiesList.size() + "");
        int i=0;
        for (TranscodeProperties properties: propertiesList) {
            TranscodeFile transcodeFile = objectFactory.createTranscodeFile();
            transcodeFile.setTranscodeProperties(properties);
            transcodeFile.setId(i++  + "");
            transcodeFile.setFileID(Gen.generateGID());
            transcodeFile.setFileDirectory("\\" + Gen.generateGID() + "\\");
            transcodeFile.setFileName(Gen.getString(10));
            transcodeFile.setFileSize(Gen.generateInt(99999));
            transcodeFile.setSpecDBDocID("f1:image:Clapper:PNG:sourceSize:RGB");
            transcodeFiles.getTranscodeFile().add(transcodeFile);
        }

        transcodeResponce.setTranscodeFiles(transcodeFiles);
        return Arrays.asList(Xml.convertXmlToString(transcodeResponce, TranscodeJobResponse.class));
    }
}
