package com.adstream.automate.babylon.JsonObjects.adcost;

import java.util.List;

/**
 * Created by Arti.Sharma on 17/01/2017.
 */
public class PaymentRules {

    private Criteria criteria;

    private Definition definition;

    private boolean skipFirstPresentation;
    
    private String name;

    private String id;

    public Criteria getCriteria ()
    {
        if (criteria == null) criteria = new Criteria();
        return criteria;
    }

    public void setCriteria (Criteria criteria)
    {
        if (criteria == null) criteria = new Criteria();
        this.criteria = criteria;
    }

    public Definition getDefinition ()
    {
        if (definition == null) definition = new Definition();
        return definition;
    }

    public void setDefinition (Definition definition)
    {
        if (definition == null) definition = new Definition();
        this.definition = definition;
    }

    public Boolean getskipFirstPresentation ()
    {
        return skipFirstPresentation;
    }

    public void setSkipFirstPresentation (Boolean skipFirstPresentation)
    {
        this.skipFirstPresentation = skipFirstPresentation;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }


}
