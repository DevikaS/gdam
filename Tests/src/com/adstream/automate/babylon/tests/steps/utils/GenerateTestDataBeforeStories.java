package com.adstream.automate.babylon.tests.steps.utils;

import com.adstream.automate.babylon.BabylonEmbedder;
import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.TestDataGenerator;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.teamcity.TeamCityIntegration;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.BeforeStories;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 26.04.12
 * Time: 22:52
 */
public class GenerateTestDataBeforeStories extends BaseStep {
    private final File configFile;
    public GenerateTestDataBeforeStories(File configFile) {
        this.configFile = configFile;
    }

    @BeforeStories
    public void generateDataBeforeStories() {
        log.info("before stories, generate test data, start");
        try {
            File defaultObjectsFile = new File(getContext().testDataFolderName, getContext().testsDefaultObjectsFile);
            File generateListFile = new File(getContext().testDataFolderName, getContext().testsGenerateListFile);
            File generateAdcostListFile = new File(getContext().testDataFolderName, getContext().generateAdcostListFile);
            List<String> storiestlist = BabylonEmbedder.getlistOfResolvedDesiredStories();
            new TestDataGenerator(defaultObjectsFile,
                    generateListFile,
                    configFile,
                    generateAdcostListFile,
                    getContext().threads,
                    getContext().isUnicDataSet,
                    getContext().isOrdering,
                    storiestlist
            ).createDefaultElements();
            addFiles();
        } catch (Exception e) {
            log.error("Something goes wrong due to data generation", e);
        }

        try {
            BabylonServiceWrapper service = new BabylonServiceWrapper(new BabylonCoreService(getContext().coreUrl[0]), null);
            log.info("Target core version " + service.getVersion());
            log.info("Target core branch " + service.getBranch());
            TeamCityIntegration.setBuildTag(service.getBranch());
        } catch (Exception e) {
            log.error("Something goes wrong due to tagging build", e);
        }
        log.info("before stories, generate test data, stop");
    }

     private void addFiles() {
        File file = new File(TestsContext.getInstance().testDataFolderName + "/files/ÄäDocumentÖö.txt");
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                log.error(Common.exceptionToString(e));
            }
        }
    }
}
