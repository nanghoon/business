package egovframework.example.sample.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import nl.captcha.Captcha;

@Controller
public class LoginController {
	
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	//회원가입 
	@RequestMapping("/join.do")
	public String join(){
		return "user/join";
	}
	
	@ResponseBody
	@RequestMapping(value="/checkJoinForm.do" , produces = "application/json; charset=utf8")
	public String checkJoinForm(HttpServletRequest request ){
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String pwchk = request.getParameter("pwchk");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		String mail = request.getParameter("mail");
		String info = request.getParameter("info");
		String captcha = request.getParameter("captcha");
		
		if(Utils.isNull(id)){
			obj.put("msg", "아이디를 입력해주세요");
			return obj.toJSONString();
		}
		// + 아이디 중복체크 
		EgovMap checkId = (EgovMap)sampleDAO.select("checkID",id);
		if(checkId != null){
			obj.put("msg", "아이디가 중복되었습니다");
			return obj.toJSONString();
		}
		if(!Utils.isEnNum(id) || id.length() < 3){
			obj.put("msg", "아이디는 영문자 혹은 숫자만 3자리 이상으로 입력해주세요.");
			return obj.toJSONString();
		}
		if(Utils.isNull(pw)){
			obj.put("msg", "비밀번호를 입력해주세요");
			return obj.toJSONString();
		} 	
		// 숫자 == 비교 가능 , 문자는 .eqqulas("비교문자열") , .compareTo("비교문자열")
		if(!pw.equals(pwchk)){
			obj.put("msg" , "비밀번호가 일치하지 않습니다");
			return obj.toJSONString();
		}
		if(Utils.isNull(name)){
			obj.put("msg", "이름을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(nickname)){
			obj.put("msg", "닉네임을 입력해주세요");
			return obj.toJSONString();
		}
		// 닉네임 중복체크
		EgovMap checkNickname = (EgovMap)sampleDAO.select("checkNickname",nickname);
		if(checkNickname != null){
			obj.put("msg", "닉네임이 중복되었습니다");
			return obj.toJSONString();
		}
		if(!Utils.isTextEngNum(nickname) || nickname.length() < 3){
			obj.put("msg", "닉네임은 한글과 영어,숫자만 가능합니다. 글자를 3자리 이상으로 입력해주세요.");
			return obj.toJSONString();
		}
		if(Utils.isNull(email)){
			obj.put("msg", "이메일을 입력해주세요.");
			return obj.toJSONString();
		}
		if(!Utils.isValidEmail(email)){
			obj.put("msg", "이메일 형식이 올바르지 않습니다");
			return obj.toJSONString();
		}
		EgovMap checkMail = (EgovMap)sampleDAO.select("checkEmail" , email);
		if(checkMail != null){
			obj.put("msg", "이메일이 중복되었습니다");
			return obj.toJSONString();
		}
		if(Utils.isNull(captcha)){
			obj.put("msg", "자동등록방지숫자를 입력해주세요.");
			return obj.toJSONString();
		}
		Captcha c = (Captcha) request.getSession().getAttribute(Captcha.NAME);
		if(!c.isCorrect(captcha)) {
			obj.put("msg", "자동등록방지숫자가 올바르지않습니다.");
			return obj.toJSONString();
		}else{
			request.getSession().removeAttribute(Captcha.NAME);
		}
		if(Utils.isNull(mail)){
			mail = "N";
		}
		if(Utils.isNull(info)){
			info = "N";
		}
		EgovMap in = new EgovMap();
		in.put("id", id);
		in.put("pw", pw);
		in.put("name", name);
		in.put("nickname", nickname);
		in.put("email", email);
		in.put("mail", mail);
		in.put("info", info);
		sampleDAO.insert("insertLoginformMember",in);
		obj.put("result", "success");
		obj.put("name", name);
		obj.put("msg", "완료되었습니다.");
		return obj.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/loginProcess.do", produces="application/json; charset=utf8")
	public String loginProcess(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		if(Utils.isNull(id)){
			obj.put("msg", "아이디를 입력하세요.");
			return obj.toJSONString();
		}
		if(Utils.isNull(pw)){
			obj.put("msg", "비밀번호를 입력하세요.");
			return obj.toJSONString();
		}	
		EgovMap in = new EgovMap();
		in.put("id", id);
		in.put("pw", pw);
		EgovMap info = (EgovMap)sampleDAO.select("checkUserLogin", in);
		if(info == null){
			obj.put("msg", "아이디 혹은 비밀번호가 틀렸습니다.");
			return obj.toJSONString();
		}else{
			HttpSession session = request.getSession();
			session.setAttribute("UserLogin", "1");
			session.setAttribute("UserLoginIdx", info.get("idx"));
			session.setAttribute("UserLoginId", info.get("id"));
			session.setAttribute("UserLoginNickName", info.get("nickname"));
			obj.put("result", "success");
			return obj.toJSONString();
		}
		
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.setAttribute("UserLogin", null);
		session.setAttribute("UserLoginIdx", null);
		session.setAttribute("UserLoginId", null);
		session.setAttribute("UserLoginNickName", null);
		return "redirect:main.do";
	}

	@ResponseBody
	@RequestMapping(value="/checkInfoForm.do" , produces = "application/json; charset=utf8")
	public String checkInfoForm(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		String email = request.getParameter("email");
		String captcha = request.getParameter("captcha");
		if(Utils.isNull(email)){
			obj.put("msg", "이메일을 입력해주세요.");
			return obj.toJSONString();
		}
		if(!Utils.isValidEmail(email)){
			obj.put("msg", "이메일 형식이 올바르지 않습니다");
			return obj.toJSONString();
		}
		EgovMap info = (EgovMap)sampleDAO.select("checkEmail" , email);
		if(info == null){
			obj.put("msg", "등록된 정보가 없습니다.");
			return obj.toJSONString();
		}
		if(Utils.isNull(captcha)){
			obj.put("msg", "자동등록방지숫자를 입력해주세요.");
			return obj.toJSONString();
		}
		Captcha c = (Captcha) request.getSession().getAttribute(Captcha.NAME);
		if(!c.isCorrect(captcha)) {
			obj.put("msg", "자동등록방지숫자가 올바르지않습니다.");
			return obj.toJSONString();
		}else{
			request.getSession().removeAttribute(Captcha.NAME);
		}
		String message = "ID - "+info.get("id")+" , PW = " + info.get("pw");
		if(Utils.sendMailInfo(request, email, message)){
			obj.put("result", "success");
			obj.put("msg", "메일로 회원정보가 발송되었습니다.");
			return obj.toJSONString();
		}else{
			obj.put("msg", "메일 발송 중 오류가 발생했습니다. \n새로고침 후 다시 시도해주세요.");
			return obj.toJSONString();
		}
	}
	@ResponseBody
	@RequestMapping(value="/userDelete.do" , produces = "application/json; charset=utf8")
	public String userDelete(HttpServletRequest request){
		HttpSession session = request.getSession();
		String idx = session.getAttribute("UserLoginIdx").toString(); // 회원 idx
		JSONObject obj = new JSONObject();
		sampleDAO.delete("deleteUser" , idx); 
		// 유저가 작성할수있는부분 qna / 링크게시판 reple / qna reple / 스크랩 
		sampleDAO.delete("deleteBoardUser" , idx);
		sampleDAO.delete("deleteBoardRepleUser" , idx);
		sampleDAO.delete("deleteLinkRepleUser" , idx);
		sampleDAO.delete("deleteScrapUser" , idx);
		
		obj.put("result", "success");
		obj.put("msg", "탈퇴 완료되었습니다.");
		return obj.toJSONString();
	}
}
