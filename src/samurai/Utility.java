package samurai;

public class Utility {
	public static boolean notNullOrEmpty(String s) {
		return notNullOrEmpty(s, true);
	}
	
	public static boolean notNullOrEmpty(String s, boolean trim) {
		if (trim)
			return (s != null) && (! (s.trim()).equals(""));
		return ( s != null ) && (! s.equals(""));
	}
}
