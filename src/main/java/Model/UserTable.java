/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Enum.ActiveOrDeactive;
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
@Table(name = "user_table")
@NamedQueries({
    @NamedQuery(name = "UserTable.findAll", query = "SELECT u FROM UserTable u"),
    @NamedQuery(name = "UserTable.findById", query = "SELECT u FROM UserTable u WHERE u.id = :id"),
    @NamedQuery(name = "UserTable.findByFullname", query = "SELECT u FROM UserTable u WHERE u.fullname = :fullname"),
    @NamedQuery(name = "UserTable.findByEmail", query = "SELECT u FROM UserTable u WHERE u.email = :email"),
    @NamedQuery(name = "UserTable.findByPassword", query = "SELECT u FROM UserTable u WHERE u.password = :password"),
    @NamedQuery(name = "UserTable.findByPhoneNumber", query = "SELECT u FROM UserTable u WHERE u.phoneNumber = :phoneNumber"),
    @NamedQuery(name = "UserTable.findByAddress", query = "SELECT u FROM UserTable u WHERE u.address = :address"),
    @NamedQuery(name = "UserTable.findByIdCardCode", query = "SELECT u FROM UserTable u WHERE u.idCardCode = :idCardCode"),
    @NamedQuery(name = "UserTable.findByCommitmentLeterPath", query = "SELECT u FROM UserTable u WHERE u.commitmentLeterPath = :commitmentLeterPath"),
    @NamedQuery(name = "UserTable.findByIdCardPhotoPath", query = "SELECT u FROM UserTable u WHERE u.idCardPhotoPath = :idCardPhotoPath"),
    @NamedQuery(name = "UserTable.findByUserStatus", query = "SELECT u FROM UserTable u WHERE u.userStatus = :userStatus")})
public class UserTable implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "fullname")
    private String fullname;
    @Basic(optional = false)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @Column(name = "password")
    private String password;
    @Basic(optional = false)
    @Column(name = "phone_number")
    private String phoneNumber;
    @Column(name = "address")
    private String address;
    @Column(name = "id_card_code")
    private String idCardCode;
    @Column(name = "commitment_status")
    private String commitmentLeterPath;
    @Column(name = "id_card_photo_path")
    private String idCardPhotoPath;
    @Basic(optional = false)
    @Column(name = "user_status")
    private String userStatus;

    public UserTable() {
    }

    public UserTable(Integer id) {
        this.id = id;
    }

    public UserTable(Integer id, String email, String password, String phoneNumber, String userStatus) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.userStatus = userStatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIdCardCode() {
        return idCardCode;
    }

    public void setIdCardCode(String idCardCode) {
        this.idCardCode = idCardCode;
    }

    public ActiveOrDeactive getCommitmentLeterPath() {
        if(commitmentLeterPath.compareTo("0")==0)
            return ActiveOrDeactive.DEACTIVE;
        else
            return ActiveOrDeactive.ACTIVE;
    }

    public void setCommitmentLeterPath(ActiveOrDeactive commitmentLeterPath) {
        this.commitmentLeterPath = Integer.toString(commitmentLeterPath.ordinal());
    }

    public String getIdCardPhotoPath() {
        return idCardPhotoPath;
    }

    public void setIdCardPhotoPath(String idCardPhotoPath) {
        this.idCardPhotoPath = idCardPhotoPath;
    }

    public ActiveOrDeactive getUserStatus() {
        if(userStatus.compareTo("0")==0)
            return ActiveOrDeactive.DEACTIVE;
        else
            return ActiveOrDeactive.ACTIVE;
    }

    public void setUserStatus(ActiveOrDeactive userStatus) {
        this.userStatus = Integer.toString(userStatus.ordinal());
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
        if (!(object instanceof UserTable)) {
            return false;
        }
        UserTable other = (UserTable) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.UserTable[ id=" + id + " ]";
    }
    
}
