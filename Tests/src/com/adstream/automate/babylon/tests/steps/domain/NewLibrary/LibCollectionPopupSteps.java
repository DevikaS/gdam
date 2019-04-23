package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.CollectionType;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibCollectionPopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/**
 * Created by Janaki.Kamat on 13/07/2017.
 */
public class LibCollectionPopupSteps extends LibraryHelperSteps {

    @Given("{I |}added assets to '$collectionType' collection '$toCollection' from collection '$fromCollection'NEWLIB")
    @When("{I |}add assets to '$collectionType' collection '$toCollection' from collection '$fromCollection'NEWLIB")
    public void addAssetsToCollection(String collectionType,String toCollection,String fromCollection){
        LibraryAsset page=null;
        if(collectionType.equalsIgnoreCase(CollectionType.findByType("new").toString())){
          page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(fromCollection));
        }
        else
            page = getSut().getPageCreator().getCollectionFilterPage();
        LibCollectionPopUp popup = page.clickAddToCollection(CollectionType.findByType(collectionType));
        Common.sleep(3000);
        popup.setCollectionName(wrapVariableWithTestSession(toCollection)).clickAction();
    }

    @Then("{I |}'$condition' see warning message '$message' while adding assets to '$collectionType' collection '$toCollection' from collection filter pageNEWLIB")
    public void verifyMessageSubCollection(String condition,String message,String collectionType, String toCollection)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageCreator().getCollectionFilterPage();
        LibCollectionPopUp popup = page.clickAddToCollection(CollectionType.findByType(collectionType));
        popup.setCollectionName(wrapVariableWithTestSession(toCollection)).clickAction();
        boolean actual = popup.verifyMessage(message);
        assertThat(actual, equalTo(shouldState));

    }


    @Then("{I }'$condition' see below agencies in the location dropdown for '$type' collection:$data")
    public void shouldSeeCollectionLocationDropdown(String condition,String type,ExamplesTable filterTable) {
        Boolean should = condition.equalsIgnoreCase("should");
        LibCollectionPopUp popup = getSut().getPageCreator().getLibraryPageNEWLIB("Everything").getCollectionPopup(CollectionType.findByType(type));
        List<String> agencyList = popup.getLocationValues();
        for (int i = 0; i < filterTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filterTable, i);
            assertThat(agencyList, should ? hasItem(row.get("Agency").equalsIgnoreCase("My Collections")?row.get("Agency"):wrapCollectionName(row.get("Agency"))) : not(hasItem(row.get("Agency").equalsIgnoreCase("My Collections")?row.get("Agency"):wrapCollectionName(row.get("Agency")))));
        }
    }

    @Given("{I |}added asset to '$collectionType' collection '$toCollection' from collection '$fromCollection' under Agency '$agencyName'NEWLIB")
    @When("{I |}add asset to '$collectionType' collection '$toCollection' from collection '$fromCollection' under Agency '$agencyName'NEWLIB")
    public void addAssetsToCollectionInAgency(String collectionType, String toCollection, String fromCollection, String agencyName) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(fromCollection);
        Common.sleep(1000);
        LibCollectionPopUp popup = page.clickAddToCollection(CollectionType.findByType(collectionType));
        Common.sleep(1000);
        popup.setCollectionName(wrapVariableWithTestSession(toCollection)).selectCollectionLocation(wrapAgencyName(agencyName)).clickAction();
        Common.sleep(1000);
    }


    @When("{I |}click on add '$collectionType' collection on '$collectionName'NEWLIB")
    public void whenClickOnAddNewCollection(String type,String collectionName) {
        LibraryAsset libPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        libPage.clickAddToCollection(CollectionType.findByType(type));
    }

    @When("I click on '$collectionType' option on the collection filter page")
    public void clickSubCollectionFromFilter(String collectionType) {
        getSut().getPageCreator().getCollectionFilterPage().clickAddToCollection(CollectionType.findByType(collectionType));

    }


    @Given("{I |}type collection name '$collectionName' on opened '$type' collection popupNEWLIB")
    @When("{I |}type collection name '$collectionName' on opened '$type' collection popupNEWLIB")
    public void addToCollectionInAgency(String collectionName,String type) {
        LibCollectionPopUp popup = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).getCollectionPopup(CollectionType.findByType(type));
        popup.typeCollectionName(wrapCollectionName(collectionName));
    }

    @Given("{I |}type collection name '$collectionName' and save on opened '$type' collection popupNEWLIB")
    @When("{I |}type collection name '$collectionName' and save on opened '$type' collection popupNEWLIB")
    public void createCollectionWithSave(String collectionName,String type) {
        LibCollectionPopUp popup = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName)).getCollectionPopup(CollectionType.findByType(type));
        popup.typeCollectionName(wrapCollectionName(collectionName));
        popup.clickAction();
    }

    @Given("{I |}type collection name '$collectionName' and save on opened '$type' collection popup from filter pageNEWLIB")
    @When("{I |}type collection name '$collectionName' and save on opened '$type' collection popup from filter pageNEWLIB")
    public void createCollectionWithSaveFRomFilterPage(String collectionName,String type) {
        LibCollectionPopUp popup = getSut().getPageCreator().getLibraryFilterPage(wrapCollectionName(collectionName)).getCollectionPopup(CollectionType.findByType(type));
        popup.typeCollectionName(wrapCollectionName(collectionName));
        popup.clickAction();
    }


    @Then("{I |}'$condition' see existing collection '$collectionName' in opened dropdown on '$type' collection popupNEWLIB")
    public void shouldSeeExistingCollection(String condition,String collectionName,String type) {
        LibCollectionPopUp popup = getSut().getPageCreator().getLibraryPageNEWLIB("My Assets").getCollectionPopup(CollectionType.findByType(type));
        // TODO method to check the list of existing collections while entering collection name
    }


    @Given("{I |}cancelled assets to '$collectionType' collection '$toCollection' from collection '$fromCollection'NEWLIB")
    @When("{I |}cancel assets to '$collectionType' collection '$toCollection' from collection '$fromCollection'NEWLIB")
    public void cancelAssetsToSubCollection_CollectionPage(String collectionType,String toCollection,String fromCollection){
        LibCollectionPopUp popup = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(fromCollection)).clickAddToCollection(CollectionType.findByType(collectionType));
        Common.sleep(3000);
        popup.setCollectionName(wrapVariableWithTestSession(toCollection)).clickCancel();
    }



    @Then("{I |}'$condition' see warning message '$message' while adding assets to '$collectionType' collection '$toCollection' from collection '$fromCollection' NEWLIB")
    public void verifyMessageForCollection(String condition,String message,String collectionType,String toCollection,String fromCollection)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibCollectionPopUp popup = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(fromCollection)).clickAddToCollection(CollectionType.findByType(collectionType));
        popup.setCollectionName(wrapVariableWithTestSession(toCollection)).clickAction();
        boolean actual = popup.verifyMessage(message);
        assertThat(actual, equalTo(shouldState));

    }

    @Then("{I |}'$condition' see menu option in collection '$collectionName'NEWLIB")
    public void verifyMenuOption(String condition,String collectionName)
    {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean actual = page.isMenuOptionVisible();
        assertThat(actual, equalTo(shouldState));
    }


}
