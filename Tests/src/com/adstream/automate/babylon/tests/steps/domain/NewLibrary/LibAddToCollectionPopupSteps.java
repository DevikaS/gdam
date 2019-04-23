package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibAddToCollectionPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

/**
 * Created by Janaki.Kamat on 19/09/2017.
 */
public class LibAddToCollectionPopupSteps extends LibraryHelperSteps {

    @Given("{I |}clicked copy to collection from '$collection' library page")
    @When("{I |}click copy to collection from '$collection' library page")
    public LibAddToCollectionPopup openAddToCollection(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickCopyCollectionButton();
    }

    @Given("{I |}copied to '$name' from '$collection' library page")
    @When("{I |}copy to '$name'  from '$collection' library page")
    public void copyToCollection(String name,String collection) {
        Common.sleep(3000);
        LibAddToCollectionPopup libAddToCollectionPopup = openAddToCollection(wrapCollectionName(collection));
        Common.sleep(2000);
        libAddToCollectionPopup.enterCollectionToCopy(wrapCollectionName(name));
        libAddToCollectionPopup.clickAddhere();
    }

    @Then("{I |}'$condition' see that category '$categoryName' available for copy")
    public void shouldSeeCategoryDisabled(String condition,String categoryName){
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibAddToCollectionPopup libAddToCollectionPopup = new LibAddToCollectionPopup(getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName("Everything")));
        assertThat(libAddToCollectionPopup.checkCategoryAvailable(wrapCollectionName(categoryName)),equalTo(shouldState));
    }
}
