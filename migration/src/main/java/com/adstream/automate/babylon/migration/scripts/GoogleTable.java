package com.adstream.automate.babylon.migration.scripts;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.gdata.client.authn.oauth.OAuthUtil;
import com.google.gdata.client.docs.DocsService;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/4/15
 * Time: 5:04 PM

 */
public class GoogleTable {
    // "https://docs.google.com/spreadsheets/d/1UktgTt0zWMzGo2oGEptvDDEvl_U5_8geCDwi_gHvq5A/edit#gid=1875858468"



    public static void main(String[] args) throws IOException {
        String CLIENT_ID = "90220241869-2p6s1ogn46pfsqgu4i88leptst2oqvkk.apps.googleusercontent.com";

        // This is the OAuth 2.0 Client Secret retrieved
        // above.  Be sure to store this value securely.  Leaking this
        // value would enable others to act on behalf of your application!
        //String CLIENT_SECRET = "0a531a7a375fa28bc385333249a4680d487c647d";
        String CLIENT_SECRET = "j7kFrateH7stMTRE-nEie26v ";

        // Space separated list of scopes for which to request access.
        String SCOPE = "https://spreadsheets.google.com/feeds https://docs.google.com/feeds";

        // This is the Redirect URI for installed applications.
        // If you are building a web application, you have to set your
        // Redirect URI at https://code.google.com/apis/console.
        String REDIRECT_URI = "https://docs.google.com/oauth2callback";



        HttpTransport httpTransport = new NetHttpTransport();
        JsonFactory jsonFactory = new JacksonFactory();

        GoogleTokenResponse response =
                new GoogleAuthorizationCodeTokenRequest(new NetHttpTransport(), new JacksonFactory(),
                        CLIENT_ID, CLIENT_SECRET,
                        "4/P7q7W91a-oMsCeLvIaQm6bTrgtp7", "https://oauth2-login-demo.appspot.com/code")
                        .execute();
        System.out.println("Access token: " + response.getAccessToken());

        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                httpTransport, jsonFactory, CLIENT_ID, CLIENT_SECRET, Arrays.asList(DriveScopes.DRIVE))
                .setAccessType("online")
                .setApprovalPrompt("auto").build();

        String url = flow.newAuthorizationUrl().setRedirectUri(REDIRECT_URI).build();
        System.out.println("Please open the following URL in your browser then type the authorization code:");
        System.out.println("  " + url);
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String code = br.readLine();

        //GoogleTokenResponse response = flow.newTokenRequest(code).setRedirectUri(REDIRECT_URI).execute();
        GoogleCredential credential = new GoogleCredential().setFromTokenResponse(response);

        //Create a new authorized API client
        Drive service = new Drive.Builder(httpTransport, jsonFactory, credential).build();
    }

    public void init() {
        //DocsService service

    }                                     //00000000-0000-0000-0000-142167329383

}
