package pcs.css.service;

import pcs.css.dto.NoticeQnaDTO;

import java.util.List;

public interface INoticeQnaService {

    List<NoticeQnaDTO> getNoticeQnaList() throws Exception;

    void InsertNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;

    NoticeQnaDTO getNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;

    void updateNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;

    void deleteNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception;


}
