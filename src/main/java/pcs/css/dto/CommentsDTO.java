package pcs.css.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class CommentsDTO {

    private String seq;
    private String writer; // 작성자
    private String content; //댓글내용
    private String reg_dt; //날짜



}
