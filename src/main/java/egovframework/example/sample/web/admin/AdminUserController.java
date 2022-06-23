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
@RequestMapping("/admin/user")
public class AdminUserController {
	
	@Resource(name = "fileProperties")
	private Properties fileProperties;

	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;

	
	@RequestMapping("/userList.do")
	public String userList(HttpServletRequest request , Model model){
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
		model.addAttribute("list", sampleDAO.list("selectUserList" , in));
		pi.setTotalRecordCount((int)sampleDAO.select("selectUserListCnt" , in));
		model.addAttribute("pi", pi);
		return "admin/userList";
	}
	
}
