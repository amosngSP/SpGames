package db;

import java.io.Serializable;

public class Genres implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5051628141229016006L;
	int GenreID;
	String GenreName;
	int Deleted;

	public Genres() {

	}

	public Genres(int GenreID, String GenreName, int Deleted) {
		this.GenreID = GenreID;
		this.GenreName = GenreName;
		this.Deleted = Deleted;
	}

	public void SetGenreID(int GenreID) {
		this.GenreID = GenreID;
	}

	public void SetDeleted(int Deleted) {
		this.Deleted = Deleted;
	}

	public void SetGenreName(String GenreName) {
		this.GenreName = GenreName;
	}

	public int GetGenreID() {
		return this.GenreID;
	}

	public int GetDeleted() {
		return this.Deleted;
	}

	public String GetGenreName() {
		return this.GenreName;
	}
}
