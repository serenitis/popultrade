package com.popultrade.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.*;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.Formula;
import org.hibernate.annotations.Index;
import java.io.Serializable;
import java.util.Comparator;

public class LabelValue implements Comparable, Serializable {
    private static final long serialVersionUID = 3689355407466181430L;

    public static final Comparator CASE_INSENSITIVE_ORDER = new Comparator() {
        public int compare(Object o1, Object o2) {
            String label1 = ((LabelValue) o1).getLabel();
            String label2 = ((LabelValue) o2).getLabel();
            return label1.compareToIgnoreCase(label2);
        }
    };


    // ----------------------------------------------------------- Constructors


    public LabelValue() {
        super();
    }

    public LabelValue(String label, String value) {
        this.label = label;
        this.value = value;
    }


    // ------------------------------------------------------------- Properties


    private String label = null;

    public String getLabel() {
        return this.label;
    }

    public void setLabel(String label) {
        this.label = label;
    }


    private String value = null;

    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }


    // --------------------------------------------------------- Public Methods

    public int compareTo(Object o) {
        // Implicitly tests for the correct type, throwing
        // ClassCastException as required by interface
        String otherLabel = ((LabelValue) o).getLabel();

        return this.getLabel().compareTo(otherLabel);
    }

    public String toString() {
        StringBuffer sb = new StringBuffer("LabelValue[");
        sb.append(this.label);
        sb.append(", ");
        sb.append(this.value);
        sb.append("]");
        return (sb.toString());
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }

        if (!(obj instanceof LabelValue)) {
            return false;
        }

        LabelValue bean = (LabelValue) obj;
        int nil = (this.getValue() == null) ? 1 : 0;
        nil += (bean.getValue() == null) ? 1 : 0;

        if (nil == 2) {
            return true;
        } else if (nil == 1) {
            return false;
        } else {
            return this.getValue().equals(bean.getValue());
        }

    }

    public int hashCode() {
        return (this.getValue() == null) ? 17 : this.getValue().hashCode();
    }
}