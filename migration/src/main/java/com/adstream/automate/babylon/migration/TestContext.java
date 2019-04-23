package com.adstream.automate.babylon.migration;

import com.adstream.automate.utils.ConfigLoader;
import com.adstream.automate.utils.ConfigParam;
import com.adstream.automate.utils.IO;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.File;
import java.util.Properties;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/19/15
 * Time: 12:53 PM

 */
public class TestContext {

    @ConfigParam("ftp.path")
    public String ftpPath;

    @ConfigParam("ftp.login")
    public String ftpLogin;

    @ConfigParam("ftp.password")
    public String ftpPassword;

    @ConfigParam("app.url")
    public String appUrl;

    @ConfigParam("mongo.url")
    public String mongoUrl;

    @ConfigParam("jira.issue")
    public String jiraIssue;

    @ConfigParam("env.name")
    public String envName;

    @ConfigParam("is.report")
    public boolean isReport;

    @ConfigParam("is.time.report")
    public boolean isTimeReport;

    @ConfigParam("google.key.file")
    public String googleKeyFile;

    @ConfigParam("path.to.local.storage")
    public String pathToLocalStorage;

    @ConfigParam("path.to.xml")
    public String pathToXml;

    @ConfigParam("proxy.only")
    public boolean proxyOnly;

    @ConfigParam("save.time")
    public boolean saveTime;

    @ConfigParam("xml.sources")
    public String xmlSources;

    @ConfigParam("is.order.report")
    public boolean isOrderReport;

    @ConfigParam("a4.db.server")
    public String a4DBServer;

    @ConfigParam("deliveryOnly")
    public boolean deliveryOnly;

    @ConfigParam("with_odt")
    public boolean withODT;

    private static TestContext testsContext = new TestContext();

    public static TestContext getInstance() {
        return testsContext;
    }

    private TestContext() {
        loadConfig(new File(this.getClass().getClassLoader().getResource("default.properties").getFile()));
    }

    public void loadConfig(File propertiesFile) {
        new ConfigLoader() {
            @Override
            public <T> String getConfigValue(T source, String configField) {
                return ((Properties) source).getProperty(configField);
            }
        }.load(this, IO.getProperties(propertiesFile));
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(getInstance(), ToStringStyle.MULTI_LINE_STYLE);
    }

}
