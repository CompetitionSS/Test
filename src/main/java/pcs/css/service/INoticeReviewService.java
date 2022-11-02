package pcs.css.service;
import pcs.css.dto.NoticeReviewDTO;

import java.util.List;

public interface INoticeReviewService {

    List<NoticeReviewDTO> getNoticeReviewList() throws Exception;

    void InsertNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;

    NoticeReviewDTO getNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;

    void updateNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;

    void deleteNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;


}

