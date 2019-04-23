package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.AMQRequestQueue;
import com.adstream.automate.babylon.JsonObjects.adcost.Costs;
import com.adstream.automate.babylon.JsonObjects.adcost.LongText;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.ActiveMQSslConnectionFactory;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import javax.jms.*;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;

import com.adstream.automate.babylon.JsonObjects.adcost.enums.Commodity;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.equalTo;

/**
 * Created by Raja.Gone on 06/06/2017.
 */
public class AMQMockService extends AdCostsHelperSteps {

    // $action = Reject
    @When("COUPA '$action' the cost with title '$costTitle' to introduce type 4 error message:$data")
    public void updateResponseQueueInAMQType4Error(String action,String costTitle,ExamplesTable data){
        ActivityType type =getActionTypeInMyPurchasesSystem(action);
        MyPurchasesPayloadWrapper wrapper = new MyPurchasesPayloadWrapper( "Pg", type.getActivityType(), getCostDetails(wrapVariableWithTestSession(costTitle)).getCostNumber(), type.getApprovalStatus(),data);
        mockMyPurchaseResponseInAMQ(Arrays.asList(wrapper),TestsContext.getInstance().amqAdcostInternalErrorQueue.toString());
    }

    // $action = Approve || Recall || Cancel || Reject
    @Given("cost with title '$costTitle' is '$action' on behalf of MyPurchases application")
    @When("cost with title '$costTitle' is '$action' on behalf of MyPurchases application")
    public void updateResponseQueueInAMQ(String costTitle, String action){
        ActivityType type =getActionTypeInMyPurchasesSystem(action);
        MyPurchasesPayloadWrapper wrapper = new MyPurchasesPayloadWrapper( "Pg", type.getActivityType(), getCostDetails(wrapVariableWithTestSession(costTitle)).getCostNumber(), "", type.getApprovalStatus());
        mockMyPurchaseResponseInAMQ(Arrays.asList(wrapper),TestsContext.getInstance().amqAdcostInternalQueue.toString());
    }

    // $action = Approve || Recall || Cancel || Reject
    @Given("cost with title '$costTitle' is '$action' on behalf of MyPurchases application by passing payload values:$data")
    @When("cost with title '$costTitle' is '$action' on behalf of MyPurchases application by passing payload values:$data")
    public void updateResponseQueueInAMQByPassingPayloadValues(String costTitle, String action, ExamplesTable data){
        ActivityType type =getActionTypeInMyPurchasesSystem(action);
        MyPurchasesPayloadWrapper wrapper = new MyPurchasesPayloadWrapper( "Pg", type.getActivityType(), getCostDetails(wrapVariableWithTestSession(costTitle)).getCostNumber(), type.getApprovalStatus(),data);
        mockMyPurchaseResponseInAMQ(Arrays.asList(wrapper), TestsContext.getInstance().amqAdcostInternalQueue.toString());
    }

    // $action = Approve || Recall || Cancel || Reject
    @Given("cost with title '$costTitle' is '$action' on behalf of MyPurchases application with page refresh")
    @When("cost with title '$costTitle' is '$action' on behalf of MyPurchases application with page refresh")
    public void updateResponseQueueInAMQWithPageRefresh(String costTitle,String action){
        ActivityType type =getActionTypeInMyPurchasesSystem(action);
        MyPurchasesPayloadWrapper wrapper = new MyPurchasesPayloadWrapper( "Pg", type.getActivityType(), getCostDetails(wrapVariableWithTestSession(costTitle)).getCostNumber(), "", type.getApprovalStatus());
        mockMyPurchaseResponseInAMQ(Arrays.asList(wrapper),TestsContext.getInstance().amqAdcostInternalQueue.toString());
        getSut().getWebDriver().navigate().refresh();
        Common.sleep(5000);
    }

    @Then("{I |}should seee AMQ receives below request for cost title '$costTitle' and type as '$type': $data")
    public void checkAMQRequestQueue(String costTitle, String type, ExamplesTable data){
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        String costNumber = costs.getCostNumber();
        AMQRequestQueue queue= consumeCostsRequestsOnAMQSSL(costNumber, type);
        Map<String, String> row = parametrizeTabularRow(data, 0);

        assertThat("Check 'costNumber' field in AMQ Request Queue: ",queue.getAction().getPayload().getCostNumber(),equalTo(costNumber));
        if (row.containsKey("Total Amount"))
            assertThat("Check 'Total Amount' field in AMQ Request Queue: ",queue.getAction().getPayload().getTotalAmount(), equalTo(row.get("Total Amount")));
        if (row.containsKey("Currency"))
            assertThat("Check 'Currency' field in AMQ Request Queue: ", queue.getAction().getPayload().getCurrency(), equalTo(row.get("Currency")));
        if (row.containsKey("IO Number")) {
            assertThat("Check 'ioNumber' field in AMQ Request Queue: ",queue.getAction().getPayload().getIoNumber(), containsString(row.get("IO Number")));
        }
        if (row.containsKey("Vendor"))
            assertThat("Check 'Vendor' field in AMQ Request Queue: ",queue.getAction().getPayload().getVendor(),equalTo(row.get("Vendor")));
        if (row.containsKey("PO Number"))
            //need to confirm the format and how to get it
            assertThat("Check 'poNumber' field in AMQ Request Queue: ", queue.getAction().getPayload().getIoNumber(),equalTo(row.get("PO Number")));
        if (row.containsKey("Payment Amount"))
            assertThat("Check 'paymentAmount' field in AMQ Request Queue: ", queue.getAction().getPayload().getPaymentAmount(),equalTo(row.get("Payment Amount")));
        if (row.containsKey("Basket Name")) {
            String brand = row.get("Brand");
            if(!brand.equals("DefaultBrand"))
                brand = wrapVariableWithTestSession(row.get("Brand"));
            String expectedBasketName = "ADCOST".concat(costNumber).concat(brand).concat(":").concat(String.valueOf(row.get("Description")));
            String actualBasketName = queue.getAction().getPayload().getBasketName();
            if(actualBasketName.length()<=40)
                assertThat("Check 'Basket Name' in AMQ Request Queue: \n Actual: "+actualBasketName
                        +"\n Expected: "+expectedBasketName, expectedBasketName.contains(actualBasketName));
            else
                assertThat("Check 'Basket Name' length in AMQ Request Queue. Expected length is 40 char's but found: "+queue.getAction().getPayload().getBasketName().length(), false);
        }
        if (row.containsKey("Description_Budget Region")) {
            String contentType;
            if (costs.getCostType().contains("Production"))
                contentType= costs.getContentType();
            else
                contentType="";
            String description = contentType.concat("/").concat(row.get("Description_Budget Region").concat(" ").concat(costNumber));
            assertThat("Check 'description' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getDescription(),equalTo(description));
        }
        if (row.containsKey("Start Date")) {
            //ToDo--probably a bug
        }
        if (row.containsKey("Delivery Date")) {
            // ToDo:
        }
        if (row.containsKey("CategoryId")) {
            assertThat("Check CategoryId on AMQ- expected is: "+row.get("CategoryId")+ " actual category Id : "+queue.getAction().getPayload().getCategoryId(),
                    queue.getAction().getPayload().getCategoryId(),equalTo(row.get("CategoryId")));
        }
        if (row.containsKey("Gl")) {
            assertThat("Check GL code on AMQ- expected is: "+row.get("GL")+ " actual gl code : "+queue.getAction().getPayload().getGl(),
                    queue.getAction().getPayload().getGl(),equalTo(row.get("Gl")));
        }
        if (row.containsKey("TNumber")) {
            // ToDo: only for cyclone costs: need to confirm how we are getting it from COUPA in case of cyclone costs
        }
        if (row.containsKey("RequisitionerEmail")) {
            String reqEmail = wrapUserEmailWithTestSession(row.get("RequisitionerEmail"));
            assertThat("Check 'requisitionerEmail' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getRequisitionerEmail(),equalTo(reqEmail));
        }
        if (row.containsKey("LongText")) {
            LongText lText = generateLongText(row.get("LongText"),type, costs, queue.getAction().getPayload().getPoNumber());
            if(CostActionTypeInMyPurchases.SUBMITTED.toString().equals(type)){
                assertThat("Check 'an field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getAn(),equalTo(lText.getAn()));
                assertThat("Check 'bn field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getBn(),equalTo(lText.getBn()));
            }
            if (CostActionTypeInMyPurchases.CANCELLED.toString().equals(type)){
                assertThat("Check 'bn field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getBn(),equalTo(lText.getBn()));
                assertThat("Check 'vn field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getVn(), equalTo(lText.getVn()));
            }
        }

        if (row.containsKey("Account Code")) {
            //ToDo --need to confirm the format and in which field we are getting it from COUPA while injecting response in amq as brand approver
        }
        if (row.containsKey("Item Code")) {
            //ToDo --need to confirm the format and in which field we are getting it from COUPA while injecting response in amq as brand approver
        }
        if (row.containsKey("GrNumbers")) {
            //ToDo --need to confirm
        }
        if (row.containsKey("Commodity")) {
            String commodity = Commodity.findByType(row.get("Commodity")).getCommodity();
            assertThat("Check 'commodity' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getCommodity(),equalTo(commodity));
        }

    }

    public LongText generateLongText(String productionType, String type, Costs costs, String POnumber){
        String costType = costs.getCostType();
        String stage = getAdcostApi().getCostStage(costs.getId()).getName();
        String adcostUrl = TestsContext.getInstance().applicationUrl.toString();
        LongText longText = new LongText();
        String[] an = new String[1];
        String[] bn = new String[1];
        String[] vn = new String[1];

        switch(CostActionTypeInMyPurchases.findByType(type)){
            case SUBMITTED:
                an[0]=adcostUrl.concat(":8883/#/cost/").concat(costs.getId()).concat("/review");
                longText.setAn(an);
                bn[0]= stage.concat(" APPROVED ").concat(costType).concat(" ").concat(productionType);
                if((POnumber!= null) && (!POnumber.isEmpty())){
                    bn[0]= bn[0].concat(" ").concat(POnumber);
                }
                longText.setBn(bn);
                break;
            case CANCELLED:
                bn[0] = "PROJECT CANCELLED. PLEASE CANCEL PO ".concat(POnumber).concat(" AND REQUEST CN FOR ANY AMOUNTS PAID");
                vn[0] = "PROJECT CANCELLED. PLEASE CANCEL PO AND REQUEST CN FOR ANY AMOUNTS PAID";
                longText.setBn(bn);
                longText.setVn(vn);
                break;
        }
        return longText;
    }

    public void mockMyPurchaseResponseInAMQ(List<MyPurchasesPayloadWrapper> fieldsWrapper, String queueName) {
        try {
            for (MyPurchasesPayloadWrapper fields : fieldsWrapper) {
                ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory(TestsContext.getInstance().amqInternalHostName.toString());
                Connection connection = connectionFactory.createConnection();
                connection.start();
                Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
                javax.jms.Destination destination = session.createQueue(queueName);
                MessageProducer producer = session.createProducer(destination);
                producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
                String responsePayload = buildAMQResponsePayload(fields);
                TextMessage message = session.createTextMessage(responsePayload);
                producer.send(message);
                session.close();
                connection.close();
            }
        } catch (Exception e) {
            throw new Error();
        }
    }

    public AMQRequestQueue consumeCostsRequestsOnAMQSSL(String costNumber, String type){
        try {
            ActiveMQSslConnectionFactory sslConnectionFactory = new ActiveMQSslConnectionFactory();
            sslConnectionFactory.setKeyStore("broker.ks");
            sslConnectionFactory.setKeyStorePassword("adstream");
            sslConnectionFactory.setTrustStore("client.ks");
            sslConnectionFactory.setTrustStorePassword("adstream");

            sslConnectionFactory.setUserName("admin");
            sslConnectionFactory.setPassword("xiet2jei7ohF");
            sslConnectionFactory.setBrokerURL(TestsContext.getInstance().amqExternalHostName.toString());
            Connection con = sslConnectionFactory.createConnection();
            Session session = con.createSession(false, Session.AUTO_ACKNOWLEDGE);

            Destination destination = session.createQueue(TestsContext.getInstance().amqAdcostExternalQueue.toString());
            MessageConsumer consumer = session.createConsumer(destination);
            con.start();

            AMQRequestQueue queue=null;
            Boolean msgFound = false;
            AMQRequestQueue returnQueue=null;
            String queueType =null;
            String queueCostNumber = null;
            Gson gson = new Gson();
            while(true) {
                Message message = consumer.receive(2000); // Increased time to check AMQ steps doesn't fail randomly
                if (message instanceof TextMessage) {
                    TextMessage textMessage = (TextMessage) message;
                    String text = textMessage.getText();
                    queue = gson.fromJson(text,AMQRequestQueue.class);
                    try {
                        queueType = queue.getAction().getType();
                        queueCostNumber = queue.getAction().getPayload().getCostNumber();
                    } catch(Exception e){
                        continue; // make sure loop continued until right message is identified from the queue
                    }
                    if (queueCostNumber.equals(costNumber) && queueType.equals(type)) {
                        returnQueue= queue;
                        msgFound = true;
                    }
                } else {
                    con.stop();
                    break;
                }
            }
            consumer.close();
            session.close();
            con.close();
            if(msgFound)
                return returnQueue;
            else
                throw new javax.jms.JMSException("Check ActiveMQ :'"+TestsContext.getInstance().amqExternalHostName.toString()+"'. \nCouldn't found any message on '"+TestsContext.getInstance().amqAdcostExternalQueue.toString()+"' queue for costNumber: '"+costNumber+"' with activity type '"+type+"'");
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    public AMQRequestQueue consumeCostsRequestsOnAMQ(String costNumber, String type){
        try {
            AMQRequestQueue queue=null;
            Boolean msgFound = false;
            AMQRequestQueue returnQueue=null;
            String queueType =null;
            String queueCostNumber = null;
            Gson gson = new Gson();
            ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory(TestsContext.getInstance().amqInternalHostName.toString());
            Connection connection = connectionFactory.createConnection();
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Destination destination = session.createQueue(TestsContext.getInstance().amqAdcostInternalQueue.toString());
            MessageConsumer consumer = session.createConsumer(destination);
            connection.start();
            while(true) {
                Message message = consumer.receive(4000); // Increased time to check AMQ steps doesn't fail randomly
                if (message instanceof TextMessage) {
                    TextMessage textMessage = (TextMessage) message;
                    String text = textMessage.getText();
                    queue = gson.fromJson(text,AMQRequestQueue.class);
                    try {
                        queueType = queue.getAction().getType();
                        queueCostNumber = queue.getAction().getPayload().getCostNumber();
                    } catch(Exception e){
                        continue; // make sure loop continued until right message is identified from the queue
                    }
                    if (queueCostNumber.equals(costNumber) && queueType.equals(type)) {
                        returnQueue= queue;
                        msgFound = true;
                    }
                } else {
                    connection.stop();
                    break;
                }
            }
            consumer.close();
            session.close();
            connection.close();
            if(msgFound)
                return returnQueue;
            else
                throw new javax.jms.JMSException("Check ActiveMQ :'"+TestsContext.getInstance().amqInternalHostName.toString()+"'. \nCouldn't found any message on '"+TestsContext.getInstance().amqAdcostInternalQueue.toString()+"' queue for costNumber: '"+costNumber+"' with activity type '"+type+"'");
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    private String buildAMQResponsePayload(MyPurchasesPayloadWrapper fields){
        JsonObject request = new JsonObject();
        if(fields.getEventTimeStamp()!=null)
            request.addProperty("eventTimeStamp",fields.getEventTimeStamp());
        request.addProperty("clientName",fields.getClientName());
        request.addProperty("activityType",fields.getActivityType());
        request.addProperty("costNumber",fields.getCostNumber());
        fields.setShoppingCartNumber();
        fields.setPoNumber();
        JsonObject payload = new JsonObject();
        if (fields.row.containsKey("ErrorMessages") && (fields.row.get("ErrorMessages") != null && !fields.row.get("ErrorMessages").isEmpty())){
            JsonArray errorMessages = new JsonArray();
            JsonObject object = new JsonObject();
            object.addProperty("type",fields.row.get("Type"));
            object.addProperty("Message",fields.row.get("Message"));
            errorMessages.add(object);
            payload.add("ErrorMessages",errorMessages);
        } else {
            request.addProperty("approverEmail",fields.getApproverEmail());
            payload.addProperty("approvalStatus", fields.getApprovalStatus());
            payload.addProperty("requisition", "345345345");
            payload.addProperty("poNumber", fields.getPoNumber());
            payload.addProperty("accountCode", "001-4880-US-G4P~K0--5000106342-S811419AF-005247000");
            payload.addProperty("grNumber", "4234627901");
            payload.addProperty("shoppingCartNumber", fields.getShoppingCartNumber());
            payload.addProperty("glAccount", "hi");
            payload.addProperty("ioNumber", "io");
            payload.addProperty("totalAmount", "1111111");
            if (fields.row.get("I/O# Owner") != null && !fields.row.get("I/O# Owner").isEmpty())
                payload.addProperty("ioNumberOwner", fields.row.get("I/O# Owner"));
            else
                payload.addProperty("ioNumberOwner", getIoNumberOwner());
            payload.addProperty("comments", getMockedAMQComment());
        }
     //   payload.addProperty("itemIdCode","w17289");
        request.add("payload",payload);
        return request.toString();
    }

    public class MyPurchasesPayloadWrapper{
        private String eventTimeStamp;
        private String clientName;
        private String activityType;
        private String costNumber;
        private String approverEmail;
        private String approvalStatus;
        private String shoppingCartNumber;
        private String poNumber;
        private Map<String,String> row = Collections.emptyMap();

        public MyPurchasesPayloadWrapper(String clientName,String activityType, String costNumber,String approverEmail, String approvalStatus){
            this.clientName=clientName;
            this.activityType=activityType;
            this.costNumber=costNumber;
            this.approverEmail=approverEmail;
            this.approvalStatus=approvalStatus;
        }

        public MyPurchasesPayloadWrapper(String eventTimeStamp,String clientName,String activityType, String costNumber,String approverEmail, String approvalStatus){
            this.eventTimeStamp=eventTimeStamp;
            this.clientName=clientName;
            this.activityType=activityType;
            this.costNumber=costNumber;
            this.approverEmail=approverEmail;
            this.approvalStatus=approvalStatus;
        }

        public MyPurchasesPayloadWrapper(String clientName,String activityType, String costNumber,String approvalStatus,ExamplesTable data){
            this.clientName=clientName;
            this.activityType=activityType;
            this.costNumber=costNumber;
            this.approvalStatus=approvalStatus;
            this.row = parametrizeTabularRow(data);
        }

        public String getClientName() {
            return clientName;
        }

        public void setClientName(String clientName) {
            this.clientName = clientName;
        }

        public String getActivityType() {
            return activityType;
        }

        public void setActivityType(String activityType) {
            this.activityType = activityType;
        }

        public String getCostNumber() {
            return costNumber;
        }

        public void setCostNumber(String costNumber) {
            this.costNumber = costNumber;
        }

        public String getApproverEmail() {
            return approverEmail;
        }

        public void setApproverEmail(String approverEmail) {
            this.approverEmail = approverEmail;
        }

        public String getApprovalStatus() {
            return approvalStatus;
        }

        public void setApprovalStatus(String approvalStatus) {
            this.approvalStatus = approvalStatus;
        }

        public String getShoppingCartNumber() {
            return shoppingCartNumber;
        }

        public void setShoppingCartNumber(String shoppingCartNumber) {
            this.shoppingCartNumber = shoppingCartNumber;
        }

        public void setShoppingCartNumber() {
            Random randomGenerator = new Random();
            this.shoppingCartNumber = Integer.toString(randomGenerator.nextInt(100000000));
        }

        public String getPoNumber() {
            return poNumber;
        }

        public void setPoNumber(String poNumber) {
            this.poNumber = poNumber;
        }

        public void setPoNumber() {
            Random randomGenerator = new Random();
            this.poNumber = "PO".concat(Integer.toString(randomGenerator.nextInt(100000000)));
        }

        public String getEventTimeStamp() { return eventTimeStamp; }

        public void setEventTimeStamp(String eventTimeStamp) { this.eventTimeStamp = eventTimeStamp; }
    }

    public ActivityType getActionTypeInMyPurchasesSystem(String action) {
        ActivityType activity = new ActivityType();
        if (action.equalsIgnoreCase(CostActionTypeInMyPurchases.APPROVE.toString())) {
            activity.setActivityType("updated");
            activity.setApprovalStatus("approved");
            return activity;
        } else if (action.equalsIgnoreCase(CostActionTypeInMyPurchases.RECALL.toString())) {
            activity.setActivityType("recalled");
            activity.setApprovalStatus("approved");
            return activity;
        } else if (action.equalsIgnoreCase(CostActionTypeInMyPurchases.CANCEL.toString())) {
            activity.setActivityType("cancelled");
            activity.setApprovalStatus("approved");
            return activity;
        } else if (action.equalsIgnoreCase(CostActionTypeInMyPurchases.REJECT.toString())) {
            activity.setActivityType("updated");
            activity.setApprovalStatus("rejected");
            return activity;
        } else
            throw new IllegalArgumentException("Unknown Action type for a cost in MyPurchases System: " + action);
    }

    public enum CostActionTypeInMyPurchases{
        APPROVE("Approve"),
        RECALL("Recall"),
        CANCEL("Cancel"),
        REJECT("Reject"),
        SUBMITTED("submitted"),
        GOODSRECEIPTSUBMITTED("goods_receipt_submitted"),
        CANCELLED("cancelled"),
        RECALLED("recalled");

        private String CostActionTypeInMyPurchases;

        private CostActionTypeInMyPurchases(String CostActionTypeInMyPurchases) {
            this.CostActionTypeInMyPurchases = CostActionTypeInMyPurchases;
        }

        @Override
        public String toString() {
            return CostActionTypeInMyPurchases;
        }

        public static CostActionTypeInMyPurchases findByType(String type) {
            for (CostActionTypeInMyPurchases costActionType: values())
                if (costActionType.toString().equals(type))
                    return costActionType;
            throw new IllegalArgumentException("Unknown Action Type for MyPurchases : " + type);
        }
    }

    public class ActivityType{
        private String activityType;
        private String approvalStatus;

        public String getApprovalStatus() {
            return approvalStatus;
        }

        public void setApprovalStatus(String approvalStatus) {
            this.approvalStatus = approvalStatus;
        }

        public String getActivityType() {
            return activityType;
        }

        public void setActivityType(String activityType) {
            this.activityType = activityType;
        }
    }

    @Then("{I |}should see AMQ receives below request for cost title '$costTitle' and type as '$type': $data")
    public void checkMessagesOnAMQRequestQueue(String costTitle, String type, ExamplesTable data){
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        String costNumber = costs.getCostNumber();

        AMQConsumerService source = new AMQConsumerService();
        Map<String, AMQRequestQueue>  queueMap = source.consumeAMQMessages();
        AMQRequestQueue queue= queueMap.get(costNumber);
        source.removeMessageFromQueue(costNumber);

        Map<String, String> row = parametrizeTabularRow(data, 0);

        assertThat("Check 'costNumber' field in AMQ Request Queue: ",queue.getAction().getPayload().getCostNumber(),equalTo(costNumber));
        if (row.containsKey("Total Amount"))
            assertThat("Check 'Total Amount' field in AMQ Request Queue: ",queue.getAction().getPayload().getTotalAmount(), equalTo(row.get("Total Amount")));
        if (row.containsKey("Currency"))
            assertThat("Check 'Currency' field in AMQ Request Queue: ", queue.getAction().getPayload().getCurrency(), equalTo(row.get("Currency")));
        if (row.containsKey("IO Number"))
            assertThat("Check 'ioNumber' field in AMQ Request Queue: ",queue.getAction().getPayload().getIoNumber(), containsString(row.get("IO Number")));
        if (row.containsKey("Vendor"))
            assertThat("Check 'Vendor' field in AMQ Request Queue: ",queue.getAction().getPayload().getVendor(),containsString(row.get("Vendor")));
        if (row.containsKey("PO Number"))
            assertThat("Check 'poNumber' field in AMQ Request Queue: ", queue.getAction().getPayload().getIoNumber(),equalTo(row.get("PO Number")));
        if (row.containsKey("Payment Amount"))
            assertThat("Check 'paymentAmount' field in AMQ Request Queue: ", queue.getAction().getPayload().getPaymentAmount(),equalTo(row.get("Payment Amount")));
        if (row.containsKey("Basket Name")) {
            String brand = row.get("Brand");
            if(!brand.equals("DefaultBrand"))
                brand = wrapVariableWithTestSession(row.get("Brand"));
            String expectedBasketName = "ADCOST".concat(costNumber).concat(brand).concat(":").concat(String.valueOf(row.get("Description")));
            String actualBasketName = queue.getAction().getPayload().getBasketName();
            if(actualBasketName.length()<=40)
                assertThat("Check 'Basket Name' in AMQ Request Queue: \n Actual: "+actualBasketName
                        +"\n Expected: "+expectedBasketName, expectedBasketName.contains(actualBasketName));
            else
                assertThat("Check 'Basket Name' length in AMQ Request Queue. Expected length is 40 char's but found: "+queue.getAction().getPayload().getBasketName().length(), false);
        }
        if(row.containsKey("Description")){
            String contentType;
            if (costs.getCostType().contains("Production"))
                contentType= costs.getContentTypeValue();
            else
                contentType="";
            String description = contentType.concat("/").concat(costs.getBudgetRegionName()).concat(" ").concat(costNumber);
            String actual = queue.getAction().getPayload().getDescription();
            assertThat("Check 'description' field under 'Action' in AMQ Request Queue: ", actual,equalTo(description));
        }
        if (row.containsKey("CategoryId")) {
            assertThat("Check CategoryId on AMQ- expected is: "+row.get("CategoryId")+ " actual category Id : "+queue.getAction().getPayload().getCategoryId(),
                    queue.getAction().getPayload().getCategoryId(),equalTo(row.get("CategoryId")));
        }
        if (row.containsKey("Gl")) {
            assertThat("Check GL code on AMQ- expected is: "+row.get("GL")+ " actual gl code : "+queue.getAction().getPayload().getGl(),
                    queue.getAction().getPayload().getGl(),equalTo(row.get("Gl")));
        }
        if (row.containsKey("RequisitionerEmail")) {
            String reqEmail = wrapUserEmailWithTestSession(row.get("RequisitionerEmail"));
            assertThat("Check 'requisitionerEmail' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getRequisitionerEmail(),equalTo(reqEmail));
        }
        if (row.containsKey("LongText")) {
            LongText lText = generateLongText(row.get("LongText"),type, costs, queue.getAction().getPayload().getPoNumber());
            if(CostActionTypeInMyPurchases.SUBMITTED.toString().equals(type)){
                assertThat("Check 'an field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getAn(),equalTo(lText.getAn()));
                assertThat("Check 'bn field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getBn(),equalTo(lText.getBn()));
            }
            if (CostActionTypeInMyPurchases.CANCELLED.toString().equals(type)){
                assertThat("Check 'bn field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getBn(),equalTo(lText.getBn()));
                assertThat("Check 'vn field in longText' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getLongText().getVn(), equalTo(lText.getVn()));
            }
        }
        if (row.containsKey("Commodity")) {
            String commodity = Commodity.findByType(row.get("Commodity")).getCommodity();
            assertThat("Check 'commodity' field under 'Action' in AMQ Request Queue: ", queue.getAction().getPayload().getCommodity(),equalTo(commodity));
        }
        if (row.containsKey("Account Code")) {
            //ToDo --need to confirm the format and in which field we are getting it from COUPA while injecting response in amq as brand approver
        }
        if (row.containsKey("Item Code")) {
            //ToDo --need to confirm the format and in which field we are getting it from COUPA while injecting response in amq as brand approver
        }
        if (row.containsKey("GrNumbers")) {
            //ToDo --need to confirm
        }
        if (row.containsKey("Start Date")) {
            //ToDo--probably a bug
        }
        if (row.containsKey("Delivery Date")) {
            // ToDo:
        }
        if (row.containsKey("TNumber")) {
            // ToDo: only for cyclone costs: need to confirm how we are getting it from COUPA in case of cyclone costs
        }
    }
}
