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

<!-- Navbar -->
<nav class="container py-4 align-items-center navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <button
                class="navbar-toggler"
                type="button"
                data-mdb-toggle="collapse"
                data-mdb-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false"
                aria-label="Toggle navigation"
        >
            <i class="fas fa-bars"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <a class="navbar-brand mt-2 mt-lg-0" href="#">
                <img src="https://assets.cdn.soomgo.com/icons/icon-navi-logo.svg" />
            </a>
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="/Main.jsp">메인</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="NoticeInfo.jsp">자유게시판</a>
                </li>
            </ul>
        </div>

        <div class="d-flex align-items-center">
            <div class="dropdown">
                <div class="dropdown-toggle d-flex align-items-center hidden-arrow" href="#" id="navbarDropdownMenuAvatar" role="button" data-mdb-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-cog"></i>
                </div>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuAvatar">
                    <li>
                        <a id="loginBtn" class="dropdown-item" href="#">로그인</a>
                    </li>
                    <!-- <li>
                      <a class="dropdown-item" href="#">로그아웃</a>
                    </li> -->
                </ul>
            </div>
        </div>
    </div>
</nav>
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
</section>

<!-- Comment -->
<section>
    <div class="container my-5 py-5">
        <h4 class="mb-3">댓글 4개</h4>
        <div class="row d-flex justify-content-center">
            <div class="col-md-12 col-lg-12">
                <div id="comments" class="card text-dark"></div>

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

<nav class="pb-5">
    <ul class="pagination justify-content-center">
        <li class="page-item">
            <a class="page-link" href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
                <span class="sr-only">Previous</span>
            </a>
        </li>
        <li class="page-item active"><a class="page-link" href="#">1</a></li>
        <!-- <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item"><a class="page-link" href="#">4</a></li>
        <li class="page-item"><a class="page-link" href="#">5</a></li> -->
        <li class="page-item">
            <a class="page-link" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
                <span class="sr-only">Next</span>
            </a>
        </li>
    </ul>
</nav>
<script type="text/javascript">

    $(document).ready(
        function GetComment() {
            var page = document.location.href;
            page = page.substring(page.indexOf("=") + 1);
            let id = "<%=ss_user_id%>"
            let otherlist = false;
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
                            html += "<a class='updatestart link-muted'><i class='updatestart fas fa-pencil-alt ms-2'></i></a>";
                            html += "<a class='insertReply link-muted'><i class='insertReply fas fa-comment-alt ms-2'></i></a>";
                            html += "<a class='delete link-muted'><i class='delete fas fa-trash ms-2'></i></a>";
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
                            html += "<button type='button' class='update btn btn-primary' onclick='window.location.reload()'>"+"취소"+"</button>";
                        } else {
                            html += "<div class = 'updateForm' style='display:none;'>";

                            html += "<textarea class ='contents form-control ' name = 'contents' style='background-color: whitesmoke' >" + contents + "</textarea>";
                            html += "<input name ='comment_seq' class = 'comment_seq' type='hidden' value=" + comment_seq + ">";
                            html += "<button type='button' class='update btn btn-primary' >"+"수정 완료" +"</button>"+ "&nbsp";
                            html += "<button type='button' class='update btn btn-primary' onclick='window.location.reload()'>"+"취소"+"</button>";
                        }
                        html += "</div>";

                        html += "<div class = 'replyForm' style='display: none'>";

                        html += "<textarea class ='contents form-control ' name = 'contents' style='background-color: whitesmoke'>"+ "</textarea>";
                        html += "<input name ='notice_seq' class = 'notice_seq' type='hidden' value=" + page + ">";
                        html += "<input name ='user_id' class = 'user_id' type='hidden' value=" + id + ">";
                        html += "<input name ='ref' class = 'ref' type='hidden' value=" + ref + ">";
                        html += "<input name ='ref_rank' class = 'ref_rank' type='hidden' value=" + ref_rank + ">";
                        html += "<button class='reply btn btn-primary' name ='reply' type='button'  '>" + "등록" + "</button>";

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
                            window.location.reload();
                        }
                    })
                }
            }


            function getReplyForm() {

                let login_yn = "<%=edit%>";
                if (login_yn != 3) {
                    let ReplyForm = $(this).closest("div.co").children("div.replyForm");

                    ReplyForm.css("display", "inline");
                } else {
                    alert("로그인 후 이용해 주세요");
                }
            }

            function getUpdateList() {

                let comment = $(this).closest("div.card-body")
                let updateform = $(this).closest("div.co").children("div.updateForm");

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