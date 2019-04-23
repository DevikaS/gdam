package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.migration.actions.UsersAction;
import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.tests.data.MigrationDataProvider;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
/*import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.json.JSONObject;*/
import org.testng.annotations.Test;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;


/**
 * Created with IntelliJ IDEA.
 * User: mukha-v
 * Date: 04.11.13
 * Time: 9:26
 * To change this template use File | Settings | File Templates.
 */
public class Specification extends BaseTest {

    @Test(dataProvider = "assetsWithSpecs", dataProviderClass = MigrationDataProvider.class)
    public void checkAllAssetsWithSpec(UsersAction usersAction) {
        getService().logIn(usersAction.getCurrentUser().getEmail(), usersAction.getCurrentUser().getPassword());
        Asset currAsset = usersAction.getOneAssetFromXML();
        String specDocId_from_ourXml = currAsset.getSpecDBDocID();
        try {
            Boolean response = getResponseFromA5(specDocId_from_ourXml);
            //assertTrue(response);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }


    }


    public boolean getResponseFromA5(String spec) throws IOException {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        RequestConfig requestConfig = RequestConfig.custom()
                .setSocketTimeout(9000)
                .setConnectTimeout(9000)
                .build();
        String line = "http://uakyivdev8:5984/specs/_design/api/_rewrite/mediaFormat/";
        String specFromXml = spec;
        int count = 0; //success counter
        StringBuilder fb = new StringBuilder(); //fails buffers


        HttpGet httpGet = new HttpGet(line + specFromXml);
        CloseableHttpResponse response = httpclient.execute(httpGet);

        if (response.getStatusLine().getStatusCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : "
                    + response.getStatusLine().getStatusCode());
        }

        try {
            BufferedReader br = new BufferedReader( new InputStreamReader((response.getEntity().getContent())));
            StringBuilder sb = new StringBuilder();
            String ln =null;

            while ((ln = br.readLine()) != null) {
                sb.append(ln + "\n").toString();
            }

            //System.out.println(sb.toString());
            String jsonInArray[] = sb.toString().split("\n");

            /* Do parsing specFromXml in each line xml*/
            int x = 0; // index
            for (int len = jsonInArray.length; len > 1; len--, x++) {
                if (jsonInArray[x].contains(specFromXml)) { count++; }
            }

            if (count == 0) {
                System.out.println("!!!!!!!!!!!! F A I L S !!!!!!!!!!!!");
                System.out.println(sb.toString());
                System.out.println("!!!!!!!!!!!! F A I L S !!!!!!!!!!!!");
            }

            //String a5 = br.readLine();
            //System.out.println("From A5  : " + a5);
            //System.out.println("From XML : " + specFromXml);

            //if (a5.contains(specFromXml)) return true; else return false;
            //if (br.readLine().contains(specFromXml)) return true; else return false;

        } finally {
            response.close();
            httpclient.close();
        }

        if ( count == 1 ) return true; else return false;
    }


}


