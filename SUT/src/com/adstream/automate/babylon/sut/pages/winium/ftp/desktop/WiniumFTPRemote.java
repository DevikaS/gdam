package com.adstream.automate.babylon.sut.pages.winium.ftp.desktop;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHttpEntityEnclosingRequest;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.remote.SessionId;
import org.openqa.selenium.winium.DesktopOptions;
import org.openqa.selenium.winium.WiniumDriver;

import java.io.*;
import java.lang.reflect.Field;
import java.net.MalformedURLException;
import java.net.URL;


/**
 * Created by Saritha.Dhanala on 24/03/2017.
 */
public class WiniumFTPRemote{

    ExtendedWebDriver web;
    private String hostIPAddress = null;
    private WiniumDriver winiumDriver = null;
    private String gridUserName = TestsContext.getInstance().gridUserName;
    private String gridPassword = TestsContext.getInstance().gridUserPassword;

    public WiniumFTPRemote(ExtendedWebDriver webDriver) {
        web = webDriver;
    }

    public void ftpAndExecuteAutoScripts(String autoScriptName, String ftpgridLocation) {
        hostIPAddress = getRemoteNodeIP();

        File localFilePath = null;
        FTPClient ftpClient = new FTPClient();
        InputStream inputStream = null;
        boolean done = false;

        try {
            //Set the autoscripts location on grid
            localFilePath = new File(String.format(TestsContext.getInstance().testDataFolderName + "/" + "files/" + "%s", autoScriptName));

            ftpClient.connect(hostIPAddress);
            ftpClient.login(TestsContext.getInstance().gridUserName, TestsContext.getInstance().gridUserPassword);
            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            // Uploads autoscript file from codebase to Grid using an InputStream
            inputStream = new FileInputStream(localFilePath);
            done = ftpClient.storeFile(autoScriptName, inputStream);
            web.sleep(8000);
            if (done) {
                //Start winiumervice
                //   winiumService(null, "start");
                //Execute autoIt scripts using winium from grid
                runAutoScriptUsingWinium(hostIPAddress, autoScriptName, ftpgridLocation);

            }
            //Deleting autoscript files from grid
            ftpClient.deleteFile(autoScriptName);


        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
                ftpClient.disconnect();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public boolean copyFileFromGridToLocalUsingFTP(String remoteFileOnGrid) {
        hostIPAddress = getRemoteNodeIP();

        File downloadFile = null;
        FTPClient ftpClient = new FTPClient();
        OutputStream outputStream = null;
        boolean success = false;

        try {
            ftpClient.connect(hostIPAddress);
            ftpClient.login(TestsContext.getInstance().gridUserName, TestsContext.getInstance().gridUserPassword);
            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            downloadFile = new File(String.format(TestsContext.getInstance().testDataFolderName + "/" + "files/" + "%s", remoteFileOnGrid));
            outputStream = new BufferedOutputStream(new FileOutputStream(downloadFile));
            //Downloads file from grid location to local using an outputStream
            success = ftpClient.retrieveFile(remoteFileOnGrid, outputStream);

            //Deleting remote files from grid
            ftpClient.deleteFile(remoteFileOnGrid);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (outputStream != null) {
                    outputStream.close();
                }
                ftpClient.disconnect();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return success;
        }
    }

    public void runAutoScriptUsingWinium(String hostIPAddress ,String remoteFile, String ftpgridLocation ) {

        DesktopOptions options = new DesktopOptions();
        try {
            options.setApplicationPath(ftpgridLocation + "\\" + remoteFile);
            winiumDriver = new WiniumDriver(new URL("http://" + hostIPAddress + ":9999"), options);
            //This wait is for allowing the exe to complete the execution [For example :Opening document,editing/verifying and closing]
            web.sleep(90000);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void winiumService(Session isSession, String winiumStopCommand) {
        hostIPAddress = getRemoteNodeIP();
        Session session = null;
        ChannelExec channel = null;
        try {

            JSch jsch = new JSch();
            session = jsch.getSession(gridUserName, hostIPAddress, 22);
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");

            session.setConfig(config);
            session.setPassword(gridPassword);
            session.connect();

            channel = (ChannelExec) session.openChannel("exec");
            channel.setCommand(winiumStopCommand);
            ((ChannelExec) channel).setPty(true);

            InputStream outputstream_from_the_channel = channel.getInputStream();
            OutputStream out = channel.getOutputStream();
            channel.connect();

            BufferedReader reader = new BufferedReader(new InputStreamReader(outputstream_from_the_channel));
            String linea = null;
            int index = 0;

            while ((linea = reader.readLine()) != null) {
                if (linea.contains("Press any key")) {
                    byte[] ENTER = {(byte) 0x0d};
                    out.write(ENTER);
                    out.flush();
                    out.write(winiumStopCommand.getBytes());
                    out.flush();
                    out.write(ENTER);
                    out.flush();
                    break;
                }
            }
            Thread.sleep(8000);
            while ((linea = reader.readLine()) != null) {
                System.out.println(++index + " : " + linea);
            }
            channel.disconnect();
            session.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getRemoteNodeIP() {
        String iPAddress = null;
        String errorMsg = "Failed to acquire remote webdriver node and port info. Root cause: ";
        String webDriverGridRemoteUrl = System.getProperty("webDriverGridRemoteUrl");

        URL aURL = null;
        RemoteWebDriver driver = null;
        try {
            aURL = new URL(webDriverGridRemoteUrl);
            Field field = null;
            try {
                field = ExtendedWebDriver.class.getDeclaredField("browserDriver");
                field.setAccessible(true);
                try {
                    driver = ((RemoteWebDriver) field.get(web));
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            } catch (NoSuchFieldException e) {
                e.printStackTrace();
            }

        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

        SessionId session = ((RemoteWebDriver) driver).getSessionId();

        try {
            HttpHost host = new HttpHost(aURL.getHost(), aURL.getPort());
            DefaultHttpClient client = new DefaultHttpClient();
            URL sessionURL = new URL("http://" + aURL.getHost() + ":" + aURL.getPort() + "/grid/api/testsession?session=" + session);
            BasicHttpEntityEnclosingRequest r = new BasicHttpEntityEnclosingRequest("POST", sessionURL.toExternalForm());
            HttpResponse response = client.execute(host, r);

            JsonObject object = extractObject(response);


            URL myURL = new URL(object.get("proxyId").getAsString());
            if ((myURL.getHost() != null) && (myURL.getPort() != -1)) {
                iPAddress = myURL.getHost();

            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(errorMsg, e);
        }
        return iPAddress;
    }

    private static JsonObject extractObject(HttpResponse resp) throws IOException {
        BufferedReader rd = new BufferedReader(new InputStreamReader(resp.getEntity().getContent()));
        StringBuffer s = new StringBuffer();
        String line;
        while ((line = rd.readLine()) != null) {
            s.append(line);
        }
        rd.close();
        JsonParser parser = new JsonParser();
        JsonObject objToReturn = (JsonObject) parser.parse(s.toString());
        return objToReturn;
    }


}
