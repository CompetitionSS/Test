package pcs.css.persistance.mapper;

import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.CommentDTO;
import pcs.css.dto.NoticeDTO;

import java.util.List;

@Mapper
public interface INoticeMapper {

    //게시판 리스트
    List<NoticeDTO> getNoticeList(NoticeDTO pDTO) throws Exception;
    List<NoticeDTO> getReviewList(NoticeDTO nDTO) throws Exception;
    //게시판 글 등록
    void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;
    void InsertReviewInfo(NoticeDTO pDTO) throws Exception;
    void InsertComment(CommentDTO cDTO) throws Exception;
    //게시판 상세보기
    NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;
    CommentDTO getCommentInfo(CommentDTO cDTO) throws Exception;
    //게시판 댓글보기
    List<CommentDTO> getCommentsList(CommentDTO pDTO) throws Exception;
    //게시판 조회수 업데이트
    void updateNoticeReadCnt(NoticeDTO pDTO) throws Exception;

    //게시판 글 수정
    void updateNoticeInfo(NoticeDTO pDTO) throws Exception;
    void commentUpdate(CommentDTO cDTO) throws Exception;
    //게시판 글 삭제
    void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;

    //게시판 페이징 카운트
    int noticeCount(NoticeDTO nDTO) throws Exception;
    int reviewCount(NoticeDTO nDTO) throws Exception;
    int commentCount(CommentDTO nDTO) throws Exception;

    CommentDTO commentcheck(CommentDTO cDTO) throws Exception;

    void deleteComment(CommentDTO cDTO) throws Exception;
}
