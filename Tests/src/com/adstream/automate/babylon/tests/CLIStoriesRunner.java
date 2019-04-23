package com.adstream.automate.babylon.tests;

import com.adstream.automate.babylon.BabylonEmbedder;
import org.apache.log4j.PropertyConfigurator;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 09.02.12
 * Time: 14:38
 */
public class CLIStoriesRunner {
    //entry point to tests
    public static void main(String[] args) throws Throwable {
        new BabylonEmbedder(args).run();
    }
}
