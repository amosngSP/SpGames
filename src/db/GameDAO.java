package db;

import java.io.InputStream;
import java.util.ArrayList;

public interface GameDAO {
	public void CloseConn();

	public boolean CreateGame(Game Game, InputStream Image);

	public boolean UpdateGame(Game GameRow, InputStream Image);

	public boolean UpdateGame(Game GameRow);

	public boolean DeleteGame(int GameID);

	public Game GetGameInfo(int gameid);

	public boolean UndoDeleteGame(int GameID);

	public ArrayList<Game> GetGamesList(int Del);

	public ArrayList<Game> GetPreownedGamesList(int PreOwned);

}
