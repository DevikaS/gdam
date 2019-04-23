package com.adstream.automate.babylon.migration.googledrive;

import com.adstream.automate.babylon.migration.utils.FileManager;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.List;

public class GoogleDriveExample {
    private static final String SERVICE_ID = "938525884814-en61kdtu44k4ks6ag4n46dnfa3udk5ks@developer.gserviceaccount.com";
    private static final List<String> SCOPES = Arrays.asList(
            "https://www.googleapis.com/auth/drive.readonly"
    );

    public static void main(String[] args) throws Exception {
        HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
        JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
        GoogleCredential credential = new GoogleCredential.Builder()
                .setTransport(httpTransport)
                .setJsonFactory(jsonFactory)
                .setServiceAccountId(SERVICE_ID)
                .setServiceAccountScopes(SCOPES)
                .setServiceAccountPrivateKeyFromP12File(getPrivateKeyFile())
                .build();
        Drive drive = new Drive.Builder(new NetHttpTransport(), new JacksonFactory(), credential).setApplicationName("test").build();
        List<File> files = drive.files().list().setQ("title='Batch Migration template'").execute().getItems();
        if (files.size() > 0) {
            String downloadLink = files.get(0).getExportLinks().get("text/csv");
            HttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(new HttpGet(downloadLink));
            String scv = EntityUtils.toString(response.getEntity(), "UTF-8");
            List<CSVRecord> upsa = ddd(scv);
            for (CSVRecord csvRecord: upsa) {
                System.out.println();
            }
            FileManager.saveIntoFile("downloaded.csv", scv);
            System.out.println();
        }
    }

    public static String getDataFromSpreadSheet() throws Exception {
        HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
        JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
        GoogleCredential credential = new GoogleCredential.Builder()
                .setTransport(httpTransport)
                .setJsonFactory(jsonFactory)
                .setServiceAccountId(SERVICE_ID)
                .setServiceAccountScopes(SCOPES)
                .setServiceAccountPrivateKeyFromP12File(getPrivateKeyFile())
                .build();
        Drive drive = new Drive.Builder(new NetHttpTransport(), new JacksonFactory(), credential).setApplicationName("test").build();
        List<File> files = drive.files().list().setQ("title='Batch Migration template'").execute().getItems();
        if (files.size() > 0) {
            String downloadLink = files.get(0).getExportLinks().get("text/csv");
            HttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(new HttpGet(downloadLink));
            return EntityUtils.toString(response.getEntity(), "UTF-8");
        }
        return "";
    }

    public static List<CSVRecord> ddd(String csv) throws IOException {
        Reader in = new StringReader(csv);
        CSVParser parser = new CSVParser(in, CSVFormat.EXCEL);
        List<CSVRecord> list = parser.getRecords();
        return list;

    }

    private static java.io.File getPrivateKeyFile() throws Exception {
        return new java.io.File("babylonautotester.p12");
    }
}
