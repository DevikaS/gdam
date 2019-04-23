package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.concurrent.TimeUnit;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 31.10.12
 * Time: 17:06
 */
public abstract class AbstractPopUpWindow extends PopUpWindow {
    DojoCombo dojoRole;

    public AbstractPopUpWindow(Page parentPage) {
        super(parentPage);
        dojoRole = new DojoCombo(parentPage, By.cssSelector(".select_roles"));
    }

    public void selectFolder(String path) {
        path = normalizePath(path);
        if (path.isEmpty() || path.equals("/")) {
           // web.findElement(By.cssSelector("a.tree-root")).click();
            web.findElement(By.xpath("//*[@data-dojo-type='adbank.files.copy_folder_tree_item']/div[@class='arrow']")).click();
            return;
        }
        String[] parts;
        WebElement currentNode = web.findElement(By.cssSelector(".tree_head"));
        do {
            parts = path.split("/", 2);
            String locator = String.format("ul/li[div//a[contains(.,'%s')]]", parts[0]);
            currentNode = currentNode.findElement(By.xpath(locator));
            if (parts.length == 2) {
                if (!currentNode.getAttribute("class").contains("active")) {
                    currentNode.findElement(By.className("arrow")).click();
                }
                path = parts[1];
            } else {
                currentNode.findElement(By.xpath(String.format("div//a[contains(.,'%s')]", parts[0]))).click();
            }
        } while (parts.length == 2);
    }

    public void checkUncheckFolderCheckbox(String checkUncheck, String path){
        path = normalizePath(path);
        if (path.isEmpty()) return;
        String[] parts;
        WebElement currentNode = web.findElement(By.cssSelector(".tree_head"));
        do {
            parts = path.split("/", 2);
            String locator = String.format("ul/li[div//a[.='%s']]", parts[0]);
            currentNode = currentNode.findElement(By.xpath(locator));
            if (parts.length == 2) {
                if (!currentNode.getAttribute("class").contains("active"))
                    currentNode.findElement(By.className("arrow")).click();
                path = parts[1];
            } else {
                WebElement checkBox = currentNode.findElement(By.xpath(String.format("div//a[.='%s']/../input", parts[0])));
                if(checkUncheck.equals("check")){
                    if(!checkBox.isSelected()){
                       checkBox.click();
                    }
                }
                else {
                    if(checkBox.isSelected()){
                        checkBox.click();
                    }
                }
            }
        } while (parts.length == 2);
    }

    public void selectRootFolder(String rootFolderName) {
//        web.findElement(By.cssSelector(".tree_head .title-root .fsname")).click();
        String locator = String.format("//a[text()='%s']", rootFolderName);
        web.findElement(By.xpath(locator)).click();
        web.sleep(1000);
    }

    public void selectRole(String role) {
        dojoRole.selectByVisibleText(role);
    }

    public boolean isFolderExists(String path) {
        path = normalizePath(path);
        if (path.isEmpty()) return false;
        String[] parts;
        WebElement currentNode = web.findElement(By.cssSelector(".tree_head"));
        try {
            do {
                turnImplicitlyWaitOff();
                parts = path.split("/", 2);
                String locator = String.format("ul/li[div//a[.='%s']]", parts[0]);
                currentNode = currentNode.findElement(By.xpath(locator));
                if (parts.length == 2) {
                    if (!currentNode.getAttribute("class").contains("active"))
                        currentNode.findElement(By.className("arrow")).click();
                    web.sleep(1000);
                    path = parts[1];
                }
            } while (parts.length == 2);
            turnImplicitlyWaitOn();
        } catch (NoSuchElementException e) {
            e.printStackTrace();
            turnImplicitlyWaitOn();
            return false;
        }
        return true;
    }

    protected String normalizePath(String path) {
        if (path == null) {
            path = "";
        } else {
            path = path.replaceAll("\\s*/+\\s*", "/");
            if (path.endsWith("/")) {
                path = path.substring(0, path.length() - 1);
            }
            if (path.startsWith("/")) {
                path = path.substring(1);
            }
        }
        return path;
    }

    protected void turnImplicitlyWaitOff() {
        web.manage().timeouts().implicitlyWait(0, TimeUnit.MILLISECONDS);
    }

    protected void turnImplicitlyWaitOn() {
        web.manage().timeouts().implicitlyWait(web.getShortTimeoutMS(), TimeUnit.MILLISECONDS);
    }
}
