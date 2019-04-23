package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 06.08.13 13:36
 */
public class AddAssetsToExistingCollectionTest extends AddAssetsToNewCollectionTest {
    private final static String COLLECTION_SUBTYPE = "asset_filter_collection";
    private static AtomicInteger startCounter = new AtomicInteger();
    private static List<AssetFilter> collections = new ArrayList<>();

    @Override
    public void beforeStart() {
        super.beforeStart();

        int rootCollectionsCount = getParamInt("rootCollectionsCount");
        int childCollectionLevels = getParamInt("childCollectionLevels");
        int actualRootCollectionsCount = getRootCollections().size();

        if (collections.isEmpty()) {
            for (int i = 0; i < rootCollectionsCount - actualRootCollectionsCount; i++) {
                getService().createAssetFilter(Gen.getHumanReadableString(8, true), COLLECTION_SUBTYPE, "{\"and\":[]}");
            }

            if (childCollectionLevels > 0) {
                List<AssetFilter> rootCollections = getRootCollections();

                int counter = 0;
                for (AssetFilter rootCollection : rootCollections) {
                    if (counter >= rootCollectionsCount) break;
                    findOrCreateChildCollections(rootCollection.getId(), childCollectionLevels, Gen.getInt(childCollectionLevels));
                    counter++;
                }
            } else {
                collections.addAll(getRootCollections());
            }
        }
    }

    @Override
    public void start() {
        int collectionIndex = startCounter.getAndIncrement() % collections.size();
        getService().addAssetsToExistingCollection(getAssetIds(), collections.get(collectionIndex));
    }

    private AssetFilter findOrCreateChildCollections(String baseCollectionId, int count, int level) {
        AssetFilter childCollection = findChildCollection(baseCollectionId);
        if (childCollection == null) childCollection = createChildCollection(baseCollectionId);
        if (level == count) collections.add(childCollection);

        return count > 1 ? findOrCreateChildCollections(childCollection.getId(), count - 1, level) : childCollection;
    }

    private AssetFilter createChildCollection(String baseCollectionId) {
        String name = Gen.getHumanReadableString(8, true);
        String query = "{\"and\":[{\"collections\":[\"" + baseCollectionId + "\"]}]}";

        return getService().createAssetFilter(name, COLLECTION_SUBTYPE, query);
    }

    private AssetFilter findChildCollection(String baseCollectionId) {
        for (AssetFilter collection : getService().getAssetFilters(COLLECTION_SUBTYPE).getFilters()) {
            String query = (String)collection.getQuery();

            if (query.contains("collections") && query.contains(baseCollectionId))
                return collection;
        }

        return null;
    }

    private List<AssetFilter> getRootCollections() {
        List<AssetFilter> rootCollections = new ArrayList<AssetFilter>();

        for (AssetFilter collection : getService().getAssetFilters(COLLECTION_SUBTYPE).getFilters())
            if (!((String)collection.getQuery()).contains("collections"))
                rootCollections.add(collection);

        return rootCollections;
    }
}