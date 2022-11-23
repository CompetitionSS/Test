<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 화면</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>

<br/>

<form name="f" method="post" action="/user/insertUserInfo" onsubmit="return doRegUserCheck(this);">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
            </div>
            <div class="col-md-4">
                <a href="/main/main" style="text-decoration: none"> <h1 style="text-align: center" >"constory" <span class="badge bg-secondary">"회원가입"</span></h1></a>

            </div>
            <div class="col-md-4">
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <label for="validationServer01" class="form-label">* 아이디 : <input class="form-control" id="validationServer01" type="text" name="user_id" style="width:400px"/></label><br/>
                <label for="validationServer02" class="form-label">* 이름 : <input class="form-control" id="validationServer02" type="text" name="user_name" style="width:400px"/></label><br/>

                <label  for="validationServerUserpass" class="form-label">* 비밀번호 : <input class="form-control" id="validationServerUserpass" type="password" name="password" style="width:400px"/></label><br/>
                <label  for="validationServerUserpass2" class="form-label">* 비밀번호확인 : <input class="form-control" id="validationServerUserpass2" type="password" name="password2" style="width:400px"/></label><br/>

                <label for="validationServerUseremail" class="form-label">* 이메일 : <input class="form-control" id="validationServerUseremail" type="email" name="email" style="width:400px"/> </label><br/>

                <button class="btn btn-primary" type="submit">회원가입</button>
            </div>
            <div class="col-md-4">
            </div>
        </div>
    </div>
</form>
</body>
</html>
