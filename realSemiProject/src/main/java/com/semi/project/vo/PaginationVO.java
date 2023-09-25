package com.semi.project.vo;

import lombok.Data;

@Data
public class PaginationVO {
	private String type, keyword; //검색 분류 및 키워드
	private String weather, area; // 카테고리 계절, 지역
	
	private int page =1; //현재 페이지 번호
	private int size =15; // 보여줄 게시글 수 ->기본값 10
	private int count; // 전체 글 수 (DB에서 구해와야하는 값)
	private int navigatorSize=10; // 하단 네비게이터 표시 개수(기본값 10)
	
	public boolean isSearch() {
		return type !=null && keyword !=null;
	}
	
	public int getBegin() {
		return (page-1)/navigatorSize*navigatorSize+1;
	}
	public int getEnd() {
		int end = getBegin()+navigatorSize-1;
		return Math.min(getPageCount(), end);
	}
	
	public boolean isFirst() {
		return getBegin()==1;
	}
	
	public String getPrevQueryString() {
		if(isSearch()) {
			return "page="+(getBegin()-1)+"&size="+size+"&weather="+weather+"&area="+area+
					"&type="+type+"&keyword="+keyword;
			}
		else {//목록
			return "page="+(getBegin()-1)+"&size="+size+"&weather="+weather+"&area="+area;
		}
	}
	
	public int getPageCount() {
		return (count-1)/size+1;
	}
	
	public boolean isLast() {
		return getEnd() >= getPageCount();
	}
	
	public String getNextQueryString() {
		if(isSearch()) {
			return "page="+(getEnd()+1)+"&size="+size+"&weather="+weather+"&area="+area+
					"&type="+type+"&keyword="+keyword;
			}
		else {//목록
			return "page="+(getEnd()+1)+"&weather="+weather+"&area="+area+"&size="+size;
		}
	}
	
	public String getQueryString(int page) {
		if(isSearch()) {
			return "page="+page+"&size="+size+"&weather="+weather+"&area="+area+
					"&type="+type+"&keyword="+keyword;
			}
		else {//목록
			return "page="+page+"&size="+size+"&weather="+weather+"&area="+area;
		}
	}
	
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	public int getFinishRow() {
		return page* size;
	}
	
	
	// 관리자가 보는 회원 목록
	public String getPrevQueryStringForMemberList() {
		if(isSearch()) { //검색
			return "page="+(getBegin() - 1)+"&type=" + type + "&keyword=" + keyword;
		}
		else { //목록
			return "page=" + (getBegin() - 1);
		}
	}
	public String getNextQueryStringForMemberList() {
		if(isSearch()) { //검색
			return "page="+(getEnd() + 1)+"&size=" + size +"&type=" + type + "&keyword=" + keyword;
		}
		else { //목록
			return "page=" + (getEnd() + 1)+ "&size=" + size;
		}		
	}
	public String getQueryStringForMemberList(int page) {
		if(isSearch()) { //검색
			return "page="+page+"&size=" + size +"&type=" + type + "&keyword=" + keyword;
		}
		else { //목록
			return "page=" + page+"&size=" + size;
		}		
	}
	
}
