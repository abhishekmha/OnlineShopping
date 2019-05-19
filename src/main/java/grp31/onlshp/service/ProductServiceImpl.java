package grp31.onlshp.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import grp31.onlshp.dao.ProductDAO;
import grp31.onlshp.pojo.Product;;

@Service
public class ProductServiceImpl implements ProductService {
	
	private ProductDAO productDAO;

	public void setProductDAO(ProductDAO productDAO) {
		this.productDAO = productDAO;
	}

	@Override
	@Transactional
	public void addProduct(String productname, String vendor, String description, int quantity, String category, int price) {
		Product p = new Product();
		p.setProductname(productname);
		p.setVendor(vendor);
		p.setDescription(description);
		p.setQuantity(quantity);
		p.setCategory(category);
		p.setPrice(price);
		this.productDAO.addProduct(p);
	}

	@Override
	@Transactional
	public void updateProduct(Product p) {
		this.productDAO.updateProduct(p);
	}

	@Override
	@Transactional
	public List<String> listProducts() {
		return this.productDAO.listProducts();
	}

	@Override
	@Transactional
	public String getDescription(String productname) {
		return this.productDAO.getDescription(productname);
	}
	
	@Override
	@Transactional
	public List<String> listProductsByCategory(String category) {
		return this.productDAO.listProductsByCategory(category);
	}
	
	@Override
	@Transactional
	public List<String> listVendors(String productname) {
		return this.productDAO.listVendors(productname);
	}
	
	@Override
	@Transactional
	public void removeProduct(int pid) {
		this.productDAO.removeProduct(pid);
	}

	@Override
	@Transactional
	public boolean validateProduct(String productname, String vendor) throws SQLException {
		System.out.println("checking product details");
	    return productDAO.validateProduct(productname, vendor);	    
	}
	
	@Override
	@Transactional
	public int getProductId(String productname, String vendor) {
		return productDAO.getProductId(productname,vendor);
	}

	@Override
	@Transactional
	public Product getProductById(int pid) {
		return productDAO.getProductById(pid);
	}

	
}
