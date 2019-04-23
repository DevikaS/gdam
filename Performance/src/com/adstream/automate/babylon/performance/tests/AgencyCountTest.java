package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementProjectCommonSchema;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;
import java.io.File;
import java.util.*;

//more details there NPL-82
public class AgencyCountTest extends AbstractPerformanceTestServiceWrapper {
    private User defaultUser;
    private Agency defaultAgency;
    private Project defaultProject;
    private final int count = 1000;

    @Override
    public void runOnce() {


    }

    @Override
    public void beforeStart() {
        log.info("login as global admin");
        getService().auth(getParam("login"), getParam("password"));
        log.info("create agency");
        Agency agency = getService().createAgency(generateAgency());
        log.info("create and login as agency admin");
        User user = getService().createUser(agency.getId(), generateUser());
        getService().auth(user.getEmail(), "1");

        log.info(String.format("update agency common schema by adding  %s fields", 20));
        updateSchema(agency.getId(), 20);

        log.info(String.format("create %s assets", count));
        for (int i = 0; i < count; i++) {
            createAsset(getParam("ImageAssetFilePath"));
        }

        log.info(String.format("waiting till %s assets obtain specs", count));
        waitForSpec(count);

        log.info(String.format("create %s projects", count));
        for (int i = 0; i < count; i++) {
            createProject(agency.getId());
        }
        log.info("end of beforeStart method");
    }

    @Override
    public void start() {
        getAssets(count);
    }

    @Override
    public void afterRun() {
    }

    protected Content createAsset(String assetFile) {
        return uploadAsset(new File(assetFile));
    }

    protected Project createProject(String agencyId) {
        return getService().createProject(generateProject(agencyId));
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

    protected void updateSchema(String agencyId, int numOfFields) {
        for (int i = 0; i < numOfFields; i++) {
            getService().updateAssetElementProjectCommonSchema(agencyId, generateAssetElementProjectCommonSchemaField(agencyId));
        }
    }

    protected AssetElementProjectCommonSchema generateAssetElementProjectCommonSchemaField(String agencyId){
        AssetElementProjectCommonSchema schema = getService().getAssetElementProjectCommonSchema(agencyId);
        Map<String, String> properties = new HashMap<String, String>();
        properties.put("FieldSize", "Full");
        properties.put("Hidden", "false");
        properties.put("Compulsory", "false");
        properties.put("Description", "customField");
        properties.put("Schema", "common");
        properties.put("SchemaName", String.format("asset_element_project_common.agency.%s", agencyId));
        properties.put("FieldType", "string");
        properties.put("FieldId", String.format("%s_%s", properties.get("Description"), Long.toString(System.currentTimeMillis())));
        schema.createCMField(properties);
        return  schema;
    }

    protected User generateUser() {
        if (defaultUser == null) {
            defaultUser = new User();
            defaultUser.setPhoneNumber("1234567890");
            defaultUser.setPassword("abcdefghA1");
            defaultUser.setAccess();
            defaultUser.setRoles(new BaseObject[]{getRoleByName("agency.admin")});
        }
        defaultUser.setFirstName(Gen.getHumanReadableString(6, true));
        defaultUser.setLastName(Gen.getHumanReadableString(6, true));
        defaultUser.setEmail((defaultUser.getFirstName() + "." + defaultUser.getLastName() + "@test.com").toLowerCase());
        log.info(defaultUser.getEmail());
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

    protected Project generateProject(String agencyId) {
        if (defaultProject == null) {
            Project project = new Project();
            project.setMediaType("Broadcast");
            project.setSubtype("project");
            project.setDateStart(new DateTime());
            project.setDateEnd(new DateTime().plus(Period.days(1)));
            defaultProject = project;
        }
        defaultProject.setName(Gen.getHumanReadableString(8, true));
        defaultProject.setJobNumber(Gen.getHumanReadableString(8, true));
        AssetElementProjectCommonSchema schema = getService().getAssetElementProjectCommonSchema(agencyId);
        Set<String> fields = schema.getCmSectionProperties("common").keySet();
        for (String field: fields){
            if (field.contains("customField")){
                defaultProject.getCmCommon().put(field,Gen.getHumanReadableString(8, true));
            }
        }
        return defaultProject;
    }
}