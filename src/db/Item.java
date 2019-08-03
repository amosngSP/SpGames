package db;

import java.io.Serializable;

public class Item implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4155365883366532613L;
	private int GameID;
	private int Qty;

	public Item(int game_id, int qty) {
		SetGameID(game_id);
		SetQty(qty);
	}

	public void SetGameID(int game_id) {
		this.GameID = game_id;
	}

	public void SetQty(int qty) {
		this.Qty = qty;
	}

	public void AppendQty(int qty) {
		this.Qty += qty;
	}

	public int GetGameID() {
		return this.GameID;
	}

	public int GetQty() {
		return this.Qty;
	}
}
