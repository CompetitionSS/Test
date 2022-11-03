<%@ page import="org.apache.ibatis.jdbc.Null" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />

    <div>

        <form method="post" action="/reply/write">

            <p>
                <label>댓글 작성자</label> <input type="text" name="writer">
            </p>
            <p>
                <textarea rows="5" cols="50" name="content"></textarea>
            </p>
            <p>
                <button type="submit">댓글 작성</button>
            </p>
        </form>

    </div>
    </script>



    <style type="text/css">
        body {
            min-height: 100vh;
            font-family: sans-serif;
        }
        .header {
            padding: 10px;
        }
        .container {
            width: 80%;
            border: 1px solid #ccc;
        }
        .subject {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f6f6f6;
        }
        .row {
            display: flex;
            min-height: 50px;
        }
        .row-title {
            display: flex;
            justify-content: center;
            min-width: 140px;
            width: fit-content;
            text-align: center;
            background-color: #f6f6f6;
            font-weight: bold;
            white-space: nowrap;
            border-top: 1px solid #ccc;
            border-right: 1px solid #ccc;

        }
        .centered-text {
            margin: auto 0;
            padding: 10px;
        }
        .row-content {
            display: flex;
            align-items: center;
            width: 100%;
            border-top: 1px solid #ccc;
            border-right: 1px solid #ccc;
        }
    </style>

</head>
<body>
<div class="header">
    <a href="main">
        <img src="" alt="사이트 로고" />
    </a>
    <h2>공모전 검색</h2>
    <div class="mybox">
        <% if(session.getAttribute("SS_USER_ID") == null){%>
    <div id="user-box">
        <input type="button" class ="login-box" value="로그인" onclick="location.href='/user/LoginForm'">
    </input>
        <input type="button" class ="signup-box" value="회원가입" onclick="location.href='/user/UserRegForm'">
        </input></div>
    <%}else{%>
<div id="logout-box">
    <input type="button" class ="login-box" value="로그아웃" onclick="location.href='/user/LogOut'">
    </input>
</div> <%}%>
</div>
<div>
<input type="button" class ="signup-box" value="커뮤니티" onclick="location.href='/notice/NoticeList'">
</input>

</div>

    <form name="ex" method="get" action="/main/searchMain">

    <div class="container">
        <div class="subject" style="display:flex;">
            전체&nbsp;&nbsp;
            <h2 style="text-align:center;">공모전 찾기</h2>

        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">공모전명</div></div>
            <div class="row-content"><div class="centered-text"><input type="text" placeholder="ex) 데이터" autofocus=""  name="c_name" size="20" maxlength="10"></div></div>
            <div class="row-title"><div class="centered-text">날짜로 검색</div></div>
            <div class="row-content"><div class="centered-text">
                <input type="date" name = "s_year"></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">주최지역</div></div>
            <div class="row-content"><div class="centered-text">
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
                    <option>강원도
                    </option>
                    <option>제주도
                    </option>
                </select><input type="text" name="area2" value="" size="20" maxlength="5"></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">마감일</div></div>
            <div class="row-content"><div class="centered-text"><select name="deadline" size="1">
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

            </select><a style="font-size:14px"> 월</a>
                <input type="text" name="deadline2" value="" size="20" maxlength="5"> <a style="font-size:14px"> 일</a></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">응시대상자</div></div>
            <div class="row-content"><div class="centered-text"><select name="candidate" size="1">
                <option value="전체">전체
                </option>
                <option value="청소년"> 청소년
                </option>
                <option value="대학생"> 대학생
                </option>


            </select></div></div>
            <div class="row-title"><div class="centered-text">연도</div></div>
            <div class="row-content"><div class="centered-text"><input type="" name="b_year"  placeholder="20xx"></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">주최사</div></div>
            <div class="row-content"><div class="centered-text">
                <input type="checkbox" name="organizer"  onclick="checkall(this)">
                전체<br>
                <input type="checkbox" name="organizer" value="1" >정부/공공기관<br>
                <input type="checkbox" name="organizer" value="2" >대기업<br>
                <input type="checkbox" name="organizer" value="3">중견/중소/벤처기업
                <br>
                <input type="checkbox" name="organizer" value="4">비영리/협회/재단
                <br>
            </div></div>

            <div class="row-title"><div class="centered-text">검색 기준일</div></div>
            <div class="row-content"><div class="centered-text">2022-09-29</div>
            </div>



        </div>
        <center> <input type="submit" value="공모전 검색"></center>
    </div><br></form>

        </div>

</body>
</html>
