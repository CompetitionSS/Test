package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import pcs.css.dto.NoticeQnaDTO;
import pcs.css.service.INoticeQnaService;
import pcs.css.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class NoticeQnaController {

    /*

     * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
     */
    @Resource(name = "NoticeQnaService")
    private INoticeQnaService noticeQnaService;

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
    @GetMapping(value = "noticeQna/NoticeQnaList")
    public String NoticeQnaList(ModelMap model) throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeQna start!");

        // 공지사항 리스트 가져오기
        List<NoticeQnaDTO> rList = noticeQnaService.getNoticeQnaList();

        if (rList == null) {
            rList = new ArrayList<>();

        }

        // 조회된 리스트 결과값 넣어주기
        model.addAttribute("rList", rList);

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeQnaList end!");
        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/noticeQna/NoticeQnaList";

    }


    @GetMapping(value = "noticeQna/NoticeQnaReg")
    public String NoticeQnaReg() {

        log.info(this.getClass().getName() + ".NoticeQnaReg start!");

        log.info(this.getClass().getName() + ".NoticeQnaReg end!");

        return "/noticeQna/NoticeQnaReg";
    }

    /**
     * 게시판 글 등록
     */
    @PostMapping(value = "noticeQna/NoticeQnaInsert")
    public String NoticeQnaInsert(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeQnaInsert start!");

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

            NoticeQnaDTO pDTO = new NoticeQnaDTO();

            pDTO.setUser_id(user_id);
            pDTO.setTitle(title);
            pDTO.setNotice_yn(noticeYn);
            pDTO.setContents(contents);

            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             */
            noticeQnaService.InsertNoticeQnaInfo(pDTO);

            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeQnaInsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        return "/noticeQna/MsgToListQna";
    }

    /**
     * 게시판 상세보기
     */
    @GetMapping(value = "noticeQna/NoticeQnaInfo")
    public String NoticeQnaInfo(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeQnaInfo start!");

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
            NoticeQnaDTO pDTO = new NoticeQnaDTO();
            pDTO.setNotice_seq(nSeq);

            // 공지사항 상세정보 가져오기
            NoticeQnaDTO rDTO = noticeQnaService.getNoticeQnaInfo(pDTO);

            if (rDTO == null) {
                rDTO = new NoticeQnaDTO();

            }

            log.info("getNoticeQnaInfo success!!!");

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeQnaInsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        log.info(this.getClass().getName() + ".NoticeQnaInfo end!");

        return "/noticeQna/NoticeQnaInfo";
    }

    /**
     * 게시판 수정 보기
     */
    @GetMapping(value = "noticeQna/NoticeQnaEditInfo")
    public String NoticeQnaEditInfo(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeQnaEditInfo start!");

        String msg = "";

        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 공지글번호(PK)

            log.info("nSeq : " + nSeq);

            NoticeQnaDTO pDTO = new NoticeQnaDTO();

            pDTO.setNotice_seq(nSeq);

            /*
             * ####################################################### 공지사항 수정정보 가져오기(상세보기
             * 쿼리와 동일하여, 같은 서비스 쿼리 사용함)
             * #######################################################
             */
            NoticeQnaDTO rDTO = noticeQnaService.getNoticeQnaInfo(pDTO);
//여기도
            if (rDTO == null) {
                rDTO = new NoticeQnaDTO();
//여기도
            }

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeQnaUpdate end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        log.info(this.getClass().getName() + ".NoticeQnaEditInfo end!");

        return "/noticeQna/NoticeQnaEditInfo";
    }

    /**
     * 게시판 글 수정
     */
    @PostMapping(value = "noticeQna/NoticeQnaUpdate")
    public String NoticeQnaUpdate(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeQnaUpdate start!");

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

            NoticeQnaDTO pDTO = new NoticeQnaDTO();

            pDTO.setUser_id(user_id);;
            pDTO.setNotice_seq(nSeq);
            pDTO.setTitle(title);
            pDTO.setNotice_yn(noticeYn);
            pDTO.setContents(contents);

            // 게시글 수정하기 DB
            noticeQnaService.updateNoticeQnaInfo(pDTO);

            msg = "수정되었습니다.";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeQnaUpdate end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        return "/noticeQna/MsgToListQna";
    }

    /**
     * 게시판 글 삭제
     */
    @GetMapping(value = "noticeQna/NoticeQnaDelete")
    public String NoticeQnaDelete(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeQnaDelete start!");

        String msg = "";

        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 글번호(PK)

            log.info("nSeq : " + nSeq);

            NoticeQnaDTO pDTO = new NoticeQnaDTO();

            pDTO.setNotice_seq(nSeq);

            // 게시글 삭제하기 DB
            noticeQnaService.deleteNoticeQnaInfo(pDTO);

            msg = "삭제되었습니다.";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeQnaDelete end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        return "/noticeQna/MsgToListQna";
    }

}
