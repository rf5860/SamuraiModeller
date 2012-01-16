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
public class CreateFragment extends HttpServlet {
	private static final Logger log = Logger.getLogger(CreateFragment.class.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		String fragmentName = req.getParameter("fragmentName");
		Entity fragment = new Entity("Fragment");
		fragment.setProperty("fragmentName", fragmentName);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(fragment);
		
		resp.sendRedirect("/samurai.jsp");
	}
}
