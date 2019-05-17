package db;

import java.util.ArrayList;

public class game_entry{
	int game_id;
	String game_title;
	String company;
	String release_date;
	String description;
	String price;
	ArrayList<genres> genres;
	int preowned;
	public void set_game_id(int gameID) {
		this.game_id = gameID;
	}
	public void set_game_title(String gameTitle) {
		this.game_title = gameTitle;
	}
	public void set_company(String Company) {
		this.company = Company;
	}
	public void set_release_date(String ReleaseDate) {
		this.release_date = ReleaseDate;
	}
	public void set_description(String Description) {
		this.description = Description;
	}
	public void set_price(String Price) {
		this.price = Price;
	}
	public void set_genres_list(ArrayList<genres> GenresList) {
		this.genres = GenresList;
	}
	public void set_preowned(int PreOwned) {
		this.preowned = PreOwned;
	}
	public int get_game_id() { 
		return this.game_id;
	}
	public String get_game_title() {
		return this.game_title;
	}
	public String get_company() {
		return this.company;
	}
	public String get_release_date() {
		return this.release_date;
	}
	public String get_description() {
		return this.description;
	}
	public String get_price() {
		return this.price;
	}
	public ArrayList<genres> get_genres(){
		return this.genres;
	}
	public int get_preowned() {
		return this.preowned;
	}
}