<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pcs.css.dto.NoticeDTO" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%@ page import="pcs.css.dto.CommentDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.jsoup.helper.DataUtil" %>
<%
    NoticeDTO rDTO = (NoticeDTO) request.getAttribute("rDTO");
    List<CommentDTO> cList = (List<CommentDTO>) request.getAttribute("cList");
    if (rDTO == null) {
        rDTO = new NoticeDTO();

    }
    if(cList == null){
        cList = new ArrayList<>();
    }

//공지글 정보를 못불러왔다면, 객체 생성


    String ss_user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    int edit = 1;

//로그인 안했다면....
    if (ss_user_id.equals("")) {
        edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
    } else if (ss_user_id.equals(CmmUtil.nvl(rDTO.getUser_id()))) {
        edit = 2;

    }

    System.out.println("user_id : " + CmmUtil.nvl(rDTO.getUser_id()));
    System.out.println("ss_user_id : " + ss_user_id);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>게시판 글보기</title>
    <script src="js/jquery-3.6.1.min.js" type="text/javascript"></script>
</head>
<body>
<table border="1">
    <col width="100px"/>
    <col width="200px"/>
    <col width="100px"/>
    <col width="200px"/>
    <tr>
        <td align="center">제목</td>
        <td colspan="3"><%=CmmUtil.nvl(rDTO.getTitle())%>
        </td>
    </tr>

    <tr>
        <td align="center">작성일</td>
        <td><%=CmmUtil.nvl(rDTO.getReg_dt())%>
        </td>
        <td align="center">조회수</td>
        <td><%=CmmUtil.nvl(rDTO.getRead_cnt())%>
        </td>
    </tr>
    <tr>
        <td colspan="4" height="300px" valign="top">
            <%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>") %>
        </td>
    </tr>

        <% for(CommentDTO comment : cList){

            %>  <tr><td><%=comment.getUser_id()%></td>
        <td><%=comment.getContents()%></td>
        <td><%=CmmUtil.nvl(comment.getChg_dt())%></td>
        <td align="center" colspan="4">
            <a href="javascript:doCoEdit();" id = "update">[수정]</a>
            <a href="javascript:doCoDelete();" id = "delete">[삭제]</a>
        </td>
        
    </tr>
        <%}%>

</table>
    <form action="/notice/InsertComment" method="post">
        <div>
            <input type="hidden" name = "notice_seq" value = "<%=rDTO.getNotice_seq()%>">
            <input type="hidden" name = "user_id" value = "<%=ss_user_id%>">
            <textarea type="contents" name = "contents" style="width: 555px; height: 70px; float:left" ></textarea>
            <button type="submit" class="btn btn-primary" style="height: 76px; width: 50px; float:left ">등록</button>
        </div>

    </form>
    <div>
        <div align="center">
            <a href="javascript:doEdit();">[수정]</a>
            <a href="javascript:doDelete();">[삭제]</a>
            <a href="javascript:doList();">[목록]</a>
        </div>
    </div>

</body>
<script type="text/javascript">

    //수정하기
    function doEdit() {
        if ("<%=edit%>" == 2) {

        } else if ("<%=edit%>" == 3) {
            alert("로그인 하시길 바랍니다.");

        } else {
            alert("본인이 작성한 글만 수정 가능합니다.");

        }
    }
    function doCoEdit() {
        if ("<%=edit%>" == 2) {


        } else if ("<%=edit%>" == 3) {
            alert("로그인 하시길 바랍니다.");

        } else {
            alert("본인이 작성한 글만 수정 가능합니다.");

        }
    }
    function doCoDelete() {
        if ("<%=edit%>" == 2) {
            if (confirm("작성한 글을 삭제하시겠습니까?")) {
                location.href = "/notice/NoticeDelete?nSeq=<%=CmmUtil.nvl(rDTO.getNotice_seq())%>";

            }

        } else if ("<%=edit%>" == 3) {
            alert("로그인 하시길 바랍니다.");

        } else {
            alert("본인이 작성한 글만 삭제 가능합니다.");

        }
    }


    //삭제하기
    function doDelete() {
        if ("<%=edit%>" == 2) {
            if (confirm("작성한 글을 삭제하시겠습니까?")) {
                location.href = "/notice/NoticeDelete?nSeq=<%=CmmUtil.nvl(rDTO.getNotice_seq())%>";

            }

        } else if ("<%=edit%>" == 3) {
            alert("로그인 하시길 바랍니다.");

        } else {
            alert("본인이 작성한 글만 삭제 가능합니다.");

        }
    }

    //목록으로 이동
    function doList() {
        location.href = "/notice/NoticeList";

    }

</script>
<script>
    $(document).ready(function(){
        $("#update").click(getMemberList); //id="listButton"인 태그에 click하면 function getMemberList() 실행
    });
    function getMemberList(){
        $.ajax({
            url:"NoticeInfo.jsp",                    //list.jsp에 AJAX요청
            success:function(data){
                let obj=JSON.parse(data);      //data를 받아와서 JSON형태로 변환
                let array=["<ol>"];
                obj["member_list"].forEach(
                    member =>  array.push("<li>"+member.id+"</li>")
                    //JSON에 있는 member.id의 value를 li태그에 넣어서 array에 넣어줌
                );
                array.push("</ol>");

                $("#result").html(array.join(""));
                //array의 요소들을 다 합쳐서 하나로 만든후 id="result"인 태그에 html로 출력
            }
        });
    }
</script>
</html>