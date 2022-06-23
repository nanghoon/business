package egovframework.example.sample.web.admin;

import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	@Resource(name = "fileProperties")
	private Properties fileProperties;
	
	@RequestMapping(value="/main.do")
	public String main(){
		return "admin/main";
	}
	@RequestMapping(value="/login.do")
	public String login(){
		return "admin/login";
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
		EgovMap info = (EgovMap)sampleDAO.select("checkAdminLogin", in);
		if(info == null){
			obj.put("msg", "아이디 혹은 비밀번호가 틀렸습니다.");
			return obj.toJSONString();
		}else{
			HttpSession session = request.getSession();
			session.setAttribute("adminLogin", "1");
			session.setAttribute("adminIdx", info.get("idx"));
			obj.put("result", "success");
			return obj.toJSONString();
		}
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.setAttribute("adminLogin", null);
		session.setAttribute("adminIdx", null);
		return "admin/login";
	}
	
}
