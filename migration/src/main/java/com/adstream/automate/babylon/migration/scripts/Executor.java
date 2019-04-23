package com.adstream.automate.babylon.migration.scripts;

import com.adstream.automate.babylon.JsonObjects.MigrationA4toA5;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.migration.googledrive.GoogleDriveExample;
import com.adstream.automate.babylon.migration.jira.JiraApi;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.IO;
import com.adstream.automate.utils.Xml;
import org.apache.commons.io.IOUtils;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.tools.ant.util.FileUtils;
import org.apache.xerces.dom.DOMOutputImpl;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 1/28/15
 * Time: 9:40 AM

 */
public class Executor extends BaseTest{
    // ToDO отправка запросов для миграции


    private String a4UserEmail;
    private String agencyName;
    private String userName;

    public static void main(String[] args) throws Exception {
        Executor executor = new Executor();

        //executor.executeButchMigration(list);
        executor.executeButchMigration();
        //executor.prepareListOfFiles();
        //executor.attacheXML("MIG-470");
        /*MigrationA4toA5 migrationA4toA5 = new MigrationA4toA5("ftp://migration_user:1qa2ws3ed@10.0.24.17:/[UPDATED XML OUTPUT] 2015-2-20T15-58-04_Venables, Bell & Partners_0000.xml");
        migrationA4toA5.setFakeUserEmail("admin.NGN-14416.26@adbank.me");
        migrationA4toA5.setAgencyName("Agency NGN-14416.2");
        migrationA4toA5.setA4UserEmail("mccann@adstream.tv.ua");
        getService().executeMigrationA4toA5(migrationA4toA5);*/
        System.out.println();
    }

    public void prepareListOfFiles() throws Exception {
        File file = new File("./Butch");
        List<DataForBatchMigration> list = preparedDataFromGoogleTable();
        int i= 0;
        if (file.isDirectory()) {
            for (File file1: file.listFiles()) {
                System.out.println("{\"" + file1.getName() + "\", \"2\", \"" + list.get(i).getA5BuName() + "\", \""+ getUserNameByAgency(list.get(i).getA5BuName()) + "\", \"\", \"" + list.get(i).getA4UserEmail() +"\",  \"MIG-512\", \"Live\"},");
                i++;
            }
        }
        System.out.println();
    }

    public void executeButchMigration(List<DataForBatchMigration> listOfData) {
        for (DataForBatchMigration dataForBatchMigration: listOfData) {

        }
    }

    public void executeButchMigration() {
        long startTime = System.currentTimeMillis();
        for (String[] xmlPath: xmlSourceArray) {
            try {
                MigrationA4toA5 migrationA4toA5 = new MigrationA4toA5(getFtp() + xmlPath[0]);
                int type = Integer.parseInt(xmlPath[1]);
                switch (type) {
                    case 0: {
                        getValuesFromXML(xmlPath[0]);
                        migrationA4toA5.setFakeUserEmail(userName);
                        migrationA4toA5.setAgencyName(agencyName);
                        migrationA4toA5.setA4UserEmail(a4UserEmail);
                        break;
                    }
                    case 1: { // Butch with fake user = a4user
                        migrationA4toA5.setFakeUserEmail(xmlPath[3]);
                        migrationA4toA5.setAgencyName(xmlPath[2]);
                        migrationA4toA5.setFakeUserPass(xmlPath[4]);
                        migrationA4toA5.setA4UserEmail(xmlPath[5].toLowerCase());
                        break;
                    }
                    case 2: {
                        migrationA4toA5.setFakeUserEmail(xmlPath[3].toLowerCase());
                        migrationA4toA5.setAgencyName(xmlPath[2]);
                        //migrationA4toA5.setA4UserEmail(xmlPath[5].toLowerCase());
                        break;
                    }
                    case 3: {
                        // Parse openofiice file
                        break;
                    }
                    case 4: {
                        getValuesFromXML(xmlPath[0]);
                        migrationA4toA5.setFakeUserEmail(userName.toLowerCase());
                        migrationA4toA5.setAgencyName(xmlPath[2]);
                        migrationA4toA5.setA4UserEmail(a4UserEmail);
                        break;
                    }
                }

                String result = getService().executeMigrationA4toA5(migrationA4toA5);
                //String result = "ok";
                if (result.contains("ok")) {
                    ReportsHelper.getMigrationReportByFile(getFtp() + xmlPath[0], xmlPath[7]);
                    //JiraApi.addComment(xmlPath[6],ReportsHelper.getLocalReport());
                    System.out.println(xmlPath[0] + " was migrated. Time from start: " + (System.currentTimeMillis() - startTime));
                }
                else {
                    System.out.println(xmlPath[0] + " was failed");
                }

            }catch (Throwable t) {
                t.printStackTrace();
                System.out.println("There is an exception during migration from " + xmlPath[0]);
            }
        }
        System.out.println("Full butch migration time is: " + (System.currentTimeMillis() - startTime) + " ms.");
    }

    public void getValuesFromXML(String filePath) {
        Document xml = parseXmlDocument(filePath);
        Node dataSet = getNodeByXpath(xml.getDocumentElement(), "/NewDataSet");
        String primaryUserId = getStringByXpath(dataSet, "Agency/PrimaryUserGUID");
        agencyName = getStringByXpath(dataSet, "Agency/AgencyName");
        userName = getUserNameByAgency();
        a4UserEmail = getStringByXpath(dataSet, "User[UserGUID='" + primaryUserId + "']/Email");

    }

    public String getUserNameByAgency() {
        return getUserNameByAgency(agencyName);
    }

    public String getUserNameByAgency(String agencyName) {
        if (agencyName.isEmpty())
            return "";
        String[] tempArray = agencyName.replaceAll("[\\W]", " ").toLowerCase().split(" ");
        String result = "admin";
        for (String temp: tempArray) {
            result+= temp.isEmpty()?"":"."+temp;
        }
        return result + "@adbank.me";
    }

    private Document parseXmlDocument(String filePath) {
        System.out.println("Parse xml document ...");
        try (FileReader reader = new FileReader(filePath)) {
            return Xml.parseXml(IOUtils.toString(reader));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String documentToString(Document xml) {
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

    private static List<DataForBatchMigration> preparedDataFromGoogleTable() throws Exception {
        String csv = GoogleDriveExample.getDataFromSpreadSheet();
        CSVParser csvParser = new CSVParser(csv);
        return csvParser.prepareData();

    }

}
