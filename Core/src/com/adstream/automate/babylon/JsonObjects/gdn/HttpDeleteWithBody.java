package com.adstream.automate.babylon.JsonObjects.gdn;

import org.apache.http.annotation.NotThreadSafe;
import org.apache.http.client.methods.HttpEntityEnclosingRequestBase;
import org.apache.http.client.methods.HttpRequestBase;

import java.net.URI;

/**
 * Created by Ramababu.Bendalam on 21/07/2016.
 */

@NotThreadSafe
public class HttpDeleteWithBody extends HttpEntityEnclosingRequestBase {

      public static final String METHOD_NAME = "DELETE";

        public HttpDeleteWithBody() {
        }

        public HttpDeleteWithBody(URI uri) {
            this.setURI(uri);
        }

        public HttpDeleteWithBody(String uri) {
            this.setURI(URI.create(uri));
        }

        public String getMethod() {
            return "DELETE";
        }
    }


