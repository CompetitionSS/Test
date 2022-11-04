<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%



    String res = CmmUtil.nvl((String) request.getAttribute("res"));

    String msg = "";

    if (res.equals("1")) {
        msg =  "비밀번호를 이메일로 전송 완료되었습니다.";
    } else if (res.equals("2")) {
        msg = "아이디 또는 이메일이 일치하지 않습니다.";

    } else {
        msg = "시스템에 문제가 발생하였습니다. 잠시후 다시 시도하여 주시길 바랍니다.";

    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <% if(res.equals("1")){
        %> <meta http-equiv="refresh" content="2; /user/LoginForm">
    <%}else{
        %> <meta http-equiv="refresh" content="2; /user/LoginpsSearch">
     <%} %>

    <title><%=msg%></title>
</head>
<body>
<%=msg %>
</body>
</html>
