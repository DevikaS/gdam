package com.adstream.automate.babylon;

import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.babylon.tests.steps.GlobalAdminUserSteps;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.babylon.tests.steps.core.SpecDbSteps;
import com.adstream.automate.babylon.tests.steps.domain.*;
import com.adstream.automate.babylon.tests.steps.domain.NewLibrary.*;
import com.adstream.automate.babylon.tests.steps.domain.NewLibrary.CollectionPageSteps;
import com.adstream.automate.babylon.tests.steps.domain.adcost.*;
import com.adstream.automate.babylon.tests.steps.domain.ingest.GdnIngestSteps;
import com.adstream.automate.babylon.tests.steps.domain.mediamanager.*;
import com.adstream.automate.babylon.tests.steps.domain.oneDelivery.*;
import com.adstream.automate.babylon.tests.steps.domain.ordering.*;
import com.adstream.automate.babylon.tests.steps.domain.ordering.section.*;

import com.adstream.automate.babylon.tests.steps.domain.traffic.*;
import com.adstream.automate.babylon.tests.steps.utils.*;
import com.adstream.automate.babylon.tests.steps.utils.heartbeat.HeartbeatListener;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.jbehave.*;
import com.adstream.automate.teamcity.TeamCityIntegration;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.IO;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.http.client.methods.HttpGet;
import org.apache.log4j.Logger;
import org.jbehave.core.ConfigurableEmbedder;
import org.jbehave.core.configuration.Configuration;
import org.jbehave.core.configuration.MostUsefulConfiguration;
import org.jbehave.core.embedder.Embedder;
import org.jbehave.core.embedder.StoryControls;
import org.jbehave.core.failures.PassingUponPendingStep;
import org.jbehave.core.i18n.LocalizedKeywords;
import org.jbehave.core.io.LoadFromRelativeFile;
import org.jbehave.core.io.StoryLoader;
import org.jbehave.core.model.Lifecycle;
import org.jbehave.core.model.Scenario;
import org.jbehave.core.model.Story;
import org.jbehave.core.parsers.RegexPrefixCapturingPatternParser;
import org.jbehave.core.parsers.RegexStoryParser;
import org.jbehave.core.reporters.CrossReference;
import org.jbehave.core.reporters.FreemarkerViewGenerator;
import org.jbehave.core.reporters.StoryReporterBuilder;
import org.jbehave.core.steps.*;
import org.joda.time.format.DateTimeFormat;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

import static com.adstream.automate.jbehave.FailedTestsReporter.FAILED_TEST_REPORTER;
import static com.adstream.automate.jbehave.TeamCityReporter.TEAMCITY;
import static java.util.Arrays.asList;
import static org.jbehave.core.io.CodeLocations.codeLocationFromClass;
import static org.jbehave.core.reporters.Format.*;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 09.02.12
 * Time: 14:31
 */
public class BabylonEmbedder extends ConfigurableEmbedder {
    private final static Logger log = Logger.getLogger(BabylonEmbedder.class);
    private static File configFile;
    private Map<Lifecycle,Set<Scenario>> failed= new HashMap<Lifecycle,Set<Scenario>>();
    private Map<Lifecycle,Set<Scenario>> executed= new HashMap<Lifecycle,Set<Scenario>>();
    private Map<String,Set<Scenario>> executedStories = new HashMap<String,Set<Scenario>>();
    private List<String> executedFileNames= new ArrayList();
    private Map<Lifecycle,Set<Scenario>> skipped= new HashMap<Lifecycle,Set<Scenario>>();
    private final String lineSeparator=System.getProperty("line.separator");
    private final String lifeCycle = "Lifecycle:";
    private final String before = "Before:";
    private final String Scenario = "Scenario: ";
    private final String Meta = "Meta: ";
    private final String Examples = "Examples:";
    private static List<String> listOfResolvedDesiredStories = new ArrayList<>();
    public BabylonEmbedder(String[] args) {
        if (args.length > 0) { //todo parse args
            configFile = new File(args[0]);
            log.info("Trying to load non default config " + configFile.getAbsolutePath());
            TestsContext.getInstance().loadConfig(configFile);
        }
        log.info("Start babylon embedder with args: " + TestsContext.getInstance().toString());
    }

    public BabylonEmbedder() {
    }

    static ThreadLocal<StoryContext> storyContext = new ThreadLocal<>();

    @Override
    public Configuration configuration() {
        new File("Tests/target/jbehave/allure");
        System.setProperty("allure.results.directory", "Tests/target/jbehave/allure");
        CrossReference crossReference = new CrossReference();
        crossReference.withThreadSafeDelegateFormat(new StoryContextOutput(storyContext));

        StoryReporterBuilder reporterBuilder = new StoryReporterBuilder()
                .withCodeLocation(codeLocationFromClass(this.getClass()))
                .withMultiThreading(true)
                .withFailureTrace(true)
                .withFailureTraceCompression(false)
                .withDefaultFormats()
                .withFormats(TeamCityIntegration.isTeamcityRun() ? TEAMCITY : CONSOLE, HTML_TEMPLATE, XML_TEMPLATE)
                .withFormats(FAILED_TEST_REPORTER)
                .withCrossReference(crossReference);

        StoryReporterBuilder reporterBuilderForAllure = new StoryReporterBuilder()
                .withCodeLocation(codeLocationFromClass(this.getClass()))
                .withMultiThreading(true)
                .withFailureTrace(true)
                .withFailureTraceCompression(false)
                .withDefaultFormats()
                .withFormats(FAILED_TEST_REPORTER)
                .withFormats(CONSOLE, HTML_TEMPLATE, XML_TEMPLATE)
                .withCrossReference(crossReference)
                .withReporters(new JenkinsAllureReporter());

        Configuration jBehaveConfiguration = new MostUsefulConfiguration();
        jBehaveConfiguration
                .useStoryControls(new StoryControls().doDryRun(false).doSkipScenariosAfterFailure(false).doResetStateBeforeStory(true))
                .useFailureStrategy(new PassingUponPendingStep())
                .useKeywords(new LocalizedKeywords())   //def
                .useStoryParser(new RegexStoryParser())
                .usePendingStepStrategy(new PassingUponPendingStep())
                .useStepCollector(new MarkUnmatchedStepsAsPending(new StepFinder(new StepFinder.ByPriorityField())))
                        //.useStepMonitor(new StoryContextMonitor(new SilentStepMonitor(), storyContext))
                .useViewGenerator(new FreemarkerViewGenerator())
                //change the step below to make allure report work. ensure its setup in jenkins before this - .useStoryReporterBuilder(reporterBuilderForAllure)
                .useStoryReporterBuilder(reporterBuilder)
                .useStoryLoader(getLocalStoryLoader())
                .useParameterControls(new ParameterControls().useDelimiterNamedParameters(true))
                .useParameterConverters(new ParameterConverters().addConverters(customConverters()))
                .useStepPatternParser(new RegexPrefixCapturingPatternParser());

        return jBehaveConfiguration;
    }

    private StoryLoader getLocalStoryLoader() {
        return getLocalStoryLoader(getStoriesFolder());
    }

    private StoryLoader getLocalStoryLoader(String relativePath) {
        try {
            return new LoadFromRelativeFile(new URL("file://" + relativePath.replace(" ", "%20")));
        } catch (MalformedURLException e) {
            throw new IllegalArgumentException("wrong path", e);
        }
    }

    @Override
    public InjectableStepsFactory stepsFactory() {
        return new InstanceStepsFactory(configuration(), ArrayUtils.addAll(storySteps(), beforeAfterSteps()));
    }

    public static Object[] storySteps() {
        return new Object[]{
                new GenericSteps(),
                new BabylonSteps(),
                new LoginSteps(),
                new RegistrationSteps(),
                new RefreshPasswordSteps(),
                new ImpersonateSteps(),
                new WorkRequestTemplateSteps(),
                new WorkRequestTemplateFolderSteps(),
                new WorkRequestTemplateTeamsSteps(),
                new WorkRequestSteps(),
                new WorkRequestTeamsSteps(),
                new WorkRequestFolderSteps(),
                new WorkRequestFileViewSteps(),
                new ProjectSteps(),
                new ProjectListSteps(),
                new UserSteps(),
                new UserStepsWithinGlobalAdmin(),
                new TermsAndConditionsSteps(),
                new UserGroupSteps(),
                new TemplatesSteps(),
                new TemplateListSteps(),
                new ProjectFolderSteps(),
                new ProjectFileViewSteps(),
                new ProjectFileActivitySteps(),
                new ProjectFolderTrashSteps(),
                new TemplateFolderSteps(),
                new TemplateFileViewSteps(),
                new TemplateFolderTrashSteps(),
                new DashboardSteps(),
                new RolesSteps(),
                new GlobalAdminMailTemplatesSteps(),
                new GlobalAdminUserSteps(),
                new GlobalAdminUsersSteps(),
                new MetadataSteps(),
                new ViewAssetManagementSteps(),
                new RelatedFilesManagementSteps(),
                new WaterMarkingManagementSteps(),
                new MetadataMappingSteps(),
                new ApprovalTemplatesSteps(),
                new AddressBookSteps(),
                new ProjectTeamsSteps(),
                new MyProfileSteps(),
                new AgencySteps(),
                new AgencyOverviewSteps(),
                new AnnotationSteps(),
                new AgencyPartnersSteps(),
                new AgencySecuritySteps(),
                new TemplateTeamsSteps(),
                new NotificationSteps(),
                new LibrarySteps(),
                new LibraryTrashSteps(),
                new LibraryTrashAssetsInfoSteps(),
                new CategoriesSteps(),
                new DownloadFileSteps(),
                new ProjectSearchResultSteps(),
                new ProjectFileCommentsSteps(),
                new LibraryPresentationsAssetsSteps(),
                new LibraryPresentationsActivitySteps(),
                new GlobalSearchSteps(),
                new ProjectFileUsageRightsSteps(),
                new TemplateFileUsageRightsSteps(),
                new LibraryPresentationsSettingsSteps(),
                new PresentationPreviewSteps(),
                new LibraryAssetsViewSteps(),
                new LibraryAssetsActivitySteps(),
                new LibraryAssetsUsageRightsSteps(),
                new LibraryAllPresentationsSteps(),
                new LibraryPresentationsLayoutSteps(),
                new LibraryPresentationsBrandingSteps(),
                new EmailSteps(),
                new SystemBrandingSteps(),
                new FileAndFoldersSearchResultsSteps(),
                new ProjectFileVersionHistorySteps(),
                new LibrarySearchSteps(),
                new PLUploaderSteps(),
                new ProjectFileApprovalsSteps(),
                new ProjectFileFramesSteps(),
                new ProjectApprovalsSteps(),
                new DeliverySettingSteps(),
                new ViewOrderSteps(),
                new DraftOrderSteps(),
                new CommonInformationSteps(),
                new AddMediaSteps(),
                new AddInformationSteps(),
                new AdditionalInformationSteps(),
                new UsageRightSteps(),
                new BroadcastDestinationsSteps(),
                new AdditionalServicesSteps(),
                new DraftOrderProceedSteps(),
                new LiveOrderSteps(),
                new BeamTvStatusSteps(),
                new BillingServiceSteps(),
                new BillingRulesSteps(),
                new FailedOrderSteps(),
                new AdCodeSteps(),
                new CommonOrderingMetadataSteps(),
                new CommonTrafficMetadataSteps(),
                new UserDeliverySteps(),
                new XmppSteps(),
                new AdminLoginPageSteps(),
                new PublicPageSteps(),
                new AssetPreviewPageSteps(),
                new FilePreviewPageSteps(),
                new SharedCollectionsSteps(),
                new GlobalAdminPasswordsSteps(),
                new GlobalAdminSearchAgencySteps(),
                new GlobalAdminSearchUsersSteps(),
                new ProjectFileAttachmentsSteps(),
                new AdbankProjectFileRelatedFilesSteps(),
                new AdbankLibraryAssetsDestinationSteps(),
                new AdbankLibraryRelatedAssetsSteps(),
                new AdbankLibraryRelatedProjectsSteps(),
                new AdbankLibraryAttachmentsSteps(),
                new WorkRequestTemplateListSteps(),
                new WorkRequestListSteps(),
                new SpecDbSteps(),
                new WorkRequestFileActivitySteps(),
                new GDAMChecklistSteps(),
                new TrafficOrderListSteps(),
                new TrafficNewTabSteps(),
                new TrafficOrderItemsListSteps(),
                new TrafficOrderEditSteps(),
                new TrafficOrderSummarySteps(),
                new TrafficMasterArrivedPopUpSteps(),
                new GdnIngestSteps(),
                new AgencyMarketPageSteps(),
                new SuperHubMembersPageSteps(),
                new AgencyGlobalAccessRulesPageSteps(),
                new HolidaysSteps(),
                new TrafficOrderItemDetailsPageSteps(),
                new TrafficApprovalPopUpSteps(),
                new TrafficOrderPageSteps(),
                new TrafficAPISteps(),
                new AdCostsOverviewSteps(),
                new AdCostsAdminUserOverrideSteps(),
                new AdCostsDetailsSteps(),
                new AdCostsProductionDetailsSteps(),
                new AdCostsExpectedAssetsSteps(),
                new AdCostsItemsSteps(),
                new AdCostsSupportingDocumentsSteps(),
                new AdCostsApprovalsSteps(),
                new AdCostsUsageBuyoutDetailsSteps(),
                new AdCostsNegotiatedTermsSteps(),
                new AdCostsReviewSteps(),
                new AMQMockService(),
                new AdCostsVendorSteps(),
                new AdCostsAdminUserAccessSteps(),
                new AdCostsAssociatedAssetsSteps(),
                new AdCostsCurrencySteps(),
                new AdCostsDictionarySteps(),
                new NewLibrarySteps(),
                new NewLibraryAssetsViewSteps(),
                new LibCollectionPopupSteps(),
                new LibShareFilesPopupSteps(),
                new LibDownLoadPopupSteps(),
                new CollectionDetailsPageSteps(),
                new LibWorkRequestPopupSteps(),
                new CollectionPageSteps(),
                new LibChangeMediaPopupSteps(),
                new LibRemovePopupSteps(),
                new CollectionDataPageSteps(),
                new LibAddToCollectionPopupSteps(),
                new LibRemoveFromCollectionPopupSteps(),
                new NewAdbankLibraryAttachmentsSteps(),
                new LibDeleteAssetsAttachmentPopUpSteps(),
                new NewAdbankLibraryAssetsActivitySteps(),
                new NewAdbankLibrarySharedCollectionSteps(),
                new NewAdbankLibraryAssetsDestinationSteps(),
                new NewAdbankLibraryAddAssetToPresentationSteps(),
                new NewLibraryAssetsUsageRightsSteps(),
                new NewLibraryAddAssetToProjectSteps(),
                new NewAssetPreviewPageSteps(),
                new NewLibraryTrashSteps(),
                new NewLibraryGlobalSearchSteps(),
                new NewLibraryGlobalSearchResultsSteps(),
                new LibSingleEditAssetMetadataPageSteps(),
                new NewAdbankLibraryAssetsProjectRelatedSteps(),
                new LibMultiEditAssetMetadataPageSteps(),
                new LibImpersonatePopupSteps(),
                new LibMultiEditAssetMetadataPageSteps(),
                new LibRemoveCollectionPopupSteps(),
                new NewAssetPreviewPageSteps(),
                new MediaManagerLoginSteps(),
                new MediaUploadSteps(),
                new MediaManagerFileInfoSteps(),
                new MediaCheckerSteps(),
                new MediaManagerFileInfoSteps() ,
                new MediaManagerHistorySteps(),
                new OneDeliveryBaseSteps(),
                new OneDeliveryNewOrderSteps(),
                new OneDeliveryOrderItemSteps(),
                new OneDeliveryOrderBillingSteps(),
                new OneDeliveryOrderCompleteSteps()
        };
    }

    public Object[] beforeAfterSteps() {
        return new Object[]{
                new StopBrowserAfterStory(storyContext),
                new LoginBeforeEachScenario(storyContext),
                new GenerateTestDataBeforeStories(configFile),
                new TakeScreenshotOnFailure(
                        configuration().storyReporterBuilder().outputDirectory(),
                        storyContext),
                new BeforeAfterStoriesActions(storyContext),
                new TimeTracker(storyContext),
                new HeartbeatListener(storyContext)
        };
    }

    private ParameterConverters.ParameterConverter[] customConverters() {
        List<ParameterConverters.ParameterConverter> converters = new ArrayList<>();
        converters.add(
                new CustomParameterConverters.JodaDateConverter(
                        DateTimeFormat.forPattern(TestsContext.getInstance().storiesDateTimeFormat))
        );
        converters.add(new CustomParameterConverters.JsonObjectConverter());
        return converters.toArray(new ParameterConverters.ParameterConverter[converters.size()]);
    }


    public static String getStoriesFolder() {
        String STORIESPATH = TestsContext.getInstance().storiesPath;
        return System.getProperty("user.dir") + "/" + STORIESPATH;
    }

    public List<String> storyPaths() {
        listOfResolvedDesiredStories.clear();
        List<String> listOfDesiredStories = asList(TestsContext.getInstance().storiesList);
        String storyFilterRaw = System.getProperty("tests.story_filter","").trim();
        if (!storyFilterRaw.isEmpty()) {
            log.info("Gor story filter " + storyFilterRaw);
            List<String> listOfStoryFilter = asList(storyFilterRaw.split(";"));
            for (String storyFilter: listOfStoryFilter){
                for (String desiredStory : listOfDesiredStories) {
                    if (desiredStory.matches(storyFilter) && !listOfResolvedDesiredStories.contains(desiredStory + ".story")) {
                        listOfResolvedDesiredStories.add(desiredStory + ".story");
                    }
                }
            }
        } else {
            for (String desiredStory : listOfDesiredStories) {
                listOfResolvedDesiredStories.add(desiredStory + ".story");
            }
        }
        log.info("List of result stories" + ArrayUtils.toString(listOfResolvedDesiredStories));
        return listOfResolvedDesiredStories;
    }

    public static  List<String> getlistOfResolvedDesiredStories() {
        return listOfResolvedDesiredStories;
    }

    protected List<String> metaFilters() {
        return asList(TestsContext.getInstance().storiesMeta);
    }

    public void run() throws Throwable {
        TestsContext.getInstance().threads = getConfiguredThreadsCount(TestsContext.getInstance());
        Embedder embedder = configuredEmbedder();
        embedder.useMetaFilters(metaFilters());
        embedder.embedderControls().doIgnoreFailureInStories(true);
        embedder.embedderControls().doGenerateViewAfterStories(false);
        embedder.embedderControls().useThreads(TestsContext.getInstance().threads);
        embedder.embedderControls().useStoryTimeoutInSecs(24 * 60 * 60); //24h

        try {
            getBuildVersions();
            log.info("First Run Begins at: "+new Date().toString());
            embedder.runStoriesAsPaths(storyPaths());
            if (TestsContext.getInstance().enableTestExecutionFile) {
                prepareExecutedScenarioFile(FailedTestsReporter.getexecutedTests());
                prepareCompleteFile(executed, executedStories, executedFileNames, TestsContext.getInstance().executed_scenario_list_path);
            }
            executedTestsCount();
            log.info("First Run Completed: "+new Date().toString());
            if (TestsContext.getInstance().isUnicDataSet && TestsContext.getInstance().testsRunAgainOnFail) {
                log.info("Second run Begins at: "+new Date().toString());
               // terminategridsessions();
                TestsContext.getInstance().isSecondRun = true;
                DataContext.getInstance().sessionId = null;
                log.info("sessionId: " + DataContext.getInstance().sessionId);
                Map<String, List<String>> storiesWithfailedAndSkippedScenarios=FailedTestsReporter.getFailedTests();
                System.out.println("Failed Tests:"+FailedTestsReporter.getFailedTests().size());
                storiesWithfailedAndSkippedScenarios.putAll(FailedTestsReporter.getSkippedTests());
                System.out.println("Skipped Tests:" + FailedTestsReporter.getSkippedTests().size());
                prepareFailedTests(storiesWithfailedAndSkippedScenarios);
                FailedTestsReporter.getFailedTests().clear();
                FailedTestsReporter.getSkippedTests().clear();
                embedder.configuration().useStoryLoader(getLocalStoryLoader(TestsContext.getInstance().storiesPath));
                embedder.runStoriesAsPaths(storyPaths());
            }
        } finally {
            try {
                prepareFailedScenarioFile(FailedTestsReporter.getFailedTests());
                prepareSkippedScenarioFile(FailedTestsReporter.getSkippedTests());
            } catch (IOException e) {
                e.printStackTrace();
            }
            embedder.generateCrossReference();
            if(TestsContext.getInstance().testsGenerateLocalReports != null && TestsContext.getInstance().testsGenerateLocalReports ) {
               embedder.generateReportsView();
            }
            prepareFile(failed,TestsContext.getInstance().failed_scenario_list_path);
            prepareFile(skipped,TestsContext.getInstance().skipped_scenario_list_path);
         }
    }

    private void terminategridsessions() throws MalformedURLException {
        String webDriverGridRemoteUrl = System.getProperty("webDriverGridRemoteUrl");
        URL url = new URL(webDriverGridRemoteUrl);
        final String sessionURL = "http://" + url.getHost() + ":" + url.getPort() + "/grid/admin/TerminateAllSlots";
        new BabylonMessageSender(new URL(webDriverGridRemoteUrl))
        {
            public void terminate() {

                sendRequest(new HttpGet(sessionURL));
                            }

        }.terminate();

    }

    private void getBuildVersions(){
        BabylonServiceWrapper currentCoreApi = new BabylonServiceWrapper(new BabylonCoreService(TestsContext.getInstance().coreUrl[0]), null);
        log.info("Target core version " + currentCoreApi.getVersion());
        BabylonMiddlewareService service = new BabylonMiddlewareService(TestsContext.getInstance().applicationUrl);
        log.info("Target new library middle tier version " + service.getNewLibraryMiddleTierVersion());
        log.info("Target new library webapp version " + service.getNewLibraryWebappVersion());
        log.info("Target MiddleTier version " + service.getVersion());
        PaperPusherCoreService currentPpApi = new PaperPusherCoreService(TestsContext.getInstance().paperPusherUrl);
        log.info("Target Paper pusher version " + currentPpApi.getVersion());
        TrafficCoreService currentDsApi =  new TrafficCoreService(TestsContext.getInstance().deliveryServerUrl);
        log.info("Target Delivery Server version " + currentDsApi.getVersion());
        TrafficFrontService trafficFrontVer =  new TrafficFrontService(TestsContext.getInstance().applicationUrl);
        log.info("Target Traffic Front version " + trafficFrontVer.getVersion());
        TrafficCoreService currentMsApi =  new TrafficCoreService(TestsContext.getInstance().mailServiceApiUrl);
        log.info("Target Mail Server version " + currentMsApi.getApiVersion());
        if(TestsContext.getInstance().isAdcost.equalsIgnoreCase("true")) {
            AdcostCoreService adcostCoreService = new AdcostCoreService(TestsContext.getInstance().adcostCore);
            log.info("Target Adcost Core version " + adcostCoreService.getVersion());
            log.info("Target Adcost Branch version " + adcostCoreService.getBranch());
            log.info("Target Adcost DB Table version " + adcostCoreService.getDatabaseTable());
            log.info("Target Adcost Nginx/FE version " + adcostCoreService.getNginxVersion());
            log.info("Target Adcost MiddleTier version " + adcostCoreService.getMiddleTierVersion());
        }
        if(TestsContext.getInstance().isMediaManager.equalsIgnoreCase("true")) {
            MediaManagerCoreService mmCoreService = new MediaManagerCoreService(TestsContext.getInstance().mediamanager_core_url);
            log.info("Target Media Manager Core version  " + mmCoreService.getVersion());
            log.info("Target Media Manager Branch version " + mmCoreService.getBranch());
        }
    }

    private StringBuilder prepareNarrative(){
        return new StringBuilder().append("Feature:")
                .append(lineSeparator)
                .append("Narrative:")
                .append(lineSeparator)
                .append("In order to").append(lineSeparator)
                .append("As a\t AgencyAdmin")
                .append(lineSeparator).append("I want to Check functionality").append(lineSeparator).append(lineSeparator);
    }

    public void prepareCompleteFile(Map<Lifecycle,Set<Scenario>> list,Map<String,Set<Scenario>> executedStories,List<String> executedFileNames,String fileName) {
        StringBuilder sbExecutedScenario= new StringBuilder();
        int l=0;
        File f ;
        try {
            f = new File(configuration().storyReporterBuilder().outputDirectory() + "//view//" + fileName + "_" + new SimpleDateFormat("dd-MM-yyyy").format(new Date()).replace("-", "") + ".txt");
            if (!f.getParentFile().exists()) {
                f.getParentFile().mkdirs();
            }
            if (!f.exists()) {
                f.createNewFile();
            }
                    for (Map.Entry<Lifecycle, Set<Scenario>> sc : list.entrySet()) {
                        sbExecutedScenario.append("Story name:").append(executedFileNames.get(l)).append(lineSeparator);
                        //sbExecutedScenario.append(prepareNarrative());
                        if (!sc.getKey().getBeforeSteps().isEmpty()) {
                            sbExecutedScenario.append(lifeCycle).append(lineSeparator);
                            sbExecutedScenario.append(before).append(lineSeparator);
                            for (String data : sc.getKey().getBeforeSteps())
                                sbExecutedScenario.append(data).append(lineSeparator);
                            sbExecutedScenario.append(lineSeparator);
                            for (Scenario scValue : sc.getValue()) {
                                sbExecutedScenario.append(Scenario).append(scValue.getTitle()).append(lineSeparator);
                                if (!scValue.getMeta().getPropertyNames().isEmpty())
                                    sbExecutedScenario.append(Meta);
                                for (String meta : scValue.getMeta().getPropertyNames()) {
                                    sbExecutedScenario.append("@" + meta).append(lineSeparator);
                                }
                                for (String step : scValue.getSteps())
                                    sbExecutedScenario.append(step).append(lineSeparator);
                                sbExecutedScenario.append(lineSeparator).append(lineSeparator);
                                if (!scValue.getExamplesTable().getRows().isEmpty()) {
                                    List<String> headers = scValue.getExamplesTable().getHeaders();
                                    sbExecutedScenario.append(Examples).append(lineSeparator);
                                    int headerLength = scValue.getExamplesTable().getHeaders().size();
                                    sbExecutedScenario.append("|");
                                    for (String exHead : scValue.getExamplesTable().getHeaders())
                                        sbExecutedScenario.append(exHead).append("\t|");
                                    sbExecutedScenario.append(lineSeparator);
                                    for (int i = 0; i < scValue.getExamplesTable().getRowCount(); i++) {
                                        sbExecutedScenario.append("|");
                                        for (int j = 0; j < headerLength; j++)
                                            sbExecutedScenario.append(scValue.getExamplesTable().getRow(i).get(headers.get(j))).append("\t|");
                                        sbExecutedScenario.append(lineSeparator);

                                    }
                                    sbExecutedScenario.append(lineSeparator);
                                }
                            }

                        }
                        l=l+1;
                        sbExecutedScenario.append("------------------------------------------------------------------------------------------------------------------------------");
                        sbExecutedScenario.append(lineSeparator);
                    }


            for (Map.Entry<String, Set<Scenario>> story : executedStories.entrySet()) {
                sbExecutedScenario.append("Story name:").append(story.getKey()).append(lineSeparator);
              //  sbExecutedScenario.append(prepareNarrative());
                if(story.getValue()!=null) {
                    for (Scenario scen : story.getValue()) {
                        sbExecutedScenario.append(Scenario).append(scen.getTitle()).append(lineSeparator);
                        if (scen.getMeta().getPropertyNames().isEmpty())
                            sbExecutedScenario.append(Meta);
                        for (String meta : scen.getMeta().getPropertyNames()) {
                            sbExecutedScenario.append("@" + meta).append(lineSeparator);
                        }
                        for (String step : scen.getSteps())
                            sbExecutedScenario.append(step).append(lineSeparator);
                        sbExecutedScenario.append(lineSeparator).append(lineSeparator);
                        if (!scen.getExamplesTable().getRows().isEmpty()) {
                            List<String> headers = scen.getExamplesTable().getHeaders();
                            sbExecutedScenario.append(Examples).append(lineSeparator);
                            int headerLength = scen.getExamplesTable().getHeaders().size();
                            sbExecutedScenario.append("|");
                            for (String exHead : scen.getExamplesTable().getHeaders())
                                sbExecutedScenario.append(exHead).append("\t|");
                            sbExecutedScenario.append(lineSeparator);
                            for (int i = 0; i < scen.getExamplesTable().getRowCount(); i++) {
                                sbExecutedScenario.append("|");
                                for (int j = 0; j < headerLength; j++)
                                    sbExecutedScenario.append(scen.getExamplesTable().getRow(i).get(headers.get(j))).append("\t|");
                                sbExecutedScenario.append(lineSeparator);

                            }
                            sbExecutedScenario.append(lineSeparator);
                        }
                    }
                }
                sbExecutedScenario.append("------------------------------------------------------------------------------------------------------------------------------");
                sbExecutedScenario.append(lineSeparator);
                    }
            IO.saveTextFile(f, sbExecutedScenario.toString());
        } catch(Exception ff){
            log.info("Exception while creating file");
            ff.printStackTrace();
        }
    }

    public void prepareFile(Map<Lifecycle,Set<Scenario>> list,String fileName) {
        int COUNT=1;
        int failedTestsCount=0;
        int sheetNumber=0;
        File f;

        StringBuilder sbFailedScenario=null;
        try {
              for (Map.Entry<Lifecycle,Set<Scenario>> sc : list.entrySet()) {

                  if(!sc.getKey().getBeforeSteps().isEmpty())
                    f=new File(configuration().storyReporterBuilder().outputDirectory()+"//view//"+"LifeCycle_" + fileName+"_"+new SimpleDateFormat("dd-MM-yyyy").format(new Date()).replace("-","") + "_" + COUNT++ +".txt");
                  else {
                       f = new File(configuration().storyReporterBuilder().outputDirectory() + "//view//" + fileName + sheetNumber + "_" + new SimpleDateFormat("dd-MM-yyyy").format(new Date()).replace("-", "") + ".txt");
                  }
                      if (!f.getParentFile().exists()) {
                      f.getParentFile().mkdirs();
                   }
                  if (!f.exists()) {
                      f.createNewFile();
                  }
                  sbFailedScenario=prepareNarrative();
                  String metaData = sbFailedScenario.toString();
                  if (!sc.getKey().getBeforeSteps().isEmpty()){
                      sbFailedScenario.append(lifeCycle).append(lineSeparator);
                      sbFailedScenario.append(before).append(lineSeparator);
                      for (String data : sc.getKey().getBeforeSteps())
                         sbFailedScenario.append(data).append(lineSeparator);
                      sbFailedScenario.append(lineSeparator);
                  }

                for(Scenario scValue:sc.getValue()) {
                    sbFailedScenario.append(Scenario).append(scValue.getTitle()).append(lineSeparator);
                    if (!scValue.getMeta().getPropertyNames().isEmpty())
                        sbFailedScenario.append(Meta);
                    for (String meta : scValue.getMeta().getPropertyNames()) {
                        sbFailedScenario.append("@" + meta).append(lineSeparator);
                    }
                    for (String step : scValue.getSteps())
                        sbFailedScenario.append(step).append(lineSeparator);
                    sbFailedScenario.append(lineSeparator).append(lineSeparator);
                    if (!scValue.getExamplesTable().getRows().isEmpty()) {
                        List<String> headers = scValue.getExamplesTable().getHeaders();
                        sbFailedScenario.append(Examples).append(lineSeparator);
                        int headerLength = scValue.getExamplesTable().getHeaders().size();
                        sbFailedScenario.append("|");
                        for (String exHead : scValue.getExamplesTable().getHeaders())
                            sbFailedScenario.append(exHead).append("\t|");
                        sbFailedScenario.append(lineSeparator);
                        for (int i = 0; i < scValue.getExamplesTable().getRowCount(); i++) {
                            sbFailedScenario.append("|");
                            for (int j = 0; j < headerLength; j++)
                                sbFailedScenario.append(scValue.getExamplesTable().getRow(i).get(headers.get(j))).append("\t|");
                            sbFailedScenario.append(lineSeparator);

                        }
                        sbFailedScenario.append(lineSeparator);
                    }
                    if (!f.getName().contains("LifeCycle_")) {
                        failedTestsCount++;
                        if (failedTestsCount == TestsContext.getInstance().failed_scenarios_count_perFile) {
                            sheetNumber = sheetNumber + 1;
                            sbFailedScenario.append(lineSeparator);
                            File newFile = new File(configuration().storyReporterBuilder().outputDirectory() + "//view//" + fileName + sheetNumber + "_" + new SimpleDateFormat("dd-MM-yyyy").format(new Date()).replace("-", "") + ".txt");
                            IO.saveTextFile(newFile, sbFailedScenario.toString());
                            sbFailedScenario.setLength(0);
                            sbFailedScenario.append(metaData);
                            failedTestsCount = 0;
                        }
                    }
                }
                  sbFailedScenario.append(lineSeparator);
                  IO.saveTextFile(f, sbFailedScenario.toString());
                  sbFailedScenario = null;

                  if(failedTestsCount==0 && !f.getName().contains("LifeCycle_")){
                      f.delete();
                  }
                }


         }catch(Exception ff){
            log.info("Exception while creating file");
            ff.printStackTrace();
        }

    }

    private void prepareExecutedScenarioFile(Map<String,List<String>> storyMap) throws IOException{
        Story story;
        File file;
        for(String storyTitle:storyMap.keySet()) {
            file = new File(TestsContext.getInstance().storiesPath + "/" + storyTitle + ".story");
            story = configuration().storyParser().parseStory(IOUtils.toString(new FileReader(file)));
            Lifecycle lifecycle = story.getLifecycle();
            Set<Scenario> executedScenarios = new HashSet<Scenario>();
            for (Scenario parsedScenario : story.getScenarios()) {
                if (storyMap.get(storyTitle).contains(parsedScenario.getTitle())) {
                    executedScenarios.add(parsedScenario);
                }
            }
            if(executed.keySet()!=null & executed.keySet().contains(lifecycle)) {
                executed.get(lifecycle).addAll(executedScenarios);
            }else if(lifecycle.getBeforeSteps().isEmpty()){
                executedStories.put(storyTitle,executedScenarios);
            }else{
                executed.put(lifecycle,executedScenarios);
                executedFileNames.add(storyTitle);
               // executedStories.put(storyTitle,null);
            }
        }
    }

    private void prepareFailedScenarioFile(Map<String,List<String>> storyMap) throws IOException{
        Story story;
        File file;
        for(String storyTitle:storyMap.keySet()) {
            file = new File(TestsContext.getInstance().storiesPath + "/" + storyTitle + ".story");
            story = configuration().storyParser().parseStory(IOUtils.toString(new FileReader(file)));
            Lifecycle lifecycle = story.getLifecycle();
            Set<Scenario> failedScenarios = new HashSet<Scenario>();
            for (Scenario parsedScenario : story.getScenarios()){
                if(storyMap.get(storyTitle).contains(parsedScenario.getTitle())) {
                    failedScenarios.add(parsedScenario);
                 }
            }
               if(failed.keySet()!=null & failed.keySet().contains(lifecycle))
                   failed.get(lifecycle).addAll(failedScenarios);
               else
               failed.put(lifecycle,failedScenarios);

        }
    }

    private void prepareSkippedScenarioFile(Map<String,List<String>> storyMap) throws IOException{
        Story story;File file;
        for(String storyTitle:storyMap.keySet()) {
            file = new File(TestsContext.getInstance().storiesPath + "/" + storyTitle + ".story");
            story = configuration().storyParser().parseStory(IOUtils.toString(new FileReader(file)));
            Lifecycle lifecycle = story.getLifecycle();
            Set<Scenario> failedScenarios = new HashSet<Scenario>();
            for (Scenario parsedScenario : story.getScenarios()){
                if(storyMap.get(storyTitle).contains(parsedScenario.getTitle())) {
                    failedScenarios.add(parsedScenario);
                }
            }
            if(skipped.keySet()!=null & skipped.keySet().contains(lifecycle))
                skipped.get(lifecycle).addAll(failedScenarios);
            else
                skipped.put(lifecycle,failedScenarios);

        }
    }




    private void executedTestsCount(){
        Map<String, List<String>> storiesWithExecutedScenarios = FailedTestsReporter.getexecutedTests();
        Map<String, List<String>> storiesWitfailedScenarios = FailedTestsReporter.getFailedTests();
        Map<String, List<String>> storiesWitScenariosWithPendingSteps = FailedTestsReporter.getSkippedTests();
        int testsexecutedCount = 0;
        int testsfailedCount = 0;
        int testsPendingCount = 0;
        for (Map.Entry<String, List<String>> suit : storiesWithExecutedScenarios.entrySet()) {
            testsexecutedCount += suit.getValue().size();
        }
        for (Map.Entry<String, List<String>> failedsuit : storiesWitfailedScenarios.entrySet()) {
            testsfailedCount += failedsuit.getValue().size();
        }
        for (Map.Entry<String, List<String>> Pendingsuit : storiesWitScenariosWithPendingSteps.entrySet()) {
            testsPendingCount += Pendingsuit.getValue().size();
        }
        log.info(String.format("Found %d pending tests",  testsPendingCount));
        log.info(String.format("Found %d failed tests",  testsfailedCount));
        log.info(String.format("Found %d Executed tests",  testsexecutedCount));
        log.info(String.format("Found %d passed tests",  testsexecutedCount-(testsfailedCount+testsPendingCount)));
    }

    private void prepareFailedTests( Map<String, List<String>> storiesWithfailedScenarios) {
        TeamCityIntegration teamCity = new TeamCityIntegration();
        Map<String, List<String>> runAgainSuits = new HashMap<>();
     //   Map<String, List<String>> storiesWithfailedScenarios = FailedTestsReporter.getFailedTests();
        logFailedTestsCount(storiesWithfailedScenarios);
        //go thru failed tests and remove muted
        for (String failedStory : storiesWithfailedScenarios.keySet()) {
            if (teamCity.isStoryHaveMutesSenarios(failedStory)) {
                for (String failedScenario : storiesWithfailedScenarios.get(failedStory)) {
                    if (!teamCity.isScenarioMuted(failedStory, failedScenario)) {
                        if (!runAgainSuits.containsKey(failedStory)) {
                            runAgainSuits.put(failedStory, new ArrayList<String>());
                        }
                        runAgainSuits.get(failedStory).add(failedScenario);
                    } else {
                        log.info(String.format("filtered as muted story %s, scenario %s", failedStory, failedScenario));
                    }
                }
            } else {
                runAgainSuits.put(failedStory, storiesWithfailedScenarios.get(failedStory));

            }
        }

        File newStoriesFolder = createTempDirectory();
        List<String> newStoriesList = new ArrayList<>();

        /*for (Map.Entry<String, List<String>> entry : runAgainSuits.entrySet()) {
            String storyFileName = entry.getKey() + ".story";
            String storyFileName_R = entry.getKey() + "_Rerun.story";
            File file = new File(TestsContext.getInstance().storiesPath + "/" + storyFileName);
            if (file.exists()) {
                try {
                    String newStory = prepareFailedStory(file, entry.getValue());
                    File newFile = new File(newStoriesFolder, storyFileName_R);
                    IO.saveTextFile(newFile, newStory);
                    newStoriesList.add(entry.getKey()+"_Rerun");
                    log.info("Created new story " + newFile.getCanonicalPath());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                log.error("Could not find story " + storyFileName);
            }
        }*/

        for (Map.Entry<String, List<String>> entry : runAgainSuits.entrySet()) {
            String storyFileName = entry.getKey() + ".story";
            File file = new File(TestsContext.getInstance().storiesPath + "/" + storyFileName);
            if (file.exists()) {
                try {
                    String newStory = prepareFailedStory(file, entry.getValue());
                    File newFile = new File(newStoriesFolder, storyFileName);
                    IO.saveTextFile(newFile, newStory);
                    newStoriesList.add(entry.getKey());
                    log.info("Created new story " + newFile.getCanonicalPath());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                log.error("Could not find story " + storyFileName);
            }
        }


        TestsContext.getInstance().storiesList = newStoriesList.toArray(new String[newStoriesList.size()]);
        try {
            TestsContext.getInstance().storiesPath = newStoriesFolder.getCanonicalPath();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void logFailedTestsCount(Map<String, List<String>> suits) {
        int testsCount = 0;
        for (Map.Entry<String, List<String>> suit : suits.entrySet()) {
            testsCount += suit.getValue().size();
        }
        log.info(String.format("Found %d stories with %d failed tests", suits.size(), testsCount));
    }

    private File createTempDirectory() {
        String newStoriesFolder = Gen.getString(6);
        File file = new File(System.getProperty("java.io.tmpdir"), newStoriesFolder);
        file.mkdir();
        return file;
    }

    //TODO found how to inject story list for second run
    private Story prepareFailedStory2(File file, List<String> failedScenarios) throws IOException {
        String story = IOUtils.toString(new FileReader(file));
        Story parsedStory = configuration().storyParser().parseStory(story);
        List<Scenario> scenarios = new ArrayList<>();
        for (Scenario parsedScenario : parsedStory.getScenarios()) {
            for (String failedScenarioTitle : failedScenarios) {
                if (parsedScenario.getTitle().equals(failedScenarioTitle)) {
                    scenarios.add(parsedScenario);
                    break;
                }
            }
        }
        return new Story(parsedStory.getDescription(), parsedStory.getNarrative(), scenarios);
    }

    private String prepareFailedStory(File file, List<String> failedScenarios) throws IOException {
        String story = IOUtils.toString(new FileReader(file));
        Map<Integer, String> scenariosTitle = getScenariosTitle(story);
        List<Integer> positions = new ArrayList<>(scenariosTitle.keySet());
        Collections.sort(positions, Collections.reverseOrder());
        StringBuilder newStory = new StringBuilder(story);
        for (int i = 0; i < positions.size(); i++) {
            Integer position = positions.get(i);
            String title = scenariosTitle.get(position);
            if (!isTitleInList(title, failedScenarios)) {
                Integer nextScenarioPosition = (i == 0 ? newStory.length() : positions.get(i - 1));
                newStory.delete(position, nextScenarioPosition);
            }
        }
        return newStory.toString();
    }

    private Map<Integer, String> getScenariosTitle(String story) {
        Map<Integer, String> scenarios = new HashMap<>();
        int scenarioStart = 0;
        while ((scenarioStart = story.indexOf("Scenario:", scenarioStart + 1)) != -1) {
            int titleStart = story.indexOf(":", scenarioStart) + 1;
            int titleEnd = story.indexOf("\n", titleStart);
            if (titleEnd == -1) {
                titleEnd = story.length();
            }
            String title = story.substring(titleStart, titleEnd).trim();
            scenarios.put(scenarioStart, title);
        }
        return scenarios;
    }

    private boolean isTitleInList(String title, List<String> list) {
        for (String item : list) {
            if (item.matches(Pattern.quote(title) + "\\d*")) {
                return true;
            }
        }
        return false;
    }

    private int getConfiguredThreadsCount(TestsContext context) throws MalformedURLException {
        String webDriverGridRemoteUrl = System.getProperty("webDriverGridRemoteUrl");
        if (context.threads <= 0 && webDriverGridRemoteUrl != null) {
            ExtendedWebDriver.Browser browser = ExtendedWebDriver.Browser.getByValue(context.browser);
            final String browserName = Common.urlEncode(browser.getBrowserName());
            return new BabylonMessageSender(new URL(webDriverGridRemoteUrl))
            {
                public int getAvailableSlots() {
                    String result = sendRequest(new HttpGet(baseUrl + "grid/admin/SlotFilteringServlet/?browserName=" + browserName));
                    JsonObject obj = new JsonParser().parse(result).getAsJsonObject();
                    return obj.get("passedSlots").getAsInt();
                }
            }.getAvailableSlots();
        }
        return context.threads;
    }

}