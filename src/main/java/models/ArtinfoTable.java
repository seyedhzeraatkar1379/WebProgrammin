/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
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
@Table(name = "artinfo_table")
@NamedQueries({
    @NamedQuery(name = "ArtinfoTable.findAll", query = "SELECT a FROM ArtinfoTable a"),
    @NamedQuery(name = "ArtinfoTable.findById", query = "SELECT a FROM ArtinfoTable a WHERE a.id = :id"),
    @NamedQuery(name = "ArtinfoTable.findByName", query = "SELECT a FROM ArtinfoTable a WHERE a.name = :name"),
    @NamedQuery(name = "ArtinfoTable.findByDescription", query = "SELECT a FROM ArtinfoTable a WHERE a.description = :description"),
    @NamedQuery(name = "ArtinfoTable.findByPhotoPath", query = "SELECT a FROM ArtinfoTable a WHERE a.photoPath = :photoPath")})
public class ArtinfoTable implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "name")
    private String name;
    @Column(name = "description")
    private String description;
    @Column(name = "photo_path")
    private String photoPath;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "artId")
    private List<AuctionTable> auctionTableCollection;

    public ArtinfoTable() {
    }

    public ArtinfoTable(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }

    public List<AuctionTable> getAuctionTableList() {
        return auctionTableCollection;
    }

    public void setAuctionTableList(List<AuctionTable> auctionTableCollection) {
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
        if (!(object instanceof ArtinfoTable)) {
            return false;
        }
        ArtinfoTable other = (ArtinfoTable) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.ArtinfoTable[ id=" + id + " ]";
    }
    
}
