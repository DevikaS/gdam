package com.adstream.automate.babylon.performance.tests.ordering;

import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderCounter;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Gen;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 09.10.13
 * Time: 17:14
 */
public class SearchOrdersTest extends CompleteOrderTest {
    private static boolean ordersCreated = false;
    private static List<String> filterCriteria = new ArrayList<String>();

    @Override
    public void runOnce() {
        if (!ordersCreated) {
            super.runOnce();
            initializeIndexingCounters();
            int ordersCount = getParamInt("ordersCount");
            log.info(String.format("Check for %d orders", ordersCount));
            int ordersFound = getOrdersCountByOrderStatus(getParam("ordersStatus"));
            log.info(String.format("Found %d orders. Need to create %d orders.", ordersFound, ordersCount - ordersFound));
            for (int i = 0; i < ordersCount - ordersFound; i++) {
                if (i % 1000 == 999) log.info(String.format("Created %d orders", i + 1));
                Order order = createOrderStage();
                log.info("Has been created orders: " + (i + 1));
                filterCriteria.add(getFilterCriteria(order, Filter.findByCriteria(getParam("filterCriteria"))));
                log.info("Remains to create orders: " + (ordersCount - ordersFound - (i + 1)));
            }
            ordersCreated = true;
            log.info("Orders have been created");
        }
    }

    @Override
    public void beforeStart() {
        super.beforeStart();
    }

    @Override
    public void start() {
        String filter =  filterCriteria.get(Gen.getInt(filterCriteria.size()));
        log.info("Start search order by filter: " + filter);
        SearchResult<Order> searchResult = getService().findOrders(getQuery(filter));
        if (searchResult == null || searchResult.getResult().size() == 0)
            fail("Error while searching order by filter: " + filter);
    }

    @Override
    public void afterRun() {
    }

    private void initializeIndexingCounters() {
        if (getParam("ordersStatus").equals(OrderStatus.DRAFT.toString()))
            createOrderStage();
    }

    private int getOrdersCountByOrderStatus(String orderStatus) {
        SearchResult<OrderCounter> result = getService().getOrderCounters(getParam("orderType"));
        for (OrderCounter orderCounter : result.getResult()) {
            if (orderCounter.getStatus().equals(orderStatus))
                return orderCounter.getCount();
        }
        throw new NullPointerException("No any order with following status: " + orderStatus);
    }

    private LuceneSearchingParams getQuery(String filter) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("{\"and\":[{\"or\":[{\"prefix\":{\"orderReference.string\":\"" + filter + "\"}},{\"prefix\":{\"deliverables.items._cm.common.clockNumber\":\"" + filter + "\"}},{\"prefix\":{\"_cm.tv.market\":\"" + filter + "\"}},{\"prefix\":{\"deliverables.items._cm.asset.common.advertiser\":\"" + filter + "\"}},{\"prefix\":{\"deliverables.items._cm.asset.common.brand\":\"" + filter + "\"}},{\"prefix\":{\"deliverables.items._cm.asset.common.sub_brand\":\"" + filter + "\"}},{\"prefix\":{\"deliverables.items._cm.asset.common.product\":\"" + filter + "\"}},{\"prefix\":{\"deliverables.items._cm.common.title\":\"" + filter + "\"}},{\"prefix\":{\"deliverables.items._cm.common.campaign\":\"" + filter + "\"}}]},{\"terms\":{\"_subtype\":[\"" + getParam("orderType") + "\"]}},{\"terms\":{\"status\":[\"" + getParam("ordersStatus") + "\"]}}]}");
        query.setStatus(getParam("ordersStatus"));
        return query;
    }

    private String getFilterCriteria(Order order, Filter filter) {
        String filterCriteria = "";
        switch (filter) {
            case ORDER_REFERENCE:
                filterCriteria =  order.getOrderReference().toString();
                break;
            case CLOCK_NUMBER:
                filterCriteria = getService().getOrderById(order.getId(), true).getDeliverables().getOrderItems()[Gen.getInt(getParamInt("orderItemsCount"))].getClockNumber();
                break;
            case ADVERTISER:
                filterCriteria =  getService().getOrderById(order.getId(), true).getDeliverables().getOrderItems()[Gen.getInt(getParamInt("orderItemsCount"))].getAdvertiser()[0];
                break;
            case BRAND:
                filterCriteria = getService().getOrderById(order.getId(), true).getDeliverables().getOrderItems()[Gen.getInt(getParamInt("orderItemsCount"))].getBrand()[0];
                break;
            case SUB_BRAND:
                filterCriteria = getService().getOrderById(order.getId(), true).getDeliverables().getOrderItems()[Gen.getInt(getParamInt("orderItemsCount"))].getSubBrand()[0];
                break;
            case PRODUCT:
                filterCriteria = getService().getOrderById(order.getId(), true).getDeliverables().getOrderItems()[Gen.getInt(getParamInt("orderItemsCount"))].getProduct()[0];
                break;
            case TITLE:
                filterCriteria =  getService().getOrderById(order.getId(), true).getDeliverables().getOrderItems()[Gen.getInt(getParamInt("orderItemsCount"))].getTitle();
                break;
            case CAMPAIGN:
                filterCriteria = getService().getOrderById(order.getId(), true).getDeliverables().getOrderItems()[Gen.getInt(getParamInt("orderItemsCount"))].getCampaign();
                break;
        }
        return filterCriteria;
    }

    private enum Filter {
        ORDER_REFERENCE("order reference"),
        CLOCK_NUMBER("clock number"),
        ADVERTISER("advertiser"),
        BRAND("brand"),
        SUB_BRAND("sub brand"),
        PRODUCT("product"),
        TITLE("title"),
        CAMPAIGN("campaign");

        private String criteria;

        private Filter(String criteria) {
            this.criteria = criteria;
        }


        @Override
        public String toString() {
            return criteria;
        }

        public static Filter findByCriteria(String criteria) {
            for (Filter filter: values())
                if (filter.toString().equalsIgnoreCase(criteria))
                    return filter;
            throw new IllegalArgumentException("Unknown filter criteria: " + criteria);
        }
    }

    private enum OrderStatus {
        IN_PROGRESS("in_progress"),
        DRAFT("draft"),
        ON_HOLD("onHold"),
        COMPLETED("completed");

        private String name;

        private OrderStatus(String name) {
            this.name = name;
        }


        @Override
        public String toString() {
            return name;
        }
    }
}