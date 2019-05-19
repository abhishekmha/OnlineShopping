package grp31.onlshp.pojo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Products")
public class Product implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="pid")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int pid;

	@Column(name="quantity")
	private int quantity;
	
	@Column(name="price")
	private int price;

	@Column(name="productname")
	private String productname;

	@Column(name="vendor")
	private String vendor;

	@Column(name="category")
	private String category;
	
	@Column(name="description")	
	private String description;

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "Product [pid=" + pid + ", quantity=" + quantity + ", price=" + price + ", productname=" + productname
				+ ", vendor=" + vendor + ", category=" + category + ", description=" + description + "]";
	}

}
