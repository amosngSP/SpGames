package db;

public class comment {
	int comment_id;
	int game_id;
	String username;
	int rating;
	String review;
	public void set_comment_id(int id) {
		this.comment_id = id;
	}
	public void set_game_id(int id) {
		this.game_id = id;
	}
	public void set_username(String username) {
		this.username = username;
	}
	public void set_rating(int rating) {
		this.rating = rating;
	}
	public void set_review(String review) {
		this.review = review;
	}
	public int get_comment_id() {
		return this.comment_id;
	}
	public int get_game_id() {
		return this.game_id;
	}
	public String get_username() {
		return this.username;
	}
	public int get_rating() {
		return this.rating;
	}
	public String get_review() {
		return this.review;
	}
}
