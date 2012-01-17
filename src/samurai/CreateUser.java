package samurai;

import com.google.appengine.api.datastore.ShortBlob;
import com.google.appengine.api.datastore.DatastoreFailureException;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
			// Means the user already exists.
			resp.sendRedirect("/register.jsp?fail=true");
		} catch (EntityNotFoundException e) {
			Entity user = new Entity(userKey);
			try {
				byte[] pwdBytes = password.getBytes("UTF-8");
				MessageDigest md = MessageDigest.getInstance("MD5");
				byte[] hash = md.digest(pwdBytes);
								
				user.setProperty("userName", userName);
				user.setProperty("userId", userId);
				user.setProperty("password", new ShortBlob(hash));
				user.setProperty("email", email);
				datastore.put(user);
				req.getSession().setAttribute("user", userId);
				
			} catch (NoSuchAlgorithmException noSuchAlgExc) {}
		} catch (IllegalArgumentException e) {
			log.log(Level.INFO, "Attempt at creating invalid user");
			resp.sendError(400, "Invalid User Id");
		} catch (DatastoreFailureException e) {
			resp.sendError(500, "Error accessing datastore");
		}
		resp.sendRedirect("/samurai.jsp");
	}
}
