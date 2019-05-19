package grp31.onlshp.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import grp31.onlshp.pojo.Product;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public void addProduct(Product p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(p);
		logger.info("Product saved successfully, Product Details="+p);	
	}

	@Override
	public void updateProduct(Product p) {
		Session session = this.sessionFactory.getCurrentSession();
		try {
			int pid = getProductId(p.getProductname(),p.getVendor());
			p.setPid(pid);
			session.update(p);
			logger.info("Product updated successfully, new Product Details="+p);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	@Override
	public List<String> listProducts() {
		String jpql = "SELECT DISTINCT p.productname FROM Product p";
		List<String> productList = sessionFactory.getCurrentSession().createQuery(jpql, String.class).getResultList();
		for(String p : productList){
			logger.info("Product List : "+p);
		}
		return productList;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<String> listProductsByCategory(String category) {
		Session session = this.sessionFactory.getCurrentSession();
//		Configuration config = new Configuration();
//		config.addAnnotatedClass(String.class);
		List<String> productList = null;
		try {
			String jpql = "SELECT DISTINCT p.productname FROM Product p WHERE p.category=:cat";
			Query<?> query=session.createQuery(jpql);
			query.setParameter("cat", category);
	//		System.out.println(productname);
			productList = (List<String>) query.getResultList();
		}
		catch(NoResultException e) {
			logger.info("No such products found");
			System.out.println("No such products found");
			return null;
		}
		for(String p : productList){
			logger.info("Product List : "+p);
		}
		return productList;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<String> listVendors(String productname) {
		Session session = this.sessionFactory.getCurrentSession();
//		Configuration config = new Configuration();
//		config.addAnnotatedClass(String.class);
		List<String> productList = null;
		try {
			String jpql = "SELECT p.vendor FROM Product p WHERE p.productname=:pname";
			Query<?> query=session.createQuery(jpql);
			query.setParameter("pname", productname);
	//		System.out.println(productname);
			productList = (List<String>) query.getResultList();
		}
		catch(NoResultException e) {
			logger.info("No such products found");
			System.out.println("No such products found");
			return null;
		}
		for(String p : productList){
			logger.info("Vendor List : "+p);
		}
		return productList;
	}

	@Override
	public void removeProduct(int pid) {
		Session session = this.sessionFactory.getCurrentSession();
		try {
		Product p = getProductById(pid);
			if(null != p){
				session.delete(p);
			}
			logger.info("Product deleted successfully, product details="+p);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Product getProductById(int pid) {
		Session session = sessionFactory.getCurrentSession();
		Configuration config = new Configuration();
		config.addAnnotatedClass(Product.class);
		Product p = null;
		try {
			String jpql = "SELECT p FROM Product p WHERE p.pid = :id";
			Query<?> query=session.createQuery(jpql);
			query.setParameter("id", pid);
//			System.out.println(productname+" "+vendor);
			p=(Product)query.getSingleResult();
			}
		catch(NoResultException e) {
			System.out.println("No such products found");
			//throw new SQLException("Product does not exist")
			return null;
		}
		catch(NonUniqueResultException e) {
			System.out.println("DB error, dupicate products found");
			return null;
		}
		logger.info("Product loaded successfully, Product details="+p);
		return p;
	}
	
	@Override
	public String getDescription(String productname) {
		Session session = sessionFactory.getCurrentSession();
//		Configuration config = new Configuration();
//		config.addAnnotatedClass(Product.class);
		String desc = null;
		try {
			String jpql = "SELECT p.description FROM Product p WHERE p.productname = :pname";
			Query<?> query=session.createQuery(jpql);
			query.setParameter("pname", productname);
			desc=(String)query.getSingleResult();
			logger.info("Product loaded successfully, Description = "+desc);
			}
		catch(NoResultException e) {
			System.out.println("No such products found");
			//throw new SQLException("Product does not exist")
			return null;
		}
		return desc;
	}


	@Override
	public boolean validateProduct(String productname, String vendor) {
		int check=getProductId(productname,vendor);
		if(check==-5) {
			return true;
		}
		else {
			return false;
		}
	}

	@Override
	public int getProductId(String productname, String vendor) {
		Session session = sessionFactory.getCurrentSession();
		Configuration config = new Configuration();
		config.addAnnotatedClass(Product.class);
		Product p = null;
		try {
			String jpql = "SELECT p FROM Product p WHERE p.productname = :name AND p.vendor = :ven";
			Query<?> query=session.createQuery(jpql);
			query.setParameter("name", productname);
			query.setParameter("ven", vendor);
//			System.out.println(productname+" "+vendor);
			p=(Product)query.getSingleResult();
			}
		catch(NoResultException e) {
			System.out.println("No such Products found");
			//throw new SQLException("User product not exist")
			return -5;
		}
		catch(NonUniqueResultException e) {
			System.out.println("DB error, dupicate products found");
			return -1;
		}
		logger.info("Product loaded successfully, Product details="+p);
		return p.getPid();
	}
}
