package com.adstream.automate.babylon.tests.api.tests;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.utils.ConfigLoader;
import com.adstream.automate.utils.ConfigParam;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.PropertyConfigurator;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeSuite;
import org.testng.xml.XmlTest;

import java.io.File;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 08.01.14 14:59
 */
public abstract class AbstractTest {

    @ConfigParam("applicationUrl")
    private static URL applicationUrl;

    @ConfigParam("globalAdminLogin")
    private static String globalAdminLogin;

    @ConfigParam("globalAdminPassword")
    private static String globalAdminPassword;

    @ConfigParam("defaultAgency")
    private static String defaultAgencyName;

    @ConfigParam("defaultStorageId")
    private static String defaultStorageId;

    @ConfigParam("defaultUser")
    private static String defaultUserEmail;

    @ConfigParam("defaultPassword")
    private static String defaultPassword;

    @ConfigParam("useUniqueAgencyNames")
    private static boolean useUniqueAgencyNames;

    @ConfigParam("useUniqueUserEmails")
    private static boolean useUniqueUserEmails;

    private static ThreadLocal<BabylonServiceWrapper> adminRestService = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> defaultRestService = new ThreadLocal<>();
    private static ThreadLocal<Agency> defaultAgency = new ThreadLocal<>();
    private static ThreadLocal<User> defaultUser = new ThreadLocal<>();
    private static ThreadLocal<String> sessionId = new ThreadLocal<>();
    private static AtomicInteger threadCounter = new AtomicInteger();

    @BeforeSuite
    protected void loadParametersBeforeSuit(XmlTest xmlTest) {
        setUpLogger();
        loadParameters(xmlTest.getSuite().getParameters());
    }

    @BeforeClass
    public void createDefaultAgencyAndUser() {
        getDefaultUser();
    }

    protected File getResource(String path) {
        try {
            URL url = this.getClass().getClassLoader().getResource(path);
            if (url == null) {
                return null;
            }
            return new File(url.toURI());
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return null;
        }
    }

    protected BabylonServiceWrapper getAdminRestService() {
        BabylonServiceWrapper restService = adminRestService.get();
        if (restService == null) {
            restService = new BabylonServiceWrapper(new BabylonMiddlewareService(getApplicationUrl()), null);
            restService.logInSSO(getGlobalAdminLogin(), getGlobalAdminPassword());
            adminRestService.set(restService);
        }
        return restService;
    }

    protected BabylonServiceWrapper getDefaultRestService() {
        BabylonServiceWrapper restService = defaultRestService.get();
        if (restService == null) {
            restService = new BabylonServiceWrapper(new BabylonMiddlewareService(getApplicationUrl()), null);
            restService.logInSSO(getDefaultUserEmail(), getDefaultPassword());
            defaultRestService.set(restService);
        }
        return restService;
    }

    protected Agency getDefaultAgency() {
        Agency defaultAgency = AbstractTest.defaultAgency.get();
        if (defaultAgency == null) {
            defaultAgency = getAdminRestService().getAgencyByName(getDefaultAgencyName());
            if (defaultAgency == null) {
                Agency agency = new Agency();
                agency.setName(getDefaultAgencyName());
                agency.setDescription(getDefaultAgencyName());
                agency.setSubtype("agency");
                agency.setPin("1");
                agency.setTimeZone("Europe-Andorra");
                agency.setCountry("AF");
                agency.setAgencyType("Advertiser");
                agency.setStorageId(getDefaultStorageId());
                defaultAgency = getAdminRestService().createAgency(agency);
            }
            AbstractTest.defaultAgency.set(defaultAgency);
        }
        return defaultAgency;
    }

    protected User getDefaultUser() {
        User defaultUser = AbstractTest.defaultUser.get();
        if (defaultUser == null) {
            defaultUser = getAdminRestService().getUserByEmail(getDefaultUserEmail(), 0);
            if (defaultUser == null) {
                User user = new User();
                user.setAgency(getDefaultAgency());
                user.setPhoneNumber("1234567890");
                user.setAdvertiser(user.getAgency().getId());
                user.setPassword(getDefaultPassword());
                user.setFullAccess();
                user.setRoles(new BaseObject[]{getAdminRestService().getRoleByName("agency.admin")});
                user.setFirstName("admin");
                user.setLastName("agency");
                user.setEmail(getDefaultUserEmail());
                defaultUser = getAdminRestService().createUser(user);
            }
            AbstractTest.defaultUser.set(defaultUser);
        }
        return defaultUser;
    }

    protected static String getSessionId() {
        String sessionId = AbstractTest.sessionId.get();
        if (sessionId == null) {
            sessionId = Gen.getString(5);
            AbstractTest.sessionId.set(sessionId);
        }
        return sessionId;
    }

    protected String getDefaultAgencyName() {
        String uniquePart = useUniqueAgencyNames ? getSessionId() : "" + threadCounter.getAndIncrement();
        if (uniquePart.equals("0")) {
            uniquePart = "";
        }
        return defaultAgencyName + uniquePart;
    }

    protected URL getApplicationUrl() {
        return applicationUrl;
    }

    protected String getDefaultUserEmail() {
        return useUniqueUserEmails ? wrapUserEmailWithTestSession(defaultUserEmail) : defaultUserEmail;
    }

    protected String getGlobalAdminLogin() {
        return globalAdminLogin;
    }

    protected String getGlobalAdminPassword() {
        return globalAdminPassword;
    }

    protected String getDefaultStorageId() {
        return defaultStorageId;
    }

    protected String getDefaultPassword() {
        return defaultPassword;
    }

    protected String wrapUserEmailWithTestSession(String email) {
        if (email.contains(getSessionId() + "@")) {
            return email;
        }
        String[] parts = email.split("@");
        return parts[0] + getSessionId() + "@" + parts[1];
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

    private void loadParameters(Map<String, String> parameters) {
        new ConfigLoader() {
            @Override
            public <T> String getConfigValue(T t, String s) {
                return ((Map<String, String>) t).get(s);
            }
        }.load(AbstractTest.class, parameters);
    }
}
