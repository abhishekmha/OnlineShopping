package grp31.onlshp.dao;

import java.util.List;

import grp31.onlshp.pojo.Product;

public interface ProductDAO {

	void addProduct(Product p);

	void updateProduct(Product p);

	List<String> listProducts();
	
	List<String> listVendors(String productname);

	void removeProduct(int pid);

	boolean validateProduct(String productname, String vendor);

	int getProductId(String productname, String vendor);

	Product getProductById(int pid);

	List<String> listProductsByCategory(String category);

	String getDescription(String productname);
	
}
