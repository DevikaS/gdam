package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created by janaki.kamat on 19/04/2016.
 */
public class Comment extends PopUpWindow {

    private static final By COMMENTFIELDSELECTOR = By.cssSelector("[id='commentMessage']");
    private static final By SAVEBUTTONSELECTOR = By.cssSelector("[ng-click=\"$addCommentCtrl.confirm()\"]");
    private Edit commentField;
    private Button saveButton;

    public Comment(Page parentPage) {
        super(parentPage);
        saveButton = new Button(parentPage,SAVEBUTTONSELECTOR);
        commentField = new Edit(parentPage, COMMENTFIELDSELECTOR);
    }

    public void clickSaveButton(){
        saveButton.click();
    }

    public void addComment(String data){
        commentField.type(data);
        Common.sleep(3000);
        clickSaveButton();
    }
}