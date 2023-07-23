package DatabaseManager;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import Model.ContactusTable;
import javax.persistence.EntityTransaction;

public class ContactUsManager {

    private static final String PUN = "Auction_website";

    public static boolean insertOrUpdate(ContactusTable contactusTable) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("Auction_website");
            entityManager = entityManagerFactory.createEntityManager();
            ContactusTable conus = (ContactusTable) entityManager.find(ContactusTable.class, Integer.valueOf(1));
            transaction.begin();
            if (conus != null) {

                conus.setEmail(contactusTable.getEmail());
                conus.setAddress(contactusTable.getAddress());
                conus.setTellPhone(contactusTable.getTellPhone());
                transaction.commit();
            } else {
                entityManager.persist(contactusTable);
                transaction.commit();
            }
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                if (transaction.isActive()) {
                    e.printStackTrace();
                }
            }
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
