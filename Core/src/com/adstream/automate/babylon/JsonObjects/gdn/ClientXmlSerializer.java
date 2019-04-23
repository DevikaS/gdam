package com.adstream.automate.babylon.JsonObjects.gdn;

import com.adstream.gdn.api.client.serialization.*;


/**
 * Created by Ramababu.Bendalam on 25/01/2016.
 */
public class ClientXmlSerializer extends AbstractGdnClientXmlSerializer {

    public <T extends Job> String serializeJobJava(T obj) {
        return serializeJobString(obj);
    }

    public <T extends JobResponse> T deserializeJobResponseJava(String str) {
        return deserializeJobResponseString(str);
    }

    public <T extends JobResponse> String serializeJobResponseJava(T obj) {
        return serializeJobResponseString(obj);
    }

    public <T extends Job> T deserializeJobJava(String str) {
        return deserializeJobString(str);
    }

    public <T extends Command> String serializeComandJava(T obj) {
        return serializeCommandString(obj);
    }

    public <T extends CommandResponse> T deserializeCommandResponseJava(String str) {
        return deserializeCommandResponseString(str);
    }
}
