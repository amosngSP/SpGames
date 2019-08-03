package db;

import java.io.Serializable;
import java.util.ArrayList;

public class Game implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5593297814992750731L;
	private int GameID;
	private int PreOwned;
	private String GameTitle;
	private String Company;
	private String ReleaseDate;
	private String Description;
	private String Price;
	private ArrayList<Genres> Genres;
	private int Quantity;
	private int Deleted;

	public Game() {

	}

	public Game(int GameID, int PreOwned, String GameTitle, String Company, String ReleaseDate, String Description,
			String Price, ArrayList<Genres> GenresList, int Quantity, int Deleted) {
		this.GameID = GameID;
		this.PreOwned = PreOwned;
		this.GameTitle = GameTitle;
		this.Company = Company;
		this.ReleaseDate = ReleaseDate;
		this.Description = Description;
		this.Price = Price;
		this.Genres = GenresList;
		this.Quantity = Quantity;
		this.Deleted = Deleted;
	}

	public Game(int GameID, int PreOwned, String GameTitle, String Company, String ReleaseDate, String Description,
			String Price, int Quantity, int Deleted) {
		this.GameID = GameID;
		this.Deleted = Deleted;
		this.GameTitle = GameTitle;
		this.Company = Company;
		this.ReleaseDate = ReleaseDate;
		this.Description = Description;
		this.Price = Price;
		this.PreOwned = PreOwned;
		this.Quantity = Quantity;
	}

	public Game(int GameID, int PreOwned, String GameTitle, String Company, String ReleaseDate, String Description,
			String Price, int Quantity) {
		this.GameID = GameID;
		this.GameTitle = GameTitle;
		this.Company = Company;
		this.ReleaseDate = ReleaseDate;
		this.Description = Description;
		this.Price = Price;
		this.PreOwned = PreOwned;
		this.Quantity = Quantity;
	}

	public void SetGameID(int GameID) {
		this.GameID = GameID;
	}

	public void SetDeletedStatus(int Deleted) {
		this.Deleted = Deleted;
	}

	public void SetGameTitle(String GameTitle) {
		this.GameTitle = GameTitle;
	}

	public void SetCompany(String Company) {
		this.Company = Company;
	}

	public void SetReleaseDate(String ReleaseDate) {
		this.ReleaseDate = ReleaseDate;
	}

	public void SetDescription(String Description) {
		this.Description = Description;
	}

	public void SetPrice(String Price) {
		this.Price = Price;
	}

	public void SetGenresList(ArrayList<Genres> GenresList) {
		this.Genres = GenresList;
	}

	public void SetPreOwned(int PreOwned) {
		this.PreOwned = PreOwned;
	}

	public void SetQty(int Qty) {
		this.Quantity = Qty;
	}

	public int GetQty() {
		return this.Quantity;
	}

	public int GetGameID() {
		return this.GameID;
	}

	public int GetDeleted() {
		return this.Deleted;
	}

	public String GetGameTitle() {
		return this.GameTitle;
	}

	public String GetCompany() {
		return this.Company;
	}

	public String GetReleaseDate() {
		return this.ReleaseDate;
	}

	public String GetDescription() {
		return this.Description;
	}

	public String GetPrice() {
		return this.Price;
	}

	public ArrayList<Genres> GetGenres() {
		return this.Genres;
	}

	public int GetPreOwned() {
		return this.PreOwned;
	}
}