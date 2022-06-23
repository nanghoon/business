package egovframework.example.sample.web.admin;

import java.io.File;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringEscapeUtils;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin/board")
public class AdminBoardController {
	
	@Resource(name = "fileProperties")
	private Properties fileProperties;

	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;

	
	@RequestMapping("/{linkCate}List.do")
	public String linkCateList(@PathVariable("linkCate") String linkCate , HttpServletRequest request , Model model){
		PaginationInfo pi = new PaginationInfo();
		String pageIndex = request.getParameter("pageIndex");
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
		model.addAttribute("linkList", sampleDAO.list("linkList" , in));
		pi.setTotalRecordCount((int)sampleDAO.select("linkListCnt" , in));
		model.addAttribute("pi", pi);
		model.addAttribute("category", linkCate);
		return "admin/linkList";
	}
	@RequestMapping("/{linkCate}Insert.do")
	public String linkCateInsert(@PathVariable("linkCate") String linkCate , Model model){
		model.addAttribute("category", linkCate);
		return "admin/linkInsert";
	}
	
	@ResponseBody
	@RequestMapping(value="/{linkCate}InsertProcess.do" ,produces = "application/json; charset=utf8")
	public String linkCateInsertProcess(@PathVariable("linkCate") String linkCate , MultipartHttpServletRequest request , Model model){
		String title = request.getParameter("title");
		MultipartFile logo = request.getFile("logo");
		String text = request.getParameter("text");
		String link = request.getParameter("link");
		String kind = request.getParameter("kind");
		String tag = request.getParameter("tag");
		JSONObject obj = new JSONObject();
		obj.put("result" , "fail");
		if(Utils.isNull(title)){
			obj.put("msg", "사이트명을 입력해주세요");
			return obj.toJSONString();
		}
		if(logo.isEmpty()){
			obj.put("msg", "로고 사진을 등록해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(text)){
			obj.put("msg", "내용을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(link)){
			obj.put("msg", "바로가기링크 URL을 입력해주세요");
			return obj.toJSONString();
		}
		String path = fileProperties.getProperty("file.photo.upload");
		File file = new File(path);
		if(!file.exists()){
			file.mkdirs();
		}
		String originNm = logo.getOriginalFilename();
		String logoNm =  UUID.randomUUID().toString().replaceAll("-", "") + originNm.substring(originNm.lastIndexOf("."));
		try {
			logo.transferTo(new File(path+logoNm));
		} catch (Exception e) {
			obj.put("msg", "파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요.");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		in.put("category", linkCate);
		in.put("title", title);
		in.put("logo", logoNm);
		in.put("text", text);
		in.put("link", link);
		in.put("kind", kind);
		int lidx = (int)sampleDAO.insert("insertLink" , in);
		if(!Utils.isNull(tag)){
			String[] tags = tag.split(",");
			for(int i=0; i<tags.length; i++){
				in = new EgovMap();
				tag = tags[i].trim();
				tag = tag.replaceAll("\\p{Z}","");
				if(tag.length() > 10){
					tag = tag.substring(0, 10);
				}
				in.put("tag", tag);
				EgovMap tagChk = (EgovMap)sampleDAO.select("tagChk",in);
				if(tagChk == null){ //같은 tag가 존재하지 않으면
					sampleDAO.insert("insertTag",in);
					in.put("tidx", (int)sampleDAO.select("tagLastNum"));
				}else{
					int tagNum = (int)sampleDAO.select("tagNum",in);
					in.put("tidx", tagNum);
				}
				in.put("lidx", lidx);
				// 태그 외래키 등록 
				EgovMap tagFkChk = (EgovMap)sampleDAO.select("tagFkChk",in);
				if(tagFkChk == null){
					sampleDAO.insert("tagFk",in); 
				}
			}
		}
		obj.put("result", "success");
		obj.put("msg", "완료되었습니다");
		return obj.toJSONString();
	}
	@RequestMapping("/{linkCate}Detail.do")
	public String linkCateDetail(@PathVariable("linkCate") String linkCate ,HttpServletRequest request, Model model){
		String idx = request.getParameter("idx");
		model.addAttribute("info", sampleDAO.select("linkDetail",idx));
		model.addAttribute("tagList", sampleDAO.list("tagListByLidx",idx));
		model.addAttribute("category", linkCate);
		model.addAttribute("repleList",sampleDAO.list("selectlinkRepleList",idx));
		return "admin/linkDetail";
	}
	@ResponseBody
	@RequestMapping(value="/repleAdminDelete.do", produces = "application/json; charset=utf8")
	public String qnaRepleDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String idx = ""+request.getParameter("idx");
		sampleDAO.delete("deleteReple" , idx);
		obj.put("result", result);
		return obj.toJSONString();
	}

	@ResponseBody
	@RequestMapping(value="/qnaRepleDelete.do", produces = "application/json; charset=utf8")
	public String repleDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String idx = ""+request.getParameter("idx");
		sampleDAO.delete("deleteqnaReple" , idx);
		obj.put("result", result);
		return obj.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/{linkCate}UpdateProcess.do" ,produces = "application/json; charset=utf8")
	public String linkCateUpdateProcess(@PathVariable("linkCate") String linkCate , MultipartHttpServletRequest request , Model model){
		String idx = request.getParameter("idx");
		String title = request.getParameter("title");
		MultipartFile logo = request.getFile("logo");
		String text = request.getParameter("text");
		String link = request.getParameter("link");
		String kind = request.getParameter("kind");
		String tag = request.getParameter("tag");
		String view = request.getParameter("view");
		String click = request.getParameter("click");
		JSONObject obj = new JSONObject();
		obj.put("result" , "fail");
		if(Utils.isNull(title)){
			obj.put("msg", "사이트명을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(text)){
			obj.put("msg", "내용을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(link)){
			obj.put("msg", "바로가기링크 URL을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(view)){
			obj.put("msg", "조회수를 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(click)){
			obj.put("msg", "링크클릭횟수를 입력해주세요");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		if(!logo.isEmpty()){
			String path = fileProperties.getProperty("file.photo.upload");
			File file = new File(path);
			if(!file.exists()){
				file.mkdirs();
			}
			String originNm = logo.getOriginalFilename();
			String logoNm =  UUID.randomUUID().toString().replaceAll("-", "") + originNm.substring(originNm.lastIndexOf("."));
			try {
				logo.transferTo(new File(path+logoNm));
				in.put("logo", logoNm);
			} catch (Exception e) {
				obj.put("msg", "파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요.");
				return obj.toJSONString();
			}
		}
		in.put("category", linkCate);
		in.put("title", title);
		in.put("text", text);
		in.put("link", link);
		in.put("kind", kind);
		in.put("view", view);
		in.put("click", click);
		in.put("idx", idx);
		//int lidx = (int)sampleDAO.insert("insertLink" , in);
		sampleDAO.update("updateLink",in);
		if(!Utils.isNull(tag)){
			sampleDAO.delete("deleteTagFk",idx);
			String[] tags = tag.split(",");
			for(int i=0; i<tags.length; i++){
				in = new EgovMap();
				tag = tags[i].trim();
				tag = tag.replaceAll("\\p{Z}","");
				if(tag.length() > 10){
					tag = tag.substring(0, 10);
				}
				in.put("tag", tag);
				EgovMap tagChk = (EgovMap)sampleDAO.select("tagChk",in);
				if(tagChk == null){ //같은 tag가 존재하지 않으면
					sampleDAO.insert("insertTag",in);
					in.put("tidx", (int)sampleDAO.select("tagLastNum"));
				}else{
					int tagNum = (int)sampleDAO.select("tagNum",in);
					in.put("tidx", tagNum);
				}
				in.put("lidx", idx);
				// 태그 외래키 등록 
				EgovMap tagFkChk = (EgovMap)sampleDAO.select("tagFkChk",in);
				if(tagFkChk == null){
					sampleDAO.insert("tagFk",in); 
				}
			}
		}else{
			sampleDAO.delete("deleteTagFk",idx);
		}
		obj.put("result", "success");
		obj.put("msg", " 완료되었습니다");
		return obj.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/linkDelete.do" , produces = "application/json; charset=utf8")
	public String linkDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		//게시글 삭제처리 
		String delList = ""+request.getParameter("delArray");
		String[] delArray = delList.split("-");
		if(delArray != null && delArray.length > 0){
			for(int i=0; i<delArray.length; i++){
				sampleDAO.delete("deleteLink" , delArray[i]);
				sampleDAO.delete("deleteTagFk",delArray[i]);
				sampleDAO.delete("deletelinkRepleByGroupIdx" , delArray[i]);
			}
			result = "success";
		}else{
			result = "nothing";
		}
		obj.put("result", result);
		return obj.toJSONString();
	}
	
	@RequestMapping("/notice.do")
	public String notice(HttpServletRequest request , Model model){
		String pageIndex = request.getParameter("pageIndex");
		PaginationInfo pi = new PaginationInfo();
		if(pageIndex == null || pageIndex.equals("")){
			pi.setCurrentPageNo(1);
		}else{
			pi.setCurrentPageNo(Integer.parseInt(pageIndex));
		}
		pi.setRecordCountPerPage(15);
		pi.setPageSize(10);
		EgovMap in = new EgovMap();
		in.put("first", pi.getFirstRecordIndex());
		in.put("record", pi.getRecordCountPerPage());
		List<EgovMap> memberList = (List<EgovMap>)sampleDAO.list("selectNoticeMemberList", in );
		pi.setTotalRecordCount((int)sampleDAO.select("selectNoticeMemberListCnt" , in));
		model.addAttribute("pi",pi);
		model.addAttribute("noticeMemberList",memberList);
		return"admin/notice";
	}
	@RequestMapping("/noticeDetail.do")
	public String noticeDetail(HttpServletRequest request , Model model){
		String idx = request.getParameter("idx");
		model.addAttribute("info" , sampleDAO.select("selectNoticeDetail",idx));
		return"admin/noticeDetail";
	}
	@RequestMapping("/noticeInsert.do")
	public String noticeInsert(){
		return"admin/noticeInsert";
	}
	@ResponseBody
	@RequestMapping(value="/noticeInsertProcess.do" , produces="application/json; charset=utf8")
	public String noticeInsertProcess(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		obj.put("result" , "fail");
		String title = request.getParameter("title");
		String text = request.getParameter("text");
		String top = request.getParameter("top");
		String right = request.getParameter("right");
		if(Utils.isNull(title)){
			obj.put("msg", "제목을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(text)){
			obj.put("msg", "내용을 입력해주세요");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		in.put("title", title);
		in.put("text", text);
		in.put("top", top);
		in.put("right", right);
		sampleDAO.insert("insertNoticeMember",in);
		obj.put("result", "success");
		obj.put("msg", "완료되었습니다");
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/noticeUpdateProcess.do" , produces="application/json; charset=utf8")
	public String noticeUpdateProcess(HttpServletRequest request , Model model){
		String idx = request.getParameter("idx");
		String title = request.getParameter("title");
		String text = request.getParameter("text");
		String top = request.getParameter("top");
		String rightYn = request.getParameter("rightYn");
		String view = request.getParameter("view");
		JSONObject obj = new JSONObject();
		obj.put("result" , "fail");
		if(Utils.isNull(title)){
			obj.put("msg", "제목을 입력해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(text)){
			obj.put("msg", "내용을 입력해주세요");
			return obj.toJSONString();
		}

		if(Utils.isNull(view)){
			obj.put("msg", "조회수를 입력해주세요");
			return obj.toJSONString();
		}

		EgovMap in = new EgovMap();
		in.put("title", title);
		in.put("text", text);
		in.put("top", top);
		in.put("rightYn", rightYn);
		in.put("view", view);
		in.put("idx", idx);
		sampleDAO.update("noticeUpdate",in);
		obj.put("result", "success");
		obj.put("msg", " 완료되었습니다");
		return obj.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeDelete.do" , produces = "application/json; charset=utf8")
	public String noticeDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String delList = ""+request.getParameter("delArray");
		String[] delArray = delList.split("-");
		if(delArray != null && delArray.length > 0){
			for(int i=0; i<delArray.length; i++){
				sampleDAO.delete("deleteNotice" , delArray[i]);
			}
			result = "success";
		}else{
			result = "nothing";
		}
		obj.put("result", result);
		return obj.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value="/{linkCate}DetailDelete.do", produces = "application/json; charset=utf8")
	public String linkCateDetailDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String idx = ""+request.getParameter("idx");
		sampleDAO.delete("deleteLink" , idx);
		sampleDAO.delete("deletelinkRepleByGroupIdx" , idx);
		obj.put("result", result);
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/noticeDetailDelete.do", produces = "application/json; charset=utf8")
	public String noticeDetailDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String idx = request.getParameter("idx");
		sampleDAO.delete("deleteNotice" , idx);
		obj.put("result", result);
		return obj.toJSONString();
	}
	@RequestMapping("/qnaAdmin.do")
	public String qnaAdmin(HttpServletRequest request , Model model){
		String category = request.getParameter("category");
		String pageIndex = request.getParameter("pageIndex");
		PaginationInfo pi = new PaginationInfo();
		if(pageIndex == null || pageIndex.equals("")){
			pi.setCurrentPageNo(1);
		}else{
			pi.setCurrentPageNo(Integer.parseInt(pageIndex));
		}
		pi.setRecordCountPerPage(15);
		pi.setPageSize(10);
		EgovMap in = new EgovMap();
		in.put("first", pi.getFirstRecordIndex());
		in.put("record", pi.getRecordCountPerPage());
		in.put("category", category);
		List<EgovMap> memberList = (List<EgovMap>)sampleDAO.list("selectqnaAdminList", in );
		pi.setTotalRecordCount((int)sampleDAO.select("selectqnaAdminListCnt" , in));
		model.addAttribute("pi",pi);
		model.addAttribute("category",category);
		model.addAttribute("qnaAdminMemberList",memberList);
		return"Qna/qnaAdmin";
	}
	@RequestMapping("/qnaAdminDetail.do")
	public String qnaAdminDetail(HttpServletRequest request , Model model){
		String idx =request.getParameter("idx");
		EgovMap info = (EgovMap)sampleDAO.select("selectQnaAdminDetail",idx);
		model.addAttribute("qnaAdminDetail",info);
		model.addAttribute("text", StringEscapeUtils.unescapeHtml3(info.get("text")+""));
		model.addAttribute("repleList",sampleDAO.list("selectQnaRepleList",idx));
		return"Qna/qnaAdminDetail";
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaAdminUpdateProcess" , produces="application/json; charset=utf8")
	public String qnaAdminUpdateProcess(HttpServletRequest request , Model model){
		String idx = request.getParameter("idx");
		String reple = request.getParameter("reple");
		JSONObject obj = new JSONObject();
		obj.put("result", "fail");
		if(Utils.isNull(reple)){
			obj.put("msg", "답변을 입력해주세요");
			return obj.toJSONString();
		} 	
		EgovMap in = new EgovMap();
		in.put("idx", idx);
		in.put("reple", reple);
		in.put("ridx", -1);
		sampleDAO.insert("insertQnaReple",in);
		obj.put("result", "success");
		obj.put("msg", "완료되었습니다.");
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/qnaAdminDelete.do" , produces = "application/json; charset=utf8")
	public String qnaAdminDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String delList = ""+request.getParameter("delArray");
		String[] delArray = delList.split("-");
		if(delArray != null && delArray.length > 0){
			for(int i=0; i<delArray.length; i++){
				sampleDAO.delete("deleteQnaAdmin" , delArray[i]);
				sampleDAO.delete("deleteQnaRepleByGroupIdx" , delArray[i]);
			}
			result = "success";
		}else{
			result = "nothing";
		}
		obj.put("result", result);
		return obj.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/qnaAdminDetailDelete.do", produces = "application/json; charset=utf8")
	public String qnaAdminDetailDelete(HttpServletRequest request){
		JSONObject obj = new JSONObject();
		String result = "success";
		String idx = request.getParameter("idx");
		sampleDAO.delete("deleteQnaAdmin" , idx);
		sampleDAO.delete("deleteQnaRepleByGroupIdx" , idx);
		obj.put("result", result);
		return obj.toJSONString();
	}
	@RequestMapping("/topNoti.do")
	public String topNoti(Model model){
		model.addAttribute("topNoti", sampleDAO.select("selectGuideByKind" , "6"));
		return "admin/topNoti";
	}
	
	@ResponseBody
	@RequestMapping(value="/topNotiInsertProcess.do" , produces ="application/json; charset=utf8")
	public String topNotiInsertProcess(HttpServletRequest request){
		String idx = request.getParameter("idx");
		String text= request.getParameter("text");
		EgovMap in =new EgovMap();
		in.put("idx", idx);
		in.put("text", text);
		sampleDAO.update("updateGuideText" , in);
		JSONObject obj = new JSONObject();
		obj.put("msg", "완료되었습니다.");
		obj.put("result", "success");
		return obj.toJSONString();
	}
	
}
