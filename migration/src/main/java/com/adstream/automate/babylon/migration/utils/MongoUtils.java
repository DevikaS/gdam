package com.adstream.automate.babylon.migration.utils;

import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.mongodb.*;
import org.bson.types.ObjectId;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11/11/13
 * Time: 9:54 AM

 */
public class MongoUtils {

    private static String filePath = "migration/src/main/resources/results/migration_report.txt";

    public static void main(String[] args) throws IOException {
        //getA5Id("b7fa35b4-b6ed-4bef-9d0e-7a3695a531f7");
        //boolean result = isA4Id("532335f6e4b05c06b5908965");
        //getMigrationReport();
        //getMigrationReportByFile("");
        //getAllUsersFromAgency("53c42541e4b01466dd7341ee");
        //ystem.out.println(result);
        getMarketsInfo();
        //getMarketsFieldsValues();
        /*List<String> allNames = getAgenciesNamesBuGUIDs(new File("agencyGUIDs.txt"));
        for (String name: allNames) {
            System.out.println(name);
        } */
    }

    public static String getOrderByA4GUID(String guid) {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("order");
        DBObject query = new BasicDBObject("_private.a4.guid", guid);
        DBObject filter = new BasicDBObject("_id", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        String _id = "";
        if (obj == null)
            return "0";
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            return map.getValue().toString();
        }
        return _id;
    }

    public static long getCountOfOrderItems(String a5orderId) {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("order");
        BasicDBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(a5orderId));
        DBObject filter = new BasicDBObject("deliverables.total", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        if (obj == null)
            return -20;
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equals("deliverables")) {
                Iterator iteratorValue = ((BasicDBObject) map.getValue()).entrySet().iterator();
                while (iteratorValue.hasNext()) {
                    Map.Entry mapValue = (Map.Entry)iteratorValue.next();
                    return Long.parseLong(mapValue.getValue().toString());
                }
            }
        }

        return -9;
    }

    public static List<String> getOrderItems(String a5orderId) {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("order");
        BasicDBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(a5orderId));
        DBObject filter = new BasicDBObject("deliverables.items._id", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        if (obj == null)
            return null;
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        List<String> orderItemsIDs = new ArrayList<>();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("deliverables")) {
                Iterator iteratorValue = ((BasicDBObject) map.getValue()).entrySet().iterator();
                while (iteratorValue.hasNext()) {
                    Map.Entry mapValue = (Map.Entry)iteratorValue.next();
                    if (mapValue.getKey().toString().equalsIgnoreCase("items")){
                        Iterator iteratorItems = ((BasicDBList) mapValue.getValue()).iterator();
                        while (iteratorItems.hasNext()) {
                            DBObject objItems = (BasicDBObject)iteratorItems.next();
                            Iterator iteratorObjItems = ((BasicDBObject) objItems).entrySet().iterator();
                            while (iteratorObjItems.hasNext()) {
                                Map.Entry mapObjItems = (Map.Entry)iteratorObjItems.next();
                                orderItemsIDs.add(mapObjItems.getValue().toString());

                            }
                        }
                    }
                }
            }
        }
        return orderItemsIDs;
    }

    public static long getTotalCountForOrderItems(String orderItemsID) {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("order");
        BasicDBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(orderItemsID));
        DBObject filter = new BasicDBObject("_cm.destinations.count.total", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        if (obj == null)
            return 0;
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("_cm")) {
                Iterator iteratorValue = ((BasicDBObject) map.getValue()).entrySet().iterator();
                while (iteratorValue.hasNext()) {
                    Map.Entry mapValue = (Map.Entry)iteratorValue.next();
                    if (mapValue.getKey().toString().equalsIgnoreCase("destinations")) {
                        Iterator iteratorDest = ((BasicDBObject) mapValue.getValue()).entrySet().iterator();
                        while (iteratorDest.hasNext()) {
                            Map.Entry mapDest = (Map.Entry)iteratorDest.next();
                            if (mapDest.getKey().toString().equalsIgnoreCase("count")) {
                                Iterator iteratorCount = ((BasicDBObject) mapDest.getValue()).entrySet().iterator();
                                while (iteratorCount.hasNext()) {
                                    Map.Entry mapCount = (Map.Entry)iteratorCount.next();
                                    return Long.parseLong(mapCount.getValue().toString());
                                }
                            }
                        }
                    }
                }
            }
        }
        return 0;
    }

    public static String getPassword(String email) {
        String password = "";
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("user");
        DBObject query = new BasicDBObject("_cm.common.email", email);
        DBObject filter = new BasicDBObject("_private.password", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("_private")) {
                password = map.getValue().toString().split(":")[1].replaceAll("}","").replaceAll("\"", "").trim();
            }
        }
        return password;
    }

    public static List<String> getAgenciesNamesBuGUIDs(File fileGUIDs) throws IOException {
        List<String> guids = FileManager.readTextFile(fileGUIDs.getCanonicalPath());
        List<String> results = new ArrayList<>();
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("group");
        for (String guid: guids) {
            DBObject query = new BasicDBObject("_cm.a4.agencyId", guid.toLowerCase());
            DBObject filter = new BasicDBObject("_cm.common.name", 1);
            DBObject obj = schemaCollection.findOne(query, filter);
            Iterator iterator = null;
            try {
                iterator = ((BasicDBObject) obj).entrySet().iterator();
            } catch (Exception e) {
                System.err.println("guid = " + guid + " isn't in the DB");
                continue;
            }

            while (iterator.hasNext()) {
                Map.Entry map = (Map.Entry)iterator.next();
                if (map.getKey().toString().equalsIgnoreCase("_cm")) {
                    if (map.getValue() instanceof BasicDBObject) {
                        Iterator value = ((BasicDBObject) map.getValue()).entrySet().iterator();
                        while (value.hasNext()) {
                            Map.Entry mapValue = (Map.Entry)value.next();
                            if (mapValue.getValue() instanceof BasicDBObject) {
                                Iterator iteratorName = ((BasicDBObject) mapValue.getValue()).entrySet().iterator();
                                while (iteratorName.hasNext()) {
                                    Map.Entry mapName = (Map.Entry)iteratorName.next();
                                    if (mapName.getKey().toString().equalsIgnoreCase("name")) {
                                        results.add(mapName.getValue().toString());
                                    }
                                }

                            }

                        }
                    }

                    //password = map.getValue().toString().split(":")[1].replaceAll("}","").replaceAll("\"", "").trim();
                }
            }

        }
        return results;
    }

    public static String getA5Id(String a4Id) {
        String a5Id = "";
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("asset");
        DBObject query = (new BasicDBObject("_private.a4.id", a4Id).append("_deleted", new BasicDBObject("$not", new BasicDBObject("$exists", true))));
        DBObject filter = new BasicDBObject("_id", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        if (obj==null)
            return "";
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("_id")) {
                a5Id = map.getValue().toString();
            }
        }
        return a5Id;

    }

    public static void getMigrationReportByFile(String xmlSource) {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("migration_report");
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat(filePath);
        File fileReport = new File(folder);

        BasicDBObject query = new BasicDBObject();
        query.put("parameters.xmlSource", "ftp://migration_user:1qa2ws3ed@10.0.24.17/2014_07_30_0001_Procter & Gamble_adopted.xml");
        DBObject obj = schemaCollection.findOne(query);
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            String fullInfoAboutOneMigration = "";
            if (map.getKey().toString().equals("report")) {
                if (map.getValue() instanceof BasicDBObject) {
                    Iterator iteratorReport = ((BasicDBObject) map.getValue()).entrySet().iterator();
                    while (iteratorReport.hasNext()) {
                        Map.Entry mapReport = (Map.Entry)iteratorReport.next();
                        if (mapReport.getKey().toString().equalsIgnoreCase("assetNoSpec") || mapReport.getKey().toString().equalsIgnoreCase("otherStatus") || mapReport.getKey().toString().equalsIgnoreCase("proxyNoSpec")) continue;
                        fullInfoAboutOneMigration+= "\n" + mapReport.getKey().toString() + ": ";
                        if (mapReport.getValue() instanceof BasicDBObject) {
                            Iterator iteratorDetailedReport = ((BasicDBObject) mapReport.getValue()).entrySet().iterator();
                            while (iteratorDetailedReport.hasNext()) {
                                Map.Entry mapDetailedReport = (Map.Entry)iteratorDetailedReport.next();
                                fullInfoAboutOneMigration+= mapDetailedReport.getKey() + "->" + mapDetailedReport.getValue()+", ";
                            }

                        }
                    }
                }
            }
            System.out.println();
            FileManager.saveIntoFile(fileReport.getAbsolutePath(), fullInfoAboutOneMigration, true);
        }

    }

    public static boolean isA4Id(String a5Id) {
        String a4Id = "";
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("asset");
        BasicDBObject query = new BasicDBObject();
        query.put("_id", new ObjectId(a5Id));
        //DBObject filter = new BasicDBObject("_private.a4.id", 1);
        DBObject filter = new BasicDBObject("_private.migrated", 1);
        DBObject obj = schemaCollection.findOne(query, filter);
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("_private")) {
                if (map.getValue().toString().contains("migrated"))
                    return true;
                else
                    return false;
            }
        }
        return false;
    }

    public static List<String> getAllUsersFromAgency(String agencyID) {
        List<String> result = new ArrayList<>();
        DBCollection schemaCollectionAgency = BaseTest.getMongoDB().getCollection("user");
        BasicDBObject queryAgency = new BasicDBObject();
        queryAgency.put("agency._id", new ObjectId(agencyID));
        DBObject filterAgency = new BasicDBObject("_cm.common.email", 1);    //
        DBCursor cursorAgency = schemaCollectionAgency.find(queryAgency, filterAgency);
        while (cursorAgency.hasNext()) {
            DBObject objAgency =cursorAgency.next();
            Iterator iteratorAgency = ((BasicDBObject) objAgency).entrySet().iterator();
            while (iteratorAgency.hasNext()) {
                Map.Entry mapAgency = (Map.Entry)iteratorAgency.next();
                if (mapAgency.getValue() instanceof BasicDBObject) {
                    Iterator iteratorUser = ((BasicDBObject) mapAgency.getValue()).entrySet().iterator();
                    while (iteratorUser.hasNext()) {
                        Map.Entry mapUser = (Map.Entry)iteratorUser.next();
                        if (mapUser.getValue() instanceof BasicDBObject) {
                            Iterator iteratorEmail = ((BasicDBObject) mapUser.getValue()).entrySet().iterator();
                            while (iteratorEmail.hasNext()) {
                                Map.Entry mapEmail = (Map.Entry)iteratorEmail.next();
                                result.add(mapEmail.getValue().toString());
                            }
                        }
                    }
                }
            }
        }
        return result;
    }

    public static void getMigrationReport2() {

    }
    public static void getMigrationReport() {
                            /*DBCollection schemaCollectionAgency = BaseTest.getMongoDB().getCollection("group");
                    BasicDBObject queryAgency = new BasicDBObject();
                    queryAgency.put("_id", new ObjectId(map.getValue().toString()));
                    DBObject filterAgency = new BasicDBObject("_cm.common.name", 1);    //
                    DBCursor cursorAgency = schemaCollection.find(queryAgency, filterAgency);
                    while (cursorAgency.hasNext()) {
                        DBObject objAgency =cursorAgency.next();
                        Iterator iteratorAgency = ((BasicDBObject) objAgency).entrySet().iterator();
                        while (iteratorAgency.hasNext()) {
                            Map.Entry mapAgency = (Map.Entry)iteratorAgency.next();

                            System.out.println();
                        }

                    }
                    */

        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("migration_report");
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor = schemaCollection.find();
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat(filePath);
        File fileReport = new File(folder);
        while (cursor.hasNext()) {
            String fullInfoAboutOneMigration = "";
            DBObject obj =cursor.next();
            Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry map = (Map.Entry)iterator.next();
                if (map.getKey().equals("_id")) {
                    fullInfoAboutOneMigration+= "Unique migration key: " + map.getValue().toString() + "\n";
                } else if (map.getKey().equals("report")) {
                    if (map.getValue() instanceof BasicDBObject) {
                        Iterator iteratorReport = ((BasicDBObject) map.getValue()).entrySet().iterator();
                        while (iteratorReport.hasNext()) {
                            Map.Entry mapReport = (Map.Entry)iteratorReport.next();
                            if (mapReport.getKey().toString().equalsIgnoreCase("assetNoSpec") || mapReport.getKey().toString().equalsIgnoreCase("otherStatus") || mapReport.getKey().toString().equalsIgnoreCase("proxyNoSpec")) continue;
                            fullInfoAboutOneMigration+= "\n" + mapReport.getKey().toString() + ": ";
                            if (mapReport.getValue() instanceof BasicDBObject) {
                                Iterator iteratorDetailedReport = ((BasicDBObject) mapReport.getValue()).entrySet().iterator();
                                while (iteratorDetailedReport.hasNext()) {
                                    Map.Entry mapDetailedReport = (Map.Entry)iteratorDetailedReport.next();
                                    fullInfoAboutOneMigration+= mapDetailedReport.getKey() + "->" + mapDetailedReport.getValue()+", ";
                                }
                                //fullInfoAboutOneMigration+= "\n";
                            }

                        }
                    }
                } else if (map.getKey().equals("parameters")) {
                    if (map.getValue() instanceof BasicDBObject) {
                        Iterator iteratorParameters = ((BasicDBObject) map.getValue()).entrySet().iterator();
                        while (iteratorParameters.hasNext()) {
                            Map.Entry mapParameters = (Map.Entry)iteratorParameters.next();
                            if (mapParameters.getKey().toString().equalsIgnoreCase("xmlSource"))
                                fullInfoAboutOneMigration = mapParameters.getKey() + " -> " + mapParameters.getValue() + "\n" + fullInfoAboutOneMigration + "\n";
                        }
                    }
                } else if (map.getKey().equals("_duration")) {
                    fullInfoAboutOneMigration += "duration of migration: " + map.getValue().toString() + "\n\n\n";
                }

            }
            FileManager.saveIntoFile(fileReport.getAbsolutePath(), fullInfoAboutOneMigration, true);
        }

    }

    public static void getMarketsInfo() {
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("market.debug.info");
        File fileReport = new File(folder);

        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("market");
        DBCursor cursorAgency = schemaCollection.find();
        while (cursorAgency.hasNext()) {
            DBObject objAgency =cursorAgency.next();
            Iterator iteratorAgency = ((BasicDBObject) objAgency).entrySet().iterator();
            String _id = "";
            String name = "";
            String country = "";
            while (iteratorAgency.hasNext()) {
                Map.Entry mapAgency = (Map.Entry)iteratorAgency.next();
                //System.out.println(mapAgency.getValue().getClass().toString());
                if (mapAgency.getValue() instanceof BasicDBList) continue;
                if (mapAgency.getKey().toString().equalsIgnoreCase("sid"))
                    _id = mapAgency.getValue().toString();
                if (mapAgency.getKey().toString().equalsIgnoreCase("name"))
                    name = mapAgency.getValue().toString();
                if (mapAgency.getKey().toString().equalsIgnoreCase("country"))
                    country = mapAgency.getValue().toString();

            }
            FileManager.saveIntoFile(fileReport.getAbsolutePath(), _id + ", \"" + name + ", " + country +"\"\n", true);
        }
    }

    public static void getMarketsFieldsValues() {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("settings");
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat("markets_fields.info");
        File fileReport = new File(folder);

        BasicDBObject query = new BasicDBObject();
        query.put("_id", "market_fields");
        DBObject obj = schemaCollection.findOne(query);
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("markets")) {
                String _id = "";
                Iterator iteratorMarkets = ((BasicDBList) map.getValue()).iterator();
                while (iteratorMarkets.hasNext()) {
                    DBObject objMarkets = (BasicDBObject)iteratorMarkets.next();
                    Iterator iteratorObjMarkets = ((BasicDBObject) objMarkets).entrySet().iterator();
                    while (iteratorObjMarkets.hasNext()) {
                        Map.Entry mapObjMarkets = (Map.Entry)iteratorObjMarkets.next();
                        if (mapObjMarkets.getKey().toString().equalsIgnoreCase("marketNumber"))
                            _id = mapObjMarkets.getValue().toString();
                        System.out.println();
                        if (mapObjMarkets.getValue() instanceof BasicDBList) {
                            Iterator iteratorXMap = ((BasicDBList) mapObjMarkets.getValue()).iterator();
                            String info = "";
                            while (iteratorXMap.hasNext()) {
                                DBObject objXMap = (BasicDBObject)iteratorXMap.next();
                                Iterator iteratorObjXMap = ((BasicDBObject) objXMap).entrySet().iterator();
                                while (iteratorObjXMap.hasNext()) {
                                    Map.Entry mapObjXMap = (Map.Entry)iteratorObjXMap.next();
                                    info += mapObjXMap.getValue() + "->";
                                    System.out.println();
                                }
                            }
                            FileManager.saveIntoFile(fileReport.getAbsolutePath(), _id+ ", \"" + info.substring(0, info.length()-2) + "\"\n", true);
                        }

                    }


                }
            }

        //
        }
    }
}


