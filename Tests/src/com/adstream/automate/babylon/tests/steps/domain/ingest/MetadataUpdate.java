package com.adstream.automate.babylon.tests.steps.domain.ingest;

import com.adstream.automate.babylon.BabylonMessageSender;
import com.adstream.automate.babylon.JsonObjects.gdn.A4RestService;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GdnBase;
import com.adstream.automate.babylon.tests.steps.utils.gdn.ParseDoc;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * Created by Ramababu.Bendalam on 08/02/2016.
 */
public class MetadataUpdate extends BaseStep {

    private static Logger log = Logger.getLogger(MetadataUpdate.class);

    /* Update xml file from the given path Tests/resources/gdntemplates/updatemetadata.xml */
    public void modifymetadata(String clockNumber) throws MalformedURLException {
        String assetGuid = GdnBase.getGuidByClock(clockNumber);
        String filePath = getFilePath("updatemetadata.xml");
        try {
            Document doc = ParseDoc.getDocument(filePath);
            updateDSMetadata(doc, assetGuid);
            updateMetadata(doc, assetGuid);
            updateHeader(doc);
            String updatedFileContent = ParseDoc.getUpdatedFileContent(doc);
            try {
                A4RestService a4restservice = new A4RestService(new URL(TestsContext.getInstance().a4host));
                a4restservice.postMetadata(updatedFileContent);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (IOException | ParserConfigurationException | SAXException | TransformerException e) {
            e.printStackTrace();
        }
    }

    private void updateDSMetadata(Document doc, String assetGuid) {
        Node dsMetadata = doc.getElementsByTagName("dsMetadata").item(0);
        NodeList childNodes = dsMetadata.getChildNodes();
        for (int i = 0; i < childNodes.getLength(); i++) {
            Node node = childNodes.item(i);
            switch (node.getNodeName()) {
                case "ObjectInventoryID":
                    node.setTextContent(assetGuid);
                    break;
                case "StringValue":
                    node.setTextContent(TestsContext.getInstance().storageExtID);
                    break;
                default:
            }
        }
    }

    private void updateMetadata(Document doc, String assetGuid) {
        Node dsMetadata = doc.getElementsByTagName("metadata").item(0);
        NodeList childNodes = dsMetadata.getChildNodes();
        for (int i = 0; i < childNodes.getLength(); i++) {
            Node node = childNodes.item(i);
            if ("ObjectInventoryID".equals(node.getNodeName())) {
                node.setTextContent(assetGuid);
                break;
            }
        }
    }

    private void updateHeader(Document doc) {
        Node header = doc.getElementsByTagName("s:Header").item(0);
        NodeList headerNodes = header.getChildNodes();
        for (int i = 0; i < headerNodes.getLength(); i++) {
            Node node = headerNodes.item(i);
            if ("a:To".equals(node.getNodeName())) {
                node.setTextContent(TestsContext.getInstance().a4host + "/AMS/Metadata.svc");
            }
        }
    }
}
