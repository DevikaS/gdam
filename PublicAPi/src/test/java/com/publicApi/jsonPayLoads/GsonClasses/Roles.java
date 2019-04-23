package com.publicApi.jsonPayLoads.GsonClasses;


public class Roles {
    private String role;

    private String name;

    private boolean inheritance;

    private boolean parent;

    public void setRole(String role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setInheritance(boolean inheritance) {
        this.inheritance = inheritance;
    }

    public void setParent(boolean parent) {
        this.parent = parent;
    }

    public boolean isInheritance() {
        return inheritance;
    }

    public String getRole() {
        return role;
    }

    public boolean isParent() {
        return parent;
    }

}

