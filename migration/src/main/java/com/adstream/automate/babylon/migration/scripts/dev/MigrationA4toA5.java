package com.adstream.automate.babylon.migration.scripts.dev;

import com.adstream.automate.babylon.migration.jira.JiraApi;
import com.adstream.automate.babylon.migration.scripts.DataForBatchMigration;
import com.adstream.automate.babylon.migration.scripts.FTPUploader;
import com.adstream.automate.babylon.migration.scripts.ReportsHelper;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.utils.Common;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 4/1/15
 * Time: 4:21 PM

 */
public class MigrationA4toA5 extends BaseTest {

    // Step1: Parse google Docs. Problems in this step - this is a finish for migration
    // Step2: Get all attache from issue;

    private String issueKey;
    private String pathToXMLFolder;
    private int migratedBUQuantity;
    private List<DataForBatchMigration> googleDocs;
    private List<File> allAttachedXMLs;
    private List<com.adstream.automate.babylon.JsonObjects.MigrationA4toA5> listOfMigrationParams;
    private boolean isReport;

    public MigrationA4toA5() {
        prepareMigration();
        issueKey = getContext().jiraIssue;
        isReport = getContext().isReport;
    }

    private void prepareMigration() {
        log.info("Cleaning output folder is started...");
        FileManager.deleteAllFilesFromFolder(pathToXMLFolder);
        googleDocs = prepareGoogleData();
        listOfMigrationParams = new ArrayList<>();
        pathToXMLFolder = getContext().pathToXml;
    }

    private List<File> prepareFilesToUpload() {
        downloadAttaches();
        allAttachedXMLs = getFilesToUpload();
        return chooseFilesAccordingToGoogleDoc();
    }

    private List<File> chooseFilesAccordingToGoogleDoc() {
        List<File> xmlFiles = new ArrayList<>();
        for (DataForBatchMigration dataForBatchMigration: googleDocs) {
            File xmlWithMigrationData = MigrationUtils.getFileFromList(dataForBatchMigration.getA4BuName(), allAttachedXMLs);
            xmlFiles.add(xmlWithMigrationData);
            com.adstream.automate.babylon.JsonObjects.MigrationA4toA5 migrationA4toA5 = new com.adstream.automate.babylon.JsonObjects.MigrationA4toA5(getFtp() + xmlWithMigrationData.getName());
            migrationA4toA5.setAgencyName(dataForBatchMigration.getA5BuName());
            migrationA4toA5.setFakeUserEmail(MigrationUtils.getUserNameByAgency(dataForBatchMigration.getA5BuName()));
            listOfMigrationParams.add(migrationA4toA5);
        }
        return xmlFiles;
    }

    private void uploadToFTP(List<File> xmlFiles) {
        try {
            FTPUploader ftpUploader = new FTPUploader(getContext().ftpPath, getContext().ftpLogin, getContext().ftpPassword);
            for (File file:  xmlFiles) {
                ftpUploader.uploadFile(file.getCanonicalPath(), file.getName(), "");
            }
            ftpUploader.disconnect();
        } catch (Exception e) {

        }
    }

    public void executeRequest() throws Exception {
        for (com.adstream.automate.babylon.JsonObjects.MigrationA4toA5 migrationA4toA5: listOfMigrationParams) {
            try {
                String result = getService().executeMigrationA4toA5(migrationA4toA5);
                if (result.contains("ok")) {
                    log.info(migrationA4toA5.getXmlLocation() + " was migrated successful");
                    ReportsHelper.getMigrationReportByFile(migrationA4toA5.getXmlLocation(), getContext().envName);
                    if (isReport)
                        JiraApi.addComment(issueKey, ReportsHelper.getLocalReport());
                    migratedBUQuantity++;
                }
            } catch (Exception e) {
                log.error(migrationA4toA5.getXmlLocation() + " wasn't migrated");
            }
        }
        if (isReport)
            JiraApi.addComment(issueKey, ReportsHelper.getSummaryReport());
    }

    private List<DataForBatchMigration> prepareGoogleData() {
        return  MigrationInfo.generateData();
    }


    private List<String> downloadAttaches() {
        List<String> allAttaches = JiraApi.getListOfAttachmentsURLs(issueKey);
        if (allAttaches == null || allAttaches.size() == 0)
            return null;
        List<String> result = new ArrayList<>();
        for (String url: allAttaches) {
            String fileName = "";
            try {
                fileName = Common.urlDecode(url.split("/")[url.split("/").length - 1]);
                JiraApi.getAttachmentFromIssue(url, String.format("%s/%s", pathToXMLFolder, fileName));
            } catch (IOException e) {
                e.printStackTrace();
                log.error("XML weren't downloaded from Jira. Migration was failed");
            }
            log.info(fileName + " was downloaded from JIRA");
            result.add(fileName);
        }
        return result;
    }

    private List<File> getFilesToUpload() {
        List<File> result = new ArrayList<>();
        File file = new File(pathToXMLFolder);
        if (file.isDirectory()) {
            for (File file1: file.listFiles()) {
                try {
                    if (file1.getName().endsWith(".7z")) {
                        Archive.extract7z(file1.getCanonicalPath());
                        file1.delete();
                    }
                    else if (file1.getName().endsWith(".zip")) {
                        try {
                            Archive.extractZip(file1.getCanonicalPath());
                        } catch (Exception e) {
                            e.printStackTrace();
                            log.error("There is an error during unzip file: " + file1.getName());
                        }
                        file1.delete();
                    }
                }catch (IOException ie) {
                    log.error("Can't get canonical path for file " + file1.getName());
                }
            }
        }
        file = new File(pathToXMLFolder);
        for (File xmlFile: file.listFiles()) {
            if (xmlFile.getName().endsWith("xml")) {
                result.add(xmlFile);
            }
        }
        return result;
    }


}
