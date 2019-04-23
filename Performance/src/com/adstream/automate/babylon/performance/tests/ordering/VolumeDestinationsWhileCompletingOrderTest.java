package com.adstream.automate.babylon.performance.tests.ordering;

import com.adstream.automate.babylon.JsonObjects.ordering.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 28.03.14
 * Time: 22:04
 */

public class VolumeDestinationsWhileCompletingOrderTest extends CompleteOrderTest {

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
        long start = System.currentTimeMillis();
        Order order = createOrderStage();
        addPartialTime("Create order time, s: ", System.currentTimeMillis() - start);
        completeOrderStage(order);
    }

    @Override
    public void afterRun() {
    }
}