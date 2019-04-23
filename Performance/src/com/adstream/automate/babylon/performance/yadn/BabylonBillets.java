package com.adstream.automate.babylon.performance.yadn;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

/**
 * User: ruslan.semerenko
 * Date: 13.09.12 16:49
 */
public class BabylonBillets {
    private BabylonServiceWrapper service;
    private Agency currentAgency;

    public BabylonBillets(BabylonServiceWrapper service) {
        this.service = service;
    }

    public Project getProjectBillet() {
        Project project = new Project();
        project.setMediaType("Broadcast");
        project.setAdministrators(new String[0]);
        project.setSubtype("project");
        project.setLogo("");
        project.setDateStart(new DateTime());
        project.setDateEnd(new DateTime().plus(Period.days(1)));
        project.setName(Gen.getHumanReadableString(8, true));
        project.setJobNumber(Gen.getHumanReadableString(8, true));
        return project;
    }

    private Agency getCurrentAgency() {
        if (currentAgency == null) {
            currentAgency = service.getCurrentAgency();
        }
        return currentAgency;
    }
}
