package com.adstream.automate.babylon.tests.performance;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.sut.pages.admin.metadata.GlobalMetadataPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.elements.MetadataFieldSettingsBlock;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 19.07.13 17:25
 */
public class WBSearchWorkflow extends Workflow {
    private static final int AGENCIES_COUNT = 20;
    private static final int BRANDS_COUNT = 30;
    private static final int ASSETS_COUNT = 20;
    private static final String FILE_PATH = "C:\\Work\\Downloads\\find.jpg";
    private static final String EMAIL_SUFFIX = "@test.com";
    private static final String AGENCY_PREFIX = "WB1Agency";
    private static final String BRAND_PREFIX = "Option";
    private static final String DEFAULT_PASSWORD = "1";
    private static AtomicInteger agencyCounterAdmin = new AtomicInteger(0);
    private static AtomicInteger categoryCounter = new AtomicInteger(1);
    private static AtomicInteger agencyCounter = new AtomicInteger(1);

    public WBSearchWorkflow(URL baseUrl, URL coreUrl, String login, String password) {
        super(baseUrl, coreUrl, login, password);
    }

    @Override
    public WorkflowActionStats perform() {
        performAction("", new WorkflowAction() {
            private AssetFilter everything;

            @Override
            public void prepare(Workflow workflow) {
                getPageNavigator().getLoginPage().login("admin", DEFAULT_PASSWORD);
                getCoreApi().logIn("admin", DEFAULT_PASSWORD);
                waitForPageLoad();
                int i;
                while ((i = agencyCounterAdmin.getAndIncrement()) < AGENCIES_COUNT) {
                    Agency agency = getCoreApi().getAgencyByName(AGENCY_PREFIX + i);
                    if (agency == null) {
                        agency = createAgency(AGENCY_PREFIX + i);
                        User user = generateUser(agency);
                        user.setEmail(AGENCY_PREFIX + i + EMAIL_SUFFIX);
                        getCoreApi().createUser(user);
                    }
                    Dictionary dictionary = getCoreApi().getAgencyDictionaryByName(agency.getId(), "advertiser");
                    if (dictionary == null) {
                        getCoreApi().createAgencyDictionary(agency.getId(), "advertiser", generateAdvertiserDictionary(AGENCIES_COUNT, BRANDS_COUNT));
                    }
                    getPageNavigator().getGlobalRolesPage();
                    GlobalMetadataPage metadataPage = getPageNavigator().getGlobalCommonCustomMetadataPage(agency.getId());
                    MetadataFieldSettingsBlock block = metadataPage.clickCommonMetadataButtonByName("Advertiser");
                    block.clickHierarchyNavigationBarItemByName("Sub Brand");
                    if (!block.isHideCheckboxSelected()) {
                        block.checkHideCheckbox();
                        block.clickSaveButton();
                    }
                    block.clickHierarchyNavigationBarItemByName("Product");
                    if (!block.isHideCheckboxSelected()) {
                        block.checkHideCheckbox();
                        block.clickSaveButton();
                    }
                }

                String wbAdminMail = AGENCY_PREFIX + 0 + EMAIL_SUFFIX;
                getPageNavigator().getLoginPage().login(wbAdminMail, DEFAULT_PASSWORD);
                getCoreApi().logIn(wbAdminMail, DEFAULT_PASSWORD);
                while ((i = categoryCounter.getAndIncrement()) < AGENCIES_COUNT) {
                    getPageNavigator().getMyProfilePage();
                    for (int j = 0; j < BRANDS_COUNT; j++) {
                        AssetFilterTerms collectionTerms = new AssetFilterTerms()
                                .add("_cm.common.advertiser", AGENCY_PREFIX + i)
                                .add("_cm.common.brand", BRAND_PREFIX + j);
                        getCoreApi().createAssetFilterCategory("Category agency " + i + " brand " + j, collectionTerms.getQuery().toString());
                    }
                }

                Agency mainAgency = getCoreApi().getAgencyByName(AGENCY_PREFIX + 0);
                while ((i = agencyCounter.getAndIncrement()) < AGENCIES_COUNT) {
                    String userMail = AGENCY_PREFIX + i + EMAIL_SUFFIX;
                    getPageNavigator().getLoginPage().login(userMail, DEFAULT_PASSWORD);
                    getCoreApi().logIn(userMail, DEFAULT_PASSWORD);

                    AssetFilter myAssets = getCoreApi().getAssetsFilterByName("My Assets", "asset_filter_category");
                    for (int j = getCoreApi().getAssetCountForCollection(myAssets.getId()); j < ASSETS_COUNT; j++) {
                        getCoreApi().uploadAsset(new File(FILE_PATH));
                        if (j % 10 == 9) {
                            System.out.println("Uploaded " + (j + 1) + " assets");
                        }
                    }

                    AssetFilter mainCategory = getCoreApi().getAssetsFilterByName("Main category", "asset_filter_category", 0);
                    if (mainCategory == null) {
                        AssetFilterTerms collectionTerms = new AssetFilterTerms()
                                .add("_cm.common.advertiser", AGENCY_PREFIX + i);
                        mainCategory = getCoreApi().createAssetFilterCategory("Main category", collectionTerms.getQuery().toString());
                        getCoreApi().shareAssetFilterToAgency(mainCategory.getId(), mainAgency.getId());
                    }
                    for (int j = 0; j < BRANDS_COUNT; j++) {
                        AssetFilterTerms collectionTerms = new AssetFilterTerms()
                                .add("_cm.common.advertiser", AGENCY_PREFIX + i)
                                .add("_cm.common.brand", BRAND_PREFIX + j);
                        getCoreApi().createAssetFilterCategory("Category brand " + j, collectionTerms.getQuery().toString());
                    }

                    List<Content> assets = getCoreApi()
                            .findAssets(myAssets.getId(), new LuceneSearchingParams().setResultsOnPage(ASSETS_COUNT))
                            .getResult();
                    int transcodedAssets = 0;
                    for (Content asset : assets) {
                        boolean firstTime = true;
                        while (asset.getLastRevision().getPreview() == null) {
                            if (!firstTime) {
                                Common.sleep(5000);
                            } else {
                                firstTime = false;
                            }
                            asset = getCoreApi().getAsset(asset.getId());
                        }
                        if (asset.getAdvertiser() == null || !asset.getAdvertiser().equals(AGENCY_PREFIX + i)) {
                            asset.setAdvertiser(AGENCY_PREFIX + i);
                            getCoreApi().updateAsset(asset);
                        }
                        transcodedAssets++;
                        if (transcodedAssets % 10 == 0) {
                            System.out.println("Transcoded " + transcodedAssets + " assets");
                        }
                    }
                }
                String userMail = AGENCY_PREFIX + 0 + EMAIL_SUFFIX;
                getPageNavigator().getLoginPage().login(userMail, DEFAULT_PASSWORD);
                getCoreApi().logIn(userMail, DEFAULT_PASSWORD);
                everything = getCoreApi().getAssetsFilterByName("Everything", "asset_filter_category");
            }

            @Override
            public void perform(Workflow workflow) {
                performAction("Get assets", new WorkflowAction() {
                    @Override
                    public void perform(Workflow workflow) {
                        LuceneSearchingParams query = new LuceneSearchingParams()
                                .setQuery("*")
                                .setSortingField("_created")
                                .setSortingOrder("desc")
                                .setPageNumber(1)
                                .setResultsOnPage(20)
                                .setDeleted(false);
                        getCoreApi().findAssets(everything.getId(), query);
                    }
                });
            }
        });
        return null;
    }

    protected List<CustomMetadata> generateAdvertiserDictionary(int numOfAdv, int numOfBrand) {
        List<CustomMetadata> advDictionary = new ArrayList<CustomMetadata>(numOfAdv);
        for (int i = 0; i < numOfAdv; i++) {
            CustomMetadata adv = new CustomMetadata();
            adv.put("key", AGENCY_PREFIX + i);

            List<Map<String, String>> brandDictionary = new ArrayList<Map<String, String>>(numOfBrand);
            for (int y = 0; y < numOfBrand; y++) {
                Map<String, String> brand = new HashMap<String, String>();
                brand.put("key", BRAND_PREFIX + y);
                brandDictionary.add(brand);
            }
            adv.put("values", brandDictionary);
            advDictionary.add(adv);
        }
        return advDictionary;
    }

    private Agency createAgency(String agencyName) {
//        createAgencyInAdbank4(agencyName);
        Agency agency = getCoreApi().getAgencyByName(agencyName);
        if (agency == null) {
            agency = getCoreApi().createAgency(generateAgency(agencyName));
        }
        return agency;
    }

    private Agency generateAgency(String agencyName) {
        Agency agency = new Agency();
        agency.setName(agencyName);
        agency.setDescription(agencyName);
        agency.setSubtype("agency");
        agency.setPin("1");
        agency.setTimeZone("Europe-Andorra");
        agency.setCountry("AF");
        agency.setAgencyType("Advertiser");
//        agency.setStorageId("5b1ad2af-3f8f-4557-9841-d6440df3648c");
        agency.setStorageId("d7acf7be-9e69-4b66-9813-7fe2fed203fe");
        return agency;
    }

    private User generateUser(Agency agency) {
        User user = new User();
        user.setAgency(agency);
        user.setPhoneNumber("1234567890");
        user.setAdvertiser(agency.getId());
        user.setPassword("1");
        user.setFullAccess();
        user.setRoles(new BaseObject[] {getRole("agency.admin")});
        user.setFirstName(Gen.getHumanReadableString(6, true));
        user.setLastName(Gen.getHumanReadableString(6, true));
        user.setEmail(user.getFirstName().toLowerCase() + "." + user.getLastName().toLowerCase() + EMAIL_SUFFIX);
        return user;
    }

    private Role getRole(String roleName) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\"", roleName));
        return getCoreApi().findRoles(query).getResult().get(0);
    }

}
