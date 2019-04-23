package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.EditFilePopup;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;

import java.util.List;

public class AdbankBatchEditFilePopUp extends EditFilePopup {
    public AdbankBatchEditFilePopUp(Page parentPage) {
        super(parentPage);
        action = new Button(parentPage, generateLocator(".button[data-role='save']"));
    }

    public void openTabOnAdbankBatchEditFilePopUp(String value){
        if(!web.findElement(generateLocator("a[data-role='" + value + "']")).getAttribute("class").equals("active")){
            web.findElement(generateLocator("a[data-role='" + value + "']")).click();
            web.waitUntilElementAppearVisible(By.cssSelector("div[data-role='schemedContent']"));
        }
    }

    public void fillEditFilePopup(List<MetadataItem> fields) {
        for (MetadataItem field : fields){
                fillFieldByName(field.getKey(), field.getValue(), field.getSection());
        }

    }


}
