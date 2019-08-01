package db;

import java.util.List;

public class Cart {

	private List<CartItem> cartItemList;

	public void SetCartList(List<CartItem> CartList) {
		this.cartItemList = CartList;
	}

	public List<CartItem> GetCartList() {
		return this.cartItemList;
	}
}
