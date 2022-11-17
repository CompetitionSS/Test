package pcs.css.service;

import pcs.css.dto.CommentDTO;
import pcs.css.dto.NoticeDTO;

import java.util.List;

public interface INoticeService {

    List<NoticeDTO> getNoticeList() throws Exception;
    List<NoticeDTO> getReviewList() throws Exception;
    List<CommentDTO> getCommentsList(NoticeDTO pDTO) throws Exception;

    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;
    void InsertReviewInfo(NoticeDTO pDTO) throws Exception;

    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

    void InsertComment(CommentDTO cDTO)throws Exception;

    void updateNoticeInfo(NoticeDTO pDTO) throws Exception;

    void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;
}
