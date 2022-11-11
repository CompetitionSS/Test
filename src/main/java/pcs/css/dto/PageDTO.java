package pcs.css.dto;

import lombok.Data;


@Data
public class PageDTO {
    private int pageNum;// 현재 페이지 번호
    private int amount;
    private int recordSize;       // 페이지당 출력할 데이터 개수
    private int pageSize;         // 화면 하단에 출력할 페이지 사이즈


    public PageDTO() {
        this.pageNum = 1;
        this.recordSize = 10;
        this.pageSize = 10;
    }

    public int getOffset() {
        return (pageNum - 1) * recordSize;
    }
}
