package com.adstream.automate.babylon.migration.scripts;

import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.utils.Common;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import org.bson.BSONObject;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 1/8/15
 * Time: 12:36 PM

 */
public class ReportsHelper extends BaseTest {

    private static StringBuffer localReport;
    private static StringBuffer summaryReport = new StringBuffer("||*BU Name*||*assets amount*||*user*||*password*||*migration time, s*||\n");
    private static StringBuffer timeReport = new StringBuffer("||*BU Name*||*assets amount*||*time, s*||\n");
    private static StringBuffer withOrderReport = new StringBuffer("||*BU Name*||*assets amount*||*orders amount*||*order items amount*||*time, s*||\n");
    private long migrationTime;



    private static String xmlSources = "ftp://mongo-admin:ooquooX4Tha@ftp.adstream.com/[UPDATED XML OUTPUT] 2015-3-12T11-00-12_Discovery Italia Srl Unipersonale_0000.xml";

    public static void main(String[] args) {
        xmlSources = getFtp() + getContext().xmlSources;
        getMigrationReportByFile(xmlSources, "Live");


    }

    public static StringBuffer getSummaryReport() {
        return summaryReport;
    }

    public static StringBuffer getTimeReport() {
        return timeReport;
    }

    public static StringBuffer getWithOrderReport() {
        return withOrderReport;
    }

    public static long getMigrationReportByFile(String xmlSource, String env) {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("migration_report");
        String folder = System.getProperty("user.dir");
        localReport = new StringBuffer("On ");
        localReport.append("*" + env + "*\n");
        //folder = folder.concat("\\").concat(filePath);
        //File fileReport = new File(folder);

        BasicDBObject query = new BasicDBObject();
        query.put("parameters.xmlSource", xmlSource);
        DBObject obj = schemaCollection.findOne(query);
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        String assetsAmount= "";
        String ordersAmount= "";
        String orderItemsAmount= "";
        String BU = "";
        String login = "";
        String password = "";
        long result = 0;
        DateTime created = null;
        DateTime modify = null;
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            String fullInfoAboutOneMigration = "";
            if (map.getKey().toString().equals("report")) {
                if (map.getValue() instanceof BasicDBObject) {
                    Iterator iteratorReport = ((BasicDBObject) map.getValue()).entrySet().iterator();
                    while (iteratorReport.hasNext()) {
                        Map.Entry mapReport = (Map.Entry)iteratorReport.next();
                        //if (mapReport.getKey().toString().equalsIgnoreCase("assetNoSpec") || mapReport.getKey().toString().equalsIgnoreCase("otherStatus") || mapReport.getKey().toString().equalsIgnoreCase("proxyNoSpec")) continue;
                        //
                        if (mapReport.getKey().toString().equalsIgnoreCase("Asset") || mapReport.getKey().toString().equalsIgnoreCase("ProductOrder") || mapReport.getKey().toString().equalsIgnoreCase("ProductOrderItem")) {
                            if (mapReport.getValue() instanceof BasicDBObject) {
                                Iterator iteratorDetailedReport = ((BasicDBObject) mapReport.getValue()).entrySet().iterator();
                                while (iteratorDetailedReport.hasNext()) {
                                    Map.Entry mapDetailedReport = (Map.Entry)iteratorDetailedReport.next();
                                    fullInfoAboutOneMigration+= mapDetailedReport.getKey() + "->" + mapDetailedReport.getValue()+", ";
                                    if (mapDetailedReport.getKey().toString().equalsIgnoreCase("sync")) {
                                        if (mapDetailedReport.getValue() instanceof  BasicDBObject) {
                                            Iterator iteratorDetailed = ((BasicDBObject) mapDetailedReport.getValue()).entrySet().iterator();
                                            while (iteratorDetailed.hasNext()) {
                                                Map.Entry mapDetailed = (Map.Entry)iteratorDetailed.next();
                                                if (mapDetailed.getKey().toString().equalsIgnoreCase("stored")) {
                                                    result = Long.parseLong(mapDetailed.getValue().toString());
                                                    if (mapReport.getKey().toString().equalsIgnoreCase("Asset"))
                                                        assetsAmount= "Assets amount *" + mapDetailed.getValue().toString() + "*";
                                                    else if (mapReport.getKey().toString().equalsIgnoreCase("ProductOrder"))
                                                        ordersAmount= "Orders amount *" + mapDetailed.getValue().toString() + "*";
                                                    else if (mapReport.getKey().toString().equalsIgnoreCase("ProductOrderItem"))
                                                        orderItemsAmount= "Order items amount *" + mapDetailed.getValue().toString() + "*";

                                                }
                                            }
                                        }

                                    }
                                }
                            }
                        }


                    }
                }
            }
            else {
                if (map.getKey().toString().equalsIgnoreCase("parameters")) {
                    if (map.getValue() instanceof BasicDBObject) {
                        Iterator iteratorParameters = ((BasicDBObject) map.getValue()).entrySet().iterator();
                        while (iteratorParameters.hasNext()) {
                            Map.Entry mapDetailedParameters = (Map.Entry)iteratorParameters.next();
                            if (mapDetailedParameters.getKey().toString().equalsIgnoreCase("agencyName")) {
                                BU = "BU: *" + mapDetailedParameters.getValue().toString() + "*";
                            }
                            if (mapDetailedParameters.getKey().toString().equalsIgnoreCase("fakeUser")) {
                                if (mapDetailedParameters.getValue() instanceof BasicDBObject) {
                                    Iterator iteratorFakeUser = ((BasicDBObject) mapDetailedParameters.getValue()).entrySet().iterator();
                                    while (iteratorFakeUser.hasNext()) {
                                        Map.Entry mapFakeUser = (Map.Entry)iteratorFakeUser.next();
                                        if (mapFakeUser.getKey().toString().equalsIgnoreCase("email")) {
                                            login = "Login: *" + mapFakeUser.getValue().toString() + "*";
                                        }
                                        if (mapFakeUser.getKey().toString().equalsIgnoreCase("password")) {
                                            password = "Password: *" + mapFakeUser.getValue().toString() + "*";
                                        }
                                    }


                                }

                            }
                        }
                    }
                }
            }
            if (map.getKey().toString().equals("_created")) {
                if (map.getValue() instanceof Date) {
                    SimpleDateFormat dateFormat3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ssZZ");
                    String a = dateFormat3.format(map.getValue()).toString();
                    DateTimeFormatter parserCreate = ISODateTimeFormat.dateTimeNoMillis();
                    created = parserCreate.parseDateTime(a.replace(" ", "T"));

                }

            }
            if (map.getKey().toString().equals("_modified")) {
                if (map.getValue() instanceof Date) {
                    SimpleDateFormat dateFormat3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ssZZ");
                    String a = dateFormat3.format(map.getValue()).toString();
                    DateTimeFormatter parserCreate = ISODateTimeFormat.dateTimeNoMillis();
                    modify = parserCreate.parseDateTime(a.replace(" ", "T"));
                }

            }
            //FileManager.saveIntoFile(fileReport.getAbsolutePath(), fullInfoAboutOneMigration, true);
        }
        //
        localReport.append(BU+ "\n");
        localReport.append(assetsAmount + "\n");
        localReport.append(login + "\n");
        localReport.append(password + "\n");
        localReport.append("Advanced report:\n{code}\n");
        localReport.append(obj.toString()+"\n");
        localReport.append("{code}");
        summaryReport.append(String.format("|%s|%s|%s|%s|%s|\n", BU.replace("*", "").replace("BU", "").replace(":",""),
                assetsAmount.replace("*", "").replace("Assets amount", ""),
                login.replace("*", "").replace("Login", "").replace(":",""),
                password.replace("*", "").replace("Password", "").replace(":",""),
                (modify.getMillis() - created.getMillis())/1000));
        timeReport.append(String.format("|%s|%s|%s|\n", BU.replace("*", "").replace("BU", "").replace(":",""),
                assetsAmount.replace("*", "").replace("Assets amount", ""),
                (modify.getMillis() - created.getMillis())/1000));

        withOrderReport.append(String.format("|%s|%s|%s|%s|%s|\n", BU.replace("*", "").replace("BU", "").replace(":",""),
                assetsAmount.replace("*", "").replace("Assets amount", ""),
                ordersAmount.replace("*", "").replace("Orders amount", ""),
                orderItemsAmount.replace("*", "").replace("Order items amount", ""),
                (modify.getMillis() - created.getMillis())/1000));
        return result;
    }

    public static String getAssetsCount(String xmlSource) {
        DBCollection schemaCollection = BaseTest.getMongoDB().getCollection("migration_report");
        BasicDBObject query = new BasicDBObject();
        query.put("parameters.xmlSource", xmlSource);
        DBObject filter = new BasicDBObject("report.Asset.extract.total", "1");
        filter.put("report.Asset.sync.total", "1");
        DBObject obj = schemaCollection.findOne(query, filter);
        Iterator iterator = ((BasicDBObject) obj).entrySet().iterator();
        String result = "";
        while (iterator.hasNext()) {
            Map.Entry map = (Map.Entry)iterator.next();
            if (map.getKey().toString().equalsIgnoreCase("report")) {
                if (map.getValue() instanceof BasicDBObject) {
                    Iterator value = ((BasicDBObject) map.getValue()).entrySet().iterator();
                    while (value.hasNext()) {
                        Map.Entry mapValue = (Map.Entry)value.next();
                        Iterator assets = ((BasicDBObject) mapValue.getValue()).entrySet().iterator();
                        while (assets.hasNext()) {
                            Map.Entry mapAssets = (Map.Entry)assets.next();
                            result+= mapAssets.getKey().toString() + "->" + mapAssets.getValue() + "\n";
                        }
                    }
                }
            }

        }

        return result;
    }

    public static StringBuffer getLocalReport() {
        return localReport;
    }

    public static void setLocalReport(StringBuffer localReport) {
        ReportsHelper.localReport = localReport;
    }

    public static void marketHelper() {

    }


    public static void curlHelper() {
        /*            user-content-block
        Need to know:
        1. AgencyName
        2. user name
        3. fakeUser
        4. address
        Example:

        curl -XPOST -H "Content-Type: application/json" "http://10.64.162.12:8080/migration/a4?%24id%24=id-4ef31ce1766ec96769b399c0" -d '{"xmlLocation":"ftp://migration_user:1qa2ws3ed@10.0.24.17:/[UPDATED XML OUTPUT] 2015-1-08T13-58-38_Scandvision_0000.xml", "withPM": false, "withODT" :false, "withWIP": false, "WithCM": true,  "source": "a4UK", "fakeUserEmail" : "migration.user.chimney.scandvision@adbank.me", "agencyName" : "Chimney/Scandvision", "a4UserEmail" : "mccann@adstream.tv"}'

        curl -XPOST -H "Content-Type: application/json" "http://localhost:8080/migration/a4?%24id%24=id-4ef31ce1766ec96769b399c0" -d '{"xmlLocation":"ftp://migration_user:1qa2ws3ed@10.0.24.17:/[UPDATED XML OUTPUT] 2015-1-22T13-31-43_Duckling & Sonne_0000_adapted.xml", "withPM": false, "withODT" :false, "withWIP": false, "WithCM": true,  "source": "a4UK", "fakeUserEmail" : "migration.user.duckling.sonne@adbank.me", "agencyName" : "Duckling", "a4UserEmail" : "yvonne.powles@icpnet.com"}'


        curl -XPOST -H "Content-Type: application/json" "http://10.64.162.12:8080/migration/a4?%24id%24=id-4ef31ce1766ec96769b399c0" -d '{"xmlLocation":"ftp://migration_user:1qa2ws3ed@10.0.24.17:/[UPDATED XML OUTPUT] 2015-1-26T13-44-14_The Broadcast House_0000.xml", "withPM": false, "withODT" :false, "withWIP": false, "WithCM": true,  "source": "a4UK", "fakeUserEmail" : "migration.user.the.broadcast.house@adbank.me", "agencyName" : "The Broadcast House", "a4UserEmail" : "sallybuttery@tbh-uk.com"}'
        * */
    }

}
