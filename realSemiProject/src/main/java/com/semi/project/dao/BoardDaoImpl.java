package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.BoardDto;
import com.semi.project.dto.BoardListDto;
import com.semi.project.dto.BoardReportDto;
import com.semi.project.dto.MainPageListDto;
import com.semi.project.dto.ReportDto;
import com.semi.project.dto.ReportListDto;
import com.semi.project.mapper.BoardDetailMapper;
import com.semi.project.mapper.BoardListMapper;
import com.semi.project.mapper.BoardTop10Mapper;
import com.semi.project.mapper.MainPageListMapper;
import com.semi.project.mapper.ReportListMapper;
import com.semi.project.vo.PaginationVO;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BoardListMapper boardListMapper;
	
	@Autowired
	 private BoardDetailMapper boardDetailMapper;
	
	@Autowired
	private ReportListMapper reportListMapper;
	
	@Autowired
	private BoardTop10Mapper boardTop10Mapper;
	
	
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
	public List<BoardListDto> selectList() {// 정보 리스트 조회
		String sql = "select * from board_list where board_category between 1 and 40 order by board_no asc";
		return jdbcTemplate.query(sql, boardListMapper);
	}

	@Override
	public List<BoardListDto> selectCommunityList() { // 커뮤니티 리스트 조회
		String sql = "select * from board_list where board_category between 41 and 42 order by board_no asc";
		return jdbcTemplate.query(sql, boardListMapper);
	}
	
	@Override
	public List<BoardListDto> selectFreeTop10() { // 자유 조회수 top10 조회
		String sql="SELECT * FROM ("
					+ "SELECT ROWNUM ranking, TMP.* FROM("
						+ "select * from board_list where board_category=42 order by board_readcount desc"
					+ ")TMP "
				+ ")where ranking between 1 and 10";
		
		return jdbcTemplate.query(sql, boardTop10Mapper);
	}
	
	@Override
	public List<BoardListDto> selectReviewTop10() { //후기 조회수 top10 조회
		String sql="SELECT * FROM ("
				+ "SELECT ROWNUM ranking, TMP.* FROM("
					+ "select * from board_list where board_category=41 order by board_readcount desc"
				+ ")TMP "
			+ ")where ranking between 1 and 10";
	
		return jdbcTemplate.query(sql, boardTop10Mapper);
	}
	
	
	
	@Override
	public boolean delete(int boardNo) {//삭제
		String sql = "delete board where board_no = ?";
		Object[] data = {boardNo};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	//게시판 번호와 첨부파일 번호 커넥트
	@Override
	public void connect(int boardNo, int attachmentNo) {
		String sql = "insert into board_attachment values(?, ?)";
		Object[] data = {boardNo, attachmentNo};
		jdbcTemplate.update(sql, data);
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
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where board_category between 1 and 40 order by board_ctime desc"
					+ ")TMP "
				+ ")where rn between ? and ?";
		return jdbcTemplate.query(sql, boardListMapper,start,end);
	}
	
	//검색을 안하고 계절만 선택했을때
	@Override
	public List<BoardListDto> selectListByPageAndWeather(int page, String weather) {
		
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where "
							+ "board_category between 1 and 40 and board_categoryweather = ?"
								+ " order by board_ctime desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	//검색을 안하고 지역만 선택했을때
	@Override
	public List<BoardListDto> selectListByPageAndArea(int page, String area) {
		
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 "
									+ "and board_area = ?"
								+ " order by board_ctime desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	//검색을 안하고 계절과 지역을 선택했을때
	@Override
	public List<BoardListDto> selectListByPageAndCategory(int page, String weather, String area) {
		
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 and"
							+ " board_categoryweather = ? AND board_area = ?"
								+ " order by board_ctime desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	//정보게시판 목록 페이지 검색 및 페이지 조회
	@Override
	public List<BoardListDto> selectListByPage(String type, String keyword, String weather, String area, int page) {
		
		int start = (page-1)*15 +1;
		int end = page*15;

		if(weather.equals("전체") && area.equals("전체") && !keyword.equals("")) {
			
			String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where instr("+type+",?) >0 and "
									+ "board_category between 1 and 40"
							+ " order by board_ctime desc"
						+ ")TMP "
					+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
			
		}
		else if(!weather.equals("전체") && area.equals("전체") && !keyword.equals("")) {
			String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where instr("+type+",?) >0 and "
									+ "board_category between 1 and 40 and board_categoryweather = ?"
							+ " order by board_ctime desc"
						+ ")TMP "
					+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,weather,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
		}
		else if(weather.equals("전체") && !area.equals("전체") && !keyword.equals("")) {
			String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where instr("+type+",?) >0 and "
									+ "board_category between 1 and 40 and board_area = ?"
							+ " order by board_ctime desc"
						+ ")TMP "
					+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,area,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
		}
		
		else {
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where instr("+type+",?) >0 and "
										+ "board_category between 1 and 40 and board_categoryweather = ? "
									+ "AND board_area = ?"
								+ " order by board_ctime desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {keyword,weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		}
	}
	
	
	//정보게시판 목록 조회(검색,페이지)(VO로 간단히)
	@Override
	public List<BoardListDto> selectListByPage(PaginationVO vo) {
		if(!vo.isSearch()) {
			return selectListByPage(vo.getPage());
		}
		else {
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
	}
	
	//조회수순 정렬
	
	@Override
	public List<BoardListDto> selectListByReadcount(int page) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where board_category between 1 and 40 order by board_readcount desc"
					+ ")TMP "
				+ ")where rn between ? and ?";
		return jdbcTemplate.query(sql, boardListMapper,start,end);
	}
	
	@Override
	public List<BoardListDto> selectListByReadcountWeather(int page, String weather) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where "
							+ "board_category between 1 and 40 and board_categoryweather = ?"
								+ " order by board_readcount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	@Override
	public List<BoardListDto> selectListByReadcountArea(int page, String area) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 "
									+ "and board_area = ?"
								+ " order by board_readcount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		
	}
	
	@Override
	public List<BoardListDto> selectListByReadcountCategory(int page, String weather, String area) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 and"
							+ " board_categoryweather = ? AND board_area = ?"
								+ " order by board_readcount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	@Override
	public List<BoardListDto> selectListByReadcountAll(String type, String keyword, String weather, String area, int page) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		if(weather.equals("전체") && area.equals("전체") && !keyword.equals("")) {
					
			String sql = "SELECT * FROM ("
							+ "SELECT ROWNUM rn, TMP.* FROM("
								+ "select * from board_list where instr("+type+",?) >0 and "
											+ "board_category between 1 and 40"
									+ " order by board_readcount desc"
								+ ")TMP "
							+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
			
		}
		else if(!weather.equals("전체") && area.equals("전체") && !keyword.equals("")) {
			String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where instr("+type+",?) >0 and "
									+ "board_category between 1 and 40 and board_categoryweather = ?"
							+ " order by board_readcount desc"
						+ ")TMP "
					+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,weather,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
		}
		else if(weather.equals("전체") && !area.equals("전체") && !keyword.equals("")) {
			String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where instr("+type+",?) >0 and "
									+ "board_category between 1 and 40 and board_area = ?"
							+ " order by board_readcount desc"
						+ ")TMP "
					+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,area,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
		}
		else {
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where instr("+type+",?) >0 and "
										+ "board_category between 1 and 40 and board_categoryweather = ? "
									+ "AND board_area = ?"
								+ " order by board_readcount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {keyword,weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		}
	}
	
	@Override
	public List<BoardListDto> selectListByReadcount(PaginationVO vo) {
		if(!vo.isSearch()) {
			return selectListByReadcount(vo.getPage());
		}
		else {
			// 계절과 지역이 전체일 경우
			if(vo.getWeather().equals("전체") && vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByReadcount(vo.getPage());
			}
			// 계절이 전체일 경우
			else if(vo.getWeather().equals("전체") && !vo.getArea().equals("전체")&& vo.getKeyword().equals("")) {
				return selectListByReadcountArea(vo.getPage(), vo.getArea());
			}
			// 지역이 전체일 경우
			else if(!vo.getWeather().equals("전체") && vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByReadcountWeather(vo.getPage(), vo.getWeather());
			}
			//계절과 지역이 전체가 아닌 경우
			else if(!vo.getWeather().equals("전체") && !vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByReadcountCategory(vo.getPage(), vo.getWeather(), vo.getArea());
			}
			//계절과 지역이 선택되고 검색 키워드가 있는 경우
			else {
				return selectListByReadcountAll(vo.getType(), vo.getKeyword(),vo.getWeather(),vo.getArea(), vo.getPage());
			}
		}
	}
	
	
	//좋아요순 정렬
	@Override
	public List<BoardListDto> selectListByLikecount(int page) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where board_category between 1 and 40 order by board_likecount desc"
					+ ")TMP "
				+ ")where rn between ? and ?";
		return jdbcTemplate.query(sql, boardListMapper,start,end);
	}
	
	@Override
	public List<BoardListDto> selectListByLikecountWeather(int page, String weather) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where "
							+ "board_category between 1 and 40 and board_categoryweather = ?"
								+ " order by board_likecount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	@Override
	public List<BoardListDto> selectListByLikecountArea(int page, String area) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 "
									+ "and board_area = ?"
								+ " order by board_likecount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		
	}
	
	@Override
	public List<BoardListDto> selectListByLikecountCategory(int page, String weather, String area) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category between 1 and 40 and"
							+ " board_categoryweather = ? AND board_area = ?"
								+ " order by board_likecount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	@Override
	public List<BoardListDto> selectListByLikecount(String type, String keyword, String weather, String area, int page) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		if(weather.equals("전체") && area.equals("전체") && !keyword.equals("")) {
			
			String sql = "SELECT * FROM ("
							+ "SELECT ROWNUM rn, TMP.* FROM("
								+ "select * from board_list where instr("+type+",?) >0 and "
											+ "board_category between 1 and 40"
									+ " order by board_likecount desc"
								+ ")TMP "
							+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
			
		}
		else if(!weather.equals("전체") && area.equals("전체") && !keyword.equals("")) {
			String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where instr("+type+",?) >0 and "
									+ "board_category between 1 and 40 and board_categoryweather = ?"
							+ " order by board_likecount desc"
						+ ")TMP "
					+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,weather,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
		}
		else if(weather.equals("전체") && !area.equals("전체") && !keyword.equals("")) {
			String sql = "SELECT * FROM ("
					+ "SELECT ROWNUM rn, TMP.* FROM("
						+ "select * from board_list where instr("+type+",?) >0 and "
									+ "board_category between 1 and 40 and board_area = ?"
							+ " order by board_likecount desc"
						+ ")TMP "
					+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,area,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
		}
		
		else {
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where instr("+type+",?) >0 and "
										+ "board_category between 1 and 40 and board_categoryweather = ? "
									+ "AND board_area = ?"
								+ " order by board_likecount desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {keyword,weather,area,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		}
	}
	
	@Override
	public List<BoardListDto> selectListByLikecount(PaginationVO vo) {
		if(!vo.isSearch()) {
			return selectListByLikecount(vo.getPage());
		}
		else {
			// 계절과 지역이 전체일 경우
			if(vo.getWeather().equals("전체") && vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByLikecount(vo.getPage());
			}
			// 계절이 전체일 경우
			else if(vo.getWeather().equals("전체") && !vo.getArea().equals("전체")&& vo.getKeyword().equals("")) {
				return selectListByLikecountArea(vo.getPage(), vo.getArea());
			}
			// 지역이 전체일 경우
			else if(!vo.getWeather().equals("전체") && vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByLikecountWeather(vo.getPage(), vo.getWeather());
			}
			//계절과 지역이 전체가 아닌 경우
			else if(!vo.getWeather().equals("전체") && !vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
				return selectListByLikecountCategory(vo.getPage(), vo.getWeather(), vo.getArea());
			}
			//계절과 지역이 선택되고 검색 키워드가 있는 경우
			else {
				return selectListByLikecount(vo.getType(), vo.getKeyword(),vo.getWeather(),vo.getArea(), vo.getPage());
			}
		}
	}
	
	
	 // 정보게시판 페이지네비게이터 갯수 새기
	@Override
	public int countList(PaginationVO vo) {
		String sql;
	    Object[] data;

	    if (!vo.isSearch()) {
	    	sql = "select count(*) from board_list where board_category between 1 and 40";
	    	data = new Object[0];
	    } 
	    else {
	    	if(vo.getWeather().equals("전체")&& vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
	    		sql="select count(*) from board_list where board_category between 1 and 40";
	    		data = new Object[0];
	    	}
//	    	else if(vo.getWeather().equals("전체")&& vo.getArea().equals("전체") && !vo.getKeyword().equals("")) {
//	    		sql="select count(*) from board_list where " + vo.getType() + " like ? " +
//	    				"and board_category between 1 and 40";
//	    		data = new Object[]{"%" + vo.getKeyword() + "%",0};
//	    	}
	    	
	    	else if(!vo.getWeather().equals("전체") && vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
	    		sql="select count(*) from board_list where board_categoryweather =? and board_category between 1 and 40";
	    		data = new Object[]{vo.getWeather()};
	    	}
//	    	else if(!vo.getWeather().equals("전체") && vo.getArea().equals("전체") && !vo.getKeyword().equals("")) {
//	    		sql="select count(*) from board_list where " + vo.getType() + " like ? " +
//	    				"and board_categoryweather =? and board_category between 1 and 40";
//	    		data = new Object[]{"%" + vo.getKeyword() + "%",vo.getWeather()};
//	    	}
	    	else if(vo.getWeather().equals("전체") && !vo.getArea().equals("전체") && vo.getKeyword().equals("")) {
	    		sql="select count(*) from board_list where board_area =? and board_category between 1 and 40";
	    		data = new Object[]{vo.getArea()};
	    	}
//	    	else if(vo.getWeather().equals("전체") && !vo.getArea().equals("전체") && !vo.getKeyword().equals("")) {
//	    		sql="select count(*) from board_list where " + vo.getType() + " like ? " +
//	    				"and board_area =? and board_category between 1 and 40";
//	    		data = new Object[]{"%" + vo.getKeyword() + "%",vo.getArea()};
//	    	}
	    	else {
	    	sql = "select count(*) from board_list where " + vo.getType() + " like ? " +
	    			"and board_categoryweather = ? and board_area = ? and board_category between 1 and 40";
	    	data = new Object[]{"%" + vo.getKeyword() + "%", vo.getWeather(), vo.getArea()};
	    	}
	    }
	    
	    return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	// 커뮤니티 목록 후기 페이지 조회(검색 , 페이지)
	@Override
	public List<BoardListDto> selectReviewListByPage(int page) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where board_category =41"
								+ " order by board_ctime desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
		
	}
	
	@Override
	public List<BoardListDto> selectReviewListSearchByPage(int page, String type, String keyword) {
		int start = (page-1)*15 +1;
		int end = page*15;
		
		String sql = "SELECT * FROM ("
						+ "SELECT ROWNUM rn, TMP.* FROM("
							+ "select * from board_list where instr("+type+",?) >0 and board_category =41"
								+ " order by board_ctime desc"
							+ ")TMP "
						+ ")WHERE rn BETWEEN ? AND ?";
		Object[] data = {keyword,start,end};
		return jdbcTemplate.query(sql, boardListMapper,data);
	}
	
	@Override
	public List<BoardListDto> selectReviewListSearchByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			return selectReviewListSearchByPage(vo.getPage(), vo.getType(), vo.getKeyword());
		}
		else return selectReviewListByPage(vo.getPage());
	}
	
	// 커뮤니티 목록 자유 페이지 조회(검색 , 페이지)
		@Override
		public List<BoardListDto> selectFreeListByPage(int page) {
			int start = (page-1)*15 +1;
			int end = page*15;
			
			String sql = "SELECT * FROM ("
							+ "SELECT ROWNUM rn, TMP.* FROM("
								+ "select * from board_list where board_category =42"
									+ " order by board_ctime desc"
								+ ")TMP "
							+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
			
		}
		
		@Override
		public List<BoardListDto> selectFreeListSearchByPage(int page, String type, String keyword) {
			int start = (page-1)*15 +1;
			int end = page*15;
			
			String sql = "SELECT * FROM ("
							+ "SELECT ROWNUM rn, TMP.* FROM("
								+ "select * from board_list where instr("+type+",?) >0 and board_category =42"
									+ " order by board_ctime desc"
								+ ")TMP "
							+ ")WHERE rn BETWEEN ? AND ?";
			Object[] data = {keyword,start,end};
			return jdbcTemplate.query(sql, boardListMapper,data);
		}
		
		@Override
		public List<BoardListDto> selectFreeListSearchByPage(PaginationVO vo) {
			if(vo.isSearch()) {
				return selectFreeListSearchByPage(vo.getPage(), vo.getType(), vo.getKeyword());
			}
			else return selectFreeListByPage(vo.getPage());
		}
	
	
	
	
	//커뮤니티 게시판 페이지네비게이터 갯수 (후기)
	@Override
	public int countCommunityReviewList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from board_list where instr("+vo.getType()+",?) >0 and board_category =41";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class,data);
		}
		else {
			String sql ="select count(*) from board_list where board_category =41";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	//커뮤니티 게시판 페이지네비게이터 갯수 (자유)
		@Override
		public int countCommunityFreeList(PaginationVO vo) {
			if(vo.isSearch()) {
				String sql = "select count(*) from board_list where instr("+vo.getType()+",?) >0 and board_category =42";
				Object[] data = {vo.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class,data);
			}
			else {
				String sql ="select count(*) from board_list where board_category =42";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
		}
	

	@Override
	public boolean readcountEdit(int boardNo) {
		String sql =  "update board set board_readcount=board_readcount+1 where board_no=?";
		Object[] data= {boardNo};
		return jdbcTemplate.update(sql, data)>0;
	}

	//마지막으로 쓴글 찾기
	@Override
	public Integer selectMax(String boardWriter) {
		String sql = "select max(board_no) from board "
				+ "where board_writer = ?";
		Object[] data = {boardWriter};
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}


	//신고 번호(시퀀스)
	@Override
	public int reportSequence() {
		String sql = "select report_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//신고 등록
	@Override
	public void insertReport(ReportDto reportDto) {
        String sql = "INSERT INTO report (report_no, report_reason) VALUES (?, ?)";
        Object[] data = { reportDto.getReportNo(), reportDto.getReportReason() };
        jdbcTemplate.update(sql, data);
    }
	
	//게시글 신고 등록
	@Override
	public void insertBoardReport(BoardReportDto boardReportDto) {
        String sql = "INSERT INTO board_report (report_no, board_no, member_id) VALUES (?, ?, ?)";
        Object[] data = {
            boardReportDto.getReportNo(),
            boardReportDto.getBoardNo(),
            boardReportDto.getMemberId()
        };
        jdbcTemplate.update(sql, data);
    }
	
	//신고 삭제
	@Override
	public boolean deleteReport(int ReportNo) {
		String sql = "delete report where report_no = ?";
		Object[] data = {ReportNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//신고 개수
	@Override
	public int countReportList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from report_list "
								+ "where instr(" + vo.getType() + ", ?) > 0 ";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, Integer.class,data);
		}else {
			String sql = "select count(*) from report_list";
			return jdbcTemplate.queryForObject(sql, Integer.class);
		}
	}
	
	//신고 목록
	@Override
	public List<ReportListDto> selectReportList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ( "
								+ "SELECT rownum rn, tmp.* FROM( "
									+ "SELECT * FROM report_list "
									+ "where instr(" + vo.getType() + ", ?) > 0  "
									+ "ORDER BY report_no desc "
								+ ") tmp"
							+ ") WHERE rn BETWEEN ? AND ?";
			Object[] data = {
					vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()
			};
			return jdbcTemplate.query(sql, reportListMapper, data);
		} else {
			String sql = "SELECT * FROM ( "
					+ "SELECT rownum rn, tmp.* FROM( "
					+ "SELECT * FROM report_list "
					+ "ORDER BY report_no desc"
					+ ") tmp"
					+ ") WHERE rn BETWEEN ? AND ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, reportListMapper, data);	
		}
	}

    // 첨부 파일 갯수(count) 조회
    @Override
    public int getAttachmentCount(int boardNo) {
        String sql = "SELECT COUNT(*) FROM board_attachment WHERE board_no = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, boardNo);
    }

    // 첫 번째 첨부 파일 번호(firstAttachmentNo) 조회
    @Override
    public int getFirstAttachmentNo(int boardNo) {
        String sql = "SELECT MIN(attachment_no) FROM board_attachment WHERE board_no = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, boardNo);
    }
	
    @Autowired
    private MainPageListMapper mainPageListMapper;
    
    //계절별 인기글
	@Override
	public List<MainPageListDto> selectListSeasonTop5() {
		String sql = "select * from (select rownum rnum, TMP.* from ( "
				+ "select * from ( select bl.*, row_number() "
				+ "over (partition by bl.board_no "
				+ "order by bl.attachment_no desc) as rn "
				+ "from mainpage_list bl where board_category between 9 and 40 "
				+ "order by board_readcount desc "
				+ ") ranked where rn = 1 )tmp) where rnum between 1 and 5";
		return jdbcTemplate.query(sql, mainPageListMapper);
	}

	@Override
	public boolean updateBoardReplyCount(int boardNo) {
			String sql = "update board set board_replycount = ("
					+ "select count(*) from reply where reply_origin = ?"
					+ ") "
					+ "where board_no=?";
			Object[] data = {boardNo, boardNo};
			return jdbcTemplate.update(sql, data)>0;
	}
	
	@Override
	public List<MainPageListDto> selectListAreaTop5() {
		String sql = "select * from (select rownum rnum, TMP.* from ( "
				+ "select * from ( select bl.*, row_number() "
				+ "over (partition by bl.board_no "
				+ "order by bl.attachment_no desc) as rn "
				+ "from mainpage_list bl where board_category between 2 and 8 "
				+ "order by board_readcount desc "
				+ ") ranked where rn = 1 )tmp) where rnum between 1 and 5";
		return jdbcTemplate.query(sql, mainPageListMapper);
	}
}
