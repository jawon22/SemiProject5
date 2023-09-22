package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.mapper.BoardDetailMapper;
import com.semi.project.mapper.BoardListMapper;
import com.semi.project.vo.PaginationVO;

@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	BoardListMapper boardListMapper;
	
	@Autowired
	BoardDetailMapper boardDetailMapper;
	
	@Override
	public int sequence() {
		String sql = "select board_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(BoardDto boardDto) {//등록
		String sql = "insert into board(board_no, board_category, board_writer, board_title, board_content ) values(?, ?, ?, ?, ?)";
		Object[] data = {boardDto.getBoardNo(), boardDto.getBoardCategory(), boardDto.getBoardWriter(),boardDto.getBoardTitle(), boardDto.getBoardContent()};
		
		jdbcTemplate.update(sql, data);
	}

	@Override
	public BoardDto selectOne(int boardNo) {//상세 조회
		String sql = "select * from board where board_no = ?";
		Object[] data = {boardNo};
		List<BoardDto> list = jdbcTemplate.query(sql, boardDetailMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<BoardListDto> selectList() {//리스트 조회
		String sql = "select * from board where board_category between 1 and 40 order by board_no asc";
		
		return jdbcTemplate.query(sql, boardListMapper);
	}

	@Override
	public boolean delete(int boardNo) {//삭제
		String sql = "delete board where board_no = ?";
		Object[] data = {boardNo};
		return jdbcTemplate.update(sql, data)>0;
	}

	@Override
	public boolean edit(BoardDto boardDto) {//수정
		String sql = "update board set board_category=?, board_title=?, board_content=? where board_no=?";
		Object[] data= {boardDto.getBoardCategory(), boardDto.getBoardTitle(), boardDto.getBoardContent(), boardDto.getBoardNo()};
		return jdbcTemplate.update(sql, data)>0;
	}

	// 정보게시판 목록 페이지 조회
	@Override
	public List<BoardListDto> selectListByPage(int page) {
		int start = (page-1)*10 +1;
		int end = page*10;
		
		String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where board_category between 1 and 40 order by board_no asc"
					+ ")TMP "
				+ ")where rn between ? and ?";
		return jdbcTemplate.query(sql, boardListMapper,start,end);
	}
	
	//검색을 안하고 계절만 선택했을때
	@Override
	public List<BoardListDto> selectListByPageAndWeather(int page, String weather) {
		int start = (page-1)*10 +1;
		int end = page*10;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where "
							+ "board_category between 1 and 40 and board_categoryweather = ?"
								+ " order by board_no asc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	//검색을 안하고 지역만 선택했을때
	@Override
	public List<BoardListDto> selectListByPageAndArea(int page, String area) {
		int start = (page-1)*10 +1;
		int end = page*10;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 "
									+ "and board_area = ?"
								+ " order by board_no asc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		
	}
	
	//검색을 안하고 계절과 지역을 선택했을때
	@Override
	public List<BoardListDto> selectListByPageAndCategory(int page, String weather, String area) {
		int start = (page-1)*10 +1;
		int end = page*10;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 and"
							+ " board_categoryweather = ? AND board_area = ?"
								+ " order by board_no asc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	//정보게시판 목록 페이지 검색 및 페이지 조회
	@Override
	public List<BoardListDto> selectListByPage(String type, String keyword, String weather, String area, int page) {
		int start = (page-1)*10 +1;
		int end = page*10;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where instr("+type+",?) >0 and "
										+ "board_category between 1 and 40 and board_categoryweather = ? "
									+ "AND board_area = ?"
								+ " order by board_no asc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {keyword,weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		
	}
	
	//정보게시판 목록 조회(검색,페이지)(VO로 간단히)
	@Override
	public List<BoardListDto> selectListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
				// 계절과 지역이 전체일 경우
			if(vo.getWeather().equals("전체") && vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByPage(vo.getPage());
			}
				// 계절이 전체일 경우
			else if(vo.getWeather().equals("전체") && !vo.getArea().equals("전체")&& vo.getKeyword().equals("")) {
				return selectListByPageAndArea(vo.getPage(), vo.getArea());
			}
				// 지역이 전체일 경우
			else if(!vo.getWeather().equals("전체") && vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByPageAndWeather(vo.getPage(), vo.getWeather());
			}
				//계절과 지역이 전체가 아닌 경우
			else if(!vo.getWeather().equals("전체") && !vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByPageAndCategory(vo.getPage(), vo.getWeather(), vo.getArea());
			}
				//계절과 지역이 선택되고 검색 키워드가 있는 경우
			else {
				return selectListByPage(vo.getType(), vo.getKeyword(),vo.getWeather(),vo.getArea(), vo.getPage());
			}
		}
		else return selectListByPage(vo.getPage());
	}

	@Override
	public int countList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from board_list where instr("+vo.getType()+",?)>0 "
							+ "and board_categoryweather = ? AND board_area = ?";
			
			Object[] data = {vo.getKeyword(),vo.getWeather(),vo.getArea()};
			return jdbcTemplate.queryForObject(sql, int.class,data);
		
		}
		else {
			String sql= "select count(*) from board";
			return jdbcTemplate.queryForObject(sql,int.class);
		}
	}



	

}
