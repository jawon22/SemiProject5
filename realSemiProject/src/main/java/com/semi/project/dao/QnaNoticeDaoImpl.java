package com.semi.project.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.semi.project.dto.AttachmentDto;
import com.semi.project.dto.BoardDto;
import com.semi.project.dto.QnaNoticeDto;
import com.semi.project.mapper.AttachmentMapper;
import com.semi.project.mapper.QnaNoticeListMapper;
import com.semi.project.mapper.QnaNoticeMapper;
import com.semi.project.vo.PaginationVO;

@Repository
public class QnaNoticeDaoImpl implements QnaNoticeDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AttachmentMapper attachmentMapper;

	@Autowired
	private QnaNoticeMapper qnaNoticeMapper;
	
	@Autowired
	private QnaNoticeListMapper qnaNoticeListMapper;
	
	@Override
	public int sequence() {
		String sql = "select qnanotice_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(QnaNoticeDto qnaNoticeDto) {
		String sql = "insert into qnanotice("
				+ "qnanotice_no, qnanotice_title, qnanotice_content, member_id, "
				+ "qnanotice_type, qnanotice_group, qnanotice_parent, qnanotice_depth, qnanotice_secret"
				+ ") values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				qnaNoticeDto.getQnaNoticeNo(), qnaNoticeDto.getQnaNoticeTitle(),
				qnaNoticeDto.getQnaNoticeContent(), qnaNoticeDto.getMemberId(),
				qnaNoticeDto.getQnaNoticeType(), qnaNoticeDto.getQnaNoticeGroup(), 
				qnaNoticeDto.getQnaNoticeParent(), qnaNoticeDto.getQnaNoticeDepth(),
				qnaNoticeDto.getQnaNoticeSecret()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//썸머노트 파일첨부
	@Override
	public void connect(int qnaNoticeNo, int attachmentNo) {
	    String sql = "insert into qna_attach values(?, ?)";
	    Object[] data = {qnaNoticeNo, attachmentNo};
	    jdbcTemplate.update(sql, data);
	}
	
	
	
	@Override
	public QnaNoticeDto selectOne(int qnaNoticeNo) {
		String sql = "select q.*, qa.attachment_no from "
				+ "qnanotice q left outer join qna_attach qa "
				+ "on q.qnanotice_no = qa.qnanotice_no "
				+ "where q.qnanotice_no = ?";
		Object[] data = {qnaNoticeNo};
		List<QnaNoticeDto> list = jdbcTemplate.query(sql, qnaNoticeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	
	//list 상단에 나오는 공지글(5개까지)
	@Override
	public List<QnaNoticeDto> selectNoticeListTop5() {
		String sql = "select * from (select rownum rn, TMP.* from ("
				+ "select * from qnanotice_list "
				+ "where qnanotice_type = 1 "
				+ "order by qnanotice_no desc) TMP ) where rn between 1 and 5";
		return jdbcTemplate.query(sql, qnaNoticeListMapper);
	}
	
	//공지글 전체 나오게
	@Override
	public List<QnaNoticeDto> selectNoticeListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select * from (select rownum rn, TMP.* from ("
					+ "select * from qnanotice_list "
					+ "where instr ("+vo.getType()+", ?) > 0 "
					+ "and qnanotice_type = 1 "
					+ "order by qnanotice_no desc) TMP ) where rn between ? and ?";
			Object[] data = {
				vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()	
			};
		return jdbcTemplate.query(sql, qnaNoticeListMapper, data);
		}
		else {
			String sql = "select * from (select rownum rn, TMP.* from ("
					+ "select * from qnanotice_list "
					+ "where qnanotice_type = 1 "
					+ "order by qnanotice_no desc) TMP ) where rn between ? and ?";
			Object[] data = {
					vo.getStartRow(), vo.getFinishRow()	
			};
		return jdbcTemplate.query(sql, qnaNoticeListMapper, data);
		}
	}
	
	//qna목록 전체 나오게
	@Override
	public List<QnaNoticeDto> selectQnaListByPage(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select * from (select rownum rn, TMP.* from ("
					+ "select * from qnanotice_list "
					+ "where (instr("+vo.getType()+", ?) > 0) "
					+ "and (qnanotice_type = 2 or qnanotice_type = 3) "
					+ "connect by prior qnanotice_no = qnanotice_parent "
					+ "start with qnanotice_parent is null "
					+ "order siblings by qnanotice_group desc, "
					+ "qnanotice_no asc) TMP ) where rn between ? and ?";
			Object[] data = {
				vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()	
			};
		return jdbcTemplate.query(sql, qnaNoticeListMapper, data);
		}
		else {
			String sql = "select * from (select rownum rn, TMP.* from ("
					+ "select * from qnanotice_list "
					+ "where (qnanotice_type = 2 or qnanotice_type = 3) "
					+ "connect by prior qnanotice_no = qnanotice_parent "
					+ "start with qnanotice_parent is null "
					+ "order siblings by qnanotice_group desc, "
					+ "qnanotice_no asc) TMP ) where rn between ? and ?";
			Object[] data = {
					vo.getStartRow(), vo.getFinishRow()	
			};
		return jdbcTemplate.query(sql, qnaNoticeListMapper, data);
		}
	}

//	@Override
//	public int countQnaList(PaginationVO vo) {
//		if(vo.isSearch()) {
//			String sql = "select count(*) from qnanotice_list "
//					+ "where (instr("+vo.getType()+", ?) > 0) "
//					+ "and (qnanotice_type = 2 or qnanotice_type = 3)";
//			Object[] data = {vo.getKeyword()};
//			return jdbcTemplate.queryForObject(sql, int.class, data);
//		}
//		else {
//			String sql = "select count(*) from qnanotice_list "
//					+ "where (qnanotice_type = 2 or qnanotice_type = 3)";
//			return jdbcTemplate.queryForObject(sql, int.class);
//		}
//	}
//	
//	@Override
//	public int countNoticeList(PaginationVO vo) {
//		if(vo.isSearch()) {
//			String sql = "select count(*) from qnanotice_list "
//					+ "where instr("+vo.getType()+", ?) > 0 "
//					+ "and qnanotice_type = 1";
//			Object[] data = {vo.getKeyword()};
//			return jdbcTemplate.queryForObject(sql, int.class, data);
//		}
//		else {
//			String sql = "select count(*) from qnanotice_list "
//					+ "where qnanotice_type = 1 ";
//			return jdbcTemplate.queryForObject(sql, int.class);
//		}
//	}
	
	@Override
	public int countList(PaginationVO vo, String listType) {
        String sql = "";
		if(vo.isSearch()) {
			if ("qnalist".equals(listType)) {
				sql = "select count(*) from qnanotice_list "
						+ "where (instr("+vo.getType()+", ?) > 0) "
						+ "and (qnanotice_type = 2 or qnanotice_type = 3)";
				Object[] data = {vo.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class, data);
			}
			else if("noticelist".equals(listType)) {
				sql = "select count(*) from qnanotice_list "
						+ "where instr("+vo.getType()+", ?) > 0 "
						+ "and qnanotice_type = 1";
				Object[] data = {vo.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class, data);
			}
		}
		else {
			if ("qnalist".equals(listType)) {
				sql = "select count(*) from qnanotice_list "
						+ "where (qnanotice_type = 2 or qnanotice_type = 3)";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
			else if("noticelist".equals(listType)) {
				sql = "select count(*) from qnanotice_list "
						+ "where qnanotice_type = 1 ";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
		}
		return 0;
	}
	
	
	@Override
	public boolean deleteByAdmin(int qnaNoticeNo) {
		String sql = "delete qnaNotice where qnaNotice_no = ?";
		Object[] data = {qnaNoticeNo};
		return jdbcTemplate.update(sql, data)>0;
	}

	@Override
	public boolean delete(int qnaNoticeNo) {//삭제
		String sql = "delete qnaNotice where qnaNotice_no = ?";
		Object[] data = {qnaNoticeNo};
		return jdbcTemplate.update(sql, data)>0;
	}

	@Override
	public boolean edit(QnaNoticeDto qnaNoticeDto) {//수정
		String sql = "update qnaNotice set qnaNotice_secret=?, qnaNotice_title=?, qnaNotice_content=? "
				+ "where qnaNotice_no=?";
		Object[] data = {qnaNoticeDto.getQnaNoticeSecret(), qnaNoticeDto.getQnaNoticeTitle(), 
				qnaNoticeDto.getQnaNoticeContent(), qnaNoticeDto.getQnaNoticeNo()};
		return jdbcTemplate.update(sql, data)>0;
	}
//	public boolean edit(BoardDto boardDto) {//수정
//	String sql = "update board set board_category=?, board_title=?, board_content=? where board_no=?";
//	Object[] data= {boardDto.getBoardCategory(), boardDto.getBoardTitle(), boardDto.getBoardContent(), boardDto.getBoardNo()};
//	return jdbcTemplate.update(sql, data)>0;
//}


}
