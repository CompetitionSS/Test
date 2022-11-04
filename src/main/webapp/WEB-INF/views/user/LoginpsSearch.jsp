<%@ page import="pcs.css.dto.UserInfoDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    UserInfoDTO rDTO =(UserInfoDTO) request.getAttribute("rDTO");
    String user_id = null;
    if(rDTO == null){
        rDTO = new UserInfoDTO();
    }else {
        user_id  = rDTO.getUser_id();
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>웹 페이지 제목</title>
</head>
<body>
<form name = "search" method="get" action="/user/find_ps">
    <div class="container-field">
        <div class="container">
           <div>이메일 : </div><input type="text" class ="" name="email"><br>
            <div>아이디 : </div><input type="text" class ="" name="user_id">
            <button class="btn btn-primary" type="submit" >비밀번호 찾기</button>
        </div>
    </div>
    <div>
        <%if(user_id != null){
            out.print(user_id);
        }%>
    </div>
</form>
</body>
</html>
    