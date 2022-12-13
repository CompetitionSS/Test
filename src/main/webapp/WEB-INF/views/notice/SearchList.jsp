<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.dto.NoticeDTO" %>
<%@ page import="pcs.css.util.CmmUtil" %>

<%

  boolean prev = (boolean) request.getAttribute("prev");
  boolean next = (boolean) request.getAttribute("next");

  int startPageNum = (int) request.getAttribute("startPageNum");
  int endPageNum = (int) request.getAttribute("endPageNum");
  int select = (int) request.getAttribute("select");
  String purl =  request.getRequestURL().toString().replaceAll(".jsp","");
  String c = request.getQueryString();
  String a = purl.replaceFirst("/WEB-INF/views/","")+"?" + c.replaceFirst("&num="+select,"");
  String review = (String) request.getAttribute("review");
  List<NoticeDTO> rList = (List<NoticeDTO>) request.getAttribute("nList");

//게시판 조회 결과 보여주기
  if (rList == null) {
    rList = new ArrayList<NoticeDTO>();

  }
  String ss_user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

  String edit = "1";

//로그인 안했다면....
  if (ss_user_id.equals("")) {
    edit = "2";
  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  <title>공지 리스트</title>
  <script type="text/javascript">

    //상세보기 이동
    function doDetail(seq) {
      location.href = "/notice/NoticeInfo?nSeq=" + seq;
    }
    function reg(){
      let loginyn = "<%=edit%>";
      if(loginyn!=="2"){
        location.href='/notice/NoticeReg';
      }else{
        alert("로그인 후 이용바랍니다.")
      }

    }
  </script>
  <link  href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

</head>

<body>
<div class="container">
  <div class="row">
    <div class="col-md-4">
      <a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
    </div>
    <%if(review.equals("N")||review.equals("n")){%>
        <div class="col-md-4">
      <a href="/main/main" style="text-decoration: none"> <h1 style="text-align: center">"constory" <span class="badge bg-secondary">"자유 게시판"</span></h1></a>
    </div>
    <%}else{%>
    <div class="col-md-4">
      <a href="/main/main" style="text-decoration: none"> <h1 style="text-align: center">"constory" <span class="badge bg-secondary">"공모전 리뷰"</span></h1></a>
    </div>
    <%}%>
    <div class="col-md-4">
      <%--<div style="float:right; width: 300px">
        <table border="1" style="float:right; width: 300px;">
          <tr>
            <td colspan="2" align="center">
              <h1>유저 정보창</h1>
            </td>

          </tr>
          <tr>
            <td align="center">
              <h4> user_id :</h4>
            </td>
            <td align="center">
              <h4>peisir</h4>
            </td>
          </tr>
          <tr>
            <td align="center">
              <h4>P :</h4>
            </td>
            <td align="center">
              <h4>250p</h4>
            </td>
          </tr>
         <tr>
           <td align="center">
             <input type="button" class ="btn btn-outline-primary" value="내 정보"  onclick="location.href='/mypage/Mypageinfo'">
           </td>
           <td align="center">
             <input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">
           </td>
         </tr>
        </table>
      </div>
    </div>--%>
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
    <div class="col-md-12"  >
      <table border="1" width="600px" align="center" class="table table-striped table-bordered mt-4">
        <tr>

          <td width="100" align="center">순번</td>
          <td width="200" align="center">제목</td>
          <td width="100" align="center">조회수</td>
          <td width="100" align="center">등록자</td>
          <td width="100" align="center">등록일</td>
        </tr>
        <%
          for (NoticeDTO rDTO : rList) {


            if (rDTO == null) {
              rDTO = new NoticeDTO();
            }

        %>
        <tr>
          <td align="center">
            <%


              if (CmmUtil.nvl(rDTO.getNotice_yn()).equals("y")||CmmUtil.nvl(rDTO.getNotice_yn()).equals("Y")) {
                out.print("<b>[공지]</b>");


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
<div>
  <form action="/notice/SearchList" method="get" style="text-align: center" >

    <label>
      <select name="search" style="height: 40px">
        <option value="title">제목</option>
        <option value="user_id">작성자</option>
        <option value="contents">글 내용</option>
      </select>
      <input type="hidden" name="review" value="<%=review%>">
      <input type="text" name ="s_contents" style="height: 40px; width: 600px"  />
    </label>
    <button type="submit" class="btn btn-primary">검색</button>
  </form>

</div>


<div class="container">
  <div class="row">
    <div class="col-12">
      <%if(review.equals("N")||review.equals("n")){
        %> <button class="btn btn-primary" onclick="location='/notice/NoticeReg'" style="float: right">글쓰기</button>
      <%}else{%>
      <button class="btn btn-primary" onclick="location='/noticeReview/NoticeReviewReg'" style="float: right">글쓰기</button>
      <%}%>

    </div>
  </div>
</div>


<div class="container">
  <div class="row">
    <div class="col-md-12">
      <nav aria-label="Page navigation example">
        <div style="text-align: center; margin-bottom: 50px;">
          <% if(prev) {%>
          <button type="button" class="btn btn-secondary" onclick="location.href='<%=a%>&num=<%=select-1%>'">Prev</button>
          <%}%>
          <div class="btn-group " style="margin: 0 auto; display: inline-block;">
            <% for (int i = startPageNum; i <= endPageNum; i++) {
              if(select == i) {%>
            <a style="color: red;" href="<%=a%>&num=<%=i%>">
              <button class="btn btn-secondary" >
                <%=i%>
              </button></a>
            <%} else {%>
            <a style="" href="<%=a%>&num=<%=i%>">
              <button class="btn btn-secondary" >
                <%=i%>
              </button></a>
            <% }
            } %>
          </div>
          <% if(next) {%>
          <button type="button" class="btn btn-secondary" onclick="location.href='<%=a%>&num=<%=select+1%>'">Next</button>
          <% } %>
        </div>
      </nav>
    </div>
  </div>
</div>
</body>

</html>