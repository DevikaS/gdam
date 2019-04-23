package com.adstream.automate.babylon.tests.steps.domain.ingest;


import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.gdn.*;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.OrderList;
import com.adstream.automate.babylon.tests.steps.core.GdnBase;
import com.adstream.automate.babylon.tests.steps.domain.LoginSteps;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import com.adstream.gdn.api.client.serialization.DeliveryJobResponse;
import com.adstream.gdn.api.client.serialization.TerminateJobResponse;
import com.adstream.gdn.api.client.serialization.TranscodeJobResponse;
import com.adstream.gdn.api.engine.serialization.TranscodeAction;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.google.gson.Gson;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.jetbrains.annotations.NotNull;
import org.testng.Assert;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;


/**
 * Created by Ramababu.Bendalam on 13/01/2016.
 */
public class GdnIngestSteps extends GdnDocFinder {

    public String response = null;

    private int noOfTranscodeJobs = 0;

    public GdnIngestSteps() {
        super();
    }

    /* ingest assest with the specified clocks */
    @Given("{I |}ingest assests with following clocks: $clockNumberList")
    @When("{I |}ingested assests with following clocks: $clockNumberList")
    @Then("{I |}Re-ingested assests with following clocks: $clockNumberList")
    public void ingest(ExamplesTable fieldsTable) throws IOException, InterruptedException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            GdnBase.ingest(wrapVariableWithTestSession(row.get("ClockNumberList")));
        }
    }

    /* checks the total count of deliveries*/
    @When("{I |}find '$response' to the '$count' destinations")
    @Then("{I |}find '$response' to the '$count' destinations")
    public void deliveryJob(String response, int count) throws UnsupportedEncodingException, MalformedURLException {
        List<String> responses = new ArrayList<String>();
        responses.add(response);
        List<DeliveryJobResponse> deliveryJobResponse = getAMQService().receiveDeliveryJobResponseCommon(count, response, responses);
        Assert.assertEquals(String.valueOf(deliveryJobResponse.size()), String.valueOf(count), "total delveries are not as expected");

    }

    @When("{I |}find '$response' to the destinations with following fields: $fieldsTable")
    @Then("{I |}find '$response' to the destinations with following fields: $fieldsTable")
    public void terminateJob(String response, ExamplesTable fieldsTable) throws UnsupportedEncodingException, MalformedURLException {
        int count = 1;
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            List<String> destinationExtId = new java.util.ArrayList<String>();
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                List<GDNDestinations> destinations = gdnDeliveryDoc.get(k).getDestinations();
                for (int j = 0; j < destinations.size(); j++) {
                    destinationExtId.add(destinations.get(j).getExternalId());
                }
                List<TerminateJobResponse> terminateJobResponse = getAMQService().receiveTerminateJobResponse(count, response, destinationExtId);
                Assert.assertTrue(Integer.valueOf(terminateJobResponse.size()) >= count);
            }
        }
    }

    @Given("{I |}ingested assests through A5 with following fields: $fieldsTable")
    @When("{I |}ingested assests through A5 with following fields: $fieldsTable")
    @Then("{I |}ingest assests through A5 with following fields: $fieldsTable")
    public void ingestA5(ExamplesTable fieldsTable) throws IOException, InterruptedException {
        String assetId = null;
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("clockNumber"));
            String agencyName = row.get("agencyName");
            String destinationName = row.get("destinations");
            Order order = getOrderByItemClockNumber(clockNumber);
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
            if (destinationName != null) {
                assetId = getOrderItemContentIdForClones(orderItem, destinationName);
            } else {
                assetId = getOrderItemContentIdForIngest(orderItem);
            }
            Agency agency = getAgencyByName(agencyName);
            File file = new File(TestsContext.getInstance().testDataFolderName + "/" + "files/sampleVideo_Master.zip");
            response = getCoreApi().IngestAssetA5(agency.getStorageId(), file, assetId, agency.getId(), null);
        }
    }

    @When("{I |}set comment to order using traffic manager: $fieldsTable")
    @Then("{I |}set comment to order using traffic manager: $fieldsTable")
    public void setcomment(ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            String clockNumber = wrapVariableWithTestSession(row.get("clockNumber"));
            Order order = getOrderByItemClockNumber(clockNumber);
            getTrafficCoreApi().setCommentTraffic(order.getId(), userId);
        }
    }

    @When("{I |}set master arrived comment to order using traffic manager: $fieldsTable")
    @Then("{I |}set master arrived comment to order using traffic manager: $fieldsTable")
    public void setMasterArrived(ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            User orderinguser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("OrderingEmail")));
            String orderinguserId = orderinguser == null ? wrapVariableWithTestSession(row.get("OrderingEmail")) : orderinguser.getId();
            User adpathuser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("adpathEmail")));
            String adpathuserId = adpathuser == null ? wrapVariableWithTestSession(row.get("adpathEmail")) : adpathuser.getId();
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(row.get("clockNumber")));
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(row.get("clockNumber")));
            getCoreApi().setMasterArrived(order.getId(), orderItem.getId(), orderinguserId, adpathuserId, row);
        }
    }

    @When("{I |}remove master arrived comment to order using traffic manager: $fieldsTable")
    @Then("{I |}remove master arrived comment to order using traffic manager: $fieldsTable")
    public void removeMasterArrived(ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            User orderinguser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("OrderingEmail")));
            String orderinguserId = orderinguser == null ? wrapVariableWithTestSession(row.get("OrderingEmail")) : orderinguser.getId();
            User adpathuser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("adpathEmail")));
            String adpathuserId = adpathuser == null ? wrapVariableWithTestSession(row.get("adpathEmail")) : adpathuser.getId();
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(row.get("clockNumber")));
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(row.get("clockNumber")));
            getCoreApi().removeMasterArrived(order.getId(), orderItem.getId(), orderinguserId, adpathuserId);
        }
    }

    @Given("{I |}verify ingest doc for following fields: $fieldsTable")
    @When("{I |}verify ingest doc for following fields: $fieldsTable")
    @Then("{I |}verify ingest doc for following fields: $fieldsTable")
    public void verifyIngestdoc(ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(wrapVariableWithTestSession(row.get("clockNumber"))));
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(row.get("clockNumber")));
            String assetId = getOrderItemContentId(orderItem);
            IngestDoc ingestdoc = getCoreApi().getIngestId(assetId);
            IngestChecklist ingestChecklist = new IngestChecklist();
            ingestChecklist.checkIngestlist(getCoreApi(), assetId, ingestdoc, row);
        }
    }

    @When("{I |}set assest status to '$status' for following fields:$fieldsTable")
    @Then("{I |}set assest status to '$status' for following fields:$fieldsTable")
    public void setStatus(String status, ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            String clockNumber = wrapVariableWithTestSession(row.get("clockNumber"));
            Order order = getOrderByItemClockNumber(clockNumber);
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
            String assetId = getOrderItemContentId(orderItem);
            getCoreApi().setAssetStatus(assetId, userId, status);
        }
    }

    @When("{I |}set assest Durations:$fieldsTable")
    @Then("{I |}set assest Durations:$fieldsTable")
    public void setAssetDurations(ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            User orderinguser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("OrderingEmail")));
            String orderinguserId = orderinguser == null ? wrapVariableWithTestSession(row.get("OrderingEmail")) : orderinguser.getId();
            User adpathuser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("adpathEmail")));
            String adpathuserId = adpathuser == null ? wrapVariableWithTestSession(row.get("adpathEmail")) : adpathuser.getId();
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(row.get("clockNumber")));
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(row.get("clockNumber")));
            String assetId = getOrderItemContentId(orderItem);
            getCoreApi().setDuration(assetId, orderinguserId, adpathuserId);
        }
    }

    @When("{I |}retranscode assest:$fieldsTable")
    @Then("{I |}retranscode assest:$fieldsTable")
    public void retranscodeAsset(ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            User orderinguser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("OrderingEmail")));
            String orderinguserId = orderinguser == null ? wrapVariableWithTestSession(row.get("OrderingEmail")) : orderinguser.getId();
            User adpathuser = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("adpathEmail")));
            String adpathuserId = adpathuser == null ? wrapVariableWithTestSession(row.get("adpathEmail")) : adpathuser.getId();
            String clockNumber = wrapVariableWithTestSession(row.get("clockNumber"));
            Order order = getOrderByItemClockNumber(clockNumber);
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
            String assetId = getOrderItemContentId(orderItem);
            getCoreApi().retranscodeAsset(assetId, orderinguserId, adpathuserId);
        }
    }

    @Then("{I |}check order status set to '$status' for clock '$clockNumber'")
    public void getOrderStatus(String status, String clockNumber) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        Gson gson = new Gson();
        String jsonInString = gson.toJson(order.getStatus());
        Assert.assertTrue(jsonInString.toString().contains(status), "status was not set to" + status);
    }

    @Then("{I |}deliver order using orderId with following fields:$fieldsTable")
    public void deliverbyOrderId(ExamplesTable fieldsTable) throws IOException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapVariableWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail("qatbabylonautotester+" + email + "@gmail.com");
            String userId = user == null ? email : user.getId();
            Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
            getCoreApi().orderdeliverbyOrderId(order.getId(), userId);
        }
    }

    @When("{I |}redeliver asset using externalId to the destinations with following fields:$fieldsTable")
    @Then("{I |}redeliver asset using externalId to the destinations with following fields:$fieldsTable")
    public void redeliverAssetbyExtId(ExamplesTable fieldsTable) throws IOException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                List<GDNDestinations> destinations = gdnDeliveryDoc.get(k).getDestinations();
                for (int j = 0; j < destinations.size(); j++) {
                    if (destinations.get(j).getId().equals(row.get("DestinationID"))) {
                        getCoreApi().redeliverAssetbyExtId(destinations.get(j).getExternalId(), userId);
                    }
                }
            }
        }
    }

    @Then("{I |}redeliver asset using deliveryId to the destinations with following fields:$fieldsTable")
    public void redeliverAssetbyDeliveryId(ExamplesTable fieldsTable) throws IOException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                getCoreApi().redeliverAssetbyDeliveryId(gdnDeliveryDoc.get(k).get_id(), userId);
            }
        }
    }

    @Then("{I |}cancel delivery using externalId to the destinations with following fields:$fieldsTable")
    public void cancelDeliverybyExtId(ExamplesTable fieldsTable) throws IOException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                List<GDNDestinations> destinations = gdnDeliveryDoc.get(k).getDestinations();
                for (int j = 0; j < destinations.size(); j++) {
                    getCoreApi().cancelDeliverybyExtId(destinations.get(j).getExternalId(), userId);
                }
            }
        }
    }

    @Then("{I |}cancel delivery using deliveryId to the destinations with following fields:$fieldsTable")
    public void cancelDeliverybyDeliveryId(ExamplesTable fieldsTable) throws IOException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                getCoreApi().cancelDeliverybyDeliveryId(gdnDeliveryDoc.get(k).get_id(), userId);
            }
        }
    }

    @Then("{I |}read delivery job response with following fields: $fieldsTable")
    public void getdeliveryWorkflow(ExamplesTable fieldsTable) throws IOException, SAXException, ParserConfigurationException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                List<GDNDestinations> destinations = gdnDeliveryDoc.get(k).getDestinations();
                row.put("uniqueName", clockNumber);
                row.put("OrderReference", gdnDeliveryDoc.get(k).getOrderReference());
                row.put("assetID", gdnDeliveryDoc.get(k).getAssetId());
                row.put("agencyID", getAgencyIdByName(wrapVariableWithTestSession(row.get("AgencyUnique"))));
                row.put("agency", wrapVariableWithTestSession(row.get("AgencyUnique")));
                row.put("advertiser", wrapVariableWithTestSession(row.get("Advertiser")));
                row.put("product", wrapVariableWithTestSession(row.get("Product")));
                row.put("campaign", wrapVariableWithTestSession(row.get("Campaign")));
                row.put("title", wrapVariableWithTestSession(row.get("Title")));
                row.put("createdByEmail", email);
                row.put("createdByFirstName", user.getFirstName());
                row.put("createdByLastName", user.getLastName());

                if (row.containsKey("Motivnummer")) {
                    row.put("customField.Motivnummer", wrapVariableWithTestSession(row.get("Motivnummer")));
                }
                if (row.containsKey("Subtitles Required")) {
                    if (row.get("Subtitles Required").equalsIgnoreCase("Yes")) {
                        row.put("customField.Subtitles Required", "Yes");
                    } else {
                        row.put("customField.Subtitles Required", "Already Supplied");
                    }
                }
                if (row.containsKey("Watermarking Required")) {
                    row.put("customField.Watermarking Required", "Yes");
                }
                if (row.containsKey("Clave")) {
                    row.put("customField.Clave", row.get("Clave"));
                }

                java.util.Set<MetaDataAttribute> expectedAttributes = GDNDeliveryResponse.getExpectedAttributes(row);
                for (int j = 0; j < destinations.size(); j++) {
                    destinations = gdnDeliveryDoc.get(k).getDestinations();
                    WorkflowAction workflowAction = getGDNApi().getworkflowAction(destinations.get(j).getGdnWorkflowId());
                    String xml = workflowAction.getXml();
                    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                    DocumentBuilder builder = factory.newDocumentBuilder();
                    StringBuilder xmlStringBuilder = new StringBuilder();
                    xmlStringBuilder.append(xml);
                    ByteArrayInputStream input = new ByteArrayInputStream(xmlStringBuilder.toString().getBytes("UTF-8"));
                    Document doc = builder.parse(input);
                    NodeList nList = doc.getElementsByTagName("property");
                    java.util.Set<MetaDataAttribute> actualAttributes = new java.util.HashSet();
                    for (int x = 0, size = nList.getLength(); x < size; x++) {
                        Element element = (Element) nList.item(x);
                        MetaDataAttribute attribute = new MetaDataAttribute(element.getAttribute("name"), element.getFirstChild().getNodeValue());
                        actualAttributes.add(attribute);
                    }
                    assertTrue(Sets.intersection(expectedAttributes, actualAttributes).size() == expectedAttributes.size(), "Expected " + expectedAttributes.toString() + "but found " + actualAttributes.toString());
                }
            }
        }
    }

    @Then("{I |}read asset duration for retranscode action")
    public void consumeTranscode() throws IOException, ParserConfigurationException, SAXException {
        List<String> responses = new ArrayList<String>();
        responses.add(response);
        List<TranscodeJobResponse> transcodeJobResponseList = getAMQService().receiveTranscodeJobResponseCommon(4, "TranscodeJobResponse", responses);
        Boolean flag = false;
        java.util.Set<MetaDataAttribute> expectedAttributes = new java.util.HashSet();
        java.util.Set<MetaDataAttribute> actualAttributes = new java.util.HashSet();
        for (int m = 0, size1 = transcodeJobResponseList.size(); m < size1; m++) {
            String workflowActioId = String.valueOf(transcodeJobResponseList.get(m).WorkflowID()).replace("Some(", "").replace(")", "");
            WorkflowAction workflowAction = getGDNApi().getworkflowAction(workflowActioId);
            String xml = workflowAction.getXml();
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            StringBuilder xmlStringBuilder = new StringBuilder();
            xmlStringBuilder.append(xml);
            ByteArrayInputStream input = new ByteArrayInputStream(xmlStringBuilder.toString().getBytes("UTF-8"));
            Document doc = builder.parse(input);
            NodeList nList = doc.getElementsByTagName("property");
            expectedAttributes.add(new MetaDataAttribute("firstActiveFrame", "75"));
            expectedAttributes.add(new MetaDataAttribute("fullDurationInFrames", "750"));
            expectedAttributes.add(new MetaDataAttribute("adDurationInFrames", "500"));
            for (int x = 0, size = nList.getLength(); x < size; x++) {
                Element element = (Element) nList.item(x);
                MetaDataAttribute attribute = new MetaDataAttribute(element.getAttribute("name"), element.getFirstChild().getNodeValue());
                actualAttributes.add(attribute);
            }
            if (Sets.intersection(expectedAttributes, actualAttributes).size() == expectedAttributes.size()) {
                flag = true;
                break;
            }
        }
        if (flag == false) {
            assertTrue(Sets.intersection(expectedAttributes, actualAttributes).size() == expectedAttributes.size(), "Expected " + expectedAttributes.toString() + "but found " + actualAttributes.toString());
        }
    }

    @Given("{I |}modify Destination collection for following fields: $fieldsTable")
    @When("{I |}modify Destination collection for  following fields: $fieldsTable")
    public void modifyMongoDestinationCollection(ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            DBCollection schemaCollection = getMongoDB().getCollection("destination");
            MongoDestinationCollection mongoDestinationCollection = new MongoDestinationCollection();
            mongoDestinationCollection.setMongoDoc(row, schemaCollection);
        }
    }

    public String getAssetIDAfterIngestA5(String clockNum, String orderId) {
        String clockNumber = wrapVariableWithTestSession(clockNum);
        OrderItem orderItem = getOrderItemByClockNumberAsGlobalAdmin(orderId, clockNumber);
        return getOrderItemContentId(orderItem);
    }

    @Given("{I |}refresh destinations")
    @When("{I |}refresh destinations")
    public void refreshDestinations() throws IOException {
        getCoreApi().refreshDestinations();
    }

    @Given("{I |}approve destinations with following fields:$fieldsTable")
    @When("{I |}approve destinations with following fields:$fieldsTable")
    public void approveDestinations(ExamplesTable fieldsTable) throws UnsupportedEncodingException, MalformedURLException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumber"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                List<GDNDestinations> destinations = gdnDeliveryDoc.get(k).getDestinations();
                for (int j = 0; j < destinations.size(); j++) {
                    if (destinations.get(j).getId().equals(row.get("DestinationID"))) {
                        getCoreApi().setHouseNumber(userId, destinations.get(j).getExternalId(), row.get("HouseNumber"));
                    }
                }
            }
        }
    }

    @When("{I |}check DeliveryStatus of A5 with following fields:$fieldsTable")
    @Then("{I |}check DeliveryStatus of A5 with following fields:$fieldsTable")
    public void checkDeliveryStatus(ExamplesTable fieldsTable) throws IOException, SAXException, ParserConfigurationException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            List<GDNDeliveryDoc> gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
            for (int k = 0; k < gdnDeliveryDoc.size(); k++) {
                List<GDNDestinations> destinations = gdnDeliveryDoc.get(k).getDestinations();
                for (int j = 0; j < destinations.size(); j++) {
                    if (destinations.get(j).getId().equals(row.get("DestinationID"))) {
                        deliveryStatusCheck(getCoreApi(), clockNumber, userId, j, k, sleep);
                        gdnDeliveryDoc = getCoreApi().getDeliveryDoc(clockNumber, userId);
                        destinations = gdnDeliveryDoc.get(k).getDestinations();
                        assertEquals(destinations.get(j).getGdnStatus(), row.get("Status"), "status was not set to" + "" + row.get("Status"));
                    }
                }
            }
        }
    }
    @When("{I |}delete ingest repo with following fields:$fieldsTable")
    @Then("{I |}delete ingest repo with following fields:$fieldsTable")
    public void deleteIngestRepo(ExamplesTable fieldsTable) throws MalformedURLException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            Order order = getOrderByItemClockNumber(clockNumber);
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
            String assetId = getOrderItemContentId(orderItem);
            getCoreApi().deleteIngestRepo(assetId);
        }
    }

    @When("{I |}add ingest repo with following fields:$fieldsTable")
    @Then("{I |}add ingest repo with following fields:$fieldsTable")
    public void addIngestRepo(ExamplesTable fieldsTable) throws MalformedURLException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            Order order = getOrderByItemClockNumber(clockNumber);
            OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
            String assetId = getOrderItemContentId(orderItem);
            getCoreApi().addIngestRepo(assetId);
        }
    }

    @When("{I |}start the restranscode Job")
    public void startRetranscodeInA5() {
        noOfTranscodeJobs++;
    }

    @When("{I |}wait for delivery doc available with following fields:$fieldsTable")
    @Then("{I |}wait for delivery doc available with following fields:$fieldsTable")
    public void waitforDeliveryDoc(ExamplesTable fieldsTable) throws MalformedURLException, UnsupportedEncodingException {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String clockNumber = wrapVariableWithTestSession(row.get("ClockNumberList"));
            String email = wrapUserEmailWithTestSession(row.get("Email"));
            User user = getCoreApiAdmin().getUserByEmail(email);
            String userId = user == null ? email : user.getId();
            deliveryDocCheck(getCoreApi(), clockNumber, userId, sleep);
        }
    }

    @When("{I |}should reset the transcode Job")
    @Then("{I |}should reset the transcode Job")
    public void resetRetranscodeInA5() {
        noOfTranscodeJobs = 0;
    }

    @Then("{I |}read asset duration for retranscode action in A5 $fieldsTable")
    public void consumeTranscodeInA5(ExamplesTable fieldsTable) throws IOException, ParserConfigurationException, SAXException {
        List<String> responses = new ArrayList<String>();
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        responses.add(response);
        List<TranscodeJobResponse> transcodeJobResponseList = getAMQService().receiveTranscodeJobResponseCommon(noOfTranscodeJobs, "TranscodeJobResponse", responses);
        Boolean flag = false;
        //  java.util.Set<MetaDataAttribute> expectedAttributes = new java.util.HashSet();
        //   java.util.Set<MetaDataAttribute> actualAttributes = new java.util.HashSet();
        for (int m = 0, size1 = transcodeJobResponseList.size(); m < size1; m++) {
            String workflowActioId = String.valueOf(transcodeJobResponseList.get(m).WorkflowID()).replace("Some(", "").replace(")", "");
            WorkflowAction workflowAction = getGDNApi().getworkflowAction(workflowActioId);
            String xml = workflowAction.getXml();
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            StringBuilder xmlStringBuilder = new StringBuilder();
            xmlStringBuilder.append(xml);
            ByteArrayInputStream input = new ByteArrayInputStream(xmlStringBuilder.toString().getBytes("UTF-8"));
            Document doc = builder.parse(input);
            NodeList nList = doc.getElementsByTagName("property");
            java.util.Set<MetaDataAttribute> expectedAttributes = new java.util.HashSet();
            expectedAttributes.add(new MetaDataAttribute("firstActiveFrame", row.get("First active frame")));
            expectedAttributes.add(new MetaDataAttribute("fullDurationInFrames", row.get("Full Duration in frames")));
            expectedAttributes.add(new MetaDataAttribute("adDurationInFrames", row.get("Ad duration in frames")));
            java.util.Set<MetaDataAttribute> actualAttributes = new java.util.HashSet();
            for (int x = 0, size = nList.getLength(); x < size; x++) {
                Element element = (Element) nList.item(x);
                MetaDataAttribute attribute = new MetaDataAttribute(element.getAttribute("name"), element.getFirstChild().getNodeValue());
                actualAttributes.add(attribute);
            }
            assertTrue(Sets.intersection(expectedAttributes, actualAttributes).size() == expectedAttributes.size(), "Expected " + expectedAttributes.toString() + "but found " + actualAttributes.toString());
        }
    }

    @When("{I |}verify ingest doc status set to '$status' for clock '$clockNumber'")
    @Then("{I |}verify ingest doc status set to '$status' for clock '$clockNumber'")
    public void getIngestdoc(String status, String clockNumber) throws MalformedURLException, UnsupportedEncodingException {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        String assetId = getOrderItemContentId(orderItem);
        long start = System.currentTimeMillis();
//        A5RestService a5RestService = new A5RestService(new URL(TestsContext.getInstance().coreUrl[0] + "/"));
        if (!status.equals("Null")) {
            do {
                Common.sleep(1000);
            } while (!getCoreApi().getIngestId(assetId).getStatus().equalsIgnoreCase(status)
                    && System.currentTimeMillis() - start < 5000);
        } else if (status.equals("Null")) {
            Assert.assertNull(getCoreApi().getIngestId(assetId));
        }
    }


}







