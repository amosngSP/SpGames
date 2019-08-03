package db;

public class CartDAOImpl implements CartDAO {
	public CartDAOImpl() {

	}

	public int GetID(Cart CartList, int GameID) {
		int i = 0;
		boolean found = false;
		while (i < CartList.GetSize()) {
			Item temp = CartList.GetRow(i);
			if (temp.GetGameID() == GameID) {
				// can find entry
				found = true;
				break;
			} else {
				// cannot find entry
				// continue looping
				i++;
			}
		}
		if (found) {
			// able to find the entry
			return i;
		} else {
			// cannot find entry
			return -1;
		}
	}

	public int GetGameQtyInCart(Cart CartList, int gameid) {
		if (CartList == null) {
			return 0;
		} else {
			int rowid = GetID(CartList, gameid);
			if (rowid == -1) {
				return 0;
			} else {
				return CartList.GetRow(rowid).GetQty();
			}
		}
	}

	public boolean AddToCart(Cart CartList, Item Item) {
		// Check if Entry already exists
		int rowid = GetID(CartList, Item.GetGameID());
		if (rowid != -1) {
			// Entry can be found
			CartList.GetRow(rowid).SetQty(Item.GetQty());
			return true;
		} else {
			// Cannot find entry
			// Add it in
			CartList.AddNewItem(Item);
			return true;
		}
	}

	/*
	 * public boolean UpdateQty(Cart CartList, Item Item) { // Check if Entry
	 * already exists int rowid = GetID(CartList, Item.GetGameID()); if (rowid !=
	 * -1) { // Entry can be found CartList.GetRow(rowid).SetQty(Item.GetQty());
	 * return true; } else { // Cannot find entry return false; } }
	 */

	public boolean RemoveFromCart(Cart CartList, int GameID) {
		int rowid = GetID(CartList, GameID);
		if (rowid != -1) {
			// Entry can be found
			CartList.RemoveRow(rowid);
			return true;
		} else {
			// Cannot find entry
			return false;
		}
	}
}
