<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 화면</title>

    <script type="text/javascript">
        //회원가입 정보의 유효성 체크하기
        function doRegUserCheck(f) {

            if (f.user_id.value === "") {
                alert("아이디를 입력하세요.");
                f.user_id.focus();
                return false;
            }

            if (f.user_name.value === "") {
                alert("닉네임을 입력하세요.");
                f.user_name.focus();
                return false;
            }

            if (f.password.value === "") {
                alert("비밀번호를 입력하세요.");
                f.password.focus();
                return false;
            }

            if (f.password2.value === "") {
                alert("비밀번호확인을 입력하세요.");
                f.password2.focus();
                return false;
            }

            if (f.password.value !== f.password2.value) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                f.password.focus();
                return false;
            }

            if (f.email.value === "") {
                alert("이메일을 입력하세요.");
                f.email.focus();
                return false;
            }


        }


    </script>


</head>
<body>
<h1>회원가입 화면</h1>
<br/>
<form name="f" method="post" action="/user/insertUserInfo" onsubmit="return doRegUserCheck(this);">
    <label>* 아이디 : <input type="text" name="user_id" style="width:400px"/></label><br/>
    <label>* 이름 : <input type="text" name="user_name" style="width:400px"/></label><br/>
    <hr/>
    <label>* 비밀번호 : <input type="password" name="password" style="width:400px"/></label><br/>
    <label>* 비밀번호확인 : <input type="password" name="password2" style="width:400px"/></label><br/>
    <hr/>
    <label>* 이메일 : <input type="email" name="email" style="width:400px"/> </label><br/>

    <input type="submit" value="회원가입"/>
</form>
</body>
</html>