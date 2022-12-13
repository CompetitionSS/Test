package pcs.css.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.CommentDTO;
import pcs.css.dto.NoticeDTO;
import pcs.css.persistance.mapper.INoticeMapper;
import pcs.css.service.INoticeService;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service("NoticeService")
public class NoticeService implements INoticeService {


    private final INoticeMapper noticeMapper;

    @Override
    public int noticeCount(NoticeDTO nDTO) throws Exception{
        log.info(this.getClass().getName()+".count start!!");

        return noticeMapper.noticeCount(nDTO);
    }
    @Override
    public int reviewCount(NoticeDTO nDTO) throws Exception{
        log.info(this.getClass().getName()+".count start!!");

        return noticeMapper.reviewCount(nDTO);
    }
    @Transactional
    @Override
    public void commentUpdate(CommentDTO cDTO) throws Exception {
        log.info("되는거맞제?");
         noticeMapper.commentUpdate(cDTO);
    }

    @Override
    public CommentDTO commentcheck(CommentDTO cDTO) throws Exception {
        return noticeMapper.commentcheck(cDTO);
    }

    @Override
    public void deleteComment(CommentDTO cDTO) throws Exception {
       noticeMapper.deleteComment(cDTO);
    }

    @Override
    public int commentCount(CommentDTO nDTO) throws Exception {
        return noticeMapper.commentCount(nDTO);
    }

    @Override
    public String Reviewyn(NoticeDTO nDTO) throws Exception {
        return noticeMapper.Reviewyn(nDTO);
    }


    @Transactional
    @Override
    public List<NoticeDTO> getNoticeList(NoticeDTO nDTO) throws Exception {

        log.info(this.getClass().getName() + ".getNoticeList start!");

        return noticeMapper.getNoticeList(nDTO);

    }

    @Transactional
    @Override
    public List<NoticeDTO> getReviewList(NoticeDTO nDTO) throws Exception {

        log.info(this.getClass().getName() + ".getReviewList start!");

        return noticeMapper.getReviewList(nDTO);

    }
    @Transactional
    @Override
    public List<CommentDTO> getCommentsList(CommentDTO pDTO) throws Exception{
         log.info(this.getClass().getName() + ".getCommentsList start!");

         return noticeMapper.getCommentsList(pDTO);
    }

    @Transactional
    @Override
    public void InsertNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertNoticeInfo start!");

        noticeMapper.InsertNoticeInfo(pDTO);
    }



    @Transactional
    @Override
    public void InsertReviewInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertReviewInfo start!");

        noticeMapper.InsertReviewInfo(pDTO);
    }
    @Override
    public List<NoticeDTO> SearchList(NoticeDTO nDTO) throws Exception{

        return noticeMapper.SearchList(nDTO);
    }
    @Override
    public int SearchCount (NoticeDTO nDTO) throws Exception{

        return noticeMapper.SearchCount(nDTO);
    }

    @Transactional
    @Override
    public NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getNoticeInfo start!");

        // 상세보기 할때마다, 조회수 증가하기
        log.info("Update ReadCNT");
        noticeMapper.updateNoticeReadCnt(pDTO);

        return noticeMapper.getNoticeInfo(pDTO);

    }

    @Override
    public void InsertComment(CommentDTO cDTO)throws Exception{
        log.info(this.getClass().getName() + ".InsertComment start!");
        if(cDTO.getRef()==null){
            cDTO.setRef(String.valueOf(noticeMapper.commentCount(cDTO)));
            cDTO.setRef_rank("0");
        }
        noticeMapper.InsertComment(cDTO);
    }
    @Transactional
    @Override
    public void updateNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".updateNoticeInfo start!");

        noticeMapper.updateNoticeInfo(pDTO);

    }

    @Transactional
    @Override
    public void deleteNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".deleteNoticeInfo start!");

        noticeMapper.deleteNoticeInfo(pDTO);

    }

}
