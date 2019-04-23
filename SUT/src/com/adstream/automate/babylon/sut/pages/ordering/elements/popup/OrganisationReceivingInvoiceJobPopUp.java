package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.BaseOrderingPage;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Link;

/*
 * Created by demidovskiy-r on 06.06.2014.
 */
public class OrganisationReceivingInvoiceJobPopUp extends AbstractPopUp {
    public final static String TITLE = "Which Organisation should receive the invoice for this job?";
    public final static String TITLE_NODE = generateTitleNode(TITLE);
    private DojoCombo buList;

    public OrganisationReceivingInvoiceJobPopUp(BaseOrderingPage parentPage, String title) {
        super(parentPage, title);
        this.cancel = new Link(parentPage, generateLocator("+ * [data-id='cancel']"));
        buList = new DojoCombo(parentPage, generateLocator("+ * .dijitComboBox"));
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public void selectInvoiceOnBehalfOfBU(String agencyName) {
        buList.selectByVisibleText(agencyName);
    }
}