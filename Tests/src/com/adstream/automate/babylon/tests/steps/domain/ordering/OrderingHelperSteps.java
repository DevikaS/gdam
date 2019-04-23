package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.UserDateFormat;
import com.adstream.automate.babylon.JsonObjects.ordering.DestinationItem;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.OrderType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.OrderStatus;
import com.adstream.automate.babylon.sut.pages.ordering.elements.StepsOrderType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import com.google.common.collect.Lists;
import org.apache.commons.codec.binary.Base64;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.Period;
import org.openqa.selenium.TimeoutException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 31.10.13
 * Time: 15:26
 */
public abstract class OrderingHelperSteps extends BaseStep {

    protected final long sleep = 5000; //5 sec
    protected final long placeOrderToA4TimeOut = 10 * 90 * 1000; // 9 min
    protected final static long statusReplicationToTraffic = 60 * 6000; //6min

    private enum StepsOrderStatus {
        LIVE("live"),
        DRAFT("draft"),
        HELD("held"),
        COMPLETE("complete");

        private String stepsOrderStatus;

        private StepsOrderStatus(String stepsOrderStatus) {
            this.stepsOrderStatus = stepsOrderStatus;
        }


        @Override
        public String toString() {
            return stepsOrderStatus;
        }
    }

    protected void waitForOrderIndex(String orderId, String orderStatus, long timeOut) {
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(1000);
        } while (!getCoreApi().getLastCreatedOrder(orderStatus).getId().equals(orderId) && System.currentTimeMillis() - start < timeOut);
    }

    protected void waitForOrderIsNull(String orderId, long timeOut) {
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(1000);
        } while (getCoreApi().getOrder(orderId, true) != null && System.currentTimeMillis() - start < timeOut);
    }

    protected void waitForFinishPlaceOrderToA4(String orderId, long timeOut) {
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 2);
        } while (!getCoreApi().getOrder(orderId, true).getStatus()[0].equals(OrderStatus.VIEW_LIVE_ORDERS.toString()) && System.currentTimeMillis() - start < placeOrderToA4TimeOut);
        if (System.currentTimeMillis() - start > placeOrderToA4TimeOut)
            throw new TimeoutException("Timeout during place order to a4!");
    }

    protected void waitForFailingPlaceOrderToA4(String orderId, long timeOut) {
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(1000);
        } while (!getCoreApi().getOrder(orderId, true).getStatus()[0].equals(OrderStatus.VIEW_LIVE_ORDERS.getOrderStatus()[2]) && System.currentTimeMillis() - start < timeOut);
        if (System.currentTimeMillis() - start > timeOut)
            throw new TimeoutException("Timeout during waiting for failing place order to a4!");
    }

    protected Order getLastCreatedOrder(String orderStatus) {
        Order order = getCoreApi().getLastCreatedOrder(orderStatus);
        if (order == null)
            throw new NullPointerException("Order was not found! Check if it is created.");
        return order;
    }

    protected Order getOrderByMarket(String market) {
        Order order = getCoreApi().getOrderByMarket(market);
        if (order == null)
            throw new NullPointerException("Order was not found by following market: " + market);
        return order;
    }

    protected Order getOrderByMarketAndItemClockNumber(String market, String clockNumber) {
        Order order = getCoreApi().getOrderByMarketAndItemClockNumber(market, clockNumber);
        if (order == null)
            throw new NullPointerException("Order was not found by following market: " + market + " and item clock number: " + clockNumber);
        return order;
    }

    protected Order getOrderByItemClockNumber(String clockNumber) {
        Order order = getCoreApi().getOrderByItemClockNumber(clockNumber);
        if (order == null)
            throw new NullPointerException("Order was not found by following item clock number: " + clockNumber);
        return order;
    }

    protected Order getOrderByItemClockNumberByGlobalAdmin(String clockNumber) {
        Order order = getCoreApiAdmin().getOrderByItemClockNumber(clockNumber);
        if (order == null)
            throw new NullPointerException("Order was not found by following item clock number: " + clockNumber);
        return order;
    }

    protected Order getOrderByItemTitle(String title) {
        Order order = getCoreApi().getOrderByItemTitle(title);
        if (order == null)
            throw new NullPointerException("Order was not found by following item title: " + title);
        return order;
    }

    protected OrderItem[] getOrderItems(String orderId) {
        OrderItem[] orderItems = getCoreApi().getOrder(orderId, true).getDeliverables().getOrderItems();
        if (orderItems == null || orderItems.length == 0)
            throw new NullPointerException("Order with id: " + orderId + " hasn't any of order items!");
        return orderItems;
    }

    protected OrderItem getOrderItemByClockNumber(String orderId, String clockNumber) {
        OrderItem orderItem = getCoreApi().getOrderItemByClockNumber(orderId, clockNumber);
        if (orderItem == null)
            throw new NullPointerException("Order item was not found by following clock number: " + clockNumber + " for order with id: " + orderId);
        return orderItem;
    }

    protected OrderItem getOrderItemByClockNumberAsGlobalAdmin(String orderId, String clockNumber) {
        OrderItem orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, clockNumber);
        if (orderItem == null)
            throw new NullPointerException("Order item was not found by following clock number: " + clockNumber + " for order with id: " + orderId);
        return orderItem;
    }

    protected OrderItem getOrderItemByTitle(String orderId, String title) {
        OrderItem orderItem = getCoreApi().getOrderItemByTitle(orderId, title);
        if (orderItem == null)
            throw new NullPointerException("Order item was not found by following title: " + title + " for order with id: " + orderId);
        return orderItem;
    }

    protected OrderItem getOrderItemByIndex(Order order, int index) {
        return order.getDeliverables().getOrderItems()[index];
    }

    protected OrderItem getOrderItemByIndex(int index, String orderId, String clockNumber) {
        List<OrderItem> orderItems = getCoreApi().getOrderItemsByClockNumber(orderId, clockNumber);
        if (orderItems.isEmpty())
            throw new IllegalArgumentException("There is no any order items with following clock number: " + clockNumber + " for order with id: " + orderId);
        if (orderItems.size() < index)
            throw new IndexOutOfBoundsException("Index is more than number of order items!");
        return orderItems.get(index - 1);
    }

    protected OrderItem getOrderItemWithTitleByIndex(int index, String orderId, String title) {
        List<OrderItem> orderItems = getCoreApi().getOrderItemsByTitle(orderId, title);
        if (orderItems.isEmpty())
            throw new IllegalArgumentException("There is no any order items with following title: " + title + " for order with id: " + orderId);
        if (orderItems.size() < index)
            throw new IndexOutOfBoundsException("Index is more than number of order items!");
        return orderItems.get(index - 1);
    }

    protected DestinationItem getDestinationItemByName(OrderItem orderItem, String name) {
        for (DestinationItem destinationItem : orderItem.getDestinationItems())
            if (destinationItem.getName().equals(name))
                return destinationItem;
        throw new NullPointerException("There is no any destination item with name: " + name + " for order item with id: " + orderItem.getId());
    }

    protected String getAggregateOrderStatus(String orderStatus) {
        if (orderStatus.equalsIgnoreCase(StepsOrderStatus.LIVE.toString()))
            return OrderStatus.VIEW_LIVE_ORDERS.convertStatusToString();
        else if (orderStatus.equalsIgnoreCase(StepsOrderStatus.DRAFT.toString()))
            return OrderStatus.VIEW_DRAFT_ORDERS.convertStatusToString();
        else if (orderStatus.equalsIgnoreCase(StepsOrderStatus.HELD.toString()))
            return OrderStatus.VIEW_HELD_ORDERS.convertStatusToString();
        else if (orderStatus.equalsIgnoreCase(StepsOrderStatus.COMPLETE.toString()))
            return OrderStatus.VIEW_COMPLETED_ORDERS.convertStatusToString();
        else
            throw new IllegalArgumentException("Unknown order status: " + orderStatus);
    }

    protected OrderStatus getOrderStatusByName(String orderStatus) {
        if (orderStatus.equalsIgnoreCase(StepsOrderStatus.LIVE.toString()))
            return OrderStatus.VIEW_LIVE_ORDERS;
        else if (orderStatus.equalsIgnoreCase(StepsOrderStatus.DRAFT.toString()))
            return OrderStatus.VIEW_DRAFT_ORDERS;
        else if (orderStatus.equalsIgnoreCase(StepsOrderStatus.HELD.toString()))
            return OrderStatus.VIEW_HELD_ORDERS;
        else if (orderStatus.equalsIgnoreCase(StepsOrderStatus.COMPLETE.toString()))
            return OrderStatus.VIEW_COMPLETED_ORDERS;
        else
            throw new IllegalArgumentException("Unknown order status: " + orderStatus);
    }

    protected String getOrderType(String orderType) {
        if (orderType.equalsIgnoreCase(StepsOrderType.TV.toString()))
            return OrderType.TV.getOrderType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.MUSIC.toString()))
            return OrderType.MUSIC.getOrderType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.PRINT.toString()))
            return OrderType.PRINT.getOrderType();
        else
            throw new IllegalArgumentException("Unknown order type: " + orderType);
    }

    protected String getItemTypeByOrderType(String orderType) {
        if (orderType.equalsIgnoreCase(StepsOrderType.TV.toString()))
            return OrderType.TV.getOrderItemType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.MUSIC.toString()))
            return OrderType.MUSIC.getOrderItemType();
        else if (orderType.equalsIgnoreCase(StepsOrderType.PRINT.toString()))
            return OrderType.PRINT.getOrderItemType();
        else
            throw new IllegalArgumentException("Unknown order type: " + orderType);
    }

    protected String getOrderItemContentId(OrderItem orderItem) {
        if (orderItem.getAssetId() != null)
            return orderItem.getAssetId();
        else if (orderItem.getQCAssetId() != null)
            return orderItem.getQCAssetId();
        else
            throw new NullPointerException("There is no any content in order item!");
    }

    protected String getOrderItemContentIdForIngest(OrderItem orderItem) {
       if (orderItem.getQCAssetId() != null)
            return orderItem.getQCAssetId();
        else
            throw new NullPointerException("There is no any content in order item!");
    }

    protected String getOrderItemContentIdForClones(OrderItem orderItem,String destinationName) {
        String destinationQcAssetid =null;
        if (orderItem.getAssetId() != null) {
            return orderItem.getAssetId();
        }
        else if (orderItem.getDestinationItems() != null) {
            for (DestinationItem Item : orderItem.getDestinationItems()) {
                if (Item.getName().contains(destinationName)) {
                    destinationQcAssetid = Item.getQcAssetId();
                }
            }
            return destinationQcAssetid;
        } else {
            throw new NullPointerException("There is no any content in order item!");
        }
    }

    protected String getOrderItemContentIdWithQcedAsset(OrderItem orderItem) {
        if (orderItem.getQCAssetId() != null)
            return orderItem.getQCAssetId();
        else
            throw new NullPointerException("There is no any content in order item!");
    }

    protected String getCategoryId(String categoryName) {
        AssetFilter category = getCoreApi().getAssetsFilterByName(categoryName, "");
        if (category != null) return category.getId();
        throw new RuntimeException(String.format("Could not find category '%s'", categoryName));
    }

    protected Content getAsset(String collectionId, String assetId) {
        // asset which directly uploaded to library is not wrapped and have some extension
        Common.sleep(1000);
        return getCoreApi().getAssetByName(collectionId, assetId);
    }

    protected String getAgencyName(String agencyName) {
        return getAgencyByName(agencyName).getName();
    }

    protected boolean isAutoGenerateClockNumber(String fieldValue) {
        return fieldValue.contains("AutoCode");
    }

    protected boolean isClockNumberFromARPPSystem(String clockNumber) {
        return clockNumber.startsWith("FR_TSTM");
    }

    protected String wrapVariableByCriteria(String variable) {
        return variable.contains(".") || variable.toLowerCase().contains("test") ? variable : wrapVariableWithTestSession(variable);
    }

    protected String convertDateToDefaultUserLocale(String date) {
        return DateTimeUtils.formatDate(parseDate(date), getCurrentUserDateFormat());
    }

    protected String convertDateToDefaultUserLocale(DateTime dateTime) {
        return DateTimeUtils.formatDate(dateTime, getCurrentUserDateFormat());
    }

    protected String convertDateTimeToDefaultUserLocale(DateTime dateTime) {
        return DateTimeUtils.formatDate(dateTime, getCurrentUserDateTimeFormat());
    }

    protected String convertDateToDefaultStoriesFormat(DateTime dateTime) {
        return DateTimeUtils.formatDate(dateTime, getContext().userDateTimeFormat);
    }

    protected String convertDateToEnGbFormat(String date) {
        return DateTimeUtils.formatDate(parseDate(date), UserDateFormat.getForLanguage("en-gb").getDateFormat());
    }

    protected DateTime convertDateTimeToDefaultUserTimeZone(DateTime dateTime) {
        return dateTime.toDateTime(DateTimeZone.forTimeZone(TimeZone.getDefault()));
    }

    protected DateTime convertDateTimeToUTC(DateTime dateTime) {
        return dateTime.toDateTime(DateTimeZone.forTimeZone(TimeZone.getTimeZone("UTC")));
    }

    protected DateTime parseDate(String date) {
        return DateTimeUtils.parseDate(date, getContext().userDateTimeFormat);
    }

    protected DateTime parseDateWithUTCZone(String date) {
        return DateTimeUtils.parseDateWithUTCZone(date, getContext().userDateTimeFormat);
    }

    protected DateTime parseDateTime(String date) {
        return DateTimeUtils.parseDate(date, String.format("%s %s", getContext().userDateTimeFormat, getContext().userTimeFormat));
    }

    protected String formatDateToDefaultUserLocale(DateTime dateTime) {
        return DateTimeUtils.formatDate(convertDateTimeToDefaultUserTimeZone(dateTime), getCurrentUserDateFormat());  // useful for core's dates because they are always in UTC format
    }

    protected String formatDateTimeToDefaultUserLocale(DateTime dateTime) {
        return DateTimeUtils.formatDate(convertDateTimeToDefaultUserTimeZone(dateTime), getCurrentUserDateTimeFormat());
    }

    protected String formatDateTimeToUTC(String date) {
        return DateTimeUtils.getFormattedUTCDate(date, getCurrentUserDateTimeFormat());
    }

    protected String formatDateToDefaultStoriesFormat(String date) {
        return DateTimeUtils.formatDate(parseDate(date), getContext().userDateTimeFormat);
    }

    protected String prepareDate(String date) {
        switch (date) {
            case "Today": return convertDateToDefaultUserLocale(new DateTime());
            case "Yesterday": return convertDateToDefaultUserLocale(new DateTime().minus(Period.days(1)));
            case "Tomorrow": return convertDateToDefaultUserLocale(new DateTime().plus(Period.days(1)));
            default: return convertDateToDefaultUserLocale(date);
        }
    }

    protected String prepareDateToStoriesFormat(String date) {
        switch (date) {
            case "Today": return convertDateToDefaultStoriesFormat(new DateTime());
            case "Yesterday": return convertDateToDefaultStoriesFormat(new DateTime().minus(Period.days(1)));
            case "Tomorrow": return convertDateToDefaultStoriesFormat(new DateTime().plus(Period.days(1)));
            default: throw new IllegalArgumentException("Unknown date: " + date);
        }
    }

    // useful for preparing dates for core
    protected DateTime prepareDateTime(String date) {
        switch (date) {
            case "Today": return convertDateTimeToUTC(new DateTime());
            case "Yesterday": return convertDateTimeToUTC(new DateTime().minus(Period.days(1)));
            case "Tomorrow": return convertDateTimeToUTC(new DateTime().plus(Period.days(1)));
            case "Last Week": return convertDateTimeToUTC(new DateTime().minus(Period.weeks(1)));
            case "Last Month": return convertDateTimeToUTC(new DateTime().minus(Period.months(1)));
            default: throw new IllegalArgumentException("Unknown date: " + date);
        }
    }

    protected String prepareAdvertiser(String advertiser) {
        if (advertiser.equalsIgnoreCase("various") || advertiser.toLowerCase().contains("test")) return advertiser;
        return getData().getAgencyByName(advertiser) != null
               ? getData().getAgencyByName(advertiser).getName()
               : wrapVariableWithTestSession(advertiser);
    }

    protected String prepareAdvertiserWithoutTestSession(String advertiser) {
        if (advertiser.equalsIgnoreCase("various") || advertiser.toLowerCase().contains("test")) return advertiser;
        return getData().getAgencyByName(advertiser) != null
                ? getData().getAgencyByName(advertiser).getName()
                : advertiser;
    }

    protected String prepareAdvertiserHierarchyValue(String catalogValue) {
        if (catalogValue.equalsIgnoreCase("various")) return catalogValue;
        return wrapVariableWithTestSession(catalogValue);
    }

    // advertiser structure may has some custom descriptions
    protected void prepareAdvertiserHierarchyWithDescriptions(Map<String, String> row) {
        List<String> keys = Lists.newArrayList(row.keySet());
        for (String key : keys) {
            if (key.startsWith(SchemaField.ADVERTISER.toString())) {
                row.put("Advertiser Description", key);
                row.put(SchemaField.ADVERTISER.toString(), wrapVariableWithTestSession(row.get(key)));
                if (!key.equals(SchemaField.ADVERTISER.toString())) row.remove(key); // to clear extra data
            } else if (key.startsWith(SchemaField.BRAND.toString())) {
                row.put("Brand Description", key);
                row.put(SchemaField.BRAND.toString(), wrapVariableWithTestSession(row.get(key)));
                if (!key.equals(SchemaField.BRAND.toString())) row.remove(key); // to clear extra data
            } else if (key.startsWith(SchemaField.SUB_BRAND.toString())) {
                row.put("Sub Brand Description", key);
                row.put(SchemaField.SUB_BRAND.toString(), wrapVariableWithTestSession(row.get(key)));
                if (!key.equals(SchemaField.SUB_BRAND.toString())) row.remove(key); // to clear extra data
            } else if (key.startsWith(SchemaField.PRODUCT.toString())) {
                row.put("Product Description", key);
                row.put(SchemaField.PRODUCT.toString(), wrapVariableWithTestSession(row.get(key)));
                if (!key.equals(SchemaField.PRODUCT.toString())) row.remove(key); // to clear extra data
            } else if (key.startsWith(SchemaField.CAMPAIGN.toString())) {
                row.put("Campaign Description", key);
                row.put(SchemaField.CAMPAIGN.toString(), wrapVariableWithTestSession(row.get(key)));
                if (!key.equals(SchemaField.CAMPAIGN.toString())) row.remove(key); // to clear extra data
            }
        }
    }

    protected String prepareDestination(String destination) {
        // additional destinations must contains symbol _ or last symbols are digit
        return destination.contains("_") || destination.matches("\\D+\\d+") ? wrapVariableWithTestSession(destination) : destination;
    }

    protected String prepareAssignees(String assignees) {
        StringBuilder assigneeEmails = new StringBuilder();
        String[] assigneesArr = assignees.split(",");
        for (int i = 0; i < assigneesArr.length; i++) {
            assigneeEmails.append(wrapUserEmailWithTestSession(assigneesArr[i]));
            if (i != assigneesArr.length - 1) assigneeEmails.append(", ");
        }
        return assigneeEmails.toString();
    }

    protected Map<String, String> prepareAssignSomeoneToSupplyMediaData(Map<String, String> row) {
        if (row.containsKey("Order Number")) {
            String[] clocks = row.get("Order Number").split(",");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < clocks.length; i++) {
                sb.append(getOrderByItemClockNumber(wrapVariableWithTestSession(clocks[i])).getOrderReference());
                if (i != clocks.length - 1) sb.append(",");
            }
            row.put("Order Number", sb.toString());
        }
        if (row.containsKey("Clock Number")) {
            String[] clockNumbers = row.get("Clock Number").split(",");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < clockNumbers.length; i++) {
                sb.append(wrapVariableWithTestSession(clockNumbers[i]));
                if (i != clockNumbers.length - 1) sb.append(",");
            }
            row.put("Clock Number", sb.toString());
        }
        if (row.containsKey("Assignee")) row.put("Assignee", prepareAssignees(row.get("Assignee")));
        if (row.containsKey("Previous Assignee")) row.put("Previous Assignee", prepareAssignees(row.get("Previous Assignee")));
        if (row.containsKey("Post House")) row.put("Post House", wrapUserEmailWithTestSession(row.get("Post House")));
        if (row.containsKey("Already Supplied")) row.put("Already Supplied", String.valueOf(row.get("Already Supplied").equals("should")));
        if (row.containsKey("Deadline Date")) row.put("Deadline Date", !row.get("Deadline Date").isEmpty() ? convertDateToDefaultUserLocale(row.get("Deadline Date")) : "");
        return row;
    }

    protected String parseHtml(String html) {
        return html
                .replace("\r\n", " ")
                .replaceAll("<style>.+</style>", "")
                .replace("<br>", "\r\n")
                .replaceAll("\r\n(\r\n)+", "\r\n")
                .replaceAll("<[^>]+>", "")
                .replace("\t", " ")
                .replaceAll("  +", " ")
                .replaceAll("&nbsp;", " ")
                .replaceAll("&amp;", "&")
                .replaceAll("\n+", "")
                .replaceAll(" +", " ")
                .trim();
    }

    protected byte[] decodeBase64String(String base64String) {
        return Base64.decodeBase64(base64String);
    }

    protected String convertNonUnicodeCharactersToUTF8(String characters) {
        try {
            byte[] isoBytes = characters.getBytes("ISO-8859-1");
            return new String(isoBytes, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            ex.printStackTrace();
            return "";
        }
    }


    protected void waitForOrderItemWillHaveParticularA5ViewStatus(String orderId,String clockNumber,String status,long timeOut){
        long start = System.currentTimeMillis();
        OrderItem orderItem;
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 2);
            if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                throw new TimeoutException("Timeout during waiting status " + status + " for order item");
            }
            orderItem = getCoreApiAdmin().getOrderItemByClockNumber(orderId, wrapVariableWithTestSession(clockNumber));
        } while (!orderItem.getDestinationItems()[0].getViewStatus()[0].equals(status));
    }

}