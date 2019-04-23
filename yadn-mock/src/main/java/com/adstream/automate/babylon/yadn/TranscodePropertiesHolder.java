package com.adstream.automate.babylon.yadn;

import adstream.yadn.ObjectFactory;
import adstream.yadn.TranscodeProperties;
import adstream.yadn.TranscodeProperty;

import java.util.List;

import static java.util.Arrays.asList;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 06.08.13
 * Time: 11:42
 */
public class TranscodePropertiesHolder {

    public static List<TranscodeProperties> getAllProperies(){
        return asList(getClapperProperies(), getStoryboardProperies(), getTumbnailProperies(),getVideoProxyProperies());
    }

    public static TranscodeProperties getClapperProperies() {
        TranscodeProperties props = new ObjectFactory().createTranscodeProperties();
        TranscodeProperty a5TypeProperty = new TranscodeProperty();
        a5TypeProperty.setName("a5_type");
        a5TypeProperty.setValue("clapper");
        TranscodeProperty guiseProperty = new TranscodeProperty();
        guiseProperty.setName("guise");
        guiseProperty.setValue("preview");
        TranscodeProperty guisePreviewProperty = new TranscodeProperty();
        guisePreviewProperty.setName("proxy_guise");
        guisePreviewProperty.setValue("true");

        props.getTranscodeProperty().add(a5TypeProperty);
        props.getTranscodeProperty().add(guiseProperty);
        props.getTranscodeProperty().add(guisePreviewProperty);
        return props;
    }
    public static TranscodeProperties getVideoProxyProperies() {
        TranscodeProperties props = new ObjectFactory().createTranscodeProperties();
        TranscodeProperty a5TypeProperty = new TranscodeProperty();
        a5TypeProperty.setName("a5_type");
        a5TypeProperty.setValue("video_proxy");
        TranscodeProperty guiseProperty = new TranscodeProperty();
        guiseProperty.setName("guise");
        guiseProperty.setValue("preview");
        TranscodeProperty guisePreviewProperty = new TranscodeProperty();
        guisePreviewProperty.setName("proxy_guise");
        guisePreviewProperty.setValue("true");

        TranscodeProperty proxySourceFps = new TranscodeProperty();
        proxySourceFps.setName("proxy_source_fps");
        proxySourceFps.setValue("25.0");

        props.getTranscodeProperty().add(a5TypeProperty);
        props.getTranscodeProperty().add(guiseProperty);
        props.getTranscodeProperty().add(guisePreviewProperty);
        props.getTranscodeProperty().add(proxySourceFps);
        return props;
    }

    public static TranscodeProperties getStoryboardProperies() {
        TranscodeProperties props = new ObjectFactory().createTranscodeProperties();
        TranscodeProperty a5TypeProperty = new TranscodeProperty();
        a5TypeProperty.setName("a5_type");
        a5TypeProperty.setValue("storyboard");
        TranscodeProperty guiseProperty = new TranscodeProperty();
        guiseProperty.setName("guise");
        guiseProperty.setValue("preview");
        TranscodeProperty guisePreviewProperty = new TranscodeProperty();
        guisePreviewProperty.setName("proxy_guise");
        guisePreviewProperty.setValue("true");

        props.getTranscodeProperty().add(a5TypeProperty);
        props.getTranscodeProperty().add(guiseProperty);
        props.getTranscodeProperty().add(guisePreviewProperty);
        return props;
    }

    public static TranscodeProperties getTumbnailProperies() {
        TranscodeProperties props = new ObjectFactory().createTranscodeProperties();
        TranscodeProperty a5TypeProperty = new TranscodeProperty();
        a5TypeProperty.setName("a5_type");
        a5TypeProperty.setValue("thumbnail");
        TranscodeProperty guiseProperty = new TranscodeProperty();
        guiseProperty.setName("guise");
        guiseProperty.setValue("preview");
        TranscodeProperty guisePreviewProperty = new TranscodeProperty();
        guisePreviewProperty.setName("proxy_guise");
        guisePreviewProperty.setValue("true");

        props.getTranscodeProperty().add(a5TypeProperty);
        props.getTranscodeProperty().add(guiseProperty);
        props.getTranscodeProperty().add(guisePreviewProperty);
        return props;
    }
}
