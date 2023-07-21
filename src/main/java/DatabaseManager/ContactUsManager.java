package DatabaseManager;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import Model.ContactusTable;

public class ContactUsManager {

    private static final String PUN = "Auction_website";

    public static boolean insertOrUpdate(ContactusTable contactusTable) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            ContactusTable conus = (ContactusTable) entityManager.find(ContactusTable.class, Integer.valueOf(1));
            entityManager.getTransaction().begin();
            if (conus != null) {

                conus.setEmail(contactusTable.getEmail());
                conus.setAddress(contactusTable.getAddress());
                conus.setTellPhone(contactusTable.getTellPhone());
                entityManager.getTransaction().commit();
            } else {
                entityManager.persist(contactusTable);
                entityManager.getTransaction().commit();
            }
            return true;
        } catch (Exception e) {
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

    public static ContactusTable getContactUs() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            ContactusTable conus = (ContactusTable) entityManager.find(ContactusTable.class, Integer.valueOf(1));
            return conus;
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
