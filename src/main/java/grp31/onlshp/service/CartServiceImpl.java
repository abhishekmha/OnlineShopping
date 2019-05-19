package grp31.onlshp.service;

import org.springframework.transaction.annotation.Transactional;

import grp31.onlshp.dao.CartDAO;
import grp31.onlshp.pojo.CartItem;

public class CartServiceImpl implements CartService {
	
	private CartDAO cartDAO;

	public void setCartDAO(CartDAO cartDAO) {
		this.cartDAO = cartDAO;
	}
	
	@Override
	@Transactional
	public void addToCart(int cartId, int productId, int quantity) {
		CartItem c = new CartItem();
		c.setCartId(cartId);
		c.setProductId(productId);
		c.setQuantity(quantity);
		System.out.println("item bought - "+c);
		this.cartDAO.addToCart(c);
	}
}
