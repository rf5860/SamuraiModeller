package samurai;

import com.google.appengine.api.datastore.DatastoreFailureException;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class CreateUser extends HttpServlet {
	private static final Logger log = Logger.getLogger(CreateUser.class.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String userId = req.getParameter("userId");
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key userKey = KeyFactory.createKey("User", userId);
		
		try {
			datastore.get(userKey);
		} catch (EntityNotFoundException e) {
			Entity user = new Entity("User", userKey);
			user.setProperty("userName", userName);
			user.setProperty("userId", userId);
			user.setProperty("password", password);
			user.setProperty("email", email);
			datastore.put(user);
			req.getSession().setAttribute("user", userId);
		} catch (IllegalArgumentException e) {
			log.log(Level.INFO, "Attempt at creating invalid user");
			resp.sendError(400, "Invalid User Id");
		} catch (DatastoreFailureException e) {
			resp.sendError(500, "Error accessing datastore");
		}
		resp.sendRedirect("/samurai.jsp");
	}
}
