package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 19.10.12
 * Time: 16:54

 */
public class AdbankFilesAndFoldersSearchResultPage extends AdbankPaginator {
    private List<String> projectsId;
    private List<String> foldersId;
    private List<String> filesId;


    public AdbankFilesAndFoldersSearchResultPage(ExtendedWebDriver web) {
        super(web);
        projectsId = new ArrayList<>();
        foldersId = new ArrayList<>();
        filesId = new ArrayList<>();
    }

    public int getItemsCount() {
        return web.findElementsToStrings(By.cssSelector(".first.vmiddle.link.no-decoration.project_link")).size();
    }

    public List<String> getAllItems() {
        return web.findElementsToStrings(By.cssSelector(".first.vmiddle.link.no-decoration.project_link"));
    }

    public List<String> getProjectsId() {
        return projectsId;
    }

    public List<String> getFoldersId() {
        return foldersId;
    }

    public List<String> getFilesId() {
        return filesId;
    }

    public void parseObjectsList() {
        projectsId.clear();
        foldersId.clear();
        filesId.clear();
        List<WebElement> objectsList = web.findElements(By.cssSelector(".column-2 .project_link"));
        for (WebElement element: objectsList) {
            String href = element.getAttribute("href");
            if (href.contains("/projects")) {
                projectsId.add(getObjectIdFromHref(href, "/projects/"));
            }
            if (href.contains("/folders")) {
                foldersId.add(getObjectIdFromHref(href, "/folders/"));
            }
            if (href.contains("/files")) {
                filesId.add(getObjectIdFromHref(href, "/files/"));
            }
        }
    }

    private String getObjectIdFromHref(String href, String object) {
        String temp = href.split(object)[1];
        return temp.substring(0,temp.indexOf("/"));
    }

    public String getTotalCount(String type) {
        return web.findElement(By.xpath("//span[@data-id='total-count']")).getText();

    }

    public void scrollDownToFooter(int filesCount) {
        long startTime = System.currentTimeMillis();
        boolean isNeedRefresh = true;
        while (web.findElements(By.cssSelector("[data-type='tableRow']")).size() < filesCount) {
            web.scrollToElement(web.findElement(By.cssSelector(".footer.clearfix")));
            web.sleep(2000);
            if (System.currentTimeMillis() - startTime > 60000 && isNeedRefresh) {
                web.navigate().refresh();
                isNeedRefresh = false;
            }
            if (System.currentTimeMillis() - startTime > 120000) {
                throw new Error("Timeout while waiting for scroll to page footer");
            }
        }
    }

    public String getItemCount(){
        return web.findElement(By.xpath("//div[@class='counterItems bold']")).getText();
    }

}
