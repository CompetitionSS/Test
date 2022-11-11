<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그인 화면</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

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

<br/>
<form name="f" method="post" action="/user/getUserLoginCheck" onsubmit="return doLoginUserCheck(this);">
    <div class="container-fluid">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <h1 style="text-align: center">"   " <span class="badge bg-secondary">" "</span></h1>
            </div>
            <div class="col-md-4">
            </div>
        </div>
        <div class="container">
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
        </div>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="form-floating mb-3">
                    <input type="text" name="user_id" class="form-control" id="floatinguser_id" placeholder="user_id">
                    <label for="floatinguser_id">"ID"를 입력하세요.</label>
                </div>
                <div class="form-floating">
                    <input type="password" name="password" class="form-control" id="floatingpassword" placeholder="Password">
                    <label for="floatingpassword">"Password"를 입력하세요.</label>
                </div>
                <br/>
                <button type="submit" class="btn btn-primary" value="login">
                    로그인
                </button>
                <button type="button" class="btn btn-primary" onclick="location='/user/UserRegForm'"  value="회원가입">
                    회원가입
                </button><br><br>
                <button type="button" class="btn btn-primary" onclick="location='/user/LoginidSearch'"  value="아이디 비밀번호 찾기">
                    아이디&nbsp;/&nbsp; 비밀번호 찾기
                </button>

            </div>
            <div class="col-md-4">
            </div>
        </div>




    </div>
    </div>



</form>
</body>
</html>