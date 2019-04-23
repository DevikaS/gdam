package com.adstream.automate.babylon.migration.tests;

import com.adstream.automate.babylon.migration.tests.data.TestBugInfo;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import org.testng.IReporter;
import org.testng.IResultMap;
import org.testng.ITestNGMethod;
import org.testng.ITestResult;
import org.testng.annotations.AfterGroups;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:15 PM

 */
public class BaseTestGroups extends BaseTest {

    protected static List<TestBugInfo> resultOfTestsGroup = new ArrayList<>();
    protected String resultFolder;
    protected File reportFolder;
    protected StringBuilder reportFileName;
    protected File reportFile;
    protected static String pathToResultsFolder = "migration\\src\\main\\resources\\results\\";
    protected static String agencyName;


    @AfterGroups(groups = "g1")
    public void getResults() {
        for (TestBugInfo testBugInfo: resultOfTestsGroup) {
            System.out.println();
        }
    }

    @BeforeClass
    public void setUp() {

        agencyName = XMLParser.getNewDataSet().getAgency()[0].getAgencyName();
        reportFolder = new File("report".concat(File.separator).concat(agencyName));
        if (!reportFolder.exists())
            reportFolder.mkdir();

        resultFolder = System.getProperty("user.dir").concat("\\").concat("results");

    }

    @BeforeMethod
    public void setReportFile(Method method) {
        reportFileName = new StringBuilder();
        reportFileName.append("report").append(File.separator).append(agencyName).append(File.separator);
        //reportFileName.append(String.format("%1$tY-%1$tm-%1$td %1$tH-%1$tM-%1$tS", new Date())).append(".txt");
       // ng.getMethodName();
        reportFileName.append(String.format("%s ", method.getName()) + String.format("%1$tY-%1$tm-%1$td", new Date())).append(".txt");

        reportFile = new File(reportFileName.toString());

    }

    @AfterMethod
    public void showResult() {
        /*String reason = "";
        String folder = System.getProperty("user.dir");
        folder = folder.concat("\\").concat(pathToResultsFolder).concat("check_date.txt");
        File file = new File((folder));
        if (file.exists()) {
            file.delete();
            file = new File((folder));
        }

        for (TestBugInfo testBugInfo: resultOfTestsGroup) {
            if (testBugInfo.isBug()) {
                reason = "Asset info:\n" + "A4GUID = " + testBugInfo.getA4Id() + "\nUniqueName(clockNumber) = " + testBugInfo.getUniqueName() + "\nA5ID = " + testBugInfo.getA5Id()+"\n";
                reason+="Reasons list:\n";
                for (String partReason: testBugInfo.getReasons()) {
                    reason+= partReason + "\n";
                }
                reason+= "=====================================================================================\n";
            }
            FileManager.saveIntoFile(file.getAbsolutePath(), reason, true);
            System.out.println(reason);
        }
     */
    }
}
