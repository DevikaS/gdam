package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibChangeMediaPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;

/**
 * Created by Janaki.Kamat on 04/07/2017.
 */
public class LibChangeMediaPopupSteps extends LibraryHelperSteps {

    @Given("{I |}clicked chnage media on '$collection' library page")
    @When("{I |}click change Media on '$collection' library page")
    public LibChangeMediaPopup openChangeMedia(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickChangeMediaButton();
    }

    @Given("{I |}changed media to '$mediaType' on '$collection' library page")
    @When("{I |}change media to '$mediaType'  on '$collection' library page")
    public void changeMedia(String mediaType,String collection) {
        LibChangeMediaPopup libChangeMediaPopup = openChangeMedia(collection);
        Common.sleep(1000);
        libChangeMediaPopup.changeMediaType(mediaType);
        libChangeMediaPopup.clickSave();
    }


    @Then("{I |}should see fields in Change Media Form:$data")
    public void checkLocalisationFields_MultiEdit(ExamplesTable data) {
        Map<String, String> row = parametrizeTabularRow(data);
        LibChangeMediaPopup libChangeMediaPopup = new LibChangeMediaPopup(getSut().getPageCreator().getNewAdbankLibraryPage());
        if (row.containsKey("Media type"))
            assertThat("Media type is not loclised", libChangeMediaPopup.getchangeMedia_Label().equalsIgnoreCase(row.get("Media type")));
        if (row.containsKey("Save"))
            assertThat("Save is not localised", libChangeMediaPopup.getSaveButton_Label().equalsIgnoreCase(row.get("Save")));
        if (row.containsKey("Change Media Title"))
            assertThat("Change Media Title is not localised", libChangeMediaPopup.getChangeMedia_Title().equalsIgnoreCase(row.get("Change Media Title")));
        if (row.containsKey("Cancel"))
            assertThat("Cancel on page is not localised", libChangeMediaPopup.getCancel_Title().equalsIgnoreCase(row.get("Cancel")));
        if (row.containsKey("Are you sure you want to change media type for selected files ?"))
            assertThat("Are you sure you want to change media type for selected files ? is not localised", libChangeMediaPopup.getChangeMedia_Verify().equalsIgnoreCase(row.get("Are you sure you want to change media type for selected files ?")));

    }



}
