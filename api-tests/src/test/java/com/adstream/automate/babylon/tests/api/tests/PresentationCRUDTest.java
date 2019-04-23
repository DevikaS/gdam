package com.adstream.automate.babylon.tests.api.tests;

import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.tests.api.JsonObjectFactory;
import com.adstream.automate.utils.Common;
import org.testng.annotations.Test;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: Ruslan Semerenko
 * Date: 26.01.14 22:33
 */
public class PresentationCRUDTest extends AbstractTest {

    @Test
    public void createPresentationTest() {
        final String PRESENTATION_NAME = "CreatePresentationTest" + getSessionId();

        Reel reel = JsonObjectFactory.getReel();
        reel.setName(PRESENTATION_NAME);
        reel = getDefaultRestService().createReel(reel);
        assertThat("Presentation name", reel.getName(), equalTo(PRESENTATION_NAME));
    }

    @Test
    public void readPresentationTest() {
        final String PRESENTATION_NAME = "ReadPresentationTest" + getSessionId();

        Reel reel = JsonObjectFactory.getReel();
        reel.setName(PRESENTATION_NAME);
        reel = getDefaultRestService().createReel(reel);
        Common.sleep(3000);

        Reel readReel = getDefaultRestService().getReel(reel.getId());
        assertThat("Presentation id", readReel.getId(), equalTo(reel.getId()));
        assertThat("Presentation name", readReel.getName(), equalTo(reel.getName()));
    }

    @Test
    public void updatePresentationTest() {
        final String PRESENTATION_NAME_OLD = "UpdatePresentationTest" + getSessionId();
        final String PRESENTATION_NAME_NEW = "UpdatePresentationTest New" + getSessionId();

        Reel reel = JsonObjectFactory.getReel();
        reel.setName(PRESENTATION_NAME_OLD);
        reel = getDefaultRestService().createReel(reel);
        Common.sleep(3000);

        reel.setName(PRESENTATION_NAME_NEW);
        Reel newReel = getDefaultRestService().getWrappedService().updateReel(reel);
        Common.sleep(3000);
        assertThat("Presentation id", newReel.getId(), equalTo(reel.getId()));
        assertThat("Presentation name", newReel.getName(), equalTo(PRESENTATION_NAME_NEW));

        SearchResult<Reel> reels = getDefaultRestService().findReels(new LuceneSearchingParams());
        List<String> reelsNames = new ArrayList<>();
        for (Reel reelFromSearch : reels.getResult()) {
            reelsNames.add(reelFromSearch.getName());
        }
        assertThat("Old presentation doesn't exist", reelsNames.contains(PRESENTATION_NAME_OLD), is(false));
        assertThat("New presentation is present", reelsNames.contains(PRESENTATION_NAME_NEW), is(true));
    }

    @Test
    public void deletePresentationTest() {
        final String PRESENTATION_NAME = "DeletePresentationTest";

        Reel reel = JsonObjectFactory.getReel();
        reel.setName(PRESENTATION_NAME);
        reel = getDefaultRestService().createReel(reel);
        Common.sleep(3000);

        getDefaultRestService().getWrappedService().deleteReel(reel.getId());
        Common.sleep(3000);

        SearchResult<Reel> reels = getDefaultRestService().findReels(new LuceneSearchingParams());
        List<String> reelsNames = new ArrayList<>();
        for (Reel reelFromSearch : reels.getResult()) {
            reelsNames.add(reelFromSearch.getName());
        }
        assertThat("Presentation doesn't exist", reelsNames.contains(PRESENTATION_NAME), is(false));
    }
}
