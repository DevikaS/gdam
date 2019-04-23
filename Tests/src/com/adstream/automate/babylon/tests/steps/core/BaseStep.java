package com.adstream.automate.babylon.tests.steps.core;

import com.adstream.automate.babylon.*;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Localization;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.schema.cm.section.FieldContent;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.data.ProjectBuilder;
import com.adstream.automate.babylon.data.UserBuilder;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.babylon.middleware.BabylonSendplusMiddleTierService;
import com.adstream.automate.babylon.sut.Sut;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.tests.RelativePathConverter;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.gdn.activemq.ActiveMQService;
import com.adstream.automate.teamcity.TeamCityIntegration;
import com.adstream.automate.utils.ImapClient;
import com.adstream.automate.utils.ImapClientInterface;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.lightcouch.CouchDbClient;
import org.lightcouch.CouchDbProperties;
import org.openqa.selenium.JavascriptExecutor;

import java.net.URL;
import java.net.UnknownHostException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.util.Arrays.asList;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 29.03.12
 * Time: 18:41
 */
public class BaseStep {
    protected final static Logger log = Logger.getLogger(BaseStep.class);
    private static ThreadLocal<Sut> sut = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> coreApi = new ThreadLocal<>();
    private static ThreadLocal<TrafficServiceWrapper> trafficCoreApi = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> coreApiAdmin = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> coreApiDefaultAdmin = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> mtApi = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> nvergeApi = new ThreadLocal<>();
    private static ThreadLocal<TestDataContainer> testsData = new ThreadLocal<>();
    private static ThreadLocal<String> storyName = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> adcostApi = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> adcostCoreAdminApi = new ThreadLocal<>();
    private static ActiveMQService activeMQService;
    private static AMQServiceWrapper amqCoreApi ;
    private static ThreadLocal<GDNServiceWrapper> GDNApi = new ThreadLocal<>();
    private static ThreadLocal<BabylonServiceWrapper> mediaUploaderApi = new ThreadLocal<>();

    // thread safe fields
    private static ImapClientInterface mailClient;
    private static MongoClient mongoClient;
    private static DB mongoDB;
    // dbName -> Client
    private static Map<String, CouchDbClient> couchDbClients = new HashMap<>();

    private static AtomicInteger threadCounter = new AtomicInteger();

    // custom fields are used for custom advertiser hierarchy
    protected static final List<String> FIELDS_TO_WRAP = asList("Key Number","Business Unit:", "Originator:", "Original Project:",
            "Originator", "Business Unit", "Advertiser", "Brand", "Sub Brand", "Product", "Advertiser Custom", "Name",
            "Brand Custom", "Sub Brand Custom", "Product Custom", "Campaign Custom", "Collection", "Template", Localization.CLOCK_NUMBER.getDescription(),
            "Nom","Product"); // "Title" removed from wrap field as it breaking other tests.

    protected static final List<String> FIELDS_TO_WRAP_ADCOST = asList("Project Name","Cost Title", "Agency Tracking Number", "Description", "Name of Traveller",
            "Asset Title");

    protected static final List<String> EDIT_ASSET_FIELDS_TO_WRAP = asList("Key Number","Business Unit:", "Originator:", "Original Project:",
            "Originator", "Business Unit", "Advertiser", "Brand", "Sub Brand", "Product","Clock number");


    public static Sut getSut() {
        Sut currentSut = sut.get();
        if (currentSut == null) {
            currentSut = new Sut(getContext().applicationUrl,
                    ExtendedWebDriver.Browser.getByValue(getContext().browser),
                    extractWebdriverCapability(getContext().asMap()),
                    getContext().testsTempFolder,
                    getContext().enableHarFileSupport);
            sut.set(currentSut);
        }
        return currentSut;
    }

    private static Map<String, Object> extractWebdriverCapability(Map<String, Object> allMyProps) {
        String capabilityPrefix = "webdriver.";
        Map<String, Object> resultMap = new HashMap<>();
        for (Map.Entry<String, Object> entry : allMyProps.entrySet()) {
            if (entry.getKey().startsWith(capabilityPrefix)) {
                resultMap.put(entry.getKey().substring(capabilityPrefix.length()), entry.getValue());
            }
        }
        // pass story name and teamcity build to browser stack
        resultMap.put("name", storyName.get());
        resultMap.put("build", TeamCityIntegration.getBuildId());
        return resultMap;
    }

    // protected, because can be used only in steps
    protected static void stopSut() {
        Sut currentSut = sut.get();
        if (currentSut != null) {
     JavascriptExecutor js = currentSut.getWebDriver().getJavascriptExecutor();
      js.executeScript("window.onbeforeunload = function() {};");
            currentSut.stop();
            sut.remove();
        }
        getData().setCurrentUser(null);
    }

    public static void stopApi() {
        coreApi.remove();
    }

    public static TestsContext getContext() {
        return TestsContext.getInstance();
    }

    protected static TestDataContainer getData() {
        TestDataContainer currentData = testsData.get();
        if (currentData == null) {
            currentData = TestDataContainer.getDataSet(threadCounter.getAndIncrement());
            testsData.set(currentData);
            log.info("Current session id is " + currentData.getSessionId());
        }
        return currentData;
    }

    protected static ImapClientInterface getMailClient() {
        if (mailClient == null) {
            if (getContext().useFakeEmailService) {
                mailClient = new RestClientForMailMan(getContext().fakeEmailServiceUrl);
            } else {
                mailClient = ImapClient.getInstance();
                ((ImapClient) mailClient).setCredentials(getContext().imapHost, getContext().imapUserName, getContext().imapPassword);
            }
        }
        // log.info("mailclient" + mailClient);
        return mailClient;
    }

    protected static MongoClient getMongoClient() {
        if (mongoClient == null) {
            try {
                mongoClient = new MongoClient(getContext().mongoHost, getContext().mongoPort);
            } catch (Exception e) {
                log.error(e);
            }
        }
        return mongoClient;
    }

    protected static DB getMongoDB() {
        if (mongoDB == null) {
            mongoDB = getMongoClient().getDB(getContext().mongoDb);
        }
        return mongoDB;
    }

    protected static CouchDbClient getCouchDB(String db) {
        if (!couchDbClients.containsKey(db)) {
            CouchDbProperties properties = new CouchDbProperties();
            properties.setConnectionTimeout(5 * 1000); // 5 seconds
            properties.setCreateDbIfNotExist(false);
            properties.setDbName(db);
            properties.setHost(getContext().couchDbUrl.getHost());
            properties.setMaxConnections(10);
            properties.setPassword(getContext().couchDbPassword);
            properties.setPort(getContext().couchDbUrl.getPort());
            properties.setProtocol(getContext().couchDbUrl.getProtocol());
            properties.setSocketTimeout(30 * 1000); // 30 seconds
            properties.setUsername(getContext().couchDbUser);
            couchDbClients.put(db, new CouchDbClient(properties));
        }
        return couchDbClients.get(db);
    }

    protected static void setStoryName(String storyName) {
        BaseStep.storyName.set(storyName);
    }

    protected static UserBuilder getUserBuilder() {
        return new UserBuilder(getData(),
                getData().getCurrentUser().getAgency(),
                getContext().defaultUserPassword,
                getCoreApiAdmin(),
                getContext().isOrdering);
    }

    protected static ProjectBuilder getProjectBuilder() {
        return new ProjectBuilder(getData(),
                getContext().storiesDateTimeFormat,
                getData().getCurrentUser().getAgency(), ProjectBuilder.PROJECT_SUBTYPE);
    }

    protected static ProjectBuilder getTemplateBuilder() {
        return new ProjectBuilder(getData(),
                getContext().storiesDateTimeFormat,
                getData().getCurrentUser().getAgency(), ProjectBuilder.TEMPLATE_SUBTYPE);
    }

    protected static ProjectBuilder getWorkRequestBuilder() {
        return new ProjectBuilder(getData(),
                getContext().storiesDateTimeFormat,
                getData().getCurrentUser().getAgency(), ProjectBuilder.WORK_REQUEST_SUBTYPE);
    }

    protected static ProjectBuilder getWorkRequestTemplateBuilder() {
        return new ProjectBuilder(getData(),
                getContext().storiesDateTimeFormat,
                getData().getCurrentUser().getAgency(), ProjectBuilder.WORK_REQUEST_TEMPLATE_SUBTYPE);
    }

    public static BabylonServiceWrapper getCoreApi() {
        BabylonServiceWrapper currentCoreApi = coreApi.get();
        if (currentCoreApi == null) {
            URL coreUrl = getContext().coreUrl[0];
            currentCoreApi = new BabylonServiceWrapper(new BabylonCoreService(coreUrl), new PaperPusherCoreService(getContext().paperPusherUrl));
            coreApi.set(currentCoreApi);
            log.info("Target core version " + currentCoreApi.getVersion());
        }
        User user = getData().getCurrentUser();
        String loggedUserEmail = currentCoreApi.getLoggedUserEmail();
        if (loggedUserEmail == null || !loggedUserEmail.equals(user.getEmail()))
            currentCoreApi.logIn(user.getEmail(), user.getPassword());
        return currentCoreApi;
    }

    private String adcostUserId;
    public void setAdcostUser(String userId){
        adcostUserId = userId;
    }

    public void setAdcostUser(User user){
        getData().setCurrentUser(user);
        adcostUserId = user.getId();
    }

    public BabylonServiceWrapper getAdcostApi() {
        BabylonServiceWrapper currentAdcostApi = adcostApi.get();
        if (currentAdcostApi == null) {
            URL adcostCoreUrl = getContext().adcostCore;
            currentAdcostApi = new BabylonServiceWrapper(new BabylonCoreService(adcostCoreUrl), new PaperPusherCoreService(getContext().paperPusherUrl));
            adcostApi.set(currentAdcostApi);
            log.info("Target AdCost core version " + currentAdcostApi.getAdcostVersion());
        }
        User user = getData().getCurrentUser();
        String loggedUserEmail = currentAdcostApi.getLoggedUserEmail();
        if (loggedUserEmail == null || !loggedUserEmail.equals(user.getEmail()))
            currentAdcostApi.logInToAdcost(user);
        return currentAdcostApi;
    }

    public BabylonServiceWrapper getAdcostCoreAdminApi() {
        BabylonServiceWrapper currentAdcostApi = adcostCoreAdminApi.get();
        if (currentAdcostApi == null) {
            URL adcostCoreUrl = getContext().adcostCore;
            currentAdcostApi = new BabylonServiceWrapper(new BabylonCoreService(adcostCoreUrl), new PaperPusherCoreService(getContext().paperPusherUrl));
            User user = getData().getUserByType("GovernanceManager");
            adcostCoreAdminApi.set(currentAdcostApi);
            log.info("Target AdCost core version " + currentAdcostApi.getAdcostVersion());
        }
        User user = getData().getUserByType("GovernanceManager");
        String loggedUserEmail = currentAdcostApi.getLoggedUserEmail();
        if (loggedUserEmail == null || !loggedUserEmail.equals(user.getEmail()))
            currentAdcostApi.logInToAdcost(user);
        return currentAdcostApi;
    }

    public static TrafficServiceWrapper getTrafficCoreApi() {
        TrafficServiceWrapper currentTrafficCoreApi = trafficCoreApi.get();
        URL coreUrl = getContext().coreUrl[0];
        if (currentTrafficCoreApi == null) {
            URL trafficCoreUrl = getContext().trafficCoreUrl;
            currentTrafficCoreApi = new TrafficServiceWrapper(new TrafficCoreService(trafficCoreUrl));
            trafficCoreApi.set(currentTrafficCoreApi);
            log.info("Target delivery service version " + currentTrafficCoreApi.getVersion());
        }
        User user = getData().getCurrentUser();
        String loggedUserEmail = currentTrafficCoreApi.getLoggedUserEmail();
        if (loggedUserEmail == null || !loggedUserEmail.equals(user.getEmail()))
            currentTrafficCoreApi.logIn(user.getEmail(), user.getPassword(),coreUrl);
        return currentTrafficCoreApi;
    }

    public static BabylonServiceWrapper getCoreApiAdmin() {
        BabylonServiceWrapper currentCoreApi = coreApiAdmin.get();
        if (currentCoreApi == null) {
            URL coreUrl = getContext().coreUrl[0];
            currentCoreApi = new BabylonServiceWrapper(new BabylonCoreService(coreUrl), new PaperPusherCoreService(getContext().paperPusherUrl));
            User user = getData().getUserByType("GlobalAdmin");
            currentCoreApi.logIn(user.getEmail(), user.getPassword());
            coreApiAdmin.set(currentCoreApi);
        }
        return currentCoreApi;
    }

    public static BabylonServiceWrapper getCoreApiDefaultAdmin() {
        BabylonServiceWrapper currentCoreApi = coreApiDefaultAdmin.get();
        if (currentCoreApi == null) {
            URL coreUrl = getContext().coreUrl[0];
            currentCoreApi = new BabylonServiceWrapper(new BabylonCoreService(coreUrl), new PaperPusherCoreService(getContext().paperPusherUrl));
            User user = getData().getUserByType("DefaultGlobalAdmin");
            currentCoreApi.logIn(user.getEmail(), user.getPassword());
            coreApiDefaultAdmin.set(currentCoreApi);
        }
        return currentCoreApi;
    }

    public static BabylonServiceWrapper getCoreApi(User user) {
        User trafficAdmin=getData().getUserByType("AgencyAdmin");
        URL coreUrl = getContext().coreUrl[0];
        BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(coreUrl), new PaperPusherCoreService(getContext().paperPusherUrl));
        if (user.getPassword() != null) {
            service.logIn(user.getEmail(), user.getPassword());
        } else {
            if(trafficAdmin.getEmail().equalsIgnoreCase(user.getEmail()))
                service.logIn(user.getEmail(), trafficAdmin.getPassword());
            else
            service.logIn(user.getEmail(), getContext().defaultUserPassword);
        }

        return service;
    }

    public static BabylonServiceWrapper getMtApi() {
        BabylonServiceWrapper currentMtApi = mtApi.get();
        if (currentMtApi == null) {
            BabylonMiddlewareService service = new BabylonMiddlewareService(getContext().applicationUrl);
            currentMtApi = new BabylonServiceWrapper(service, service);
            mtApi.set(currentMtApi);
            log.info("Target mt version " + currentMtApi.getVersion());
        }
        User user = getData().getCurrentUser();
        String loggedUserEmail = currentMtApi.getLoggedUserEmail();
        if (loggedUserEmail == null || !loggedUserEmail.equals(user.getEmail())) {
            if (getContext().useSSO) {
                currentMtApi.logInSSO(user.getEmail(), user.getPassword());
            } else {
                currentMtApi.logIn(user.getEmail(), user.getPassword());
            }
        }
        return currentMtApi;
    }

    public static BabylonServiceWrapper getNVergeApi() {
        if (!getContext().useSSO) {
            throw new IllegalStateException("SSO have to be enabled when using nverge");
        }
        BabylonServiceWrapper currentNVergeApi = nvergeApi.get();
        if (currentNVergeApi == null) {
            BabylonSendplusMiddleTierService service = new BabylonSendplusMiddleTierService(getContext().applicationUrl);
            currentNVergeApi = new BabylonServiceWrapper(service, service);
            nvergeApi.set(currentNVergeApi);
        }
        User user = getData().getCurrentUser();
        String loggedUserEmail = currentNVergeApi.getLoggedUserEmail();
        if (loggedUserEmail == null || !loggedUserEmail.equals(user.getEmail()))
            currentNVergeApi.logInSSO(user.getEmail(), user.getPassword());
        return currentNVergeApi;
    }

    public static String wrapVariableWithTestSession(String variable) {
        if (variable == null || variable.isEmpty()) {
            return "";
        }
        if (variable.contains(getData().getSessionId())) {
            return variable;
        }
        return variable + getData().getSessionId();
    }

    public static String wrapPathWithTestSession(String path) {
        if (path.isEmpty() || path.equals("/")) {
            return path;
        }
        List<String> notWrappedParts = asList("Originals", "Brief");
        StringBuilder wrappedPath = new StringBuilder();
        for (String part : path.split("/")) {
            wrappedPath.append(notWrappedParts.contains(part) ? part : wrapVariableWithTestSession(part)).append("/");
        }
        return wrappedPath.substring(0, wrappedPath.length() - 1);
    }

    public static String wrapUserEmailWithTestSession(String userName) {  //todo move to testcommon
        User user = getData().getUserByType(userName);
        if (user != null) return user.getEmail();
        if (userName.contains("@")) return userName; // todo not sure about this
        if(userName.equalsIgnoreCase("new")) return "qatbabylonautotester+" + wrapVariableWithTestSession(userName) + "@gmail.com";
        return "qatbabylonautotester+" + wrapVariableWithTestSession(userName) + "@gmail.com";
    }

    protected static String wrapCollectionName(String collectionName) {
        if (collectionName.equalsIgnoreCase("My Assets") || (collectionName.equalsIgnoreCase("Everything")))
            return collectionName;
        else
            return wrapVariableWithTestSession(collectionName);
    }

    protected static String wrapAgencyName(String agencyName) {
        if (getData().getAgencyByName(agencyName) != null) {
            return getData().getAgencyByName(agencyName).getName();
        } else {
            return wrapVariableWithTestSession(agencyName);
        }
    }

    protected static Map<String, String> parametrizeTabularRow(ExamplesTable table) {
        return parametrizeTabularRow(table, 0);
    }

    protected static Map<String, String> parametrizeTabularRow(ExamplesTable table, int rowNumber) {
        Map<String, String> row = table.getRow(rowNumber);
        for (Map.Entry<String, String> rowEntry : row.entrySet()) {
            String key = rowEntry.getKey();
            String value = rowEntry.getValue();
            if (value.contains("<") && value.endsWith(">")) {
                String newValue = table.getRowAsParameters(rowNumber, true).valueAs(key, String.class);
                row.put(key, newValue.replaceFirst("<", "").substring(0, newValue.length() - 2));
            }
        }
        return row;
    }

    protected static List<Map<String, String>> parametrizeTableRows(ExamplesTable table) {
        List<Map<String, String>> parametrizedRows = new ArrayList<>();

        for (int i = 0; i < table.getRowCount(); i++) {
            parametrizedRows.add(parametrizeTabularRow(table, i));
        }

        return parametrizedRows;
    }

    protected static List<String> getParametrizedTableColumn(ExamplesTable table, String columnName) {
        if (!table.getHeaders().contains(columnName))
            throw new IllegalArgumentException(String.format("Unknown column name: '%s'", columnName));

        List<String> parametrizedRows = new ArrayList<>();

        for (int i = 0; i < table.getRowCount(); i++) {
            parametrizedRows.add(parametrizeTabularRow(table, i).get(columnName));
        }

        return parametrizedRows;
    }

    protected String normalizePath(String path) {
        if (path == null) path = "";
        else {
            path = path.replaceAll("\\s*/+\\s*", "/");
            if (path.endsWith("/")) path = path.substring(0, path.length() - 1);
            if (path.startsWith("/")) path = path.substring(1);
        }
        return path;
    }

    protected String getFilePath(String fileName) {
        if (fileName.equals("test"))
            fileName = Logo.PNG.getPath();
        else
            fileName = RelativePathConverter.getFullPath(fileName);
        return fileName;
    }


    protected String getAgencyIdByName(String agencyName) {
        if (getData().getAgencyByName(agencyName) != null) {
            return getData().getAgencyByName(agencyName).getId();
        } else if (getData().getAgencyByName(wrapVariableWithTestSession(agencyName)) != null) {
            return getData().getAgencyByName(wrapVariableWithTestSession(agencyName)).getId();
        } else if (getCoreApiAdmin().getAgencyByName(wrapVariableWithTestSession(agencyName)) != null) {
            return getCoreApiAdmin().getAgencyByName(wrapVariableWithTestSession(agencyName)).getId();
        }
        else
            return getCoreApiAdmin().getAgencyByName(agencyName).getId();

    }

    protected Agency getAgencyByName(String agencyName) {
        String agencyWithoutWrap=agencyName;
        Agency agency = getData().getAgencyByName(agencyName);
        if (agency == null) {
            agencyName = wrapVariableWithTestSession(agencyName);
            agency = getData().getAgencyByName(agencyName);
            if (agency == null) {
                agency = getCoreApiAdmin().getAgencyByName(agencyName);
                if (agency == null)
                    agency = getCoreApiAdmin().getAgencyByName(agencyWithoutWrap);
                if (agency != null)
                    getData().addAgency(agencyName, agency);
            }
        }
        return agency;
    }

    protected Agency getAgencyByNamenoWrapping(String agencyName) {
        Agency agency = getData().getAgencyByName(agencyName);
        if (agency == null) {
            agency = getData().getAgencyByName(agencyName);
            if (agency == null) {
                agency = getCoreApiAdmin().getAgencyByName(agencyName);
                if (agency != null)
                    getData().addAgency(agencyName, agency);
            }
        }
        return agency;
    }



    protected String getAssetName(String assetName) {
        return assetName.contains(".") ? assetName : wrapVariableWithTestSession(assetName);
    }

    protected String getCurrentUserDateFormat() {
        return getCoreApi().getCurrentUser().getDateTimeFormatter().getDateFormat();
    }

    protected String getCurrentUserDateTimeFormat() {
        return getCoreApi().getCurrentUser().getDateTimeFormatter().getDateTimeFormat();
    }

    protected static String getProjectDateFieldFormat(String fieldName) {
        FieldContent field = getCoreApiAdmin().getProjectSchema(getData().getCurrentUser().getAgency().getId()).getField(fieldName);

        return field != null && field.isDateType() ? field.getDateType() : null;
    }

    protected static List<MetadataItem> wrapMetadataFields(ExamplesTable data, String nameKey, String valueKey) {
        return wrapMetadataFields(parametrizeTableRows(data), FIELDS_TO_WRAP, nameKey, valueKey, ",",true);
    }

    protected static List<MetadataItem> wrapMetadataFieldsAssets(ExamplesTable data, String nameKey, String valueKey)  {
       return wrapMetadataFields(parametrizeTableRows(data), EDIT_ASSET_FIELDS_TO_WRAP, nameKey, valueKey, ",",false);
    }

    protected static List<MetadataItem> wrapMetadataFields_Adcost(ExamplesTable data, String nameKey, String valueKey) {
        return wrapMetadataFields(parametrizeTableRows(data), FIELDS_TO_WRAP_ADCOST, nameKey, valueKey, ",",false);
    }

    public static boolean isDate(String s){
        String pattern= "([0-9]{2})/([0-9]{2})/([0-9]{4})";
        return s.matches(pattern);}

    protected static List<MetadataItem> wrapMetadataFields(List<Map<String, String>> fields,
                                                           List<String> fieldsToWrap, String nameKey,
                                                           String valueKey, String valueSeparator,Boolean localized) {
        List<MetadataItem> items = new ArrayList<>();
        for (Map<String, String> field : fields) {
            String description = localized?Localization.findByKey(field.get(nameKey)):field.get(nameKey);
            String value = field.get(valueKey);
       /*     try {
                if (isDate(value)) {
                    SimpleDateFormat date = new SimpleDateFormat("dd/MM/yyyy");
                    value = new SimpleDateFormat("MMM d, yyyy").format(date.parse(value));
                }
            }catch (ParseException e){

            }*/
            if (fieldsToWrap.contains(description)) {
                String[] values = value.split(valueSeparator);

                for (int i = 0; i < values.length; i++) {
                    if (field.get(nameKey).equals("Collection")) {
                        values[i] = wrapCollectionName(values[i]);
                    } else if (field.get(nameKey).matches("Business Unit:?|Originator:?")) {
                        values[i] = wrapAgencyName(values[i]);
                    } else {
                        values[i] = wrapVariableWithTestSession(values[i]);
                    }
                }

                value = StringUtils.join(values, valueSeparator);
            }
            items.add(new MetadataItem(field.get("SectionName"), description, value));
        }

        return items;
    }

    protected static List<MetadataItem> convertMetadataFields(ExamplesTable data, String nameKey, String valueKey) {
        List<MetadataItem> items = new ArrayList<>();
        for (Map<String, String> field : parametrizeTableRows(data)) {
            String description = Localization.findByKey(field.get(nameKey));
            String value = field.get(valueKey);
            items.add(new MetadataItem(field.get("SectionName"), description, value));
        }
        return items;
    }

    public DateTime parseDateTime(String dateTimeString, String dateTimeFormat) {
        DateTime result;
        Calendar cal = Calendar.getInstance();
        Matcher m = Pattern.compile("(?<amount>\\d+) +(?<field>second|minute|hour|day|month|year)s? +(?<up>since|ago)").
                matcher(dateTimeString);

        if (m.find()) {
            boolean up = m.group("up").equals("since");
            int amount = Integer.parseInt(m.group("amount"));
            int field = new HashMap<String, Integer>() {{ put("year", Calendar.YEAR); put("month", Calendar.MONTH);
                put("day", Calendar.DAY_OF_MONTH); put("hour", Calendar.HOUR); put("minute", Calendar.MINUTE);
                put("second", Calendar.SECOND); }}.get(m.group("field"));

            cal.add(field, up ? amount : -amount);
            result = new DateTime(cal.getTime());
        } else if (dateTimeString.equalsIgnoreCase("yesterday")) {
            cal.add(Calendar.DAY_OF_MONTH, -1);
            result = new DateTime(cal.getTime());
        } else if (dateTimeString.equalsIgnoreCase("now") || dateTimeString.equalsIgnoreCase("today")) {
            result = DateTime.now();
        } else if (dateTimeString.equalsIgnoreCase("tomorrow")) {
            cal.add(Calendar.DAY_OF_MONTH, 1);
            result = new DateTime(cal.getTime());
        } else if (dateTimeString.equalsIgnoreCase("deepFuture")) {
            cal.add(Calendar.YEAR, 1);
            result = new DateTime(cal.getTime());
        } else {
            result = DateTime.parse(dateTimeString, DateTimeFormat.forPattern(dateTimeFormat));
        }

        return result;
    }

    public static ActiveMQService getActiveMQService() {
        if (null == activeMQService) {
            activeMQService = new ActiveMQService(getContext().ActiveMQUrl);
        }

        return activeMQService;
    }

    public static AMQServiceWrapper getAMQService() {

        amqCoreApi = new AMQServiceWrapper(new AMQCoreService(getActiveMQService()));
        return amqCoreApi;
    }

    public static GDNServiceWrapper getGDNApi() {

        GDNServiceWrapper currentGDNApi = GDNApi.get();
        if (currentGDNApi == null) {
            URL gdnUrl = getContext().gdnUrl;
            currentGDNApi = new GDNServiceWrapper(new GDNCoreService(gdnUrl));
            GDNApi.set(currentGDNApi);

        }
         return currentGDNApi;
    }

}