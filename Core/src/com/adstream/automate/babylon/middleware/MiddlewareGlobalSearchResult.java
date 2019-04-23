package com.adstream.automate.babylon.middleware;

import com.adstream.automate.babylon.JsonObjects.*;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 24.09.12 12:45
 */
public class MiddlewareGlobalSearchResult {
    private Internal globalSearch;

    public GlobalSearchResult getResult() {
        return globalSearch.getResult();
    }

    public static class Internal {
        private Map<String, Project> projecttemplates;
        private Map<String, BaseObject> assets; //todo define asset class
        private Map<String, Content> projectcontent;
        private Map<String, Contact> contacts;
        private Map<String, BaseObject> presentations; //todo define reel class
        private Map<String, Project> projects;

        public GlobalSearchResult getResult() {
            GlobalSearchResult result = new GlobalSearchResult();
            result.setProjectTemplates(convertMap(projecttemplates, Project.class));
            result.setAssets(convertMap(assets, BaseObject.class));
            result.setProjectContent(convertMap(projectcontent, Content.class));
            result.setContacts(convertMap(contacts, Contact.class));
            result.setReels(convertMap(presentations, BaseObject.class));
            result.setProjects(convertMap(projects, Project.class));
            return result;
        }

        private <T> SearchResult<T> convertMap(Map<String, T> map, Class<T> clazz) {
            List<T> list = new ArrayList<T>();
            for (Map.Entry<String, T> entry : map.entrySet()) {
                list.add(entry.getValue());
            }
            SearchResult<T> sr = new SearchResult<T>();
            sr.setResult(list);
            return sr;
        }
    }
}
