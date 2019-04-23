package com.adstream.automate.babylon.migration.utils;

import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryItem;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.migration.objects.Agency;
import com.adstream.automate.babylon.migration.tests.BaseTest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11/14/13
 * Time: 3:06 PM

 */
public class DictionaryUtils {

    public static void main(String[] args) {
        getAllAdvertiserAndBrandByAgency("A4&A5 Migration Agency");

    }

    public static List<String> getAdvertiserByAgency(String agencyName) {
        BaseTest.getService().logIn("admin", "abcdefghA1");
        String agencyId = getAgencyId(agencyName);
        ArrayList<String> result = new ArrayList<String>();
        BaseTest.getService().getAgencyDictionaryByName(agencyId, "advertiser").getValues().get(0).getKey();
        for (DictionaryItem dV: BaseTest.getService().getAgencyDictionaryByName(agencyId, "advertiser").getValues()) {
            result.add(dV.getKey());
        }
        return result;
    }

    public static List<String> getDictionaryForAgency(String agencyName, String dictionaryName) {
        BaseTest.getService().logIn("admin", "abcdefghA1");
        String agencyId = getAgencyId(agencyName);
        ArrayList<String> result = new ArrayList<String>();
        DictionaryValues dictionaryValues = BaseTest.getService().getAgencyDictionaryByName(agencyId, dictionaryName).getValues();
        for (DictionaryItem dictionaryItem: dictionaryValues) {
            result.add(dictionaryItem.getKey());
        }
        return result;
    }

    public static Map<String, List<String>> getAllAdvertiserAndBrandByAgency(String agencyName) {
        List<String> advertisers = getAdvertiserByAgency(agencyName);
        String agencyId = getAgencyId(agencyName);
        Map<String, List<String>> result = new HashMap<String, List<String>>();
        for (String advertiser: advertisers) {
            BaseTest.getService().getAgencyDictionaryByName(agencyId, "advertiser").getValues();
            List<String> brands = new ArrayList<String>();
            for (DictionaryItem dV: BaseTest.getService().getAgencyDictionaryByName(agencyId, "advertiser").getValues().get(advertiser).getValues()) {
                brands.add(dV.getKey());
            }
            result.put(advertiser, brands);
        }
        return result;
    }

    public static String getAgencyId(String agencyName) {
        String agencyId = "";
        for (Agency agency: XMLParser.getNewDataSet().getAgency()) {
            if (agency.getAgencyName().equalsIgnoreCase(agencyName)) {
                agencyId = BaseTest.getService().getAgencyByName(agencyName).getId();
            }
        }
        return agencyId;
    }

}
