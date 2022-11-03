<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%@ page import="pcs.css.dto.NoticeQnaDTO" %>
<%
    session.setAttribute("SESSION_USER_ID", "USER01"); //세션 강제 적용, 로그인된 상태로 보여주기 위함

    List<NoticeQnaDTO> rList = (List<NoticeQnaDTO>) request.getAttribute("rList");

//게시판 조회 결과 보여주기
    if (rList == null) {
        rList = new ArrayList<NoticeQnaDTO>();

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
            location.href = "/noticeQna/NoticeQnaInfo?nSeq=" + seq;
        }

    </script>
</head>

<body>
<img src="/img/asd.gif" alt="사진" onclick="location.href='/main/main'">
<header align=center>
    <h1>QNA</h1>
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
<br/>

<table border="1" width="600px" align="center">
    <tr>

        <td width="100" align="center">순번</td>
        <td width="200" align="center">제목</td>
        <td width="100" align="center">조회수</td>
        <td width="100" align="center">등록자</td>
        <td width="100" align="center">등록일</td>
    </tr>
    <%
        for (int i = 0; i < rList.size(); i++) {
            NoticeQnaDTO rDTO = rList.get(i);

            if (rDTO == null) {
                rDTO = new NoticeQnaDTO();
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
            <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getNotice_seq())%>');">
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
<a href="/noticeQna/NoticeQnaReg" align="center">[글쓰기]</a>
</body>

</html>