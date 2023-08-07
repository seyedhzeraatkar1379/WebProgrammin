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
@Table(name = "auction_participant_table")
@NamedQueries({
    @NamedQuery(name = "AuctionParticipantTable.findAll", query = "SELECT a FROM AuctionParticipantTable a"),
    @NamedQuery(name = "AuctionParticipantTable.findById", query = "SELECT a FROM AuctionParticipantTable a WHERE a.id = :id"),
    @NamedQuery(name = "AuctionParticipantTable.findByPerposedPrice", query = "SELECT a FROM AuctionParticipantTable a WHERE a.perposedPrice = :perposedPrice"),
    @NamedQuery(name = "AuctionParticipantTable.findByPerposedDatetime", query = "SELECT a FROM AuctionParticipantTable a WHERE a.perposedDatetime = :perposedDatetime"),
    @NamedQuery(name = "AuctionParticipantTable.findByStatusCollateral", query = "SELECT a FROM AuctionParticipantTable a WHERE a.statusCollateral = :statusCollateral")})
public class AuctionParticipantTable implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "perposed_price")
    private String perposedPrice;
    @Basic(optional = false)
    @Column(name = "perposed_datetime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date perposedDatetime;
    @Basic(optional = false)
    @Column(name = "status_collateral")
    private String statusCollateral;
    @JoinColumn(name = "auction_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private AuctionTable auctionId;
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private UserTable userId;

    public AuctionParticipantTable() {
    }

    public AuctionParticipantTable(Integer id) {
        this.id = id;
    }

    public AuctionParticipantTable(Integer id, String perposedPrice, Date perposedDatetime, String statusCollateral) {
        this.id = id;
        this.perposedPrice = perposedPrice;
        this.perposedDatetime = perposedDatetime;
        this.statusCollateral = statusCollateral;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPerposedPrice() {
        return perposedPrice;
    }

    public void setPerposedPrice(String perposedPrice) {
        this.perposedPrice = perposedPrice;
    }

    public Date getPerposedDatetime() {
        return perposedDatetime;
    }

    public void setPerposedDatetime(Date perposedDatetime) {
        this.perposedDatetime = perposedDatetime;
    }

    public ActiveOrDeactive getStatusCollateral() {
        if (statusCollateral == Integer.toString(ActiveOrDeactive.ACTIVE.ordinal())) {
            return ActiveOrDeactive.ACTIVE;
        } else {
            return ActiveOrDeactive.DEACTIVE;
        }
    }

    public void setStatusCollateral(ActiveOrDeactive statusCollateral) {
        this.statusCollateral = Integer.toString(statusCollateral.ordinal());
    }

    public AuctionTable getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(AuctionTable auctionId) {
        this.auctionId = auctionId;
    }

    public UserTable getUserId() {
        return userId;
    }

    public void setUserId(UserTable userId) {
        this.userId = userId;
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
        if (!(object instanceof AuctionParticipantTable)) {
            return false;
        }
        AuctionParticipantTable other = (AuctionParticipantTable) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.AuctionParticipantTable[ id=" + id + " ]";
    }

}
