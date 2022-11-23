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
    <script src="/js/jquery-3.6.1.min.js" type="text/javascript"></script>
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
<div class="container">
    <div class="row">
        <div class="col-md-4">
            <a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
        </div>
        <div class="col-md-4">
            <a href="/main/main"style="text-decoration: none"> <h1 style="text-align: center">"constory" <span class="badge bg-secondary">"너를 위한 공모전 "</span></h1></a>
        </div>
        <div class="col-md-4">
        </div>
    </div>


    <div class="col-md-4">
    </div>
</div>
<!-- Navbar -->
<div class="container" style="height: 150px">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="btn-group" role="group" aria-label="Basic outlined example">
                <% if(session.getAttribute("SS_USER_ID") == null){%>

                <input type="button" class ="btn btn-outline-primary" value="로그인" onclick="location.href='/user/LoginForm'">

                <input type="button" class ="btn btn-outline-primary" value="회원가입" onclick="location.href='/user/UserRegForm'">

                <input type="button" class ="btn btn-outline-primary" value="자유게시판" onclick="location.href='/notice/NoticeList'">

                <input type="button" class ="btn btn-outline-primary" value="리뷰게시판" onclick="location.href='/noticeReview/NoticeReviewList'">

                <%}else if(session.getAttribute("SS_USER_ID").equals("admin")){%>
                <input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">

                <input type="button" class ="btn btn-outline-primary" value="자유게시판" onclick="location.href='/notice/NoticeList'">

                <input type="button" class ="btn btn-outline-primary" value="리뷰게시판" onclick="location.href='/noticeReview/NoticeReviewList'">

                <input type="button" class ="btn btn-outline-primary" value="회원관리" onclick="location.href='/user/UserManagement'">

                <%}else{%>
                <input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">

                <input type="button" class ="btn btn-outline-primary" value="커뮤니티" onclick="location.href='/notice/NoticeList'">
                <input type="button" class ="btn btn-outline-primary" value="자유게시판" onclick="location.href='/notice/NoticeList'">

                <input type="button" class ="btn btn-outline-primary" value="리뷰게시판" onclick="location.href='/noticeReview/NoticeReviewList'">

                <%}%>
            </div>
        </div>
    </div>
</div>
<!-- Navbar -->

<section class="container">
    <div class="py-4 card">
        <div class="row navbar navbar-expand-lg justify-content-between px-3">
            <div class="fw-bold fs-5 text-truncate col-10" style="max-width: 90%"><%=CmmUtil.nvl(rDTO.getTitle())%></div>
            <div class="text-muted col-2 text-end" style="font-size: 14px">조회수: <%=CmmUtil.nvl(rDTO.getRead_cnt())%></div>
        </div>

        <hr class="hr" />

        <!-- Author -->
        <div class="px-3">
            <span class="me-1">작성자: <%=CmmUtil.nvl(rDTO.getUser_id())%></span>
            <span> / </span>
            <span>작성일: <%=CmmUtil.nvl(rDTO.getReg_dt())%></span>
        </div>

        <div class="text-muted px-3 py-5" style="min-height: 400px"><%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br />") %></div>
    </div>
    <form class="notice_form" action="/notice/NoticeDelete" >
        <input type="hidden" name="nSeq" value="<%=notice_seq%>">

        <button style="float: right" type="submit" class="btn btn-primary">삭제</button>
        <button style="float: right" type="button" class="btn btn-primary" onclick="location.href='/notice/NoticeEditInfo?nSeq='+<%=notice_seq%>">수정</button>

    </form>
</section>

<!-- Comment -->
<section>
    <div class="container my-5 py-5">
        <div id="comment-count">

        </div>

        <div class="row d-flex justify-content-center">
            <div class="col-md-12 col-lg-12">
                <div id="comments" class="card text-dark"></div>
                <div class="pb-5 col-md-12"  style="text-align: center; margin-bottom: 50px;" id="paging"></div>
                <!-- Write Comment -->
                <div class="insertForm card-footer py-3 border-0" style="background-color: #f8f9fa">
                    <div class="form-outline form-floating w-100">
                        <input type="hidden" id="user_id" name="user_id" value="<%=ss_user_id%>" />
                        <p style="font-size: 20px;font-weight: bold"><%=ss_user_id%></p>
                        <input type="hidden" id="notice_seq" name="notice_seq" value="<%=notice_seq%>" />
                        <textarea class="form-control form-control-lg" id="contents" name="contents" rows="6" style="background: #fff; font-size: 16px" placeholder="댓글 작성"></textarea>
                        <label class="form-label"><br><br>댓글 작성</label>
                    </div>
                    <div class="float-end mt-2 pt-1">
                        <button type="button" id="writeCommentBtn" class="insert btn btn-primary" >댓글 쓰기</button>
                    </div>
                </div>
                <!-- Write Comment -->
            </div>

        </div>
    </div>
</section>


<script type="text/javascript">
    //페이지 시작
    $(document).ready(
        function GetComment() {
            var page = document.location.href;
            page = page.substring(page.indexOf("=") + 1);
            let id = "<%=ss_user_id%>"
            let otherlist = false;
            let prev;
            let next;
            let num = 1;
            let startPageNum;
            let endPageNum;
            $(".insert").click(insertComment);
            PageCount(num);
            //댓글 페이징
            function PageCount(value){


                $.ajax({
                    type: "GET",
                    url: "/notice/CommentPage",
                    dataType: "json",
                    data: {notice_seq: page, num: value.toString()},
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    error: function () {
                        console.log('통신eee실패!!');
                    },success:function (data){
                        console.log(data);
                        let paging = data;
                        num = Number(paging.num);
                        startPageNum = paging.startPageNum;
                        endPageNum = paging.endPageNum;
                        prev = paging.prev;
                        next = paging.next;
                        let pagehtml ="<div>";
                        console.log(prev);
                        if(prev){
                            pagehtml+="<button  class='page btn btn-secondary' type='button' value='"+(num-1)+"'>"+"<<"+"</button>";

                        }

                        for (let i = startPageNum; i <= endPageNum; i++) {
                            if(num === i) {

                                pagehtml+="<button class='page btn btn-secondary' type ='button' value='"+i+"'>"+i+"</button>"+"&nbsp";

                            } else {

                                pagehtml+= "<button class='page btn btn-secondary' type ='button' value='"+i+"'>"+i+"</button>"+"&nbsp";


                             }
                            }

                       if(next){
                           pagehtml+="<button type='button' class='page btn btn-secondary' value='"+(num+1)+"'>"+">>"+"</button>";
                       }
                        $("#paging").html(pagehtml);
                        $(".page").click(clickvalue);
                        num =value;

                    }
                })  //댓글 리스트
                $.ajax({
                    type: "GET",
                    url: "/notice/Comment",
                    dataType: "json",
                    data: {notice_seq: page,num: value},
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    error: function () {
                        console.log('통신실패!!');
                    },
                    success: function (data) {
                        let html = "<div id='comment-list' >";
                        $.each(data, (index, obj) => {
                            let comment = JSON.parse(obj);
                            let comment_seq = comment.comment_seq;
                            let contents = comment.contents;
                            let user_id = comment.user_id;
                            let ref = comment.ref;
                            let ref_rank = comment.ref_rank;
                            let chg_dt = comment.chg_dt;
                            let reg_dt = comment.reg_dt;
                            html += "<div class='co'>";
                            html += "<div class='d-flex flex-start card-body p-4'>";

                            if (ref_rank > 0) {
                                html += "<div style='margin-left: 3%'>";  //1

                                html += "<div class='d-flex align-items-center mb-1'>";

                                html += "<h6 class='fw-bold mb-0 me-1 user_id'>" + user_id + "</h6>";
                                html += "<span class='badge bg-primary'>작성자</span>";
                                html += "<a class='link-muted'><i class='updatestart fas fa-pencil-alt ms-2'></i></a>";
                                html += "<a class='link-muted'><i class='insertReply fas fa-comment-alt ms-2'></i></a>";
                                html += "<a class='link-muted'><i class='delete fas fa-trash ms-2'></i></a>";
                                html += "</div>";
                                html += "<div class='d-flex align-items-center mb-3'>";

                                html += "<p class='mb-0'>" + chg_dt + "</p>";
                                if (chg_dt !== reg_dt) {
                                    html += "<p class='mb-0'>" + "&nbsp(수정됨)" + "</p>";
                                }
                                html += "</div>";

                                html += "<p class='mb-0'>" + contents + "</p>";
                                html += "</div>";
                                html += "</div>";
                                html += "<div class='comment_seq' style='display: none'>" + comment_seq + "</div>";


                                html += "<hr class='my-0' />";
                            }else {
                                html += "<div>";
                                html += "<div class='d-flex align-items-center mb-1'>";
                                html += "<h6 class='fw-bold mb-0 me-1 user_id'>" + user_id + "</h6>";
                                html += "<span class='badge bg-primary'>작성자</span>";
                                html += "<a class=' link-muted'><i class='updatestart fas fa-pencil-alt ms-2'></i></a>";
                                html += "<a class=' link-muted'><i class='insertReply fas fa-comment-alt ms-2'></i></a>";
                                html += "<a class=' link-muted'><i class='delete fas fa-trash ms-2'></i></a>";
                                html += "</div>";
                                html += "<div class='d-flex align-items-center mb-3'>";
                                html += "<p class='mb-0'>" + chg_dt + "</p>";
                                if (chg_dt !== reg_dt) {
                                    html += "<p class='mb-0'>" + "&nbsp(수정됨)" + "</p>";
                                }
                                html += "</div>";
                                html += "<p class='mb-0'>" + contents + "</p>";
                                html += "</div>";
                                html += "</div>";
                                html += "<div class='comment_seq' style='display: none'>" + comment_seq + "</div>";


                                html += "<hr class='my-0' />";
                            }


                            if (ref_rank > 0) {
                                html += "<div class = 'updateForm' style='display:none; margin-left: 50px'>";

                                html += "<textarea class ='contents form-control ' name = 'contents' style='background-color: whitesmoke'>" + contents + "</textarea>";
                                html += "<input name ='comment_seq' class = 'comment_seq' type='hidden' value=" + comment_seq + ">"+ "&nbsp";
                                html += "<button type='button' class='update btn btn-primary' >"+"수정 완료"+"</button>" + "&nbsp";
                                html += "<button type='button' class='cancel btn btn-primary'>"+"취소"+"</button>";
                            } else {
                                html += "<div class = 'updateForm' style='display:none;'>";

                                html += "<textarea class ='contents form-control ' name = 'contents' style='background-color: whitesmoke' >" + contents + "</textarea>";
                                html += "<input name ='comment_seq' class = 'comment_seq' type='hidden' value=" + comment_seq + ">";
                                html += "<button type='button' class='update btn btn-primary' >"+"수정 완료" +"</button>"+ "&nbsp";
                                html += "<button type='button' class='cancel btn btn-primary'>"+"취소"+"</button>";
                            }
                            html += "</div>";

                            html += "<div class = 'replyForm' style='display: none'>";

                            html += "<textarea class ='contents form-control ' name = 'contents' style='background-color: whitesmoke'>"+ "</textarea>";
                            html += "<input name ='notice_seq' class = 'notice_seq' type='hidden' value=" + page + ">";
                            html += "<input name ='user_id' class = 'user_id' type='hidden' value=" + id + ">";
                            html += "<input name ='ref' class = 'ref' type='hidden' value=" + ref + ">";
                            html += "<input name ='ref_rank' class = 'ref_rank' type='hidden' value=" + ref_rank + ">";
                            html += "<button class='reply btn btn-primary' name ='reply' type='button'  '>" + "등록" + "</button>"+ "&nbsp";
                            html += "<button type='button' class='cancel btn btn-primary'>"+"취소"+"</button>";

                            html += "</div>";

                            html += "<hr class='my-0' />";
                            html +="</div>"
                        });

                        html += "</div>";
                        $("#comments").html(html);
                        $(".updatestart").click(getUpdateList);
                        $(".insertReply").click(getReplyForm);
                        $(".update").click(upDate);
                        $(".reply").click(reply);
                        $(".delete").click(DeleteComment);
                        $(".cancel").click(CancelComment);
                        CommentCount();
                    }
                });
            }
            //작성 취소
            function CancelComment(){
                PageCount(num);
            }

            //댓글 입력 ajax
            function insertComment() {

                let notice_seq = document.querySelector('#notice_seq').value;
                let user_id = document.querySelector('#user_id').value;
                let contents= document.querySelector('#contents').value;
                if(user_id == null||user_id ===""){
                    alert("로그인 후 이용해주세요")
                }else{
                    $.ajax({
                        type: "post",
                        url: "/notice/InsertComment",
                        data: {notice_seq:notice_seq,user_id:user_id,contents:contents},
                        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                        error: function () {},
                        success: function (data) {
                            document.querySelector('#contents').value = "";
                            PageCount(num);


                        }
                    })
                }
            }
            //ajax 현재 위치로 재호출
            function clickvalue(){
                let value = this.value;
                PageCount(value);
            }
            //댓글 갯수 ajax
            function CommentCount(){

                $.ajax({
                    type: "GET",
                    url: "/notice/CommentCount",
                    dataType: "text",
                    data: {notice_seq: page},
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    error: function () {
                    },success(data){
                        let count = Number(data);

                        let counthtml ="<h4 class='mb-3'>"+"댓글 갯수 : "+count+"개"+"</h4>"
                        $("#comment-count").html(counthtml);

                    }
                })
            }
            //댓글 삭제 ajax
            function DeleteComment(){

                let login_yn = "<%=edit%>";
                let comment = document.querySelector("h6.user_id").innerHTML;
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
                            PageCount(num);

                        }
                    })
                }
            }
            // 다른 창 전부 끄기
            function otherExit(){
                let otherlist = document.getElementsByClassName("replyForm");
                let otherlist2 = document.getElementsByClassName("updateForm");
                for(let i = 0; i<otherlist.length;i++){
                    otherlist[i].style.display = "none";
                }
                for(let i = 0; i<otherlist2.length;i++){
                    otherlist2[i].style.display = "none";
                }

            }
            //대댓글 폼 보이기
            function getReplyForm() {

                let login_yn = "<%=edit%>";
                if (login_yn != 3) {
                    let ReplyForm = $(this).closest("div.co").children("div.replyForm");
                    otherExit();
                    ReplyForm.css("display", "inline");
                } else {
                    alert("로그인 후 이용해 주세요");
                }
            }
            //댓글 수정 폼 보이기
            function getUpdateList() {
                otherExit();
                let comment = $(this).closest("div.card-body")
                let updateform = $(this).closest("div.co").children("div.updateForm");

                updateform.css("display", "inline");
                comment.css("display", "none");

            }
            //수정 ajax
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
                        PageCount(num);
                    }
                })

            }
            //대댓글 ajax
            function reply() {
                let val =  $(this).closest("div").children("input");


                let contents = $(this).closest("div").children("textarea").val();
                let notice_seq = $(this).closest("div").children("input.notice_seq").val();
                let user_id = $(this).closest("div").children("input.user_id").val();
                let ref = $(this).closest("div").children("input.ref").val();
                let ref_rank = $(this).closest("div").children("input.ref_rank").val();

                $.ajax({
                    type: "post",
                    url: "/notice/InsertReply",
                    data: {notice_seq : notice_seq,user_id : user_id, contents: contents,ref:ref, ref_rank : ref_rank},
                    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                    error: function () {

                    },
                    success: function (data) {

                        PageCount(num);
                    }
                })
            }
        })
</script>
</body>


</html>