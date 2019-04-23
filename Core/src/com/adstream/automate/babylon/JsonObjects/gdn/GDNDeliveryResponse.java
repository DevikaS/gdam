package com.adstream.automate.babylon.JsonObjects.gdn;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import org.jetbrains.annotations.NotNull;
import java.io.UnsupportedEncodingException;
import java.util.*;
import java.util.Map;

/**
 * Created by Ramababu.Bendalam on 12/05/2016.
 */
public class GDNDeliveryResponse {

   @NotNull
    public static java.util.Set<MetaDataAttribute> getExpectedAttributes(Map<String, String> row)  {
        java.util.Set<MetaDataAttribute> expectedAttributes = new java.util.HashSet();

        expectedAttributes.add(new MetaDataAttribute("uniqueName", row.get("uniqueName")));
        expectedAttributes.add(new MetaDataAttribute("OrderReference", row.get("OrderReference")));
        expectedAttributes.add(new MetaDataAttribute("agencyID", row.get("agencyID")));
        expectedAttributes.add(new MetaDataAttribute("agency", row.get("agency")));
        expectedAttributes.add(new MetaDataAttribute("advertiser", row.get("advertiser")));
        expectedAttributes.add(new MetaDataAttribute("product", row.get("product")));
        expectedAttributes.add(new MetaDataAttribute("campaign", row.get("campaign")));
        expectedAttributes.add(new MetaDataAttribute("title", row.get("title")));
        expectedAttributes.add(new MetaDataAttribute("createdByEmail", row.get("createdByEmail")));
        expectedAttributes.add(new MetaDataAttribute("createdByFirstName", row.get("createdByFirstName")));
        expectedAttributes.add(new MetaDataAttribute("createdByLastName", row.get("createdByLastName")));
        if (row.containsKey("customField.Motivnummer")) {
        expectedAttributes.add(new MetaDataAttribute("customField.Motivnummer", row.get("customField.Motivnummer")));
       }
        expectedAttributes.add(new MetaDataAttribute("isProxyApprove", "0"));
        expectedAttributes.add(new MetaDataAttribute("isLegalApprove", "0"));
        expectedAttributes.add(new MetaDataAttribute("slaServiceLevelID", "2"));
        expectedAttributes.add(new MetaDataAttribute("slaServiceLevelName", "Standard"));
        expectedAttributes.add(new MetaDataAttribute("deliveryRetryAttempt", "0"));
        expectedAttributes.add(new MetaDataAttribute("resolution", "720x576i@25fps"));
        expectedAttributes.add(new MetaDataAttribute("aspectRatio", "16x9"));
        expectedAttributes.add(new MetaDataAttribute("fullDurationInFrames", "500"));
        expectedAttributes.add(new MetaDataAttribute("adDurationInFrames", "375"));
        expectedAttributes.add(new MetaDataAttribute("firstActiveFrame", "25"));
        expectedAttributes.add(new MetaDataAttribute("lengthOfBlack", "100"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-1-LangId", "81"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-1-Lang", "eng"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-1-Lang-ISO2", "en"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-1-Lang-Name", "en"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-1-Lang-EnglishName", "English"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-1-SpecId", "f1:audio:track:channel:StereoLeft"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-2-LangId", "81"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-2-Lang", "eng"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-2-Lang-ISO2", "en"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-2-Lang-Name", "en"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-2-Lang-EnglishName", "English"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-2-SpecId", "f1:audio:track:channel:StereoRight"));
        expectedAttributes.add(new MetaDataAttribute("audioTrack-count", "2"));
        expectedAttributes.add(new MetaDataAttribute("assetStatusID", "5"));
        expectedAttributes.add(new MetaDataAttribute("assetStatusName", "Transfer Queued"));
        if (row.containsKey("customField.Subtitles Required")){
          expectedAttributes.add(new MetaDataAttribute("customField.Subtitles Required", row.get("customField.Subtitles Required")));
       }
       if (row.containsKey("customField.Watermarking Required")){
           expectedAttributes.add(new MetaDataAttribute("customField.Watermarking Required",row.get("customField.Watermarking Required")));
       }
       if (row.containsKey("customField.Clave")){
           expectedAttributes.add(new MetaDataAttribute("customField.Clave", row.get("customField.Clave")));
       }
        return expectedAttributes;
    }


}
