package Model;

import Model.AuctionTable;
import Model.UserTable;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-08-09T22:10:22")
@StaticMetamodel(AuctionParticipantTable.class)
public class AuctionParticipantTable_ { 

    public static volatile SingularAttribute<AuctionParticipantTable, AuctionTable> auctionId;
    public static volatile SingularAttribute<AuctionParticipantTable, Date> perposedDatetime;
    public static volatile SingularAttribute<AuctionParticipantTable, Integer> id;
    public static volatile SingularAttribute<AuctionParticipantTable, String> statusCollateral;
    public static volatile SingularAttribute<AuctionParticipantTable, UserTable> userId;
    public static volatile SingularAttribute<AuctionParticipantTable, String> perposedPrice;

}