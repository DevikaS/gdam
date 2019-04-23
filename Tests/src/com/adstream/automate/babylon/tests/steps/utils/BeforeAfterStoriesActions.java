package com.adstream.automate.babylon.tests.steps.utils;

import com.adstream.automate.babylon.BabylonMessageSender;
import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjectBuilder;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GdnBase;
import com.adstream.automate.jbehave.StoryContext;
import com.google.gson.JsonObject;
import org.apache.http.client.methods.HttpPut;
import org.apache.log4j.Logger;
import org.jbehave.core.annotations.AfterStories;
import org.jbehave.core.annotations.BeforeStories;
import org.jbehave.core.annotations.BeforeStory;

/**
 * User: ruslan.semerenko
 * Date: 02.01.13 11:55
 */
public class BeforeAfterStoriesActions extends BaseStep {
    private Logger log = Logger.getLogger(this.getClass());
    private ThreadLocal<StoryContext> storyContext;

    public BeforeAfterStoriesActions(ThreadLocal<StoryContext> storyContext) {
        this.storyContext = storyContext;
    }

    @BeforeStories
    public void deleteAllEmails() {
        if (getContext().deleteEmailsBeforeTests) {
            log.info("Delete old email messages");
            getMailClient().deleteAllMessages();
        }
        if (getContext().updateApplicationUrlInMailService) {
            log.info("Update application url in mail service");
            updateApplicationUrlInMailService();
        }
    }

    @BeforeStory
    public void setStoryName() {
        setStoryName(storyContext.get().getCurrentStory().getName());
    }

    @AfterStories
    public void afterStories() {
        //log.info("Entering After Stories" + System.currentTimeMillis() );
        log.info("Total files uploaded: " + BabylonServiceWrapper.getUploadedFilesCount());
//        GdnBase gdnBase = new GdnBase();
 //       gdnBase.getA5().closeConnection();
        getAMQService().closeConnection();

    }

   private void updateApplicationUrlInMailService() {
        String applicationUrl = getContext().applicationUrl.getProtocol() + "://" + getContext().applicationUrl.getAuthority();
        new BabylonMessageSender(getContext().mailServiceApiUrl) {
            public void updateApplicationUrl(String url) {
                contentType = "application/json";
                JsonObject body = new JsonObjectBuilder()
                        .add("ActionTypeName", "all")
                        .add("ID", 9)
                        .add("Locale", "")
                        .add("Name", "default application URL")
                        .add("ObjectID", "adbank5")
                        .add("PlaceHolderName", "ApplicationURL")
                        .add("Value", url)
                        .build();
                HttpPut put = createPut(baseUrl + "api/TemplateItems/9", body.toString());
                sendRequest(put);
            }
        }.updateApplicationUrl(applicationUrl);
    }
}
