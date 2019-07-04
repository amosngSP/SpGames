package db;

import java.util.ArrayList;

public class GameEntryObj {
	int GameID;
	String GameTitle;
	String Company;
	String ReleaseDate;
	String Description;
	String Price;
	ArrayList<GenresObj> Genres;
	int PreOwned;
	int Deleted;

	public GameEntryObj(int GameID, String GameTitle, String Company, String ReleaseDate, String Description,
			String Price, ArrayList<GenresObj> GenresList, int PreOwned, int Deleted) {
		this.GameID = GameID;
		this.Deleted = Deleted;
		this.GameTitle = GameTitle;
		this.Company = Company;
		this.ReleaseDate = ReleaseDate;
		this.Description = Description;
		this.Price = Price;
		this.Genres = GenresList;
		this.PreOwned = PreOwned;
	}

	public GameEntryObj(int GameID, String GameTitle, String Company, String ReleaseDate, String Description,
			String Price, int PreOwned, int Deleted) {
		this.GameID = GameID;
		this.Deleted = Deleted;
		this.GameTitle = GameTitle;
		this.Company = Company;
		this.ReleaseDate = ReleaseDate;
		this.Description = Description;
		this.Price = Price;
		this.PreOwned = PreOwned;
	}

	public GameEntryObj() {

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

	public void SetGenresList(ArrayList<GenresObj> GenresList) {
		this.Genres = GenresList;
	}

	public void SetPreOwned(int PreOwned) {
		this.PreOwned = PreOwned;
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

	public ArrayList<GenresObj> GetGenres() {
		return this.Genres;
	}

	public int GetPreOwned() {
		return this.PreOwned;
	}
}