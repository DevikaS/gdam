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
public class UpdateAsset extends BaseStep{

    private static Logger log = Logger.getLogger(UpdateAsset.class);

    /* Update xml file from the given path Tests/resources/gdntemplates/saveIngest.xml */
    public void saveIngest(String ClockNumber) throws MalformedURLException {
        String filePath = getFilePath("saveIngest.xml");
        try {
            Document doc = ParseDoc.getDocument(filePath);
            updateHeader(doc);
            updateBody(ClockNumber, doc);
            String updatedFileContent = ParseDoc.getUpdatedFileContent(doc);
            try {
                A4RestService a4restservice = new A4RestService(new URL(TestsContext.getInstance().a4host));
                a4restservice.postAsset(updatedFileContent);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (ParserConfigurationException | SAXException | IOException | TransformerException e) {
            e.printStackTrace();
        }
    }

    private void updateHeader(Document doc) {
        Node header = doc.getElementsByTagName("s:Header").item(0);
        NodeList headerNodes = header.getChildNodes();
        for (int i = 0; i < headerNodes.getLength(); i++) {
            Node node = headerNodes.item(i);
            if ("a:To".equals(node.getNodeName())) {
                node.setTextContent(TestsContext.getInstance().a4host + "/AMS/Asset.svc");
            }
        }
    }

    private void updateBody(String clockNumber, Document doc) {
        String fileID = GdnBase.getfileID();
        String assetGuid = GdnBase.getGuidByClock(clockNumber);
        Node saveIngestionDataWithStatus = doc.getElementsByTagName("SaveIngestionDataWithStatus").item(0);
        NodeList childNodes = saveIngestionDataWithStatus.getChildNodes();
        for (int i = 0; i < childNodes.getLength(); i++) {
            Node node = childNodes.item(i);
            switch (node.getNodeName()) {
                case "AssetGuid":
                    node.setTextContent(assetGuid);
                    break;
                case "Filename":
                    node.setTextContent(assetGuid + "_master.mpeg");
                    break;
                case "fileId":
                    node.setTextContent(fileID);
                    break;
                case "SessionID":
                    node.setTextContent(TestsContext.getInstance().sessionID);
                    break;
                default:
            }
        }
    }
}
