package com.adstream.automate.babylon;

/**
 * User: ruslan.semerenko
 * Date: 04.04.12 18:15
 */
public class LuceneSearchingParams extends SearchingParams {
    public static final String ORDER_ASCENDING = "ASC";
    public static final String ORDER_DESCENDING = "DESC";

    private String query = null;
    private Integer page = null;
    private Integer size = null;
    private String sort = null;
    private String order = null;
    private Boolean deleted = null;
    private String status = null; // status of order: in_progress, draft, waiting_for_approval, completed

    public String getQuery() {
        return query;
    }

    public LuceneSearchingParams setQuery(String query) {
        this.query = query;
        return this;
    }

    public Integer getPageNumber() {
        return page;
    }

    public LuceneSearchingParams setPageNumber(Integer pageNumber) {
        page = pageNumber;
        return this;
    }

    public Integer getResultsOnPage() {
        return size;
    }

    public LuceneSearchingParams setResultsOnPage(Integer resultsOnPage) {
        size = resultsOnPage;
        return this;
    }

    public String getSortingField() {
        return sort;
    }

    public LuceneSearchingParams setSortingField(String sortingField) {
        sort = sortingField;
        return this;
    }

    public String getSortingOrder() {
        return order;
    }

    public LuceneSearchingParams setSortingOrder(String sortingOrder) {
        order = sortingOrder;
        return this;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public LuceneSearchingParams setDeleted(Boolean deleted) {
        this.deleted = deleted;
        return this;
    }

    public String getStatus() {
        return status;
    }

    public LuceneSearchingParams setStatus(String status) {
        this.status = status;
        return this;
    }
}