package egovframework.example.sample.web.admin;

import java.io.File;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.example.sample.web.util.Utils;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
@RequestMapping("/admin/banner")
public class AdminBannerController {
	
	@Resource(name = "sampleDAO")
	private SampleDAO sampleDAO;
	
	@Resource(name = "fileProperties")
	private Properties fileProperties;

	@RequestMapping("/banner.do")
	public String banner(Model model){
		for(int i=1; i<10; i++){
			if(i < 5)model.addAttribute("rightBanner"+i, sampleDAO.select("selectRightBannerByOrd" , i));
			model.addAttribute("topBanner"+i, sampleDAO.select("selectTopBannerByOrd" ,i));
		}
		
		return "admin/banner";
	}
	
	@ResponseBody
	@RequestMapping(value="/bannerInsert.do" , produces = "application/json; charset=utf8")
	public String bannerInsert(MultipartHttpServletRequest request){
		String location  = request.getParameter("location"); // 0 상단배너 , 1 우측배너 
		String ordNum = request.getParameter("ordNum"); // 배너 순서 
		String link = request.getParameter("link");
		String imgNm = request.getParameter("originBanner");// 기존 배너가 등록되어있는지 체크 
		MultipartFile file =request.getFile("file");
		JSONObject obj = new JSONObject();
		obj.put("result" , "fail");
		if(Utils.isNull(imgNm) && file.isEmpty()){
			obj.put("msg", "배너 사진을 등록해주세요");
			return obj.toJSONString();
		}
		if(Utils.isNull(link)){
			obj.put("msg", "연결할 링크를 입력해주세요");
			return obj.toJSONString();
		}
		EgovMap in = new EgovMap();
		if(!file.isEmpty()){
			String path = fileProperties.getProperty("file.banner.upload");
			File filechk = new File(path);
			if(!filechk.exists()){
				filechk.mkdirs();
			}
			String originNm = file.getOriginalFilename();
			imgNm =  UUID.randomUUID().toString().replaceAll("-", "") + originNm.substring(originNm.lastIndexOf("."));
			try {
				file.transferTo(new File(path+imgNm));
			} catch (Exception e) {
				obj.put("msg", "파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요.");
				return obj.toJSONString();
			}
		}
		in.put("location", location);
		in.put("ordNum", ordNum);
		in.put("imgNm", imgNm);
		in.put("url", link);
		EgovMap info = (EgovMap)sampleDAO.select("selectBannerLimit1",in);
		if(info == null){
			sampleDAO.insert("insertBanner" , in);
		}else{
			sampleDAO.update("updateBanner", in);
		}
		obj.put("result", "success");
		obj.put("msg" , "배너가 등록되었습니다");
		return obj.toJSONString();
	}
}
