package db;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;

public class Cart implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8453061430763050226L;
	private ArrayList<Item> cartItemList;

	public Cart() {
		this.cartItemList = new ArrayList<Item>();
	}

	public Cart(Cart CartItems) {
		if (CartItems == null) {
			this.cartItemList = new ArrayList<Item>();
		} else {
			this.cartItemList = CartItems.GetCartList();
		}
	}

	public void SetCartList(ArrayList<Item> CartList) {
		this.cartItemList = CartList;
	}

	public ArrayList<Item> GetCartList() {
		return this.cartItemList;
	}

	public void AddNewItem(Item Item) {
		this.cartItemList.add(Item);
	}

	public int GetSize() {
		if (this.cartItemList == null) {
			return 0;
		} else {
			return this.cartItemList.size();
		}

	}

	public Iterator<Item> GetIterator() {
		return this.cartItemList.iterator();
	}

	public Item GetRow(int index) {
		return this.cartItemList.get(index);
	}

	public void RemoveRow(int index) {
		this.cartItemList.remove(index);
	}
}
