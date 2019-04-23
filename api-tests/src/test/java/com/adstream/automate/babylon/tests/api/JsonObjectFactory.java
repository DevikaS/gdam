package com.adstream.automate.babylon.tests.api;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

/**
 * User: ruslan.semerenko
 * Date: 09.01.14 15:42
 */
public class JsonObjectFactory {
    public static Project getProject() {
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

    public static Reel getReel() {
        Reel reel = new Reel();
        reel.setName(Gen.getHumanReadableString(8, true));
        return reel;
    }
}
