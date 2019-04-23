package com.adstream.automate.babylon.migration.actions;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.utils.Gen;
import static com.adstream.automate.babylon.migration.tests.BaseTest.getService;

/**
 * Created with IntelliJ IDEA.
 * User: User
 * Date: 11.10.13
 * Time: 22:20

 */
public class CreateFolder extends BaseTest {

    public String folder_name = "";

    public Content addNewFolder(Project projectApp ){
        this.folder_name = Gen.getHumanReadableString(6, true);
        Content con = getService().createFolder(projectApp.getId(), folder_name);
        con.setName(folder_name);
        return con;
    }

    public String getNewFolderName() {
        return folder_name;
    }
}
