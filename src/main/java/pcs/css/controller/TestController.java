package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import pcs.css.dto.CommentDTO;
import pcs.css.dto.NoticeDTO;
import pcs.css.service.INoticeService;
import pcs.css.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@Controller
public class TestController {
    @Resource(name = "NoticeService")
    private INoticeService noticeService;

    @GetMapping(value="test/ajaxtest")
    public String ajaxtest(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".ajaxtest start!");

        String msg = "";

        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 공지글번호(PK)
            log.info("nSeq : " + nSeq);
            NoticeDTO pDTO = new NoticeDTO();
            pDTO.setNotice_seq(nSeq);
            CommentDTO cDTO = new CommentDTO();
            cDTO.setNotice_seq(nSeq);
            // 공지사항 상세정보 가져오기
            NoticeDTO rDTO = noticeService.getNoticeInfo(pDTO);

            List<CommentDTO> cList = noticeService.getCommentsList(cDTO);

            if (rDTO == null) {
                rDTO = new NoticeDTO();

            }

            log.info("getNoticeInfo success!!!");

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);
            model.addAttribute("cList",cList);


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeInsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        log.info(this.getClass().getName() + ".ajaxtest end!");

        return "/test/ajaxtest";
    }

}
