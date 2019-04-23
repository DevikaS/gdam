package com.adstream.automate.babylon.performance.stress;

/**
 * User: lynda-k
 * Date: 03.09.2014
 * Time: 12:34
 */
public class PublishProjectCreatedFromTemplate extends CreateProjectFromTemplate {
    private static final int PROJECTS_COUNT = 10;

    private static final int FOLDER_LEVELS = 2;
    private static final int FOLDERS_PER_LEVEL = 5;
    private static final int USERS_PER_FOLDER = 2;
    private static final boolean IS_PROJECTS_PUBLISHED = false;

    public static void main(String[] args) throws Exception {
        setUpLogger();
        String templateNameFormat = "NGN-11896 %d";

        for (int i = 0; i < PROJECTS_COUNT; i++) {
            test(String.format(templateNameFormat, i+1), FOLDER_LEVELS, FOLDERS_PER_LEVEL, USERS_PER_FOLDER + i, IS_PROJECTS_PUBLISHED);
        }
    }
}
