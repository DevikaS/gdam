package com.adstream.automate.babylon.JsonObjects.gdn;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.gdn.api.client.serialization.Metadata;
import com.adstream.gdn.api.client.serialization.Property;
import com.adstream.gdn.api.client.serialization.RegisterJob;
import scala.Option;
import scala.collection.immutable.Seq;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.Random;

/**
 * Created by Ramababu.Bendalam on 02/03/2017.
 */
public class GDNIngestRegisterJob {


    public static RegisterJob getRegisterJob(String storageId, File file, String elementId) {
        String filename = file.getName().replace("zip", "mpeg");
        return new RegisterJob(UUID.randomUUID().toString(), //ExternalID
                9, //Priority
                "ADBANK", //System
                Option.apply(storageId), // StorageID
                Option.apply(null), // SLA
                Option.apply(null), // StartTime
                Option.apply((String) "http-upload"), //Capabilities
                Option.apply((String) null), //RelatedWorkflowID
                filename, // FileName
                Option.apply((Object) file.length()), //Size
                Option.apply(createRegisterJobMetadata(file, elementId)), //Metadata
                Option.apply((Object) true), //IsIngested
                Option.apply((String) null), //UserIP
                Option.empty(), //LifeTime
                Option.apply(null), //IsArchived
                Option.apply((String) null), //ArchiveType
                Option.apply((String) null), //ArchiveSpec
                Option.apply((String) null), //ArchiveExtId
                Option.apply((Metadata) null));  //ArchiveMetadata
    }

    private static Metadata createRegisterJobMetadata(File file, String elementId) {
        List<Property> propertyArrayList = new ArrayList<Property>();
        String filePath1 = "/Adstream_A4_e2e/20140725" + file.getPath().replace(TestsContext.getInstance().ingestDropPath, "").replaceAll("\\\\", "/").replace("%20", " ") + "/";
        //String filePath = "/" + file.getPath().replace(Config.getIngestDropPath(), "").replaceAll("\\\\", "/").replace("%20", " ") + "/";
        String filePath = filePath1.replace("zip", "mpeg");
        propertyArrayList.add(new Property(file.getName(), "Path"));
        propertyArrayList.add(new Property(filePath, "Filepath"));
        propertyArrayList.add(new Property(elementId, "ElementID"));

        Seq<Property> propertySeq = scala.collection.JavaConversions.asScalaBuffer(propertyArrayList).toList();

        Metadata metadata = new Metadata(propertySeq);
        return metadata;
    }

    public static RegisterJob getRegisterJobA5(String storageId, File file, String assetId, String agencyId) {
        return new RegisterJob(UUID.randomUUID().toString(), //ExternalID
                9, //Priority
                "adbank5", //System
                Option.apply(storageId), // StorageID
                Option.apply(null), // SLA
                Option.apply(null), // StartTime
                Option.apply((String) "http-upload"), //Capabilities
                Option.apply((String) null), //RelatedWorkflowID
                assetId+"_Master.zip", // FileName
                Option.apply((Object) file.length()), //Size
                Option.apply(createRegisterJobMetadataA5(assetId, agencyId)), //Metadata
                Option.apply((Object) true), //IsIngested
                Option.apply((String) null), //UserIP
                Option.empty(), //LifeTime
                Option.apply(null), //IsArchived
                Option.apply((String) null), //ArchiveType
                Option.apply((String) null), //ArchiveSpec
                Option.apply((String) null), //ArchiveExtId
                Option.apply((Metadata) null));  //ArchiveMetadata
    }

    private static Metadata createRegisterJobMetadataA5(String assetId, String agencyId) {
        List<Property> propertyArrayList = new ArrayList<Property>();
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        Date dateobj = new Date();
        Random rand = new Random();
        int  n = rand.nextInt(50) + 1;
        String filePath = "/" + agencyId + "/" + df.format(dateobj) + n + "/" + assetId + "/" + assetId+"_Master.zip";
        propertyArrayList.add(new Property(assetId+"_Matser.zip", "Path"));
        propertyArrayList.add(new Property(filePath, "Filepath"));
        propertyArrayList.add(new Property(assetId, "ElementID"));
        propertyArrayList.add(new Property(agencyId, "AgencyID"));
        Seq<Property> propertySeq = scala.collection.JavaConversions.asScalaBuffer(propertyArrayList).toList();
        Metadata metadata = new Metadata(propertySeq);
        return metadata;
    }

}
