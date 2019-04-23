package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: Geethanjali.K
 * Date: 27/01/2016
 */
public class ItemAlreadyExistInLibraryPopUp extends PopUpWindow {
    public Button send;
    public Button cancel;

    public ItemAlreadyExistInLibraryPopUp(Page<? extends Page> parentPage) {
        super(parentPage);
        close = new Span(parentPage, generateLocator("[title='Cancel']"));
        send = new Button(parentPage, generateLocator("[data-role='send']"));
        cancel = new Button(parentPage, generateLocator("[name='cancel']"));
    }
   // !--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Starts
    public String warningMessage(){
         return web.findElement(By.cssSelector(".pam")).getText();
    }
    //!--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Ends
}
