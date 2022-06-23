package egovframework.example.sample.web.util;

import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class Utils {
	
	public static boolean isNull(String str){
		return str == null || str.isEmpty() || str.equals("null") || str.equals("NaN");
	}
	
	public static boolean isEnNum(String str){
		return Pattern.matches("[a-zA-Z0-9]*$", str);
	}

	public static boolean isTextEngNum(String str) {
	    return Pattern.matches("^[가-힣a-zA-Z0-9]+$", str);
	}
	
	public static boolean isValidEmail(String email) { 
		 return Pattern.matches("^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$", email);
	}
	
	public static boolean isValidPhone(String str) {
	    return Pattern.matches("^\\d{2,3}\\d{3,4}\\d{4}$", str);
	}

	public static String getTempCode(SampleDAO sampleDAO, int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
				'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z' };
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}
		EgovMap codeInfo = (EgovMap)sampleDAO.select("checkInviteCode" ,sb.toString());
		if(codeInfo != null){
			getTempCode(sampleDAO,length);
		}
		return sb.toString();
	}
	
	public static String getTempNumber(int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}
		return sb.toString();
	}
	
	public static String getClientIp(HttpServletRequest req) {
	    String ip = req.getHeader("X-Forwarded-For");
	    if (ip == null) ip = req.getRemoteAddr();
	    return ip;
	}
	
	public static boolean sendMailInfo(HttpServletRequest request , String email, String context)
	{
		Properties properties = getProperties();
		try
		{
			Authenticator auth = new senderAccount();
			Session session = Session.getInstance(properties, auth);
			session.setDebug(true); // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
			MimeMessage msg = new MimeMessage(session);
			msg.setSubject("LINKSHOW - 회원 정보입니다."); //타이틀변경
			Address fromAddr = new InternetAddress("link2432q@gmail.com"); // 보내는사람
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(email); // 받는사람 EMAIL
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			String mailcontent = context;
			msg.setContent("<pre>"+mailcontent+"</pre>", "text/html;charset=utf-8"); // 메일 전송될
			if(isValidEmail(email)==true){
				Transport.send(msg);
			}
			return true;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
	}
	static Properties getProperties(){
		Properties properties = new Properties();
		properties.put("mail.smtp.user", "link2432q@gmail.com"); // 구글 계정
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.debug", "true");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.socketFactory.fallback", "false");
		return properties;
	}
	
	public static class senderAccount extends javax.mail.Authenticator
	{
		public PasswordAuthentication getPasswordAuthentication()
		{
			// @gmail.com 제외한 계정 ID, PASS
			return new PasswordAuthentication("link2432q", "Choi958100@"); // @gmail.com. 제외																// PASS

		}
	}
}
