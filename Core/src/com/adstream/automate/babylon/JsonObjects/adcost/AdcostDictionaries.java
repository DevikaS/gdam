package com.adstream.automate.babylon.JsonObjects.adcost;

import java.util.List;

/**
 * Created by Raja.Gone on 08/06/2017.
 */
public class AdcostDictionaries {
    private String id;

    private String isNameEditable;

    private String isStatic;

    private String name;

    private DictionaryEntries[] dictionaryEntries;

    private String abstractTypeId;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getIsNameEditable ()
    {
        return isNameEditable;
    }

    public void setIsNameEditable (String isNameEditable)
    {
        this.isNameEditable = isNameEditable;
    }

    public String getIsStatic ()
    {
        return isStatic;
    }

    public void setIsStatic (String isStatic)
    {
        this.isStatic = isStatic;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public DictionaryEntries[] getDictionaryEntries ()
    {
        return dictionaryEntries;
    }

    public void setDictionaryEntries (DictionaryEntries[] dictionaryEntries)
    {
        this.dictionaryEntries = dictionaryEntries;
    }

    public String getAbstractTypeId ()
    {
        return abstractTypeId;
    }

    public void setAbstractTypeId (String abstractTypeId)
    {
        this.abstractTypeId = abstractTypeId;
    }
}
