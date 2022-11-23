package pcs.css.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;

import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Data;

@Data
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class CommentDTO {
    private String notice_seq;
    private String user_id;
    private String contents;
    private String reg_dt;
    private String chg_dt;
    private String comment_seq;
    private String ref;
    private String ref_rank;

    private int start;
    private int finish;
}
