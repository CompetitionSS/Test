package pcs.css.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeReviewDTO {
    private String notice_seq; // 기본키, 순번////
    private String title; // 제목///
    private String notice_yn; // 공지글 여부///
    private String contents; // 글 내용////
    private String nick; // 작성자////
    private String read_cnt; // 조회수////
    private String user_id; // 등록자 아이디////
    private String reg_dt; // 등록일//


}