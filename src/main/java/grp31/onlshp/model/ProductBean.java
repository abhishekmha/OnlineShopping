package grp31.onlshp.model;

public class ProductBean {

	private int quantity;
	private int price;
	
	private String productname;
	private String description;
	private String category;
	
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	@Override
	public String toString() {
		return "ProductBean [quantity=" + quantity + ", price=" + price + ", productname=" + productname
				+ ", description=" + description + ", category=" + category + "]";
	}
	
}
