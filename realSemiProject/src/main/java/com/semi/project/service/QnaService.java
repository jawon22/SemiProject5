package com.semi.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.semi.project.dao.AttachmentDao;
import com.semi.project.dao.QnaNoticeDao;
import com.semi.project.dto.QnaNoticeDto;

@Service
public class QnaService {
	
	@Autowired
	QnaNoticeDao qnaNoticeDao;

	@Autowired
	AttachmentDao attachmentDao;
	
	public int write(QnaNoticeDto qnaDto, List<Integer> attachmentNo) {
		int qnaNoticeNo = qnaNoticeDao.sequence();
		
		qnaDto.setQnaNoticeNo(qnaNoticeNo);
		
		//qnaNoticeDao.insert(qnaDto);
		
		//글에 사용된 첨부파일번호(attachmentNo)와 글번호(qnaNoticeNo)를 연결
		if(attachmentNo != null) {
			for(int no : attachmentNo) {
				qnaNoticeDao.connect(qnaNoticeNo, no);
			}
		}		
		//System.out.print(qnaNoticeNo);
		return qnaNoticeNo;
	}
}	
	