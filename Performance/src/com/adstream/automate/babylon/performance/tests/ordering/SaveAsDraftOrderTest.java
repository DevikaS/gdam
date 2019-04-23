package com.adstream.automate.babylon.performance.tests.ordering;

import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.google.gson.JsonObject;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 07.10.13
 * Time: 18:04
 */
public class SaveAsDraftOrderTest extends CompleteOrderTest {

    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
    }

    @Override
    public void start() {
        Order order = createOrderStage();
        Order orderToSave = getService().getOrderById(order.getId(), true);
        JsonObject orderJsonObj = getBabylonMiddlewareService().prepareSaveAsDraftOrderRequest(orderToSave);

        log.info("Save as draft order: " + order.getId());
        long start = System.currentTimeMillis();
        Order saveAsDraftOrder = getBabylonMiddlewareService().saveAsDraftOrder(orderJsonObj, order.getId());
        if (saveAsDraftOrder == null)
            fail("Cannot save as draft order: " + order.getId());
        addPartialTime("Save as draft order, s: ", System.currentTimeMillis() - start);
    }

    @Override
    public void afterRun() {
    }
}