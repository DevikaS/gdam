package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 12/02/2016.
 */
public class Users_GetUserInfo extends BaseTests {

        @Test
        public void getUserInfoTest(){
                apiCall = new HeadlessAPICalls();

                responsePayLoad = apiCall.getCurrentUser();

                actual_list.clear();
                actual_list.add(responsePayLoad.getId());
                actual_list.add(responsePayLoad.getMeta().getCommon().getEmail());

                expected_list.clear();
                expected_list.add(ExpectedData.USERID);
                expected_list.add(ExpectedData.USEREMAIL);

                Assert.assertEquals(actual_list,expected_list,
                        "Users_Getuserinfo: 'GetCurrentUser' - Endpoint failed, due to, ");

                responsePayLoad = apiCall.getUserInfo(responsePayLoad.getId());

                actual_list.clear();
                actual_list.add(responsePayLoad.getId());
                actual_list.add(responsePayLoad.getMeta().getCommon().getEmail());

                expected_list.clear();
                expected_list.add(ExpectedData.USERID);
                expected_list.add(ExpectedData.USEREMAIL);

                Assert.assertEquals(actual_list,expected_list,
                        this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");
        }
}
