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

    }else if(!ss_user_id.equals("null")){
        edit = 4;
    }
    String notice_seq =  request.getQueryString().substring(request.getQueryString().indexOf("=")+1);



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>게시판 글보기</title>
    <script src="../js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <style type="text/css">
    </style>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
            crossorigin="anonymous"
    />

    <script src="https://kit.fontawesome.com/9e30f8c908.js" crossorigin="anonymous"></script>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.1/mdb.min.js"></script>

</head>
<body>
<section class="container">
    <div class="py-4 card">
        <div class="row navbar navbar-expand-lg justify-content-between px-3">
            <div class="fw-bold fs-5 text-truncate col-10" style="max-width: 90%"><%=CmmUtil.nvl(rDTO.getTitle())%></div>

            <div class="text-muted col-2 text-end" style="font-size: 14px"><%=CmmUtil.nvl(rDTO.getRead_cnt())%></div>
        </div>

        <hr class="hr" />

        <!-- Author -->
        <div class="px-3">
            <span class="me-1"><%=CmmUtil.nvl(rDTO.getUser_id())%></span>
            <span> / </span>
            <%=CmmUtil.nvl(rDTO.getReg_dt())%>
            <span>작성일: 2022-11-22</span>
        </div>

        <div class="text-muted px-3 py-5" style="min-height: 400px">
          <%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br />") %>

        </div>
    </div>
</section>
    <div id = comments style="width: 100%; margin-left: 200px">
    </div>
<br>
<br>
<hr>
<br>
<br>
    <div class = "insertForm" style="text-align: center">
        <input type="hidden" id="user_id" name = "user_id" value="<%=ss_user_id%>">
        
        <strong style="float:left; margin-left: 200px" ><%=ss_user_id%></strong><br>
        <input type="hidden" id="notice_seq" name = "notice_seq" value="<%=notice_seq%>">
        <textarea cols="80px" id="contents" name="contents"></textarea>
        <input type="button"  class="insert" value="등록">
    </div>
<script type="text/javascript">

    $(document).ready(
        function GetComment() {
        var page = document.location.href;
        page = page.substring(page.indexOf("=") + 1);
        let id = "<%=ss_user_id%>"

        $(".insert").click(insertComment);
        $.ajax({
            type: "GET",
            url: "/notice/Comment",
            dataType: "json",
            data: {notice_seq: page},
            contentType: "application/x-www-form-urlencoded;charset=UTF-8",
            error: function () {
                console.log('통신실패!!');
            },
            success: function (data) {
                let html = "<div id = 'comment-list' class='container my-5 py-5'>";
                $.each(data, (index, obj) => {

                    let comment = JSON.parse(obj);

                    let comment_seq = comment.comment_seq;
                    let contents = comment.contents;
                    let user_id = comment.user_id;
                    let ref = comment.ref;
                    let ref_rank = comment.ref_rank;
                    let chg_dt = comment.chg_dt;
                    let reg_dt = comment.reg_dt;
                    if (ref_rank > 0) {
                        html += "<span class='user_id badge bg-primary' style='margin-left: 50px'>" + user_id + "</span>";
                        html += "<div class= 'comment' style='margin-left: 50px'>";
                        html += "<div>" + contents + "</div>";
                        html += "<div class='comment_seq' style='display: none'>" + comment_seq + "</div>";
                        if (chg_dt !== reg_dt) {
                            html += "<div>" + "(수정됨)" + "</div>";
                        }
                        html += "<div>" + chg_dt + "</div>";
                    } else {
                        html += "<div  class='user_id'>" + user_id + "</div>";
                        html += "<div class= 'comment'>";
                        html += "<div>" + contents + "</div>";
                        html += "<div class='comment_seq' style='display: none'>" + comment_seq + "</div>";
                        if (chg_dt !== reg_dt) {
                            html += "<div>" + "(수정됨)" + "</div>";
                        }
                        html += "<div>" + chg_dt + "</div>";
                    }

                    html += "<input class = 'updatestart' type ='button'  value='수정'>";
                    html += "<input class = 'insertReply' type ='button'  value='대댓글'>";
                    html += "<input class = 'delete' type ='button' value='삭제'>";
                    html += "</div>";

                    if (ref_rank > 0) {
                        html += "<div class = 'updateForm' style='display:none; margin-left: 50px'>";
                        html += "<textarea class ='contents' name = 'contents' >" + contents + "</textarea>";
                        html += "<input name ='comment_seq' class = 'comment_seq' type='hidden' value=" + comment_seq + ">";
                        html += "<input type='button' class='update' value='수정 완료'>"
                        html += "<input name = 'update' type = 'button' onclick='window.location.reload()' value='취소'>"
                    } else {
                        html += "<div class = 'updateForm' style='display:none;'>";
                        html += "<textarea class ='contents' name = 'contents' >" + contents + "</textarea>"
                        html += "<input name ='comment_seq' class = 'comment_seq' type='hidden' value=" + comment_seq + ">";
                        html += "<input type='button' class='update' value='수정 완료'>"
                        html += "<input name = 'update' type = 'button' onclick='window.location.reload()' value='취소'>"
                    }
                    html += "</div>"

                    html += "<div class = 'replyForm' style='display: none'>";

                    html += "<textarea class ='contents' name = 'contents'>" + "</textarea>";
                    html += "<input name ='notice_seq' class = 'notice_seq' type='hidden' value=" + page + ">";
                    html += "<input name ='user_id' class = 'user_id' type='hidden' value=" + id + ">";
                    html += "<input name ='ref' class = 'ref' type='hidden' value=" + ref + ">";
                    html += "<input name ='ref_rank' class = 'ref_rank' type='hidden' value=" + ref_rank + ">";
                    html += "<button class='reply' name ='reply' type='button' '>" + "등록" + "</button>";
                    html += "</div>";


                })
                html += "</div>";
                $("#comments").html(html);
                $(".updatestart").click(getUpdateList);
                $(".insertReply").click(getReplyForm);
                $(".update").click(upDate);
                $(".reply").click(reply);
                $(".delete").click(DeleteComment)
            }
        });

        function insertComment() {

            let notice_seq = document.querySelector('#notice_seq').value;
            let user_id = document.querySelector('#user_id').value;
            let contents= document.querySelector('#contents').value;

            $.ajax({
                type: "post",
                url: "/notice/InsertComment",
                data: {notice_seq:notice_seq,user_id:user_id,contents:contents},
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                error: function () {
                    console.log('응안돼');
                },
                success: function (data) {
                    console.log("ㅅㅂ되냐?")
                    window.location.reload();

                }
            })
        }

            function DeleteComment(){
                let login_yn = "<%=edit%>";
                let comment = document.querySelector("span.user_id").innerHTML;
                let choice = false;

                if (login_yn === "2"||id === comment) {

                    choice = confirm("댓글을 삭제하시겠습니까?");


                }else if(login_yn==="3") {
                    alert("로그인 후 이용해 주세요");
                }else{
                    alert("사용자가 일치하지 않습니다.")
                }

                if(choice){
                    let comment_seq = $(this).parents("div").children("div.comment_seq").html();

                    $.ajax({
                        type:"delete",
                        url:"/notice/commentDelete",
                        data:{comment_seq: comment_seq} ,
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        error: function () {
                        },
                        success: function (data) {
                            window.location.reload();
                        }
                    })
                }
            }


        function getReplyForm() {
            let login_yn = "<%=edit%>";
            if (login_yn != 3) {
                let ReplyForm = $(this).closest("div").next("div").next("div");
                let comment = $(this).closest("div")
                ReplyForm.css("display", "inline");
            } else {
                alert("로그인 후 이용해 주세요");
            }
        }

        function getUpdateList() {
            let updateform = $(this).closest("div").next("div");
            let comment = $(this).closest("div")
            console.log(comment.html());
            console.log(updateform.html());
            updateform.css("display", "inline");
            comment.css("display", "none");

        }

        function upDate() {

            let contents = $(this).closest("div").children("textarea").val();
            let comment_seq = $(this).closest("div").children("input").val();

            $.ajax({
                type: "post",
                url: "/notice/CommentUpdate",
                data: {comment_seq: comment_seq, contents: contents},
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                error: function () {
                },
                success: function (data) {
                    window.location.reload();
                }
            })

        }

        function reply() {
            let val =  $(this).closest("div").children("input");


            let contents = $(this).closest("div").children("textarea").val();
            let notice_seq = $(this).closest("div").children("input.notice_seq").val();
            let user_id = $(this).closest("div").children("input.user_id").val();
            let ref = $(this).closest("div").children("input.ref").val();
            let ref_rank = $(this).closest("div").children("input.ref_rank").val();


            console.log(notice_seq);
            console.log(user_id);
            console.log(ref);
            console.log(ref_rank);
            $.ajax({
                type: "post",
                url: "/notice/InsertReply",
                data: {notice_seq : notice_seq,user_id : user_id, contents: contents,ref:ref, ref_rank : ref_rank},
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                error: function () {
                    console.log('응안돼');
                },
                success: function (data) {
                    console.log("ㅅㅂ되냐?")
                    window.location.reload();
                }
            })
        }
    })
</script>
</body>


</html>