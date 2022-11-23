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
    <title>로그인 화면</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
            crossorigin="anonymous"
    />

    <meta charset="utf-8">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4">
            <a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
        </div>
        <div class="col-md-4">
            <a href="/main/main" style="text-decoration: none"> <h1 style="text-align: center">"constory" <span class="badge bg-secondary">"아이디 / 비밀번호 찾기"</span></h1></a>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</div>
<section class="vh-100" style="background-color: hsl(0, 0%, 96%)">

    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-xl-10">
                <div class="card" style="border-radius: 1rem">
                    <div class="row g-0">
                        <div class="col-md-12 col-lg-12 d-flex align-items-center">
                            <div class="card-body p-4 p-lg-5 text-black">
                                <form name = "search" method="get" action="/user/find_id">
                                    <h5 class="fw-bold pb-3" style="letter-spacing: 1px">이메일 주소로 계정 찾기</h5>
                                    <p class="small text-muted">회원정보에 등록된 메일 주소로 아이디를 알려드립니다. 메일 주소를 입력하고 "아이디 찾기" 버튼을 클릭해 주세요.</p>

                                    <div class="form-outline form-floating mb-4">
                                        <input type="email" name="email" class="form-control form-control-lg" id="floatinguser_id" placeholder="user_id" />
                                        <label for="floatinguser_id">이메일 주소</label>
                                    </div>

                                    <div class="pt-1 mb-4">
                                        <button type="submit" class="btn btn-primary">아이디 찾기</button>
                                    </div>
                                </form>

                                <hr class="hr mt-5 mb-5" />
                                <h5 class="fw-bold pb-3" style="letter-spacing: 1px">이메일 주소와 아이디로 비밀번호 찾기</h5>
                                <p class="small text-muted">회원정보에 등록된 메일 주소로 비밀번호를 알려드립니다. 메일 주소와 아이디를 입력하고 "비밀번호 찾기" 버튼을 클릭해 주세요.</p>
                                <form name = "search" method="get" action="/user/find_ps">


                                            <div class="form-outline form-floating mb-4">
                                            <input type="email" name="email" class="form-control form-control-lg" id="floatingemail" placeholder="이메일 주소" /><br>
                                            <label for="floatingemail">이메일 주소</label>
                                            </div>
                                    <div class="form-outline form-floating mb-4">
                                            <input type="text" name="user_id" class="form-control form-control-lg" id="floatingid" placeholder="아이디  " /><br>
                                              <label for="floatingid">아이디</label>
                                            <button class="btn btn-primary" type="submit" >비밀번호 찾기</button>
                                    </div>


                                    <div>
                                        <%if(user_id != null){
                                            out.print(user_id);
                                        }%>
                                    </div>
                                </form>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>