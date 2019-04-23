package com.adstream.automate.babylon.migration.scripts;

import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.utils.Xml;
import org.apache.commons.io.IOUtils;
import org.apache.xerces.dom.DOMOutputImpl;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;

import javax.xml.namespace.QName;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.*;
import java.util.List;

public class AdaptMigrationXml {
    private static final String XML_FILE_NAME = "2015-3-10T11-56-24_JWT Amsterdam Agency_0000.xml";
    private static final String XML_FILE_NAME_ADAPTED_SUFFIX = "_adapted";

    private static final boolean RENAME_AGENCY = true;
    private static final String NEW_AGENCY_NAME = "Homefree Film";
    private static final boolean RENAME_ASSETS_ORIGINATOR = true;

    private static final boolean REMOVE_USERS = true;
    private static final String UNIQUE_USER_SUFFIX = "homefree.film";

    public static void main(String[] args) {
        Document xml = parseXmlDocument();
        Node dataSet = getNodeByXpath(xml.getDocumentElement(), "/NewDataSet");

        addAllInfoAboutAsset();

        String oldAgencyName = getStringByXpath(dataSet, "Agency/AgencyName");
        String primaryUserId;
        if (RENAME_AGENCY) {
            getNodeByXpath(dataSet, "Agency/AgencyName").setTextContent(NEW_AGENCY_NAME);
        }
        if (REMOVE_USERS) {
            primaryUserId = getNodeByXpath(dataSet, "User[AgencyName[text()='" + oldAgencyName +"']]/UserGUID").getTextContent();
            getNodeByXpath(dataSet, "Agency/PrimaryUserGUID").setTextContent(primaryUserId);
            NodeList users = getNodesByXpath(dataSet, "User");
            for (int i = 0; i < users.getLength(); i++) {
                System.out.println("Processing user " + (i + 1) + "/" + users.getLength());
                Node user = users.item(i);
                if (primaryUserId.equals(getStringByXpath(user, "UserGUID"))) {
                    getNodeByXpath(user, "Password").setTextContent("Adstream01");
                    getNodeByXpath(user, "FirstName").setTextContent("Migration");
                    getNodeByXpath(user, "LastName").setTextContent("User");
                    getNodeByXpath(user, "Email").setTextContent("migration.user." + UNIQUE_USER_SUFFIX + "@adbank.me");
                    getNodeByXpath(user, "Disabled").setTextContent("false");
                    getNodeByXpath(user, "IsDeptAdmin").setTextContent("true");
                    Node agencyGuid = getNodeByXpath(dataSet, "Agency/AgencyGUID");
                    Node userAgencyGuid = getNodeByXpath(user, "AgencyGUID");
                    if (userAgencyGuid == null) {
                        user.appendChild(agencyGuid.cloneNode(true));
                    } else {
                        userAgencyGuid.setTextContent(agencyGuid.getTextContent());
                    }
                    if (RENAME_AGENCY) {
                        getNodeByXpath(user, "AgencyName").setTextContent(NEW_AGENCY_NAME);
                    }
                } else {
                    dataSet.removeChild(user);
                }
            }
        }

        // process assets
        NodeList assets = getNodesByXpath(dataSet, "Asset");
        for (int i = 0; i < assets.getLength(); i++) {
            System.out.println("Processing asset " + (i + 1) + "/" + assets.getLength());
            Node asset = assets.item(i);
            if (REMOVE_USERS) {
                getNodeByXpath(asset, "CreatedBy").setTextContent(primaryUserId);
                getNodeByXpath(asset, "LastUpdatedBy").setTextContent(primaryUserId);
            }
            if (RENAME_AGENCY && RENAME_ASSETS_ORIGINATOR) {
                getNodeByXpath(asset, "AgencyName").setTextContent(NEW_AGENCY_NAME);

            }
        }
        if (RENAME_AGENCY) {
            NodeList proxyAssets = getNodesByXpath(dataSet, "ProxyAsset");
            for (int i = 0; i < proxyAssets.getLength(); i++) {
                System.out.println("Processing proxyAsset " + (i + 1) + "/" + proxyAssets.getLength());
                Node proxyAsset = proxyAssets.item(i);
                getNodeByXpath(proxyAsset, "AgencyName").setTextContent(NEW_AGENCY_NAME);
            }
        }

        //writeResult(xml);
        System.out.println("Done");
    }

    public static void addAllInfoAboutAsset() {
        Document xml = parseXmlDocument();
        Node dataSet = getNodeByXpath(xml.getDocumentElement(), "/NewDataSet");
        String sourceFile = "migration/src/main/resources/clock_numbers.txt";
        List<String> clockNumbers = FileManager.readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        for (String clockNumber: clockNumbers) {
            String fileName = clockNumber + ".xml";
            // xpath =
            try {
                String assetGUID =  getNodeByXpath(dataSet, String.format("//Asset[UniqueName[text()='%s']]/AssetGUID", clockNumber)).getTextContent();
                NodeList entitiesByParentGuid = getNodesByXpath(dataSet, String.format("//*[ParentAssetGuid[text()='%s']]", assetGUID));
                System.out.println();
            }catch (Throwable t) {}

        }

    }

    private static Document parseXmlDocument() {
        System.out.println("Parse xml document ...");
        try (FileReader reader = new FileReader(XML_FILE_NAME)) {
            return Xml.parseXml(IOUtils.toString(reader));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static void writeResult(Document xml) {
        System.out.println("Write xml document ...");
        String data = documentToString(xml);
        try (FileWriter writer = new FileWriter(getAdaptedFileName())) {
            IOUtils.write(data, writer);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String documentToString(Document xml) {
        try {
            System.setProperty(DOMImplementationRegistry.PROPERTY, "com.sun.org.apache.xerces.internal.dom.DOMImplementationSourceImpl");
            DOMImplementationRegistry registry = DOMImplementationRegistry.newInstance();
            DOMImplementationLS impl = (DOMImplementationLS) registry.getDOMImplementation("LS");
            Writer writer = new StringWriter();
            DOMOutputImpl output = new DOMOutputImpl();
            output.setCharacterStream(writer);
            LSSerializer serializer = impl.createLSSerializer();
            serializer.getDomConfig().setParameter("format-pretty-print", Boolean.TRUE);
            serializer.getDomConfig().setParameter("xml-declaration", Boolean.TRUE);
            serializer.write(xml, output);
            return writer.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return Xml.documentToString(xml);
        }
    }

    private static String getAdaptedFileName() {
        int dotPosition = XML_FILE_NAME.lastIndexOf(".");
        String newFileName;
        if (dotPosition >= 0) {
            newFileName = XML_FILE_NAME.substring(0, dotPosition)
                    + XML_FILE_NAME_ADAPTED_SUFFIX
                    + XML_FILE_NAME.substring(dotPosition);
        } else {
            newFileName = XML_FILE_NAME + XML_FILE_NAME_ADAPTED_SUFFIX;
        }
        return newFileName;
    }

    private static NodeList getNodesByXpath(Node parentNode, String xpathString) {
        return getByXpath(parentNode, xpathString, XPathConstants.NODESET);
    }

    private static Node getNodeByXpath(Node parentNode, String xpathString) {
        return getByXpath(parentNode, xpathString, XPathConstants.NODE);
    }

    private static String getStringByXpath(Node parentNode, String xpathString) {
        return getByXpath(parentNode, xpathString, XPathConstants.STRING);
    }

    private static <T> T getByXpath(Node node, String xpathString, QName qname) {
        XPath xpath = XPathFactory.newInstance().newXPath();
        try {
            return (T) xpath.evaluate(xpathString, node, qname);
        } catch (XPathExpressionException e) {
            e.printStackTrace();
            return null;
        }
    }
}
