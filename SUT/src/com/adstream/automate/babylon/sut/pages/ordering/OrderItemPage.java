package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.*;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.TransferOrderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.*;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.*;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.util.*;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 20.08.13
 * Time: 19:48
 */
public class OrderItemPage extends BaseOrderingPage<OrderItemPage> {
    private Button backBtn;
    private Button addCommercialBtn;
    private Button onHoldBtn;
    private Button createNewCommercialBtn;
    private Button copyExistingCommercialBtn;
    private Button qcIngestBtn;
    private Button saveAsDraftBtn;
    private Button transferOrderBtn;
    private Button proceedBtn;
    private Link editOnBehalfOfBuBtn;
    private String invoicingOrganisation;
    private String onBehalfOfBU;
    private String onBehalfOfBUWarningMessage;
    private final static String addMediaSectionProps = "mediaBlock";
    private final static String addInformationSectionProps = "informationBlock";
    private final static String additionalInformationSectionProps = "availableFieldsBlock";
    private final static String addUsageRightsSectionProps = "usageRightsBlock";
    private final static String selectBroadcastDestinationSectionProps = "destinationsBlock";
    private final static String additionalServicesProps = "servicesBlock";
    private final static String coverFlowItemRoot = ".carousel-item";
    private final static String warningIconRoot = ".spriteicon.i24x24_warning:not([class*='hidden'])";
    private final static String successIconRoot = ".spriteicon.i24x24_proceed:not([class*='hidden'])";

    public OrderItemPage(ExtendedWebDriver web) {
        super(web);
        backBtn = new Button(this, By.className("back"));
        addCommercialBtn = new Button(this, By.className("addCommercialButton"));
        createNewCommercialBtn = new Button(this, generateElementLocatorByDataRole("createBtn"));
        copyExistingCommercialBtn = new Button(this, generateElementLocatorByDataRole("copyBtn"));
        qcIngestBtn = new Button(this, By.className("qcIngestButton"));
        saveAsDraftBtn = new Button(this, generateElementLocatorByDataRole("saveAsDraft"));
        transferOrderBtn = new Button(this, generateElementLocatorByDataRole("transferOrder"));
        proceedBtn = new Button(this, generateElementLocatorByDataRole("proceedButton"));
        editOnBehalfOfBuBtn = new Link(this, generateElementLocatorByDataRole("editBUIcon"));
        onHoldBtn = new Button(this,By.cssSelector("[data-role='holdForApprovalBtn']"));
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getOrderItemPageLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getOrderItemPageLocator()));
    }

    public OrderingPage back() {
        backBtn.click();
        return new OrderingPage(web);
    }

    public boolean isBackButtonVisible() {
        return backBtn.isVisible();
    }

    public boolean isTitleVisible() {
        return web.isElementVisible(getTitleLocator());
    }

    public String getTitle() {
        return web.findElement(getTitleLocator()).getText();
    }

    public static class CoverFlowItem extends PageElement<OrderItemPage> {
        private String counterContainer;
        private WebElement deleteBtn;
        private String carouselItemImg;
        private String mediaText;
        private String coverTitle;
        private String clockNumber;
        private String duration;
        private String title;
        private WebElement holdBtn;
        private WebElement heldBtn;
        private String aspectRatio;
        private String format;
        private String rootNodeLocator;
        private WebElement cover;
        private List<WebElement> formFields;

        public CoverFlowItem(ExtendedWebDriver web, WebElement cover, String rootNodeLocator, OrderItemPage parent ) {
            super(web, parent);
            this.rootNodeLocator = rootNodeLocator;
            this.cover = cover;
            this.formFields = cover.findElements(By.cssSelector(".form_field .value"));
            counterContainer = cover.findElement(By.cssSelector("[data-role='counter-container']")).getText();
            carouselItemImg = cover.findElement(By.cssSelector(".carousel-item-img + img")).getAttribute("src");
            mediaText = cover.findElement(By.className("mediaText")).getText().replaceAll("\n", " ");
            coverTitle = cover.findElement(By.className("assetName")).getAttribute("title");
            clockNumber = formFields.get(formFields.size() - 1).getText();
            title = formFields.get(0).getText();
            aspectRatio = cover.findElement(By.className("info-hdmark")).getText();
            format = cover.findElement(By.cssSelector("[class*='logo']")).getAttribute("class");
            holdBtn = cover.findElement(By.className("hold-btn"));
            heldBtn = cover.findElement(By.cssSelector("[data-role='releaseDestinationsBtn']"));

        }

        public String getCounterContainer() {
            return counterContainer;
        }

        public String getMediaText() {
            return mediaText;
        }

        public String getCoverTitle() {
            return coverTitle;
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getDuration() {
            if (duration == null)
                duration = formFields.get(1).getText();
            return duration;
        }

        public String getTitle() {
            return title;
        }

        public String getAspectRatio() {
            return aspectRatio;
        }

        public String getFormat() {
            return format;
        }

        public String getCarouselItemImg() {
            return carouselItemImg;
        }

        public void holdForApproval() {
            if (!isHeldForApproval()) {
                clickHoldBtn();
                ExpectedConditions.stalenessOf(holdBtn);
            }
        }

        public boolean isHeldForApproval() {
            //return holdBtn.getAttribute("class").contains("unset_on_hold");
           // return heldBtn.getAttribute("class").contains("unset_on_hold");
            web.scrollToElement(cover.findElement(By.cssSelector("[data-role='releaseDestinationsBtn']")));
            WebElement held=cover.findElement(By.cssSelector("[data-role='releaseDestinationsBtn']"));
            return !held.getAttribute("class").contains("hide");

        }

        public void clickHeldForApprovalButtonOnOrderItemPageUi(){
            web.waitUntilElementAppearVisible(By.cssSelector(".mts.hold-btn.button.unit-right.unset_on_hold[data-role='releaseDestinationsBtn']"));
            heldBtn.click();
        }

        public boolean isHoldForApprovalEnabled() {
            return !holdBtn.getAttribute("class").contains("disabled");
        }

        public DeleteOrderItemFromCoverFlowPopUp getDeleteOrderItemPopUp() {
            if (!web.isElementVisible(By.xpath(DeleteOrderItemFromCoverFlowPopUp.TITLE_NODE)))
                clickCrossBtn();
            return new DeleteOrderItemFromCoverFlowPopUp(parent, DeleteOrderItemFromCoverFlowPopUp.TITLE);
        }

        public boolean isCrossBtnVisible() {
            return web.isElementVisible(generateCrossBtnLocator());
        }

        public boolean isWarningIconVisible() {
            return web.isElementVisible(generateIconLocator(warningIconRoot));
        }

        public boolean isSuccessIconVisible() {
            return web.isElementVisible(generateIconLocator(successIconRoot));
        }

        private void clickCrossBtn() {
            if (deleteBtn == null)
                deleteBtn = cover.findElement(By.cssSelector("[data-action='onDeleteSlide']"));
            deleteBtn.click();
        }

        private void clickHoldBtn() {
            holdBtn.click();
        }

        private By generateCrossBtnLocator() {
            return By.cssSelector(rootNodeLocator + " " + "[data-action='onDeleteSlide']");
        }

        private By generateIconLocator(String partialLocator) {
            return By.cssSelector(rootNodeLocator + " " + partialLocator);
        }
    }

    public CoverFlowItem getActiveCoverFlowItem() {
        if (!web.isElementVisible(getActiveCoverFlowItemLocator()))
            throw new NoSuchElementException("Not present carousel item on order item page!");
        WebElement cover = web.findElement(getActiveCoverFlowItemLocator());
        return new CoverFlowItem(web, cover, getActiveCoverFlowItemRootNode(), this);
    }

    public CoverFlowItem getCoverFlowItemById(String orderItemId) {
        if (!web.isElementVisible(getCoverFlowItemByIdLocator(orderItemId)))
            throw new NoSuchElementException("Not present carousel item  with id: " + orderItemId + " on order item page!");
        WebElement cover = web.findElement(getCoverFlowItemByIdLocator(orderItemId));
        return new CoverFlowItem(web, cover, getCoverFlowItemByIdRootNode(orderItemId), this);
    }

    public CoverFlowItem selectCoverFlowItemById(String orderItemId) {
        if (!web.isElementVisible(getCoverFlowItemByIdLocator(orderItemId)))
            throw new NoSuchElementException("Not present carousel item  with id: " + orderItemId + " on order item page!");
        selectOrderItemInCoverFlowById(orderItemId);
        WebElement cover = web.findElement(getCoverFlowItemByIdLocator(orderItemId));
        return new CoverFlowItem(web, cover, getCoverFlowItemByIdRootNode(orderItemId), this);
    }

    public List<String> getVisibleCoverFlowItemClockNumbers() {
        if (!web.isElementVisible(getCoverFlowItemLocator()))
            throw new NoSuchElementException("Not present carousel item on order item page!");
        List<String> clockNumbers  = new ArrayList<String>();
        List<WebElement> covers = web.findElements(getCoverFlowItemLocator());
        List<CoverFlowItem> coverFlowItems = new ArrayList<CoverFlowItem>();
        for (WebElement cover : covers)
            coverFlowItems.add(new CoverFlowItem(web, cover, getCoverFlowItemRootNode(), this));
        for (CoverFlowItem coverFlowItem : coverFlowItems)
            clockNumbers.add(coverFlowItem.getClockNumber());
        return clockNumbers;
    }

    public boolean isCoverFlowItemPreviewVisible(String contentId) {
        return getActiveCoverFlowItem().getCarouselItemImg().contains(contentId);
    }

    public int getCountCoverFlowItems() {
        return web.findElements(getCoverFlowItemLocator()).size();
    }

    public OrderItemPage copyExistingCommercial() {
        web.clickThroughJavascript(copyExistingCommercialBtn.getLocator());
        web.sleep(1000);
        return new OrderItemPage(web);
    }

    public OrderItemPage createNewCommercial() {
        web.clickThroughJavascript(createNewCommercialBtn.getLocator());
        web.sleep(1000);
        return new OrderItemPage(web);
    }

    public boolean isAddCommercialButtonVisible(){
        return addCommercialBtn.isVisible();
    }

    public boolean isOnHoldVisible(){
        return onHoldBtn.isVisible();
    }

    public OrderItemPage selectOrderItemInCoverFlowById(String orderItemId) {
        if (!web.getCurrentUrl().contains(orderItemId)) {
            web.clickThroughJavascript(getCoverFlowItemByIdLocator(orderItemId));
            waitUntilURLChanged(orderItemId);
        }
        return new OrderItemPage(web);
    }

    public SelectMarketPopUp getSelectedMarketPopUp() {
        if (!web.isElementVisible(By.xpath(SelectMarketPopUp.TITLE_NODE)))
            clickIconMarket();
        return new SelectMarketPopUp(this, SelectMarketPopUp.TITLE);
    }

    public String getSelectedMarket() {
        return web.findElement(getSelectedMarketLocator()).getAttribute("class");
    }

    public CommonInformationForm getCommonInformationForm() {
        if (!isCommonInformationSectionExpanded())
            throw new NoSuchElementException("There is no Common Information section on the page!");
        return new CommonInformationForm(this);
    }

    public AddMediaToOrderForm getAddMediaToOrderForm() {
        if (!isAddMediaSectionExpanded())
            expandSection(Section.AddMedia);
        return new AddMediaToOrderForm(this);
    }

    public AddInformationForm getAddInformationForm() {
        if (!isAddInformationSectionExpanded())
            expandSection(Section.AddInformation);
        return new AddInformationForm(this);
    }

    public AdditionalInformationForm getAdditionalInformationForm() {
        if (!isAdditionalInformationSectionExpanded())
            expandSection(Section.AdditionalInformation);
        return new AdditionalInformationForm(this);
    }

    public UsageRightSelectorForm getUsageRightSelectorForm() {
        if (!isUsageRightsSectionExpanded())
            expandSection(Section.UsageRights);
        return new UsageRightSelectorForm(this);
    }

    public AddUsageRightForm getAddUsageRightForm(String usageType) {
        if (!web.isElementVisible(By.cssSelector(AddUsageRightForm.ROOT_NODE))) {
            UsageRightSelectorForm form = getUsageRightSelectorForm();
            Map<String, String> row = new HashMap<>();
            row.put("Usage Type", usageType);
            form.fill(row);
            return form.getAddUsageRightForm();
        }
        return new AddUsageRightForm(this);
    }

    public BroadcastDestinationForm getBroadcastDestinationForm() {
        if (!isSelectBroadcastDestinationsSectionExpanded()) {
            expandSection(Section.SelectBroadcastDestinations);
            web.sleep(2000);
        }
        return new BroadcastDestinationForm(this);
    }

    public boolean isTranslatedSelectDestination(String translatedTitle) {
        return(translatedTitle.equalsIgnoreCase(getTranslatedSelectDestination()));
    }

    public AdditionalServiceForm getAdditionalServiceForm() {
        if (!isAdditionalServiceSectionExpanded())
            expandSection(Section.AdditionalServices);
        return new AdditionalServiceForm(this);
    }

    public void expandSection(String sectionName) {
        expandSection(Section.findByName(sectionName));
    }

    public void expandSection(Section section) {
        switch (section) {
            case AddMedia: expandSectionByProps(addMediaSectionProps); break;
            case AddInformation: expandSectionByProps(addInformationSectionProps); break;
            case AdditionalInformation: expandSectionByProps(additionalInformationSectionProps); break;
            case UsageRights: expandSectionByProps(addUsageRightsSectionProps); break;
            case SelectBroadcastDestinations: expandSectionByProps(selectBroadcastDestinationSectionProps); break;
            case AdditionalServices: expandSectionByProps(additionalServicesProps); break;
            default: throw new IllegalArgumentException("Unknown section: " + section.toString());
        }
    }

    public boolean isSectionExpanded(String sectionName) {
        Section section = Section.findByName(sectionName);
        switch (section) {
            case AddMedia: return isAddMediaSectionExpanded();
            case AddInformation: return isAddInformationSectionExpanded();
            case AdditionalInformation: return isAdditionalInformationSectionExpanded();
            case UsageRights: return isUsageRightsSectionExpanded();
            case SelectBroadcastDestinations: return isSelectBroadcastDestinationsSectionExpanded();
            case AdditionalServices: return isAdditionalServiceSectionExpanded();
            default: throw new IllegalArgumentException("Unknown section: " + section);
        }
    }

    public boolean isSectionVisible(String sectionName) {
        Section section = Section.findByName(sectionName);
        switch (section) {
            case CommonInformation: return isCommonInformationSectionExpanded();
            case AddMedia: return isSectionVisibleByProps(addMediaSectionProps);
            case AddInformation: return isSectionVisibleByProps(addInformationSectionProps);
            case AdditionalInformation: return isSectionVisibleByProps(additionalInformationSectionProps);
            case UsageRights: return isSectionVisibleByProps(addUsageRightsSectionProps);
            case SelectBroadcastDestinations: return isSectionVisibleByProps(selectBroadcastDestinationSectionProps);
            case AdditionalServices: return isSectionVisibleByProps(additionalServicesProps);
            default: throw new IllegalArgumentException("Unknown section: " + section);
        }
    }

    public boolean isWarningIconVisibleNextSection(String sectionName) {
        Section section = Section.findByName(sectionName);
        switch (section) {
            case AddMedia: return isWarningIconVisibleNextSectionByProps(addMediaSectionProps);
            case AddInformation: return isWarningIconVisibleNextSectionByProps(addInformationSectionProps);
            case AdditionalInformation: return isWarningIconVisibleNextSectionByProps(additionalInformationSectionProps);
            case UsageRights: return isWarningIconVisibleNextSectionByProps(addUsageRightsSectionProps);
            case SelectBroadcastDestinations: return isWarningIconVisibleNextSectionByProps(selectBroadcastDestinationSectionProps);
            case AdditionalServices: return isWarningIconVisibleNextSectionByProps(additionalServicesProps);
            default: throw new IllegalArgumentException("Unknown section: " + section);
        }
    }

    public String getWarningMessageNextSection(String sectionName) {
        forceWarningTooltipForSection(sectionName);
        ExpectedConditions.presenceOfElementLocated(getDijitTooltipContainer());
        return web.findElement(getDijitTooltipContainer()).getText();
    }

    public boolean isCopyToAllVisibleNextToSection(String sectionName) {
        return isCopyToAllVisibleForSection(Section.findByName(sectionName));
    }

    public CopyToAllConfirmationPopUp getCopyToAllPopUpForSection(String sectionName) {
        return getCopyToAllConfirmationPopUpBySection(Section.findByName(sectionName));
    }

    public ClearSectionConfirmationPopUp getClearActionPopUpForSection(String sectionName) {
        return getClearActionConfirmationPopUpBySection(Section.findByName(sectionName));
    }

    public BSkyBConfirmationPopUp getBSkyBConfirmPopUp() {
        return new BSkyBConfirmationPopUp(this, BSkyBConfirmationPopUp.TITLE);
    }

    public boolean isBSkyBConfirmPopUpVisible() {
        return getDriver().isElementVisible(By.xpath(BSkyBConfirmationPopUp.TITLE_NODE));
    }

    public String warningMessageDeliveryAccessRuleBuilderFields(String fieldName) {
        getDriver().findElement(By.xpath("//div[@class='clearfix header-content relative']")).click();
        String generateFieldLocator="//div[contains(@data-schema-path,'_cm.asset.common."+fieldName+"')]//span[contains(@class,'h6 errorMessage')]";
       // getDriver().findElement(By.xpath("//div[contains(@data-role,'commonGroup')]")).click();
       return getDriver().findElement(By.xpath(generateFieldLocator)).getAttribute("innerHTML");
    }

    public boolean isSelectBroadcastDestinationsSectionActive() {
        return !getSelectBroadcastDestinationsSection().getAttribute("class").contains("disabled");
    }

    public OrderItemPage qcIngestOnly() {
        if (qcIngestBtn.isEnabled())
            qcIngestBtn.click();
        return new OrderItemPage(web);
    }

    public boolean isQcIngestOnlyBtnActive() {
        return !qcIngestBtn.getAttribute("class").contains("disabled") && isSelectBroadcastDestinationsSectionActive();
    }

    public OrganisationReceivingInvoiceJobPopUp getOrganisationReceivingInvoiceJobPopUp() {
        if (!web.isElementVisible(By.xpath(OrganisationReceivingInvoiceJobPopUp.TITLE_NODE)))
            clickEditOnBehalfOfBuBtn();
        return new OrganisationReceivingInvoiceJobPopUp(this, OrganisationReceivingInvoiceJobPopUp.TITLE);
    }

    public ChangeBUOnBehalfOfPopUp getChangeBUOnBehalfOfPopUp() {
        if (!web.isElementVisible(By.xpath(ChangeBUOnBehalfOfPopUp.TITLE_NODE)))
            clickEditOnBehalfOfBuBtn();
        return new ChangeBUOnBehalfOfPopUp(this, ChangeBUOnBehalfOfPopUp.TITLE);
    }

    public OrderItemPage changeInvoicingOrganisation(String agencyName) {
        OrganisationReceivingInvoiceJobPopUp popUp = getOrganisationReceivingInvoiceJobPopUp();
        popUp.selectInvoiceOnBehalfOfBU(agencyName);
        popUp.clickOkBtn();
        return this;
    }

    public String getInvoicingOrganisation() {
        if (invoicingOrganisation == null)
            invoicingOrganisation = web.findElement(getInvoiceToLocator()).getText();
        return invoicingOrganisation;
    }

    public String getOnBehalfOfBU() {
        if (onBehalfOfBU == null)
            onBehalfOfBU = web.findElement(getOnBehalfOfBULocator()).getText();
        return onBehalfOfBU;
    }

    public String getOnBehalfOfBUWarningMessage() {
        if (onBehalfOfBUWarningMessage == null)
            onBehalfOfBUWarningMessage = web.findElement(getOnBehalfOfBUWarningMessageLocator()).getText();
        return onBehalfOfBUWarningMessage;
    }
    public boolean isInvoiceToVisible() {
        return web.isElementVisible(getInvoiceToLocator());
    }

    public boolean isOnBehalfOfBUVisible() {
        return web.isElementVisible(getOnBehalfOfBULocator());
    }

    public boolean isProceedButtonEnabled() {
        return !proceedBtn.getAttribute("class").contains("disabled");
    }

    public boolean isProceedButtonVisible() {
        return proceedBtn.isVisible();
    }

    public OrderProceedPage proceed() {
        clickProceedBtn();
        return new OrderProceedPage(web);
    }

    public void clickProceedButton() {
        clickProceedBtn();
        waitUntilLoadSpinnerDisappears();
    }

    public String verifyError()
    {
        String text="true";
        try
        {  text = web.findElement(By.xpath("//span[@class='h6 errorMessage']")).getText(); }
        catch(Exception e)
        {
            text="false";
        }
        return text;


    }
    public OrderingPage saveAsDraft() {
        clickSaveAsDraftBtn();
        return new OrderingPage(web);
    }

    public void saveAsDraftWithoutDelay() {
        clickSaveAsDraftBtn();
                    }


    public TransferOrderForm getTransferOrderForm() {
        if (!web.isElementVisible(By.cssSelector(TransferOrderForm.ROOT_NODE)))
            clickTransferBtn();
        return new TransferOrderForm(this);
    }

    private void clickIconMarket() {
        web.click(getSelectedMarketLocator());
    }

    private void clickEditOnBehalfOfBuBtn() {
        editOnBehalfOfBuBtn.click();
    }

    private boolean isSectionVisibleByProps(String sectionProps) {
        return web.isElementVisible(generateSectionLocator(sectionProps));
    }

    private void expandSectionByProps(String sectionProps) {
        web.click(generateExpandLocator(sectionProps));
    }

    private boolean isCommonInformationSectionExpanded() {
        return web.isElementVisible(By.cssSelector(CommonInformationForm.ROOT_NODE));
    }

    private boolean isAddMediaSectionExpanded() {
        return web.isElementVisible(By.cssSelector(AddMediaToOrderForm.ROOT_NODE));
    }

    private boolean isAddInformationSectionExpanded() {
        return web.isElementVisible(By.cssSelector(AddInformationForm.ROOT_NODE));
    }

    private boolean isAdditionalInformationSectionExpanded() {
        return web.isElementVisible(By.cssSelector(AdditionalInformationForm.ROOT_NODE));
    }

    private boolean isUsageRightsSectionExpanded() {
        return web.isElementVisible(By.className(UsageRightSelectorForm.ROOT_NODE));
    }

    private boolean isSelectBroadcastDestinationsSectionExpanded() {
        return web.isElementVisible(By.cssSelector(BroadcastDestinationForm.ROOT_NODE));
    }
    private String getTranslatedSelectDestination() {
        return web.findElement(By.cssSelector("#destination-group> div > div >div > div.unit.plm > span")).getText();
    }
    private boolean isAdditionalServiceSectionExpanded() {
        return web.isElementVisible(By.cssSelector(AdditionalServiceForm.ROOT_NODE));
    }

    private WebElement getSelectBroadcastDestinationsSection() {
        return web.findElement(generateSectionLocator(selectBroadcastDestinationSectionProps));
    }

    private boolean isWarningIconVisibleNextSectionByProps(String sectionProps) {
        return web.isElementVisible(generateWarningIconLocatorNextSection(sectionProps));
    }

    private void forceWarningTooltipForSection(String sectionName) {
        if (isWarningIconVisibleNextSection(sectionName))
            invokeWarningTooltip(sectionName);
        else
            throw new NoSuchElementException("There is no warning icon for section: " + sectionName);
    }

    private void invokeWarningTooltip(String sectionName) {
        Section section = Section.findByName(sectionName);
        switch (section) {
            case AddMedia: web.click(generateWarningIconLocatorNextSection(addMediaSectionProps)); break;
            case AddInformation: web.click(generateWarningIconLocatorNextSection(addInformationSectionProps)); break;
            case AdditionalInformation: web.click(generateWarningIconLocatorNextSection(additionalInformationSectionProps)); break;
            case UsageRights: web.click(generateWarningIconLocatorNextSection(addUsageRightsSectionProps)); break;
            case SelectBroadcastDestinations: web.click(generateWarningIconLocatorNextSection(selectBroadcastDestinationSectionProps)); break;
            case AdditionalServices: web.click(generateWarningIconLocatorNextSection(additionalServicesProps)); break;
            default: throw new IllegalArgumentException("Unknown section: " + section);
        }
    }

    private enum Section {
        CommonInformation("Common Information"),
        AddMedia("Add media"),
        AddInformation("Add information"),
        AdditionalInformation("Additional information"),
        UsageRights("Usage rights"),
        SelectBroadcastDestinations("Select Broadcast Destinations"),
        AdditionalServices("Additional Services");

        private String name;

        private Section(String name) {
            this.name = name;
        }

        public static Section findByName(String sectionName) {
            for (Section section : values())
                if (section.toString().equals(sectionName))
                    return section;
            throw new IllegalArgumentException("Unknown section: " + sectionName);
        }

        @Override
        public String toString() {
            return name;
        }
    }

    private boolean isCopyToAllVisibleForSection(Section section) {
        switch (section) {
            case AddMedia: return isCopyToAllLinkVisible(addMediaSectionProps);
            case AddInformation: return isCopyToAllLinkVisible(addInformationSectionProps);
            case SelectBroadcastDestinations: return isCopyToAllLinkVisible(selectBroadcastDestinationSectionProps);
            default: throw new IllegalArgumentException("Unknown section: " + section.toString());
        }
    }

    private CopyToAllConfirmationPopUp getCopyToAllConfirmationPopUpBySection(Section section) {
        if (!web.isElementVisible(By.xpath(CopyToAllConfirmationPopUp.TITLE_NODE))) {
            switch (section) {
                case AddMedia: clickCopyToAll(addMediaSectionProps); break;
                case AddInformation: clickCopyToAll(addInformationSectionProps); break;
                case AdditionalInformation: clickCopyToAll(additionalInformationSectionProps); break;
                case SelectBroadcastDestinations: clickCopyToAll(selectBroadcastDestinationSectionProps); break;
                case AdditionalServices: clickCopyToAll(additionalServicesProps); break;
                default: throw new IllegalArgumentException("Unknown section: " + section.toString());
            }
        }
        return new CopyToAllConfirmationPopUp(this, CopyToAllConfirmationPopUp.TITLE);
    }

    private ClearSectionConfirmationPopUp getClearActionConfirmationPopUpBySection(Section section) {
        if (!web.isElementVisible(By.xpath(ClearSectionConfirmationPopUp.TITLE_NODE))) {
            switch (section) {
                case AddMedia: clickClearSection(addMediaSectionProps); break;
                case AddInformation: clickClearSection(addInformationSectionProps); break;
                case AdditionalInformation: clickClearSection(additionalInformationSectionProps); break;
                case UsageRights: clickClearSection(addUsageRightsSectionProps); break;
                case SelectBroadcastDestinations: clickClearSection(selectBroadcastDestinationSectionProps); break;
                case AdditionalServices: clickClearSection(additionalServicesProps); break;
                default: throw new IllegalArgumentException("Unknown section: " + section.toString());
            }
        }
        return new ClearSectionConfirmationPopUp(this, ClearSectionConfirmationPopUp.TITLE);
    }

    private void clickClearSection(String partialLocator) {
        web.click(generateClearSectionLinkLocator(partialLocator));
    }

    private void clickCopyToAll(String partialLocator) {
        web.click(generateCopyToAllLinkLocator(partialLocator));
    }

    private boolean isCopyToAllLinkVisible(String partialLocator) {
        return web.isElementVisible(generateCopyToAllLinkLocator(partialLocator));
    }

    private void waitUntilURLChanged(final String value) {
        web.waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return webDriver.getCurrentUrl().contains(value);
            }
        });
    }

    private void clickSaveAsDraftBtn() {
        saveAsDraftBtn.click();
    }

    private void clickTransferBtn() {
        transferOrderBtn.click();
    }

    private void clickProceedBtn() {
        web.waitUntilElementAppearVisible(generateElementLocatorByDataRole("proceedButton"));
        proceedBtn.click();
    }

    /*
        Block of defining locators
    */

    private By getCoverFlowItemLocator() {
        return By.cssSelector(generateCoverFlowItemLocator(""));
    }

    private String getCoverFlowItemRootNode() {
        return generateCoverFlowItemLocator("");
    }

    private By getActiveCoverFlowItemLocator() {
        return By.cssSelector(generateCoverFlowItemLocator(".selected"));
    }

    private String getActiveCoverFlowItemRootNode() {
        return generateCoverFlowItemLocator(".selected");
    }

    private By getCoverFlowItemByIdLocator(String orderItemId) {
        return By.cssSelector(generateCoverFlowItemLocator(getCoverFlowByIdRoot(orderItemId)));
    }

    private By getInvoiceToLocator() {
        return generateElementLocatorByDataRole("invoiceTo");
    }

    private By getOnBehalfOfBULocator() {
        return generateElementLocatorByDataRole("behalfOf");
    }

    private By getOnBehalfOfBUWarningMessageLocator() {
        return By.cssSelector(".mbxs.red");
    }

    private String getCoverFlowItemByIdRootNode(String orderItemId) {
        return generateCoverFlowItemLocator(getCoverFlowByIdRoot(orderItemId));
    }

    private By generateElementLocatorByDataRole(String partialLocator) {
        return By.cssSelector("[data-role='" + partialLocator + "']");
    }

    private By generateWarningIconLocatorNextSection(String partialLocator) {
        return By.cssSelector(getSectionRoot(partialLocator) + " " + warningIconRoot);
    }

    private By generateSectionLocator(String partialLocator) {
        return By.cssSelector(getSectionRoot(partialLocator));
    }

    private By generateExpandLocator(String partialLocator) {
        return By.cssSelector(getSectionRoot(partialLocator) + " .tabAI");
    }

    private By generateClearSectionLinkLocator(String partialLocator){
        return By.cssSelector(getSectionRoot(partialLocator) + " [data-role='clear-section']");
    }

    private By generateCopyToAllLinkLocator(String partialLocator) {
        return By.cssSelector(getSectionRoot(partialLocator) + " [data-role='copy-section']");
    }

    private String generateCoverFlowItemLocator(String partialLocator) {
        return partialLocator.isEmpty() ? coverFlowItemRoot : coverFlowItemRoot + partialLocator;
    }

    private By getTitleLocator() {
        return By.cssSelector(".b-head-title .pvs");
    }

    private By getSelectedMarketLocator() {
        return By.className("selected-market");
    }

    private String getCoverFlowByIdRoot(String orderItemId) {
        return "[data-id='" + orderItemId + "']";
    }

    private String getSectionRoot(String partialLocator) {
        return "[data-dojo-props*='" + partialLocator + "']";
    }

    private By getDijitTooltipContainer() {
        return By.className("dijitTooltipContainer");
    }

    private By getOrderItemPageLocator() {
        return By.cssSelector("[data-dojo-type='ordering.form.manager.App']");
    }

    public void clearClockNumber(){
        web.findElement(By.xpath("//input[@name='_cm.common.clockNumber'][@data-role='schemaField']")).clear();
    }
}