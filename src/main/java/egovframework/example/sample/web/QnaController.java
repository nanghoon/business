package egovframework.example.sample.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class QnaController {
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	@RequestMapping("/qna.do")
	public String qna(HttpServletRequest request , Model model){
		String category = request.getParameter("category");
		String search = request.getParameter("search");
		PaginationInfo pi = new PaginationInfo();
		String pageIndex = request.getParameter("pageIndex");
		if(Utils.isNull(pageIndex)){
			pi.setCurrentPageNo(1);
		}else{
			pi.setCurrentPageNo(Integer.parseInt(pageIndex));
		}
		pi.setPageSize(5);
		pi.setRecordCountPerPage(10);
		EgovMap in = new EgovMap();
		in.put("first", pi.getFirstRecordIndex());
		in.put("record", pi.getRecordCountPerPage());
		in.put("category", category);
		in.put("search", search);
		List<EgovMap> selectQnaList = (List<EgovMap>)sampleDAO.list("selectQnaList" , in);
		pi.setTotalRecordCount((int)sampleDAO.select("QnaListCnt" , in));
		model.addAttribute("qnaMemberList",selectQnaList);
		model.addAttribute("pi",pi);
		model.addAttribute("category",category);
		model.addAttribute("search",search);
		return"Qna/qna";
	}
	@RequestMapping("/qnaDetail.do")
	public String qnaDetail(HttpServletRequest request , Model model , HttpServletResponse response){
		String idx = request.getParameter("idx");
		EgovMap info = (EgovMap)sampleDAO.select("selectQnaMemberDetail",idx);
		model.addAttribute("qnaDetail",info);
		model.addAttribute("text",StringEscapeUtils.unescapeHtml3(info.get("text")+""));
		model.addAttribute("repleList",sampleDAO.list("selectQnaRepleList",idx));
		//조회수처리 
		Cookie[] cookies = request.getCookies();
		Cookie viewCookie = null;
        if (cookies != null && cookies.length > 0){
            for (int i = 0; i < cookies.length; i++){
                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
                if (cookies[i].getName().equals("qna_cookie"+idx)){ 
                    viewCookie = cookies[i];
                }
            }
        }		
        if(viewCookie == null){
        	Cookie newCookie = new Cookie("qna_cookie"+idx, "|" + idx + "|");
        	response.addCookie(newCookie);
        	sampleDAO.update("boardViewCnt",idx);  //조회수
        }
		return"Qna/qnaDetail";
	}
	@RequestMapping("/qnaUpdate.do")
	public String qnaUpdate(HttpServletRequest request , Model model){
		String idx = request.getParameter("idx");
		String category =request.getParameter("category");
		model.addAttribute("qnaDetail",sampleDAO.select("selectQnaMemberDetail",idx));
		model.addAttribute("category", category);
		model.addAttribute("repleList",sampleDAO.list("selectQnaRepleList",idx));
		return"Qna/qnaUpdate";
	}
	@RequestMapping("/qnaInsert.do")
	public String qnaInsert(HttpServletRequest request , Model model){
		String category = request.getParameter("category");
		model.addAttribute("category",category);
		return"Qna/qnaInsert";
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaInsertProcess.do" , produces = "application/json; charset=utf8")
	public String qnaInsertProcess(HttpServletRequest request ){
		HttpSession session=request.getSession();
		String useridx = session.getAttribute("UserLoginIdx").toString();
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String text = request.getParameter("text");
		String link1 = request.getParameter("link1");
		String link2 = request.getParameter("link2");
		JSONObject obj = new JSONObject();
		System.out.println(text);
		obj.put("result", "fail");
		if(Utils.isNull(category)){
			obj.put("msg", "카테고리를 선택해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(title)){
			obj.put("msg", "제목을 입력해주세요");
			return obj.toJSONString();
		} 	
		if(Utils.isNull(text)){
			obj.put("msg", "내용을 입력해주세요");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		in.put("category", category);
		in.put("title", title);
		in.put("text", text);
		in.put("link1", link1);
		in.put("link2", link2);
		in.put("useridx", useridx);
		sampleDAO.insert("insertQnaMember",in);
		obj.put("result", "success");
		obj.put("msg", "완료되었습니다.");
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/qnaDetailDelete.do" , produces = "application/json; charset=utf8")
	public String qnaDetailDelete(HttpServletRequest request){
		String idx = request.getParameter("idx");
		JSONObject obj = new JSONObject();
		String result = "success";
		sampleDAO.delete("deleteQna" , idx);
		// 댓글삭제 
		sampleDAO.delete("deleteQnaRepleByGroupIdx",idx);
		obj.put("result", result);
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/qnaRepleProcess.do" , produces="application/json; charset=utf8" )
	public String qnaRepleProcess(HttpServletRequest request , Model model){
		HttpSession session =request.getSession();
		String ridx = session.getAttribute("UserLoginIdx").toString();
		String idx = request.getParameter("idx");
		String reple = request.getParameter("reple");
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		if(Utils.isNull(ridx)){
			obj.put("msg", "로그인 후 작성하실수있습니다.");
			return obj.toJSONString();
		}
		if(Utils.isNull(reple)){
			obj.put("msg", "내용을 입력해주세요");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		in.put("idx", idx);
		in.put("reple", reple);
		in.put("ridx", ridx);
		sampleDAO.insert("insertQnaReple",in);
		obj.put("result", "success");
		obj.put("msg", "완료되었습니다.");
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/qnaUpdateProcess.do" , produces="application/json; charset=utf8" )
	public String qnaUpdateProcess(HttpServletRequest request , Model model){
		String idx = request.getParameter("idx");
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String text = request.getParameter("text");
		String link1 = request.getParameter("link1");
		String link2 = request.getParameter("link2");
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		if(Utils.isNull(category)){
			obj.put("msg", "카테고리를 선택해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(title)){
			obj.put("msg", "제목을 입력해주세요");
			return obj.toJSONString();
		} 	
		if(Utils.isNull(text)){
			obj.put("msg", "내용을 입력해주세요");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		in.put("idx", idx);
		in.put("category", category);
		in.put("title", title);
		in.put("text", text);
		in.put("link1", link1);
		in.put("link2", link2);
		sampleDAO.update("updateQnaMember",in);
		obj.put("result", "success");
		obj.put("msg", "완료되었습니다.");
		return obj.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaPwCheck.do" , produces ="appication/json; charset=utf8")
	public String qnaPwCheck(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		String qidx = request.getParameter("qidx"); // qna 글의 idx 
		String qbidx = request.getParameter("qbidx"); //qna 글 작성자의 idx
		String qnaPw = request.getParameter("qnaPw");
		
		EgovMap info = (EgovMap)sampleDAO.select("selectUserDetail", qbidx);
		if(info != null){
			if(!info.get("pw").equals(qnaPw)){
				obj.put("msg", "비밀번호가 다릅니다.");
				return obj.toJSONString();
			}else{
				obj.put("result", "success");
				obj.put("qidx", qidx);
				return obj.toJSONString();
			}
		}else{
			obj.put("msg", "잘못된정보입니다.");
			return obj.toJSONString();
		}
		
	}
	@ResponseBody
	@RequestMapping(value="/qnaRepleDelete.do", produces = "application/json; charset=utf8")
	public String qnaRepleDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String idx = ""+request.getParameter("idx");
		sampleDAO.delete("deleteqnaReple" , idx);
		obj.put("result", result);
		return obj.toJSONString();
	}

}
