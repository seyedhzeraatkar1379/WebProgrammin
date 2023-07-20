/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author seyedhossein
 */
@Entity
@Table(name = "admin_table")
@NamedQueries({
    @NamedQuery(name = "AdminTable.findAll", query = "SELECT a FROM AdminTable a"),
    @NamedQuery(name = "AdminTable.findById", query = "SELECT a FROM AdminTable a WHERE a.id = :id"),
    @NamedQuery(name = "AdminTable.findByFullName", query = "SELECT a FROM AdminTable a WHERE a.fullName = :fullName"),
    @NamedQuery(name = "AdminTable.findByUsername", query = "SELECT a FROM AdminTable a WHERE a.username = :username"),
    @NamedQuery(name = "AdminTable.findByPassword", query = "SELECT a FROM AdminTable a WHERE a.password = :password"),
    @NamedQuery(name = "AdminTable.findByEmail", query = "SELECT a FROM AdminTable a WHERE a.email = :email")})
public class AdminTable implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "full_name")
    private String fullName;
    @Basic(optional = false)
    @Column(name = "username")
    private String username;
    @Basic(optional = false)
    @Column(name = "password")
    private String password;
    @Column(name = "email")
    private String email;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "adminId")
    private Collection<AuctionTable> auctionTableCollection;

    public AdminTable() {
    }

    public AdminTable(Integer id) {
        this.id = id;
    }

    public AdminTable(Integer id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Collection<AuctionTable> getAuctionTableCollection() {
        return auctionTableCollection;
    }

    public void setAuctionTableCollection(Collection<AuctionTable> auctionTableCollection) {
        this.auctionTableCollection = auctionTableCollection;
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
        if (!(object instanceof AdminTable)) {
            return false;
        }
        AdminTable other = (AdminTable) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.AdminTable[ id=" + id + " ]";
    }
    
}
