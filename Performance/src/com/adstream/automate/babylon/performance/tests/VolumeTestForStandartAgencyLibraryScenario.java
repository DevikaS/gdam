package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.utils.Gen;

import java.io.File;
import java.io.IOException;
import java.util.*;

//more details there NPL-99
public class VolumeTestForStandartAgencyLibraryScenario extends AbstractPerformanceTestServiceWrapper {
    private User defaultUser;
    private Agency defaultAgency;
    private static File tmpFile;
    private final int count = 60;

    @Override
    public void runOnce() {
        try {
            tmpFile = File.createTempFile("sfsdfd","sfsdfsdd");
        } catch (IOException e) {
            log.error(e);
        }

    }

    /*  Num of agency 200
    Every agency should have:
Advertiser dictionary: 60 advertisers, 4 brands in every advertiser
60 Agency Users
Every Agency User should have:
4 categories shared by Agency Admin(relevant to 4 brands of single advertiser)
Assets: 16 per Brand of Advertiser, uploaded by admin user
     */
    @Override
    public void beforeStart() {
        try {


        log.info("login as global admin");
        getService().auth(getParam("login"), getParam("password"));
        log.info("create agency");
        String agencyId = getService().createAgency(generateAgency()).getId();
        log.info("create agency admin");
        User agencyAdminUser = getService().createUser(agencyId, generateUser("agency.admin"));
        log.info(agencyAdminUser.getEmail());
        loginAs(agencyAdminUser);

        log.info(String.format("create %s agency users", count));
        List<String> agencyUsersId = new ArrayList<>(count);
        for (int i = 0; i < count; i++) {
            agencyUsersId.add(getService().createUser(agencyId, generateUser("agency.user")).getId());
        }

        log.info(String.format("create %s entries in advertiser dictionary + %s dictionary in each", count, 4));
        Dictionary agencyDictionay = getService().createAgencyDictionary(agencyId, "advertiser", generateAdvertiserDictionaty(count, 4));

        String libraryUserRoleId = getRoleByName("library.user").getId();
        log.info(String.format("create %s adv x %s brand category ", count, 4));
        int numOfUsers = 0;
        for (DictionaryItem item : agencyDictionay.getValues()) {
            for (String brand : item.getValues().getKeys()) {
                String assetFilerQuery = new AssetFilterTerms()
                        .add("_cm.common.advertiser", item.getKey())
                        .add("_cm.common.brand", brand).getQuery().toString();
                try {
                    String filterId = getService().createAssetFilter(Gen.getHumanReadableString(6, true) + " category", "asset_filter_category",assetFilerQuery).getId();
                    getService().shareAssetFilter(filterId,agencyUsersId.get(numOfUsers),libraryUserRoleId);
                }   catch (NullPointerException e){
                    log.error(e);
                }
            }
            numOfUsers++;
        }

        log.info(String.format("create %s assets", count * 4 * 16));
        for (DictionaryItem item : agencyDictionay.getValues()) {
            for (String brand : item.getValues().getKeys()) {
                for (int i = 0; i < 16; i++) {
                    Content asset = new Content();
                    fail("Rewrite to GND");
                    //asset.setTmpPath(prepareFileToUploadToGDN(tmpFile, null).get("tmpPath"));
                    asset.setBrand(brand);
                    asset.setAdvertiser(item.getKey());
                    asset.setName(Gen.getHumanReadableString(12));
                    //getService().createAsset(asset);
                }
            }
        }

        log.info(String.format("waiting till %s assets obtain specs", count * 4 * 16));
        waitForSpec(count * 4 * 16);
        }catch (Exception e){log.error(e);}

        log.info("end of beforeStart method");
    }

    @Override
    public void start() {
        getAssets(count);
    }

    @Override
    public void afterRun() {
    }

    protected void loginAs(User user){
        getService().auth(user.getEmail(), "1");
    }

    private SearchResult<Content> getAssets(int count) {
        return getService().findAssets(getEverythingCategoryId(), new LuceneSearchingParams().setResultsOnPage(count).setPageNumber(1));
    }

    private void waitForSpec(final int count) {
        try {
            new AbstractTranscodingChecker() {
                @Override
                public List<Content> getFiles() {
                    return getAssets(count).getResult();
                }
            }.process(true);
        } catch (Throwable t) {
            log.error(t);
        }
    }


    protected List<CustomMetadata> generateAdvertiserDictionaty(int numOfAdv, int numOfBrand) {
        List<CustomMetadata> advDictionary = new ArrayList<>(numOfAdv);
        for (int i = 0; i < numOfAdv; i++) {
            CustomMetadata adv = new CustomMetadata();
            adv.put("key", Gen.getHumanReadableString(10) + " advertiser");

            List<Map<String, String>> brandDictionary = new ArrayList<>(numOfBrand);
            for (int y = 0; y < numOfBrand; y++) {
                Map<String, String> brand = new HashMap<>();
                brand.put("key", Gen.getHumanReadableString(10) + " brand");
                brandDictionary.add(brand);
            }
            adv.put("values", brandDictionary);
            advDictionary.add(adv);
        }
        return advDictionary;
    }


    protected User generateUser(String role) {
        if (defaultUser == null) {
            defaultUser = new User();
            defaultUser.setPhoneNumber("1234567890");
            defaultUser.setPassword("abcdefghA1");
            defaultUser.setFullAccess();
        }
        defaultUser.setRoles(new BaseObject[]{getRoleByName(role)});
        defaultUser.setFirstName(Gen.getHumanReadableString(6, true));
        defaultUser.setLastName(Gen.getHumanReadableString(6, true));
        defaultUser.setEmail((defaultUser.getFirstName() + "." + defaultUser.getLastName() + "@test.com").toLowerCase());
        return defaultUser;
    }

    protected Agency generateAgency() {
        if (defaultAgency == null) {
            defaultAgency = new Agency();
            defaultAgency.setTimeZone("Europe-Andorra");
            defaultAgency.setPin("1");
            defaultAgency.setAgencyType("Advertiser");
            defaultAgency.setCountry("AF");
            defaultAgency.setStorageId(getParam("storageId"));
        }
        defaultAgency.setName(Gen.getHumanReadableString(6, true) + " Agency");
        return defaultAgency;
    }
}
