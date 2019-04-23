package com.adstream.automate.babylon.sut;

import com.adstream.automate.babylon.sut.pages.PageCreator;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.uimap.UIMap;
import org.apache.log4j.Logger;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 13:17
 */
public class Sut {
    private static Logger log = Logger.getLogger(Sut.class);
    private static Lock webDriverLock = new ReentrantLock();
    private ExtendedWebDriver webDriver;
    private PageNavigator pageNavigator;
    private PageCreator pageCreator;
    private URL siteUrl;
    private ExtendedWebDriver.Browser siteBrowser;
    private String tempFolder;
    private final boolean enableHARFileSupport;
    private Map<String, Object> browserCapabilityMap;

    private UIMap uiMap;

    public Sut(URL siteUrl, ExtendedWebDriver.Browser desiredBrowser, Map<String, Object> browserCapabilitysMap, String tempFolder, boolean enableHARFileSupport) {
        this.siteUrl = siteUrl;
        this.siteBrowser = desiredBrowser;
        this.tempFolder = tempFolder;
        this.enableHARFileSupport = enableHARFileSupport;
        this.browserCapabilityMap = browserCapabilitysMap;
    }

    public void stop() {
        try {
            if(getWebDriver()!=null) {
                getWebDriver().quit();
           }
        }catch(Exception e)
        {log.error("Webdriver quit failed");
            e.printStackTrace();}
    }

    public ExtendedWebDriver getWebDriver() {
        if (webDriver == null) {
            webDriverLock.lock();
            log.info("Starting browser");
            try {
                webDriver = siteBrowser == ExtendedWebDriver.Browser.CUSTOM_REMOTE_BROWSER
                        ? new ExtendedWebDriver(browserCapabilityMap)
                        : new ExtendedWebDriver(siteBrowser, new File(tempFolder), enableHARFileSupport);
            } finally {
                webDriverLock.unlock();
            }
        }
        return webDriver;
    }

    public PageNavigator getPageNavigator() {
        if (pageNavigator == null) {
            pageNavigator = new PageNavigator(getWebDriver(), this.siteUrl);
        }
        return pageNavigator;
    }

    public PageCreator getPageCreator() {
        if (pageCreator == null) {
            pageCreator = new PageCreator(getWebDriver());
        }
        return pageCreator;
    }

    public UIMap getUIMap() {
        if (this.uiMap == null) {
            this.uiMap = new UIMap().load(Sut.class.getResourceAsStream("UIMap.xml"));
        }
        return this.uiMap;
    }

    public String getPageUrl() {
        try {
            URL url = new URL(getWebDriver().getCurrentUrl());
            return url.getPath() + "#" + url.getRef();
        } catch (MalformedURLException e) {
            return "";
        }
    }
}
