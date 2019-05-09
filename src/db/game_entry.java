package db;

import java.util.ArrayList;

public class game_entry{
	int game_id;
	String game_title;
	String company;
	String release_date;
	String description;
	String price;
	String image_location;
	ArrayList<String> genres;
	int preowned;
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
	public String get_image_location() {
		return this.image_location;
	}
	public ArrayList<String> get_genres(){
		return this.genres;
	}
	public int get_preowned() {
		return this.preowned;
	}
}