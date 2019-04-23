package com.adstream.automate.babylon.migration.scripts;

import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/9/14
 * Time: 9:36 AM

 */
public class RemoveAssetsFromXML extends ParentScript {

    public static void main(String[] args) {
        Document doc = initXMLDocument();
        removeAllIncorrectAssets(doc);
        writeDocument(doc, XMLParser.getFilePath().replace(".xml", "_rm_node.xml"));
    }

    public static void removeAllIncorrectAssets(Document doc) {
        String sourceFile = "ex_list_need.txt";
        List<String> usefulCN = FileManager.readTextFile(sourceFile);
        int deletedAssets = 0;
        NodeList nodes = doc.getElementsByTagName("Asset");
        int count = nodes.getLength();
        for (int i = 0; i < count; i++) {
            Element person = (Element)nodes.item(i);
            Element name = null;
            if (person!= null)
                name = (Element)person.getElementsByTagName("AssetGUID").item(0);
                //name = (Element)person.getElementsByTagName("UniqueName").item(0);
            else
                continue;
            Element typeAsset = (Element)person.getElementsByTagName("AssetTypeID").item(0);
            if (name==null) continue;
            if (typeAsset == null) continue;
            if (typeAsset.getTextContent().equals("999")) continue;
            String pName = name.getTextContent();
            if (!usefulCN.contains(pName)) {
                person.getParentNode().removeChild(person);
                i--;
                deletedAssets++;
            }
            else {
                System.out.println();
            }
            System.out.println("Current / Deleted / ALL " + i + " / " + deletedAssets + " / " + count);
        }
        System.out.println("deletedAssets = " + deletedAssets);
    }

}
