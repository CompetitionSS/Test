<%@ page import="pcs.css.util.CmmUtil" %>
<%@ page import="pcs.css.dto.UserInfoDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    UserInfoDTO rDTO =(UserInfoDTO) request.getAttribute("rDTO");
    String user_id = null;
    if(rDTO == null){
        rDTO = new UserInfoDTO();
    }else {
     user_id  = rDTO.getUser_id();
    }

%>
<html>
<head>
    <meta charset="utf-8">
    <title>웹 페이지 제목</title>
</head>
<body>
    <form name = "search" method="get" action="/user/find_id">
        <div class="container-field">
            <div class="container">
                <input type="text" class ="" name="email">
                <button class="btn btn-primary" type="submit" >아이디 찾기</button>
            </div>
        </div>

    </form>
</body>
</html>
    