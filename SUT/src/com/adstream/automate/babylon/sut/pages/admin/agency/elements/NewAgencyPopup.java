package com.adstream.automate.babylon.sut.pages.admin.agency.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * User: lynda-k
 * Date: 12.06.14
 * Time: 12:33
 */
public class NewAgencyPopup extends EditAgencyPopup {

    public NewAgencyPopup(Page parentPage) {
        super(parentPage);
    }


    public By getCopyFromExistingButFieldLocator() {
        return generateLocator("[class='section pbm mbxs'] [role='combobox']");
    }


    public void fillCopyExistingBUField(String value) {
        Common.sleep(3000);
        super.fillComboboxField(getCopyFromExistingButFieldLocator(), value);

    }



}