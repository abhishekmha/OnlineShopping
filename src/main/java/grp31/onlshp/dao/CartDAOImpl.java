package grp31.onlshp.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import grp31.onlshp.pojo.CartItem;

public class CartDAOImpl implements CartDAO {

	private static final Logger logger = LoggerFactory.getLogger(ProductDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public void addToCart(CartItem c) {
		Session session = this.sessionFactory.getCurrentSession();
		System.out.println("IN DAO - item bought - "+c);
		session.persist(c);
		logger.info("Product added to cart, Product Details="+c);	
	}
}
