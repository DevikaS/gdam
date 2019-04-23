package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.activity.Activity;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityQuery;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityType;
import com.adstream.automate.babylon.JsonObjects.activity.Pager;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;

import java.io.File;
import java.util.concurrent.*;

/**
 * User: ruslan.semerenko
 * Date: 28.02.13 14:25
 */
public class OpenDashboardTest extends CreateProjectTest {
    private static volatile boolean assetsCreated = false;
    private static volatile boolean collectionsCreated = false;
    private static volatile boolean reelsCreated = false;
    private static volatile boolean projectsCreated = false;

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        if (!assetsCreated) {
            createAssets();
            assetsCreated = true;
        }
        if (!collectionsCreated) {
            createCollections();
            collectionsCreated = true;
        }
        if (!reelsCreated) {
            createReels();
            reelsCreated = true;
        }
        if (!projectsCreated) {
            createProjects();
            projectsCreated = true;
        }
    }

    private void createAssets() {
        int assetsCount = getParamInt("assetsCount");
        SearchResult<Content> assets;
        int page = 1;
        do {
            assets = getService().findAssets(getMyAssetsCategoryId(), new LuceneSearchingParams().setResultsOnPage(50).setPageNumber(page++));
            assetsCount -= assets.getResult().size();
        } while(assetsCount > 0 && assets.hasMore());
        if (assetsCount > 0) {
            log.info(String.format("Create %d assets", assetsCount));
        }
        for (int i = 0; i < assetsCount; i++) {
            uploadAsset(new File(getParam("filePath")));
        }
    }

    private void createCollections() {
        int collectionsCount = getParamInt("collectionsCount") - getService().getAssetFilters().getFilters().size();
        if (collectionsCount > 0) {
            log.info(String.format("Create %d collections", collectionsCount));
        }
        for (int i = 0; i < collectionsCount; i++) {
            getService().createAssetFilter(Gen.getHumanReadableString(6, true), "asset_filter_category", "{\"and\":[]}");
        }
    }

    private void createReels() {
        int reelsCount = getParamInt("reelsCount") - getService().findReels(new LuceneSearchingParams()).getResult().size();
        if (reelsCount > 0) {
            log.info(String.format("Create %d reels", reelsCount));
        }
        for (int i = 0; i < reelsCount; i++) {
            Reel reel = new Reel();
            reel.setName(Gen.getHumanReadableString(6));
            reel.setDescription(Gen.getHumanReadableString(6));
            getService().createReel(reel);
        }
    }

    private void createProjects() {
        int projectsCount = getParamInt("projectsCount");
        SearchResult<Project> projects;
        int page = 1;
        do {
            projects = getService().findProjects(new LuceneSearchingParams().setResultsOnPage(50).setPageNumber(page++));
            projectsCount -= projects.getResult().size();
        } while(projectsCount > 0 && projects.hasMore());
        if (projectsCount > 0) {
            log.info(String.format("Create %d projects", projectsCount));
        }
        for (int i = 0; i < projectsCount; i++) {
            super.start();
        }
    }

    @Override
    public void start() {
        ExecutorService executor = Executors.newFixedThreadPool(8);

        executor.execute(getFindAssets());
        executor.execute(getFindReels());
        executor.execute(getFindCollections());
        executor.execute(getFindProjects());
        executor.execute(findActivities(getCurrentAgency().getId()));

        executor.shutdown();
        while (!executor.isTerminated()) {
            Common.sleep(10);
        }
    }

    private Runnable findActivities(final String agencyId) {
        return new Runnable() {
            @Override
            public void run() {
                ActivityQuery query = new ActivityQuery(
                        new ActivityQuery.And(
                                new ActivityQuery.Term("object.agency.id", agencyId),
                                new ActivityQuery.Not(
                                        new ActivityQuery.Term("action.type",
                                                "projectSharedWithInvite",
                                                "projectSharedWithUsers",
                                                "filesSharedWithInvite",
                                                "filesSharedWithUsers",
                                                "folderSharedWithInvite",
                                                "folderSharedWithUsers",
                                                "assetsSharedWithInvite",
                                                "assetsSharedWithUsers",
                                                "presentationSharedWithInvite",
                                                "presentationSharedWithUsers"
                                        )
                                )
                        )
                );
                SearchResult<Activity> activities = getPaperPusherService().findActivities(ActivityType.dashboard, query, new Pager(10, 0));
                if (activities == null) {
                    throw new RuntimeException("Could not find activities");
                }
            }
        };
    }

    private Runnable getFindAssets() {
        return new Runnable() {
            @Override
            public void run() {
                LuceneSearchingParams query = new LuceneSearchingParams().setPageNumber(1).setResultsOnPage(10);
                SearchResult<Content> result = getService().findAssets(getMyAssetsCategoryId(), query);
                if (result == null) {
                    throw new RuntimeException("Could not find assets");
                }
            }
        };
    }

    private Runnable getFindReels() {
        return new Runnable() {
            @Override
            public void run() {
                LuceneSearchingParams query = new LuceneSearchingParams()
                        .setSortingOrder("desc").setSortingField("_created").setResultsOnPage(5);
                SearchResult<Reel> result = getService().findReels(query);
                if (result == null) {
                    throw new RuntimeException("Could not find reels");
                }
            }
        };
    }

    private Runnable getFindCollections() {
        return new Runnable() {
            @Override
            public void run() {
                AssetFilters result = getService().getAssetFilters();
                if (result == null) {
                    throw new RuntimeException("Could not find collections");
                }
            }
        };
    }

    private Runnable getFindProjects() {
        return new Runnable() {
            @Override
            public void run() {
                LuceneSearchingParams query = new LuceneSearchingParams()
                        .setQuery("owner.$id:" + getCurrentUser().getId()).setPageNumber(1).setResultsOnPage(5);
                getService().findProjects(query);
            }
        };
    }
}
