package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

/**
 * Created by Janaki.Kamat on 07/04/2017.
 */
public class LibDownLoadPopup extends LibPopUpWindow {
    private static final String downloadTitleLocator="[translate=\"DOWNLOAD_TITLE_NAME\"]";
    private static final String  downloadMasterLocator="//*[contains(@ng-show,\"$ctrl.allowMaster\")]/ads-md-checkbox/md-checkbox";
    private static final String  downloadProxyLocator="//*[contains(@ng-show,\"$ctrl.allowProxy\")]/ads-md-checkbox/md-checkbox";
    private static final String downloadButtonLocator="ads-md-button[click=\"$ctrl.download()\"] button";
    private static final String downloadSendPlusButtonLocator="ads-md-button[click=\"$ctrl.downloadOnSendplus()\"]";
    private Span downloadTitleSpan;
    private MdCheckbox masterDownloadCheckbox;
    private MdCheckbox proxyDownloadCheckbox;
    private Button sendPlusDownloadButton;
    private Button downloadButtonButton;

    public LibDownLoadPopup(Page parentPage) {
        super(parentPage,"ads-ui-download");
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(generateLocator()));
        initialize();
    }


    private void initialize(){
        downloadTitleSpan=new Span(parentPage,generateLocator(downloadTitleLocator));
        downloadButtonButton=new Button(parentPage,generateLocator(downloadButtonLocator));
        sendPlusDownloadButton=new Button(parentPage,generateLocator(downloadSendPlusButtonLocator));
    }

    public void selectDownloadMaster(){
        new MdCheckbox(parentPage,generateXpathLocator(downloadMasterLocator)).selectBylocator();
    }

    public void selectDownloadProxy(){
        new MdCheckbox(parentPage,generateXpathLocator(downloadProxyLocator)).selectBylocator();
    }

    public void clicksendPlusDownload(){
        sendPlusDownloadButton.click();
    }

    public void clickDownloadButton(){
        downloadButtonButton.click();
       // web.waitUntil(ExpectedConditions.invisibilityOfElementLocated(generateLocator()));
    }

    public boolean isMasterDownloadVisible(){
       return new MdCheckbox(parentPage,generateXpathLocator(downloadMasterLocator)).isVisible();
    }
    public boolean isDownloadSendplusButtonVisible(){
        return web.isElementVisible(By.cssSelector(downloadSendPlusButtonLocator));
    }

    public boolean isProxyDownloadVisible(){
        return new MdCheckbox(parentPage,generateXpathLocator(downloadProxyLocator)).isVisible();
    }
}

