package pcs.css.dto;

import lombok.Data;

@Data
public class CommentDTO {
    private String notice_seq;
    private String user_id;
    private String contents;
    private String reg_dt;
    private String chg_dt;
}
