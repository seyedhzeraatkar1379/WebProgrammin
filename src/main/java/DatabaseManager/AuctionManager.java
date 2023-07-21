package DatabaseManager;

import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import Model.AdminTable;
import Model.ArtinfoTable;
import Model.AuctionTable;

public class AuctionManager {

    private static final String PUN = "Auction_website";

    public static boolean insertAuction(AuctionTable auction, int adminid, int artid) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            AdminTable admin = (AdminTable) entityManager.find(AdminTable.class, Integer.valueOf(adminid));
            ArtinfoTable art = (ArtinfoTable) entityManager.find(ArtinfoTable.class, Integer.valueOf(artid));
            if (admin != null && art != null) {
                entityManager.getTransaction().begin();
                auction.setAdminId(admin);
                auction.setArtId(art);
                entityManager.persist(auction);
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

    public static boolean updateAuction(AuctionTable auction) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            entityManager.getTransaction().begin();

            AuctionTable auctionup = (AuctionTable) entityManager.find(AuctionTable.class, auction.getId());
            if (auctionup != null) {
                auctionup.setArtId(auction.getArtId());
                auctionup.setAdminId(auction.getAdminId());
                auctionup.setStartDate(auction.getStartDate());
                auctionup.setEndDate(auction.getEndDate());
                auctionup.setStatus(auction.getStatus());
                entityManager.getTransaction().commit();
            } else {
                entityManager.getTransaction().rollback();
                return false;
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

    public static boolean removeAuction(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            entityManager.getTransaction().begin();

            AuctionTable auctionrm = (AuctionTable) entityManager.find(AuctionTable.class, Integer.valueOf(id));
            entityManager.remove(auctionrm);
            entityManager.getTransaction().commit();
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

    public static AuctionTable getAuctionById(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            entityManager.getTransaction().begin();

            AuctionTable auction = (AuctionTable) entityManager.find(AuctionTable.class, Integer.valueOf(id));

            return auction;
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

    public static List<AuctionTable> getAllAuction() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
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
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            entityManager.getTransaction().begin();
            Query query = entityManager.createQuery("select auc from AuctionTable auc where auc.id = ?1 and auc.startDate <= ?2 and auc.endDate >= ?3");
            query.setParameter(1, Integer.valueOf(id));
            query.setParameter(2, currDate);
            query.setParameter(3, currDate);
            List<AuctionTable> list = query.getResultList();
            return (AuctionTable) list.get(0);
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

    public static List<AuctionTable> getAuctionActiveDoing() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            Date currDate = new Date();

            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
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

            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
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

            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
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
}
