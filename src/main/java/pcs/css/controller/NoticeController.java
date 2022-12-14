package pcs.css.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import netscape.javascript.JSObject;
import org.json.JSONArray;
import org.jsoup.helper.DataUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import pcs.css.dto.CommentDTO;
import pcs.css.dto.NoticeDTO;
import pcs.css.dto.PageDTO;
import pcs.css.service.INoticeService;
import pcs.css.util.CmmUtil;
import pcs.css.util.DateUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@Controller
public class NoticeController {


     /* 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
     */
    @Resource(name = "NoticeService")
    private INoticeService noticeService;

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
    @GetMapping(value = "notice/NoticeList")
    public String NoticeList(HttpServletRequest request,ModelMap model) throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeList start!");
        NoticeDTO nDTO = new NoticeDTO();
        PageDTO pageDTO;
        int count = noticeService.noticeCount(nDTO);
        log.info(String.valueOf(count));
        String no = CmmUtil.nvl(request.getParameter("num"));

        if(no.isEmpty()){
            pageDTO = new PageDTO(1,count);
        }else {
            pageDTO = new PageDTO(Integer.parseInt(no),count);
        }

        nDTO.setStart(pageDTO.getStart());
        nDTO.setFinish(pageDTO.getFinish());
        // 공지사항 리스트 가져오기
        List<NoticeDTO> rList = noticeService.getNoticeList(nDTO);
        if (rList == null) {
            rList = new ArrayList<>();
        }

        // 조회된 리스트 결과값 넣어주기
        model.addAttribute("rList", rList);

        // 현재 페이지
        model.addAttribute("select", pageDTO.getNum());
        model.addAttribute("startPageNum", pageDTO.getStartPageNum());
        model.addAttribute("endPageNum", pageDTO.getEndPageNum());

        // 이전 및 다음
        model.addAttribute("prev", pageDTO.isPrev());
        model.addAttribute("next", pageDTO.isNext());
        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".NoticeList end!");
        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/notice/NoticeList";

    }


    @GetMapping(value = "noticeReview/NoticeReviewList")
    public String NoticeReviewList(HttpServletRequest request,ModelMap model) throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        NoticeDTO nDTO = new NoticeDTO();
        PageDTO pageDTO;
        int count = noticeService.reviewCount(nDTO);

        String no = CmmUtil.nvl(request.getParameter("num"));

        if(no.isEmpty()){
            pageDTO = new PageDTO(1,count);
        }else {
            pageDTO = new PageDTO(Integer.parseInt(no),count);
        }

        nDTO.setStart(pageDTO.getStart());
        nDTO.setFinish(pageDTO.getFinish());

        List<NoticeDTO> rList = noticeService.getReviewList(nDTO);

        if (rList == null) {
            rList = new ArrayList<>();
        }

        // 조회된 리스트 결과값 넣어주기
        model.addAttribute("rList", rList);

        // 현재 페이지
        model.addAttribute("select", pageDTO.getNum());
        model.addAttribute("startPageNum", pageDTO.getStartPageNum());
        model.addAttribute("endPageNum", pageDTO.getEndPageNum());

        // 이전 및 다음
        model.addAttribute("prev", pageDTO.isPrev());
        model.addAttribute("next", pageDTO.isNext());

        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".ReviewList end!");
        // 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
        return "/noticeReview/NoticeReviewList";

    }


    @GetMapping(value = "notice/NoticeReg")
    public String NoticeReg() {

        log.info(this.getClass().getName() + ".NoticeReg start!");

        log.info(this.getClass().getName() + ".NoticeReg end!");

        return "/notice/NoticeReg";
    }
    @GetMapping(value = "noticeReview/NoticeReviewReg")
    public String NoticeReviewReg() {

        log.info(this.getClass().getName() + ".NoticeReg start!");

        log.info(this.getClass().getName() + ".NoticeReg end!");

        return "/noticeReview/NoticeReviewReg";
    }

    /**
     * 게시판 글 등록
     */
    @PostMapping(value = "notice/NoticeInsert")
    public String NoticeInsert(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeInsert start!");

        String msg = "";
        boolean yn = false;
        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String user_id = CmmUtil.nvl(request.getParameter("user_id"));
            String title = CmmUtil.nvl(request.getParameter("title")); // 제목
            String noticeYn = CmmUtil.nvl(request.getParameter("noticeYn")); // 공지글 여부
            String contents = CmmUtil.nvl(request.getParameter("contents")); // 내용
            String ReviewYN = CmmUtil.nvl(request.getParameter("ReviewYN"));

            log.info("user_id : " + user_id);
            log.info("title : " + title);
            log.info("noticeYn : " + noticeYn);
            log.info("contents : " + contents);
            log.info("ReviewYN : " + ReviewYN);
            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setUser_id(user_id);
            pDTO.setTitle(title);
            pDTO.setNotice_yn(noticeYn);
            pDTO.setContents(contents);
            pDTO.setReview(ReviewYN);

            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             */
            noticeService.InsertNoticeInfo(pDTO);
            if(ReviewYN.equals("Y")||ReviewYN.equals("y")){
                yn = true;
            }

            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeInsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);
            model.addAttribute("yn", yn);
        }

            return "/notice/MsgToList";


    }





    @PostMapping(value = "notice/InsertComment")
    @ResponseBody
    public void InsertComment(String notice_seq, String user_id, String contents) throws Exception {
        log.info(this.getClass().getName() + ".InsertComment start!");
        CommentDTO cDTO = new CommentDTO();
        cDTO.setNotice_seq(notice_seq);
        cDTO.setUser_id(user_id);
        cDTO.setContents(contents);
        noticeService.InsertComment(cDTO);

        log.info(this.getClass().getName() + ".InsertComment end!");

    }
    @PostMapping(value = "notice/InsertReply")
    @ResponseBody
    public void InsertReply(String notice_seq,String user_id,String contents,String ref, String ref_rank) throws Exception {
        log.info(this.getClass().getName() + ".InsertReply start!");

        CommentDTO cDTO = new CommentDTO();
        cDTO.setNotice_seq(notice_seq);
        cDTO.setUser_id(user_id);
        cDTO.setContents(contents);
        cDTO.setRef(ref);
        cDTO.setRef_rank(String.valueOf(Integer.parseInt(ref_rank) + 1));

        noticeService.InsertComment(cDTO);

        log.info(this.getClass().getName() + ".InsertReply end!");

    }
    @PostMapping(value ="notice/CommentUpdate")
    @ResponseBody
    public void CommentUpdate(String comment_seq, String contents ) throws Exception {
        CommentDTO cDTO = new CommentDTO();

        log.info(contents);
        log.info(comment_seq);
        cDTO.setComment_seq(comment_seq);
        cDTO.setContents(contents);
         noticeService.commentUpdate(cDTO);

    }

    @GetMapping(value ="notice/Comment")
    @ResponseBody
    public Object CommentCheck(String notice_seq,String num ) throws Exception {
            CommentDTO nDTO = new CommentDTO();
            nDTO.setNotice_seq(notice_seq);
            PageDTO pageDTO;
            int count = noticeService.commentCount(nDTO);
            if(num.isEmpty()){
            pageDTO = new PageDTO(1,count);
             }else {
            pageDTO = new PageDTO(Integer.parseInt(num),count);
            }
            nDTO.setStart(pageDTO.getStart());
            nDTO.setFinish(pageDTO.getFinish());
            List<CommentDTO> cList =  noticeService.getCommentsList(nDTO);
            ObjectMapper objectMapper = new ObjectMapper();
            JSONArray jsonArray = new JSONArray();
          if(cList!= null){
              for (CommentDTO commentDTO : cList) {
                  jsonArray.put(objectMapper.writeValueAsString(commentDTO));

              }
          }

        return jsonArray.toString();
    }
    @GetMapping(value ="notice/CommentCount")
    @ResponseBody
    public String CommentCount(String notice_seq)throws Exception{
        CommentDTO nDTO = new CommentDTO();
        nDTO.setNotice_seq(notice_seq);
        int count = noticeService.commentCount(nDTO);

        return String.valueOf(count);
    }
    @GetMapping(value ="notice/CommentPage")
    @ResponseBody
    public Object CommentPageCheck(String notice_seq,String num ) throws Exception {
        CommentDTO nDTO = new CommentDTO();
        nDTO.setNotice_seq(notice_seq);
        PageDTO pageDTO;
        int count = noticeService.commentCount(nDTO);

        if(num.isEmpty()){
            pageDTO = new PageDTO(1,count);
        }else {
            pageDTO = new PageDTO(Integer.parseInt(num),count);
        }
        ObjectMapper objectMapper = new ObjectMapper();

        return objectMapper.writeValueAsString(pageDTO);
    }
    @DeleteMapping(value="notice/commentDelete")
    @ResponseBody
    public void CommentDelete(String comment_seq) throws Exception{
        CommentDTO cDTO = new CommentDTO();
        cDTO.setComment_seq(comment_seq);
        noticeService.deleteComment(cDTO);

    }

    @GetMapping(value = "notice/NoticeInfo")
    public String NoticeInfo(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeInfo start!");

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

        log.info(this.getClass().getName() + ".NoticeInfo end!");

        return "/notice/NoticeInfo";
    }
    @GetMapping(value = "notice/SearchList")
    public String SearchList(HttpServletRequest request, ModelMap model) throws Exception {
        String review = CmmUtil.nvl(request.getParameter("review")) ;
        String search = CmmUtil.nvl(request.getParameter("search")) ;
        String s_contents = CmmUtil.nvl(request.getParameter("s_contents")) ;
        String no = CmmUtil.nvl(request.getParameter("num"));
        NoticeDTO nDTO = new NoticeDTO();
        nDTO.setSearch(search);
        nDTO.setS_contents(s_contents);
        nDTO.setReview(review);
        log.info(search);
        log.info(s_contents);
        log.info(review);
        PageDTO pageDTO;
        int count = noticeService.SearchCount(nDTO);
        if(no.isEmpty()){
            pageDTO = new PageDTO(1,count);
        }else {
            pageDTO = new PageDTO(Integer.parseInt(no),count);
        }
        nDTO.setStart(pageDTO.getStart());
        nDTO.setFinish(pageDTO.getFinish());
        List<NoticeDTO> nList =  noticeService.SearchList(nDTO);
        model.addAttribute("nList", nList);
        model.addAttribute("review",review);
        // 현재 페이지
        model.addAttribute("select", pageDTO.getNum());
        model.addAttribute("startPageNum", pageDTO.getStartPageNum());
        model.addAttribute("endPageNum", pageDTO.getEndPageNum());

        // 이전 및 다음
        model.addAttribute("prev", pageDTO.isPrev());
        model.addAttribute("next", pageDTO.isNext());
        return "notice/SearchList";
    }
    /**
     * 게시판 수정 보기
     */
    @GetMapping(value = "notice/NoticeEditInfo")
    public String NoticeEditInfo(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeEditInfo start!");

        String msg = "";

        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 공지글번호(PK)

            log.info("nSeq : " + nSeq);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setNotice_seq(nSeq);

            /*
             * ####################################################### 공지사항 수정정보 가져오기(상세보기
             * 쿼리와 동일하여, 같은 서비스 쿼리 사용함)
             * #######################################################
             */
            NoticeDTO rDTO = noticeService.getNoticeInfo(pDTO);

            if (rDTO == null) {
                rDTO = new NoticeDTO();

            }

            // 조회된 리스트 결과값 넣어주기
            model.addAttribute("rDTO", rDTO);

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeUpdate end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);

        }

        log.info(this.getClass().getName() + ".NoticeEditInfo end!");

        return "/notice/NoticeEditInfo";
    }

    /**
     * 게시판 글 수정
     */
    @PostMapping(value = "notice/NoticeUpdate")
    public String NoticeUpdate(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeUpdate start!");

        String msg = "";
        boolean yn = false;
        try {

            String user_id = CmmUtil.nvl((String) session.getAttribute("SESSION_USER_ID")); // 아이디
            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 글번호(PK)
            String title = CmmUtil.nvl(request.getParameter("title")); // 제목
            String contents = CmmUtil.nvl(request.getParameter("contents")); // 내용

            log.info("user_id : " + user_id);
            log.info("nSeq : " + nSeq);
            log.info("title : " + title);

            log.info("contents : " + contents);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setUser_id(user_id);;
            pDTO.setNotice_seq(nSeq);
            pDTO.setTitle(title);
            pDTO.setContents(contents);

            // 게시글 수정하기 DB
            noticeService.updateNoticeInfo(pDTO);
            if(noticeService.Reviewyn(pDTO).equals("Y")||noticeService.Reviewyn(pDTO).equals("y")){
                yn = true;
            }
            msg = "수정되었습니다.";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeUpdate end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);
            model.addAttribute("yn",yn);
        }

        return "/notice/MsgToList";
    }

    /**
     * 게시판 글 삭제
     */
    @GetMapping(value = "notice/NoticeDelete")
    public String NoticeDelete(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeDelete start!");

        String msg = "";
        boolean yn = false;
        try {

            String nSeq = CmmUtil.nvl(request.getParameter("nSeq")); // 글번호(PK)

            log.info("nSeq : " + nSeq);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setNotice_seq(nSeq);
            if(noticeService.Reviewyn(pDTO).equals("Y")||noticeService.Reviewyn(pDTO).equals("y")){
                yn = true;
            }

            // 게시글 삭제하기 DB
            noticeService.deleteNoticeInfo(pDTO);

            msg = "삭제되었습니다.";

        } catch (Exception e) {
            msg = "실패하였습니다. : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeDelete end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);
            model.addAttribute("yn",yn);

        }

        return "/notice/MsgToList";
    }

}



