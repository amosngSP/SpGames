package db;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

public class Transaction implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2567346484322353148L;
	private int trans_id;
	private int user_id;
	private Timestamp datetime;
	private ArrayList<TransactionData> Transaction_Data;

	public Transaction() {

	}

	public Transaction(int trans_id, int user_id, Timestamp datetime, ArrayList<TransactionData> Trans_Data) {
		this.trans_id = trans_id;
		this.user_id = user_id;
		this.datetime = datetime;
		this.Transaction_Data = Trans_Data;
	}

	public void SetTransID(int TransID) {
		this.trans_id = TransID;
	}

	public void SetUserID(int UserID) {
		this.user_id = UserID;
	}

	public void SetDateTime(Timestamp Datetime) {
		this.datetime = Datetime;
	}

	public void SetTransactionData(ArrayList<TransactionData> Trans_Data) {
		this.Transaction_Data = Trans_Data;
	}

	public void AddNewTransactionData(TransactionData Trans_Data) {
		if (this.Transaction_Data == null) {
			this.Transaction_Data = new ArrayList<TransactionData>();
			this.Transaction_Data.add(Trans_Data);
		} else {
			this.Transaction_Data.add(Trans_Data);
		}
	}

	public int GetTransID() {
		return this.trans_id;
	}

	public int GetUserID() {
		return this.user_id;
	}

	public Timestamp GetTimeStamp() {
		return this.datetime;
	}

	public String GetDateTime() {
		Date date = new Date(this.datetime.getTime());
		// DateFormat f = new SimpleDateFormat("dd-MM-yyyy");
		// return f.format(date);
		return date.toString();
	}

	public ArrayList<TransactionData> GetTransDataList() {
		if (this.Transaction_Data == null) {
			System.out.println("It's returning NULL!");
			return null;
		} else {
			return this.Transaction_Data;
		}
	}
}
