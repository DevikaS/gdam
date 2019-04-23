package com.adstream.automate.babylon.migration.actions;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;
import static java.util.Arrays.asList;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/11/13
 * Time: 9:20 AM

 */
public class CreateProject {
    private Project defaultProject;
    private String advertiser;

    public Project getProject() {
        if (defaultProject == null) {
            Project project = new Project();
            project.setMediaType("Broadcast");
            project.setAdministrators(new String[0]);
            project.setSubtype("project");
            project.setLogo("");
            project.setDateStart(new DateTime());
            project.setDateEnd(new DateTime().plus(Period.days(1)));
            if (advertiser!=null && advertiser.length()>0)
                project.getCmCommon().put("advertiser", asList(advertiser));
            defaultProject = project;
        }
        defaultProject.setName(Gen.getHumanReadableString(10, true));
        defaultProject.setJobNumber(Gen.getHumanReadableString(8, true));
        return defaultProject;
    }

    public String getAdvertiser() {
        return advertiser;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }
}
