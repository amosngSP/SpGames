package db;

public interface CartDAO {
	public int GetID(Cart CartList, int GameID);

	public int GetGameQtyInCart(Cart CartList, int gameid);

	public boolean AddToCart(Cart CartList, Item Item);

	// public boolean UpdateQty(Cart CartList, Item Item);

	public boolean RemoveFromCart(Cart CartList, int GameID);
}
