package com.adstream.automate.babylon.tests.steps.domain.oneDelivery;

import com.adstream.automate.babylon.sut.pages.oneDelivery.OneDeliveryOrderItemPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.model.ExamplesTable;

import java.util.Iterator;
import java.util.Map;

public class OneDeliveryOrderItemSteps extends OneDeliveryBaseSteps{

    @Given("{I am|}on '$order' order item details page of one delivery")
    public OneDeliveryOrderItemPage getOneDeliveryOrderItem(){
        return getSut().getPageNavigator().getOneDeliveryOrderItemPage();
    }

    @Given("{I |}filled following clock metadata for OneDelivery order:$data")
    public void fillFieldsviaUI(ExamplesTable data) {
        fillNewOrderDetails(data).clickByButtonName("Proceed to payment");
    }

    public OneDeliveryOrderItemPage fillNewOrderDetails(ExamplesTable data){
        OneDeliveryOrderItemPage page = getOneDeliveryOrderItem();
        Map<String, String> row = parametrizeTabularRow(data);

        if(row.containsKey("Advertiser"))
            row.put("Advertiser",wrapVariableWithTestSession(row.get("Advertiser")));
        if(row.containsKey("Brand"))
            row.put("Brand",wrapVariableWithTestSession(row.get("Brand")));
        if(row.containsKey("Sub Brand"))
            row.put("Sub Brand",wrapVariableWithTestSession(row.get("Sub Brand")));
        if(row.containsKey("Product"))
            row.put("Product",wrapVariableWithTestSession(row.get("Product")));
        if(row.containsKey("Clock Number"))
            row.put("Clock Number",wrapVariableWithTestSession(row.get("Clock Number")));

        Iterator iterator = row.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry rowEntry = (Map.Entry) iterator.next();
            Common.sleep(200);
            page.fillFieldByName(rowEntry.getKey().toString(), rowEntry.getValue().toString());
        }
        return page;
    }
}
