package grp31.onlshp.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import grp31.onlshp.pojo.User;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

@Repository
public class UserDAOImpl implements UserDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(UserDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		sessionFactory = sf;
	}

	@Override
	public void addUser(User u) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(u);
		logger.info("User saved successfully, User Details="+u);
	}

	@Override
	public void updateUser(User u) {
		Session session = sessionFactory.getCurrentSession();
//		User old = getUserByEmail(u.getEmail());
//		u.setId(old.getId());
		session.update(u);
		logger.info("User updated successfully, new User Details="+u);
	}

	@Override
	public List<User> listUsers() {
		 String jpql = "SELECT u FROM User u";
		 List<User> userList = this.sessionFactory.getCurrentSession().createQuery(jpql, User.class).getResultList();
		for(User p : userList){
			logger.info("User List : "+p);
		}
		return userList;
	}

	@Override
	public User getUserByEmail(String email) {
		Session session = this.sessionFactory.getCurrentSession();
		Configuration config = new Configuration();
		config.addAnnotatedClass(User.class);
		User u = null;
		try {
			String jpql = "SELECT u FROM User u WHERE u.email=:mail";
			Query<?> query=session.createQuery(jpql);
			query.setParameter("mail", email);
			System.out.println(email);
			u=(User)query.getSingleResult();
			}
		catch(NoResultException e) {
			logger.info("No such users found");
			System.out.println("No such users found");
			return null;
		}
		catch(NonUniqueResultException e) {
			logger.info("DB error, duplicate users found");
			System.out.println("DB error, duplicate users found");
			return null;
		}
		logger.info("Person loaded successfully, Person details="+u);
		return u;
	}

	@Override
	public void removeUser(String email) {
		Session session = this.sessionFactory.getCurrentSession();
		User u = getUserByEmail(email);
		if(null != u){
			session.delete(u);
			}
		logger.info("Person deleted successfully, person details="+u);
	}

	@Override
	public byte validateLogin(String email, String password) {
		User u = getUserByEmail(email);
		if (u != null) {
			if ((u.getPassword()).equals(password)) {
				Session session = this.sessionFactory.getCurrentSession();
				session.setProperty("loggedInUser", u);
				return 5;
			}
			else {
				return 1;
			}
		}
		return 0;
	}

	@Override
	public boolean validateRegister(String email) {
		User u = getUserByEmail(email);
		if (u != null) {
				return false;
		}
		return true;
	}

	@Override
	public User getLoggedInUser(int id) {
		User u = null;
		Session session = this.sessionFactory.getCurrentSession();
		u = (User) session.load(User.class, new Integer(id));
		logger.info("Current User details="+u);
		return u;
	}

	@Override
	public int getUserId(String email) {
		User u = getUserByEmail(email);
		return u.getId();
	}
}
