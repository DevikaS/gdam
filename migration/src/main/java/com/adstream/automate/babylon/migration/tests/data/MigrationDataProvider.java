package com.adstream.automate.babylon.migration.tests.data;

import com.adstream.automate.babylon.migration.tests.TestData;
import org.testng.annotations.DataProvider;

import java.util.Iterator;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/10/13
 * Time: 8:24 AM

 */
public class MigrationDataProvider {

    @DataProvider(name = "allUsers", parallel = false)
    public static Iterator<Object[]> getAllUsers() {
        return (new TestData()).getUsersFromXML().iterator();
    }

    @DataProvider(name = "allUsersFromAgency", parallel = false)
    public static Iterator<Object[]> getAllUsersFromAgency() {
        return (new TestData()).getAllUsersWithDefineInTheXMLAgency().iterator();
    }

    @DataProvider(name = "adminCreateProjects", parallel = false)
    public static Iterator<Object[]> getAdminUserActivityCreateProject() {
        return (new TestData()).getProjectAdminActivity(3, "Warner Bros UK").iterator();
    }

    @DataProvider(name = "nonAdminCreateProjects", parallel = false)
    public static Iterator<Object[]> getNonAdminUserActivityCreateProject() {
        return (new TestData()).getProjectNonAdminActivity(5).iterator();
    }

    @DataProvider(name = "adminCreateFolder", parallel = false)
    public static Iterator<Object[]> getAdminUserActivityCreateFolder() {
        return (new TestData()).getFolderAdminActivity().iterator();
    }

    @DataProvider(name = "adminUploadFile", parallel = false)
    public static Iterator<Object[]> getAdminUploadFile() {
        return (new TestData()).getUploadFileActivity().iterator();
    }

    @DataProvider(name = "allAssets", parallel = false)
    public static Iterator<Object[]> getAllAssets() {
        return (new TestData()).getAllAssets().iterator();
    }


    @DataProvider(name = "wipAssets", parallel = false)
    public static Iterator<Object[]> getWIPAsset() {
        return (new TestData()).getWIPAssets().iterator();
    }

    @DataProvider(name = "oneUserOneAsset", parallel = false)
    public static Iterator<Object[]> getUserAndAsset() {
        return (new TestData()).getUsersAndAssets().iterator();
    }

    // Get all files from resources/files. 1 Admin and 1 Agency User. Used in the test for upload assets
    @DataProvider(name = "assetToUpload", parallel = false)
    public static Iterator<Object[]> getFilesForUpload() {
        return (new TestData()).getDataForUploadAsset().iterator();
    }

    @DataProvider(name = "assetToEditMetadata", parallel = false)
    public static Iterator<Object[]> getAssetForEditMetadata() {
        return (new TestData()).getDataForUploadAsset().iterator();
    }

    @DataProvider(name = "uploadRevision", parallel = false)
    public static Iterator<Object[]> getUploadRevision() {
        return (new TestData()).getPreparedRevisionForUpload().iterator();
    }

    @DataProvider(name = "migratedAssetForEditMetadata", parallel = false)
    public static Iterator<Object[]> getMigratedAssetForEditMetadata() {
        return (new TestData()).getRandomlyAssets(1, null).iterator();
    }

    @DataProvider(name = "usersWithAssets", parallel = false)
    public static Iterator<Object[]> getUsersWithAssets() {
        return (new TestData()).getDataForCheckAssetForChoosenUser().iterator();
    }

    @DataProvider(name = "preparedFilesToUpload", parallel = false)
    public static Iterator<Object[]> getPreparedFilesToUpload() {
        //return (new TestData()).getPreparedFileForUpload().iterator();
        return (new TestData()).getPreparedFileForUpload("JWT Amsterdam").iterator();
    }

    @DataProvider(name = "allVideoAssets", parallel = false)
    public static Iterator<Object[]> getAllVideoAssets() {
        return (new TestData()).getVideoAssetsFromAgency().iterator();
    }

    @DataProvider(name = "allAudioAssets", parallel = false)
    public static Iterator<Object[]> getAllAudioAssets() {
        return (new TestData()).getAudioAssetsFromAgency().iterator();
    }

    // Prepare data for test usage rights permission
    @DataProvider(name = "usageRights", parallel = false)
    public static Iterator<Object[]> getUsageRights() {
        return (new TestData()).getDataForUsageRights().iterator();
    }

    @DataProvider(name = "assetsWithSpecs", parallel = false)
    public static Iterator<Object[]>  getAllAssetsWithSpecs() {
        return (new TestData()).getUsersAndAssetsWithSpecs().iterator();
    }

    @DataProvider(name = "allAgencies", parallel = false)
    public static Iterator<Object[]> getAllAgencies() {
        return (new TestData()).getAllAgencyFromXML().iterator();
    }

    @DataProvider(name = "downloadAssets", parallel = false)
    public static Iterator<Object[]> getAssetsForDownload() {
        return (new TestData()).getDataForDownloadTests().iterator();
    }

}
