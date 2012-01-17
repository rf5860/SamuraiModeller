package samurai;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.ShortBlob;
import com.google.appengine.api.datastore.DatastoreFailureException;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class LoginUser extends HttpServlet {
	private static final Logger log = Logger.getLogger(LoginUser.class.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// Read user from database, and check password --> If incorrect, redirect to the login page, with information that the id/password is wrong.
		// otherwise, redirect to the fragment page.
		String userId = req.getParameter("userId");
		// Can't retrieve null UID
		if ( Utility.notNullOrEmpty(userId, false) ) {
			String password = req.getParameter("password");
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Key userKey = KeyFactory.createKey("User", userId);
			try {
				Entity user = datastore.get(userKey);
				// Means the user already exists --> So validate their password.
				try {
					// Shouldn't be possible to have a user with a blank password.
					byte[] savedPwd = ((ShortBlob) user.getProperty("password")).getBytes();
					byte[] pwdBytes = password.getBytes("UTF-8");
					MessageDigest md = MessageDigest.getInstance("MD5");
					byte[] hash = md.digest(pwdBytes);
					
					if ( Arrays.equals(savedPwd, hash) ) {
						// Login success
						req.getSession().setAttribute("user", userId);
						resp.sendRedirect("/samurai.jsp");
					} else {
						resp.sendRedirect("/login.jsp?fail=badpwd");
					}
				} catch (NoSuchAlgorithmException e) { }
			} catch (EntityNotFoundException e) {
				resp.sendRedirect("/login.jsp?fail=baduid");
			} catch (IllegalArgumentException e) {
				log.log(Level.INFO, "Attempt to login with an invalid userId");
				resp.sendError(400, "Invalid User Id");
			} catch (DatastoreFailureException e) {
				log.log(Level.INFO, "Error accessing datastore with " + userId);
				resp.sendError(500, "Error accessing datastore");
			}
		} else {
			resp.sendRedirect("/login.jsp?fail=nouid");
		}
	}
}
