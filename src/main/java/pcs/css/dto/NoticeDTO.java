package pcs.css.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class NoticeDTO {
    private String notice_seq; // 기본키, 순번
    private String title; // 제목
    private String notice_yn; // 공지글 여부
    private String contents; // 글 내용
    private String nick; // 작성자
    private String read_cnt; // 조회수
    private String user_id; // 등록자 아이디
    private String reg_dt; // 등록일
    private String review; // 리뷰 인지 자유게시판인지 확인
    private List<CommentDTO> comments = new ArrayList<>(); //댓글 삭제시 갖고올 댓글 리스트

    private int start;
    private int finish;
}
