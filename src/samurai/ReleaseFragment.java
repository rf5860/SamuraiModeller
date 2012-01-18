package samurai;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreFailureException;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class ReleaseFragment extends HttpServlet {
	private static final Logger log = Logger.getLogger(CreateFragment.class.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String user = (String) req.getSession().getAttribute("user");
		if (user != null) {
			String fragmentName = req.getParameter("fragmentName");
			if ( Utility.notNullOrEmpty(fragmentName) ){
				Key fragmentKey = KeyFactory.createKey("Fragment", fragmentName);
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				try {
					Entity fragment = datastore.get(fragmentKey);
					// If we don't get an exception, the value was successfully retrieved. We expect this to be the standard case.
					String holder = (String)fragment.getProperty("holder");
					if (Utility.notNullOrEmpty(holder)) {
						if (holder.equals(user)) {
							// Free both the holder, and the claim date on the fragment.
							fragment.removeProperty("holder");
							fragment.removeProperty("claimDate");
							datastore.put(fragment);
						} else {
							// User attempted to release a fragment they don't own.
							log.log(Level.INFO, user + " attempted to release " + fragmentName + " they don't own.");
							resp.sendRedirect("/samurai.jsp?fragment=notholder");
						}
					} else {
						// User attempted to release a fragment that doesn't have a holder.
						log.log(Level.INFO, user + " attempted to release " + fragmentName + " which doesn't have a holder.");
						resp.sendRedirect("/samurai.jsp?fragment=noholder");
					}
				} catch (EntityNotFoundException e) {
					// User attempted to release a fragment that doesn't exist. This should never actually happen.
					log.log(Level.INFO, user + " attempted to release " + fragmentName + " which doesn't exist.");
					resp.sendRedirect("/samurai.jsp?fragment=invalidrelease");
				} catch (IllegalArgumentException e) {
					log.log(Level.INFO, user + " attempted to release " + fragmentName + " which is invalid.");
					resp.sendRedirect("/samurai.jsp?fragment=invalidrelease");
				} catch (DatastoreFailureException e) {
					log.log(Level.INFO, "Error accessing datastore with " + user);
					resp.sendError(500, "Error accessing datastore");
				}
				resp.sendRedirect("/samurai.jsp");	
			} else {
				log.log(Level.INFO, user + " attempted to release null fragment");
				resp.sendRedirect("/samurai.jsp?fragment=invalidrelease");
			}	
		} else {
			// Only allow a logged in user to release fragments.
			resp.sendRedirect("/samurai.jsp?fragment=no");
		}
	}
}
