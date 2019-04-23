package com.adstream.automate.babylon.tests.steps.domain.oneDelivery;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.oneDelivery.OneDeliveryNewOrderPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.model.ExamplesTable;

import java.util.Iterator;
import java.util.Map;

public class OneDeliveryNewOrderSteps extends OneDeliveryBaseSteps{

    @Given("{I am|}on new order page of one delivery")
    public OneDeliveryNewOrderPage getOneDeliveryNewOrder(){
        return getSut().getPageNavigator().getOneDeliveryNewOrderPage();
    }

    @Given("{I |}filled new order with following details for OneDelivery order:$data")
    public void fillFieldsviaUI(ExamplesTable data) {
        fillNewOrderDetails(data).clickByButtonName("Continue");
    }

    public OneDeliveryNewOrderPage fillNewOrderDetails(ExamplesTable data){
        OneDeliveryNewOrderPage page = getOneDeliveryNewOrder();
        Map<String, String> row = parametrizeTabularRow(data);

        if(row.containsKey("Who is supplying the media")){
            String userType = row.get("Who is supplying the media");

            User user = getData().getUserByType(userType);
            if (user == null) {
                user = getCoreApiAdmin().getUserByEmail((userType));
            }
            row.put("Who is supplying the media",user.getEmail());
        }

        Iterator iterator = row.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry rowEntry = (Map.Entry) iterator.next();
            Common.sleep(200);
            page.fillFieldByName(rowEntry.getKey().toString(), rowEntry.getValue().toString());
        }
        return page;
    }
}