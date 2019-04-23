package com.adstream.automate.babylon.JsonObjects.activity;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class ActivityQuery {
    public static interface Element {}

    public static class And implements Element {
        private List<Element> elements;

        public And(Element... elements) {
            this.elements = Arrays.asList(elements);
        }

        public List<Element> getElements() {
            return elements;
        }

        public String toString() {
            StringBuilder str = new StringBuilder();
            str.append("{ \"AND\" : [ ");
            Iterator it = elements.iterator();
            while (it.hasNext()) {
                str.append(it.next().toString());
                if (it.hasNext()) {
                    str.append(" , ");
                }
            }
            str.append(" ] }");
            return str.toString();
        }
    }

    public static class Or implements Element {
        private List<Element> elements;

        public Or(Element... elements) {
            this.elements = Arrays.asList(elements);
        }

        public List<Element> getElements() {
            return elements;
        }

        public String toString() {
            StringBuilder str = new StringBuilder();
            str.append("{ \"OR\" : [ ");
            Iterator it = elements.iterator();
            while (it.hasNext()) {
                str.append(it.next().toString());
                if (it.hasNext()) {
                    str.append(" , ");
                }
            }
            str.append(" ] }");
            return str.toString();
        }
    }

    public static class Not implements Element {
        private Element element;

        public Not(Element element) {
            this.element = element;
        }

        public Element getElement() {
            return element;
        }

        public String toString() {
            return "{ \"NOT\" : " + element.toString() + " }";
        }
    }

    public static class Term implements Element {
        private String key;
        private List<String> values;

        public Term(String key, String... values) {
            this.key = key;
            this.values = Arrays.asList(values);
        }

        public String getKey() {
            return key;
        }

        public List<String> getValues() {
            return values;
        }

        public String toString() {
            StringBuilder str = new StringBuilder();
            str.append("{ \"TERM\" : { \"").append(escape(key)).append("\" : [ ");
            Iterator it = values.iterator();
            while (it.hasNext()) {
                str.append("\"").append(escape(it.next().toString())).append("\"");
                if (it.hasNext()) {
                    str.append(" , ");
                }
            }
            str.append(" ] } }");
            return str.toString();
        }
    }

    public static class Range implements Element {
        private String field;
        private String from;
        private String to;

        public Range(String field, String from, String to) {
            this.field = field;
            this.from = from;
            this.to = to;
        }

        public String getField() {
            return field;
        }

        public String getFrom() {
            return from;
        }

        public String getTo() {
            return to;
        }

        public String toString() {
            return String.format("{ \"RANGE\" : { \"field\" : \"%s\" , \"from\" : \"%s\" , \"to\" : \"%s\" } }",
                    escape(field), escape(from), escape(to));
        }
    }

    public static class Sort {
        private String field;
        private boolean ascending;

        public Sort(String field, boolean ascending) {
            this.field = field;
            this.ascending = ascending;
        }

        public String getField() {
            return field;
        }

        public boolean isAscending() {
            return ascending;
        }

        public String toString() {
            return String.format("{ \"%s\" : \"%s\" }", escape(field), ascending ? "asc" : "desc");
        }
    }

    private static String escape(String s) {
        return s.replace("\"", "\\\"");
    }

    private Element query;
    private List<Sort> sortElements;

    public ActivityQuery(Element query) {
        this.query = query;
    }

    public ActivityQuery(Element query, Sort... sort) {
        this.query = query;
        this.sortElements = Arrays.asList(sort);
    }

    public String toString() {
        StringBuilder str = new StringBuilder();
        str.append("{ \"query\" : ").append(query.toString()).append(" , \"sort\" : [ ");
        if (sortElements != null) {
            Iterator it = sortElements.iterator();
            while (it.hasNext()) {
                str.append(it.next().toString());
                if (it.hasNext()) {
                    str.append(" , ");
                }
            }
        }
        str.append(" ] }");
        return str.toString();
    }
}
