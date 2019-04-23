package com.adstream.automate.babylon.migration.scripts;

import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

import java.io.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/31/15
 * Time: 1:42 PM

 */
public class FTPManager {

    FTPClient ftp = null;

    public static void main(String[] args) throws Exception {
        FTPManager ftpManager = new FTPManager("ftp.adstream.com", "mongo-admin", "ooquooX4Tha");
        FTPFile[] ftpFiles = ftpManager.getAllFTPFiles();
        System.out.println();

    }

    public FTPManager(String host, String user, String pwd) throws Exception {
        ftp = new FTPClient();
        //ftp.addProtocolCommandListener(new PrintCommandListener(new PrintWriter(System.out)));
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

    public void deleteFile(String fileName) throws IOException {
        ftp.deleteFile(fileName);
    }

    public FTPFile[] getAllFTPFiles() throws IOException {
        return ftp.listFiles();
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


}
