package egovframework.example.sample.web.util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class CustomPaginationRendererUser extends AbstractPaginationRenderer{
	
	public CustomPaginationRendererUser() {
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"listbtn p w-button\">&lt;&lt;</a>"; 
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"listbtn p w-button\">&lt;</a>";
		currentPageLabel = "<a href=\"#\"  onclick=\"{0}({1}); return false;\" class=\"pagingbtn2 click w-button\">{0}</a> ";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"pagingbtn2 w-button\">{2}</a>";
		nextPageLabel = "<a href=\"#\"  onclick=\"{0}({1}); return false;\" class=\"listbtn p w-button\">&gt;</a> ";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"listbtn w-button\">&gt;&gt;</a>";
	}
}
