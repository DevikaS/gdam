package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUp;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 13.10.2014.
 */
public class AdbankEditAssetsAttachmentPopUp extends AbstractPopUp {
    public final static String TITLE = "Edit attached file";
    public final static String TITLE_NODE = generateTitleNode(TITLE);
    private Edit name;
    private Edit description;

    public AdbankEditAssetsAttachmentPopUp(LibraryAttachmentsList parentPage, String title) {
        super(parentPage, title);
        name = new Edit(parentPage, generateControlLocator("name"));
        description = new Edit(parentPage, generateControlLocator("description"));
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public void fill(String name, String description) {
        fillNameField(name);
        fillDescriptionField(description);
    }

    public void save() {
        clickOkBtn();
    }

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }

    private void fillNameField(String nameValue) {
        name.type(nameValue);
    }

    private void fillDescriptionField(String descriptionValue) {
        description.type(descriptionValue);
    }

    private By generateControlLocator(String partialLocator) {
        return By.cssSelector(generatePopUpElement("[ng-model='attachment.file." + partialLocator + "']", false));
    }
}