package db;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CommentObj {
	int CommentID;
	int GameID;
	String Username;
	int Rating;
	String Review;
	Timestamp TimeStamp;

	public CommentObj(int CommentID, int GameID, String Username, int Rating, String Review, Timestamp TimeStamp) {
		this.CommentID = CommentID;
		this.GameID = GameID;
		this.Username = Username;
		this.Rating = Rating;
		this.Review = Review;
		this.TimeStamp = TimeStamp;
	}

	public void SetCommentID(int CommentID) {
		this.CommentID = CommentID;
	}

	public void SetGameID(int GameID) {
		this.GameID = GameID;
	}

	public void SetUsername(String Username) {
		this.Username = Username;
	}

	public void SetRating(int Rating) {
		this.Rating = Rating;
	}

	public void SetReview(String Review) {
		this.Review = Review;
	}

	public void SetTimestamp(Timestamp TimeStamp) {
		this.TimeStamp = TimeStamp;
	}

	public int GetCommentID() {
		return this.CommentID;
	}

	public int GetGameID() {
		return this.GameID;
	}

	public String GetUsername() {
		return this.Username;
	}

	public int GetRating() {
		return this.Rating;
	}

	public String GetReview() {
		return this.Review;
	}

	public String GetDate() {
		Date date = new Date(this.TimeStamp.getTime());
		DateFormat f = new SimpleDateFormat("dd-MM-yyyy");
		return f.format(date);
	}
}
