package db;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class comment {
	int comment_id;
	int game_id;
	String username;
	int rating;
	String review;
	Timestamp timestamp;

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

	public void set_timestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
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

	public String get_date() {
		Date date = new Date(this.timestamp.getTime());
		DateFormat f = new SimpleDateFormat("dd-MM-yyyy");
		return f.format(date);
	}
}
