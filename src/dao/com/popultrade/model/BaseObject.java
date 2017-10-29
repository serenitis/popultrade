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


public abstract class BaseObject implements Serializable {    
    public abstract String toString();
    public abstract boolean equals(Object o);
    public abstract int hashCode();
}
