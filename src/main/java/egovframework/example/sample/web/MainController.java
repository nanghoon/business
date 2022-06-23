package egovframework.example.sample.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MainController {

	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	@RequestMapping("/topBanner.do")
	public String topBanner(Model model){
		model.addAttribute("topBannerList", sampleDAO.list("selectBannerList" , "0"));
		return "userFrame/topBanner";
	}
	@RequestMapping("/top.do")
	public String top(Model model){
		model.addAttribute("topNoti", sampleDAO.select("selectGuideByKind" , "6"));
		// 방문자수 카운팅 
		Date date = new Date();
		model.addAttribute("todayVisit", sampleDAO.select("selectVisitByDate" , new SimpleDateFormat("yyyy-MM-dd").format(date)));
		date.setDate(date.getDate() -1);
		model.addAttribute("yesterVisit", sampleDAO.select("selectVisitByDate" , new SimpleDateFormat("yyyy-MM-dd").format(date)));
		model.addAttribute("maxVisit", sampleDAO.select("selectMaxVisit"));
		model.addAttribute("sumVisit", sampleDAO.select("selectSumVisit"));
		model.addAttribute("allBoard", sampleDAO.select("selectAllBoardCnt"));
		model.addAttribute("alluser" , sampleDAO.select("selectAlluserCnt"));
		model.addAttribute("allreple",sampleDAO.select("selectAllrepleCnt"));
		return"userFrame/top";
	}
	@RequestMapping("/rightBanner.do")
	public String rightBanner(Model model){
		model.addAttribute("rightBanner" , sampleDAO.select("selectRightBannerByOrd" , "1")); // 우측 고정 배너 최대 4개
		model.addAttribute("rightBannerList" , sampleDAO.list("selectRightBannerList")); // 우측 고정 배너 최대 4개
		model.addAttribute("notice" , sampleDAO.select("noticeRightlimit_1")); // 우측 고정 공지사항
		model.addAttribute("recentUpdateLink", sampleDAO.list("selectRecentUpdateLink")); // 최근 업데이트 글
		model.addAttribute("NewLink", sampleDAO.list("selectNewLink")); // 신규 등록 글 
		// 방문자수 카운팅 
    	Date date = new Date();
		model.addAttribute("todayVisit", sampleDAO.select("selectVisitByDate" , new SimpleDateFormat("yyyy-MM-dd").format(date)));
		date.setDate(date.getDate() -1);
		model.addAttribute("yesterVisit", sampleDAO.select("selectVisitByDate" , new SimpleDateFormat("yyyy-MM-dd").format(date)));
		model.addAttribute("maxVisit", sampleDAO.select("selectMaxVisit"));
		model.addAttribute("sumVisit", sampleDAO.select("selectSumVisit"));
		model.addAttribute("allBoard", sampleDAO.select("selectAllBoardCnt"));
		model.addAttribute("alluser" , sampleDAO.select("selectAlluserCnt"));
		model.addAttribute("allreple",sampleDAO.select("selectAllrepleCnt"));
		return"userFrame/rightBanner";
	}
	
	@RequestMapping(value="/main.do")
	public String main(HttpServletRequest request , HttpServletResponse response , Model model){
		String ip = Utils.getClientIp(request);
		HttpSession session = request.getSession();
		if(session.getAttribute("ip") == null){// session에 해당 ip값이 존재 하지않을때 -> 방문자수 카운팅 
			session.setAttribute("ip", ip);
	    	Date date = new Date();
	    	String today = new SimpleDateFormat("yyyy-MM-dd").format(date);
	    	EgovMap info = (EgovMap)sampleDAO.select("selectVisitByDateMap" , today);
	    	if(info == null)sampleDAO.insert("insertVisitToday");
	    	else sampleDAO.update("updateVisitToday");
		}
		model.addAttribute("webtoon", sampleDAO.list("selectLinkBoardLimit18" , "webtoon"));
		model.addAttribute("torrent", sampleDAO.list("selectLinkBoardLimit18" , "torrent"));
		model.addAttribute("eat", sampleDAO.list("selectLinkBoardLimit18" , "eat"));
		model.addAttribute("review", sampleDAO.list("selectLinkBoardLimit18" , "review"));
		model.addAttribute("sport", sampleDAO.list("selectLinkBoardLimit18" , "sport"));
		model.addAttribute("adult", sampleDAO.list("selectLinkBoardLimit18" , "adult"));
		model.addAttribute("jadult", sampleDAO.list("selectLinkBoardLimit18" , "jadult"));
		model.addAttribute("wadult", sampleDAO.list("selectLinkBoardLimit18" , "wadult"));
		return"user/main";
	}

	@RequestMapping(value="/search.do")
	public String search(HttpServletRequest request , Model model){
		String searchAll = request.getParameter("searchAll");
		String category = request.getParameter("category");
		String kind = request.getParameter("kind");
		if(Utils.isNull(kind)) kind ="all";
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
		in.put("search", searchAll);
		in.put("category", category);
		in.put("kind", kind);
		List<EgovMap> list = (List<EgovMap>)sampleDAO.list("linkList" , in);
		for(int i=0; i<list.size(); i++){ //text의 tag를 없애고 출력
			list.get(i).put("text", StringEscapeUtils.unescapeHtml3(""+list.get(i).get("text")));
		}
		model.addAttribute("linkList", list);
		pi.setTotalRecordCount((int)sampleDAO.select("linkListCnt" , in));
		model.addAttribute("pi", pi);
		model.addAttribute("searchAll", searchAll);
		model.addAttribute("category", category);
		model.addAttribute("kind", kind);
		return "user/search";
	}
	
	@RequestMapping("/tagSearch.do")
	public String tagSearch(HttpServletRequest request , Model model){
		String search = request.getParameter("search");
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
		in.put("search",search);
		if(sampleDAO.select("tagNum" , search) != null){
			int tidx = (int)sampleDAO.select("tagNum" , search);
			in.put("idx", tidx);
		}else{
			in.put("idx", -1);
		}
		model.addAttribute("list", sampleDAO.list("selectTagSearchList" , in));
		pi.setTotalRecordCount((int)sampleDAO.select("selectTagSearchListCnt" , in));
		model.addAttribute("search", search);
		model.addAttribute("pi", pi);
		return "user/tagSearch";
	}
}
