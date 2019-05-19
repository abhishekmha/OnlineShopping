package grp31.onlshp.model;

public class PurchaseBean {
	
	private int quantity;
	
	private String productname;
	private String vendor;
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
	@Override
	public String toString() {
		return "PurchaseBean [quantity=" + quantity + ", productname=" + productname + ", vendor=" + vendor + "]";
	}
	
}
