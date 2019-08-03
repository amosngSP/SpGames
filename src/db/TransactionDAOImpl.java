package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;

public class TransactionDAOImpl implements TransactionDAO {
	private SqlDAO DBSQL;
	private Connection con;

	public TransactionDAOImpl(SqlDAO DB) {
		DBSQL = DB;
		con = DBSQL.GetConnectionObj();
	}

	public TransactionDAOImpl() {
		DBSQL = new SqlDAOImpl();
		con = DBSQL.GetConnectionObj();
	}

	public boolean UploadPurchase(Transaction TransData) {
		int NextTransID = DBSQL.GetA_INumber("transaction");
		TransData.SetTransID(NextTransID);
		GameDAO Game_DAO = new GameDAOImpl();
		String SQL_1 = "INSERT INTO `transaction` (`id`, `userid`, `datetime`) VALUES (NULL, ?, CURRENT_TIMESTAMP)";
		if (DBSQL.InsertSQL(SQL_1, TransData.GetUserID())) {
			Iterator<TransactionData> temp = TransData.GetTransDataList().iterator();
			while (temp.hasNext()) {
				TransactionData CartItemData = temp.next();
				int gameid = CartItemData.GetGameID();
				int preowned = CartItemData.GetPreOwned();
				int qty = CartItemData.GetQty();
				String costprice = CartItemData.GetCostPrice();
				String SQL_2 = "INSERT INTO `transactiondata` (`transactionid`, `gameid`, `preowned`, `quantity`, `costprice`) VALUES (?, ?, ?, ?, ?)";
				Object[] tempobj = { NextTransID, gameid, preowned, qty, costprice };
				if (DBSQL.InsertSQL(SQL_2, tempobj)) {
					System.out.println("Successful insert of game purchase data");
					if (Game_DAO.DeductQty(gameid, qty)) {
						System.out.println("Successfully deduct the quantity out.");
					} else {
						System.out.println("Unable to deduct the quantity out!");
						return false;
					}
				} else {
					System.out.println("Failed insert of game purchase data");
					return false;
				}
			}
			return true;
		} else {
			System.out.println("Failed to generate trans id");
			return false;
		}
	}

	public ArrayList<Transaction> GetPurchaseHistory(int userid) {
		try {
			String SQL_1 = "SELECT * FROM transaction WHERE userid = ?";
			ResultSet rs1 = DBSQL.SelectSQL(SQL_1, userid);
			ArrayList<Transaction> user_history = new ArrayList<Transaction>();
			while (rs1.next()) {
				Transaction temp = new Transaction();
				int trans_id = rs1.getInt("id");
				Timestamp datetime = rs1.getTimestamp("datetime");
				temp.SetTransID(trans_id);
				temp.SetDateTime(datetime);
				String SQL_2 = "SELECT * FROM transactiondata WHERE transactionid = ?";
				ResultSet rs2 = DBSQL.SelectSQL(SQL_2, trans_id);
				while (rs2.next()) {
					int gameid = rs2.getInt("gameid");
					int preowned = rs2.getInt("preowned");
					int qty = rs2.getInt("quantity");
					String costprice = rs2.getString("costprice");
					TransactionData Temp_TransData = new TransactionData();
					Temp_TransData.SetGameID(gameid);
					Temp_TransData.SetPreOwned(preowned);
					Temp_TransData.SetQty(qty);
					Temp_TransData.SetCostPrice(costprice);
					temp.AddNewTransactionData(Temp_TransData);
				}
				user_history.add(temp);
			}
			if (user_history.isEmpty()) {
				return null;
			} else {
				return user_history;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
