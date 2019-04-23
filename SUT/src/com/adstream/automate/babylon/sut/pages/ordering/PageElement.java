package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 15.11.13
 * Time: 14:32
 */
public abstract class PageElement<T extends BaseOrderingPage> {
    protected ExtendedWebDriver web;
    protected T parent;

    public PageElement(ExtendedWebDriver web, T parent) {
        this.web = web;
        this.parent = parent;
    }
}