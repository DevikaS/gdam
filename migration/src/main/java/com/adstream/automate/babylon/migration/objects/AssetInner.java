package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:05 PM

 */
@XmlRootElement(name = "Asset")
public class AssetInner {
    private List<MusicRightsFieldsList> musicRightsFieldsList;

    @XmlElement(name = "MusicRightsFieldsList")
    public List<MusicRightsFieldsList> getMusicRightsFieldsList() {
        return musicRightsFieldsList;
    }

    public void setMusicRightsFieldsList(List<MusicRightsFieldsList> musicRightsFieldsList) {
        this.musicRightsFieldsList = musicRightsFieldsList;
    }

}
