package com.adstream.automate.babylon.migration.scripts;

import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import java.io.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/12/15
 * Time: 4:09 PM

 */
public class FTPUploader {
    FTPClient ftp = null;

    public FTPUploader(String host, String user, String pwd) throws Exception{
        ftp = new FTPClient();
        ftp.addProtocolCommandListener(new PrintCommandListener(new PrintWriter(System.out)));
        int reply;
        ftp.connect(host);
        reply = ftp.getReplyCode();
        if (!FTPReply.isPositiveCompletion(reply)) {
            ftp.disconnect();
            throw new Exception("Exception in connecting to FTP Server");
        }
        ftp.login(user, pwd);
        ftp.setFileType(FTP.BINARY_FILE_TYPE);
        ftp.enterLocalPassiveMode();

    }
    public void uploadFile(String localFileFullName, String fileName, String hostDir)
            throws Exception {
        try(InputStream input = new FileInputStream(new File(localFileFullName))){
            this.ftp.storeFile(hostDir + fileName, input);
        }
    }

    public void disconnect(){
        if (this.ftp.isConnected()) {
            try {
                this.ftp.logout();
                this.ftp.disconnect();
            } catch (IOException f) {
                // do nothing as file is already saved to server
            }
        }
    }
    public static void main(String[] args) throws Exception {
        System.out.println("Start");
        FTPUploader ftpUploader = new FTPUploader("ftp.adstream.com", "mongo-admin", "ooquooX4Tha");
        //FTP server path is relative. So if FTP account HOME directory is "/home/pankaj/public_html/" and you need to upload
        // files to "/home/pankaj/public_html/wp-content/uploads/image2/", you should pass directory parameter as "/wp-content/uploads/image2/"
        ftpUploader.uploadFile("./Jira/Italy_Order_1.0.zip", "Italy_Order_1.0.zip", "");

        ftpUploader.disconnect();
        System.out.println("Done");
    }
}
