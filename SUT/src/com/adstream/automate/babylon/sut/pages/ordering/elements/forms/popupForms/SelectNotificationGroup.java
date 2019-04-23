package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.ordering.BaseOrderingPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 05.06.2015.
 */
public class SelectNotificationGroup extends AbstractPopUpLayer {
    private final static String POPUP_NODE = String.format(".b-contactGroups %s", POPUP_ROOT_NODE);
    public final static String ROOT_NODE = POPUP_NODE + " [data-dojo-type='ordering.form.supplyMedia.groupsList']";
    private Edit searchGroups;
    private Checkbox selectNotificationGroup;
    private String groupName;
    protected Button select;

    public SelectNotificationGroup(BaseOrderingPage parent, String groupName) {
        super(parent);
        this.groupName = groupName;
    }

    @Override
    protected void initControls() {
        controls.put("Search Groups", searchGroups = new Edit(parent, generateFormElementLocator("[data-role='searchInput']")));
        controls.put("Group Name", selectNotificationGroup = new Checkbox(parent, generateFormElementLocator(String.format("[value='%s'][name='group']", groupName))));
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppearVisible(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    @Override
    protected String getPopupRootNode() {
        return POPUP_NODE;
    }

    public void select() {
        getDriver().waitUntilElementAppearVisible(By.cssSelector(".b-contactGroups .popupWindow.dijitDialog:not([style*='display: none']) > .windowHead + * .button"));
       clickOkBtn();
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}