package com.adstream.automate.babylon.tests.performance;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import net.lightbody.bmp.core.har.HarEntry;
import net.lightbody.bmp.core.har.HarPage;

import java.net.URL;
import java.util.*;

/**
 * User: ruslan.semerenko
 * Date: 16.07.13 21:07
 */
public abstract class Workflow extends ExtendedWebDriver {
    private BabylonServiceWrapper coreApi;
    private PageNavigator pageNavigator;
    private String login;
    private String password;
    private Map<String, String> cache = new HashMap<>();

    public Workflow(URL baseUrl, URL coreUrl, String login, String password) {
        super(Browser.FIREFOX, null, true);
        coreApi = new BabylonServiceWrapper(new BabylonCoreService(coreUrl), null);
        coreApi.logIn(login, password);
        pageNavigator = new PageNavigator(this, baseUrl);
        this.login = login;
        this.password = password;
    }

    public abstract WorkflowActionStats perform();

    public Map<String, String> getCache() {
        return cache;
    }

    protected void performAction(String name, WorkflowAction action) {
        action.prepare(this);
        getProxyServer().newPage(name);
        action.perform(this);
        waitForPageLoad();
        getProxyServer().endPage();
    }

    protected WorkflowActionStats getStats() {
        WorkflowActionStats stats = new WorkflowActionStats();
        Map<String, List<HarEntry>> entries = new HashMap<>();
        for (HarEntry entry : getProxyServer().getHar().getLog().getEntries()) {
            List<HarEntry> list = entries.get(entry.getPageref());
            if (list == null) {
                list = new ArrayList<>();
                entries.put(entry.getPageref(), list);
            }
            list.add(entry);
        }
        for (HarPage page : getProxyServer().getHar().getLog().getPages()) {
            List<HarEntry> pageEntries = entries.get(page.getId());
            if (pageEntries != null && pageEntries.size() > 0) {
                WorkflowActionPageStats stat = new WorkflowActionPageStats();
                stat.setPage(page.getId());
                stat.setRequestsCount(pageEntries.size());
                stat.setLoadTime(getLoadTime(pageEntries));
                stats.addStats(stat);
            }
        }
        return stats;
    }

    private long getLoadTime(List<HarEntry> entries) {
        long min = Long.MAX_VALUE, max = Long.MIN_VALUE;
        for (HarEntry entry : entries) {
            String url = entry.getRequest().getUrl();
            if (url.contains("SetTimeZoneFromBrowser")
                    || url.contains("notificationsCount")
                    || url.contains("cache.manifest"))
                continue;
            long start = entry.getStartedDateTime().getTime();
            long end = start + entry.getTime();
            min = Math.min(min, start);
            max = Math.max(max, end);
        }
        return max - min;
    }

    protected BabylonServiceWrapper getCoreApi() {
        return coreApi;
    }

    protected PageNavigator getPageNavigator() {
        return pageNavigator;
    }

    protected String getLogin() {
        return login;
    }

    protected String getPassword() {
        return password;
    }

    protected void waitForPageLoad() {
        waitForPageLoad(5000);
    }

    protected void waitForPageLoad(long quiteTimeout) {
        Common.sleep(quiteTimeout);
        String page = null;
        long lastAction = Long.MIN_VALUE;
        do {
            List<HarEntry> entries = getProxyServer().getHar().getLog().getEntries();
            if (page == null) {
                page = entries.get(entries.size() - 1).getPageref();
            }
            int i = entries.size() - 1;
            while (i >= 0 && entries.get(i).getPageref().equals(page)) {
                long time = entries.get(i).getStartedDateTime().getTime() + entries.get(i).getTime();
                if (time > lastAction) {
                    lastAction = time;
                }
                i--;
            }
            Common.sleep(1000);
        } while (System.currentTimeMillis() - lastAction < quiteTimeout);
    }
}
