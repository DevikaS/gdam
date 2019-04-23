package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.JsonObjects.UserDateFormat;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.openqa.selenium.TimeoutException;

import java.io.IOException;
import java.util.TimeZone;

/**
 * Created by denysb on 13/11/2015.
 */
public class TrafficHelperSteps extends BaseStep {


    private final static long placeOrderToTrafficTimeOut = 60 * 6000; //6min
    private final static long statusReplicationToTraffic = 60 * 12000; //9min
    private final static long statusReplicationToTrafficAsGDN = 60 * 9000; //9min
    protected void waitForFinishPlaceOrderFromA4ToTraffic(String orderId, long timeOut) {
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > placeOrderToTrafficTimeOut) {
                    throw new TimeoutException("Timeout during place order to Traffic!");
                }
            } while (getMtApi().getOrderFromTraffic(orderId)==500||getMtApi().getOrderFromTraffic(orderId)==404);
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }

    protected void waitForFinishPlaceOrderFromA4ToTraffic(String orderId,String qcAssetId, long timeOut) {
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > placeOrderToTrafficTimeOut) {
                    throw new TimeoutException("Timeout during place order to Traffic!");
                }
            } while (getMtApi().getOrderFromTraffic(orderId,qcAssetId)==500||getMtApi().getOrderFromTraffic(orderId,qcAssetId)==404);
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }

    protected void waitForOrderItemWillHaveParticularStatusInTraffic(String orderId, String qcAssetId, String status, long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 3);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getOrderItemStatusFromTraffic(orderId, qcAssetId).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }


    protected void waitForOrderWillHaveParticularStatusInTraffic(String orderId, String qcAssetId, String status, long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 3);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getOrderStatusFromTraffic(orderId, qcAssetId).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }



    protected void waitForOrderItemWillHaveParticularBroadcasterStatusInTraffic(String orderId,String qcAssetId, String status, long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 1);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getOrderItemBroadcasterStatusfromTraffic(orderId, qcAssetId).equals(status));
        } catch (Exception e) {
            log.error(Common.exceptionToString(e));
        }
    }

    protected void waitForOrderItemWillHaveParticularBroadcasterStatusInTrafficForDestination(String orderId,String qcAssetId, String status, long timeOut,String destination){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getOrderItemBroadcasterStatusfromTrafficForDestination(orderId, qcAssetId,destination).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }


    protected void waitForOrderItemWillHaveParticularA5ViewStatusInTraffic(String orderId,String qcAssetId, String status, long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getOrderItemA5ViewStatusfromTraffic(orderId, qcAssetId).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }

    protected void waitTillOrderItemWillHaveParticularDestinationStatusInTraffic(String orderId, String destinationName,String status, long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getDeliveryStatusfromTraffic(orderId,destinationName).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }

    protected void waitTillOrderItemWillHaveParticularDestinationStatusInTraffic(String orderId,String qcAssetId, String destinationName,String status, long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > statusReplicationToTrafficAsGDN) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
             } while (getMtApi().getDeliveryStatusfromTraffic(orderId,qcAssetId,destinationName)==null || !getMtApi().getDeliveryStatusfromTraffic(orderId,qcAssetId,destinationName).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
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


    protected void waitForOrderWillHaveMasterReceivedDateInTraffic(String orderId, String qcAssetId,long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during checking Master Received Date for order item");
                }
            } while (getMtApi().getMasterReceivedDateTraffic(orderId, qcAssetId).equals("-"));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }


    protected void waitForOrderItemWillHaveParticularAdditionalServicesStatusInTraffic(String orderId,String qcAssetId, String destination,String status, String servcieType,long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 1);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getAdditionalServiceStatusFromTraffic(orderId, qcAssetId,destination,servcieType).equals(status));
        } catch (Exception e) {
            log.error(Common.exceptionToString(e));
        }
    }


    protected void waitForOrderItemWillHaveParticularA5ViewStatusInTraffic(String orderId,String qcAssetId, String destination,String status, long timeOut){
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getMtApi().getOrderItemA5ViewStatusfromTraffic(orderId, qcAssetId,destination).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }

    protected void waitForOrderItemWillHaveParticularA5ViewStatusInTrafficForClones(String orderId,String destination,String status, long timeOut) {
        long start = System.currentTimeMillis();
        try {
            do {
                if (timeOut > 0)
                    Common.sleep(timeOut * 2);
                if (System.currentTimeMillis() - start > statusReplicationToTraffic) {
                    throw new TimeoutException("Timeout during waiting status " + status + " for order item");
                }
            } while (!getCoreApi().getOrderItemA5ViewStatusfromTrafficForClones(orderId, destination).equals(status));
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
    }
}
