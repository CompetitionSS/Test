package pcs.css.persistance.mapper;

import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.NoticeReviewDTO;

import java.util.List;

@Mapper
public interface INoticeReviewMapper {

    List<NoticeReviewDTO> getNoticeReviewList() throws Exception;

    void InsertNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;

    NoticeReviewDTO getNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;

    void updateNoticeReviewReadCnt(NoticeReviewDTO pDTO) throws Exception;

    void updateNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;

    void deleteNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception;

}
