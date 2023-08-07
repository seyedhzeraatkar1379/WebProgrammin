package Model;

import Model.AuctionTable;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-08-07T20:54:43")
@StaticMetamodel(ArtinfoTable.class)
public class ArtinfoTable_ { 

    public static volatile ListAttribute<ArtinfoTable, AuctionTable> auctionTableCollection;
    public static volatile SingularAttribute<ArtinfoTable, String> photoPath;
    public static volatile SingularAttribute<ArtinfoTable, String> name;
    public static volatile SingularAttribute<ArtinfoTable, String> description;
    public static volatile SingularAttribute<ArtinfoTable, Integer> id;

}