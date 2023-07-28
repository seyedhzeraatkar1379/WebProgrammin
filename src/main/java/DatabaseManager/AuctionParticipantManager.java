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
import javax.persistence.EntityTransaction;

public class AuctionParticipantManager {

    private static final String PUN = "Auction_website";

    public static boolean insertAuctionParticipant(AuctionParticipantTable auctionParticipant, int auctionid, int userid) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();

            transaction.begin();
            UserTable user = (UserTable) entityManager.find(UserTable.class, Integer.valueOf(userid));
            AuctionTable auction = AuctionManager.getAuctionByIdActive(auctionid);
            if (user != null && auction != null) {
                auctionParticipant.setAuctionId(auction);
                auctionParticipant.setUserId(user);
                entityManager.persist(auctionParticipant);
                transaction.commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (transaction != null) {
                if (transaction.isActive()) {
                    entityManager.getTransaction().rollback();
                }
            }
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
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            AuctionParticipantTable auction = (AuctionParticipantTable) entityManager.find(AuctionParticipantTable.class, Integer.valueOf(auctionParticipentId));
            if (auction != null) {
                transaction.begin();
                entityManager.remove(auction);
                transaction.commit();
            }
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
            }
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
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select partic from AuctionParticipantTable partic where partic.auctionId.id = ?2 ORDER BY partic.perposedPrice DESC");
            query.setParameter("2", auctionid);

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
    
    public static long getNumberOfParticipant() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select count(partic) from AuctionParticipantTable partic GROUP BY partic.userId");

            long numberOfParticipants = (long)query.getSingleResult();
            return numberOfParticipants;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
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
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select user from AuctionParticipantTable aucpart inner join AUCPART.auctionId auc inner join AUCPART.userId user where aucpart.auctionId = ?1 and auc.endDate < ?2 ORDER BY AUCPART.perposedPrice DESC");
            query.setParameter(1, Integer.valueOf(auctionId));
            query.setParameter(2, currDate);
            List<UserTable> list = query.getResultList();

            return (UserTable) list.get(0);
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
}
