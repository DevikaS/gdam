package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewPage;
import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewInfoPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 17.09.12
 * Time: 15:04
 */
public abstract class AbstractPreviewSteps extends BaseStep {
    protected abstract FilePreviewPage getPreviewPage();
    protected abstract FilePreviewInfoPage getPreviewInfoPage();

    protected void downloadOriginalFile() {
        getPreviewPage().triggerDownloadOriginalEventWithoutDownloading();
    }

    protected void downloadProxyFile() {
        getPreviewPage().triggerDownloadProxyEventWithoutDownloading();
    }

    protected void checkThatPreviewPageOpened(boolean expectedState) {
        boolean actualState = true;
        try {
            getPreviewPage();
        } catch (Exception e) {
            actualState = false;
        } finally {
            assertThat(actualState, is(expectedState));
        }
    }

    protected void checkThatEditLinkPresent(boolean expectedState) {
        assertThat(getPreviewInfoPage().isEditButtonVisible(), is(expectedState));
    }

    protected void checkThatDownloadOriginalButtonPresent(boolean expectedState) {
        assertThat(getPreviewPage().isDownloadOriginalButtonVisible(), is(expectedState));
    }

    public void checkThatDownloadProxyButtonPresent(boolean expectedState) {
        assertThat(getPreviewPage().isDownloadProxyButtonVisible(), equalTo(expectedState));
    }

    protected void checkTabPresence(boolean shouldState, String tabNames) {
        List<String> actualTabNames = getPreviewPage().getTabNames();

        for (String expectedTabName : tabNames.split(","))
            assertThat(actualTabNames, shouldState ? hasItem(expectedTabName) : not(hasItem(expectedTabName)));
    }
}