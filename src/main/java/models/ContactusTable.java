/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author seyedhossein
 */
@Entity
@Table(name = "contactus_table")
@NamedQueries({
    @NamedQuery(name = "ContactusTable.findAll", query = "SELECT c FROM ContactusTable c"),
    @NamedQuery(name = "ContactusTable.findById", query = "SELECT c FROM ContactusTable c WHERE c.id = :id"),
    @NamedQuery(name = "ContactusTable.findByEmail", query = "SELECT c FROM ContactusTable c WHERE c.email = :email"),
    @NamedQuery(name = "ContactusTable.findByTellPhone", query = "SELECT c FROM ContactusTable c WHERE c.tellPhone = :tellPhone"),
    @NamedQuery(name = "ContactusTable.findByAddress", query = "SELECT c FROM ContactusTable c WHERE c.address = :address")})
public class ContactusTable implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "email")
    private String email;
    @Column(name = "tell_phone")
    private String tellPhone;
    @Column(name = "address")
    private String address;

    public ContactusTable() {
    }

    public ContactusTable(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTellPhone() {
        return tellPhone;
    }

    public void setTellPhone(String tellPhone) {
        this.tellPhone = tellPhone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ContactusTable)) {
            return false;
        }
        ContactusTable other = (ContactusTable) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.ContactusTable[ id=" + id + " ]";
    }
    
}
