package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.AdvancedSearchForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.AssignSomeoneToSupplyMediaForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.TransferOrderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.OrderList;
import com.adstream.automate.babylon.sut.pages.ordering.elements.OrderSlider;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.TableFilterSettings;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.DeleteOrderConfirmationPopUp;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.OrganisationReceivingInvoiceJobPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 20.08.13
 * Time: 18:27
 */
public class OrderingPage extends BaseOrderingPage<OrderingPage> {
    private Button createOrderBtn;
    private Button advancedBtn;
    private Button deleteBtn;
    private Button transferBtn;
    private Button assignBtn;
    private Button simpleDropDownBtn;
    private Edit searchOrders;
    private String orderEditPencilIcon="//a[contains(@class,'pencil')]";

    public OrderingPage(ExtendedWebDriver web) {
        super(web);
        createOrderBtn = new Button(this, By.cssSelector("[data-dojo-type='ordering.main.createOrder']"));
        advancedBtn = new Button(this, By.cssSelector("[data-role='advancedSearchLink']"));
        searchOrders = new Edit(this, By.cssSelector("[data-dojo-type='ordering.common.SearchControl'] input"));
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getOrdersContentLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getOrdersContentLocator()));
    }

    public OrderItemPage createOrder() {
        clickCreateOrderBtn();
        return new OrderItemPage(web);
    }

    public OrderItemPage createOrderWithInvoicingOrganisation(String agencyName) {
        OrganisationReceivingInvoiceJobPopUp popUp = getOrganisationReceivingInvoiceJobPopUp();
        popUp.selectInvoiceOnBehalfOfBU(agencyName);
        popUp.clickOkBtn();
        return new OrderItemPage(web);
    }

    public boolean isCreateOrderBtnVisible() {
        return createOrderBtn.isVisible();
    }

    public OrderSlider getOrderSlider() {
        if (!web.isElementVisible(By.className("slider")))
            throw new NoSuchElementException("Order slider is not present on the page!");
        return new OrderSlider(web);
    }

    public OrderList getOrderList() {
        if (!web.isElementVisible(By.className("itemsList")))
            throw new NoSuchElementException("Order list is not present on the page!");
        return new OrderList(web);
    }

    public OrganisationReceivingInvoiceJobPopUp getOrganisationReceivingInvoiceJobPopUp() {
        if (!web.isElementVisible(By.xpath(OrganisationReceivingInvoiceJobPopUp.TITLE_NODE)))
            clickCreateOrderBtn();
        return new OrganisationReceivingInvoiceJobPopUp(this, OrganisationReceivingInvoiceJobPopUp.TITLE);
    }

    public DeleteOrderConfirmationPopUp getDeleteOrderConfirmationPopUp() {
        if (!web.isElementVisible(By.xpath(DeleteOrderConfirmationPopUp.TITLE_NODE)))
            clickDeleteBtn();
        return new DeleteOrderConfirmationPopUp(this, DeleteOrderConfirmationPopUp.TITLE);
    }

    public AdvancedSearchForm getAdvancedSearchForm() {
        if (!web.isElementVisible(By.cssSelector(AdvancedSearchForm.ROOT_NODE)))
            clickAdvancedBtn();
        return new AdvancedSearchForm(this);
    }

    public TransferOrderForm getTransferOrderForm() {
        if (!web.isElementVisible(By.cssSelector(TransferOrderForm.ROOT_NODE)))
            clickTransferBtn();
        return new TransferOrderForm(this);
    }

    public AssignSomeoneToSupplyMediaForm getAssignSomeoneToSupplyMediaForm() {
        if (!isAssignSomeoneToSupplyMediaFormVisible())
            clickAssignBtn();
        return new AssignSomeoneToSupplyMediaForm(this);
    }

    public boolean isAssignSomeoneToSupplyMediaFormVisible() {
        return web.isElementVisible(By.cssSelector(AssignSomeoneToSupplyMediaForm.ROOT_NODE));
    }

    public void search(String value) {
        searchOrders.type(value);
    }

    public TableFilterSettings getTableFilterSettings() {
        if (!web.isElementVisible(By.cssSelector(TableFilterSettings.ROOT_NODE)))
            expandTableFiltersSettings();
        return new TableFilterSettings(this);
    }

    public String getOrdersCounter(){
        return web.findElement(By.cssSelector(".ordersLabel .unit")).getText();
    }

    public boolean isDeleteOrderButtonVisible() {
        return initDeleteBtn().isVisible();
    }

    public boolean isTransferOrderButtonVisible() {
        return initTransferBtn().isVisible();
    }

    public boolean isAssignOrderButtonVisible() {
        return initAssignBtn().isVisible();
    }

    // NGN-16233
    public boolean isOrderEditable() {
        return orderEditLink();
    }

    // NGN-16233
    private boolean orderEditLink() {
        if(web.isElementPresent(By.xpath(orderEditPencilIcon)))
            return true;
        else
            return false;
    }

    // NGN-16233
    public void clickOrderEditIcon(String OrderID)
    {
        String elementLocator="//a[contains(@class,'spriteicon')] [contains(@href,'"+OrderID+"')]";
        if(web.isElementPresent(By.xpath(elementLocator))){
            web.findElement(By.xpath(elementLocator)).click();
        }
    }

    private void clickCreateOrderBtn() {
        createOrderBtn.click();
    }

    private void clickAdvancedBtn() {
        advancedBtn.click();
    }

    private void clickTransferBtn() {
        initTransferBtn().click();
    }

    private void clickDeleteBtn() {
        initDeleteBtn().click();
    }

    private void clickAssignBtn() {
        initAssignBtn().click();
    }

    private void expandTableFiltersSettings() {
        initSimpleDropDownBtn().click();
    }

    private Button initDeleteBtn() {
        if (deleteBtn == null)
            deleteBtn = new Button(this, generateOperationControlsLocator("[data-type='delete']"));
        return deleteBtn;
    }

    private Button initTransferBtn() {
        if (transferBtn == null)
            transferBtn = new Button(this, generateOperationControlsLocator("[data-type='assign']"));
        return transferBtn;
    }

    private Button initSimpleDropDownBtn() {
        if (simpleDropDownBtn == null)
            simpleDropDownBtn = new Button(this, generateOperationControlsLocator("[data-role='dropButton']"));
        return simpleDropDownBtn;
    }

    private Button initAssignBtn() {
        if (assignBtn == null)
            assignBtn = new Button(this, generateOperationControlsLocator("[data-type='assign_upload']"));
        return assignBtn;
    }

    private By getOrdersContentLocator() {
        return By.className("b-orders");
    }

    private By generateOperationControlsLocator(String partialLocator) {
        return By.cssSelector("[data-dojo-type='ordering.main.OperationControls'] " + partialLocator);
    }
}