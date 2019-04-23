package com.adstream.automate.babylon;

import com.adstream.automate.utils.ConfigLoader;
import com.adstream.automate.utils.ConfigParam;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.IO;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;

/**
 * User: ruslan.semerenko
 * Date: 20.04.12 11:23
 */
public class DataContext {

    @ConfigParam(value = "core_url", splitBy = ",")
    public URL[] coreUrl;

    @ConfigParam(value = "ga_core_url", splitBy = ",")
    public URL[] gaCoreUrl;

    @ConfigParam(value = "storage_id", splitBy = ",")
    public String[] storageId;

    @ConfigParam("tests.session_id")
    public String sessionId;

    @ConfigParam("tests.date_time_format")
    public String userDateTimeFormat;

    @ConfigParam("tests.default_user_password")
    public String defaultUserPassword;

    @ConfigParam("tests.isDefaultGlobalAdmin")
    public String isdefaultGlobalAdmin;

    private static DataContext testsContext = new DataContext();


    private DataContext() {
        loadConfig(this.getClass().getClassLoader().getResourceAsStream("default.properties"));
    }

    public static DataContext getInstance() {
        return testsContext;
    }

    public void loadConfig(InputStream propertiesFile) {
        new ConfigLoader() {
            @Override
            public <T> String getConfigValue(T source, String configField) {
                return ((Properties) source).getProperty(configField);
            }
        }.load(this, IO.getProperties(propertiesFile));
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

    public String getRandomStorage() {
        return storageId[Gen.getInt(storageId.length)];
    }
}
