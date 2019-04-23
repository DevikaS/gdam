package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 29.08.12
 * Time: 12:39

 */
public class AdbankTemplateFromProjectCreatePage extends AdbankTemplatesCreatePage {
    public Checkbox includeFolders;
    public Checkbox includeTeam;

    public AdbankTemplateFromProjectCreatePage(ExtendedWebDriver web) {
        super(web);
        includeFolders = new Checkbox(this, By.name("cloneFolders"));
        includeTeam = new Checkbox(this, By.name("cloneTeam"));
    }
}
