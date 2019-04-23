package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.IOException;

/**
 * To validate register media endpoint {@code https://a5.adstream.com/api/v2/media}
 * with size attrib as '0' and actual size
 */
public class Media_RegisterMedia extends ProjectsBaseTest {


    @Test
    public void registerMediaWithActualSizeTest() throws IOException{

        apiCall = new HeadlessAPICalls();
        Assert.assertTrue(apiCall.registerMedia(false),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed");

    }

    @Test
    public void registerMediaWithSizeAsZeroTest() throws IOException{

        apiCall = new HeadlessAPICalls();
        Assert.assertTrue(apiCall.registerMedia(true),
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed");
    }

}
