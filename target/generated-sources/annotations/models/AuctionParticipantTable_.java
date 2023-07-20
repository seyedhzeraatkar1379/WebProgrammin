package models;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.AuctionTable;
import models.UserTable;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-07-20T09:48:16")
@StaticMetamodel(AuctionParticipantTable.class)
public class AuctionParticipantTable_ { 

    public static volatile SingularAttribute<AuctionParticipantTable, AuctionTable> auctionId;
    public static volatile SingularAttribute<AuctionParticipantTable, Date> perposedDatetime;
    public static volatile SingularAttribute<AuctionParticipantTable, Integer> id;
    public static volatile SingularAttribute<AuctionParticipantTable, Character> statusCollateral;
    public static volatile SingularAttribute<AuctionParticipantTable, UserTable> userId;
    public static volatile SingularAttribute<AuctionParticipantTable, String> perposedPrice;

}