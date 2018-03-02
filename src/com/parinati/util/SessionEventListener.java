package com.parinati.util;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionEventListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent session) {
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent sessionEvent) {
		HttpSession session = sessionEvent.getSession();
		String userId = (String)session.getAttribute("userID");

		if (userId != null && !userId.equalsIgnoreCase("")) {
			session.removeAttribute("userID");
		}

	}
}
