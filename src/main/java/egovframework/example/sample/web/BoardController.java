package egovframework.example.sample.web;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import nl.captcha.Captcha;

@Controller
public class BoardController {
	
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	@Resource(name = "fileProperties")
	private Properties fileProperties;
	
	@RequestMapping("/{linkCate}List.do")
	public String linkCateList(@PathVariable("linkCate") String linkCate , HttpServletRequest request , Model model){
		PaginationInfo pi = new PaginationInfo();
		String pageIndex = request.getParameter("pageIndex");
		String search = request.getParameter("search");
		String orderKind = request.getParameter("orderKind");
		if(Utils.isNull(pageIndex)){
			pi.setCurrentPageNo(1);
		}else{
			pi.setCurrentPageNo(Integer.parseInt(pageIndex));
		}
		pi.setPageSize(10);
		pi.setRecordCountPerPage(15);
		EgovMap in = new EgovMap();
		in.put("first", pi.getFirstRecordIndex());
		in.put("record", pi.getRecordCountPerPage());
		in.put("category", linkCate);
		in.put("search", search);
		in.put("orderKind", orderKind);
		in.put("kind", "title");
		model.addAttribute("linkList", sampleDAO.list("linkList" , in));
		model.addAttribute("linkListAll", sampleDAO.list("linkListAll" , in));
		pi.setTotalRecordCount((int)sampleDAO.select("linkListCnt" , in));
		model.addAttribute("pi", pi);
		model.addAttribute("category", linkCate);
		model.addAttribute("search", search);
		model.addAttribute("orderKind", orderKind);
		return "user/linkList";
	}
	
	@RequestMapping("/{linkCate}Detail.do")
	public String linkCateDetail(@PathVariable("linkCate") String linkCate ,HttpServletRequest request, Model model , HttpServletResponse response){
		String idx = request.getParameter("idx");
		EgovMap info = (EgovMap)sampleDAO.select("linkDetail",idx);
		if(info == null){
			return "redirect:"+linkCate+"List.do";
		}
		model.addAttribute("info", info);
		model.addAttribute("tagList", sampleDAO.list("tagListByLidx",idx));
		model.addAttribute("category", linkCate);
		model.addAttribute("text", StringEscapeUtils.unescapeHtml3(info.get("text").toString()));
		model.addAttribute("repleList",sampleDAO.list("selectlinkRepleList",idx));
		model.addAttribute("linkList" , sampleDAO.list("linkListAll", linkCate));
		//조회수처리 
		Cookie[] cookies = request.getCookies();
		Cookie viewCookie = null;
        if (cookies != null && cookies.length > 0){
            for (int i = 0; i < cookies.length; i++){
                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
                if (cookies[i].getName().equals("cookie"+idx)){ 
                    viewCookie = cookies[i];
                }
            }
        }		
        if(viewCookie == null){
        	Cookie newCookie = new Cookie("cookie"+idx, "|" + idx + "|");
        	response.addCookie(newCookie);
        	sampleDAO.update("linkViewCnt",idx);  //조회수
        }
		return "user/linkDetail";
	}
	@ResponseBody
	@RequestMapping(value="/linkRepleProcess.do" ,  produces="application/json; charset=utf8")
	public String linkRepleProcess(HttpServletRequest request){
		HttpSession session =request.getSession();
		String ridx = session.getAttribute("UserLoginIdx").toString();
		String idx=request.getParameter("idx");
		String reple=request.getParameter("reple");
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
		sampleDAO.insert("insertLinkReple",in);
		obj.put("result", "success");
		obj.put("msg", "완료되었습니다.");
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/repleUserDelete.do", produces = "application/json; charset=utf8")
	public String repleUserDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String idx = ""+request.getParameter("idx");
		sampleDAO.delete("deleteReple" , idx);
		obj.put("result", result);
		return obj.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/linkClick.do")
	public void linkClick(HttpServletRequest request , HttpServletResponse response){
		String idx = request.getParameter("idx");
		sampleDAO.update("updateLinkClick",idx);
	}
	@RequestMapping(value="/noticeList.do")
	public String noticeList(HttpServletRequest request , Model model){
		String orderKind = request.getParameter("orderKind");
		String search = request.getParameter("search");
		//페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		if (Utils.isNull(request.getParameter("pageIndex"))) {
			paginationInfo.setCurrentPageNo(1);
		} else {
			paginationInfo.setCurrentPageNo(Integer.parseInt("" + request.getParameter("pageIndex")));
		}
		EgovMap in = new EgovMap();
		in.put("search", search);
		in.put("orderKind", orderKind);
		// 공지 3건 
		List<EgovMap> topList = (List<EgovMap>)sampleDAO.list("selectTopNoticeList" , in);
		model.addAttribute("topList", topList);
		paginationInfo.setRecordCountPerPage(10 - topList.size());
		paginationInfo.setPageSize(1);
		in.put("first", paginationInfo.getFirstRecordIndex());
		in.put("record", paginationInfo.getRecordCountPerPage());
		//인자생성
		model.addAttribute("list", sampleDAO.list("selectNoticeMemberList", in));
		paginationInfo.setTotalRecordCount((int)sampleDAO.select("selectNoticeMemberListCnt" , in));
		model.addAttribute("pi", paginationInfo);
		model.addAttribute("search", search);
		model.addAttribute("orderKind", orderKind);
		return "user/noticeList";
	}
	
	@RequestMapping("/noticeDetail.do")
	public String noticeDetail(HttpServletRequest request , Model model , HttpServletResponse response){
		String idx = request.getParameter("idx");
		EgovMap info = (EgovMap)sampleDAO.select("selectNoticeDetail",idx);
		model.addAttribute("info",info);
		model.addAttribute("text", StringEscapeUtils.unescapeHtml3(info.get("text").toString()));
		//조회수처리 
		Cookie[] cookies = request.getCookies();
		Cookie viewCookie = null;
        if (cookies != null && cookies.length > 0){
            for (int i = 0; i < cookies.length; i++){
                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
                if (cookies[i].getName().equals("notice_cookie"+idx)){ 
                    viewCookie = cookies[i];
                }
            }
        }		
        if(viewCookie == null){
        	Cookie newCookie = new Cookie("notice_cookie"+idx, "|" + idx + "|");
        	response.addCookie(newCookie);
        	sampleDAO.update("boardViewCnt",idx);  //조회수
        }
		return "user/noticeDetail";
	}

	@RequestMapping("/guide.do")
	public String guide(HttpServletRequest request , Model model){
		String kind = request.getParameter("kind");
		EgovMap info = (EgovMap)sampleDAO.select("selectGuideByKind",kind);
		model.addAttribute("kind", kind);
		model.addAttribute("text", StringEscapeUtils.unescapeHtml3(info.get("text")+""));
		return "user/guide";
	}
	
	@RequestMapping(value = "/editorFileUpload.do") // attach_photo.js 에 설정한 업로드 경로 
	public void editorFileUpload(MultipartHttpServletRequest mre,HttpServletRequest request, ModelMap model , HttpServletResponse response) throws Exception {
		System.out.println("editorFileUpload");
	    try {
	         String sFileInfo = "";
	         String filename = mre.getFile("file").getOriginalFilename();
	         String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
	         filename_ext = filename_ext.toLowerCase();
	         String dftFilePath = fileProperties.getProperty("file.editor.upload");
	         String filePath = dftFilePath;  // 서버 업로드 경로 
	         File file = new File(filePath);
	         if(!file.exists()) {
	            file.mkdirs();
	         }
	         String realFileNm = "";
	         realFileNm = UUID.randomUUID().toString().replaceAll("-", "") + filename.substring(filename.lastIndexOf("."));
	         String rlFileNm = filePath + realFileNm;
	         ///////////////// 서버에 파일쓰기 /////////////////
	         MultipartFile mf = mre.getFile("file");
	         mf.transferTo(new File(rlFileNm));
	         // 정보 출력
	         sFileInfo += "&bNewLine=true";
	         sFileInfo += "&sFileName="+ realFileNm;;
	         sFileInfo += "&sFileURL=/filePath/business/editor/"+realFileNm; //에디터 이미지 나타낼 소스 경로
	         PrintWriter print = response.getWriter();
	         print.print(sFileInfo);
	         print.flush();
	         print.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}	
	
	@RequestMapping("/edit.do")
	public String edit(){
		return "user/edit";
	}
	
	@ResponseBody
	@RequestMapping(value="/editPwCheck.do" , produces = "application/json; charset=utf8")
	public String editPwCheck(HttpServletRequest request)throws Exception{
		HttpSession session = request.getSession();
		String idx = session.getAttribute("UserLoginIdx").toString();
		String pw = request.getParameter("pw");
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		if(Utils.isNull(pw)){
			obj.put("msg", "비밀번호를 입력하세요.");
			return obj.toJSONString();
		}	
		EgovMap info = (EgovMap)sampleDAO.select("selectUserDetail", idx );
		if(info == null){ // 로그인한 회원 정보가 없을경우 
			obj.put("msg", "회원 정보가 없습니다.");
			return obj.toJSONString();
		}
		if(info.get("pw").equals(pw)){ // 테이블에 있는 비밀번호 = 내가 입력한 비밀번호
			obj.put("result", "success");
			return obj.toJSONString();
		}else{ //테이블에 있는 비밀번호 != 내가 입력한 비밀번호
			obj.put("msg", "비밀번호가 올바르지 않습니다.");
			return obj.toJSONString();
		}
	}
	
	@RequestMapping("/editForm.do")
	public String editForm(HttpServletRequest request , Model model){
		// 서버에 저장하는 저장소 
		HttpSession session = request.getSession();
		String idx = session.getAttribute("UserLoginIdx").toString(); // 로그인할때 세션에 저장한 회원 IDX
		EgovMap info = (EgovMap)sampleDAO.select("selectUserDetail", idx ); // 해당 idx의 회원정보 가져옴   
		model.addAttribute("info",info); // model : controller -> jsp 값넘길때사용  
		return "user/editForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/editUserForm.do" , produces = "application/json; charset=utf8")
	public String editUserForm(HttpServletRequest request ){
		String pw = request.getParameter("pw");
		String pwchk = request.getParameter("pwchk");
		String email = request.getParameter("email");
		String mail = request.getParameter("mail");
		String info = request.getParameter("info");
		String idx = request.getParameter("idx");
		String captcha = request.getParameter("captcha");
		JSONObject obj = new JSONObject();
		EgovMap in = new EgovMap();
		in.put("idx", idx);
		obj.put("result", "fail");
		// 숫자 == 비교 가능 , 문자는 .equals("비교문자열") , .compareTo("비교문자열")
		if(!Utils.isNull(pw)){
			if(!pw.equals(pwchk)){
				obj.put("msg" , "변경하실 비밀번호가 일치하지 않습니다");
				return obj.toJSONString();
			}
			in.put("pw", pw);
		}			
		if(Utils.isNull(email)){
			obj.put("msg", "이메일을 입력해주세요.");
			return obj.toJSONString();
		}
		if(!Utils.isValidEmail(email)){
			obj.put("msg", "이메일 형식이 올바르지 않습니다");
			return obj.toJSONString();
		}
		
		// 이메일을 원래 자기거랑 다르게 변경했는지 
		// 입력값은 = email 그렇다면 원래값은 어떻게얻어올까?? 
		EgovMap user = (EgovMap)sampleDAO.select("selectUserDetail", idx );
//		변수명 user = query 실행문 id = selectUserDetail 값 
//		user {id:123 , name : 123 , email:eeee@naver.com , pw :1234}
//		user.get("email")
		if(!user.get("email").equals(email)){ // 기존값과 입력값이 다를때 
			// 이메일 중복검사 query 
			EgovMap checkMail = (EgovMap)sampleDAO.select("checkEmail" , email);
			if(checkMail != null){
				obj.put("msg", "이메일이 중복되었습니다");
				return obj.toJSONString();
			}
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
		in.put("email", email);
		in.put("mail", mail);
		in.put("info", info);
		sampleDAO.update("updateEditformMember",in);
		obj.put("result", "success");
		obj.put("msg", "수정이 완료되었습니다.");
		return obj.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value="/scrap.do" , produces="application/json; charset=utf8")
	public String scrap(HttpServletRequest request){
		HttpSession session = request.getSession();
		String tb = request.getParameter("tb"); // 링크게시판(l) / 공지게시판(b) 구분 
		String idx = request.getParameter("idx"); // 글번호 idx
		JSONObject obj = new JSONObject();
		EgovMap in = new EgovMap();
		in.put("stable", tb);
		in.put("sidx", idx);
		in.put("midx", session.getAttribute("UserLoginIdx"));
		EgovMap info = (EgovMap)sampleDAO.select("checkScrap",in);
		if(info == null){
			obj.put("msg", "스크랩하였습니다\n지금 바로 확인하시겠습니까?");
			sampleDAO.insert("insertScrap",in);
			return obj.toJSONString();
		}else{
			obj.put("msg", "이미 스크랩하신 글입니다\n지금 바로 확인하시겠습니까?");
			return obj.toJSONString();
		}
	}
	
	@RequestMapping("/scrapPop.do")
	public String scrapPop(HttpServletRequest request, Model model){
		HttpSession session = request.getSession();
		String pageIndex = request.getParameter("pageIndex");
		PaginationInfo pi = new PaginationInfo();
		if(Utils.isNull(pageIndex))pi.setCurrentPageNo(1);
		else pi.setCurrentPageNo(Integer.parseInt(pageIndex));
		pi.setPageSize(5);
		pi.setRecordCountPerPage(10);
		EgovMap in = new EgovMap();
		in.put("idx", session.getAttribute("UserLoginIdx"));
		in.put("first", pi.getFirstRecordIndex());
		in.put("record", pi.getRecordCountPerPage());
		pi.setTotalRecordCount((int)sampleDAO.select("selectMyScrapListCnt",in));
		model.addAttribute("list", sampleDAO.list("selectMyScrapList",in));
		model.addAttribute("pi", pi);
		return "user/scrapPop";
	}
	
	@RequestMapping("/deleteScrap.do")
	public String deleteScrap(HttpServletRequest request){
		String idx = request.getParameter("idx");
		sampleDAO.delete("deletScrap" , idx);
		return "redirect:scrapPop.do";
	}

}
