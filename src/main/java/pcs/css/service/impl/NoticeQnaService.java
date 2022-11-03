package pcs.css.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.NoticeQnaDTO;
import pcs.css.persistance.mapper.INoticeQnaMapper;
import pcs.css.service.INoticeQnaService;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service("NoticeQnaService")
public class NoticeQnaService implements INoticeQnaService {


    private final INoticeQnaMapper noticeQnaMapper;

    @Transactional
    @Override
    public List<NoticeQnaDTO> getNoticeQnaList() throws Exception {

        log.info(this.getClass().getName() + ".getNoticeQnaList start!");

        return noticeQnaMapper.getNoticeQnaList();

    }


    @Transactional
    @Override
    public void InsertNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertNoticeQnaInfo start!");

        noticeQnaMapper.InsertNoticeQnaInfo(pDTO);
    }

    @Transactional
    @Override
    public NoticeQnaDTO getNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getNoticeQnaInfo start!");

        // 상세보기 할때마다, 조회수 증가하기
        log.info("Update ReadCNT");
        noticeQnaMapper.updateNoticeQnaReadCnt(pDTO);

        return noticeQnaMapper.getNoticeQnaInfo(pDTO);

    }

    @Transactional
    @Override
    public void updateNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".updateNoticeQnaInfo start!");

        noticeQnaMapper.updateNoticeQnaInfo(pDTO);

    }

    @Transactional
    @Override
    public void deleteNoticeQnaInfo(NoticeQnaDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".deleteNoticeQnaInfo start!");

        noticeQnaMapper.deleteNoticeQnaInfo(pDTO);

    }

}
