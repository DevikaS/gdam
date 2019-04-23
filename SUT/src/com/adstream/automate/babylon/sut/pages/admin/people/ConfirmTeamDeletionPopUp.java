package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: sadikov-o
 * Date: 2/13/13
 * Time: 1:15 PM
 * To change this template use File | Settings | File Templates.
 */
public class ConfirmTeamDeletionPopUp extends PopUpWindow {

    public ConfirmTeamDeletionPopUp(Page<? extends Page> parentPage) {
        super(parentPage);
    }

    public UsersPage confirmDeletion(){
        web.click(By.xpath("//button[contains(@class,'confirm button')]"));
        return new UsersPage(web);
    }
}
