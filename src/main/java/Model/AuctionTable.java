/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Enum.ActiveOrDeactive;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author seyedhossein
 */
@Entity
@Table(name = "auction_table")
@NamedQueries({
    @NamedQuery(name = "AuctionTable.findAll", query = "SELECT a FROM AuctionTable a"),
    @NamedQuery(name = "AuctionTable.findById", query = "SELECT a FROM AuctionTable a WHERE a.id = :id"),
    @NamedQuery(name = "AuctionTable.findByStartDate", query = "SELECT a FROM AuctionTable a WHERE a.startDate = :startDate"),
    @NamedQuery(name = "AuctionTable.findByEndDate", query = "SELECT a FROM AuctionTable a WHERE a.endDate = :endDate"),
    @NamedQuery(name = "AuctionTable.findByStatus", query = "SELECT a FROM AuctionTable a WHERE a.status = :status")})
public class AuctionTable implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "limit_price")
    private String limitPrice;
    @Basic(optional = false)
    @Column(name = "start_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate;
    @Basic(optional = false)
    @Column(name = "end_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endDate;
    @Basic(optional = false)
    @Column(name = "status")
    private String status;
    @JoinColumn(name = "admin_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private AdminTable adminId;
    @JoinColumn(name = "art_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private ArtinfoTable artId;

    public AuctionTable() {
    }

    public AuctionTable(Integer id) {
        this.id = id;
    }

    public AuctionTable(Integer id, Date startDate, Date endDate, ActiveOrDeactive status) {
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = Integer.toString(status.ordinal());
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public ActiveOrDeactive getStatus() {
        if (status.compareTo("0") == 0) {
            return ActiveOrDeactive.DEACTIVE;
        }
        return ActiveOrDeactive.ACTIVE;
    }

    public void setStatus(ActiveOrDeactive status) {
        this.status = Integer.toString(status.ordinal());
    }

    public AdminTable getAdminId() {
        return adminId;
    }

    public void setAdminId(AdminTable adminId) {
        this.adminId = adminId;
    }

    public ArtinfoTable getArtId() {
        return artId;
    }

    public void setArtId(ArtinfoTable artId) {
        this.artId = artId;
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
        if (!(object instanceof AuctionTable)) {
            return false;
        }
        AuctionTable other = (AuctionTable) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.AuctionTable[ id=" + id + " ]";
    }

    /**
     * @return the limitPrice
     */
    public String getLimitPrice() {
        return limitPrice;
    }

    /**
     * @param limitPrice the limitPrice to set
     */
    public void setLimitPrice(String limitPrice) {
        this.limitPrice = limitPrice;
    }

}
