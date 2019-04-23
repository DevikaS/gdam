package com.publicApi.utilities;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.jsonPayLoads.GsonClasses.DestinationItems;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class ResponseParser {


    public static String getQCAssetId(String msg) {
        String qcAssetId = "";
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readValue(msg, JsonNode.class);
            qcAssetId = node.findValue("qcAssetId").getTextValue();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return qcAssetId;
    }

    public static String getDestinationId(String msg) {
        String destinationId = "";
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readValue(msg, JsonNode.class);
            JsonNode destinationItemNode = (node.findValue("destinations")).findValue("items").get(0);
            destinationId = destinationItemNode.findValue("id").get(0).getTextValue();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return destinationId;
    }

    public static void updateDestinationAndServiceLevelIds(String msg, List destinationList) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readValue(msg, JsonNode.class);
            JsonNode destinationItemNode = (node.findValue("destinations")).findValue("items").get(0);
            destinationList.add(destinationItemNode.findValue("id").get(0).getTextValue());
            destinationList.add(destinationItemNode.findValue("serviceLevel").findValue("id").get(0).getTextValue());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void addDestinationInfo(String msg, List destinationList) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readValue(msg, JsonNode.class);
            JsonNode destinationItemNode = (node.findValue("destinations")).findValue("items").get(0);
            destinationList.add(destinationItemNode.findValue("id").get(0).getTextValue());
            destinationList.add(destinationItemNode.findValue("serviceLevel").findValue("id").get(0).getTextValue());
            destinationList.add(destinationItemNode.findValue("status").getTextValue());
            destinationList.add(destinationItemNode.findValue("statusId").get(0).getTextValue());
            destinationList.add(destinationItemNode.findValue("viewStatus").get(0).getTextValue());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void addAdditionalDestinationInfo(String msg, List destinationList) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readValue(msg, JsonNode.class);
            JsonNode metaCommonNode = (node.findValue("meta")).findValue("common");
            destinationList.add(metaCommonNode.findValue("duration").getTextValue());
            destinationList.add(metaCommonNode.findValue("additionalInformation").getTextValue());
            //destinationList.add(metaCommonNode.findValue("status").getTextValue());
            destinationList.add(metaCommonNode.findValue("title").getTextValue());
            destinationList.add(metaCommonNode.findValue("item_type").getTextValue());

            destinationList.add(node.findValue("type").getTextValue());

            JsonNode metaMetadataNode = (node.findValue("meta")).findValue("metadata");
            destinationList.add(metaMetadataNode.findValue("subtitlesRequired").get(0).getTextValue());

            destinationList.add(node.findValue("status").get(0).getTextValue());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static List updateActualItemList(String msg, List itemList) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readValue(msg, JsonNode.class);
            itemList.add(node.findValue("status").get(0).getTextValue());

            JsonNode tvNode = node.findValue("tv");
            itemList.add(tvNode.findValue("market").getTextValue());
            itemList.add(tvNode.findValue("marketCountry").getTextValue());
            itemList.add(tvNode.findValue("marketId").get(0).getTextValue());

            JsonNode commonNode = node.findValue("common");
            itemList.add(commonNode.findValue("firstAirDate").getTextValue());
            itemList.add(commonNode.findValue("format").get(0).getTextValue());
            itemList.add(commonNode.findValue("duration").getTextValue());
            itemList.add(commonNode.findValue("additionalInformation").getTextValue());
            itemList.add(commonNode.findValue("title").getTextValue());
            itemList.add(commonNode.findValue("item_type").getTextValue());

            JsonNode metadataNode = node.findValue("metadata");
            itemList.add(metadataNode.findValue("subtitlesRequired").get(0).getTextValue());

            itemList.add(node.findValue("documentType").getTextValue());
            itemList.add(node.findValue("type").getTextValue());
            return itemList;
        } catch (Exception ex) {
            ex.printStackTrace();
            return itemList;
        }
    }

    public static String removeEmptyApprovals(String jsonString) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readValue(jsonString, JsonNode.class);
            JsonNode destinationItemNode = (node.findValue("destinations")).get(0);
            Type type = new TypeToken<Map<String, Object>>() {
            }.getType();
            Map<String, Object> data = new Gson().fromJson(destinationItemNode.toString(), type);

            for (Iterator<Map.Entry<String, Object>> it = data.entrySet().iterator(); it.hasNext(); ) {
                Map.Entry<String, Object> entry = it.next();
                if (entry.getValue() == null) {
                    it.remove();
                } else if (entry.getValue().getClass().equals(ArrayList.class)) {
                    if (((ArrayList<?>) entry.getValue()).size() == 0) {
                        it.remove();
                    }
                }
            }
            return new GsonBuilder().setPrettyPrinting().create().toJson(data);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return jsonString;
    }


}
