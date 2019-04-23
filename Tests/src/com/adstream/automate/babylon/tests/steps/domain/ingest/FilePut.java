package com.adstream.automate.babylon.tests.steps.domain.ingest;

import com.adstream.automate.babylon.BabylonMessageSender;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.tests.steps.core.GdnBase;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.net.URL;

/**
 * Created by Ramababu.Bendalam on 04/02/2016.
 */
public class FilePut extends BabylonMessageSender {

    private static Logger log = Logger.getLogger(FilePut.class);

    public FilePut(URL baseUrl) {
        super(baseUrl);
        }

    public void uploadfile(String ClockNumber) {
        String assetGuid = GdnBase.getGuidByClock(ClockNumber);
        String fileID = GdnBase.getfileID();
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost request = new HttpPost(baseUrl + "/adgate/files/gdn_upload/" + fileID + "/" + assetGuid + "_master.zip");
        MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
        File file = new File(TestsContext.getInstance().testDataFolderName + "/" + "files/sampleVideo_Master.mpeg");
        entityBuilder.addBinaryBody("videoimage", file);
        request.setEntity(entityBuilder.build());
        try {
            HttpResponse response = client.execute(request);
        } catch (IOException e) {
            e.printStackTrace();
            GdnBase.setErr();
        }
    }

}
