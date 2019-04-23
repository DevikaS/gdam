package com.adstream.automate.babylon.migration.scripts;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.objects.ProxyAsset;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import org.testng.annotations.Test;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/9/14
 * Time: 9:51 AM

 */
public class UpdateAssetsFromSpecialGroup extends BaseTest {

    private static boolean useA4Id = true;

    public static void main(String[] args) throws ParserConfigurationException, TransformerException, SAXException, IOException {

        UpdateAssetsFromSpecialGroup updateAssetsFromSpecialGroup = new UpdateAssetsFromSpecialGroup();
        updateAssetsFromSpecialGroup.findProxyWithSomeVideoProxy();
        String sourceFileInvalidProxies = "a4_invalid_GUIDs.txt";
        String sourceFileEmptyProxies = "a4_empty_GUIDs.txt";
        String sourceA5File = "FerefA5Id.txt";
        List<String> needIds = null;
        if (useA4Id) {
            needIds = FileManager.readTextFile(sourceFileInvalidProxies);
            needIds.addAll(FileManager.readTextFile(sourceFileEmptyProxies));
        }
        else {
            needIds = FileManager.readTextFile(sourceA5File);
        }
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        int emptyCount= 0;
        int deletedCount= 0;
        int wrongUpdate = 0;
        for (String id: needIds) {
            String a5Id = id;
            if (useA4Id)
                a5Id = updateAssetsFromSpecialGroup.getA5Id(id.toLowerCase());
            if (a5Id.isEmpty()) {
                emptyCount++;
            }

            else {
                try {
                    getService().deleteAsset(a5Id);
                    deletedCount++;
                } catch (Throwable t) {
                    wrongUpdate++;
                    t.printStackTrace();
                }


            }
            System.out.println("Info: Updated / ALL [" + deletedCount + " / " + needIds.size() + "] and empty: " + emptyCount + " and isn't updated: " + wrongUpdate);
        }
    }


    public void findProxyWithSomeVideoProxy() {
        String resultFileA4Empty = "a4_empty_GUIDs.txt";
        String resultFileA4ClockDouble = "a4_double_proxies.txt";
        String resultFileA4DoesNotWork = "a4_invalid_GUIDs.txt";
        String resultFileA4ClockDoesNotWork = "a4_invalid_proxies.txt";
        String resultFileA4ClocksEmptyProxies = "a4_empty_proxies.txt";
        deleteOldFiles(resultFileA4Empty);
        deleteOldFiles(resultFileA4ClockDouble);
        deleteOldFiles(resultFileA4DoesNotWork);
        deleteOldFiles(resultFileA4ClockDoesNotWork);
        deleteOldFiles(resultFileA4ClocksEmptyProxies);
        Map<String, Integer> map = new HashMap<>();
        int failCounter = 0;
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getAssetTypeID().equals("999")) continue;
            List<ProxyAsset> proxyAssetList = getProxyAssets(asset.getAssetGUID());
            if (proxyAssetList.size() == 0) {
                FileManager.saveIntoFile(resultFileA4ClocksEmptyProxies, "A4 GUID = " + asset.getAssetGUID()  +  ", ClockNumber = " + asset.getUniqueName() + "\n");
                FileManager.saveIntoFile(resultFileA4Empty, asset.getAssetGUID() + "\n");
                continue;
            }
            int counter= 0;

            String a4GUID = "";
            String clockNumber = "";
            boolean isFileID = true;
            boolean isFileSize = true;
            for (ProxyAsset proxyAsset: proxyAssetList) {
                if (proxyAsset.getSpecDBDocID()!= null && (proxyAsset.getSpecDBDocID().contains(":video:proxy:") || proxyAsset.getSpecDBDocID().contains(":video:streaming"))) {
                    if (proxyAsset.getFileId()==null || proxyAsset.getFileId().isEmpty())
                        isFileID= false;
                    if (proxyAsset.getFileId()!= null && (proxyAsset.getFileSize()==null || proxyAsset.getFileId().isEmpty() || proxyAsset.getFileId().equals("0")))
                        isFileSize= false;
                    counter++;
                }
            }
            if (counter>1) {
                FileManager.saveIntoFile(resultFileA4ClockDouble, "A4 GUID = " + asset.getAssetGUID()  +  ", ClockNumber = " + asset.getUniqueName() + "\n");
            }
            else {
                if (!isFileID) {
                    FileManager.saveIntoFile(resultFileA4DoesNotWork, asset.getAssetGUID() + "\n");
                    FileManager.saveIntoFile(resultFileA4ClockDoesNotWork, "A4 GUID = " + asset.getAssetGUID()  +  ", ClockNumber = " + asset.getUniqueName() + "\n");
                }
            }
        }

    }

    @Test
    public void getA5IdIntoFile() {
        String sourceFile = "a4_invalid_GUIDs";
        String resultFile = "CurrentAgencyA5Id.txt";
        List<String> a4IDs = FileManager.readTextFile(sourceFile);
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        for (String a4id: a4IDs)  {
            FileManager.saveIntoFile(resultFile, getA5Id(a4id)  + "\n");
        }
    }

    private List<ProxyAsset> getProxyAssets(String aGuid) {
        List<ProxyAsset> result = new ArrayList<>();
        for (ProxyAsset proxyAsset: XMLParser.getNewDataSet().getProxyAsset()) {
            //&&
            if (proxyAsset.getParentAssetGuid().equals(aGuid) )
                if (proxyAsset.getSpecDBDocID()!=null && !proxyAsset.getSpecDBDocID().isEmpty())
                    result.add(proxyAsset);
                else
                if (proxyAsset.getAssetTypeID().equals("4") || proxyAsset.getAssetTypeID().equals("1"))
                    result.add(proxyAsset);
        }
        return result;
    }

    private void deleteOldFiles(String fileName) {
        File file = new File(fileName);
        if (file.exists())
            file.delete();
    }


}
