package com.adstream.automate.babylon.tests.steps.utils.gdn;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;

/**
 * Created by Ramababu.Bendalam on 08/02/2016.
 */
public class ParseDoc {


    public static Document getDocument(String filePath) throws ParserConfigurationException, SAXException, IOException {
        File file = new File(filePath);
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = documentBuilderFactory
                .newDocumentBuilder();
        return dBuilder.parse(file);

    }

    public static Document parseString(String file) throws ParserConfigurationException, IOException, SAXException {
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = documentBuilderFactory
                .newDocumentBuilder();

        return dBuilder.parse(new InputSource(new ByteArrayInputStream(file.getBytes("utf-8"))));
    }

    public static String getUpdatedFileContent(Document doc) throws TransformerException {
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        DOMSource source = new DOMSource(doc);
        ByteArrayOutputStream boas = new ByteArrayOutputStream();
        StreamResult result = new StreamResult(boas);
        transformer.transform(source, result);
        return boas.toString();
    }
}
