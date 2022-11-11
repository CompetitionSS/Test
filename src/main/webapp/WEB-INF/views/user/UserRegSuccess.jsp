<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%@ page import="pcs.css.dto.UserInfoDTO" %>
<%
    //Controller로부터 전달받은 데이터
    String msg = CmmUtil.nvl((String) request.getAttribute("msg"));

    //Controller로부터 전달받은 웹(회원정보 입력화면)으로부터 입력받은 데이터(회원아이디, 이름, 이메일, 주소 등)
    UserInfoDTO pDTO = (UserInfoDTO) request.getAttribute("pDTO");

    if (pDTO == null) {
        pDTO = new UserInfoDTO();

    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <meta charset="UTF-8" />
    <<meta http-equiv="refresh" content="2; url=/user/LoginForm">

    <script type="text/javascript">
        alert("<%=msg%>");
    </script>
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
<%=CmmUtil.nvl(pDTO.getUser_name()) %>님의 회원가입을 축하드립니다.
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" style="text-align: center">
            2초뒤에 로그인 페이지로 이동합니다.
        </div>
    </div>
</div>

</body>
</html>