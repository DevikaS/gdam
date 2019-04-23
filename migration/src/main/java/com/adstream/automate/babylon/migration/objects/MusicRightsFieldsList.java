package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:09 PM

 */
@XmlRootElement
public class MusicRightsFieldsList {

    private List<MusicRightsFields> musicRightsFields;

    @XmlElement(name = "MusicRightsFields")
    public List<MusicRightsFields> getMusicRightsFields() {
        return musicRightsFields;
    }

    public void setMusicRightsFields(List<MusicRightsFields> musicRightsFields) {
        this.musicRightsFields = musicRightsFields;
    }
}
