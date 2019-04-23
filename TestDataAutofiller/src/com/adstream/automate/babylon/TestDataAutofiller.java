package com.adstream.automate.babylon;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.ArrayUtils;

import static java.util.Arrays.asList;

/**
 * User: ruslan.semerenko
 * Date: 28.05.12 13:13
 */
public class TestDataAutofiller {
    public static void main(String[] args) {
        if (args.length < 2 || args.length > 3) {
            System.out.println("Invalid count of command line arguments");
            System.out.println("arguments: configFilePath defaultObjectsFilePath [generateListFilePath]");
            return;
        }
        if (!checkFiles(args)) return;
        File properties = new File(args[0]);
        File defaultObjects = new File(args[1]);
        File generateList = (args.length == 3) ? new File(args[2]) : null;
        File generateAdcostListFile = (args.length == 3) ? new File(args[3]) : null;
        List<String> storiestlist = storyPaths();
        try {
            new TestDataGenerator(defaultObjects, generateList, properties,generateAdcostListFile,storiestlist)
                    .createDefaultElements();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("FINISHED");
    }

    public static List<String> storyPaths() {
        List<String> listOfDesiredStories = asList(TestsContext.getInstance().storiesList);
        List<String> listOfResolvedDesiredStories = new ArrayList<>();
        String storyFilterRaw = System.getProperty("tests.story_filter","").trim();
        if (!storyFilterRaw.isEmpty()) {
            List<String> listOfStoryFilter = asList(storyFilterRaw.split(";"));
            for (String storyFilter: listOfStoryFilter){
                for (String desiredStory : listOfDesiredStories) {
                    if (desiredStory.matches(storyFilter) && !listOfResolvedDesiredStories.contains(desiredStory + ".story")) {
                        listOfResolvedDesiredStories.add(desiredStory + ".story");
                    }
                }
            }
        } else {
            for (String desiredStory : listOfDesiredStories) {
                listOfResolvedDesiredStories.add(desiredStory + ".story");
            }
        }

        return listOfResolvedDesiredStories;
    }

    public static boolean checkFiles(String[] files) {
        for (String str : files) {
            File file = new File(str);
            if (!file.exists()) {
                System.out.println(str + " is not exist");
                return false;
            }
            if (file.isDirectory()) {
                System.out.println(str + " is a directory");
                return false;
            }
            if (!file.canRead()) {
                System.out.println(str + " is not readable");
                return false;
            }
        }
        return true;
    }
}
