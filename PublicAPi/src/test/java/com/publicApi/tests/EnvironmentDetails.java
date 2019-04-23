

package com.publicApi.tests; import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import com.publicApi.utilities.HttpCalls;
import org.testng.ITestContext;
import org.testng.annotations.Test;

import java.io.IOException;
/**  * Created by Geethanjali.K  on 12/02/26e016.  */
public class EnvironmentDetails extends BaseTests {
    public EnvironmentDetails() {
        try {
            apiCall = new HeadlessAPICalls();
            coreService = new HttpCalls();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void environmentDetails() {
        Boolean status;
        System.out.println("\n    ****----------------------------------------------------------------------------****");
        System.out.println("           Test_Environment: " + getBaseURL());
        System.out.println("    ****----------------------------------------------------------------------------****\n");
        status = apiCall.getEnvironmentDetails();
        if(status){
            System.out.println("PAPI environment is UP and Running");
        }else{
            System.out.println("PAPI environment is down");
            System.exit(0);
        }
        String[] values = {"agencyAdmin","broadcastManager","trafficManager","approval","internalAdmin","s3StorageAdmin"};
        String[] keys = {"Key","BroadcastManagerKey","TrafficManagerKey","ApprovalKey","InternalAdminKey","s3StorageAdminKey"};
        String[] secrets = {"Secret","BroadcastManagerSecret","TrafficManagerSecret","ApprovalSecret","InternalAdminSecret","s3StorageAdminSecret"};
        for(int i=0;i<values.length;i++){
            System.out.println("****------------------------"+values[i]+"----------------------****");
            System.out.println("Key:"+BaseTests.getProp().getProperty(keys[i]));
            System.out.println("Secret:"+BaseTests.getProp().getProperty(secrets[i]));
        }
    }
    }

