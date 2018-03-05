package com.parinati.util;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailerUtil {

	public MailerUtil() {

	}

	private static final String MAIL_SERVER_IP;
	private static final String MAIL_SERVER_PORT;
	private static final String MAIL_FROM;
	private static final String PASSWORD;
	private static final String NO_REPLY_ID;
	private static final String MAIL_CC;

	static {
		Properties props = new Properties();

		try {
			props.load(MailerUtil.class.getClassLoader().getResourceAsStream("mailer.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		MAIL_SERVER_IP = props.getProperty("MAILERHOST");
		MAIL_SERVER_PORT = props.getProperty("MAILERPORT");
		MAIL_FROM = props.getProperty("MAILFROM");
		PASSWORD = props.getProperty("PASSWORD");
		NO_REPLY_ID = props.getProperty("NO_REPLY");
		MAIL_CC = props.getProperty("MAILCC");
	}



	/**********************************************************************************
	 * Method Description : This method is used to send post mail with cc
	 * options and TLS Authentication.
	 *
	 ********************************************************************************/

	public void postMailWithTLSAuth(String toEmail,String ccMail, String subject, String mailTempPath,String[] varData ) {
		try {

			String body = setMailTemplateData(mailTempPath,varData);
			Properties props = new Properties();
			props.put("mail.smtp.ssl.trust", MAIL_SERVER_IP);
			props.put("mail.smtp.host", MAIL_SERVER_IP); //SMTP Host
			props.put("mail.smtp.port", MAIL_SERVER_PORT); //TLS Port
			props.put("mail.smtp.auth", "true"); //enable authentication
			props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS

	                //create Authenticator object to pass in Session.getInstance argument
			Authenticator auth = new Authenticator() {
				//override the getPasswordAuthentication method
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(MAIL_FROM, PASSWORD);
				}
			};
			Session session = Session.getInstance(props, auth);

			sendEmail(session, toEmail, ccMail, subject, body);

		} catch (Exception exception) {
			CustomLogger.exceptionJava(exception, "MailerUtil.java:: postMail()", "MailerUtil.java");
		}
	}


	/**********************************************************************************
	 * Method Description : This method is used to form mail content from a template
	 *
	 ***********************************************************************************/

	public String setMailTemplateData(String filePath, String[] varData) {
		ClassLoader classLoader = MailerUtil.class.getClassLoader();
		File f = new File(classLoader.getResource(filePath).getFile());
		String body = null;
		try {
			body = TemplateFormatter.format(f, varData);

		} catch (TemplateFormatterException t) {
			CustomLogger.exceptionJava(t, "MailerUtil.java :: setMailTemplateData()", "MailerUtil.java");
		}

		return body;
	}

	/**********************************************************************************
	 * Method Description : This method is used to send mail with CC Field

	 ***********************************************************************************/


	public static void sendEmail(Session session, String toEmail, String ccMail, String subject, String body){
		try
	    {
	      MimeMessage msg = new MimeMessage(session);
	      //set message headers
	      msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
	      msg.addHeader("format", "flowed");
	      msg.addHeader("Content-Transfer-Encoding", "8bit");

	      msg.setFrom(new InternetAddress(MAIL_FROM, "NoReply"));

	     // msg.setReplyTo(InternetAddress.parse(NO_REPLY_ID, false));

	      msg.setSubject(subject, "UTF-8");

	      msg.setText(body, "UTF-8");

	      msg.setSentDate(new Date());

	      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
	      msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(ccMail, false));

    	  Transport.send(msg);

	    }
	    catch (Exception e) {
	     CustomLogger.exceptionJava(e, "MailerUtil.java :: sendEmail()", "MailerUtil.java");
	    }
	}


}