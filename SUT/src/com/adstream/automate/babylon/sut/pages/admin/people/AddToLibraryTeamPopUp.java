package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.09.12
 * Time: 8:33
 */
public class AddToLibraryTeamPopUp extends PopUpWindow {
    public Edit teamNameEdit = new Edit(parentPage, generateLocator("[role='textbox']"));
    private By autocompleteLocator = By.cssSelector("[role='option']>.mbxs");

    public AddToLibraryTeamPopUp(Page<? extends Page> parentPage) {
        super(parentPage);
        waitUntilPopUpAppears();
    }

    public AddToLibraryTeamPopUp setTeamName(String teamName) {
        web.waitUntilElementAppearVisible(generateLocator());
        //hack for bug when in drop down is showed only 'create new' variant, no variant for choose early created group(Unfortunately,no time to fix it from dev side )
        teamNameEdit.typeWithInterval(teamName.toString().substring(0, teamName.length() - 1), 100);
        web.sleep(1000);
        web.findElement(By.cssSelector("[role='textbox']")).clear();
        teamNameEdit.typeWithInterval(teamName, 100);
        web.sleep(2000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')]//*[@role='option'][contains(.,'%s')][last()]", teamName)));
        return this;
    }

    public AddToLibraryTeamPopUp inputTeamName(String teamName){
        web.waitUntilElementAppearVisible(generateLocator());
        //Temporary fix for not showing "Create new" in Autocomplete dropdown
        teamNameEdit.typeWithInterval(teamName.toString().substring(0, teamName.length() - 1), 100);
        web.sleep(1000);
        web.findElement(By.cssSelector("[role='textbox']")).clear();
        teamNameEdit.typeWithInterval(teamName, 100);
        web.sleep(2000);
        return this;
    }

    public boolean isCreateNewTeamLinkPresent(String team){
        List<WebElement> autocompleteItems = getAutocompleteItems() ;
        WebElement autocompleteItem = autocompleteItems.get(0);
        return autocompleteItem.getText().equalsIgnoreCase(team + " <- create new");
    }

    public boolean isTeamPresentInTheList(String team){
        boolean isTeamPresent = false;
        List<WebElement> autocompleteItems = getAutocompleteItems();
        end:
        for(WebElement autocompleteItem : autocompleteItems){

            if(autocompleteItem.getText().equalsIgnoreCase(team + "\nusers groups")){
                isTeamPresent = true;
                break end;
            };
        }
        return isTeamPresent;
    }

    public void save() {
        action.click();
        waitUntilPopUpDisappears();
    }

    private List<WebElement> getAutocompleteItems(){
        return web.findElements(autocompleteLocator);
    }

    private void waitUntilPopUpAppears() {
        web.waitUntilElementAppearVisible(generateLocator());
    }

    private void waitUntilPopUpDisappears() {
        web.waitUntilElementDisappear(generateLocator());
    }
}