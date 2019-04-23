package com.publicApi.jsonPayLoads.GsonClasses;

/**
 * Created by Raja.Gone on 04/07/2016.
 */
public class BaseOfBase{

    private String id;

    private String storageId;

    private String uploadId;

    private String filePartNumber;

    private String _id;

    private String[] parents;

    private String documentType;

    private String created;

    private String[] status;

    private String owner;

    private String type;

    private Meta meta;

    private String modified;

    private String orderReference;

    private String marketId;

    private String a4Status;

    private String viewStatus;

    private String destinationId;

    private String destinationName;

    private String orderAccessible;

    private String assetId;

    private String lastStartDate;

    private String url;

    private int size;

    private String name;

    private double fileSize;

    private int version;
    private String documentId;

    private String relationTypeId;

    private String description;

    private Media media;

    private String subtype;

    private Destinations destinations;

    private Count count;

    private Items[] items;

    private String filename;

    private Assets assets;

    private String reference;

    private String text;

    private Approvals approval;

    private String short_id;

    private Revisions[] revisions;

    private Common common;

    private Stage stage;

    public Approvals getApproval() {
        return approval;
    }

    public void setApproval(Approvals approval) {
        this.approval = approval;
    }

    public String getShort_id() {
        return short_id;
    }

    public void setShort_id(String short_id) {
        this.short_id = short_id;
    }

    public Common getCommon() {
        return common;
    }

    public void setCommon(Common common) {
        this.common = common;
    }

    public Stage getStage() {
        return stage;
    }

    public void setStage(Stage stage) {
        this.stage = stage;
    }

    private String[] permissions;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }



    public String getReference() {
        return reference;
    }

    public Assets getAssets() {
        return assets;
    }

    public void setAssets(Assets assets) {
        this.assets = assets;
    }



    public void setReference(String reference) {
        this.reference = reference;
    }


    public String getDocumentId() {
        return documentId;
    }

    public Destinations getDestinations() {return destinations;}

    public void setDocumentId(String documentId) {
        this.documentId = documentId;
    }


    public String getRelationTypeId() {
        return relationTypeId;
    }

    public void setRelationTypeId(String relationTypeId) {
        this.relationTypeId = relationTypeId;
    }



    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }



    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }



    public Media getMedia ()
    {
        return media;
    }

    public void setMedia (Media media)
    {
        this.media = media;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLastStartDate() {
        return lastStartDate;
    }

    public void setLastStartDate(String lastStartDate) {
        this.lastStartDate = lastStartDate;
    }

    public String getAssetId() {
        return assetId;
    }

    public void setAssetId(String assetId) {
        this.assetId = assetId;
    }

    public String getOrderReference ()
    {
        return orderReference;
    }

    public void setOrderReference (String orderReference)
    {
        this.orderReference = orderReference;
    }

    public String getId ()
    {
        return id;
    }

    public String getStorageId (){
        return storageId;
    }

    public String getuploadId() {
        return uploadId;
    }

    public String getFilePartNumber(){
        return filePartNumber;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String[] getParents ()
    {
        return parents;
    }

    public void setParents (String[] parents)
    {
        this.parents = parents;
    }

    public String getDocumentType ()
    {
        return documentType;
    }

    public void setDocumentType (String documentType)
    {
        this.documentType = documentType;
    }

    public String getCreated ()
    {
        return created;
    }

    public void setCreated (String created)
    {
        this.created = created;
    }

    public String[] getStatus ()
    {
        return status;
    }

    public void setStatus (String[] status)
    {
        this.status = status;
    }

    public String getOwner ()
    {
        return owner;
    }

    public void setOwner (String owner)
    {
        this.owner = owner;
    }

    public String getType ()
    {
        return type;
    }

    public void setType (String type)
    {
        this.type = type;
    }

    public Meta getMeta ()
    {
        return meta;
    }

    public void setMeta (Meta meta)
    {
        this.meta = meta;
    }

    public String getModified ()
    {
        return modified;
    }

    public void setModified (String modified)
    {
        this.modified = modified;
    }

    public String getSubtype() {
        return subtype;
    }

    public void setSubtype(String subtype) {
        this.subtype = subtype;
    }

    public Count getCount ()
    {
        return count;
    }

    public void setCount (Count count)
    {
        this.count = count;
    }

    public Items[] getItems ()
    {
        return items;
    }

    public void setItems (Items[] items)
    {
        this.items = items;
    }

    public String getMarketId ()
    {
        return marketId;
    }

    public void setMarketId (String marketId)
    {
        this.marketId = marketId;
    }

    public String getA4Status ()
    {
        return a4Status;
    }

    public void setA4Status (String a4Status)
    {
        this.a4Status = a4Status;
    }

    public String getViewStatus ()
    {
        return viewStatus;
    }

    public void setViewStatus (String viewStatus)
    {
        this.viewStatus = viewStatus;
    }

    public String getDestinationId ()
    {
        return destinationId;
    }

    public void setDestinationId (String destinationId)
    {
        this.destinationId = destinationId;
    }

    public String getDestinationName ()
    {
        return destinationName;
    }

    public void setDestinationName (String destinationName)
    {
        this.destinationName = destinationName;
    }

    public String getOrderAccessible ()
    {
        return orderAccessible;
    }

    public void setOrderAccessible (String orderAccessible)
    {
        this.orderAccessible = orderAccessible;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) { this._id = _id; }

    public double getFileSize() {
        return fileSize;
    }

    public void setFileSize(double fileSize) {
        this.fileSize = fileSize;
    }

    public Revisions[] getRevisions ()
    {
        return revisions;
    }

    public void setRevisions (Revisions[] revisions)
    {
        this.revisions = revisions;
    }

    private RegisterJobResponse RegisterJobResponse;

    public RegisterJobResponse getRegisterJobResponse ()
    {
        return RegisterJobResponse;
    }

    public void setRegisterJobResponse (RegisterJobResponse RegisterJobResponse)
    {
        this.RegisterJobResponse = RegisterJobResponse;
    }

    public String[] getPermissions ()
    {
        return permissions;
    }

    public void setPermissions (String[] permissions)
    {
        this.permissions = permissions;
    }

}
