package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.activity.Activity;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityQuery;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityType;
import com.adstream.automate.babylon.JsonObjects.activity.Pager;

import javax.annotation.Nullable;

public interface PaperPusherService {
    public SearchResult<Activity> getActivities(ActivityType type, String objectId, @Nullable String creatorUserId, @Nullable String recipientUserId, @Nullable Pager pager);
    public SearchResult<Activity> getActivities(ActivityType type, @Nullable String recipientUserId, @Nullable String agencyId, @Nullable Pager pager);
    public SearchResult<Activity> findActivities(ActivityType type, ActivityQuery query, @Nullable Pager pager);
}
