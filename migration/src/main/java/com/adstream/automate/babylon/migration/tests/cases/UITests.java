package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.objects.AssetRelationship;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.testng.annotations.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 1:49 PM

 */
public class UITests extends BaseTest {

    @Test
    public void addReportToJira() {
        getWebDriver().get("https://jira.adstream.com/secure/Dashboard.jspa");
        getWebDriver().findElement(By.id("login-form-username")).sendKeys("yuriy.solomin");
        getWebDriver().findElement(By.id("login-form-password")).sendKeys("bfubhfwww123");
        getWebDriver().findElement(By.name("login")).click();
        System.out.println();
    }


    @Test
    public void checkFileExtention() {
        getWebDriver().get("http://10.0.26.17");
        getWebDriver().findElement(By.name("username")).sendKeys("traffic.nl@adstream.com");
        getWebDriver().findElement(By.name("password")).sendKeys("Adstream");
        getWebDriver().findElement(By.cssSelector(".signin")).click();
        String url = "";
        getService().logIn("traffic.nl@adstream.com", "Adstream");
        String collectionId = getService().getAssetsFilterByName("Everything", "").getId();
        //.get(2).getText()
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("UI_results.info");
        File file = new File((folder));


        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            boolean ingested = (asset.getAssetTypeID().equals("3") && asset.getSubAssetTypeID().equals("1") && !asset.getStatusID().equals("5"));
            if (asset.getAgencyGUID().equalsIgnoreCase("d5c14ff8-8d86-47c2-9e95-f0e5cc983d98") && (Integer.parseInt(asset.getLifecycleID()) > 1) && !ingested) {
                String a5id = getA5Id(asset.getAssetGUID());
                FileManager.saveIntoFile(file.getName(), "A4 = " + asset.getAssetGUID() + " clockNumber = " + asset.getUniqueName() + " A5 = " + a5id + "\n");
                Map<String, List<Asset>> odtAssets = getChildAssetsAndSpec(asset.getAssetGUID());
                List<Asset> assetList = odtAssets.get(asset.getAssetGUID());
                FileManager.saveIntoFile(file.getName(), "There are(is) " + assetList.size() + " odt element(s)\n");
                for (Asset odt: assetList) {

                    url = "http://10.0.26.17/library#collections/" + collectionId + "/assets/" + a5id + "/info";
                    getWebDriver().get(url);
                    boolean isExtension = false;
                    for (WebElement webElement: getWebDriver().findElements(By.cssSelector(".file-info-download .mvs.pointer"))) {
                        FileManager.saveIntoFile(file.getName(), webElement.getText() + "\n");
                        if (webElement.getText().toLowerCase().contains(odt.getFileName().split("\\.")[odt.getFileName().split("\\.").length-1].toLowerCase()))
                            isExtension= true;
                    }
                    try {
                        assertThat("", isExtension, equalTo(true));
                    }catch (Throwable t) {
                        FileManager.saveIntoFile(file.getName(), "this asset doesn't have correct file extension\n");
                    }
                }
                FileManager.saveIntoFile(file.getName(), "--------------------------------------------------------------------\n");
            }
        }

    }

    private Map<String, List<Asset>> getChildAssetsAndSpec(String aGuid) {
        List<AssetRelationship> assetRelationshipList = new ArrayList<>();
        List<Asset> result = new ArrayList<>();

        Map<String, List<Asset>> parentChildsRelation = new HashMap<>();
        List<Asset> childsAssetGUID = new ArrayList<>();
        parentChildsRelation.put(aGuid, childsAssetGUID);
        for (Asset childAsset: XMLParser.getNewDataSet().getAsset()) {
            if (childAsset.getParentAssetGuid()!= null && childAsset.getParentAssetGuid().equals(aGuid) && childAsset.getAssetTypeID().equals("999") && childAsset.getFileID()!=null && !childAsset.getFileID().isEmpty() && childAsset.getSpecDBDocID()!= null && (childAsset.getSpecDBDocID().contains("Unknown") || childAsset.getSpecDBDocID().contains("unknown"))) {
                childsAssetGUID.add(childAsset);
            }
        }
        for (AssetRelationship assetRelationship: XMLParser.getNewDataSet().getAssetRelationship()) {
            if (assetRelationship.getParentAssetGUID().equals(aGuid)) {
                assetRelationshipList.add(assetRelationship);
            }
        }
        for (AssetRelationship assetRelationship: assetRelationshipList) {
            for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
                if (asset.getAssetGUID().equals(assetRelationship.getChildAssetGUID()) && asset.getAssetTypeID().equals("999") && asset.getFileID()!=null && !asset.getFileID().isEmpty() && asset.getSpecDBDocID()!= null && (asset.getSpecDBDocID().contains("Unknown") || asset.getSpecDBDocID().contains("unknown"))) {
                    childsAssetGUID.add(asset);
                    break;
                }
            }
        }

        return parentChildsRelation;
    }

}
