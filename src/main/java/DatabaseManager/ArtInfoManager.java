package DatabaseManager;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import Model.ArtinfoTable;
import javax.persistence.EntityTransaction;

public class ArtInfoManager {

    private static final String PUN = "Auction_website";

    public static boolean insertArt(ArtinfoTable art) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();

            entityManager.persist(art);

            transaction.commit();
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

    public static boolean updateArt(ArtinfoTable art) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;

        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();

            ArtinfoTable artfind = (ArtinfoTable) entityManager.find(ArtinfoTable.class, art.getId());
            if (artfind != null) {
                artfind.setName(art.getName());
                artfind.setDescription(art.getDescription());
                artfind.setPhotoPath(art.getPhotoPath());
                artfind.setAuctionTableList(art.getAuctionTableList());
                transaction.commit();
                return true;
            }
            return false;
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

    public static boolean removeArtById(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();

            ArtinfoTable artfind = (ArtinfoTable) entityManager.find(ArtinfoTable.class, id);
            entityManager.remove(artfind);

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

    public static List<ArtinfoTable> getAllArt() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select arts from ArtinfoTable arts");
            List<ArtinfoTable> arts = query.getResultList();

            return arts;
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

    public static List<ArtinfoTable> getAllArt(String search) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();

            Query query = entityManager.createQuery("select arts from ArtinfoTable arts where arts.name like ?1 or arts.description like ?2");
            query.setParameter(1,"%"+search+"%");
            query.setParameter(2,"%"+search+"%");
            List<ArtinfoTable> arts = query.getResultList();

            return arts;
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

    public static ArtinfoTable getArtInfo(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();

            ArtinfoTable artfind = (ArtinfoTable) entityManager.find(ArtinfoTable.class, Integer.valueOf(id));

            return artfind;
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

    public static List<ArtinfoTable> getArtDosntInAuction()
    {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select arts from ArtinfoTable arts where arts.id NOT IN (SELECT artuse.artId.id from AuctionTable artuse)");
            List<ArtinfoTable> arts = query.getResultList();
            return arts;
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
