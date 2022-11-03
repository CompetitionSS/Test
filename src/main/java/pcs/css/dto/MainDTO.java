package pcs.css.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class MainDTO {
    private String c_name;
    private String area;
    private String deadline;
    private String candidate;
    private String organizer;
    private String s_year;
    private String b_year;
    private String r_date;
    private String url;
    private List<String> s_organizer;
    private String collect_time;

  /*  // 검색 시 조회를 위한 가상 변수 들
    private String s_c_name;
    private String s_area;
    private String s_deadline;
    private String s_candidate;

    private String s_year;
    private String s_b_year;
    private String s_r_date;*/

}
