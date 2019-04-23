package com.adstream.automate.babylon;

import com.adstream.automate.utils.*;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import java.io.File;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * User: ruslan.semerenko
 * Date: 20.04.12 11:23
 */
public class TestsContext {
    @ConfigParam("application_url")
    public URL applicationUrl;

    @ConfigParam("sendplus_middle_tier")
    public URL sendplusMiddleTierUrl;

    @ConfigParam("S3_Storage_Id")
    public String s3StorageId;

    @ConfigParam("gdn_url")
    public URL gdnUrl;

    @ConfigParam("customBranding_url")
    public URL customBrandingUrl;

    @ConfigParam("customBeamBranding_url")
    public URL customBeamBrandingUrl;

    @ConfigParam("deliveryServer_url")
    public URL deliveryServerUrl;

    @ConfigParam(value = "core_url", splitBy = ",")
    public URL[] coreUrl;

    @ConfigParam(value = "ga_core_url", splitBy = ",")
    public URL[] gaCoreUrl;

    @ConfigParam(value = "traffic_url", splitBy = ",")
    public URL[] trafficUrl;

    @ConfigParam("deliveryServer_url")
    public URL trafficCoreUrl;

    @ConfigParam("adcost_frontEnd")
    public URL adcostFrontUrl;

    @ConfigParam("adcost_core_url")
    public URL adcostCore;

    @ConfigParam("amq_InternalHostName")
    public String amqInternalHostName;

    @ConfigParam("amq_ExternalHostName")
    public String amqExternalHostName;

    @ConfigParam("amq_Adcost_InternalQueue")
    public String amqAdcostInternalQueue;

    @ConfigParam("amq_Adcost_ExternalQueue")
    public String amqAdcostExternalQueue;

    @ConfigParam("amq_Adcost_InternalErrorQueue")
    public String amqAdcostInternalErrorQueue;

    @ConfigParam("tests.isAdcost")
    public String isAdcost;

    @ConfigParam("tests.isMediaManager")
    public String isMediaManager;

    @ConfigParam(value = "adpath_core_url", splitBy = ",")
    public URL[] adpathCoreUrl;

    @ConfigParam("paper_pusher_url")
    public URL paperPusherUrl;

    @ConfigParam(value = "storage_id", splitBy = ",")
    public String[] storageId;

    @ConfigParam("tests.generate_HAR_file")
    public boolean enableHarFileSupport;

    @ConfigParam("tests.browser")
    public String browser;

    @ConfigParam("tests.threads")
    public Integer threads;

    @ConfigParam("tests.unic_data_set")
    public boolean isUnicDataSet;

    @ConfigParam("tests.writescenariostofile")
    public boolean enableTestExecutionFile;

    @ConfigParam("stories.date_time_format")
    public String storiesDateTimeFormat;

    @ConfigParam("stories.path")
    public String storiesPath;

    @ConfigParam("sso_url")
    public URL ssourl;

    @ConfigParam(value = "stories.list", splitBy = ",")
    public String[] storiesList;

    @ConfigParam(value = "stories.meta_filter", splitBy = ",")
    public String[] storiesMeta;

    @ConfigParam("tests.date_time_format")
    public String userDateTimeFormat;

    @ConfigParam("tests.time_format")
    public String userTimeFormat;

    @ConfigParam("tests.data_folder")
    public String testDataFolderName;

    @ConfigParam("tests.ssokeyfile")
    public String testSSOKeyFile;

    @ConfigParam("tests.temp_folder")
    public String testsTempFolder;

    @ConfigParam("tests.default_objects_file")
    public String testsDefaultObjectsFile;

    @ConfigParam("tests.generate_list_file")
    public String testsGenerateListFile;

    @ConfigParam("tests.generate_list_file_adcost")
    public String generateAdcostListFile;

    @ConfigParam("tests.failed_scenario_count_perFile")
    public int failed_scenarios_count_perFile;

    @ConfigParam("tests.generate_local_reports")
    public Boolean testsGenerateLocalReports;

    @ConfigParam("tests.ordering")
    public boolean isOrdering;

    @ConfigParam("tests.isRealDB")
    public boolean isRealDb;

    @ConfigParam("tests.default_user_password")
    public String defaultUserPassword;

    @ConfigParam("tests.default_password_expiration_in_days")
    public Integer defaultPasswordExpiationInDays;

    @ConfigParam("tests.default_minimum_password_length")
    public Integer defaultMinimumPasswordLength;

    @ConfigParam("tests.default_numbers_count")
    public Integer defaultNumbersCount;

    @ConfigParam("tests.default_upper_case_characters_count")
    public Integer defaultUpperCaseCharactersCount;

    @ConfigParam("tests.run_again_on_fail")
    public boolean testsRunAgainOnFail;
    public boolean isSecondRun = false;

    @ConfigParam("tests.use_fake_email_service")
    public boolean useFakeEmailService;

    @ConfigParam("tests.ingestlocation")
    public String ingestlocation;

    @ConfigParam("tests.fake_email_service_url")
    public URL fakeEmailServiceUrl;

    @ConfigParam("tests.update_application_url_in_mail_service")
    public boolean updateApplicationUrlInMailService;

    @ConfigParam("tests.use_sso")
    public boolean useSSO;

    @ConfigParam("imap.delete_emails_before_tests")
    public boolean deleteEmailsBeforeTests;

    @ConfigParam("imap.host")
    public String imapHost;

    @ConfigParam("imap.username")
    public String imapUserName;

    @ConfigParam("imap.password")
    public String imapPassword;

    @ConfigParam("xmpp.host")
    public String xmppHost;

    @ConfigParam("xmpp.port")
    public Integer xmppPort;

    @ConfigParam("xmpp.domain")
    public String xmppDomain;

    @ConfigParam("mongo.host")
    public String mongoHost;

    @ConfigParam("mongo.port")
    public Integer mongoPort;

    @ConfigParam("mongo.db")
    public String mongoDb;

    @ConfigParam("couch_db.url")
    public URL couchDbUrl;

    @ConfigParam("couch_db.name")
    public String couchDbName;

    @ConfigParam("couch_db.user")
    public String couchDbUser;

    @ConfigParam("couch_db.password")
    public String couchDbPassword;

    @ConfigParam("mailservice.api_url")
    public URL mailServiceApiUrl;

    @ConfigParam("a4_default.user")
    public String a4DefaultUser;

    @ConfigParam("a4_default.agency.id")
    public String a4DefaultAgencyId;

    @ConfigParam(value = "grid_UserName")
    public String  gridUserName;

    @ConfigParam(value = "grid_UserPassword")
    public String  gridUserPassword;

    // for GDN
    @ConfigParam("a4gdnUrl")
    public URL a4gdnUrl;

    @ConfigParam("a4host")
    public String a4host;

    @ConfigParam("DB_CONNECTION")
    public String DB_CONNECTION;

    @ConfigParam("DB_LOGIN")
    public String DB_LOGIN;

    @ConfigParam("DB_PASSWORD")
    public String DB_PASSWORD;

    @ConfigParam("sampleVideoFileName")
    public String sampleVideoFileName;

    @ConfigParam("ingestDropPath")
    public String ingestDropPath;

    @ConfigParam("storageExtID")
    public String storageExtID;

    @ConfigParam("packMasters")
    public boolean packMasters;

    @ConfigParam("ActiveMQUrl")
    public String ActiveMQUrl ;

    @ConfigParam("TestSystemQueue")
    public String TestSystemQueue ;

    @ConfigParam("FileUploadLocation")
    public String FileUploadLocation ;

    @ConfigParam("A4FileUploadLocation")
    public String A4FileUploadLocation ;

    @ConfigParam("sessionID")
    public String sessionID ;

    @ConfigParam("tests.failed_scenario_list_path")
    public String failed_scenario_list_path;

    @ConfigParam("tests.executed_scenario_list_path")
    public String executed_scenario_list_path;

    @ConfigParam("tests.skipped_scenario_list_path")
    public String skipped_scenario_list_path;

    @ConfigParam("tests.newlibrary")
    public String isnewlibrary;
    /** MEDIA MANAGER **/

    @ConfigParam("mediamanager_application_url")
    public URL mediamanager_application_url;

    @ConfigParam("mediachecker-application_url")
    public URL mediachecker_application_url;

    @ConfigParam("mediamanager_core_url")
    public URL mediamanager_core_url;

    @ConfigParam("tests.isdefaultGlobalAdmin")
    public String isdefaultGlobalAdmin;

    private Map<String,Object> map = new HashMap<>();

    private static TestsContext testsContext = new TestsContext();

    private TestsContext() {
        String path = Common.urlDecode(this.getClass().getClassLoader().getResource("default.properties").getFile());
        loadConfig(new File(path));
    }

    public static TestsContext getInstance() {
        return testsContext;
    }

    public Map<String,Object> asMap(){
        return map;
    }

    public void loadConfig(File propertiesFile) {
        Properties props = IO.getProperties(propertiesFile);
        new ConfigLoader() {
            @Override
            public <T> String getConfigValue(T source, String configField) {
                return ((Properties) source).getProperty(configField);
            }
        }.load(this, props);
        //TODO move to config loader
        for (final String name: props.stringPropertyNames())
            map.put(name, props.getProperty(name));
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(getInstance(), ToStringStyle.MULTI_LINE_STYLE);
    }

    public String getRandomStorage() {
        return storageId[Gen.getInt(storageId.length)];
    }
}
