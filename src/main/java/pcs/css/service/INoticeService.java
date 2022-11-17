package pcs.css.service;

import pcs.css.dto.CommentDTO;
import pcs.css.dto.MainDTO;
import pcs.css.dto.NoticeDTO;
import pcs.css.dto.PageDTO;

import java.util.List;

public interface INoticeService {

    List<NoticeDTO> getNoticeList(NoticeDTO nDTO) throws Exception;
    List<NoticeDTO> getReviewList(NoticeDTO nDTO) throws Exception;
    List<CommentDTO> getCommentsList(NoticeDTO pDTO) throws Exception;

    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;
    void InsertReviewInfo(NoticeDTO pDTO) throws Exception;

    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

    void InsertComment(CommentDTO cDTO)throws Exception;

    void updateNoticeInfo(NoticeDTO pDTO) throws Exception;

    void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;

    int noticeCount(NoticeDTO nDTO) throws  Exception;
    int reviewCount(NoticeDTO nDTO) throws  Exception;
}
