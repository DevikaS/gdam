package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonService;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNFileRegister;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNFileWrapper;
import com.adstream.automate.babylon.UploadListener;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.IO;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.joda.time.DateTime;
import org.joda.time.Period;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeoutException;

public class MoveFilesBetweenProjects {
    private Logger log = Logger.getLogger(this.getClass());

    public static void main(String[] args) {
        new MoveFilesBetweenProjects().start();
    }

    public MoveFilesBetweenProjects() {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
    }

    public void start() {
        List<MoveFilesThread> threads = new ArrayList<>();
        ExecutorService executor = Executors.newFixedThreadPool(Config.THREADS_COUNT);
        for (int i = 0; i < Config.THREADS_COUNT; i++) {
            MoveFilesThread thread = new MoveFilesThread();
            threads.add(thread);
            executor.execute(thread);
        }
        executor.shutdown();
        while (!executor.isTerminated()) {
            Common.sleep(1000);
        }
        List<Long> timeTable = new ArrayList<>();
        for (MoveFilesThread thread : threads) {
            timeTable.addAll(thread.getTimeTable());
        }
        Collections.sort(timeTable);
        long min = timeTable.get(0);
        long max = timeTable.get(timeTable.size() - 1);
        long median = timeTable.get(timeTable.size() / 2);
        long p90 = timeTable.get((int)(timeTable.size() * 0.9));
        log.info(String.format("%nmin: %d%nmedian: %d%n90%%: %d%nmax: %d", min, median, p90, max));
    }
}

class Config {
    public static final String APPLICATION_URL = "http://perfa5-elb-internal.adstream.com:8080";
    public static final String GLOBAL_ADMIN_LOGIN = "admin";
    public static final String GLOBAL_ADMIN_PASSWORD = "K33pKa1m09";
    public static final String USER_PASSWORD = "abcdefghA1";
    public static final String STORAGE_ID = "52d3ec51e4b011bdb451d253";
    public static final File FILE = new File("logo.jpg");
    public static final int THREADS_COUNT = 16;
    public static final int TEST_TIME_MS = 10 * 60 * 1000;
}

class MoveFilesThread extends Thread {
    private BabylonService service;
    private Content folder1, folder2, file;
    private List<Long> timeTable = new ArrayList<>();

    public MoveFilesThread() {
        service = new BabylonCoreService(getApplicationUrl());
        service.auth(Config.GLOBAL_ADMIN_LOGIN, Config.GLOBAL_ADMIN_PASSWORD);
        Agency agency = createAgency();
        User user = createUser(agency);
        service.auth(user.getEmail(), Config.USER_PASSWORD);
        Project project1 = createProject();
        Project project2 = createProject();
        folder1 = service.createContent(project1.getId(), getFolder(project1.getId()));
        folder2 = service.createContent(project2.getId(), getFolder(project2.getId()));
        file = uploadFileToGDN(Config.FILE, folder1.getId(), null);
    }

    public void run() {
        long deadline = System.currentTimeMillis() + Config.TEST_TIME_MS;
        do {
            Content destinationFolder = file.getParents()[0].equals(folder1.getId()) ? folder2 : folder1;
            String processId = service.moveContent(new String[] {file.getId()}, destinationFolder.getId());
            long start = System.currentTimeMillis();
            try {
                service.batchTaskApi().waitTillDone(processId);
            } catch (TimeoutException e) {
                e.printStackTrace();
            }
            timeTable.add(System.currentTimeMillis() - start);
        } while (System.currentTimeMillis() < deadline);
    }

    public List<Long> getTimeTable() {
        return timeTable;
    }

    private URL getApplicationUrl() {
        try {
            return new URL(Config.APPLICATION_URL);
        } catch (MalformedURLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private Agency createAgency() {
        Agency agency = new Agency();
        agency.setName(Gen.getHumanReadableString(6));
        agency.setDescription(agency.getName());
        agency.setSubtype("agency");
        agency.setPin("1");
        agency.setTimeZone("Europe-Andorra");
        agency.setCountry("AF");
        agency.setAgencyType("Advertiser");
        agency.setStorageId(Config.STORAGE_ID);
        agency = service.createAgency(agency);
        return agency;
    }

    private User createUser(Agency agency) {
        User user = new User();
        user.setAgency(agency);
        user.setPhoneNumber("1234567890");
        user.setAdvertiser(agency.getId());
        user.setPassword(Config.USER_PASSWORD);
        user.setFullAccess();
        user.setRoles(new BaseObject[]{service.getRole("4f6acc74dff0676e018e6dcc")});
        user.setFirstName(Gen.getHumanReadableString(6));
        user.setLastName(Gen.getHumanReadableString(6));
        user.setEmail(user.getFirstName() + "." + user.getLastName() + "@test.com");
        user = service.createUser(agency.getId(), user);
        return user;
    }

    private Project createProject() {
        Project project = new Project();
        project.setMediaType("Broadcast");
        project.setAdministrators(new String[0]);
        project.setSubtype("project");
        project.setLogo("");
        project.setDateStart(new DateTime());
        project.setDateEnd(new DateTime().plus(Period.days(1)));
        project.setName(Gen.getHumanReadableString(6, true));
        project.setJobNumber(Gen.getHumanReadableString(6, true));
        project = service.createProject(project);
        service.addUserToProjectTeam(project.getId(), getTeamPermission(project.getId()));
        return project;
    }

    private Content getFolder(String projectId) {
        Content content = new Content();
        content.setProject(new Identity(projectId, null));
        content.setName(Gen.getHumanReadableString(6, true));
        content.setSubtype("folder");
        return content;
    }

    private TeamPermission[] getTeamPermission(String projectId) {
        return new TeamPermission[] {
                new TeamPermission(projectId, service.getCurrentUser().getId(), "4f719aed0f915e82984dc84e", true, null)
        };
    }

    private Content uploadFileToGDN(File file, String folderId, UploadListener uploadListener) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNContent(folderId, gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        HashMap<String, String> uploadResult = prepareFileToUploadToGDN(gdnFileWrapper, postURI, uploadListener);
        Content content = createContentGDN(folderId, file.getName(), gdnFileId);
        if (uploadListener != null)
            uploadListener.uploadComplete(uploadResult.get("targetFileName"), content.getId());
        return content;
    }

    private GDNFileRegister registerGDNContent(String parentId, GDNFileWrapper gdnFileWrapper) {
        return service.registerGDNContent(parentId, Arrays.asList(gdnFileWrapper));
    }

    private HashMap<String, String> prepareFileToUploadToGDN(GDNFileWrapper fileWrapper, String postURI, UploadListener uploadListener) {
        File file = fileWrapper.getFile();
        if (!file.exists())
            throw new IllegalArgumentException(String.format("File %s does not exist", file.toString()));

        HashMap<String, String> result = new HashMap<>();

        long fileLength = file.length();
        String fileName = file.getName();
        String fileExtension = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : "";
        String targetFileName = fileWrapper.getExternalId() + fileExtension;
        String lastModified = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(new Date(file.lastModified()));

        CloseableHttpClient client = HttpClients.createDefault();
        final int chunkLength = 10485760;
        int bytesToSend;
        int chunksCount = (int) (fileLength / chunkLength) + 1;
        int fileId = Gen.getInt(10000000, 99999999);
        long totalTime = 0;
        for (int i = 0; i < chunksCount; i++) {
            int bytesUploaded = i * chunkLength;
            bytesToSend = i < chunksCount - 1 ? chunkLength : (int) (fileLength - bytesUploaded);
            byte[] bytes = IO.readFile(file, bytesUploaded, bytesToSend);
            HttpPost request = new HttpPost(postURI);
            MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
            entityBuilder.addTextBody("partitionIndex", "" + i);
            entityBuilder.addTextBody("targetFileName", targetFileName);
            entityBuilder.addTextBody("fileId", "" + fileId);
            entityBuilder.addTextBody("partitionLength", "" + chunkLength);
            entityBuilder.addTextBody("lastModified", lastModified);
            entityBuilder.addTextBody("fileLength", "" + fileLength);
            entityBuilder.addTextBody("fileName", fileName);
            entityBuilder.addTextBody("partitionCount", "" + chunksCount);
            entityBuilder.addBinaryBody("file", bytes, ContentType.APPLICATION_OCTET_STREAM, fileName);
            request.setHeader("Authorization", "Basic YWxleEB1bml0LnR2LnVhOjE=");
            request.setEntity(entityBuilder.build());
            try {
                long start = System.currentTimeMillis();
                HttpResponse response = client.execute(request);
                if (response.getStatusLine().getStatusCode() != 200) {
                    System.out.println("File upload request: " + request.getURI());
                    System.out.println("File upload response: " + response.getStatusLine().getStatusCode());
                    System.out.println(EntityUtils.toString(response.getEntity()));
                    throw new IllegalStateException("File not uploaded");
                } else {
                    long time = System.currentTimeMillis() - start;
                    EntityUtils.consume(response.getEntity());
                    totalTime += time;
                    if (uploadListener != null)
                        uploadListener.chunkUploadComplete(bytesUploaded + bytesToSend, fileLength, bytesToSend, time, totalTime, targetFileName);
                }
            } catch (IOException e) {
                throw new IllegalStateException("File not uploaded", e);
            }
        }
        result.put("targetFileName", targetFileName);
        return result;
    }

    private Content createContentGDN(String folderId, String fileName, String gdnFileId) {
        Content content = new Content();
        content.setSubtype("element");
        content.setName(fileName);
        return service.createContentGDN(folderId, content, gdnFileId);
    }
}