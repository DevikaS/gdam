package com.adstream.automate.babylon.migration.scripts;

import com.adstream.automate.babylon.JsonObjects.MigrationA4toA5;
import com.adstream.automate.babylon.migration.googledrive.GoogleDriveExample;
import com.adstream.automate.babylon.migration.jira.JiraApi;
import com.adstream.automate.babylon.migration.scripts.dev.Archive;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.utils.Common;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;

import javax.annotation.Resource;
import javax.swing.*;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/12/15
 * Time: 4:26 PM

 */
public class FullMigrationScript extends BaseTest {

    // S1: Get list of  attachments by issueKey
    // S2: Get List of A4 and A5 BU from Google docs
    // S3: Select only final XML or Archive
    // S4: Download XMLs from S3
    // S5: Upload to FTP
    // S6: Create list of parametrs for migration
    // S7: Migration and report
    // S8:
    // Add: Use multi threads

    private int waitedBUQuantity;
    private int migratedBUQuantity;

    private String issueKey;
    private List<String> allAttachmentFromIssue;
    private List<File> xmlFiles;
    private File[] zipFiles;
    private List<MigrationA4toA5> listOfMigrationParams;


    private List<String> allA4BUFromGoogleDocs;

    private List<DataForBatchMigration> googleData;

    public static void main(String[] args){
        FullMigrationScript fullMigrationScript = new FullMigrationScript(getContext().jiraIssue);
        List<File> allAttached = null;
        try {
            allAttached = fullMigrationScript.getAttacheLink();
        } catch (Exception e) {
            e.printStackTrace();
            log.error("Attached files weren't be downloaded from issue: " + getContext().jiraIssue);
            return;
        }

        try {
            fullMigrationScript.getDataFromGoogleTable();
        } catch (Exception e) {
            e.printStackTrace();
            log.error("Spread sheet from google docs wasn't rad. Migration was failed");
            return;
        }
        fullMigrationScript.xmlFiles = new ArrayList<>();
        fullMigrationScript.listOfMigrationParams = new ArrayList<>();
        for (DataForBatchMigration dataForBatchMigration: fullMigrationScript.googleData) {
            File xmlWithMigrationData = null;
            File xmlWithMigrationDataPOnly = null;
            try {
                xmlWithMigrationData = fullMigrationScript.getFileFromList(dataForBatchMigration.getA4BuName(), allAttached);
                if (xmlWithMigrationData == null) continue;
                if (getContext().proxyOnly) {
                    xmlWithMigrationDataPOnly = fullMigrationScript.removeAllExceptProxy(xmlWithMigrationData.getCanonicalPath());
                    fullMigrationScript.xmlFiles.add(xmlWithMigrationDataPOnly);
                }
                else {
                    fullMigrationScript.xmlFiles.add(xmlWithMigrationData);
                }
                MigrationA4toA5 migrationA4toA5 = new MigrationA4toA5(getFtp() + (getContext().proxyOnly?xmlWithMigrationDataPOnly.getName():xmlWithMigrationData.getName()));
                migrationA4toA5.setAgencyName(dataForBatchMigration.getA5BuName());
                migrationA4toA5.setFakeUserEmail(fullMigrationScript.getUserNameByAgency(dataForBatchMigration.getA5BuName()));
                migrationA4toA5.setSource(getContext().a4DBServer);
                migrationA4toA5.setDeliveryOnly(getContext().deliveryOnly);
                migrationA4toA5.setWithODT(getContext().withODT);
                fullMigrationScript.listOfMigrationParams.add(migrationA4toA5);
            } catch (Exception e) {
                e.printStackTrace();
                log.warn("Agency " + dataForBatchMigration.getA5BuName() + " wasn't migrated");
            }
        }
        for (File file:  fullMigrationScript.xmlFiles) {
            try {
                fullMigrationScript.copyToLocalStorage(file.getCanonicalPath());
            } catch (IOException e) {
                log.error("File " + file.getName() + " wasn't migrated into local storage");
            }
        }

        try {
            fullMigrationScript.uploadToFTP();
        } catch (Exception e) {
            e.printStackTrace();
            log.warn("There are problems during upload to FTP");
        }
        //Common.sleep(1000*60*60*7);
        for (MigrationA4toA5 migrationA4toA5: fullMigrationScript.listOfMigrationParams) {
            try {
                String result = getService().executeMigrationA4toA5(migrationA4toA5);
                //String result = "ok";
                if (result.contains("ok")) {
                    log.info(migrationA4toA5.getXmlLocation() + " was migrated successful");
                    ReportsHelper.getMigrationReportByFile(migrationA4toA5.getXmlLocation(), getContext().envName);
                    if (getContext().isReport)
                        JiraApi.addComment(getContext().jiraIssue, ReportsHelper.getLocalReport().append("\n").append(migrationA4toA5.toString()));
                        //JiraApi.addComment(getContext().jiraIssue, ReportsHelper.getLocalReport());
                    fullMigrationScript.migratedBUQuantity++;
                }
            } catch (Exception e) {
                log.error(migrationA4toA5.getXmlLocation() + " wasn't migrated");
                break;
            }
        }
        if (getContext().isReport)
            JiraApi.addComment(getContext().jiraIssue, ReportsHelper.getSummaryReport());
        if (getContext().isTimeReport)
            JiraApi.addComment(getContext().jiraIssue, ReportsHelper.getTimeReport());
        if (getContext().isOrderReport)
            JiraApi.addComment(getContext().jiraIssue, ReportsHelper.getWithOrderReport());
        try {
            fullMigrationScript.deleteFileFromFTP();
        } catch (Exception e) {
            log.error("There are some problems with delete file from FTP");
        }

        /*try {
            fullMigrationScript.getDataFromGoogleTable();
        } catch (Exception e) {
            e.printStackTrace();
            log.error("GoogleDoc wasn't rad. All migration was failed. Try next time");
        }
        fullMigrationScript.setAllAttachmentFromIssue(JiraApi.getListOfAttachmentsURLs(fullMigrationScript.getIssueKey()));
        List<File> allAttacheFromIssue = null;
        try {
            allAttacheFromIssue = fullMigrationScript.getAttacheLink();
        } catch (Exception e) {
            e.printStackTrace();
            log.error("XML files weren't downloaded from issue. Migration was failed. Try next time ");
        } */


        //fullMigrationScript.executeRequest();

    }

    public File removeAllExceptProxy(String filePath) {
        Document doc = ParentScript.initXMLDocument(filePath);
        NodeList nodes = doc.getChildNodes().item(0).getChildNodes();
        int count = nodes.getLength();
        for (int i = 0; i < count; i++) {
            Element person = null;
            if (nodes.item(i) instanceof Element) {
                person = (Element)nodes.item(i);
            }
            if (nodes.item(i) instanceof Text) {
                nodes.item(i).getParentNode().removeChild(nodes.item(i));
                i--;
            }
            if (person == null) continue;
            if (!nodes.item(i).getNodeName().equalsIgnoreCase("ProxyAsset") && !nodes.item(i).getNodeName().equalsIgnoreCase("NewDataSet") && !nodes.item(i).getNodeName().equalsIgnoreCase("Agency")) {
                person.getParentNode().removeChild(person);
                i--;
            }
        }
        return ParentScript.writeDocument(doc, filePath.replace(".xml", "_proxy_only.xml"));
    }

    public List<MigrationA4toA5> getListOfMigrationParams() {
        return listOfMigrationParams;
    }

    public void setListOfMigrationParams(List<MigrationA4toA5> listOfMigrationParams) {
        this.listOfMigrationParams = listOfMigrationParams;
    }

    public List<String> getAllAttachmentFromIssue() {
        return allAttachmentFromIssue;
    }

    public void setAllAttachmentFromIssue(List<String> allAttachmentFromIssue) {
        this.allAttachmentFromIssue = allAttachmentFromIssue;
    }

    public String getIssueKey() {
        return issueKey;
    }

    public void setIssueKey(String issueKey) {
        this.issueKey = issueKey;
    }

    public FullMigrationScript() {}

    public FullMigrationScript(String issueKey) {
        this.issueKey = issueKey;
    }

    public void getDataFromGoogleTable() throws Exception {
        log.info("Start to read google doc spread sheet... ");
        String csv = GoogleDriveExample.getDataFromSpreadSheet();
        CSVParser csvParser = new CSVParser(csv);
        googleData =  csvParser.prepareData();
        waitedBUQuantity = googleData.size();
        log.info("Google doc was readed. Count of BU are: " + waitedBUQuantity);
    }

    public List<File> getAttacheLink() throws Exception {
        if (allAttachmentFromIssue == null)
            allAttachmentFromIssue = JiraApi.getListOfAttachmentsURLs(issueKey);
        prepareDir();
        List<File> result = new ArrayList<>();
        for (String url: allAttachmentFromIssue) {
            JiraApi.getAttachmentFromIssue(url, String.format("./Jira/%s", Common.urlDecode(url.split("/")[url.split("/").length - 1])));
            log.info(Common.urlDecode(url.split("/")[url.split("/").length - 1]) + " was downloaded from JIRA");
        }
        File file = new File("./Jira");
        if (file.isDirectory()) {
            for (File file1: file.listFiles()) {
                if (file1.getName().endsWith(".7z")) {
                    Archive.extract7z(file1.getCanonicalPath());
                    file1.delete();
                }
                else if (file1.getName().endsWith(".zip")) {
                    Archive.extractZip(file1.getCanonicalPath());
                    file1.delete();
                }
            }
        }
        File xmlFolder = new File("./Jira");
        if (xmlFolder.isDirectory()) {
            for (File xmlFile: xmlFolder.listFiles()) {
                if (xmlFile.getName().endsWith("xml")) {
                    result.add(xmlFile);
                }
            }
        }
        return result;
    }



    public void getListOfAttaches() throws Exception {
        allAttachmentFromIssue = JiraApi.getListOfAttachmentsURLs(issueKey);
        getDataFromGoogleTable();
        for (DataForBatchMigration batchMigration: googleData) {
            if (allAttachmentFromIssue.contains(batchMigration.getA4BuName())) {

            }
        }

    }


    public void prepareDir() {
        File file = new File("./Jira");
        if (file.isDirectory()) {
            for (File file1: file.listFiles()) {
                file1.delete();
            }
        }
    }


    private List<File> prepareXMLForDownload() throws Exception {
        List<File> allAttached = getAttacheLink();
        if (googleData == null)
            getDataFromGoogleTable();
        if (listOfMigrationParams == null)
            listOfMigrationParams = new ArrayList<>();
        if (xmlFiles == null)
            xmlFiles = new ArrayList<>();
        for (DataForBatchMigration dataForBatchMigration: googleData) {
            File xmlWithMigrationData = getFileFromList(dataForBatchMigration.getA4BuName(), allAttached);
            xmlFiles.add(xmlWithMigrationData);
            MigrationA4toA5 migrationA4toA5 = new MigrationA4toA5(getFtp() + xmlWithMigrationData.getName());
            migrationA4toA5.setAgencyName(dataForBatchMigration.getA5BuName());
            migrationA4toA5.setFakeUserEmail(getUserNameByAgency(dataForBatchMigration.getA5BuName()));
            listOfMigrationParams.add(migrationA4toA5);

        }
        return xmlFiles;
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

    private File getFileFromList(String buName, List<File> listOfFiles) {
        File file = null;
        List<File> result = new ArrayList<>();
        for (File xmlFile: listOfFiles) {
            if (xmlFile.getName().toLowerCase().contains(buName.toLowerCase())) {
                result.add(xmlFile);
            }
        }                                //[updated xml output] 2015-3-24t10-12-41_the coal shed ltd_0000.xml
                                         //                                        the coal shed ltd_0000
        if (result.size() == 1)
            return result.get(0);
        if (result.size() == 2) {
            for (int i=0; i< result.size(); i++) {
                if (result.get(i).getName().toUpperCase().contains("[UPDATED XML OUTPUT]"))
                    return result.get(i);
            }
        }
        return null;
    }

    private void uploadToFTP() throws Exception {
        FTPUploader ftpUploader = new FTPUploader("ftp.adstream.com", "mongo-admin", "ooquooX4Tha");
        for (File file:  xmlFiles) {
            ftpUploader.uploadFile(file.getCanonicalPath(), file.getName(), "");
        }
        ftpUploader.disconnect();
    }

    private void deleteFileFromFTP() throws Exception {
        FTPManager ftpManager = new FTPManager(getContext().ftpPath, getContext().ftpLogin, getContext().ftpPassword);
        for (File file:  xmlFiles) {
            ftpManager.deleteFile(file.getName());
        }
        ftpManager.disconnect();

    }

    public void executeRequest() throws Exception {
        if (listOfMigrationParams == null || listOfMigrationParams.isEmpty())
            prepareXMLForDownload();
        uploadToFTP();
        for (MigrationA4toA5 migrationA4toA5: listOfMigrationParams) {
            try {
                String result = getService().executeMigrationA4toA5(migrationA4toA5);
                if (result.contains("ok")) {
                    log.info(migrationA4toA5.getXmlLocation() + " was migrated successful");
                    ReportsHelper.getMigrationReportByFile(migrationA4toA5.getXmlLocation(), getContext().envName);
                    JiraApi.addComment(getContext().jiraIssue, ReportsHelper.getLocalReport());

                }
            } catch (Exception e) {
                log.error("Something strange");
            }


        }
    }

    public void copyToLocalStorage(String filePath) throws IOException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
        String subFolder = dateFormat.format(new Date()).toString();
        File folder = new File(getContext().pathToLocalStorage + "/" + subFolder);
        folder.mkdirs();
        File file = new File(filePath);
        FileManager.copyFiles(file, new File(folder.getCanonicalPath() + "/" + file.getName()));
    }

}
