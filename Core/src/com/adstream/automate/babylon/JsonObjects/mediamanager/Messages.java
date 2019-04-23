package com.adstream.automate.babylon.JsonObjects.mediamanager;

/**
 * Created by Saritha.Dhanala on 19/02/2018.
 */
public class Messages
{
    private Errors[] errors;

    private String[] notes;

    private Warnings[] warnings;

    public Errors[] getErrors ()
    {
        return errors;
    }

    public void setErrors (Errors[] errors)
    {
        this.errors = errors;
    }

    public String[] getNotes ()
    {
        return notes;
    }

    public void setNotes (String[] notes)
    {
        this.notes = notes;
    }

    public Warnings[] getWarnings ()
    {
        return warnings;
    }

    public void setWarnings (Warnings[] warnings)
    {
        this.warnings = warnings;
    }

}