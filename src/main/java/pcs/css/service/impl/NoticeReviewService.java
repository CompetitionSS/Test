package pcs.css.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.NoticeReviewDTO;
import pcs.css.persistance.mapper.INoticeReviewMapper;
import pcs.css.service.INoticeReviewService;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service("NoticeReviewService")
public class NoticeReviewService implements INoticeReviewService {


    private final INoticeReviewMapper noticeReviewMapper;

    @Transactional
    @Override
    public List<NoticeReviewDTO> getNoticeReviewList() throws Exception {

        log.info(this.getClass().getName() + ".getNoticeReviewList start!");

        return noticeReviewMapper.getNoticeReviewList();

    }


    @Transactional
    @Override
    public void InsertNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertNoticeReviewInfo start!");

        noticeReviewMapper.InsertNoticeReviewInfo(pDTO);
    }

    @Transactional
    @Override
    public NoticeReviewDTO getNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getNoticeReviewInfo start!");

        // 상세보기 할때마다, 조회수 증가하기
        log.info("Update ReadCNT");
        noticeReviewMapper.updateNoticeReviewReadCnt(pDTO);

        return noticeReviewMapper.getNoticeReviewInfo(pDTO);

    }

    @Transactional
    @Override
    public void updateNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".updateNoticeReviewInfo start!");

        noticeReviewMapper.updateNoticeReviewInfo(pDTO);

    }

    @Transactional
    @Override
    public void deleteNoticeReviewInfo(NoticeReviewDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".deleteNoticeReviewInfo start!");

        noticeReviewMapper.deleteNoticeReviewInfo(pDTO);

    }

}
