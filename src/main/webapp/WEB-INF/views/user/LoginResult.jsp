<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%
    //Controller에 저장된 세션으로 로그인할때 생성됨
    String SS_USER_ID = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

    String res = CmmUtil.nvl((String) request.getAttribute("res"));

    String msg = "";

    if (res.equals("1")) {
        msg = SS_USER_ID + "님이 로그인 되었습니다.";
        session.setAttribute("SS_USER_ID",SS_USER_ID);
    } else if (res.equals("0")) {
        msg = "아이디, 비밀번호가 일치하지 않습니다.";

    } else {
        msg = "시스템에 문제가 발생하였습니다. 잠시후 다시 시도하여 주시길 바랍니다.";

    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <meta charset="UTF-8">
    <%if(res.equals("1")){


    %>
     <meta http-equiv="refresh" content="2; /main/main">
        <%

    }else{%>
    <meta http-equiv="refresh" content="2; /user/LoginForm">
    <%}%>
    <title><%=msg%></title>
</head>
<body>

<div class="container" style="height: 250px">
</div>
<div class="container" style="width: 300px">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="spinner-grow text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <div class="spinner-grow text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <div class="spinner-grow text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <div class="spinner-grow text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12" style="text-align: center">
            <%=msg%>
        </div>
        <div class="col-md-12" style="text-align: center">
            <%if(res.equals("1")){
             %><div>메인 페이지로 이동합니다.</div>
            <% }else{
                %>
            <div>로그인 페이지로 돌아갑니다.</div>
            <%
            }%>

        </div>
    </div>
</div>
</body>
</html>
