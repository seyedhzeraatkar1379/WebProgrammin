package DatabaseManager;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;
import models.AdminTable;

public class AdminManager {

    private static final String PUN = "Auction_website";

    private static boolean checkAdminExist(String username, String email) {

        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select adm from AdminTable adm WHERE adm.username=?1 or adm.email=?2");
            query.setParameter(1, username);
            query.setParameter(2, email);
            return !query.getResultList().isEmpty();
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
            if (entityManagerFactory != null) {
                entityManagerFactory.close();
            }
        }
    }

    public static boolean updatePasswordAdminByUsername(String username, String password) {
        EntityManager entityManager;
        EntityManagerFactory entityManagerFactory;
        entityManagerFactory = null;
        entityManager = null;
        EntityTransaction entityTransaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            entityTransaction = entityManager.getTransaction();
            entityTransaction.begin();
            Query query = entityManager.createQuery("select adm from AdminTable adm where adm.username=?1");
            query.setParameter(1, username);
            AdminTable adminold = (AdminTable) query.getSingleResult();
            adminold.setPassword(password);
            entityTransaction.commit();
        } catch (Exception e) {
            entityTransaction.rollback();
            return false;
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

    public static AdminTable selectAdminInfoByUsername(String Username) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select adm from AdminTable adm where adm.username=?1");
            query.setParameter(1, Username);
            AdminTable admin = (AdminTable) query.getSingleResult();
            return admin;
        } catch (Exception e) {
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

    public static AdminTable AdminLogin(String username, String password) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select adm FROM AdminTable adm WHERE adm.username = ?1 and adm.password = ?2");
            query.setParameter("1", username);
            query.setParameter("2", password);
            List<AdminTable> idres = query.getResultList();
            if (!idres.isEmpty()) {
                return (AdminTable) idres.get(0);
            }
            return null;
        } catch (Exception e) {
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
