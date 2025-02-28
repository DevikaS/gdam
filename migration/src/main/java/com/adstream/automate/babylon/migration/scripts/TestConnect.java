package com.adstream.automate.babylon.migration.scripts;

import com.google.gdata.client.DocumentQuery;
import com.google.gdata.client.docs.DocsService;
import com.google.gdata.data.MediaContent;
import com.google.gdata.data.docs.DocumentListEntry;
import com.google.gdata.data.docs.DocumentListFeed;
import com.google.gdata.data.media.MediaSource;
import com.google.gdata.util.AuthenticationException;
import com.google.gdata.util.ServiceException;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/5/15
 * Time: 11:05 AM

 */
public class TestConnect {
    private static final DocsService DEFAULT_DOCS_SERVICE = new DocsService("MySpreadSheets");
    private static final String DEFAULT_FEED_URI = "https://drive.google.com/drive/#my-drive";
    private final DocsService service;
    private final String feedURI;

    public static void main(String[] args) {
        TestConnect testConnect = new TestConnect("yuriy.solomin1978@gmail.com", "bfubhfwww123");
    }

    public TestConnect(String username, String password) {
        this(username, password, DEFAULT_FEED_URI);
    }

    public TestConnect(String username, String password, String feedURI) {
        this(username, password, feedURI, DEFAULT_DOCS_SERVICE);
    }

    public TestConnect(String username, String password, String feedURI, DocsService service) {
        this.service = service;
        this.feedURI = feedURI;
        try {
            service.setUserCredentials(username, password);
        } catch (AuthenticationException e) {
            throw new GoogleAccessFailed(username, e);
        }
    }

    protected InputStream resourceAsStream(String title) throws IOException, MalformedURLException {
        try {
            return documentAsStream(exportURL(title));
        } catch (ServiceException e) {
            throw new IOException(e);
        }
    }

    private String exportURL(String title) throws IOException, ServiceException, MalformedURLException {
        DocumentQuery query = documentQuery(title);
        List<DocumentListEntry> entries = service.getFeed(query, DocumentListFeed.class).getEntries();
        if (entries.isEmpty()) {
            throw new GoogleDocumentNotFound(title);
        }
        return ((MediaContent) entries.get(0).getContent()).getUri() + "&exportFormat=odt";
    }

    DocumentQuery documentQuery(String title) throws MalformedURLException {
        DocumentQuery query = new DocumentQuery(new URL(feedURI));
        query.setTitleQuery(title);
        query.setTitleExact(true);
        query.setMaxResults(1);
        return query;
    }

    private InputStream documentAsStream(String url) throws IOException, MalformedURLException {
        try {
            MediaSource ms = service.getMedia(mediaContent(url));
            return ms.getInputStream();
        } catch (ServiceException e) {
            throw new GoogleMediaExportFailed(url, e);
        }
    }

    MediaContent mediaContent(String url) {
        MediaContent mc = new MediaContent();
        mc.setUri(url);
        return mc;
    }

    @SuppressWarnings("serial")
    public static class GoogleAccessFailed extends RuntimeException {

        public GoogleAccessFailed(String username, Throwable cause) {
            super("Google access failed for user " + username, cause);
        }

    }

    @SuppressWarnings("serial")
    public static class GoogleDocumentNotFound extends RuntimeException {

        public GoogleDocumentNotFound(String title) {
            super("Failed to find Google document from " + title);
        }

    }

    @SuppressWarnings("serial")
    public static class GoogleMediaExportFailed extends RuntimeException {

        public GoogleMediaExportFailed(String url, Throwable cause) {
            super("Failed to export Google media from " + url, cause);
        }

    }

}
