package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 31.08.12
 * Time: 15:51
 */
public class SelectFolderRestorePopUpWindow extends AbstractPopUpWindow {
    public SelectFolderRestorePopUpWindow(Page parentPage){
        super(parentPage);
    }

    public void selectFolder(String path) {
        if (path.isEmpty()) return;
        if (!path.equals("Root folder")) {
            path = normalizePath(path);
        }
        String[] parts;
        WebElement currentNode = web.findElement(generateLocator(".folders_tree"));
        do {
            parts = path.split("/", 2);
            String locator = String.format("//ul//span[@class='folder-name']/span[.='%s']/ancestor::li[1]", parts[0]);
            currentNode = currentNode.findElement(By.xpath(locator));
            if (parts.length == 2) {
                if (!currentNode.getAttribute("class").contains("active"))
                    currentNode.findElement(By.className("arrow")).click();
                path = parts[1];
            } else {
                long end = System.currentTimeMillis() + 15000; // 15 seconds
                do {
                    Common.sleep(1000);
                    web.findElement(By.xpath(String.format("//ul//span[@class='folder-name']/span[.='%s']/ancestor::li[1]/div[2]", parts[0]))).click();
                    if (System.currentTimeMillis() > end)
                        throw new RuntimeException("Could not select folder");
                } while (!currentNode.getAttribute("class").contains("current"));
            }
        } while (parts.length == 2);
    }

    public boolean isFolderExists(String path) {
        if (path.isEmpty()) return false;
        if (!path.equals("Root folder")) {
            path = normalizePath(path);
        }
        String[] parts;
        WebElement currentNode = web.findElement(generateLocator(".folders_tree"));
        try {
            do {
                turnImplicitlyWaitOff();
                parts = path.split("/", 2);
                String locator;
                if (path.equals("Root folder")) {
                    locator  = String.format("//ul//span[@class='folder-name']/span[.='%s']/ancestor::div[contains(@class,'title')]", parts[0]);
                } else {
                    locator  = String.format("//ul//span[@class='folder-name']/span[.='%s']/ancestor::li[1]", parts[0]);
                }
                currentNode = currentNode.findElement(By.xpath(locator));
                if (parts.length == 2) {
                    if (!currentNode.getAttribute("class").contains("current"))
                        currentNode.findElement(By.className("arrow")).click();
                    path = parts[1];
                }
            } while (parts.length == 2);
            turnImplicitlyWaitOn();
        } catch (NoSuchElementException e) {
            //e.printStackTrace();
            turnImplicitlyWaitOn();
            return false;
        }
        return true;
    }
}
