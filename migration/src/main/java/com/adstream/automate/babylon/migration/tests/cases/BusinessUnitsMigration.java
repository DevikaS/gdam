package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.migration.actions.UsersAction;
import com.adstream.automate.babylon.migration.objects.Agency;
import com.adstream.automate.babylon.migration.objects.User;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.tests.data.MigrationDataProvider;
import com.adstream.automate.babylon.migration.utils.MongoUtils;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import org.apache.commons.codec.digest.DigestUtils;
import org.testng.Assert;
import org.testng.annotations.Test;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;



/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/9/13
 * Time: 6:46 PM

 */
public class BusinessUnitsMigration extends BaseTest {


    @Test(dataProvider = "allAgencies", dataProviderClass = MigrationDataProvider.class)
    public void compareBUMetadata(Agency agencyData) {
        String agencyType = "";
        switch (Integer.parseInt(agencyData.getOrganisationTypeID())) {
            case 1:
                agencyType = "Agency";
                break;
            default:
                agencyType = "!@Unknown@!";
                break;
        }
        getService().logIn(globalLogin, globalPassword);
        /*for (Agency agencyXML: XMLParser.getNewDataSet().getAgency()) {
            com.adstream.automate.babylon.JsonObjects.Agency businessUnit = getService().getAgencyByA4AgencyId(agencyXML.getAgencyGUID());
            if (businessUnit.get_a4version() <= XMLParser.getNewDataSet().getAgency()[0].getRevisionA4()) {
                assertThat(businessUnit.getName(), equalTo(agencyXML.getAgencyName()));
                assertThat(businessUnit.getPin(), equalTo(agencyXML.getPin()));
                assertThat(businessUnit.getAgencyType()[0], equalToIgnoringCase(agencyType));
                assertThat(businessUnit.getA4AgencyId(), equalToIgnoringCase(agencyXML.getAgencyGUID()));
            }
        } */
    }

    @Test(dataProvider = "allAgencies", dataProviderClass = MigrationDataProvider.class)
    public void checkCountryField() {
        getService().logIn(globalLogin, globalPassword);

        for (Agency agencyXML: XMLParser.getNewDataSet().getAgency()) {

        }
    }

    @Test
    public void checkUserGetPassword() {
        ArrayList result = new ArrayList();
        int count = 0;
        for (User user: XMLParser.getNewDataSet().getUser()) {
            if (user.getAgencyName().isEmpty()) continue;
            String password = "";
            try {
                //password = MongoUtils.getPassword(user.getEmail()).trim();
                password = user.getPassword();
                boolean isLogged = getService().logIn(user.getEmail(), password);
                if (!isLogged) {
                    System.out.println(user.getEmail() + " \n disabled status: " + user.isDisabled() + " \n password: " + user.getPassword() + "\n Agency = " + user.getAgencyName() + "\n---------------------------------------------------");
                    count++;
                }
            }
            catch (Throwable npe) {
                //log.info(user.getEmail() + " \n disabled status: " + user.isDisabled() + " \n password: " + user.getPassword() + "\n---------------------------------------------------");
                //count++;
            }

        }
        System.out.println("count of users that can't login " + count);
        System.out.println();
    }

    @Test(dataProvider = "allUsers", dataProviderClass = MigrationDataProvider.class)
    public void checkMetaDate(User user) {

        log.info("-------------------------------------------------------------------");

        // Берем ВСЕХ юзеров из ХМЛ. В зависимости от теста, можем фильтровать.
        // Get AUTH for user

        String agencyGUID = XMLParser.getNewDataSet().getAgency()[0].getAgencyGUID(); // Пока работаем с 1 агенством из ХМЛ


        //Do assert that current user is login
        log.info("[2] - Do login for " + user.getFullName());
        getService().logIn(otherAgencyEmail, otherAgencyEmail);

        //if (user.)
        //assertThat(user.getEmail() + " doesn't login", getService().logIn(user.getEmail(), password), equalTo(true));


        // Check email
        log.info("[3] - Do check email for " + user.getFullName());
        assertThat(getCore().getCurrentUser().getEmail(), equalTo(user.getEmail()));

        // Check Agency Name
        log.info("[4] - Do check Agency for " + user.getFullName());
        assertThat(getCore().getCurrentUser().getAgency().getName(), equalTo(user.getAgencyName()));

        // Check First Name
        log.info("[5] - Do check first name for " + user.getFullName());
        assertThat("First Name is incorrect for user " + user.getEmail(), getCore().getCurrentUser().getFirstName(), equalTo(user.getFirstName()));

        // Check Last Name
        log.info("[6] - Do check last name for " + user.getFullName());
        assertThat(getCore().getCurrentUser().getLastName(), equalTo(user.getLastName()));

        // Check Role name
        log.info("[7] - Do check role for " + user.getFullName());
        String role_name_a4 = user.isDeptAdmin() ? "agency.admin" : "agency.user";
        String role_name_a5 = getCore().getCurrentUser().getRoles()[0].getName();
        //assertThat("email: " + user.getEmail() + " password: " + password + " agency " + user.getAgencyName(), role_name_a5, equalTo(role_name_a4));

    }

    @Test(dataProvider = "adminCreateProjects", dataProviderClass = MigrationDataProvider.class)
    public void checkAdminCreateProject(UsersAction usersAction) {

        assertThat(getService().logIn(usersAction.getCurrentUser().getEmail(), MongoUtils.getPassword(usersAction.getCurrentUser().getEmail())), equalTo(true));
        Project projectData = usersAction.getProjects().get(0);

        Project projectApp = getService().createProject(projectData);
        assertThat(projectApp.getId(), notNullValue());
        assertThat(projectApp.getName(), equalTo(projectData.getName()));
        Content con = usersAction.getContentAfterCreateFolder(projectApp);
        assertThat(con.getName(), equalTo(usersAction.getFolder().getName()));

    }

    @Test(dataProvider = "nonAdminCreateProjects", dataProviderClass = MigrationDataProvider.class)
    public void checkNonAdminCreateProject(UsersAction usersAction) {

        assertThat(getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword()), equalTo(true));
        for (Project projectData: usersAction.getProjects()) {
            Project projectApp = getService().createProject(projectData);
            assertThat(projectApp.getId(), notNullValue());
            assertThat(projectApp.getName(), equalTo(projectData.getName()));
            Content con = usersAction.getContentAfterCreateFolder(projectApp);
            assertThat(con.getName(), equalTo(usersAction.getFolder().getName()));

        }
    }

    @Test(dataProvider = "preparedFilesToUpload", dataProviderClass = MigrationDataProvider.class)
    public void checkUpload(UsersAction usersAction) {

        log.info("[1] - Do Log in and create project and folder");
        assertThat(getService().logIn(usersAction.getCurrentUser().getEmail(), MongoUtils.getPassword(usersAction.getCurrentUser().getEmail())), equalTo(true));
        Project projectApp = getService().createProject(usersAction.getProjects().get(0));
        Content folderApp = getService().createFolder(projectApp.getId(), usersAction.getFolderName());

        log.info("[2] - Do file upload to A5.");
        getService().uploadFile(usersAction.getFile(), folderApp.getId());

        log.info("[3] - Check that Project is created");
        String proj_name= usersAction.getProjects().get(0).getName();
        assertThat(getService().getProjectByName(proj_name).getName(), equalTo(usersAction.getProjects().get(0).getName()));

        log.info("[4] - Check that Folder is correct.");
        Project projectId = getService().getProject(projectApp.getId());
        assertThat(projectId.getName(), equalTo(usersAction.getProjects().get(0).getName()));

        log.info("[5] - Check that file is uploaded.");
        String name = folderApp.getName();
        Content fl_content = getService().getFolderByName(projectId.getId(), projectId.getId(),usersAction.getFolderName());
        Content con = getService().getFileByName(fl_content.getId(), usersAction.getFile().getName());
        long startTime = System.currentTimeMillis();
        while (con == null) {
            Common.sleep(1000);
            con = getService().getFileByName(fl_content.getId(), usersAction.getFile().getName());
            if (System.currentTimeMillis() - startTime > 120000)
                Assert.fail("file doesn't upload");
        }
        assertThat(con.getName(), equalTo(usersAction.getFile().getName()));

    }

    @Test(dataProvider = "adminCreateProjects", dataProviderClass = MigrationDataProvider.class)
    public void checkAdminCreateCollection(UsersAction usersAction) {

        assertThat(getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword()), equalTo(true));

        for (Project projectData: usersAction.getProjects()) {
            Project projectApp = getService().createProject(projectData);
            log.info("[1] - Assert that project name is no null.");
            assertThat(projectApp.getId(), notNullValue());
            log.info("[2] - Assert that project name is correct.");
            assertThat(projectApp.getName(), equalTo(projectData.getName()));
            Content con = usersAction.getContentAfterCreateFolder(projectApp);
            log.info("[3] - Assert that folder was created.");
            assertThat(con.getName(), equalTo( usersAction.getFolder().getName()));
            log.info("Try to create new collection.");
            AssetFilter ourCollection = getService().createAssetFilterCollection("VVideo", new AssetFilterTerms().getQuery().toString());
            log.info("New collection -" + ourCollection.getName());
            log.info("Get from service our collection name -" + getService().getAssetFiltersCollection().getRoot().getName());
            log.info("[4] Assert that new collection was created.");
            assertThat(ourCollection.getName(), equalTo(getService().getAssetFiltersCollection().getRoot().getName()));

        }
    }

    @Test(dataProvider = "nonAdminCreateProjects", dataProviderClass = MigrationDataProvider.class)
    public void checkNonAdminCreateCollection(UsersAction usersAction) {

        assertThat(getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword()), equalTo(true));

        for (Project projectData: usersAction.getProjects()) {
            Project projectApp = getService().createProject(projectData);
            log.info("[1] - Assert that project name is no null.");
            assertThat(projectApp.getId(), notNullValue());
            log.info("[2] - Assert that project name is correct.");
            assertThat(projectApp.getName(), equalTo(projectData.getName()));
            Content con = usersAction.getContentAfterCreateFolder(projectApp);
            log.info("[3] - Assert that folder was created.");
            assertThat(con.getName(), equalTo( usersAction.getFolder().getName()));
            log.info("Try to create new collection.");
            AssetFilter ourCollection = getService().createAssetFilterCollection("PPhoto", new AssetFilterTerms().getQuery().toString());
            log.info("New collection -" + ourCollection.getName());
            log.info("Get from service our collection name -" + getService().getAssetFiltersCollection().getRoot().getName());
            log.info("[4] - Assert that new collection was created.");
            assertThat(ourCollection.getName(), equalTo(getService().getAssetFiltersCollection().getRoot().getName()));
        }
    }

    @Test(dataProvider = "uploadRevision", dataProviderClass = MigrationDataProvider.class)
    public void uploadRevision(UsersAction usersAction) throws IOException {
        getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword());
        //Content newAsset = getService().uploadAsset(usersAction.getFile(), null);
        Project projectApp = getService().createProject(usersAction.getProjects().get(0));
        Content folderApp = getService().createFolder(projectApp.getId(), usersAction.getFolderName());
        File newFile = null;
        try {
            newFile = File.createTempFile(Gen.getString(10), Gen.getString(3));
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            Assert.fail("File for upload revision doesn't create");
        }
        Content uploadedFile = getService().uploadFile(newFile, folderApp.getId());
        getService().uploadRevision(usersAction.getFile(), uploadedFile.getId());

        Content newContent = getService().getFileByName(folderApp.getId(), newFile.getName());
        Long startTime = System.currentTimeMillis();
        while (newContent == null) {
            Common.sleep(1000);
            newContent = getService().getFileByName(folderApp.getId(), newFile.getName());
            if (System.currentTimeMillis() - startTime > 120000)
                Assert.fail("file doesn't upload");

        }
        startTime = System.currentTimeMillis();
        while (newContent.getRevisions()[1].getMaster() == null) {
            Common.sleep(1000);
            newContent = getService().getFileByName(folderApp.getId(), newFile.getName());
            if (System.currentTimeMillis() - startTime > 120000)
                Assert.fail("Revision didn't upload");

        }
        FileInputStream is = new FileInputStream(usersAction.getFile());
        String md5 = DigestUtils.md5Hex(is);
        assertThat("", md5, equalTo(newContent.getRevisions()[1].getMaster().getMD5()));
    }

    @Test(dataProvider = "allUsersFromAgency", dataProviderClass = MigrationDataProvider.class)
    public void checkUsersPermission(User user) { // Ordering only
        getService().logIn(user.getEmail(), MongoUtils.getPassword(user.getEmail()));
        com.adstream.automate.babylon.JsonObjects.User userApp = getService().getUserByEmail(user.getEmail());
        assertThat("check access to adpath for user: " + user.getEmail(), userApp.hasTrafficAccess(), equalTo(false));
        assertThat("check access to library for user: " + user.getEmail(), userApp.hasLibraryAccess(), equalTo(false));
        assertThat("check access to ordering for user: " + user.getEmail(), userApp.hasDeliveryAccess(), equalTo(true));
        assertThat("check access to folders for user: " + user.getEmail(), userApp.hasFoldersAccess(), equalTo(false));
        System.out.println();
    }


}
