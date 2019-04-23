package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sobolev-a on 10.02.2015.
 */
public class AgencyRelationType {

    @SerializedName("list")
    private List<Roles> list = new ArrayList<>();

    public List<Roles> getListRoles() {
        return this.list;
    }

    /**
     * @param type - role name (Parent/Child/Master/Version)
     * @return two different keys for parent and child;
     */
    public int[] getRelationRolesKeys(String type) {
        type = type.toLowerCase();
        int[] keys = new int[2];
        switch (type) {
            case "parent":
                keys[0] = 0;
                keys[1] = 1;
                break;
            case "child":
                keys[0] = 1;
                keys[1] = 0;
                break;
            case "master":
                keys[0] = 1;
                keys[1] = 0;
                break;
            case "version":
                keys[0] = 1;
                keys[1] = 0;
                break;
            default:
                throw new IllegalArgumentException(String.format("wrong argument exception %s", type));
        }

        return keys;
    }

    public static class Roles {
        @SerializedName("roles")
        private List<String> roles;

        private String _id;

        public List<String> getRoles() {
            return this.roles;
        }

        public String getRoleId() {
            return this._id;
        }
    }

}
