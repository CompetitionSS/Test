<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%@ page import="pcs.css.dto.NoticeDTO" %>
<%@ page import="pcs.css.dto.NoticeDTO" %>
<%


    boolean prev = (boolean) request.getAttribute("prev");
    boolean next = (boolean) request.getAttribute("next");

    int startPageNum = (int) request.getAttribute("startPageNum");
    int endPageNum = (int) request.getAttribute("endPageNum");
    int select = (int) request.getAttribute("select");

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
            location.href = "/notice/NoticeInfo?nSeq=" + seq;
        }

    </script>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-md-4">
            <a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
        </div>
        <div class="col-md-4">
            <a href="/main/main" style="text-decoration: none"> <h1 style="text-align: center">"constory" <span class="badge bg-secondary">"공모전 리뷰"</span></h1></a>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</div>


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


                <input type="button" class ="btn btn-outline-primary" value="자유게시판" onclick="location.href='/notice/NoticeList'">

                <input type="button" class ="btn btn-outline-primary" value="리뷰게시판" onclick="location.href='/noticeReview/NoticeReviewList'">

                <%}%>
            </div>
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
        <td align="center"><%=CmmUtil.nvl(rDTO.getUser_id()) %>
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


<div class="container"style="height: 100px">
    <div class="row">
        <div class="col-12">
            <button class="btn btn-primary" onclick="location='/noticeReview/NoticeReviewReg'" style="float: right";>글쓰기</button>
        </div>
    </div>
</div>


<div class="container" style="height: 100px">
    <div class="row">
<<<<<<< HEAD
        <div class="col-md-12" style="margin: 0 auto; display: inline-block;">
=======
        <div class="col-2">
            <label>
                <select name="search" style="height: 40px; width: 100%">
                    <option value="title">제목</option>
                    <option value="user_id">작성자</option>
                    <option value="contents">글 내용</option>
                </select>
            </label>
        </div>
        <div class="col-7" >
>>>>>>> origin/kodong
            <form action="/notice/SearchList" method="get" style="text-align: center" >

                <%--<label>
                    <select name="search" style="height: 40px">
                        <option value="title">제목</option>
                        <option value="user_id">작성자</option>
                        <option value="contents">글 내용</option>--%>
                  <%--  </select>--%>
                    <input type="text" style="height: 40px; width: 100%"  />
                <%--</label>--%>

            </form>
        </div>
<<<<<<< HEAD
=======
        <div class="col-3">
            <button type="submit" class="btn btn-primary">검색</button>
        </div>
>>>>>>> origin/kodong
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <nav aria-label="Page navigation example">
<<<<<<< HEAD
                <div style="text-align: center; margin-bottom: 50px;" class="col-md-12 ">

                    <div class="col-md-12 " style="margin: 0 auto; display: inline-block;">
                        <div style="color: red;" class="page-link" >
                        <% if(prev) {%>
                        <button type="button" class="btn btn-secondary"  onclick="location.href='/noticeReview/NoticeReviewList?num=<%=select-1%>'"><<</button>
                        <%}%>
=======
                <div style="text-align: center; height: 155px" class="page-link ">

                    <% if(prev) {%>
                    <button type="button" class="btn btn-secondary"  onclick="location.href='/noticeReview/NoticeReviewList?num=<%=select-1%>'"><<</button>
                    <%}%>

>>>>>>> origin/kodong
                        <% for (int i = startPageNum; i <= endPageNum; i++) {
                            if(select == i) {%>

                            <button class="btn btn-secondary" onclick="location.href='/noticeReview/NoticeReviewList?num=<%=i%>'">
                                <%=i%> </button>
<<<<<<< HEAD

=======
>>>>>>> origin/kodong
                        <%} else {%>
                            <button class="btn btn-secondary" onclick="location.href='/noticeReview/NoticeReviewList?num=<%=i%>'">
                                <%=i%>
                            </button>
                        <% }
                        } %>
<<<<<<< HEAD
                        <% if(next) {%>
                        <button type="button" class="btn btn-secondary" onclick="location.href='/noticeReview/NoticeReviewList?num=<%=select+1%>'">>></button>
                        <% } %>
                        </div>
                    </div>

=======
                    <% if(next) {%>
                    <button type="button" class="btn btn-secondary" onclick="location.href='/noticeReview/NoticeReviewList?num=<%=select+1%>'">>></button>
                    <% } %>
>>>>>>> origin/kodong
                </div>
            </nav>
        </div>
    </div>
</div>



        </form>
</body>

</html>