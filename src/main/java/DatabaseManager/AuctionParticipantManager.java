package DatabaseManager;

import DatabaseManager.AuctionManager;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import Model.AuctionParticipantTable;
import Model.AuctionTable;
import Model.UserTable;

public class AuctionParticipantManager {

    private static final String PUN = "Auction_website";

    public static boolean insertAuctionParticipant(AuctionParticipantTable auctionParticipant, int auctionid, int userid) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();

            entityManager.getTransaction().begin();
            UserTable user = (UserTable) entityManager.find(UserTable.class, Integer.valueOf(userid));
            AuctionTable auction = AuctionManager.getAuctionByIdActive(auctionid);
            if (user != null && auction != null) {
                auctionParticipant.setAuctionId(auction);
                auctionParticipant.setUserId(user);
                entityManager.persist(auctionParticipant);
                entityManager.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            if (entityManagerFactory != null) {
                entityManagerFactory.close();
            }
        }
    }

    public static boolean removeAuctionParticipant(int auctionParticipentId) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();

            AuctionParticipantTable auction = (AuctionParticipantTable) entityManager.find(AuctionParticipantTable.class, Integer.valueOf(auctionParticipentId));
            if (auction != null) {
                entityManager.getTransaction().begin();
                entityManager.remove(auction);
                entityManager.getTransaction().commit();
            }
            return true;
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            if (entityManagerFactory != null) {
                entityManagerFactory.close();
            }
        }
    }

    public static List<AuctionParticipantTable> getAuctionAllParticipantById(int auctionid) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select aucpart from AuctionParticipantTable aucpart where AUCPART.auctionId = ?1");
            query.setParameter(1, Integer.valueOf(auctionid));

            List<AuctionParticipantTable> list = query.getResultList();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            if (entityManagerFactory != null) {
                entityManagerFactory.close();
            }
        }
    }

    public static UserTable getWinnerAuction(int auctionId) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            Date currDate = new Date();
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select user from AuctionParticipantTable aucpart inner join AUCPART.auctionId auc inner join AUCPART.userId user where aucpart.auctionId = ?1 and auc.endDate < ?2 ORDER BY AUCPART.perposedPrice DESC");
            query.setParameter(1, Integer.valueOf(auctionId));
            query.setParameter(2, currDate);
            List<UserTable> list = query.getResultList();

            return (UserTable) list.get(0);
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            e.printStackTrace();
            return null;
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            if (entityManagerFactory != null) {
                entityManagerFactory.close();
            }
        }
    }
}
