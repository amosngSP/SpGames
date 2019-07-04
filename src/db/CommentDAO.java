package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {
	SqlDAO DBSQL = new SqlDAO();
	Connection con = DBSQL.GetConnectionObj();

	public ArrayList<CommentObj> get_comments(int gameid) {
		try {
			ResultSet comments = DBSQL.SelectSQL("SELECT * from game_comments WHERE game_id = ?", gameid);
			ArrayList<CommentObj> comments_list = new ArrayList<CommentObj>();

			while (comments.next()) {
				CommentObj row = new CommentObj(Integer.parseInt(comments.getString("comment_id")),
						Integer.parseInt(comments.getString("game_id")), comments.getString("username"),
						Integer.parseInt(comments.getString("rating")), comments.getString("review"),
						comments.getTimestamp("Date"));
				comments_list.add(row);
			}
			return comments_list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean add_comment(CommentObj comment) {
		try {
			Object[] comm = { comment.GetGameID(), comment.GetUsername(), comment.GetRating(), comment.GetReview() };
			return DBSQL.InsertSQL(
					"INSERT INTO `game_comments` (`comment_id`, `game_id`, `username`, `rating`, `review`) VALUES (NULL, ?, ?, ?, ?)",
					comm);

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
