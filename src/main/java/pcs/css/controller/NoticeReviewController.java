package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import pcs.css.dto.NoticeReviewDTO;
import pcs.css.service.INoticeReviewService;
import pcs.css.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class NoticeReviewController {

    /*

     * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
     */
    @Resource(name = "NoticeReviewService")
    private INoticeReviewService noticeReviewService;

    /**
     * GetMapping은 GET방식을 통해 접속되는 URL 호출에 대해 실행되는 함수로 설정함을 의미함
     * PostMapping은 POST방식을 통해 접속되는 URL 호출에 대해 실행되는 함수로 설정함을 의미함
     * GetMapping(value = "index") =>  GET방식을 통해 접속되는 URL이 index인 경우 아래 함수를 실행함
     */


    /**
     * 게시판 리스트 보여주기
     *
     * GetMapping(value = "notice/NoticeList") =>  GET방식을 통해 접속되는 URL이 notice/NoticeList인 경우 아래 함수를 실행함
     */
    @GetMapping(value = "noticeReview/NoticeReviewList")
    public String NoticeReviewList(ModelMap model) throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeReview start!");

        // 공지사항 리스트 가져오기
        List<NoticeReviewDTO> rList = noticeReviewService.getNoticeReviewList();

        if (rList == null) {
            rList = new ArrayList<>();

        }

        // 조회된 리스트 결과값 넣어주기
        model.addAttribute("rList", rList);

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeReviewList end!");
        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/noticeReview/NoticeReviewList";

    }


    @GetMapping(value = "noticeReview/NoticeReviewReg")
    public String NoticeReviewReg() {

        log.info(this.getClass().getName() + ".NoticeReviewReg start!");

        log.info(this.getClass().getName() + ".NoticeReviewReg end!");

        return "/noticeReview/NoticeReviewReg";
    }

    /**
     * 게시판 글 등록
     */
    @PostMapping(value = "noticeReview/NoticeReviewInsert")
    public String NoticeReviewInsert(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeReviewInsert start!");

        String msg = "";

        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String user_id = CmmUtil.nvl((String) session.getAttribute("SESSION_USER_ID"));
            String title = CmmUtil.nvl(request.getParameter("title")); // 제목
            String noticeYn = CmmUtil.nvl(request.getParameter("noticeYn")); // 공지글 여부
            String contents = CmmUtil.nvl(request.getParameter("contents")); // 내용


            log.info("user_id : " + user_id);
            log.info("title : " + title);
            log.info("noticeYn : " + noticeYn);
            log.info("contents : " + contents);

            NoticeReviewDTO pDTO = new NoticeReviewDTO();

            pDTO.setUser_id(user_id);
            pDTO.setTitle(title);
            pDTO.setNotice_yn(noticeYn);
            pDTO.setContents(contents);

            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             */
            noticeReviewService.InsertNoticeReviewInfo(pDTO);

            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeReviewInsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        return "/noticeReview/MsgToListReview";
    }

    /**
     * 게시판 상세보기
     */
    @GetMapping(value = "noticeReview/NoticeReviewInfo")
    public String NoticeReviewInfo(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeReviewInfo start!");

        String msg = "";

        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 공지글번호(PK)

            /*
             * ####################################################################################
             * 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
             * ####################################################################################
             */
            log.info("nSeq : " + nSeq);

            /*
             * 값 전달은 반드시 DTO 객체를 이용해서 처리함 전달 받은 값을 DTO 객체에 넣는다.
             */
            NoticeReviewDTO pDTO = new NoticeReviewDTO();
            pDTO.setNotice_seq(nSeq);

            // 공지사항 상세정보 가져오기
            NoticeReviewDTO rDTO = noticeReviewService.getNoticeReviewInfo(pDTO);

            if (rDTO == null) {
                rDTO = new NoticeReviewDTO();

            }

            log.info("getNoticeReviewInfo success!!!");

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeReviewInsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        log.info(this.getClass().getName() + ".NoticeReviewInfo end!");

        return "/noticeReview/NoticeReviewInfo";
    }

    /**
     * 게시판 수정 보기
     */
    @GetMapping(value = "noticeReview/NoticeReviewEditInfo")
    public String NoticeReviewEditInfo(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeReviewEditInfo start!");

        String msg = "";

        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 공지글번호(PK)

            log.info("nSeq : " + nSeq);

            NoticeReviewDTO pDTO = new NoticeReviewDTO();

            pDTO.setNotice_seq(nSeq);

            /*
             * ####################################################### 공지사항 수정정보 가져오기(상세보기
             * 쿼리와 동일하여, 같은 서비스 쿼리 사용함)
             * #######################################################
             */
            NoticeReviewDTO rDTO = noticeReviewService.getNoticeReviewInfo(pDTO);
//여기도
            if (rDTO == null) {
                rDTO = new NoticeReviewDTO();
//여기도
            }

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeReviewUpdate end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        log.info(this.getClass().getName() + ".NoticeReviewEditInfo end!");

        return "/noticeReview/NoticeReviewEditInfo";
    }

    /**
     * 게시판 글 수정
     */
    @PostMapping(value = "noticeReview/NoticeReviewUpdate")
    public String NoticeReviewUpdate(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeReviewUpdate start!");

        String msg = "";

        try {

            String user_id = CmmUtil.nvl((String) session.getAttribute("SESSION_USER_ID")); // 아이디
            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 글번호(PK)
            String title = CmmUtil.nvl(request.getParameter("title")); // 제목
            String noticeYn = CmmUtil.nvl(request.getParameter("noticeYn")); // 공지글 여부
            String contents = CmmUtil.nvl(request.getParameter("contents")); // 내용

            log.info("user_id : " + user_id);
            log.info("nSeq : " + nSeq);
            log.info("title : " + title);
            log.info("noticeYn : " + noticeYn);
            log.info("contents : " + contents);

            NoticeReviewDTO pDTO = new NoticeReviewDTO();

            pDTO.setUser_id(user_id);;
            pDTO.setNotice_seq(nSeq);
            pDTO.setTitle(title);
            pDTO.setNotice_yn(noticeYn);
            pDTO.setContents(contents);

            // 게시글 수정하기 DB
            noticeReviewService.updateNoticeReviewInfo(pDTO);

            msg = "수정되었습니다.";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeReviewUpdate end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        return "/noticeReview/MsgToListReview";
    }

    /**
     * 게시판 글 삭제
     */
    @GetMapping(value = "noticeReview/NoticeReviewDelete")
    public String NoticeReviewDelete(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeReviewDelete start!");

        String msg = "";

        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 글번호(PK)

            log.info("nSeq : " + nSeq);

            NoticeReviewDTO pDTO = new NoticeReviewDTO();

            pDTO.setNotice_seq(nSeq);

            // 게시글 삭제하기 DB
            noticeReviewService.deleteNoticeReviewInfo(pDTO);


            msg = "삭제되었습니다.";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeReviewDelete end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        return "/noticeReview/MsgToListReview";
    }

}
