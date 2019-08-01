package db;

public class CartItem {
	int GameID;
	int Qty;

	public CartItem(int game_id, int qty) {
		SetGameID(game_id);
		SetQty(qty);
	}

	public void SetGameID(int game_id) {
		this.GameID = game_id;
	}

	public void SetQty(int qty) {
		this.Qty = qty;
	}

	public int GetGameID() {
		return this.GameID;
	}

	public int GetQty() {
		return this.Qty;
	}
}
