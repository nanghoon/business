package egovframework.example.sample.web.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
@RequestMapping("/admin/guide")
public class AdminGuideController {
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	@RequestMapping("/insert.do")
	public String insesrt(HttpServletRequest request ,Model model){
		String kind = request.getParameter("kind");
		model.addAttribute("info", sampleDAO.select("selectGuideByKind",kind));
		return "admin/guideInsert";
	}

	@ResponseBody
	@RequestMapping(value="/insertProcess.do" , produces="application/json; charset=utf8")
	public String insertProcess(HttpServletRequest request){
		String idx = request.getParameter("idx");
		String text = request.getParameter("text");
		JSONObject obj = new JSONObject();
		if(Utils.isNull(text)){
			obj.put("result" , "fail");
			obj.put("msg" , "내용을 입력해주세요");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		in.put("idx" ,idx);
		in.put("text" ,text);
		sampleDAO.update("updateGuideText",in);
		obj.put("result" , "success");
		obj.put("msg" , "완료되었습니다");
		return obj.toJSONString();
	}
}
