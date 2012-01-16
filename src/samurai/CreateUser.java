package samurai;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class CreateUser extends HttpServlet {
	private static final Logger log = Logger.getLogger(CreateUser.class.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		String id = req.getParameter("userid");
		String username = req.getParameter("username");
		
		Entity fragment = new Entity("User");
		fragment.setProperty("username", username);
		fragment.setProperty("userid", id);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(fragment);
		
		resp.sendRedirect("/samurai.jsp");
	}
}
