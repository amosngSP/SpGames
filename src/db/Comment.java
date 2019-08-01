package db;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Comment implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4020616153101942722L;
	int CommentID;

	int GameID;
	int UserID;
	String Username;
	String Comment;
	int Rating;
	Timestamp Datetime;
	int Deleted;

	public Comment() {

	}

	public Comment(int CommentID, int GameID, int UserID, String Username, String Comment, int Rating,
			Timestamp Datetime, int Deleted) {
		this.SetCommentID(CommentID);
		this.SetGameID(GameID);
		this.SetUserID(UserID);
		this.SetUsername(Username);
		this.SetComment(Comment);
		this.SetRating(Rating);
		this.SetDatetime(Datetime);
		this.SetDeleted(Deleted);
	}

	public void SetCommentID(int CommentID) {
		this.CommentID = CommentID;
	}

	public int GetCommentID() {
		return this.CommentID;
	}

	public void SetGameID(int GameID) {
		this.GameID = GameID;
	}

	public int GetGameID() {
		return this.GameID;
	}

	public void SetUserID(int UserID) {
		this.UserID = UserID;
	}

	public int GetUserID() {
		return this.UserID;
	}

	public void SetUsername(String Username) {
		this.Username = Username;
	}

	public String GetUsername() {
		return this.Username;
	}

	public void SetRating(int Rating) {
		this.Rating = Rating;
	}

	public int GetRating() {
		return this.Rating;
	}

	public void SetComment(String Comment) {
		this.Comment = Comment;
	}

	public String GetComment() {
		return this.Comment;
	}

	public void SetDatetime(Timestamp Datetime) {
		this.Datetime = Datetime;
	}

	public Timestamp GetTimeStamp() {
		return this.Datetime;
	}

	public String GetDate() {
		Date date = new Date(this.Datetime.getTime());
		DateFormat f = new SimpleDateFormat("dd-MM-yyyy");
		return f.format(date);
	}

	public void SetDeleted(int Deleted) {
		this.Deleted = Deleted;
	}

	public int GetDeleted() {
		return this.Deleted;
	}
}
