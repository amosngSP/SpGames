package db;

import java.util.ArrayList;

public interface CommentDAO {
	public ArrayList<Comment> GetComments(int GameID);

	public boolean AddComment(Comment Comment);

	public boolean DeleteComment(int CommentID);

	public boolean UndoDeleteComment(int CommentID);

	public boolean EditComment(Comment Comment);
}
