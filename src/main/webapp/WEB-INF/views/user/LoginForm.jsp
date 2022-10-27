<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그인 화면</title>

    <script type="text/javascript">

        window.onload = function (){
            let loginEmpty = <%=session%>;
            if(loginEmpty){
                console.log("로그인이 이미 되어있습니다.");
            }

        }
        //로그인을 위한 입력정보의 유효성 체크하기
        function doLoginUserCheck(f) {

            if (f.user_id.value === "") {
                alert("아이디를 입력하세요.");
                f.user_id.focus();
                return false;
            }

            if (f.password.value === "") {
                alert("비밀번호를 입력하세요.");
                f.password.focus();
                return false;
            }

        }
    </script>
</head>
<body>
<h1>로그인 화면</h1>
<br/>
<form name="f" method="post" action="/user/getUserLoginCheck" onsubmit="return doLoginUserCheck(this);">

    <label>아이디 :
        <input type="text" name="user_id" />
    </label><br/>

    <label>비밀번호 :
        <input type="password" name="password" />
    </label>
    <br/>
    <input type="submit" value="로그인"/>
    <input type="button" onclick="location='/user/UserRegForm'" value="회원가입">
</form>
</body>
</html>