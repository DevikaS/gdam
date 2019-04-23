package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsActivityPage;

/**
 * Created by sobolev-a on 20.01.2015.
 */
public interface AssetActivity extends ActivityAction {

    public void secureShareAssetActivity(AdbankLibraryAssetsActivityPage activityPage, String condition, String senderName, String recipientName);

    public void assetWasTranscodedActivity(AdbankLibraryAssetsActivityPage activityPage, String condition, String uploaderName);

    public void uploadAsset(AdbankLibraryAssetsActivityPage activityPage, String condition, String uploaderName);
}
