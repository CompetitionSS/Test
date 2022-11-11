<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String user_id = (String) session.getAttribute("SS_USER_ID");
    String msg = user_id+"님이 로그아웃 되었습니다.";
    session.removeAttribute("SS_USER_ID");
%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <meta charset="UTF-8" />
    <meta http-equiv="refresh" content="2; /main/main">
    <title>로그아웃</title>
    <%--<meta http-equiv="refresh" content="2; /main/main">--%>

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
           <div>메인 페이지로 이동합니다.</div>
        </div>
    </div>
</div>
</body>
</html>
    