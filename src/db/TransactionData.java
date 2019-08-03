package db;

import java.io.Serializable;

public class TransactionData implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2404340113387815764L;
	private int gameid;
	private int preowned;
	private int qty;
	private String costprice;

	public TransactionData() {

	}

	public TransactionData(int gameid, int preowned, int qty, String costprice) {
		this.gameid = gameid;
		this.preowned = preowned;
		this.qty = qty;
		this.costprice = costprice;
	}

	public void SetGameID(int gameid) {
		this.gameid = gameid;
	}

	public void SetPreOwned(int preowned) {
		this.preowned = preowned;
	}

	public void SetQty(int qty) {
		this.qty = qty;
	}

	public void SetCostPrice(String costprice) {
		this.costprice = costprice;
	}

	public int GetGameID() {
		return this.gameid;
	}

	public int GetPreOwned() {
		return this.preowned;
	}

	public int GetQty() {
		return this.qty;
	}

	public String GetCostPrice() {
		return this.costprice;
	}
}
