package DatabaseManager;

import Enum.ActiveOrDeactive;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import Model.AdminTable;
import Model.ArtinfoTable;
import Model.AuctionTable;
import javax.persistence.EntityTransaction;

public class AuctionManager {

    private static final String PUN = "Auction_website";

    private static boolean artInAuction(int artId) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select auc from AuctionTable auc where auc.artId.id = ?1");
            query.setParameter(1, artId);
            List<AuctionTable> auction = query.getResultList();
            if (auction.size() == 0) {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            if (entityManagerFactory != null) {
                entityManagerFactory.close();
            }
        }
        return true;
    }

    public static boolean insertAuction(AuctionTable auction, int adminid, int artid) {
        if (artInAuction(artid) == true) {
            return false;
        }
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;

        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            AdminTable admin = (AdminTable) entityManager.find(AdminTable.class, Integer.valueOf(adminid));
            ArtinfoTable art = (ArtinfoTable) entityManager.find(ArtinfoTable.class, Integer.valueOf(artid));
            if (admin != null && art != null) {

                transaction.begin();
                auction.setAdminId(admin);
                auction.setArtId(art);
                entityManager.persist(auction);
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

    public static boolean updateAuction(AuctionTable auction) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;

        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();

            AuctionTable auctionup = (AuctionTable) entityManager.find(AuctionTable.class, auction.getId());
            if (auctionup != null) {
                auctionup.setArtId(auction.getArtId());
                auctionup.setAdminId(auction.getAdminId());
                auctionup.setStartDate(auction.getStartDate());
                auctionup.setEndDate(auction.getEndDate());
                auctionup.setStatus(auction.getStatus());
                transaction.commit();
            } else {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                return false;
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

    public static boolean removeAuction(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();

            AuctionTable auctionrm = (AuctionTable) entityManager.find(AuctionTable.class, Integer.valueOf(id));
            entityManager.remove(auctionrm);
            transaction.commit();
            return true;
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

    public static AuctionTable getAuctionById(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;

        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();

            AuctionTable auction = (AuctionTable) entityManager.find(AuctionTable.class, Integer.valueOf(id));
            return auction;
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

    public static List<AuctionTable> getAllAuction() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select auction from AuctionTable auction");
            List<AuctionTable> list = query.getResultList();
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

    public static AuctionTable getAuctionByIdActive(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            Date currDate = new Date();
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select auc from AuctionTable auc where auc.id = ?1 and auc.startDate <= ?2 and auc.endDate >= ?3");
            query.setParameter(1, Integer.valueOf(id));
            query.setParameter(2, currDate);
            query.setParameter(3, currDate);
            List<AuctionTable> list = query.getResultList();
            return (AuctionTable) list.get(0);
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

    public static List<AuctionTable> getAuctionActiveDoing() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            Date currDate = new Date();

            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select auc from AuctionTable auc where auc.startDate <= ?1 and auc.endDate >= ?2");
            query.setParameter(1, currDate);
            query.setParameter(2, currDate);
            List<AuctionTable> list = query.getResultList();
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

    public static List<AuctionTable> getAuctionActiveToDo() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            Date currDate = new Date();

            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select auc from AuctionTable auc where auc.startDate > ?1");
            query.setParameter(1, currDate);
            List<AuctionTable> list = query.getResultList();
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

    public static List<AuctionTable> getAuctionActiveDone() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            Date currDate = new Date();

            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select auc from AuctionTable auc where auc.endDate < ?1");
            query.setParameter(1, currDate);
            List<AuctionTable> list = query.getResultList();
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
    
    public static boolean changeAuctionStatus(int auctionId)
    {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();
            AuctionTable auction = (AuctionTable) entityManager.find(AuctionTable.class,auctionId);
            if (auction.getStatus() == ActiveOrDeactive.ACTIVE) {
                auction.setStatus(ActiveOrDeactive.DEACTIVE);
            } else {
                auction.setStatus(ActiveOrDeactive.ACTIVE);
            }
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
            }
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            if (entityManagerFactory != null) {
                entityManagerFactory.close();
            }
        }
        return false;
    }
}
