package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryItem;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.JsonObjects.projectsaccessrure.*;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;

/**
 * User: lynda-k
 * Date: 12.08.14
 * Time: 12:35
 */
public class CreateProjectsAccessRulesTest extends AbstractPerformanceTestServiceWrapper {
    static final String ADVERTISER_DICTIONARY_NAME = "advertiser";
    static final String ADVERTISER = "Advertiser";
    static final String BRAND = "Brand";
    static final String SUB_BRAND = "Sub brand";
    static final String PRODUCT = "Product";
    static final String AGENCY_USER = "agency.user";
    static final String AGENCY_ADMIN = "agency.admin";
    static final String PROJECT_USER = "project.user";
    static final String ACCESS_RULE_TERM_KEY = "_cm.common.advertiser";

    private User defaultUser;
    private Project defaultProject;
    protected static User adminUser;
    private static List<String> usersIds = new ArrayList<>();
    protected static List<String> advertisers = new ArrayList<>();

    private synchronized void collectUsersIds(String userId) {
        usersIds.add(userId);
    }

    private synchronized void collectAdvertisers(String advertiser) {
        advertisers.add(advertiser);
    }

    @Override
    public void runOnce() {
        logIn(getParam("login"), getParam("password"));
        Agency agency = getService().createAgency(ObjectsFactory.createAgency(getParam("storageId")));
        getService().enableProjectsAccessRulesForAgency(agency.getId(), 20);
        createAdvertiserChains(agency, getParamInt("advertisersCount"), getParamInt("brandsCount"),
                getParamInt("subBrandsCount"), getParamInt("productsCount"));

        adminUser = createAdminUser(agency);
        logIn(adminUser.getEmail(), getParam("password"));
        createUsers(agency, getParamInt("usersCount"));
        createProjects(getParamInt("projectsCount"));
    }

    @Override
    public void beforeStart() {
        logIn(adminUser.getEmail(), getParam("password"));
    }

    @Override
    public void start() {
        getService().createProjectsAccessRule(generateProjectsAccessRule());
    }

    @Override
    public void afterRun() {

    }

    protected ProjectsAccessRule generateProjectsAccessRule() {
        ProjectsAccessRule projectsAccessRule = new ProjectsAccessRule();
        List<ProjectsAccessRuleTerm> projectsAccessRuleTerms = new ArrayList<>();
        String projectsAccessRuleTermKey = ACCESS_RULE_TERM_KEY;
        List<String> projectsAccessRuleTermValue = new ArrayList<>();

        projectsAccessRuleTermValue.add(advertisers.get(Gen.getInt(advertisers.size())));
        projectsAccessRuleTerms.add(new ProjectsAccessRuleTerm(projectsAccessRuleTermKey, projectsAccessRuleTermValue));
        projectsAccessRule.setAgencyId(getService().getCurrentAgency().getId());
        projectsAccessRule.setUserId(usersIds.get(Gen.getInt(usersIds.size())));
        projectsAccessRule.setRoleId(getRoleByName(PROJECT_USER).getId());
        projectsAccessRule.setExpiration(DateTime.now().plusMonths(1).getMillis());
        projectsAccessRule.setTerms(projectsAccessRuleTerms);

        return projectsAccessRule;
    }

    protected User createAdminUser(Agency agency) {
        User user = ObjectsFactory.getUser(agency, getRoleByName(AGENCY_ADMIN));
        user.setFullAccess();
        user.setPassword(getParam("password"));

        return getService().createUser(agency.getId(), user);
    }

    protected void createUsers(Agency agency, int count) {
        if (defaultUser == null) defaultUser = ObjectsFactory.getUser(agency, getRoleByName(AGENCY_USER));

        for (int i = 0; i < count; i++) {
            defaultUser.setFirstName(Gen.getHumanReadableString(8, true));
            defaultUser.setLastName(Gen.getHumanReadableString(8, true));
            defaultUser.setEmail((defaultUser.getFirstName() + "." + defaultUser.getLastName() + "@test.com"));
            collectUsersIds(getService().createUser(agency.getId(), defaultUser).getId());
        }
    }

    protected void createProjects(int count) {
        if (defaultProject == null) defaultProject = ObjectsFactory.getProject(Gen.getHumanReadableString(8, true));

        for (int i = 0; i < count; i++) {
            defaultProject.setName(Gen.getHumanReadableString(8, true));
            defaultProject.setJobNumber(Gen.getHumanReadableString(8, true));
            getService().createProject(defaultProject);
        }
    }

    protected void createAdvertiserChains(Agency agency, int advertisersCount, int brandsCount, int subBrandsCount, int productsCount) {
        Dictionary dictionary = getService().getAgencyDictionaryByName(agency.getId(), ADVERTISER_DICTIONARY_NAME);

        for (int advertiserIterator = 0; advertiserIterator < advertisersCount; advertiserIterator++) {
            String advertiserKey = String.format("%s %d", ADVERTISER, advertiserIterator);
            collectAdvertisers(advertiserKey);
            DictionaryItem advertiserItem = new DictionaryItem().setKey(advertiserKey);
            if (dictionary.getValues() == null) dictionary.setValues(new DictionaryValues());
            dictionary.getValues().add(advertiserItem);

            for (int brandIterator = 0; brandIterator < brandsCount; brandIterator++) {
                DictionaryItem brandItem = new DictionaryItem().setKey(String.format("%s %d", BRAND, brandIterator));
                if (advertiserItem.getValues() == null) advertiserItem.setValues(new DictionaryValues());
                advertiserItem.getValues().add(brandItem);

                for (int subBrandIterator = 0; subBrandIterator < subBrandsCount; subBrandIterator++) {
                    DictionaryItem subBrandItem = new DictionaryItem().setKey(String.format("%s %d", SUB_BRAND, subBrandIterator));
                    if (brandItem.getValues() == null) brandItem.setValues(new DictionaryValues());
                    brandItem.getValues().add(subBrandItem);

                    for (int productIterator = 0; productIterator < productsCount; productIterator++) {
                        DictionaryItem productItem = new DictionaryItem().setKey(String.format("%s %d", PRODUCT, productIterator));
                        if (subBrandItem.getValues() == null) subBrandItem.setValues(new DictionaryValues());
                        subBrandItem.getValues().add(productItem);
                    }
                }
            }
        }

        getService().updateAgencyDictionary(agency.getId(), ADVERTISER_DICTIONARY_NAME, dictionary.getValues());
    }
}
