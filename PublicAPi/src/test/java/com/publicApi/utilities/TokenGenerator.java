package com.publicApi.utilities;

import com.publicApi.tests.testsBase.BaseTests;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;


import java.io.IOException;

public class TokenGenerator  {

                private String key = null;
                private String secret = null;


                public TokenGenerator() { }

                private String getSecret() { return secret; }

                private void setSecret(String secret) {  this.secret = secret;   }

                private String getKey() { return key;  }

                private void setKey(String key) { this.key = key; }

                public String getToken(String tokenFor) {
                    String jsonString=null;
                    String generateTokenURL;

                    try {
                        switch (tokenFor) {
                case "admin":
                    setKey("adminKey");
                    setSecret("adminSecret");
                    break;
                case "agencyAdmin":
                    setKey("Key");
                    setSecret("Secret");
                    break;
                case "broadcastManager":
                    setKey("BroadcastManagerKey");
                    setSecret("BroadcastManagerSecret");
                    break;
                case "trafficManager":
                    setKey("TrafficManagerKey");
                    setSecret("TrafficManagerSecret");
                    break;
                case "approval":
                    setKey("ApprovalKey");
                    setSecret("ApprovalSecret");
                    break;
                case "internalAdmin":
                    setKey("InternalAdminKey");
                    setSecret("InternalAdminSecret");
                    break;
                case "s3StorageAdmin":
                    setKey("s3StorageAdminKey");
                    setSecret("s3StorageAdminSecret");
                    break;
            }

            generateTokenURL = BaseTests.getBaseURL() + "/api/v2/auth/token?" +
                   "key=" + BaseTests.getProp().getProperty(getKey()) +
                   "&secret=" + BaseTests.getProp().getProperty(getSecret());
           // generateTokenURL = BaseTests.getBaseURL() + "/api/v2/auth/token?key=578c9a5468aaaf1c59f8a0dc&secret=V4yaVGiqrxxZ0KDcgWN3EfI7nXmX0A00";
            HttpGet request = new HttpGet(generateTokenURL);
            CloseableHttpClient httpClient = HttpClientBuilder.create().build();
            HttpResponse response = httpClient.execute(request);
            jsonString = EntityUtils.toString(response.getEntity());
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        /*generateTokenURL = BaseTests.getBaseURL() + "/api/v2/auth/token?" +
                "key=" + BaseTests.getProp().getProperty(getKey()) +
                "&secret=" + BaseTests.getProp().getProperty(getSecret());


        BaseTests.getDriver().navigate().to(generateTokenURL);

        generateTokenURL = BaseTests.getDriver().findElement(By.tagName("body")).getText();
*/
        return  jsonString.split("\",\"hash\":\"")[1].split("\"}")[0];
    }
}