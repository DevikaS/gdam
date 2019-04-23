package com.adstream.automate.babylon.yadn.cache;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 20.09.13 12:17
 */
public class FakeBabylonService extends BabylonCoreService {
    private String userId;
    private String uploadUrl;

    public FakeBabylonService(URL url, String userId) {
        super(url, userId);
        this.uploadUrl = url.toString();
        this.userId = userId;
    }

    @Override
    public User getCurrentUser() {
        User user = new User();
        user.setId(userId);
        return user;
    }

    @Override
    public Agency getCurrentAgency() {
        Agency agency = new Agency();
        agency.setStorageId("");
        return agency;
    }

    @Override
    public SearchResult<FileStorage> getGdnStorages() {
        FileStorage storage = new FileStorage();
        storage.setFileStorageId("");
        storage.setUploadUrl(uploadUrl);
        List<FileStorage> storages = new ArrayList<>();
        storages.add(storage);
        SearchResult<FileStorage> result = new SearchResult<>();
        result.setResult(storages);
        return result;
    }
}