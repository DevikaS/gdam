package com.adstream.automate.babylon.tests.steps.utils.gdn;

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
import java.util.List;
import java.util.UUID;
import java.util.Date;

/**
 * Created by Ramababu.Bendalam on 16/03/2016.
 */
public class A5RegisterJob {

    public static RegisterJob getRegisterJob(String storageId, File file, String elementId) {
        return new RegisterJob(UUID.randomUUID().toString(), //ExternalID
                9, //Priority
                "ADBANK", //System
                Option.apply(storageId), // StorageID
                Option.apply(null), // SLA
                Option.apply(null), // StartTime
                Option.apply((String) "http-upload"), //Capabilities
                Option.apply((String) null), //RelatedWorkflowID
                file.getName(), // FileName
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
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        Date dateobj = new Date();
        String agencyId = "56eab9b2e4b066214149f84a";
        String filePath = "" + "/" + df.format(dateobj) + elementId + "/" + elementId+"_Master.zip";
        propertyArrayList.add(new Property(file.getName(), "Path"));
        propertyArrayList.add(new Property(filePath, "Filepath"));
        propertyArrayList.add(new Property(elementId, "ElementID"));
        propertyArrayList.add(new Property(agencyId, "AgencyID"));

        Seq<Property> propertySeq = scala.collection.JavaConversions.asScalaBuffer(propertyArrayList).toList();

        Metadata metadata = new Metadata(propertySeq);
        return metadata;
    }
}
