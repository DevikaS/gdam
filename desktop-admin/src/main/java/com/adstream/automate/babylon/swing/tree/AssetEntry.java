package com.adstream.automate.babylon.swing.tree;

import com.adstream.automate.babylon.JsonObjects.Content;

/**
 * User: ruslan.semerenko
 * Date: 07.12.12 16:11
 */
public class AssetEntry {
    private Content asset;

    public AssetEntry(Content asset) {
        this.asset = asset;
    }

    public Content getAsset() {
        return asset;
    }

    @Override
    public String toString() {
        return asset.getName();
    }
}
