package pcs.css.service;

import pcs.css.dto.CommentDTO;
import pcs.css.dto.MainDTO;
import pcs.css.dto.NoticeDTO;
import pcs.css.dto.PageDTO;

import java.util.List;

public interface INoticeService {

    List<NoticeDTO> getNoticeList(NoticeDTO nDTO) throws Exception;
    List<NoticeDTO> getReviewList(NoticeDTO nDTO) throws Exception;
    List<CommentDTO> getCommentsList(CommentDTO pDTO) throws Exception;

    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;
    void InsertReviewInfo(NoticeDTO pDTO) throws Exception;

    List<NoticeDTO> SearchList(NoticeDTO nDTO) throws Exception;

    int SearchCount(NoticeDTO nDTO) throws Exception;

    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;

    void InsertComment(CommentDTO cDTO)throws Exception;

    void updateNoticeInfo(NoticeDTO pDTO) throws Exception;

    void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;

    int noticeCount(NoticeDTO nDTO) throws  Exception;
    int reviewCount(NoticeDTO nDTO) throws  Exception;

    void commentUpdate(CommentDTO cDTO) throws Exception;

    CommentDTO commentcheck(CommentDTO cDTO) throws Exception;

    void deleteComment(CommentDTO cDTO) throws Exception;

    int commentCount(CommentDTO nDTO) throws Exception;
    String Reviewyn(NoticeDTO nDTO) throws Exception;
}
