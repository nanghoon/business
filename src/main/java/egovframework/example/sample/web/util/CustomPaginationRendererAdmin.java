package egovframework.example.sample.web.util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class CustomPaginationRendererAdmin extends AbstractPaginationRenderer{
	
	public CustomPaginationRendererAdmin() {
		firstPageLabel = "<li class=\"paginate_button previous\"><a href=\"#\" onclick=\"{0}({1}); return false;\">처음</a></li>"; 
		previousPageLabel = "<li class=\"paginate_button previous\"><a href=\"#\" onclick=\"{0}({1}); return false;\">이전</a></li>";
		currentPageLabel = "<li class=\"paginate_button active\"><a href=\"#\" onclick=\"{0}({1}); return false;\">{0}</a></li>";
		otherPageLabel = "<li class=\"paginate_button\"><a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></li>";
		nextPageLabel = "<li class=\"paginate_button next\"><a href=\"#\" onclick=\"{0}({1}); return false;\">다음</a></li>";
		lastPageLabel = "<li class=\"paginate_button next\"><a href=\"#\" onclick=\"{0}({1}); return false;\">마지막</a></li>";
		
	}
}
