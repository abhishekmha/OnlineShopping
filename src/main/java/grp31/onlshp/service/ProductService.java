package grp31.onlshp.service;

import java.sql.SQLException;
import java.util.List;

import grp31.onlshp.pojo.Product;

public interface ProductService {

	void removeProduct(int pid);

	List<String> listProducts();

	List<String> listVendors(String productname);
	
	void updateProduct(Product p);

	void addProduct(String productname, String vendor, String description, int quantity, String category, int price);

	int getProductId(String productname, String vendor);

	boolean validateProduct(String productname, String vendor) throws SQLException;

	Product getProductById(int pid);

	List<String> listProductsByCategory(String category);

	String getDescription(String productname);
}
