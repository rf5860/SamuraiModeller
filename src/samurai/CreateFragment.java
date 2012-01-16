package samurai;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class CreateFragment extends HttpServlet {
	private static final Logger log = Logger.getLogger(CreateFragment.class.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		String fragmentName = req.getParameter("newFragment");
		if ( notNullOrEmpty(fragmentName) ){			
			Date date = new Date();
			
			Entity fragment = new Entity("Fragment");
			fragment.setProperty("fragmentName", fragmentName);
			fragment.setProperty("dateSeized", date);
			
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			datastore.put(fragment);
			
			resp.sendRedirect("/samurai.jsp");	
		} else {
			log.log(Level.INFO, "Attempt at creating null fragment");
			resp.sendError(400, "Invalid fragment name supplied");
		}
	}
	
	protected static boolean notNullOrEmpty(String s) {
		return (s != null) && (! (s.trim()).equals(""));
	}
}
