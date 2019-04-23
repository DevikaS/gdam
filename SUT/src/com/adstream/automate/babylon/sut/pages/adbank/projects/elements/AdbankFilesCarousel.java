package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 26.09.12 11:46
 */
public class AdbankFilesCarousel extends BaseAdBankPage<AdbankFilesCarousel> {
    public AdbankFilesCarousel(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        container = new Control(this, By.cssSelector("[data-dojo-type='common.Carousel']"));
    }

    public void scrollLeft() {
        web.click(By.cssSelector(".left .controller_round"));
        Common.sleep(1000);
    }

    public void scrollRight() {
        web.click(By.cssSelector(".right .controller_round"));
        Common.sleep(1000);
    }

    public int getFilesCount() {
        By locator = By.className("file-item");
        if (!web.isElementPresent(locator))
            return 0;
        return web.findElements(locator).size();
    }

    public int loadAllFiles() {
        int filesCount = getFilesCount();
        boolean done;
        do {
            scrollRight();
            int newFilesCount = getFilesCount();
            done = newFilesCount == filesCount;
            filesCount = newFilesCount;
        } while(!done);
        return filesCount;
    }

    public List<String> getFileNames() {
        return web.findElementsToStrings(By.cssSelector(".file-item .file-info a"));
    }
}
