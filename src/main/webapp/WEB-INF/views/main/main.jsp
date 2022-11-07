<%@ page import="org.apache.ibatis.jdbc.Null" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <meta charset="UTF-8" />
    <link rel="icon" href="" type="image/x-icon" />
    <title>constory - 너를 위한 공모전  </title>
    <script type="text/javascript">
        function checkall (f){
            const checkboxes = document.getElementsByName('organizer');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = f.checked
            })
        }


    </script>






</head>
<script src="/js/jquery-3.6.1.min.js" type="text/javascript"></script>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <a href="main"> <h1 style="text-align: center">"   " <span class="badge bg-secondary">" "</span></h1></a>
        </div>
        <div class="col-md-4">
        </div>
    </div>


    <div class="col-md-4">
    </div>
</div>
</div>


<div class="container" style="height: 150px">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="btn-group" role="group" aria-label="Basic outlined example">
                <% if(session.getAttribute("SS_USER_ID") == null){%>

                <input type="button" class ="btn btn-outline-primary" value="로그인" onclick="location.href='/user/LoginForm'">

                <input type="button" class ="btn btn-outline-primary" value="회원가입" onclick="location.href='/user/UserRegForm'">


                <input type="button" class ="btn btn-outline-primary" value="커뮤니티" onclick="location.href='/notice/NoticeList'">

                <%}else{%>
                <input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">

                <input type="button" class ="btn btn-outline-primary" value="커뮤니티" onclick="location.href='/notice/NoticeList'">

                <%}%>
            </div>
        </div>
    </div>
</div>












<form name="ex" method="get" action="/main/searchMain">

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <%--공모전명 검색--%>
                <div class="input-group mb-3">
                    <span class="input-group-text" style="text-align: center" id="inputGroup-sizing-default">공모전명 검색</span>
                    <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" placeholder="ex) 데이터" autofocus=""  name="c_name" size="20" maxlength="10">
                </div>
            </div>
        </div>
    </div>





<%--날짜검색--%>
    <div class="container">
      <div class="row">
        <div class="col-md-6">
            <div class="input-group mb-3">
                <span class="input-group-text" style="text-align: center" id="inputGroup-sizing-default">날짜로 검색</span>
            <input type="date" name = "s_year" value="2022-01-01" >
            <div><input type="checkbox" id ="s_year2" name="s_year2" value="2" >선택 </div>
            </div>
      </div>
    <%--지역명 검색--%>
    <div class="col-md-6">
        <div class="input-group mb-3">
            <span class="input-group-text" style="text-align: center" id="inputGroup-sizing-default">지역</span>
            <select name="area" size="1" >
                <option >전체
                </option>
                <option>서울시
                </option>
                <option>경기도
                </option>
                <option>충청남도
                </option>
                <option>충청북도
                </option>
                <option>전라남도
                </option>
                <option>전라북도
                </option>
                <option>경상남도
                </option>
                <option>경상북도
                </option>
                <option>강원도
                </option>
                <option>제주도
                </option>
            </select>
            <input type="text" name="area2" value="" size="20" maxlength="5" placeholder="직접입력" >
        </div>
    </div>
    </div>
    </div>







<div class="container">
    <div class="row">
        <%--마감일--%>
        <div class="col-md-12">
            <div class="input-group mb-3">
                <span class="input-group-text">마감일</span>
                <select name="deadline" size="1">
                    <option>전체
                    </option>
                    <option>1
                    </option>
                    <option>2
                    </option>
                    <option>3
                    </option>
                    <option>4
                    </option>
                    <option>5
                    </option>
                    <option>6
                    </option>
                    <option>7
                    </option>
                    <option>8
                    </option>
                    <option>9
                    </option>
                    <option>10
                    </option>
                    <option>11
                    </option>
                    <option>12
                    </option>
                </select>
            <input type="text" name="deadline2" value="" size="20" maxlength="5" aria-label="First name" class="form-control" placeholder="직접입력">
    </div>
    </div>
</div>
</div>






    <%--응시대상자--%>
    <div class="container">
    <div class="row">
        <div class="col-md-6">
            <div class="input-group mb-3">
                <span class="input-group-text" style="text-align: center" id="inputGroup-sizing-default">지원 대상</span>

                <select name="candidate" size="1">
                <option value="전체">전체
                </option>
                <option value="청소년"> 청소년
                </option>
                <option value="대학생"> 대학생
                </option>
            </select></div>
        </div>






            <%--연도--%>
            <div class="col-md-6">
                <div class="input-group mb-3">
                    <span class="input-group-text" style="text-align: center" id="inputGroup-sizing-default">연도</span>
                <input type="" value="" name="b_year"  placeholder="연도 4자리만 입력"></div>
            </div>
            </div>
            </div>







    <%--주최사--%>
    <div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="input-group">
                <span class="input-group-text" style="text-align: center" id="inputGroup-sizing-default">주최사</span>
            <div class="form-check">
                <input type="checkbox" name="organizer" checked="checked"  onclick="checkall(this)">
                전체<br>
                <input type="checkbox" name="organizer" checked="checked" value="1" >정부/공공기관<br>
                <input type="checkbox" name="organizer" checked="checked" value="2" >대기업<br>
                <input type="checkbox" name="organizer" checked="checked" value="3">중견/중소/벤처기업
                <br>
                <input type="checkbox" name="organizer" checked="checked" value="4">비영리/협회/재단
                <br>
        </div>
    </div>
    </div>
    </div>
    </div>

          <%--  <div class="row-title"><div class="centered-text" >검색 기준일</div></div>
            <div class="row-content"><div class="centered-text" id="year2"></div> --%>


    <div class="row">
        <div class="col-md-6">
        </div>
        <div class="col-md-6">
            <button class="btn btn-primary" type="submit" style="">검색</button>
        </div>
    </div>


    <br>
</form>


<script>
    $( document ).ready( function() {
        $("#s_year2").change(function () {
            if ($("#s_year2").prop("checked")) {
                $("#s_year2").val(1);
                console.log($("#s_year2").val());
            } else {
                $("#s_year2").val(2);
                console.log($("#s_year2").val());
            }
        });
    });

</script>
</body>
</html>
