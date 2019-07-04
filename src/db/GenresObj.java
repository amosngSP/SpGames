package db;

public class GenresObj {
	int GenreID;
	String GenreName;
	int Deleted;

	public GenresObj() {

	}

	public GenresObj(int GenreID, String GenreName, int Deleted) {
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
