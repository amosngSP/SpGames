package db;

public interface GameImageDAO {
	public boolean AddGameImage(GameImage GameImageObj);

	public boolean UpdateGameImage(GameImage GameImageObj);

	public boolean RemoveGameImage(GameImage GameImageObj);

	public java.sql.Blob GetGameImage(int GameID);
}
