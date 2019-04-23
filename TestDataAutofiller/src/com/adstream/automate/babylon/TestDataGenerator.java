package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.CustomMetadataField;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.OrderType;
import com.adstream.automate.babylon.JsonObjects.schema.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.data.CustomMetadataSchemaName;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.data.ProjectBuilder;
import com.adstream.automate.babylon.sut.pages.ordering.elements.StepsOrderType;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import com.adstream.automate.utils.Gen;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.mongodb.*;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Type;
import java.net.URL;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
/**
 * User: ruslan.semerenko
 * Date: 23.04.12 11:29
 */
public class TestDataGenerator {
    protected final static Logger log = Logger.getLogger(TestDataGenerator.class);
    private static int dataSetCounter = 0;

    private File defaultObjectsFile;
    private File generateListFile;
    private File generateAdcostListFile;

    private BabylonServiceWrapper service;
    private int numOfSets;
    List<String> storieslist;
    private int testDataCount;
    private boolean unicDataSet;
    private boolean isOrdering;
    private URL coreUrl;
    private Role agencyAdminRole;
    private String globalAdminPassword;
    private String defaultGlobalAdminPassword;
    private static String customGlobalAdmin;
    private String defaultGlobalBuId="56f3bf77ce8bdde34133e516";
    private String globalAdminBusinessUnit= "Global Admin Business Unit";

    public TestDataGenerator(File defaultObjectsFile, File generateListFile, File properties, File generateAdcostListFile,List<String> storiestlist) {
        this(defaultObjectsFile, generateListFile, properties, generateAdcostListFile,1, false, true, storiestlist);
    }

    public TestDataGenerator(File defaultObjectsFile,
                             File generateListFile,
                             File properties,
                             File generateAdcostListFile,
                             int numOfSets,
                             boolean unicDataSet,
                             boolean isOrdering,
                             List<String> storiestlist) {
        this.defaultObjectsFile = defaultObjectsFile;
        this.generateListFile = generateListFile;
        this.generateAdcostListFile = generateAdcostListFile;
        this.numOfSets = numOfSets;
        this.unicDataSet = unicDataSet;
        this.isOrdering = isOrdering;
        this.storieslist = storiestlist;
        if (numOfSets > storieslist.size()) {
            testDataCount = storieslist.size();
        } else {
            testDataCount = numOfSets;
        }
        if (properties.exists()) {
            DataContext.getInstance().loadConfig(properties);
        }
        coreUrl = DataContext.getInstance().coreUrl[0];
        globalAdminPassword = getGlobalAdminPassword();
        defaultGlobalAdminPassword = getDefaultGlobalAdminPassword();
        service = new BabylonServiceWrapper(new BabylonCoreService(coreUrl), null);
        service.logIn("admin", defaultGlobalAdminPassword);
    }

    private String indexToSuffix(int i) {
        if (unicDataSet) {
            return Gen.getString(5);
        } else if (i == 0) {
            return "";
        } else {
            return String.valueOf(i);
        }
    }

    private User createCustomGlobalAdmin(User desiredUser){
        Agency agency = service.getCurrentAgency();
        User user = buildUserDetailsForNewGlobalAdmin(agency,desiredUser);
        if(!service.getGlobalAdminUsers().contains(user.getEmail())) {
            if(user.getFirstName()==null || user.getLastName()==null || user.getJobTitle()==null) {
                log.info("\n\n ***** Check that 'FirstName' or 'LastName' or 'JobTitle' are not empty and not null in order to create new GlobalAdmin user: "+user.getEmail());
                System.exit(0);
            }
            else user = service.createGlobalAdminUser(defaultGlobalBuId, user);
        }
        return user;
    }

    private User buildUserDetailsForNewGlobalAdmin(Agency agency, User desiredUser) {
        User user = new User();
        user.setAgency(agency);
        user.setJobTitle(desiredUser.getJobTitle());
        user.setFirstName(desiredUser.getFirstName());
        user.setLastName(desiredUser.getLastName());
        user.setPassword(desiredUser.getPassword());
        user.setEmail((user.getFirstName() + "." + user.getLastName()).toLowerCase()); // dot is mandatory to create new GA user
        user.setRegistered(true);
        user.setPasswordNeverExpires(true);
        return user;
    }

    private User createNewGlobalAdminUser(User desiredUser){
        User user = null;
        if(getGlobalAdminEmail().equalsIgnoreCase("admin")) {
            customGlobalAdmin = getGlobalAdminEmail();
            user = desiredUser;
        }
        else {
            user = createCustomGlobalAdmin(desiredUser);
            customGlobalAdmin = user.getEmail();
        }
        return user;
    }

    public void createDefaultElements() throws InterruptedException {
        String sessionId = DataContext.getInstance().sessionId;
        User defaultGlobalAdmin=null;
        if (sessionId == null || sessionId.isEmpty()) {
            sessionId = Gen.getString(5);
            DataContext.getInstance().sessionId = sessionId;
        }

        for (int i = 0; i < testDataCount; i++) {
            log.info(String.format("Create default elements for thread %d/%d", i + 1, testDataCount));
            TestDataContainer dataContainer = TestDataContainer.getDataSet(dataSetCounter);
            dataContainer.setSessionId(sessionId);
            Map<String, AgencyCollection> agencies = readCollection();
            AgencyDataCreatorThread[] threads = new AgencyDataCreatorThread[4];
            for (Map.Entry<String, AgencyCollection> agencyEntry : agencies.entrySet()) {
                for (Map.Entry<String, User> userEntry : agencyEntry.getValue().getUsers().entrySet()) {
                    User desiredUser = userEntry.getValue();
                    if(agencyEntry.getValue().agency.getName().equals(globalAdminBusinessUnit)) {
                        if (desiredUser.getCustomEmail().equals("admin")) {
                            defaultGlobalAdmin=desiredUser;
                            dataContainer.addUser(userEntry.getKey(), desiredUser);
                            customGlobalAdmin = desiredUser.getCustomEmail();
                        }
                        else if (desiredUser.getCustomEmail().equals("customGlobalAdmin"))
                            dataContainer.addUser(userEntry.getKey(), TestsContext.getInstance().isdefaultGlobalAdmin.equalsIgnoreCase("true")?defaultGlobalAdmin:createNewGlobalAdminUser(desiredUser));
                    }
                }
                AgencyDataCreatorThread thread = null;
                while (thread == null) {
                    for (int j = 0; j < threads.length; j++) {
                        if (threads[j] == null || !threads[j].isAlive()) {
                            if (threads[j] != null) log.info(threads[j].getLog());
                            BabylonServiceWrapper localService = new BabylonServiceWrapper(new BabylonCoreService(coreUrl), null);
                            localService.logIn(customGlobalAdmin, globalAdminPassword);
                            thread = new AgencyDataCreatorThread(localService,
                                    dataContainer,
                                    agencyEntry.getKey(),
                                    agencyEntry.getValue(),
                                    indexToSuffix(dataSetCounter),
                                    globalAdminPassword,
                                    defaultGlobalAdminPassword,
                                    isOrdering,
                                    customGlobalAdmin);
                            log.info("Starting thread for agency " + agencyEntry.getValue().getAgency().getName());
                            thread.start();
                            threads[j] = thread;
                            break;
                        }
                    }
                    Thread.sleep(100);
                }
            }
            waitForIngestBUCreation(300);
            updateIngestLocation(dataSetCounter);
            for (AgencyDataCreatorThread thread : threads) {
                if (thread == null) continue;
                thread.join();
                log.info(thread.getLog());
            }
            generateDataForCostModule(dataSetCounter);
            dataSetCounter++;
        }
        //Commenting this for as generatelist is anyways set to generate 0 data
         // generateData();
        addInvalidElements();
    }

    private boolean waitForIngestBUCreation(int maxTimeout){
        boolean ingestBUCreated = false;
        while(!(maxTimeout==0))
        {
            if (AgencyDataCreatorThread.isIngestBUCreated) {
                ingestBUCreated = true;
                break;
            }
            else {
                Common.sleep(2000);
                maxTimeout = maxTimeout - 2;
            }
        }
        return ingestBUCreated;
    }

    private void updateIngestLocation(int dataSetCounter){
        TestDataContainer dataContainer = TestDataContainer.getDataSet(dataSetCounter);
        Common.sleep(5000); // should be reverted
        Map<String,Agency> liAgency= dataContainer.getAgencyMap();
        Iterator it = liAgency.entrySet().iterator();
        Agency ingestAgency=liAgency.get("IngestAgency");
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry)it.next();
            Agency ag=(Agency)pair.getValue();
            if(!(ag.getName().equalsIgnoreCase(globalAdminBusinessUnit))) {
                if (ag.getId() != null) {
                    ag.setIngestLocationId(new String[]{ingestAgency.getId()});
                    service.updateAgency(ag);
                    dataContainer.getAgencyMap().put(String.valueOf(pair.getKey()), service.getAgencyByName(ag.getName()));
                }
            }
        }
    }

    private void addInvalidElements() {
        for (int i = 0; i < numOfSets; i++) {
            TestDataContainer dataContainer = TestDataContainer.getDataSet(i);
            String invalidName = "qwerty\\|/~!@#$%^&*()_+";
            Agency agency = new Agency();
            agency.setName(invalidName);
            dataContainer.addAgency("InvalidAgency", agency);
        }
    }

    private void generateData() {
        for (int j = 0; j < testDataCount; j++) {
            Map<String, GenerateDataAmountHolder> amountHolderMap = readAmountHolder();
            for (Map.Entry<String, GenerateDataAmountHolder> amountHolder : amountHolderMap.entrySet()) {
                TestDataContainer dataContainer = TestDataContainer.getDataSet(j);
                GenerateDataAmountHolder amount = amountHolder.getValue();
                User adminUser = dataContainer.getUserByType(amountHolder.getKey());
                if (adminUser == null) {
                    log.error("Failed to found user " + amountHolder.getKey());
                    continue; //we cannot resolve desired user, so skip iteration
                }

                log.info("Generate data for user " + adminUser.getEmail());
                service.logIn(adminUser.getEmail(), adminUser.getPassword());
                final Agency agency = service.getCurrentAgency();
                int usersCount = amount.getUsers() - getUsersCountInDb(adminUser.getId(), amount.getUsers());

                log.info("Create " + usersCount + " users");
                ExecutorService executor = Executors.newFixedThreadPool(4);
                for (int i = 0; i < usersCount; i++) {
                    executor.execute(new Runnable() {
                        @Override
                        public void run() {
                            User user = service.createUser(getRandomUser(agency));
                            service.allowUserToViewPublicTemplates(user.getAgency().getId(), user.getId(), true);
                        }
                    });
                }
                shutdownExecutorService(executor, new ArrayList<Future<String>>());

                if (amount.getProjects() != null) {
                    List<String> projectsId = createProjects(amount.getProjects(), true, adminUser, agency, dataContainer);
                    createFolders(projectsId, amount.getFolders(), amount.getSubfolders(), amount.getFiles());
                }

                if (amount.getTemplates() != null) {
                    List<String> projectsId = createProjects(amount.getTemplates(), false, adminUser, agency, dataContainer);
                    createFolders(projectsId, amount.getFolders(), amount.getSubfolders(), amount.getFiles());
                }

                if (amount.getTvOrders() != null) {
                    createOrders(amount.getTvOrders(), "TV");
                }

                if (amount.getRadioOrders() != null) {
                    createOrders(amount.getRadioOrders(), "MUSIC");
                }
            }
        }
    }

    private User getRandomUser(Agency agency) {
        User user = new User();
        user.setRoles(new Role[]{getAgencyAdminRole()});
        user.setAgency(agency);
        user.setGoogleTalkContact("1" + Gen.getInt(999999999));
        user.setJobTitle(Gen.getHumanReadableString(6, true));
        user.setMobileNumber("1" + Gen.getInt(999999999));
        user.setPhoneNumber("1" + Gen.getInt(999999999));
        user.setSkypeNumber("1" + Gen.getInt(999999999));
        user.setFirstName(Gen.getHumanReadableString(6, true));
        user.setLastName(Gen.getHumanReadableString(6, true));
        user.setPassword(DataContext.getInstance().defaultUserPassword);
        user.setEmail((user.getFirstName() + "." + user.getLastName() + "@test.com").toLowerCase());
        user.setFullAccess();
        if (!user.getAgency().equals("AdstreamQaIngest"))
            user.setDeliveryAccess(isOrdering);
        user.setLogo(getRandomLogo().getBase64());
        user.setRegistered(true);
        return user;
    }

    private Role getAgencyAdminRole() {
        if (agencyAdminRole == null) {
            agencyAdminRole = service.getRoleByName("agency.admin", false);
        }
        return agencyAdminRole;
    }

    private int getUsersCountInDb(String createById, int limit) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("createdBy._id:" + createById);
        query.setResultsOnPage(limit);
        return service.findUsers(query).getResult().size();
    }

    private List<String> createProjects(int count, boolean isProject, User owner, Agency agency, TestDataContainer dataSet) {
        String subtype = isProject ? ProjectBuilder.PROJECT_SUBTYPE : ProjectBuilder.TEMPLATE_SUBTYPE;
        final ProjectBuilder projectBuilder =
                new ProjectBuilder(dataSet, DataContext.getInstance().userDateTimeFormat, agency, subtype);
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("createdBy._id:%s", owner.getId()));
        query.setResultsOnPage(count);
        SearchResult<Project> result = isProject ? service.findProjects(query) : service.findTemplates(query);

        int projectsCount = count - result.getResult().size();

        log.info("Create " + projectsCount + " " + (isProject ? "projects" : "templates"));
        ExecutorService executor = Executors.newFixedThreadPool(4);
        List<Future<String>> results = new ArrayList<>();
        for (int i = 0; i < projectsCount; i++) {
            results.add(executor.submit(new Callable<String>() {
                @Override
                public String call() throws Exception {
                    Project project = projectBuilder.getProject(null, null, getRandomLogo());
                    return service.createProject(project).getFolders().get(0).getId();
                }
            }));
        }
        return shutdownExecutorService(executor, results);
    }

    private void createOrders(Integer count, final String type) {
        log.info("Create " + count + (getOrderType(type).equals("tv_order") ? " TV" : " Radio") + " orders");
        ExecutorService executor = Executors.newFixedThreadPool(4);
        for (int i = 0; i < count; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {

                    Order order = service.createOrder("Germany", getOrderType(type));
                    if (order == null) throw new NullPointerException("Order is not created!");
                    long start = System.currentTimeMillis();
                    do {
                        if (5000 > 0)
                            Common.sleep(1000);
                    }
                    while (service.getLastCreatedOrder("draft").getId().equals(order.getId()) && System.currentTimeMillis() - start < 5000);
                    OrderItem orderItem = generateOrderItem("Germany", new String[]{"Facebook DE:Standard"});
                    service.createOrderItem(order.getId(), getItemTypeByOrderType(type), orderItem);
                    QcView qcView = prepareOrderToComplete(order);
                    service.completeOrder(order, qcView);
                }
            });
        }
        shutdownExecutorService(executor, new ArrayList<Future<String>>());
    }

    private OrderItem generateOrderItem(String market, String[] destination) {
        OrderItem orderItem = new OrderItem();
        orderItem.setClockNumber(Gen.getHumanReadableString(6, true));
        orderItem.setTitle(Gen.getHumanReadableString(6, true));
        List<DestinationItem> destinationItem = createDestinationItem(market, destination);
        orderItem.setDestinationItems(destinationItem.toArray(new DestinationItem[destinationItem.size()]));
        orderItem.setFirstAirDate(DateTimeUtils.parseDateWithUTCZone("10/14/2022", "M/d/yyyy"));
        orderItem.setDuration("7");
        orderItem.setMotivnummer("22");
        return orderItem;

    }

    private List<DestinationItem> createDestinationItem(String market, String[] destinationAndServiceLevel) {
        List<DestinationItem> destinationItems = new ArrayList<>(destinationAndServiceLevel.length);
        for (String destination_serviceLvl : destinationAndServiceLevel) {
            String[] parts = destination_serviceLvl.split(":");
            Destination destination = service.getDestinationByName(market, parts[0]);
            ServiceLevel serviceLevel = service.getDestinationServiceLevelByName(destination, parts[1]);

            CustomMetadata cmServiceLvl = new CustomMetadata();
            cmServiceLvl.put("id", new String[]{serviceLevel.getKey()});

            CustomMetadata cmDestinationItem = new CustomMetadata();
            cmDestinationItem.put("id", new String[]{destination.getKey()});
            cmDestinationItem.put("serviceLevel", new ServiceLevel(cmServiceLvl));

            DestinationItem destinationItem = new DestinationItem(cmDestinationItem);
            destinationItems.add(destinationItem);
        }
        return destinationItems;

    }

    public QcView prepareOrderToComplete(Order order) {
        order.setJobNumber("1111");
        order.setPoNumber("1111");
        order.setPin("1111");
        QcView qcView = service.getQcView(order.getId());
        for (QcOrderItem qcOrderItem : qcView.getItems())
            if (qcOrderItem.getAssets() != null && !qcOrderItem.getAssets().isEmpty())
                qcOrderItem.getAssets().get(0).setAdbanked(true); // set true by default due to ORD-3353
        return qcView;
    }

    protected String getOrderType(String orderType) {
        if (orderType.equalsIgnoreCase(StepsOrderType.TV.toString()))
            return OrderType.TV.getOrderType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.MUSIC.toString()))
            return OrderType.MUSIC.getOrderType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.PRINT.toString()))
            return OrderType.PRINT.getOrderType();
        else
            throw new IllegalArgumentException("Unknown order type: " + orderType);
    }

    protected String getItemTypeByOrderType(String orderType) {
        if (orderType.equalsIgnoreCase(StepsOrderType.TV.toString()))
            return OrderType.TV.getOrderItemType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.MUSIC.toString()))
            return OrderType.MUSIC.getOrderItemType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.PRINT.toString()))
            return OrderType.PRINT.getOrderItemType();
        else
            throw new IllegalArgumentException("Unknown order type: " + orderType);
    }

    private <T> List<T> shutdownExecutorService(ExecutorService executor, List<Future<T>> futures) {
        executor.shutdown();
        do {
            Common.sleep(100);
        } while (!executor.isTerminated());
        List<T> result = new ArrayList<>();
        for (Future<T> future : futures) {
            try {
                result.add(future.get());
            } catch (Exception e) { /**/ }
        }
        return result;
    }

    private Logo getRandomLogo() {
        Logo[] logos = {Logo.GIF, Logo.JPEG, Logo.JPG, Logo.PNG};
        return logos[Gen.getInt(logos.length)];
    }

    private void createFolders(List<String> projectsId, Integer foldersCount, Integer subFoldersCount, Integer filesCount) {
        log.info("Create folders and files");
        foldersCount = foldersCount == null ? 0 : foldersCount;
        subFoldersCount = subFoldersCount == null ? 0 : subFoldersCount;
        for (String projectId : projectsId) {
            for (int i = 0; i < foldersCount; i++) {
                Content folder = service.createFolder(projectId, Gen.getHumanReadableString(10, true));
                for (int j = 0; j < subFoldersCount; j++) {
                    Content subFolder = service.createFolder(folder.getId(), Gen.getHumanReadableString(10, true));
                    uploadFile(filesCount, subFolder.getId());
                }
                uploadFile(filesCount, folder.getId());
            }
        }
    }

    private void uploadFile(Integer filesCount, String folderId) {
        if (filesCount != null) {
            for (int i = 0; i < filesCount; i++) {
                try {
                    File file = File.createTempFile(Gen.getString(10), Gen.getString(3));
                    IOUtils.write("0", new FileWriter(file));
                    service.uploadFile(file, folderId);
                    file.delete();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private String getGlobalAdminPassword() {
        Map<String, AgencyCollection> collection = readCollection();
        return collection.get("DefaultAdstreamGlobalAdminBU").getUsers().get("GlobalAdmin").getPassword();
    }

    private String getDefaultGlobalAdminPassword() {
        Map<String, AgencyCollection> collection = readCollection();
        return collection.get("DefaultAdstreamGlobalAdminBU").getUsers().get("DefaultGlobalAdmin").getPassword();
    }

    private String getDefaultGlobalAdminEmail() {
        Map<String, AgencyCollection> collection = readCollection();
        return collection.get("DefaultAdstreamGlobalAdminBU").getUsers().get("DefaultGlobalAdmin").getEmail();
    }

    private String getGlobalAdminEmail() {
        Map<String, AgencyCollection> collection = readCollection();
        return collection.get("DefaultAdstreamGlobalAdminBU").getUsers().get("GlobalAdmin").getEmail();
    }

    private Map<String, AgencyCollection> readCollection() {
        Type resultType = new TypeToken<Map<String, AgencyCollection>>() {
        }.getType();
        return readJsonFile(defaultObjectsFile, resultType);
    }

    private Map<String, GenerateDataAmountHolder> readAmountHolder() {
        Type resultType = new TypeToken<Map<String, GenerateDataAmountHolder>>() {
        }.getType();
        Map<String, GenerateDataAmountHolder> holder = readJsonFile(generateListFile, resultType);
        if (holder == null) holder = new HashMap<>();
        return holder;
    }

    private CustomMetaData readCustomMetaDataCollection() {
        Type resultType = new TypeToken<CustomMetaData>() { }.getType();
        return readJsonFile(generateAdcostListFile, resultType);
    }

    private <T> T readJsonFile(File file, Type T) {
        if (file == null) return null;
        try {
            String json = IOUtils.toString(new FileReader(file));
            return new Gson().fromJson(json, T);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static class AgencyCollection {
        private Agency agency;
        private Map<String, User> users;
        private Map<String, Role> roles;
        private Map<String, Project> projects;

        public Agency getAgency() {
            return agency;
        }

        public Map<String, User> getUsers() {
            if (users == null)
                users = new HashMap<>();
            return users;
        }

        public Map<String, Role> getRoles() {
            if (roles == null) {
                roles = new HashMap<>();
            }
            return roles;
        }

        public Map<String, Project> getProjects() {
            if (projects == null) {
                projects = new HashMap<>();
            }
            return projects;
        }
    }

    public static class GenerateDataAmountHolder {
        private Integer users;
        private Integer projects;
        private Integer templates;
        private Integer tvOrders;
        private Integer radioOrders;
        private Integer folders;
        private Integer subfolders;
        private Integer files;

        public Integer getUsers() {
            return users;
        }

        public Integer getProjects() {
            return projects;
        }

        public Integer getTemplates() {
            return templates;
        }

        public Integer getTvOrders() {
            return tvOrders;
        }

        public Integer getRadioOrders() {
            return radioOrders;
        }

        public Integer getFolders() {
            return folders;
        }

        public Integer getSubfolders() {
            return subfolders;
        }

        public Integer getFiles() {
            return files;
        }
    }

    public static class CustomMetaData{

        private DefaultProjectForCostModule[] DefaultProjectForCostModule;

        private MarkAsFields MarkAsFields;

        private DeleteExistingCatalogueStructure[] DeleteExistingCatalogueStructure;

        private AssignUserRolesInCostModule[] AssignUserRolesInCostModule;

        private DictionaryValuesInCostModule[] DictionaryValuesInCostModule;

        private CatalogueStructureValues[] CatalogueStructureValues;

        private CreateCustomCodeForCostModule CreateCustomCodeForCostModule;

        private CreateDefaultVendor[] CreateDefaultVendor;

        private CreateNewCatalogueStructure[] CreateNewCatalogueStructure;

        private AddUsersToPrimeAgency[] AddUsersToPrimeAgency;

        public DefaultProjectForCostModule[] getDefaultProjectForCostModule ()
        {
            return DefaultProjectForCostModule;
        }

        public void setDefaultProjectForCostModule (DefaultProjectForCostModule[] DefaultProjectForCostModule)
        {
            this.DefaultProjectForCostModule = DefaultProjectForCostModule;
        }

        public MarkAsFields getMarkAsFields ()
        {
            return MarkAsFields;
        }

        public void setMarkAsFields (MarkAsFields MarkAsFields)
        {
            this.MarkAsFields = MarkAsFields;
        }

        public DeleteExistingCatalogueStructure[] getDeleteExistingCatalogueStructure ()
        {
            return DeleteExistingCatalogueStructure;
        }

        public void setDeleteExistingCatalogueStructure (DeleteExistingCatalogueStructure[] DeleteExistingCatalogueStructure)
        {
            this.DeleteExistingCatalogueStructure = DeleteExistingCatalogueStructure;
        }

        public AssignUserRolesInCostModule[] getAssignUserRolesInCostModule ()
        {
            return AssignUserRolesInCostModule;
        }

        public void setAssignUserRolesInCostModule (AssignUserRolesInCostModule[] AssignUserRolesInCostModule)
        {
            this.AssignUserRolesInCostModule = AssignUserRolesInCostModule;
        }

        public DictionaryValuesInCostModule[] getDictionaryValuesInCostModule ()
        {
            return DictionaryValuesInCostModule;
        }

        public void setDictionaryValuesInCostModule (DictionaryValuesInCostModule[] DictionaryValuesInCostModule)
        {
            this.DictionaryValuesInCostModule = DictionaryValuesInCostModule;
        }

        public CatalogueStructureValues[] getCatalogueStructureValues ()
        {
            return CatalogueStructureValues;
        }

        public void setCatalogueStructureValues (CatalogueStructureValues[] CatalogueStructureValues)
        {
            this.CatalogueStructureValues = CatalogueStructureValues;
        }

        public CreateCustomCodeForCostModule getCreateCustomCodeForCostModule ()
        {
            return CreateCustomCodeForCostModule;
        }

        public void setCreateCustomCodeForCostModule (CreateCustomCodeForCostModule CreateCustomCodeForCostModule)
        {
            this.CreateCustomCodeForCostModule = CreateCustomCodeForCostModule;
        }

        public CreateDefaultVendor[] getCreateDefaultVendor ()
        {
            return CreateDefaultVendor;
        }

        public void setCreateDefaultVendor (CreateDefaultVendor[] CreateDefaultVendor)
        {
            this.CreateDefaultVendor = CreateDefaultVendor;
        }

        public CreateNewCatalogueStructure[] getCreateNewCatalogueStructure ()
        {
            return CreateNewCatalogueStructure;
        }

        public void setCreateNewCatalogueStructure (CreateNewCatalogueStructure[] CreateNewCatalogueStructure)
        {
            this.CreateNewCatalogueStructure = CreateNewCatalogueStructure;
        }

        public AddUsersToPrimeAgency[] getAddUsersToPrimeAgency ()
        {
            return AddUsersToPrimeAgency;
        }

        public void setAddUsersToPrimeAgency (AddUsersToPrimeAgency[] AddUsersToPrimeAgency)
        {
            this.AddUsersToPrimeAgency = AddUsersToPrimeAgency;
        }
    }

    public class CreateCustomCodeForCostModule {
        private String Enabled;

        private String SequentialNumber;

        private String CustomCodeName;

        private String FreeText;

        public String getEnabled() {
            return Enabled;
        }

        public void setEnabled(String Enabled) {
            this.Enabled = Enabled;
        }

        public String getSequentialNumber() {
            return SequentialNumber;
        }

        public void setSequentialNumber(String SequentialNumber) {
            this.SequentialNumber = SequentialNumber;
        }

        public String getCustomCodeName() {
            return CustomCodeName;
        }

        public void setCustomCodeName(String CustomCodeName) {
            this.CustomCodeName = CustomCodeName;
        }

        public String getFreeText() {
            return FreeText;
        }

        public void setFreeText(String FreeText) {
            this.FreeText = FreeText;
        }

    }

    public class AssignUserRolesInCostModule {
        private String User;

        private String Role;

        public String getUser() {
            return User;
        }

        public void setUser(String User) {
            this.User = User;
        }

        public String getRole() {
            return Role;
        }

        public void setRole(String Role) {
            this.Role = Role;
        }
    }

    public class AddUsersToPrimeAgency {
        private String User;

        private String Role;

        public String getUser() {
            return User;
        }

        public void setUser(String User) {
            this.User = User;
        }

        public String getRole() {
            return Role;
        }

        public void setRole(String Role) {
            this.Role = Role;
        }
    }

    public class CreateDefaultVendor {
        private String User;

        private String DefaultName;

        private String[] CategoryCompanyList;

        public String getUser() {
            return User;
        }

        public void setUser(String User) {
            this.User = User;
        }

        public String getDefaultName() {
            return DefaultName;
        }

        public void setDefaultName(String DefaultName) {
            this.DefaultName = DefaultName;
        }

        public String[] getCategoryCompanyList() {
            return CategoryCompanyList;
        }

        public void setCategoryCompanyList(String[] CategoryCompanyList) {
            this.CategoryCompanyList = CategoryCompanyList;
        }
    }

    public class DefaultProjectForCostModule {
        private String User;

        private String Brand;

        private String ProjectName;

        private String AgencyName;

        private String Sector;

        private String Advertiser;

        public String getUser ()
        {
            return User;
        }

        public void setUser (String User)
        {
            this.User = User;
        }

        public String getBrand ()
        {
            return Brand;
        }

        public void setBrand (String Brand)
        {
            this.Brand = Brand;
        }

        public String getProjectName ()
        {
            return ProjectName;
        }

        public void setProjectName (String ProjectName)
        {
            this.ProjectName = ProjectName;
        }

        public String getAgencyName ()
        {
            return AgencyName;
        }

        public void setAgencyName (String AgencyName)
        {
            this.AgencyName = AgencyName;
        }

        public String getSector ()
        {
            return Sector;
        }

        public void setSector (String Sector)
        {
            this.Sector = Sector;
        }

        public String getAdvertiser ()
        {
            return Advertiser;
        }

        public void setAdvertiser (String Advertiser)
        {
            this.Advertiser = Advertiser;
        }
    }

    public static class DictionaryValuesInCostModule {
        private String User;

        private String DictionaryName;

        private String dictionaryValue;

        private String DictionaryKey;

        public String getUser() {
            return User;
        }

        public void setUser(String User) {
            this.User = User;
        }

        public String getDictionaryName() {
            return DictionaryName;
        }

        public void setDictionaryName(String DictionaryName) {
            this.DictionaryName = DictionaryName;
        }

        public String getDictionaryValue() {
            return dictionaryValue;
        }

        public void setDictionaryValue(String dictionaryValue) {
            this.dictionaryValue = dictionaryValue;
        }

        public String getDictionaryKey() {
            return DictionaryKey;
        }

        public void setDictionaryKey(String DictionaryKey) {
            this.DictionaryKey = DictionaryKey;
        }
    }


    // ***Test Data Generation: Adcost Specific ****
    private void generateDataForCostModule(int dataSetCounter) {
        if (dataSetCounter == 0) {
            TestDataContainer dataContainer = TestDataContainer.getDataSet(dataSetCounter);
            Agency desiredAgency = dataContainer.getAgencyByName("DefaultAgency");
            if (isCostModule(desiredAgency)) {
                log.info("\n  *********** CostModule DataGeneration: START *********** ");
                checkDetailsInPropertyFile();
                String response = service.checkAdCostHeartBeat();
                if (!response.contains("green")) {
                    log.info("Check if Cost-module services are up & running: " + response);
                    System.exit(0);
                }
                service.logIn(customGlobalAdmin, globalAdminPassword);
                CustomMetaData jsonMetaData = readCustomMetaDataCollection();
                addedExistingUserToAgency(dataContainer, desiredAgency,jsonMetaData);
                if(!isCatalogueStructureAlreadyCreated(desiredAgency)) {
                    updateCustomMetadataFieldViaCore(desiredAgency,jsonMetaData);
                    createCustomMetadataFieldViaCore(desiredAgency,jsonMetaData);
                    updateAgencyByMarkedAsFields(desiredAgency,jsonMetaData);
                    createCatalogueStructureForCostModule(desiredAgency,jsonMetaData);
                } else log.info("Check Default Catalog Structure for CostModule: OK");
                createCustomCodeForCostModule(desiredAgency,jsonMetaData);
                assignUserRolesInCostModule(dataContainer,jsonMetaData);
                createProjectForCostModule(dataContainer,jsonMetaData);
                createDictionaryValuesInCostModule(dataContainer, jsonMetaData);
                createDefaultVendorInCostModule(dataContainer,jsonMetaData);
                log.info("  *********** CostModule DataGeneration: END ***********  \n");
            }
        }
    }

    private void checkDetailsInPropertyFile() {
        try {
            TestsContext.getInstance().adcostCore.toString();
            TestsContext.getInstance().adcostFrontUrl.toString();
            TestsContext.getInstance().amqInternalHostName.toString();
            TestsContext.getInstance().amqExternalHostName.toString();
            TestsContext.getInstance().amqAdcostExternalQueue.toString();
            TestsContext.getInstance().amqAdcostInternalQueue.toString();
            TestsContext.getInstance().amqAdcostInternalErrorQueue.toString();
        } catch (Exception e) {
            log.info("Something missing in property file. Check for {'adcost_core_url', 'adcost_frontEnd', 'amq_InternalHostName', " +
                    "'amq_ExternalHostName', 'amq_Adcost_InternalQueue', 'amq_Adcost_ExternalQueue', 'amq_Adcost_InternalErrorQueue'}");
            System.exit(0);
        }
    }

    public boolean isCostModule(Agency desiredAgency) {
        try {
            for (String moduleName : desiredAgency.getLabels())
                if ((moduleName.contains("adcost") || moduleName.contains("CM_Prime_P&G")) & (TestsContext.getInstance().isAdcost.equalsIgnoreCase("true")))
                    return true;
        } catch (NullPointerException e) {
            return false;
        }
        return false;
    }

    private void addedExistingUserToAgency(TestDataContainer dataContainer, Agency desiredAgency,CustomMetaData jsonMetaData) {
        for(AddUsersToPrimeAgency usersToPrimeAgency:jsonMetaData.getAddUsersToPrimeAgency()){
            String agencyId = desiredAgency.getId();
            User user = dataContainer.getUserByType(usersToPrimeAgency.getUser());
            if (user != null) {
                String roleId = service.getRoleByName(usersToPrimeAgency.getRole(), false).getId();
                service.addExistingUserToAgency(user.getId(), agencyId, roleId);
            } else
                throw new Error("Couldn't found user details for '"+usersToPrimeAgency.getUser()+"'");
        }
    }

    private boolean isCatalogueStructureAlreadyCreated(Agency desiredAgency){
        String agencyId = desiredAgency.getId();
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = service.getAssetElementProjectCommonSchema(agencyId);
        CustomMetadata data = assetElementProjectCommonSchema.getCmSectionProperties("common");
        String schema =new Gson().toJsonTree(data).toString();
        if (!(schema.contains("Brand_") && schema.contains("Sector_"))) {
            return false;
        } else return true;
    }

    private void updateCustomMetadataFieldViaCore(Agency desiredAgency,CustomMetaData jsonMetaData) {
        String schemaName = "common";
        String agencyId = desiredAgency.getId();
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = service.getAssetElementProjectCommonSchema(agencyId);
        ProjectSchema projectSchema = service.getProjectSchema(agencyId);
        AssetElementCommonSchema assetElementCommonSchema = service.getAssetElementCommonSchema(agencyId);
        DeleteExistingCatalogueStructure[] catStruct= jsonMetaData.getDeleteExistingCatalogueStructure();

        for(DeleteExistingCatalogueStructure structure:catStruct){
            Map<String, String> properties = new HashMap<>();
            if (structure.getFieldType().equalsIgnoreCase("catalogueStructure") && (structure.getParent() == null || structure.getParent().isEmpty())) {
                if (schemaName.equalsIgnoreCase("common")) {
                    properties.put("FieldType",structure.getFieldType());
                    properties.put("Description",structure.getDescription());
                    properties.put("Parent",structure.getParent());
                    properties.put("Deleted",structure.getDeleted());
                    properties.put("Validate",structure.getValidate());
                    properties.put("SchemaName", String.format("asset_element_project_common.agency.%s", agencyId));
                    properties.put("FieldId", assetElementProjectCommonSchema.getCMFieldIdFromSectionByDescription(schemaName, properties.get("Description")));
                    assetElementProjectCommonSchema.updateCMField(properties);
                }
            }
        }

        service.updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
        service.updateProjectSchema(agencyId, projectSchema);
        service.updateAssetElementCommonSchema(agencyId, assetElementCommonSchema);
    }

    private void createCustomMetadataFieldViaCore(Agency desiredAgency,CustomMetaData jsonMetaData) {
        String schemaName = "common";
        String agencyId = desiredAgency.getId();
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = service.getAssetElementProjectCommonSchema(agencyId);
        ProjectSchema projectSchema = service.getProjectSchema(agencyId);
        AssetElementCommonSchema assetElementCommonSchema = service.getAssetElementCommonSchema(agencyId);
        CreateNewCatalogueStructure[] catStruct= jsonMetaData.getCreateNewCatalogueStructure();

        for(CreateNewCatalogueStructure structure:catStruct){
            Map<String, String> properties = new HashMap<>();
            if (structure.getFieldType().equalsIgnoreCase("catalogueStructure") && (structure.getParent() != null || !structure.getParent().isEmpty())) {
                if (schemaName.equalsIgnoreCase("common")) {
                    properties.put("FieldType",structure.getFieldType());
                    properties.put("Description",structure.getDescription());
                    properties.put("Parent",structure.getParent());
                    properties.put("SchemaName", String.format("asset_element_project_common.agency.%s", agencyId));
                    properties.put("FieldId", String.format("%s_%s", properties.get("Description").replaceAll("[^\\w]", ""), Long.toString(DateTime.now().getMillis())));
                    assetElementProjectCommonSchema.createCMField(properties);
                }
            }
        }

        service.updateAssetElementProjectCommonSchema(agencyId, assetElementProjectCommonSchema);
        service.updateProjectSchema(agencyId, projectSchema);
        service.updateAssetElementCommonSchema(agencyId, assetElementCommonSchema);
    }

    public void updateAgencyByMarkedAsFields(Agency agency,CustomMetaData jsonMetaData) {
        String schemaName = "common";
        MarkAsFields fields = jsonMetaData.getMarkAsFields();
        String sName = CustomMetadataSchemaName.findByName(schemaName);
        Schema schema = service.getAssetElementProjectCommonSchema(agency.getId());

        if (fields.getMarkasAdvertiser()!=null && !fields.getMarkasAdvertiser().isEmpty()) {
            String dictionaryId = schema.getCMFieldIdFromSectionByDescription(sName, fields.getMarkasAdvertiser());
            agency.setA4AdvertiserField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        if (fields.getMarkAsSector()!=null && !fields.getMarkAsSector().isEmpty()) {
            String dictionaryId = schema.getCMFieldIdFromSectionByDescription(sName, fields.getMarkAsSector());
            agency.setA4SectorField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        if (fields.getBrand_CostModule()!=null && !fields.getBrand_CostModule().isEmpty()) {
            String brand = "Brand_";
            CustomMetadata data = schema.getCmSectionProperties(schemaName);
            String s = data.toString();
            String randomNumber = s.split(brand)[1].split("=")[0];
            String dictionaryId = brand.concat(randomNumber);
            agency.setA4BrandField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        service.updateAgency(agency);
    }

    private void createCatalogueStructureForCostModule(Agency desiredAgency,CustomMetaData jsonMetaData) {
        String agencyId = desiredAgency.getId();
        Dictionary dictionary = service.getAgencyDictionaryByName(agencyId, "advertiser");
        if (dictionary != null) {
            DictionaryValues dictionaryValues = dictionary.getValues();
            if (dictionaryValues.size() == 0) {
                createCatStructure(agencyId,jsonMetaData);
            } else {
                for (String s : dictionaryValues.getKeys()) {
                    if (!s.contains("DefaultAdv")) {
                        createCatStructure(agencyId,jsonMetaData);
                        break;
                    }
                    log.info("Check Default Catalog Structure for CostModule: OK");
                }
            }
        } else createCatStructure(agencyId,jsonMetaData);
    }

    private void createCatStructure(String agencyId,CustomMetaData jsonMetaData) {
        AssetElementProjectCommonSchema assetElementProjectCommonSchema = service.getAssetElementProjectCommonSchema(agencyId);
        String dictionaryId = assetElementProjectCommonSchema.getFieldDictionaryIdFromSectionByDescription("common", "Advertiser");
        CustomMetadata choices = new CustomMetadata();
        choices.put("values", new ArrayList<CustomMetadata>());

        List<String> item = new ArrayList<String>();
        for(CatalogueStructureValues structure:jsonMetaData.getCatalogueStructureValues()){
            if (structure.getFieldName().contains("Advertiser") || structure.getFieldName().contains("Brand") ||
                    structure.getFieldName().contains("Sub Brand") || structure.getFieldName().contains("Product") || structure.getFieldName().contains("Sector")) {
                item.add(structure.getFieldChoice().concat(";").concat(structure.getCustomCharacters()));
            } else {
                item.add(structure.getFieldChoice().concat(";").concat(structure.getCustomCharacters()));
            }
        }
        addValues(choices, item);

        service.updateAgencyDictionaryValues(agencyId, dictionaryId, (ArrayList<CustomMetadata>) choices.get("values"));
        log.info("Check Default Catalog Structure for CostModule: NEW");
    }

    private void assignUserRolesInCostModule(TestDataContainer dataContainer,CustomMetaData jsonMetaData) {
        service.logIn(getDefaultGlobalAdminEmail(), globalAdminPassword);
        for(AssignUserRolesInCostModule assignRoles:jsonMetaData.getAssignUserRolesInCostModule())
        {
            User user = dataContainer.getUserByType(assignRoles.getUser());
            String agencyId = user.getAgency().getId();
            String typeId = getAgencyIdInCostModule(agencyId);
            checkBUReplicationToCostModule(agencyId);
            checkUsersReplicationToCostModule(user);
            service.grantUserAccessInCostModule(getUserIdInCostModule(user.getEmail()),
                    getBusinessRoleId(assignRoles.getRole()), "", "Client", typeId, "","");
        }
        log.info("Check User Role assign in CostModule: OK");
    }

    private Boolean checkForBuReplication(String agencyId) {
        Agencies[] agencies = service.getAgencyIdInCostModule();
        for (Agencies agency : agencies)
            if (agency.getGdamAgencyId().equals(agencyId)) {
                return true;
            }
        return false;
    }

    private void checkBUReplicationToCostModule(String agencyId) {
        final long timeOut = 300;
        final long globalTimeout = 3 * 60 * 1000; // 3 min
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 1);
        } while (!checkForBuReplication(agencyId) && System.currentTimeMillis() - start < globalTimeout);
        if (System.currentTimeMillis() - start > globalTimeout) {
            log.info("\n \n ************** Timeout:: BU replication failed for A5 BU_ID # '" + agencyId + " **************\n \n ");
            System.exit(0);
        }
    }

    private Boolean checkForUserReplication(String email) {
        CostUser users = service.searchUserByAgencyID(email);
        CostUsers[] costUsers = users.getUsers();
        for (CostUsers user : costUsers) {
            if (user.getEmail().equalsIgnoreCase(email))
                return true;
        }
        return false;
    }

    private void checkUsersReplicationToCostModule(User user) {
        final long timeOut = 300;
        final long globalTimeout = 3 * 60 * 1000; // 3 min
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 1);
        }
        while (!checkForUserReplication(user.getEmail()) && System.currentTimeMillis() - start < globalTimeout);
        if (System.currentTimeMillis() - start > globalTimeout) {
            log.info("\n \n ************** Timeout:: User with '" + user.getEmail() + "' not found in CostModule!! **************\n \n ");
            System.out.println("");
            System.exit(0);
        }
    }

    public void createProjectForCostModule(TestDataContainer dataContainer,CustomMetaData jsonMetaData) {
        for(DefaultProjectForCostModule projectData:jsonMetaData.getDefaultProjectForCostModule()) {
            Map<String, String> customFields = new HashMap<>();
            Agency agency = dataContainer.getAgencyByName(projectData.getAgencyName());

            User user = dataContainer.getUserByType(projectData.getUser());
            service.logIn(user.getEmail(), user.getPassword());
            LuceneSearchingParams query = new LuceneSearchingParams();
            query.setQuery(String.format("createdBy._id:%s", user.getId()));
            SearchResult<Project> result = service.findProjects(query);
            Schema schema_common = service.getAssetElementProjectCommonSchema(agency.getId());

            if (result.getTotal() == null || result.getTotal() == 0) {
                Schema schema = service.getProjectSchema(agency.getId());
                String[] customData = new String[2];
                Map<String, String> row = new HashMap<>();

                row.put("Name", projectData.getProjectName());
                row.put("Advertiser", projectData.getAdvertiser());
                row.put("Sector", projectData.getSector());
                row.put("Brand", projectData.getBrand());

                //   Map<String, String> customfields = new HashMap<>();
                String customCodeFieldName = "ProjectId_";
                CustomMetadata data = schema.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(customCodeFieldName)[1].split("=")[0];
                String customCodeName = customCodeFieldName.concat(randomNumber);
                String customCodeValue = service.generateCustomCode(agency.getId(), customCodeName);
                customData[0] = customCodeName;
                customData[1] = customCodeValue;

                String sector = "Sector".concat("_");
                CustomMetadata dataSector = schema_common.getCmSectionProperties("common");
                String dataSectorString = dataSector.toString();
                String randomNumberSector = dataSectorString.split(sector)[1].split("=")[0];
                String sectorName = sector.concat(randomNumberSector);
                customFields.put(sectorName, (row.get("Sector")));
                row.remove("Sector");

                String brand = "Brand".concat("_");
                CustomMetadata dataBrand = schema_common.getCmSectionProperties("common");
                String dataBrandString = dataBrand.toString();
                String randomNumberBrand = dataBrandString.split(brand)[1].split("=")[0];
                String brandName = brand.concat(randomNumberBrand);
                customFields.put(brandName, (row.get("Brand")));
                row.remove("Brand");

                Project project = new ProjectBuilder(dataContainer, TestsContext.getInstance().storiesDateTimeFormat,
                        dataContainer.getCurrentUser().getAgency(), ProjectBuilder.PROJECT_SUBTYPE).getProject(row);

                project.setAgency(agency);
                Project projectApi = service.getProjectByName(project.getName(), 0);
                project.buildCustomFieldsAsArray(customFields);
                project.buildCustomFieldsAsString(customData[0], customData[1]);
                if (projectApi == null) {
                    service.createProject(project);
                    service.getProjectByName(project.getName()); //slow down, be sure that project available for search
                    log.info("Check Default Project '" + project.getName() + "' for CostModule: NEW");
                }
            } else log.info("Check Default Project '" + result.getResult().get(0).getName() + "' for CostModule: OK");
        }
    }

    private void createDictionaryValuesInCostModule(TestDataContainer dataContainer, CustomMetaData jsonMetaData) {
        for(DictionaryValuesInCostModule values:jsonMetaData.getDictionaryValuesInCostModule())
        {
            User user = dataContainer.getUserByType(values.getUser());
            boolean isKeyUnique = false;
            String dictionaryId = null;
            service.logIn(user.getEmail(), user.getPassword());
            AdcostDictionaries[] dictionaries = service.getAdcostDictionaryByNameGDAMway(values.getDictionaryName());
            for (AdcostDictionaries dict : dictionaries) {
                if (dict.getName().equals(values.getDictionaryName())) {
                    DictionaryEntries[] dictionaryEntries = dict.getDictionaryEntries();
                    for (DictionaryEntries entries : dictionaryEntries) {
                        dictionaryId = entries.getDictionaryId();
                        if (!entries.getKey().equalsIgnoreCase(values.getDictionaryKey()))
                            isKeyUnique = true;
                        else {
                            isKeyUnique = false;
                            log.info("Check Default Dictionary '" + values.getDictionaryName() + "' in CostModule as '" + values.getDictionaryKey() + "': OK");
                            break;
                        }
                    }
                }
            }
            if (isKeyUnique) {
                ContentType request = new ContentType();
                request.setKey(values.getDictionaryKey());
                request.setValue(values.getDictionaryValue());
                request.setDictionaryId(dictionaryId);
                request.setVisible("true");
                service.createEntryInAdcostDictionaryGDAMway(request);
                log.info("Check Default Dictionary '" + values.getDictionaryName() + "' in CostModule as '" + values.getDictionaryKey() + "': CREATE NEW");
            }
        }
        service.logIn(customGlobalAdmin, globalAdminPassword);
    }

    private void createDefaultVendorInCostModule(TestDataContainer dataContainer,CustomMetaData jsonMetaData) {
        for(CreateDefaultVendor vendorData:jsonMetaData.getCreateDefaultVendor()){
            String defaultName = vendorData.getDefaultName();
            boolean isKeyUnique = false;
            User user = dataContainer.getUserByType(vendorData.getUser());
            service.logIn(user.getEmail(), user.getPassword());
            VendorsCount vendorsCount = service.getVendorsGDAMway(defaultName);
            if (!vendorsCount.getCount().equals("0")) {
                Vendors[] vendors = vendorsCount.getVendors();
                for (Vendors vendor : vendors) {
                    if (!vendor.getName().equalsIgnoreCase(defaultName))
                        isKeyUnique = true;
                    else {
                        isKeyUnique = false;
                        log.info("Check Default Vendor in CostModule as '" + defaultName + "': OK");
                        break;
                    }
                }
            } else isKeyUnique = true;

            if (isKeyUnique) {
                Vendors vendor = new Vendors();
                vendor.setName(defaultName);
                VendorCategoryModels vendorCategoryModels;
                List<VendorCategoryModels> addVendorCategoryModels = new ArrayList<>();
                for (String company : vendorData.getCategoryCompanyList()) {
                    vendorCategoryModels = new VendorCategoryModels();
                    vendorCategoryModels.setName(company);
                    addVendorCategoryModels.add(vendorCategoryModels);
                    vendor.setVendorCategoryModels(addVendorCategoryModels);
                }
                service.createVendorsGDAMway(vendor);
                log.info("Check Default Vendor in CostModule as '" + defaultName + "': CREATE NEW");
            }
        }
        service.logIn(customGlobalAdmin, globalAdminPassword);
    }

    private CustomMetadata addValues(CustomMetadata result, List<String> items) {
        String key = items.remove(0);
        boolean hasKey = false;
        for (CustomMetadata value : (ArrayList<CustomMetadata>) result.get("values")) {
            if (key.equals(value.get("key"))) {
                hasKey = true;
                break;
            }
        }
        if (!hasKey) {
            CustomMetadata item = new CustomMetadata();
            String[] keyItem = key.split(";");
            if (keyItem.length > 1) {
                item.put("key", (keyItem[0]));
                item.put("additionalParameter", keyItem[1]);
            } else
                item.put("key", key);
            if (!items.isEmpty() && items.get(0) != null && !items.get(0).isEmpty())
                item.put("values", new ArrayList<CustomMetadata>());
            ((ArrayList<CustomMetadata>) result.get("values")).add(item);
        }
        if (!items.isEmpty() && items.get(0) != null && !items.get(0).isEmpty()) {
            addValues(((ArrayList<CustomMetadata>) result.get("values")).get(((ArrayList<CustomMetadata>) result.get("values")).size() - 1), items);
        }
        return result;
    }

    public void createCustomCodeForCostModule(Agency desiredAgency,CustomMetaData jsonMetaData) {
        Map<String, String> rowwer = new HashMap<>();
        rowwer.put("Name", jsonMetaData.getCreateCustomCodeForCostModule().getCustomCodeName());
        rowwer.put("Sequential Number", jsonMetaData.getCreateCustomCodeForCostModule().getSequentialNumber());
        rowwer.put("Free Text", jsonMetaData.getCreateCustomCodeForCostModule().getFreeText());
        rowwer.put("Enabled", jsonMetaData.getCreateCustomCodeForCostModule().getEnabled());

        String agencyId = desiredAgency.getId();
        String sName = CustomMetadataSchemaName.findByName("project");
        Schema schema = service.getProjectSchema(agencyId);
        if (!new Gson().toJsonTree(schema.getCmSectionProperties("common")).toString().contains(jsonMetaData.getCreateCustomCodeForCostModule().getCustomCodeName())) {
            Map<String, String> rowData = rowwer;
            CustomMetadata data = schema.getCmSectionProperties("common");
            String customCodeFieldName = String.format("%s_%s", "ProjectId".replaceAll("[^\\w]", ""), Long.toString(DateTime.now().getMillis()));
            CustomMetadata node = data.getOrCreateNode(customCodeFieldName);
            node.put("description", customCodeFieldName);
            node.put("description", jsonMetaData.getCreateCustomCodeForCostModule().getCustomCodeName());
            node.put("include_in_all", true);
            if (rowData.containsKey("Make it compulsory") && rowData.get("Make it compulsory").equalsIgnoreCase("true"))
                node.put("required", true);
            else node.put("required", false);

            node.put("type", "custom_code");
            node.put("validate", true);

            CustomMetadata view = node.getOrCreateNode("view");
            CustomMetadata e = view.getOrCreateNode("e");
            CustomMetadata e_group = e.getOrCreateNode("group");
            e_group.put("project_common", "_default");
            CustomMetadata e_order = e.getOrCreateNode("order");
            e_order.put("project_common", Integer.parseInt("1"));
            e.put("width", Integer.parseInt("1"));
            e.put("visible", true);
            e.put("isEditable", true);

            CustomMetadata v = view.getOrCreateNode("v");
            CustomMetadata v_group = v.getOrCreateNode("group");
            v_group.put("project_common", "_default");
            CustomMetadata v_order = v.getOrCreateNode("order");
            v_order.put("project_common", Integer.parseInt("1"));
            v.put("width", Integer.parseInt("1"));
            v.put("visible", true);
            view.put("schemaName", sName.concat(".agency.").concat(agencyId));

            List<AutoGeneratePattern> autoGeneratePatterns = new ArrayList<>();

            Iterator it = rowwer.entrySet().iterator();
            Map.Entry pair = (Map.Entry) it.next();
            pair.getValue();

            if (pair.getKey().equals("Name"))
                rowwer.put(pair.getKey().toString(), pair.getValue().toString());

            List<PatternItem> patternItems = new ArrayList<>();

            // Free Text
            CustomMetadata patternItem = new CustomMetadata();
            patternItem.put("type", PatternItemType.SEPARATOR);
            patternItem.put("character", jsonMetaData.getCreateCustomCodeForCostModule().getFreeText());
            patternItems.add(new PatternItem(patternItem));

            // Sequential Number
            CustomMetadata patternIte = new CustomMetadata();
            patternIte.put("type", PatternItemType.SEQUENCE);
            patternIte.put("characters", jsonMetaData.getCreateCustomCodeForCostModule().getSequentialNumber());
            patternItems.add(new PatternItem(patternIte));

            CustomMetadata pattern = new CustomMetadata();
            pattern.put("items", patternItems.toArray(new PatternItem[patternItems.size()]));
            pattern.put("name", jsonMetaData.getCreateCustomCodeForCostModule().getCustomCodeName());
            pattern.put("enabled", true);

            autoGeneratePatterns.add(new AutoGeneratePattern(pattern));

            CustomMetadata autoGen = node.getOrCreateNode("autogenerate");
            autoGen.put("index", 1);
            autoGen.put("patterns", autoGeneratePatterns.toArray(new AutoGeneratePattern[autoGeneratePatterns.size()]));

            service.updateProjectSchema(agencyId, (ProjectSchema) schema);
            log.info("Check Default Custom Code '"+jsonMetaData.getCreateCustomCodeForCostModule().getCustomCodeName()+"' for CostModule: NEW");
        } else log.info("Check Default Custom Code '"+jsonMetaData.getCreateCustomCodeForCostModule().getCustomCodeName()+"' for CostModule: OK");
    }

    private String getUserIdInCostModule(String email) {
        CostUser users = service.searchUserByAgencyID(email);
        CostUsers[] costUsers = users.getUsers();
        for (CostUsers user : costUsers)
            if (user.getEmail().equalsIgnoreCase(email))
                return user.getId();
        throw new Error("Check if user with email: " + email + " replicated to CostModule");
    }

    private String getBusinessRoleId(String userRole) {
        UserRoles[] userRoles = service.getBusinessRoles();
        for (UserRoles role : userRoles) {
            if (role.getKey().equalsIgnoreCase(userRole)) {
                return role.getId();
            }
        }
        throw new IllegalArgumentException("Couldn't found BusinessUserRole in CostModule: " + userRole);
    }

    private String getAgencyIdInCostModule(String agencyId) {
        Agencies[] agencies = service.getAgencyIdInCostModule();
        for (Agencies agency : agencies)
            if (agency.getGdamAgencyId().equals(agencyId))
                return agency.getId();
        throw new Error("Check if agency id # : " + agencyId + " replicated to CostModule");
    }
}

class AgencyDataCreatorThread extends Thread {
    private BabylonServiceWrapper service;
    private TestDataContainer dataContainer;
    private String agencyKey;
    private TestDataGenerator.AgencyCollection agencyCollection;
    private String uniqueSuffix;
    private Map<String, Content> foldersCache = new HashMap<>();
    private StringBuilder log = new StringBuilder();
    private String globalAdminPassword;
    private boolean isOrdering;
    private String customGlobalAdmin;
    private String defaultGlobalAdminPassword;
    public static boolean isIngestBUCreated;

    public AgencyDataCreatorThread(BabylonServiceWrapper service, TestDataContainer dataContainer,
                                   String agencyKey, TestDataGenerator.AgencyCollection agencyCollection,
                                   String uniqueSuffix, String globalAdminPassword, String defaultGlobalAdminPassword,boolean isOrdering,String customGlobalAdmin) {
        this.service = service;
        this.dataContainer = dataContainer;
        this.agencyKey = agencyKey;
        this.agencyCollection = agencyCollection;
        this.uniqueSuffix = uniqueSuffix;
        this.globalAdminPassword = globalAdminPassword;
        this.defaultGlobalAdminPassword = defaultGlobalAdminPassword;
        this.isOrdering = isOrdering;
        this.customGlobalAdmin=customGlobalAdmin;
    }

    public boolean isCostModule(Agency desiredAgency) {
        try {
            for (String moduleName : desiredAgency.getLabels())
                if (moduleName.contains("adcost") || moduleName.contains("CM_Prime_P&G") || moduleName.contains("costPG"))
                    return true;
        } catch (NullPointerException e) {
            return false;
        }
        return false;
    }

    public boolean isDefaultAdstreamGlobalAdminBU(Agency desiredAgency){
        return desiredAgency.getName().equals("Global Admin Business Unit")?true:false;
    }

    public void run() {
        Agency desiredAgency = agencyCollection.getAgency();
        if(!isBroadcaster(desiredAgency)) {
            if(isCostModule(desiredAgency)){
                desiredAgency.setName(desiredAgency.getName());
            } else if(isDefaultAdstreamGlobalAdminBU(desiredAgency))
                desiredAgency.setName(desiredAgency.getName());
            else if (isIngestBU(desiredAgency))
                desiredAgency.setName(desiredAgency.getName());
            else desiredAgency.setName(desiredAgency.getName() + uniqueSuffix); //fix agency
        }
        else{
            desiredAgency.setDestinationId(Integer.valueOf(desiredAgency.getDestinationId()));
        }

        Agency agency = createAgency(desiredAgency);
        if (agency == null) {
            log.append("Failed to create agency ").append(desiredAgency.getName()).append("\r\n");
            return; //we cannot create desired agency, so skip iteration
        } else if(isIngestBU(agency))
            isIngestBUCreated=true;

        dataContainer.addAgency(agencyKey, agency);

        // Create users
        List<User> createdUsers = createUsers(agency);
        User agencyAdmin = null;
        if (createdUsers.size() > 0)
            agencyAdmin = createdUsers.get(0);

        // Create roles
        for (Map.Entry<String, Role> roleEntry : agencyCollection.getRoles().entrySet()) {
            createRole(agencyAdmin, roleEntry.getValue());
        }

        // Create projects
//        createProjects(agency, agencyAdmin);
    }

    private boolean isIngestBU(Agency agency){
        boolean check=false;
        for(String type:agency.getAgencyType()){
            if(type.equalsIgnoreCase("Ingest"))
                check=true;
        }
        return check;
    }

    private boolean isBroadcaster(Agency agency){
        boolean check=false;
        for(String type:agency.getAgencyType()){
            if(type.equalsIgnoreCase("TV Broadcaster"))
                check=true;
        }
        return check;
    }
    private List<User> createUsers(Agency agency) {
        boolean check=false;
        User defaultGlobalAdmin=null;
        List<User> createdUsers = new ArrayList<>();
        for (Map.Entry<String, User> userEntry : agencyCollection.getUsers().entrySet()) {
            User desiredUser = userEntry.getValue();
            desiredUser.setAgency(agency);
            if(!isBroadcaster(agency)) {
                if (!isCostModule(agency)) {
                    if (!desiredUser.getEmail().equals("admin") && !uniqueSuffix.isEmpty())
                        desiredUser.setEmail(desiredUser.getEmail().replace("@", uniqueSuffix + "@"));
                } else {
                    if (!desiredUser.getEmail().equals("admin") && !uniqueSuffix.isEmpty())
                        desiredUser.setEmail(desiredUser.getEmail());
                }
            }
            Role[] roles = new Role[desiredUser.getRoles().length];
            if (roles.length > 0) {
                for (int i = 0; i < roles.length; i++) {
                    roles[i] = service.getRoleByName(desiredUser.getRoles()[i].getName(),false);
                }
                desiredUser.setRoles(roles);
            }
            //  desiredUser.setDeliveryAccess(isOrdering);
            desiredUser.setRegistered(true);

            User user = null;
            if(isDefaultAdstreamGlobalAdminBU(agency)) {
                if (desiredUser.getCustomEmail().equals("admin")) {
                    user = desiredUser;
                    defaultGlobalAdmin = desiredUser;
                }
                else {
                    if (TestsContext.getInstance().isdefaultGlobalAdmin.equalsIgnoreCase("true")) {
                        if (desiredUser.getCustomEmail().equals("customGlobalAdmin"))
                            user = defaultGlobalAdmin;
                    } else
                        user = desiredUser;
                }
            }
            else
                user = createUser(desiredUser);

            dataContainer.addUser(userEntry.getKey(), user);
            createdUsers.add(user);
        }
        return createdUsers;
    }

//    private void createProjects(Agency agency, User agencyAdmin) {
//        for (Map.Entry<String, Project> projectEntry : agencyCollection.getProjects().entrySet()) {
//            Project projectBar = projectEntry.getValue();
//            projectBar.setAgency(agency);
//            Project project =
//                    createProject(agencyAdmin, projectBar,
//                            dataContainer.getEnum(projectBar.getCampaign().getName()).getId(),
//                            dataContainer.getEnum(projectBar.getProduct().getName()).getId());
//            if (projectBar.getFolders() != null) {
//                for (Content folder : projectBar.getFolders()) {
//                    log.append(String.format("Create folder '%s'", folder.getName())).append("\r\n");
//                    createFolderRecursiveFast(folder.getName(), project.getId(), project.getId());
//                }
//            }
//        }
//    }

    public String getLog() {
        return log.toString();
    }

    private Content createFolderRecursiveFast(String path, String projectId, String parentId) {
        if (path.startsWith("/")) path = path.substring(1);
        String[] parts = path.split("/", 2);
        String folderName = parts[0];
        String folderCacheId = String.format("%s-%s-%s", projectId, parentId, folderName);
        Content folder = foldersCache.get(folderCacheId);
        if (folder == null) {
            folder = service.getFolderByName(projectId, parentId, folderName, 0);
            if (folder == null) {
                folder = service.createFolder(parentId, folderName);
            }
            foldersCache.put(folderCacheId, folder);
        }
        if (parts.length == 2) {
            folder = createFolderRecursiveFast(parts[1], projectId, folder.getId());
        }
        return folder;
    }

//    private Project createProject(User agencyAdmin, Project project, String campaignId, String productId) {
//        service.logIn(agencyAdmin.getEmail(), agencyAdmin.getPassword());
//        String message = String.format("Check %s '%s': ", project.getSubtype(), project.getName());
//        Project checkedProject;
//        if (project.getSubtype().equals("project")) {
//            checkedProject = service.getProjectByName(project.getName(), 0);
//        } else {
//            checkedProject = service.getTemplateByName(project.getName(), 0);
//        }
//        if (checkedProject == null) {
//            log.append(message).append("CREATE NEW\r\n");
//            Map<String, String> enums = project.getEnums();
//            if (!enums.get("product").isEmpty()) {
//                enums.put("product", productId);
//            }
//            enums.put("category", null);
//            if (!enums.get("advertiser").isEmpty()) {
//                enums.put("advertiser", agencyAdmin.getAgency().getId());
//            }
//            if (!enums.get("product").isEmpty()) {
//                enums.put("campaign", campaignId);
//            }
//            checkedProject = service.createProject(project);
//        } else {
//            log.append(message).append("OK\r\n");
//        }
//        service.logIn("admin", globalAdminPassword);
//        return checkedProject;
//    }

    private Role createRole(User agencyAdmin, Role role) {
        if (agencyAdmin == null) {
            return null;
        }
        service.logIn(agencyAdmin.getEmail(), agencyAdmin.getPassword());
        String message = String.format("Check role '%s': ", role.getName());
        Role checkedRole = service.getRoleByName(role.getName(), 0 ,false);
        if (checkedRole != null) {
            log.append(message).append("OK\r\n");
        } else {
            log.append(message).append("CREATE NEW\r\n");
            checkedRole = service.createRole(role.getName(), role.getGroup(), role.getAllow(), agencyAdmin.getAgency().getId());
        }
        service.logIn(customGlobalAdmin, globalAdminPassword);
        return checkedRole;
    }

    private User createUser(User predefinedUser) {
        String message = String.format("Check user '%s': ", predefinedUser.getEmail());
        User user = service.getUserByEmail(predefinedUser.getEmail(), 0);
        if (user != null) {
            log.append(message).append("OK\r\n");
        } else {
            log.append(message).append("CREATE NEW\r\n");
            user = service.createUser(predefinedUser);
            service.allowUserToViewPublicTemplates(user.getAgency().getId(), user.getId(), true);
            service.getUserByEmail(user.getEmail());
        }
        user.setPassword(predefinedUser.getPassword());
        return user;
    }

    private void updateAllBroadcastersWithDestination(Agency agen){
        try {
            DB mongoDB;
            MongoClient mongoClient = new MongoClient(TestsContext.getInstance().mongoHost, TestsContext.getInstance().mongoPort);
            mongoDB = mongoClient.getDB("gdam");
            List<String> dbs = mongoClient.getDatabaseNames();
            List<String> results = new ArrayList<>();
            DBCollection schemaCollection = mongoDB.getCollection("group");
            BasicDBObject query1 = new BasicDBObject("_cm.common.agencyType","TV Broadcaster");
            query1.put("_cm.common.destinationID",agen.getDestinationId());
            DBObject filter = new BasicDBObject("_cm.common.name", 1);
            DBObject obj = schemaCollection.findOne(query1,filter);
            Iterator iterator = null;
            if(obj!=null) {
                iterator = ((BasicDBObject) obj).entrySet().iterator();
                while (iterator.hasNext()) {
                    Map.Entry map = (Map.Entry)iterator.next();
                    if (map.getKey().toString().equalsIgnoreCase("_cm")) {
                        if (map.getValue() instanceof BasicDBObject) {
                            Iterator value = ((BasicDBObject) map.getValue()).entrySet().iterator();
                            while (value.hasNext()) {
                                Map.Entry mapValue = (Map.Entry) value.next();
                                if (mapValue.getValue() instanceof BasicDBObject) {
                                    Iterator iteratorName = ((BasicDBObject) mapValue.getValue()).entrySet().iterator();
                                    while (iteratorName.hasNext()) {
                                        Map.Entry mapName = (Map.Entry) iteratorName.next();
                                        if (mapName.getKey().toString().equalsIgnoreCase("name")) {
                                            String existingAgency = mapName.getValue().toString();
                                            results.add(existingAgency);
                                            if (!existingAgency.equalsIgnoreCase(agen.getName())) {
                                                Agency updateAgency = service.getAgencyByName(existingAgency);
                                                updateAgency.setAgencyType("Agency");
                                                updateAgency.setMarket(null);
                                              //  updateAgency.setStorageId(DataContext.getInstance().getRandomStorage());
                                                updateAgency.setDestinationId(null);
                                                updateAgency.setHouseNumberSuffix(null);
                                                try {
                                                    if (updateAgency.getLabels()!= null) {
                                                        List<String> labelsList = Arrays.asList(updateAgency.getLabels());
                                                        List<String> actualLabelsList = new ArrayList<String>(labelsList);
                                                        actualLabelsList.add("QA");
                                                        String[] tempArray = new String[actualLabelsList.size()];
                                                        updateAgency.setLabels(actualLabelsList.toArray(tempArray));
                                                    } else if (updateAgency.getLabels()== null) {
                                                        updateAgency.setLabels(new String[]{"QA"});
                                                    }
                                                }catch(Exception e){
                                                    e.getMessage();
                                                }
                                                service.updateAgency(updateAgency);
                                                Common.sleep(2000);
                                            }
                                        }
                                    }

                                }

                            }
                        }

                    }
                }
            }
        }

        catch(Exception e){
            e.printStackTrace();

        }
    }

    private boolean isExistingBroadcasterChanged(Agency existingAgency,Agency newAgency){
        if(!isBroadcaster(existingAgency) && newAgency.getAgencyType().equals("TV Broadcaster") || ((existingAgency.getDestinationId()==null || existingAgency.getDestinationId().intValue()!=newAgency.getDestinationId().intValue()) && (newAgency.getDestinationId()!=null)))
            return true;
        else
            return false;
    }

    private Agency getAgencyByNameWithInterval(String agencyName, int timeout){
        Agency agency = null;
        int maxAgencyTimeout = timeout;
        while(!(maxAgencyTimeout==0))
        {
            agency = service.getAgencyByName(agencyName);
            if(!(agency==null))
                break;
            else {
                Common.sleep(2000);
                maxAgencyTimeout = maxAgencyTimeout - 2;
            }
        }
        return agency;
    }

    private Agency prepareIngestBU(Agency predefinedAgency){
        String ingestAgencyName=predefinedAgency.getName();
        predefinedAgency.setName(ingestAgencyName);
        return getAgencyByNameWithInterval(ingestAgencyName, 120);
    }

    private Agency createAgency(Agency predefinedAgency) {
        String message = String.format("Check agency '%s': ", predefinedAgency.getName());
        Agency agency=null;

        if (isBroadcaster(predefinedAgency)) {
            updateAllBroadcastersWithDestination(predefinedAgency);
            agency = getAgencyByNameWithInterval(predefinedAgency.getName(), 120);
        }
        else if(isIngestBU(predefinedAgency))
            agency = prepareIngestBU(predefinedAgency);
        else
            agency = service.getAgencyByName(predefinedAgency.getName());

        if (agency != null) {
            if(isExistingBroadcasterChanged(agency,predefinedAgency)){
                agency.setAgencyType("TV Broadcaster");
                agency.setDestinationId(Integer.valueOf(predefinedAgency.getDestinationId()));
                agency.setMarket(predefinedAgency.getMarket());
                //agency.setStorageId(DataContext.getInstance().getRandomStorage());
                try {
                    if (agency.getLabels()!= null) {
                        List<String> labelsList = Arrays.asList(agency.getLabels());
                        List<String> actualLabelsList = new ArrayList<String>(labelsList);
                        actualLabelsList.add("QA");
                        String[] tempArray = new String[actualLabelsList.size()];
                        agency.setLabels(actualLabelsList.toArray(tempArray));
                    } else if (agency.getLabels() == null) {
                        agency.setLabels(new String[]{"QA"});
                    }
                }catch(Exception e){
                    e.getMessage();
                }
                service.updateAgency(agency);
            }
            log.append(message).append("OK\r\n");
        } else {
            log.append(message).append("CREATE NEW\r\n");
            if (predefinedAgency.getStorageId() == null) {
                String storageId = DataContext.getInstance().getRandomStorage();
                if (storageId.isEmpty()) {
                    storageId = service.getRandomFileStorage().getFileStorageId();
                }
                predefinedAgency.setStorageId(storageId);
                predefinedAgency.setSapId(OrderingSettings.DUMMY_SAP_ID);
                predefinedAgency.setSapCountry("GB");
                predefinedAgency.enableSAP(true);
                predefinedAgency.setNVergeAllowed(true);
            }
            try {
                if (predefinedAgency.getLabels()!= null) {
                    List<String> labelsList = Arrays.asList(predefinedAgency.getLabels());
                    List<String> actualLabelsList = new ArrayList<String>(labelsList);
                    actualLabelsList.add("QA");
                    String[] tempArray = new String[actualLabelsList.size()];
                    predefinedAgency.setLabels(actualLabelsList.toArray(tempArray));
                } else if (predefinedAgency.getLabels()== null) {
                    predefinedAgency.setLabels(new String[]{"QA"});
                }
            }catch(Exception e){
                e.getMessage();
            }
            markA4CustomMetadataFields(predefinedAgency);
            agency = service.createAgency(predefinedAgency);
        }
        return agency;
    }

    private void markA4CustomMetadataFields(Agency agency) {
        agency.setA4AdvertiserField(CustomMetadataField.ADVERTISER.getPath());
        agency.setA4ProductField(CustomMetadataField.PRODUCT.getPath());
        agency.setA4CampaignField(CustomMetadataField.CAMPAIGN.getPath());
    }
}