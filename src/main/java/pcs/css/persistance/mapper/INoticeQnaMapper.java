package pcs.css.persistance.mapper;

import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.NoticeQnaDTO;

import java.util.List;


@Mapper
public interface INoticeQnaMapper {

    //Qna 리스트
    List<NoticeQnaDTO> getNoticeQnaList() throws Exception;

    //Qna 글 등록
    void InsertNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;

    //Qna 상세보기
    NoticeQnaDTO getNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;

    //Qna 조회수 업데이트
    void updateNoticeQnaReadCnt(NoticeQnaDTO pDTO) throws Exception;

    //Qna 글 수정
    void updateNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;

    // 글 삭제
    void deleteNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;


}
