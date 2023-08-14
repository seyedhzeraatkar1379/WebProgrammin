package DatabaseManager;

import DatabaseManager.AuctionManager;
import Enum.ActiveOrDeactive;
import Enum.ParticipateStatus;
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

    private static int getParticId(int userId, int auctionId) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select PARTIC.id from AuctionParticipantTable partic where partic.auctionId.id=?1 and partic.userId.id=?2");
            query.setParameter("1", auctionId);
            query.setParameter("2", userId);
            List<Integer> AucPartc = query.getResultList();            
            if (AucPartc.size() > 0) {
                return AucPartc.get(0);
            } else {
                return 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static ParticipateStatus insertOrUpdateAuctionParticipant(AuctionParticipantTable auctionParticipant, int auctionid, int userid) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            Date date = new Date();
            UserTable user = (UserTable) entityManager.find(UserTable.class, Integer.valueOf(userid));
            AuctionTable auction = AuctionManager.getAuctionTodoByIdActive(auctionid);
            if (user != null && auction != null) {
                if (user.getUserStatus() != ActiveOrDeactive.ACTIVE) {
                    return ParticipateStatus.USER_DEACTIVE;
                }
                if (auction.getStatus() != ActiveOrDeactive.ACTIVE) {
                    return ParticipateStatus.AUCTION_DEACTIVE;
                }
                int aucParticId = (int)getParticId(userid, auctionid);
                switch (aucParticId) {
                    case -1:
                        return ParticipateStatus.ERROR;
                    case 0:
                        if(Double.parseDouble(auction.getLimitPrice()) > Double.parseDouble(auctionParticipant.getPerposedPrice()))
                            return ParticipateStatus.PRICE_NOTCORRECT;
                        transaction.begin();
                        auctionParticipant.setAuctionId(auction);
                        auctionParticipant.setUserId(user);
                        auctionParticipant.setPerposedDatetime(date);
                        entityManager.persist(auctionParticipant);
                        transaction.commit();
                        return ParticipateStatus.SUCCESS_INSERT;
                    default:
                        transaction.begin();
                        AuctionParticipantTable aucpartic = entityManager.find(AuctionParticipantTable.class,aucParticId);
                        if(Double.parseDouble(aucpartic.getPerposedPrice())<Double.parseDouble(auctionParticipant.getPerposedPrice()))
                        {
                            aucpartic.setPerposedDatetime(date);
                            aucpartic.setPerposedPrice(auctionParticipant.getPerposedPrice());
                            transaction.commit();
                            return ParticipateStatus.SUCCESS_UPDATE;
                        }
                        else
                        {
                            transaction.rollback();
                            return ParticipateStatus.PRICE_NOTCORRECT;
                        }
                }
            }
            return ParticipateStatus.ERROR;
        } catch (Exception e) {
            if (transaction != null) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
            }
            e.printStackTrace();
            return ParticipateStatus.ERROR;
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

            long numberOfParticipants = (long) query.getSingleResult();
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
