package DatabaseManager;

import DatabaseManager.UserManager;
import Enum.ActiveOrDeactive;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import Model.UserTable;
import javax.persistence.EntityTransaction;
import javax.transaction.Transaction;

public class UserManager {

    private static final String PUN = "Auction_website";

    private static boolean checkUserExist(String email, String phone) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr where usr.email = ?1 or usr.phoneNumber = ?2");
            query.setParameter(1, email);
            query.setParameter(2, phone);
            List<UserTable> user = query.getResultList();
            return !user.isEmpty();
        } catch (Exception e) {
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

    public static boolean registerUserlv1(String email, String password) {

        if (!checkUserExist(email, password)) {
            EntityManagerFactory entityManagerFactory = null;
            EntityManager entityManager = null;
            EntityTransaction transaction = null;
            try {
                UserTable user = new UserTable();
                entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
                entityManager = entityManagerFactory.createEntityManager();
                transaction = entityManager.getTransaction();
                transaction.begin();
                user.setEmail(email);
                user.setPassword(password);
                user.setCommitmentLeterPath(ActiveOrDeactive.ACTIVE);
                user.setUserStatus(ActiveOrDeactive.DEACTIVE);
                entityManager.persist(user);
                transaction.commit();
                return true;
            } catch (Exception e) {
                if (transaction != null) {
                    if (transaction.isActive()) {
                        transaction.rollback();
                    }
                }
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean registerUserlv2(UserTable user) {
        if (checkUserExist(user.getEmail(), user.getPhoneNumber())) {
            EntityManagerFactory entityManagerFactory = null;
            EntityManager entityManager = null;
            EntityTransaction transaction = null;
            try {
                entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
                entityManager = entityManagerFactory.createEntityManager();
                transaction = entityManager.getTransaction();
                transaction.begin();
                UserTable updUsr = (UserTable) entityManager.find(UserTable.class, user.getId());
                updUsr.setAddress(user.getAddress());
                updUsr.setCommitmentLeterPath(user.getCommitmentLeterPath());
                updUsr.setFullname(user.getFullname());
                updUsr.setIdCardCode(user.getIdCardCode());
                updUsr.setPhoneNumber(user.getPhoneNumber());
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
        return false;
    }

    public static boolean updateUser(UserTable user) {
        return registerUserlv2(user);
    }

    public static boolean changeUserStatus(int userId) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();
            UserTable user = (UserTable) entityManager.find(UserTable.class, Integer.valueOf(userId));
            System.out.println(ActiveOrDeactive.ACTIVE.ordinal());
            System.out.println(ActiveOrDeactive.DEACTIVE.ordinal());
            if (user.getUserStatus() == ActiveOrDeactive.ACTIVE) {
                user.setUserStatus(ActiveOrDeactive.DEACTIVE);
            } else {
                user.setUserStatus(ActiveOrDeactive.ACTIVE);
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

    public static List<UserTable> getAllUser() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr");
            List<UserTable> userList = query.getResultList();
            if (!userList.isEmpty()) {
                return userList;
            }
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
        return null;
    }

    public static long getNumberOfAllUser() {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select count(usr) from UserTable usr");
            long numberOfRecord = (long)query.getSingleResult(); 
            return numberOfRecord;
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

    public static List<UserTable> getAllUser(String contain) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr where usr.email LIKE ?1 or usr.fullname like ?2");
            query.setParameter(1, "%" + contain + "%");
            query.setParameter(2, "%" + contain + "%");
            List<UserTable> userList = query.getResultList();
            if (!userList.isEmpty()) {
                return userList;
            }
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
        return null;
    }

    public static UserTable getUserInfoByUsername(String username) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr WHERE usr.username=?1");
            query.setParameter(1, username);
            return (UserTable) query.getSingleResult();
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

    public static UserTable getUserInfoById(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr WHERE usr.id=?1");
            query.setParameter(1, Integer.valueOf(id));
            return (UserTable) query.getSingleResult();
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

    public static UserTable getUserInfoByIdCardCode(String idCardCode) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr WHERE usr.idCardCode=?1");
            query.setParameter(1, idCardCode);
            return (UserTable) query.getSingleResult();
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

    public static UserTable getUserInfoByPhone(String phone) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr WHERE usr.phoneNumber=?1");
            query.setParameter(1, phone);
            return (UserTable) query.getSingleResult();
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

    public static UserTable loginUser(String email, String password) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            Query query = entityManager.createQuery("select usr from UserTable usr where usr.email = ?1 and usr.password=?2");
            query.setParameter(1, email);
            query.setParameter(2, password);
            return (UserTable) query.getSingleResult();
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

    public static boolean removeUser(int id) {
        EntityManagerFactory entityManagerFactory = null;
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PUN);
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();
            UserTable user = (UserTable) entityManager.find(UserTable.class, id);
            entityManager.remove(user);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                if (transaction.isActive()) {
                    transaction.rollback();
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
}
