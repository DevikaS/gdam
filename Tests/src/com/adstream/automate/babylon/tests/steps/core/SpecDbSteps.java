package com.adstream.automate.babylon.tests.steps.core;

import com.adstream.automate.babylon.JsonObjects.GenerateProxySet;
import com.adstream.automate.babylon.JsonObjects.TranscodingAgency;
import com.adstream.automate.babylon.JsonObjects.VideoProxySet;
import com.adstream.automate.babylon.JsonObjects.XMPMapping;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.When;

import java.util.ArrayList;
import java.util.List;

public class SpecDbSteps extends BaseStep {
    private static final String DB_SPECS = "specs";
    private static final String DB_TRANSCODING = "transcoding";
    
    @When("{I |}create xmp mapping for current agency")
    public static void createXMPMapping() {
        String currentAgencyId = getCoreApi().getCurrentAgency().getId();
        addNewXMPTranscodingAgencyId(currentAgencyId);
        List<XMPMapping> xmpMapping = new ArrayList<>();
        xmpMapping.add(new XMPMapping("_cm.common.advertiser", new XMPMapping.TagMapping("PrepressName", "pdf")));
        xmpMapping.add(new XMPMapping("_cm.common.brand", new XMPMapping.TagMapping("Client", "pdf")));
        getCoreApi().createXMPMapping(currentAgencyId, xmpMapping);
    }
    
    public static TranscodingAgency getXMPTranscodingAgency() {
        return getCouchDB(DB_TRANSCODING).find(TranscodingAgency.class, "p2:adbank5:custom:YADN-TCD:f1:document:xml:exif");
    }

    public static void addNewXMPTranscodingAgencyId(String id) {
        TranscodingAgency transcodingAgency = getXMPTranscodingAgency();
        transcodingAgency.getRules().setAgencyId(id);
        getCouchDB(DB_TRANSCODING).update(transcodingAgency);
        Common.sleep(200);
    }

    public static void removeXMPTranscodingAgencyId(String id) {
        TranscodingAgency transcodingAgency = getXMPTranscodingAgency();
        transcodingAgency.getRules().getAgencyId().remove(id);
        getCouchDB(DB_TRANSCODING).update(transcodingAgency);
        Common.sleep(200);
    }

    public static VideoProxySet getVideoProxySet() {
        return getCouchDB(DB_SPECS).find(VideoProxySet.class, "t1:FFMPEG_LinShellScriptXsltTemplate:UnspecifiedVideo-to-proxy-set");
    }

    public static GenerateProxySet getGenerateProxySet() {
        return getCouchDB(DB_SPECS).find(GenerateProxySet.class, "t1:LinShellScriptXsltTemplate:Generate-proxy-set:BEAM");
    }

    public static void setIsPayoutForAgency(String agencyId) {
        VideoProxySet videoProxySet = getVideoProxySet();
        videoProxySet.setAgencyId(agencyId);
        getCouchDB(DB_SPECS).update(videoProxySet);

        GenerateProxySet generateProxySet = getGenerateProxySet();
        generateProxySet.setAgencyId(agencyId);
        getCouchDB(DB_SPECS).update(generateProxySet);
    }
}
