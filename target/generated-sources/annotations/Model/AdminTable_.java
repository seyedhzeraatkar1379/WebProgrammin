package Model;

import Model.AuctionTable;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-08-10T13:10:35")
@StaticMetamodel(AdminTable.class)
public class AdminTable_ { 

    public static volatile SingularAttribute<AdminTable, String> password;
    public static volatile CollectionAttribute<AdminTable, AuctionTable> auctionTableCollection;
    public static volatile SingularAttribute<AdminTable, String> fullName;
    public static volatile SingularAttribute<AdminTable, Integer> id;
    public static volatile SingularAttribute<AdminTable, String> email;
    public static volatile SingularAttribute<AdminTable, String> username;

}