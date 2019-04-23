package com.adstream.automate.babylon.sut.pages.adbank.projects.approvals;

import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankProjectTabs;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.ConfirmApprovalActionPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: reznik-d
 * Date: 19.03.13
 * Time: 16:21
 */
public class AdbankProjectsApprovalsPage extends AdbankProjectTabs {

    public AdbankProjectsApprovalsPage(ExtendedWebDriver web) {
        super(web);
    }

    public List<String> getApprovalsFilesNames() {
        return web.findElementsToStrings(By.cssSelector(".cell .display-table-cell a"));
    }

    public List<String> getApprovalsClientsNames() {
        List<String> clientsList = new ArrayList<>();
        for (WebElement element : web.findElements(By.cssSelector(".agencyFilterItem"))) {
            clientsList.add(element.getText().replaceAll("(^\\[|\\]$)", ""));
        }
        return clientsList;
    }

    public List<Map<String,String>> getApprovals(List<String> fields) {
        List<Map<String,String>> approvals = new ArrayList<>();
        List<String> fileIds = web.findElementsToStrings(By.cssSelector(".column-0 a"));
        String rowXpathFormat = "//*[@data-type='tableRowsContent']//*[contains(@class,'row')][.//*[contains(@class,'cell')]//a[normalize-space(text())='%s']]";

        for (String fileId : fileIds) {
            Map<String,String> approval = new HashMap<>();
            By nameLocator = By.xpath(String.format(rowXpathFormat, fileId) + "//*[contains(@class,'display-table-cell')]//a");
            approval.put("FileName", web.findElement(nameLocator).getText());

            if (fields.contains("Status")) {
                By statusLocator = By.xpath(String.format(rowXpathFormat, fileId) + "/*[contains(@class,'cell')][last()]/preceding-sibling::*[2]");
                approval.put("Status", web.findElement(statusLocator).getText());
            }

            if (fields.contains("ApprovalStage")) {
                By stageLocator = By.xpath(String.format(rowXpathFormat, fileId) + "/*[contains(@class,'cell')][last()]/*");
                approval.put("ApprovalStage", web.findElement(stageLocator).getText().replaceAll("\\s+\\(\\d+.\\d+\\)", ""));
            }

            if (fields.contains("ProjectName")) {
                By projectNameLocator = By.xpath(String.format(rowXpathFormat, fileId) + "/*[contains(@class,'cell')][3]");
                approval.put("ProjectName", web.findElement(projectNameLocator).getText());
            }

            approvals.add(approval);
        }

        return approvals;
    }

    public String getCurrentOrder(String name) {
        return web.findElement(getColumnNameLocator(name)).getAttribute("class");
    }

    public By getColumnNameLocator(String name) {
        switch (name) {
            case "FileName":
                return By.cssSelector("[fieldname='entityName']");
            case "Status":
                return By.cssSelector("[fieldname='status']");
            case "Project":
                return By.cssSelector("[fieldname='projectName']");
            default: throw new IllegalArgumentException("Unknown name: " + name);
        }
    }

    public void sortColumnNameByOrder(String name,String order) {
        if (!getCurrentOrder(name).contains(order)) {
            web.click(getColumnNameLocator(name));
            web.sleep(3000);
            if (!getCurrentOrder(name).contains(order)) {
                web.click(getColumnNameLocator(name));
            }
        }
    }

    public List<String> getProjectNames() {
        return web.findElementsToStrings(By.cssSelector("[data-type=\"tableRow\"] .unit.cell.column-2"));
    }

    public List<String> getFileNames() {
        return web.findElementsToStrings(By.cssSelector(".itemsList .display-table a"));
    }

    public boolean isApproveButtonDisabled() {
        return web.isElementPresent(By.cssSelector("[data-dojo-type*='approval'].green.disabled"));
    }

    public boolean isRejectButtonDisabled() {
        return web.isElementPresent(By.cssSelector("[data-dojo-type*='approval'].orange.disabled"));
    }

    public void tickSentDate() {
        web.click(By.cssSelector("[value='created']"));
    }

    public void tickDueDate() {
        web.click(By.cssSelector("[value='dueDate']"));
    }

    public void selectRangeFrom(String value) {
        new DojoCombo(this, By.id("widget_searchFromDate")).selectByVisibleText(value);
    }

    public void selectRangeTo(String value) {
        new DojoCombo(this, By.id("widget_searchToDate")).selectByVisibleText(value);
    }

    public void selectClient(String client){
        web.click(By.cssSelector(String.format("[agency-id*='%s']", client)));
        Common.sleep(1000);
    }

    public void selectApprovalStatus(String status){
        if (status.equalsIgnoreCase("Pending")) {
            new Checkbox(this, By.id("approval_status_pending")).select();
        } else if (status.equalsIgnoreCase("Approved")) {
            new Checkbox(this, By.id("approval_status_approved")).select();
        } else if (status.equalsIgnoreCase("Rejected")) {
            new Checkbox(this, By.id("approval_status_rejected")).select();
        } else if (status.equalsIgnoreCase("Cancelled")) {
            new Checkbox(this, By.id("approval_status_cancelled")).select();
        } else {
            throw new IllegalArgumentException(String.format("Unknown approval status: '%s'", status));
        }
        web.sleep(1000);
    }

    public void selectMediaType(String mediaType){
        String id;
        if (mediaType.equalsIgnoreCase("Video")) {
            id = "file-type-video";
        } else if (mediaType.equalsIgnoreCase("Audio")) {
            id = "file-type-audio";
        } else if (mediaType.equalsIgnoreCase("Document")) {
            id = "file-type-print";
        } else if (mediaType.equalsIgnoreCase("Digital")) {
            id = "file-type-digital";
        } else if (mediaType.equalsIgnoreCase("Image")) {
            id = "file-type-image";
        } else {
            throw new IllegalArgumentException(String.format("Unknown mediatype: '%s'", mediaType));
        }
        Checkbox checkbox = new Checkbox(this, By.id(id));
        checkbox.select();
        Common.sleep(1000);
        // mega hack! do it again due to unbelievable header appear over the checkbox.
        checkbox = new Checkbox(this, By.id(id));
        if (!checkbox.isSelected()) {
            web.getJavascriptExecutor().executeScript("window.scrollBy(0, -200)");
            checkbox.select();
            Common.sleep(1000);
        }
    }

    public void selectApprovalStatusAdditionalCheckbox(String name) {
        if (name.equalsIgnoreCase("All user approvals")) {
            new Checkbox(this, By.id("all_user_approvals")).select();
        } else if (name.equalsIgnoreCase("Include completed approvals")) {
            new Checkbox(this, By.id("approval_include_completed")).select();
        } else {
            throw new IllegalArgumentException(String.format("Unknown additional checkbox name '%s' in Approval Status area", name));
        }

        Common.sleep(2000);
    }

    public void deselectApprovalStatusAdditionalCheckbox(String name) {
        if (name.equalsIgnoreCase("All user approvals")) {
            new Checkbox(this, By.id("all_user_approvals")).deselect();
        } else if (name.equalsIgnoreCase("Include completed approvals")) {
            new Checkbox(this, By.id("approval_include_completed")).deselect();
        } else {
            throw new IllegalArgumentException(String.format("Unknown additional checkbox name '%s' in Approval Status area", name));
        }

        Common.sleep(2000);
    }

    public void selectApprovalByFileId(String fileId) {
        if (!web.isElementPresent(By.xpath(String.format("//*[@data-type='tableRow'][contains(@class,'selected')][.//*[contains(@src,'%s')]]", fileId))))
            web.click(By.xpath(String.format("//*[@data-type='tableRow'][not(contains(@class,'selected'))][.//*[contains(@src,'%s')]]", fileId)));
    }


    public void clickOpenSelectedButton() {
        web.click(By.cssSelector("[data-dojo-type*='adbank.approvals.view_approvals']"));
    }

    public void clickStartButton() {
            web.click(By.cssSelector("[data-dojo-type*='adbank.approvals.bulk_start_approvals_button']:not(.disabled)"));
    }

    public ConfirmApprovalActionPopUp clickApproveButton() {
        web.click(By.cssSelector("[data-dojo-type*='approval'].green:not(.disabled)"));
        return new ConfirmApprovalActionPopUp(this);
    }

    public ConfirmApprovalActionPopUp clickRejectButton() {
        web.click(By.cssSelector("[data-dojo-type*='approval'].orange:not(.disabled)"));
        return new ConfirmApprovalActionPopUp(this);
    }
}