<%@ page import ="db.*" %>
<%@ page import ="java.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="javax.imageio.*" %>
<%@ page import ="java.io.ByteArrayInputStream" %>
<%@ page import ="java.net.*" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
try {
if (request.getParameter("game_id") != null){
	java.sql.Blob imageblob;
	byte imagebytes[];
	try {
		Spgames dbcon = new Spgames();
		dbcon.setValues();
		imageblob = dbcon.get_image(Integer.parseInt(request.getParameter("game_id")));
		imagebytes = imageblob.getBytes(1, (int)imageblob.length());
		response.getOutputStream().write(imagebytes);
		ByteArrayInputStream bais = new ByteArrayInputStream(imagebytes);
		String mimeType = URLConnection.guessContentTypeFromStream(bais);
		if (mimeType.startsWith("image/"))
		{

		    response.setContentType(mimeType);
		}
	} catch (Exception e){
		e.printStackTrace();
	} 
	
	
} else {
	response.sendError(404);
} } catch (Exception e){
	e.printStackTrace();
}
%>