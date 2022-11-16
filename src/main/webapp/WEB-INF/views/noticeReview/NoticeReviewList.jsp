<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%@ page import="pcs.css.dto.NoticeDTO" %>
<%@ page import="pcs.css.dto.NoticeDTO" %>
<%
    session.setAttribute("SESSION_USER_ID", "USER01"); //세션 강제 적용, 로그인된 상태로 보여주기 위함

    List<NoticeDTO> rList = (List<NoticeDTO>) request.getAttribute("rList");

//게시판 조회 결과 보여주기
    if (rList == null) {
        rList = new ArrayList<NoticeDTO>();

    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link  href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>리뷰 리스트</title>
    <script type="text/javascript">

        //상세보기 이동
        function doDetail(seq) {
            location.href = "/noticeReview/NoticeReviewInfo?nSeq=" + seq;
        }

    </script>
</head>

<body>
<%--<img src="/img/asd.gif" alt="사진" onclick="location.href='/main/main'">
<header align=center>
    <h1>REVIEW</h1>
    <hr>
</header>

<div align=right>
    <a href="/user/LoginForm">로그인</a>
    <a href="/user/UserRegForm">회원가입</a>
</div>
<div>커뮤니티</div>
<hr>
<ul>
    <li class="on">
        <a href="/notice/NoticeList">공지사항</a>
    </li>
    <li class="on">
        <a href="/noticeQna/NoticeQnaList">Qna</a> </li>
    </li>
    <li class="on">
        <a href="/noticeReview/NoticeReviewList">Review</a>
    </li>

</ul>

<hr/>
<br/>--%>



<div class="container">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <a href="/main/main" style="text-decoration: none"> <h1 style="text-align: center">"   " <span class="badge bg-secondary">" "</span></h1></a>
        </div>
        <div class="col-md-4">
        </div>
    </div>


    <div class="col-md-4">
    </div>
</div>
</div>


<div class="container" style="height: 100px">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="btn-group" role="group" aria-label="Basic outlined example">
                <% if(session.getAttribute("SS_USER_ID") == null){%>

                <input type="button" class ="btn btn-outline-primary" value="로그인" onclick="location.href='/user/LoginForm'">

                <input type="button" class ="btn btn-outline-primary" value="회원가입" onclick="location.href='/user/UserRegForm'">



                <%}else{%>
                <input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">



                <%}%>
            </div>
        </div>
    </div>
</div>



<div class="container" style="height: 100px;">
    <div class="row">
        <div class="col-md-12">
            <ul class="nav justify-content-end">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/notice/NoticeList">자유 게시판</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/noticeQna/NoticeQnaList">qna</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/noticeReview/NoticeReviewList">공모전 리뷰</a>
                </li>
            </ul>
        </div>
    </div>
</div>





<div class="container">
    <div class="row">
        <div class="col-md-12">
<table border="1" width="600px" align="center" class="table table-striped table-bordered mt-4">
    <tr>

        <td width="100" align="center">순번</td>
        <td width="200" align="center">제목</td>
        <td width="100" align="center">조회수</td>
        <td width="100" align="center">등록자</td>
        <td width="100" align="center">등록일</td>
    </tr>
    <%
        for (int i = 0; i < rList.size(); i++) {
            NoticeDTO rDTO = rList.get(i);

            if (rDTO == null) {
                rDTO = new NoticeDTO();
            }

    %>
    <tr>
        <td align="center">
            <%
                //공지글이라면, [공지]표시
                if (CmmUtil.nvl(rDTO.getNotice_yn()).equals("1")) {
                    out.print("<b>[공지]</b>");

                    //공지글이 아니라면, 글번호 보여주기
                } else {
                    out.print(CmmUtil.nvl(rDTO.getNotice_seq()));

                }
            %></td>
        <td align="center">
            <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getNotice_seq())%>');" style="text-decoration: none">
                <%=CmmUtil.nvl(rDTO.getTitle()) %>
            </a>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getRead_cnt()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getNick()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getReg_dt()) %>
        </td>
    </tr>
    <%
        }
    %>
</table>
        </div>
    </div>
</div>



<div class="container" style="height: 100px" >
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4" style="width: 150px; margin: auto">
            <button class="btn btn-primary" onclick="location='/notice/NoticeReg'" style="float: right";>글쓰기</button>
        </div>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <nav aria-label="Page navigation example">
                <ul class="pagination" style="margin: auto; width: 100px;" >
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>





</body>

</html>