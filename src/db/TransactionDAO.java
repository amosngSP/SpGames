package db;

import java.util.ArrayList;

public interface TransactionDAO {
	public boolean UploadPurchase(Transaction TransData);

	public ArrayList<Transaction> GetPurchaseHistory(int userid);
}
