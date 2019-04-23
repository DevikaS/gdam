package com.publicApi.tests.testsBase;

import com.publicApi.Listners.Retry;
import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.utilities.HttpCalls;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.testng.ITestContext;
import org.testng.ITestNGListener;
import com.publicApi.jsonPayLoads.GsonClasses.*;
import com.relevantcodes.extentreports.ExtentReports;
import com.relevantcodes.extentreports.ExtentTest;
import com.relevantcodes.extentreports.LogStatus;
/*import org.apache.http.util.EntityUtils;
import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.Logger;
import org.openqa.selenium.Platform;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;*/
import org.testng.*;
import org.testng.annotations.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

public class BaseTests implements ITestNGListener {

    public static ExtentReports extent;
    public static ExtentTest logger;
    ITestResult result;

     @AfterSuite
    public void endReport(){
         extent.close();
    }

    public List<String> actual_list;
    public List<String> expected_list;

    public HeadlessAPICalls apiCall;
    public BaseOfBase responsePayLoad;
    public HttpCalls coreService;

    private static String baseURL;
/*    private String hub_HostName;
    private String portNo;

    private static WebDriver driver;*/
    private static Properties prop;
    public Logger loggerTestLevel;


    public BaseTests(){
        super();
        loggerTestLevel = Logger.getLogger(this.getClass());
        PropertyConfigurator.configure("Log4j.properties");

        actual_list = new ArrayList<>();
        expected_list = new ArrayList<>();

        // Read Command line arguments
  //      setHub_HostName(System.getProperty("gridURL"));
  //      setPortNo(System.getProperty("gridPort"));
        setBaseURL(System.getProperty("autTestURL"));

        try {
            setProp(new Properties());
           // InputStream input = getClass().getClassLoader().getResourceAsStream("Environment.properties"); // Removing class loader loading to run globally
            getProp().load(new FileInputStream(System.getProperty("user.dir")+"//src//test//resources//Environment.properties"));
        } catch(Exception e){e.printStackTrace();}
    }

    @BeforeSuite
    public void envDetails(ITestContext context){
        if(context.getSuite().getName().equalsIgnoreCase("CommonForRun Scenarios")){
            extent = new ExtentReports (System.getProperty("user.dir") +"/target/PublicAPIExtentReport.html", true);
        }else {
            extent = new ExtentReports(System.getProperty("user.dir") + "/target/PublicAPIExtentReport.html", false);
        }
        extent.addSystemInfo("Host Name", getBaseURL());
        extent.loadConfig(new File(System.getProperty("user.dir")+"//extent-config.xml"));

    }

    @BeforeClass
    public void setUp() {
        /*try {*/
            System.out.println("=============================== " +
                    this.getClass().getSimpleName().toUpperCase() + ": End Point Start===============================");

          /*  switch (prop.getProperty("BROWSER_NAME")) {
                case "remoteFirefox":
                    DesiredCapabilities capability = new DesiredCapabilities().firefox();
                    capability.setBrowserName("firefox");
              //      capability.setPlatform(Platform.WINDOWS);
                    capability.setPlatform(Platform.LINUX);
                    driver = new RemoteWebDriver(new
                            URL("http://" + getHub_HostName() + ":" + getPortNo() + "/wd/hub"), capability);
                    break;

                default:
                    FirefoxProfile user_pref = new FirefoxProfile();
                    user_pref.setPreference("browser.cache.disk.enable", false);
                    user_pref.setPreference("browser.cache.memory.enable", false);
                    user_pref.setPreference("browser.cache.offline.enable", false);
                    user_pref.setPreference("network.http.use-cache", false);
                    setDriver(new FirefoxDriver(user_pref));
                    break;
            }

            getDriver().manage().window().maximize();
            getDriver().manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);

            setProp(prop);*/

        /*} catch (Exception e){ e.printStackTrace();}*/
    }

    @AfterClass
    public void cleanUp() throws IOException{
        /*if(getDriver()!=null){
            getDriver().close();
        }
        getDriver().quit();*/
        System.out.println("=============================== "+this.getClass().getSimpleName().toUpperCase()+": End Point Complete===============================");
        System.out.println("\n\n");
    }

    @BeforeMethod
    public void testStarting(Method testName){
        System.out.println("\n                   ----- Start of Test: "+testName.getName().toUpperCase()+" -----         ");
        logger = extent.startTest(testName.getName());
    }

    @AfterMethod
    public void endOfEachTest(Method testName){
        System.out.println("                   ----- End of Test: "+testName.getName().toUpperCase()+"-----         \n");

    }

    @AfterMethod
    public void getResult(ITestResult result){
        if(result.getStatus() == ITestResult.FAILURE){
            logger.log(LogStatus.FAIL, "Test Case Failed is "+result.getName());
            logger.log(LogStatus.FAIL, "Failed Because of "+result.getThrowable());
        }else if(result.getStatus() == ITestResult.SKIP){
            logger.log(LogStatus.SKIP, "Test Case Skipped is "+result.getName());
            throw new SkipException("Skipping - This is not ready for testing ");
        }else if(result.getStatus() == ITestResult.SUCCESS){
            logger.log(LogStatus.PASS, "Test Case Passed is "+result.getName());
        }
        extent.flush();
        extent.endTest(logger);
    }

    protected void waitFor(long ms) {
        try { Thread.sleep(ms); }
        catch(InterruptedException e) { e.printStackTrace(); }
    }

/*
    public static WebDriver getDriver() {
        return driver;
    }

    private void setDriver(WebDriver driver) {
        this.driver = driver;
    }
*/

    public static Properties getProp() {
        return prop;
    }

    private void setProp(Properties prop) {
        this.prop = prop;
    }

    public static String getBaseURL() {
        return baseURL;
    }

    private void setBaseURL(String baseURL) {
        this.baseURL = baseURL;
    }

    /*private String getHub_HostName() {
        return hub_HostName;
    }

    private void setHub_HostName(String hub_HostName) {
        this.hub_HostName = hub_HostName;
    }

    private String getPortNo() {
        return portNo;
    }

    private void setPortNo(String portNo) {
        this.portNo = portNo;
    }*/
}