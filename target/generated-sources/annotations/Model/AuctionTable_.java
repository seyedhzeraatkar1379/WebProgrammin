package Model;

import Model.AdminTable;
import Model.ArtinfoTable;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-08-19T17:51:10")
@StaticMetamodel(AuctionTable.class)
public class AuctionTable_ { 

    public static volatile SingularAttribute<AuctionTable, ArtinfoTable> artId;
    public static volatile SingularAttribute<AuctionTable, String> limitPrice;
    public static volatile SingularAttribute<AuctionTable, Date> endDate;
    public static volatile SingularAttribute<AuctionTable, AdminTable> adminId;
    public static volatile SingularAttribute<AuctionTable, Integer> id;
    public static volatile SingularAttribute<AuctionTable, Date> startDate;
    public static volatile SingularAttribute<AuctionTable, String> status;

}