package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.sut.pages.traffic.element.TrafficNewTabPopUp;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

/**
 * Created by denysb on 25/11/2015.
 */
public class TrafficNewTabSteps extends TrafficHelperSteps {



    public TrafficNewTabPopUp getTrafficCreateNewTabPopUp(){
        return getSut().getPageCreator().getTrafficNewPopUpWindow();
    }

   /* |  Condition   | Condition Type |  Value   | NewRule | Match | NewConditionAfterCurrent |
    Match should be specified only once per One Rule (see below Example)
    And add new conditions at the traffic pop up:
    |  Condition   | Condition Type |  Value   | NewRule | Match | NewConditionAfterCurrent |
    | <Condition1> |   Match        | <Value1> |         | Any   | Yes                      |
    | <Condition1> |   Match        | <Value2> |         |       |                          |
    | <Condition2> |   Match        | <Value3> |  Yes    | All   |                          |
    */
    @Given("{I |}added new conditions at the traffic create new tab pop up:$data")
    @When("{I |}add new conditions at the traffic create new tab pop up:$data")
    public void selectNewConditionforTrafficNewTab(ExamplesTable data){
        TrafficNewTabPopUp popup = getTrafficCreateNewTabPopUp();
        popup.clickAddRuleButton();
        Integer matchElementCounter = 0;
        for (int i = 0; i <data.getRowCount() ; i++) {
            Map<String,String> map = parametrizeTabularRow(data,i);
            if(map.get("NewRule").equalsIgnoreCase("yes")){
                popup.clickAddRuleButton();
            }
            if(!map.get("Match").isEmpty()) {
                popup.selectMatchType(matchElementCounter, map.get("Match"));
                matchElementCounter++;
            }
            if(map.get("Condition").equals("Agency")||map.get("Condition").equals("Advertiser")||map.get("Condition").equals("Clock Number")){
                popup.addNewConditions(i, map.get("Condition"), map.get("Condition Type"),wrapVariableWithTestSession(map.get("Value")));
            } else {
                popup.addNewConditions(i, map.get("Condition"), map.get("Condition Type"), map.get("Value"));
            }
            if(map.get("NewConditionAfterCurrent").equalsIgnoreCase("yes"))
            popup.clickOnAddConditionLink();
        }
    }

    @Given("{I |}selected share tab at the traffic create new tab pop up")
    @When("{I |}select share tab option at the traffic create new tab pop up")
    public void selectSharetabOption(){
        getTrafficCreateNewTabPopUp().selectShareTabCheckbox();
    }


    @Given("{I |}clicked save at the traffic create new tab pop up")
    @When("{I |}click save at the traffic create new tab pop up")
    public void clickSaveButton(){
        getTrafficCreateNewTabPopUp().clickSaveButton();
    }

    @Given("{I |}opened create new tab popup and fill name '$name' and type '$type' and dataRange '$dataRange'")
    @When("{I |}open create new tab popup and fill name '$name' and type '$type' and dataRange '$dataRange'")
    public void openCreateNewTabPopUp(String name, String type,String dataRange){
        TrafficNewTabPopUp popup = getSut().getPageCreator().getTrafficOrderListPage().openNewTabPopUpWindow();
        popup.fillNameAndTypeForNewTrafficTab(name, type, dataRange);
    }


    @Then("{I |}'$condition' see '$tabOption' in new tab popup")
    public void verifytabOptions(String condition, String tabOption) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        TrafficNewTabPopUp popup = getSut().getPageCreator().getTrafficOrderListPage().openNewTabPopUpWindow();
        boolean actualState=popup.verifyTabOptions(tabOption);
        assertThat(actualState, expectedState ? equalTo(true) : equalTo(false));

    }


    @Given("{I |}created tab with name '$name' and type '$type' and dataRange '$dataRange' and the following rules:$data")
    @When("{I |}create tab with name '$name' and type '$type' and dataRange '$dataRange' and the following rules:$data")
    public void createTabWithNewConditionforTraffic(String name, String type,String dataRange, ExamplesTable data){
        TrafficNewTabPopUp popup = getSut().getPageCreator().getTrafficOrderListPage().openNewTabPopUpWindow();
        popup.fillNameAndTypeForNewTrafficTab(name, type,dataRange);
        for (int i = 0; i <data.getRowCount() ; i++) {
            Map<String,String> map = parametrizeTabularRow(data,i);
            if(map.get("Schema")!=null&&!map.get("Schema").isEmpty()){
                popup.fillMarketMetadataSchemaField(map.get("Schema"));
            }
            fillUpConditions(popup,map);
            if(map.containsKey("Filter By Status")){
                popup.fillFilterByStatus(map.get("Filter By Status"));
            }
        }
        popup.clickSaveButton();
    }

    private void fillUpConditions(TrafficNewTabPopUp popup,Map<String,String> map){
        if(!map.get("Condition").isEmpty()&&!map.get("Condition Type").isEmpty()){
            popup.clickAddRuleButton();
            if((map.get("Condition").equals("Agency") && !map.get("Value").equalsIgnoreCase("A5testAdvertiser")) || map.get("Condition").equals("Advertiser")||map.get("Condition").equals("Clock Number") || map.get("Condition").equals("Ingest Location")){
                popup.addNewConditions(popup.getTabRulesList().size()-1, map.get("Condition"), map.get("Condition Type"),wrapVariableWithTestSession(map.get("Value")));
            } else {
                popup.addNewConditions(popup.getTabRulesList().size()-1, map.get("Condition"), map.get("Condition Type"), map.get("Value"));
            }
        }
    }

    @When("{I |}update tab with new rule:$data")
    public void updateTabWithNewRule(ExamplesTable data){
        TrafficNewTabPopUp popup = getTrafficCreateNewTabPopUp();
        for (int i = 0; i <data.getRowCount() ; i++) {
            Map<String, String> map = parametrizeTabularRow(data, i);
            fillUpConditions(popup, map);
        }
        popup.clickSaveButton();
    }

    @Given("{I |}created tab with name '$name' and type '$type' and Data Range '$dataRange' and without conditions in Traffic")
    @When("{I |}create tab with name '$name' and type '$type' and Data Range '$dataRange' and without conditions in Traffic")
    public void createTabWithoutNewConditionforTraffic(String name, String type,String dataRange){
        TrafficNewTabPopUp popup = getSut().getPageCreator().getTrafficOrderListPage().openNewTabPopUpWindow();
        popup.fillNameAndTypeForNewTrafficTab(name, type,dataRange);
        popup.clickSaveButton();
    }

    @When("{I |}delete the rule with condition '$condition'")
    public void deleteRuleFromTab(String condition){
        TrafficNewTabPopUp popup = getTrafficCreateNewTabPopUp();
        popup.deleteTabRuleWithCondition(condition);
    }


}
