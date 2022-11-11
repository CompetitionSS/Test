<%@ page import="pcs.css.util.CmmUtil" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.dto.MainDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    boolean prev = (boolean) request.getAttribute("prev");
    boolean next = (boolean) request.getAttribute("next");

    int startPageNum = (int) request.getAttribute("startPageNum");
    int endPageNum = (int) request.getAttribute("endPageNum");
    int select = (int) request.getAttribute("select");
    List<MainDTO> mList = (List<MainDTO>) request.getAttribute("mList");
    MainDTO pDTO = (MainDTO) request.getAttribute("pDTO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>메인 리스트</title>
</head>
<body>
<br/>
<form action="/main/mainCrawling" method="get">
    <button type="submit" class ="btn btn-outline-primary">크롤링 실행
    </button>
</form>
<table border="1" width="1600px">
    <tr>
        <td width="300" height="90" align="center">공모전명</td>
        <td width="200" align="center">지역</td>
        <td width="300" align="center">마감일</td>
        <td width="200" align="center">응시대상자</td>
        <td width="200" align="center">주최사</td>
        <td width="300" align="center">시작 날짜</td>
        <td width="150" align="center">연도</td>
        <td width="300" align="center">검색 기준일</td>


    </tr>
        <%
        for (int i = 0; i < mList.size(); i++) {
            MainDTO rDTO = mList.get(i);

            if (rDTO == null) {
                rDTO = new MainDTO();
            }

    %>
    <tr>
        <td colspan="8" align="center"><a href="<%=CmmUtil.nvl(rDTO.getUrl()) %>"><%=CmmUtil.nvl(rDTO.getUrl()) %></a>
        </td>
    </tr>
    <tr>

        <td align="center"><%=CmmUtil.nvl(rDTO.getC_name()) %>

        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getArea()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getDeadline()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getCandidate()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getOrganizer()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getS_year()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getB_year()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getR_date()) %>
        </td>

    </tr>

        <%
        }
    %>
    <div style="text-align: center; margin-bottom: 50px;">
        <% if(prev) {%>
        <button type="button" class="btn btn-secondary" onclick="location.href='/main/mainList?num=<%=select-1%>'">Prev</button>
        <%}%>
        <div class="btn-group " style="margin: 0 auto; display: inline-block;">
            <% for (int i = startPageNum; i <= endPageNum; i++) {
                if(select == i) {%>
            <a style="color: red;" href="/main/mainList?num=<%=i%>">
                <button class="btn btn-secondary">
                    <%=i%>
                </button></a>
            <%} else {%>
            <a style="" href="/main/mainList?num=<%=i%>">
                <button class="btn btn-secondary">
                    <%=i%>
                </button></a>
            <% }
            } %>
        </div>
        <% if(next) {%>
        <button type="button" class="btn btn-secondary" onclick="location.href='/main/mainList?num=<%=select+1%>'">Next</button>
        <% } %>
    </div>

</html>
    