package com.adstream.automate.babylon.performance.yadn;

import com.google.gson.Gson;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 13.09.12 17:07
 */
public class Config {
    private static Config config;

    private Config() {}

    public static Config getInstance() {
        if (config == null) {
            throw new IllegalStateException("call loadConfig() first");
        }
        return config;
    }

    public static Config loadConfig(String path) {
        try {
            FileReader configFileReader = new FileReader(path);
            config = new Gson().fromJson(configFileReader, Config.class);
            return config;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private URL coreUrl;
    private String agencyAdminLogin;
    private String agencyAdminPassword;
    private boolean useGDN;
    private int testTimeMinutes;
    private int threadsCount;
    private int uploadsCount;
    private String[] uploadFilePath;
    private Map<String, String> log4jProperties;

    public boolean getUseGDN() {
        return useGDN;
    }

    public void setUseGDN(boolean useGDN) {
        this.useGDN = useGDN;
    }

    public URL getCoreUrl() {
        return coreUrl;
    }

    public void setCoreUrl(URL coreUrl) {
        this.coreUrl = coreUrl;
    }

    public String getAgencyAdminLogin() {
        return agencyAdminLogin;
    }

    public void setAgencyAdminLogin(String agencyAdminLogin) {
        this.agencyAdminLogin = agencyAdminLogin;
    }

    public String getAgencyAdminPassword() {
        return agencyAdminPassword;
    }

    public void setAgencyAdminPassword(String agencyAdminPassword) {
        this.agencyAdminPassword = agencyAdminPassword;
    }

    public int getTestTimeMinutes() {
        return testTimeMinutes;
    }

    public void setTestTimeMinutes(int testTimeMinutes) {
        this.testTimeMinutes = testTimeMinutes;
    }

    public int getThreadsCount() {
        return threadsCount;
    }

    public void setThreadsCount(int threadsCount) {
        this.threadsCount = threadsCount;
    }

    public int getUploadsCount() {
        return uploadsCount;
    }

    public void setUploadsCount(int uploadsCount) {
        this.uploadsCount = uploadsCount;
    }

    public String[] getUploadFilePath() {
        return uploadFilePath;
    }

    public void setUploadFilePath(String[] uploadFilePath) {
        this.uploadFilePath = uploadFilePath;
    }

    public Map<String, String> getLog4jProperties() {
        return log4jProperties;
    }

    public void setLog4jProperties(Map<String, String> log4jProperties) {
        this.log4jProperties = log4jProperties;
    }
}