package com.adstream.automate.babylon.JsonObjects;

/**
 * User: ruslan.semerenko
 * Date: 24.09.12 12:34
 */
public class GlobalSearchResult {
    private SearchResult<Project> projecttemplates;
    private SearchResult<BaseObject> assets; //todo define asset class
    private SearchResult<Content> projectcontent;
    private SearchResult<Contact> contacts;
    private SearchResult<BaseObject> reels; //todo define reel class
    private SearchResult<Project> projects;

    public SearchResult<Project> getProjectTemplates() {
        return projecttemplates;
    }

    public void setProjectTemplates(SearchResult<Project> projectTemplates) {
        this.projecttemplates = projectTemplates;
    }

    public SearchResult<BaseObject> getAssets() {
        return assets;
    }

    public void setAssets(SearchResult<BaseObject> assets) {
        this.assets = assets;
    }

    public SearchResult<Content> getProjectContent() {
        return projectcontent;
    }

    public void setProjectContent(SearchResult<Content> projectContent) {
        this.projectcontent = projectContent;
    }

    public SearchResult<Contact> getContacts() {
        return contacts;
    }

    public void setContacts(SearchResult<Contact> contacts) {
        this.contacts = contacts;
    }

    public SearchResult<BaseObject> getReels() {
        return reels;
    }

    public void setReels(SearchResult<BaseObject> reels) {
        this.reels = reels;
    }

    public SearchResult<Project> getProjects() {
        return projects;
    }

    public void setProjects(SearchResult<Project> projects) {
        this.projects = projects;
    }
}
