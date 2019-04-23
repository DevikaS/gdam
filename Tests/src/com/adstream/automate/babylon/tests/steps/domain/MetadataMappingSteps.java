package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyMetadataMappingEditPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyMetadataMappingPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyMetadataMappingCreatePage;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.NewMetadataMapPopup;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 29.05.13
 * Time: 13:39
 */
public class MetadataMappingSteps extends BaseStep {

    protected AgencyMetadataMappingPage getMetadataMappingPage() {
        return getSut().getPageCreator().getAgencyMetadataMappingPage();
    }

    protected AgencyMetadataMappingCreatePage getMetadataMappingCreatePage() {
        return getSut().getPageCreator().getAgencyMetadataMappingCreatePage();
    }

    protected AgencyMetadataMappingEditPage getMetadataMappingEditPage() {
        return getSut().getPageCreator().getAgencyMetadataMappingEditPage();
    }

    @Given("{I am |}on the agency '$agency' metadata mapping page")
    @When("{I |}go to the agency '$agency' metadata mapping page")
    public AgencyMetadataMappingPage openMetadataMappingPage(Agency agency) {
        return getSut().getPageNavigator().getAgencyMetadataMappingPage(agency.getId());
    }

    @Given("{I am |}on the metadata mapping create page from agency '$agencyFrom' to agency '$agencyTo'")
    @When("{I |}go to the metadata mapping create page from agency '$agencyFrom' to agency '$agencyTo'")
    public AgencyMetadataMappingCreatePage openMetadataMappingCreatePage(Agency agencyFrom, Agency agencyTo) {
        return getSut().getPageNavigator().getAgencyMetadataMappingCreatePage(agencyFrom.getId(), agencyTo.getId());
    }

    @Given("{I am |}on the metadata mapping edit page from agency '$agencyFrom' to agency '$agencyTo'")
    @When("{I |}go to the metadata mapping edit page from agency '$agencyFrom' to agency '$agencyTo'")
    public AgencyMetadataMappingEditPage openMetadataMappingEditPage(Agency agencyFrom, Agency agencyTo) {
        String schemasMapId = getCoreApiAdmin().getSchemasMap(agencyFrom.getId(), agencyTo.getId()).getId();
        return getSut().getPageNavigator().getAgencyMetadataMappingEditPage(agencyFrom.getId(), schemasMapId);
    }

    @Given("{I |}created metadata mapping from agency '$agencyFrom' to agency '$agencyTo' on metadata mapping page")
    @When("{I |}create metadata mapping from agency '$agencyFrom' to agency '$agencyTo' on metadata mapping page")
    public void createMetadataMappingForAgency(Agency agencyFrom, Agency agencyTo) {
        NewMetadataMapPopup popup = openMetadataMappingPage(agencyFrom).clickNewMetadataMapButton();
        popup.selectBusinessUnit(agencyTo.getName());
        popup.clickAction();
        getMetadataMappingCreatePage().saveMetadataMapping();
    }

    // | GroupFrom | FieldFrom | GroupTo | FieldTo |
    @Given("{I |}mapped following '$scope' fields from agency '$agencyFrom' to agency '$agencyTo' on metadata mapping edit page: $data")
    @When("{I |}map following '$scope' fields from agency '$agencyFrom' to agency '$agencyTo' on metadata mapping edit page: $data")
    public void mapAgenciesFields(String scope, Agency agencyFrom, Agency agencyTo, ExamplesTable data) {
        AgencyMetadataMappingEditPage page = openMetadataMappingEditPage(agencyFrom, agencyTo);
        page.selectMetadataScopeTabByName(scope);

        for (Map<String,String> row : parametrizeTableRows(data)) {
            page.expandGroup(agencyFrom.getName(), row.get("GroupFrom"));
            page.choiseField(agencyFrom.getName(), row.get("GroupFrom"), row.get("FieldFrom"));

            page.expandGroup(agencyTo.getName(), row.get("GroupTo"));
            page.choiseField(agencyTo.getName(), row.get("GroupTo"), row.get("FieldTo"));
        }

        page.saveMetadataMapping();
    }

    // | FieldFrom | FieldTo |
    @Given("{I |}removed following '$scope' mapped items on metadata mapping page from agency '$agencyFrom' to agency '$agencyTo': $data")
    @When("{I |}remove following '$scope' mapped items on metadata mapping page from agency '$agencyFrom' to agency '$agencyTo': $data")
    public void removeMappedItemsForAgency(String scope, Agency agencyFrom, Agency agencyTo, ExamplesTable data) {
        AgencyMetadataMappingEditPage page = openMetadataMappingEditPage(agencyFrom, agencyTo);
        page.selectMetadataScopeTabByName(scope);

        for (Map<String,String> row : parametrizeTableRows(data))
            page.removeMappedFieldsItem(row.get("FieldFrom"), row.get("FieldTo"));

        page.saveMetadataMapping();
    }
}