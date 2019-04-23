package com.adstream.automate.babylon.migration.scripts;

import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import com.adstream.automate.utils.Common;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/9/14
 * Time: 9:37 AM

 */
public class ParentScript {

    public static Document initXMLDocument() {
        return initXMLDocument(XMLParser.getFilePath());
    }

    public static Document initXMLDocument(String filePath) {
        DocumentBuilderFactory dbf =
                DocumentBuilderFactory.newInstance();
        DocumentBuilder db = null;
        Document doc = null;
        try {
            db = dbf.newDocumentBuilder();
            try {
                doc = db.parse (new File(filePath));
            } catch (SAXException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        }
        return doc;
    }

    public static File writeDocument(Document doc, String filePath) {
        Transformer transformer = null;
        FileManager.saveIntoFile(filePath, "");
        try {
            transformer = TransformerFactory.newInstance().newTransformer();
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");

        StreamResult result = new StreamResult(new StringWriter());

        DOMSource source = new DOMSource(doc);
        try {
            transformer.transform(source, result);
        } catch (TransformerException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        String xmlString = result.getWriter().toString();
        Common.sleep(10000);
        FileManager.saveIntoFile(filePath, xmlString);
        return new File(filePath);
    }

}
