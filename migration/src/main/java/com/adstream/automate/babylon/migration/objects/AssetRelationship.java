package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:06 PM
 */
public class AssetRelationship {
    private String parentAssetGUID;
    private String childAssetGUID;
    private String relationshipTypeID;
    private String sortOrder;
    private String relationshipType;
    private String relationshipId;

    @XmlElement(name = "ParentAssetGUID")
    public String getParentAssetGUID() {
        return parentAssetGUID;
    }

    public void setParentAssetGUID(String parentAssetGUID) {
        this.parentAssetGUID = parentAssetGUID;
    }

    @XmlElement(name = "ChildAssetGUID")
    public String getChildAssetGUID() {
        return childAssetGUID;
    }

    public void setChildAssetGUID(String childAssetGUID) {
        this.childAssetGUID = childAssetGUID;
    }

    @XmlElement(name = "RelationshipTypeID")
    public String getRelationshipTypeID() {
        return relationshipTypeID;
    }

    public void setRelationshipTypeID(String relationshipTypeID) {
        this.relationshipTypeID = relationshipTypeID;
    }

    @XmlElement(name = "SortOrder")
    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    @XmlElement(name = "RelationshipType")
    public String getRelationshipType() {
        return relationshipType;
    }

    public void setRelationshipType(String relationshipType) {
        this.relationshipType = relationshipType;
    }

    @XmlElement(name = "RelationshipId")
    public String getRelationshipId() {
        return relationshipId;
    }

    public void setRelationshipId(String relationshipId) {
        this.relationshipId = relationshipId;
    }
}
