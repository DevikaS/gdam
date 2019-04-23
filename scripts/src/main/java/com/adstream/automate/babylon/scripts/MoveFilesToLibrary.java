package com.adstream.automate.babylon.scripts;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.utils.Common;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * User: ruslan.semerenko
 * Date: 21.01.14 11:49
 *
 * https://jira.adstream.com/browse/NGN-9452
 */
public class MoveFilesToLibrary {
    private static final Logger log = Logger.getLogger(MoveFilesToLibrary.class);
    private static final File FILES_TO_MOVE_LIST_FILE = new File("files-to-move.txt");
    private static final File MOVED_FILES_LIST_FILE = new File("moved-files-list.txt");
    private static final String APPLICATION_URL = "http://a5.adstream.com";
    private static final String LOGIN = "amazingspaces@adbank.me";
    private static final String PASSWORD = "adstream";
    private static final String PROJECT_ID = "52e106a2e4b0cd91be5bc4f6";
    private static BabylonServiceWrapper service;

    public static void main(String[] args) throws IOException {
        new MoveFilesToLibrary().process();
    }

    private MoveFilesToLibrary() throws IOException {
        setUpLogger();
        service = new BabylonServiceWrapper(new BabylonMiddlewareService(new URL(APPLICATION_URL)));
        log.info("Log in as " + LOGIN);
        service.logInSSO(LOGIN, PASSWORD);
    }

    private void process() throws IOException {
        List<String> filesToMoveList = getFilesToMoveList();
        BufferedWriter movedFilesWriter = new BufferedWriter(new FileWriter(MOVED_FILES_LIST_FILE, true));

        int movedFilesCount = 0;
        for (String fileId : filesToMoveList) {
            if (fileId.isEmpty()) {
                continue;
            }
            Content file = service.getContent(fileId);
            service.moveFileIntoLibrary(file);

            movedFilesWriter.write(fileId);
            movedFilesWriter.newLine();
            movedFilesWriter.flush();

            if (++movedFilesCount % 100 == 0) {
                log.info("Moved " + movedFilesCount + "/" + filesToMoveList.size() + " files.");
            }
            Common.sleep(500);
        }

        movedFilesWriter.close();
    }

    private List<String> getFilesToMoveList() throws IOException {
        if (!FILES_TO_MOVE_LIST_FILE.exists()) {
            log.info("Files to move list file doesn't exist. Create new.");
            createFilesToMoveList();
        }

        List<String> movedFilesList = new ArrayList<>();
        if (MOVED_FILES_LIST_FILE.exists()) {
            log.info("Moved files list file is present. Read.");
            movedFilesList = readFile(MOVED_FILES_LIST_FILE);
            log.info("Found " + movedFilesList.size() + " moved files");
        }

        List<String> filesToMoveList = new ArrayList<>();
        for (String fileToMove : readFile(FILES_TO_MOVE_LIST_FILE)) {
            if (!movedFilesList.contains(fileToMove)) {
                filesToMoveList.add(fileToMove);
            }
        }
        log.info(filesToMoveList.size() + " files to move.");

        return filesToMoveList;
    }

    private void createFilesToMoveList() throws IOException {
        BufferedWriter filesToMoveWriter = new BufferedWriter(new FileWriter(FILES_TO_MOVE_LIST_FILE));

        log.info("Get project");
        Project project = service.getProject(PROJECT_ID);

        log.info("Get folders");
        List<Content> folders = ((BabylonMiddlewareService) service.getWrappedService()).getProjectFolders(project.getId(), project.getId());
        log.info("Found " + folders.size() + " folders");

        for (int i = 0; i < folders.size(); i++) {
            log.info("Search files in folder " + (i + 1) + "/" + folders.size());
            Content folder = folders.get(i);
            SearchResult<Content> files;
            int page = 1;
            LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(50);
            do {
                files = service.findFoldersContent(folder.getId(), query.setPageNumber(page++));
                int subFoldersCount = 0;
                int filesCount = 0;
                for (Content file : files.getResult()) {
                    if (file.getSubtype().equals("element")) {
                        filesCount++;
                        filesToMoveWriter.write(file.getId());
                        filesToMoveWriter.newLine();
                    } else {
                        subFoldersCount++;
                    }
                }
                log.info("Found " + subFoldersCount + " sub folders and " + filesCount + " files. Has more - " + files.hasMore());
            } while (files.hasMore());
        }

        filesToMoveWriter.flush();
        filesToMoveWriter.close();
        log.info("Files list created");
    }

    private List<String> readFile(File file) throws IOException {
        return IOUtils.readLines(new FileReader(file));
    }

    private void setUpLogger() {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
    }
}
