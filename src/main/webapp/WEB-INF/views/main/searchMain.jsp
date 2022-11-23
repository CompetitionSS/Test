<%@ page import="pcs.css.util.CmmUtil" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.dto.MainDTO" %>
<%@ page import="pcs.css.util.DateUtil" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    boolean prev = (boolean) request.getAttribute("prev");
    boolean next = (boolean) request.getAttribute("next");

    int startPageNum = (int) request.getAttribute("startPageNum");
    int endPageNum = (int) request.getAttribute("endPageNum");
    int select = (int) request.getAttribute("select");
    List<MainDTO> mList = (List<MainDTO>) request.getAttribute("mList");
    MainDTO pDTO = (MainDTO) request.getAttribute("pDTO");
    String purl =  request.getRequestURL().toString().replaceAll(".jsp","");
    String c = request.getQueryString();
    String a = purl.replaceFirst("/WEB-INF/views/","")+"?" + c.replaceFirst("&num="+select,"");


   /* List<MainDTO> sList = new ArrayList<>();

    for(int i = 0; i< mList.size();i++){
        if(pDTO.getC_name()!=null){

        }
    }
//게시판 조회 결과 보여주기
    if (mList == null) {
        mList = new ArrayList<MainDTO>();

    }
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
            crossorigin="anonymous"
    />

    <script src='https://kit.fontawesome.com/9e30f8c908.js' crossorigin='anonymous'></script>
    <title>메인 리스트</title>
    <link href="css/chatbot.css" rel="stylesheet">
    <script src="/js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <!-- Channel Plugin Scripts -->
    <script>
        (function() {
            var w = window;
            if (w.ChannelIO) {
                return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
            }
            var ch = function() {
                ch.c(arguments);
            };
            ch.q = [];
            ch.c = function(args) {
                ch.q.push(args);
            };
            w.ChannelIO = ch;
            function l() {
                if (w.ChannelIOInitialized) {
                    return;
                }
                w.ChannelIOInitialized = true;
                var s = document.createElement('script');
                s.type = 'text/javascript';
                s.async = true;
                s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
                s.charset = 'UTF-8';
                var x = document.getElementsByTagName('script')[0];
                x.parentNode.insertBefore(s, x);
            }
            if (document.readyState === 'complete') {
                l();
            } else if (window.attachEvent) {
                window.attachEvent('onload', l);
            } else {
                window.addEventListener('DOMContentLoaded', l, false);
                window.addEventListener('load', l, false);
            }
        })();
        ChannelIO('boot', {
            "pluginKey": "235cd768-4afe-4ebc-bcd1-e7448b26e366"
        });
    </script>
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



<div class="container" style="height: 150px">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="btn-group" role="group" aria-label="Basic outlined example">
                <% if(session.getAttribute("SS_USER_ID") == null){%>

                <input type="button" class ="btn btn-outline-primary" value="로그인" onclick="location.href='/user/LoginForm'">

                <input type="button" class ="btn btn-outline-primary" value="회원가입" onclick="location.href='/user/UserRegForm'">


                <input type="button" class ="btn btn-outline-primary" value="커뮤니티" onclick="location.href='/notice/NoticeList'">

                <%}else if(session.getAttribute("SS_USER_ID").equals("admin")){%>
                <input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">

                <input type="button" class ="btn btn-outline-primary" value="커뮤니티" onclick="location.href='/notice/NoticeList'">

                <input type="button" class ="btn btn-outline-primary" value="크롤링 결과 확인" onclick="location.href='/main/mainList'">

                <input type="button" class ="btn btn-outline-primary" value="회원관리" onclick="location.href='/user/UserManagement'">

                <%}else{%>
                <input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">

                <input type="button" class ="btn btn-outline-primary" value="커뮤니티" onclick="location.href='/notice/NoticeList'">

                <%}%>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12">
<table class="table table-striped table-bordered mt-4">
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
  <%--  <tr>
        <td colspan="8" align="center"><a href="<%=CmmUtil.nvl(rDTO.getUrl()) %>"><%=CmmUtil.nvl(rDTO.getUrl()) %></a>
        </td>
    </tr>--%>
    <tr>

        <td align="center"><a href = "<%=CmmUtil.nvl(rDTO.getUrl()) %>"><%=CmmUtil.nvl(rDTO.getC_name()) %></a>

        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getArea()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getDeadline().substring(0,10)) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getCandidate()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getOrganizer()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getS_year().substring(0,10)) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getB_year()) %>
        </td>
        <td align="center"><%=CmmUtil.nvl(rDTO.getR_date().substring(0,10)) %>
        </td>

    </tr>

    <%
        }
    %>
</table>
        </div>
    </div>
</div>
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
</body>
</html>