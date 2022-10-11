<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="icon" href="../img/favicon.ico" type="image/x-icon" />
    <title>constory - 너를 위한 공모전  </title>
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
        <img src="../img/asd.gif" alt="사이트 로고" />
    </a>
    <h2>공모전 검색</h2>
    <form name="ex" method="get" action="https://www.constory.com/index.do">
    </form>
    <div class="container">
        <div class="subject" style="display:flex;">
            전체&nbsp;&nbsp;
            <h2 style="text-align:center;">공모전 찾기</h2>

        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">공모전명</div></div>
            <div class="row-content"><div class="centered-text"><input type="text" placeholder="ex) 데이터" value="" autofocus="" size="20" maxlength="10"></div></div>
            <div class="row-title"><div class="centered-text">날짜로 검색</div></div>
            <div class="row-content"><div class="centered-text">
                <input type="date"></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">주최지역</div></div>
            <div class="row-content"><div class="centered-text">
                <select name="addr" size="1">

                    <option value="s2">서울시
                    </option>
                    <option value="s3">경기도
                    </option>
                    <option value="s4">충청남도
                    </option>
                    <option value="s5">충청북도
                    </option>
                    <option value="s6">강원도
                    </option>
                    <option value="s7">제주도
                    </option>
                </select><input type="text" name="home" value="" size="20" maxlength="5"></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">마감일</div></div>
            <div class="row-content"><div class="centered-text"><select name="addr" size="1">

                <option value="c1">1월
                </option>
                <option value="c2">2월
                </option>
                <option value="c3">3월
                </option>
                <option value="c4">4월
                </option>
                <option value="c1">5월
                </option>
                <option value="c2">6월
                </option>
                <option value="c3">7월
                </option>
                <option value="c4">8월
                </option>
                <option value="c1">9월
                </option>
                <option value="c2">10월
                </option>
                <option value="c3">11월
                </option>
                <option value="c4">12월
                </option>

            </select><input type="text" name="home" value="" size="20" maxlength="5"></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">응시대상자</div></div>
            <div class="row-content"><div class="centered-text"><select name="addr" size="1">
                <option value="t"> 전체
                </option>
                <option value="t1"> 청소년
                </option>
                <option value="t2"> 대학생
                </option>


            </select></div></div>
            <div class="row-title"><div class="centered-text">연도</div></div>
            <div class="row-content"><div class="centered-text"><input type="" placeholder="20xx"></div></div>
        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">주최사</div></div>
            <div class="row-content"><div class="centered-text">
                <input type="checkbox" name="host" value="h1" checked="">
                전체<br>
                <input type="checkbox" name="host" value="h1">정부/공공기관<br>
                <input type="checkbox" name="host" value="h1">대기업<br>
                <input type="checkbox" name="host" value="h1">중견/중소/벤처기업
                <br>
                <input type="checkbox" name="host" value="h1">비영리/협회/재단
                <br>
            </div></div>

            <div class="row-title"><div class="centered-text">검색 기준일</div></div>
            <div class="row-content"><div class="centered-text">2022-09-29</div>
            </div>



        </div>
        <div class="row">
            <div class="row-title"><div class="centered-text">미리보기</div></div>
            <div class="row-content"><div class="centered-text">
                <textarea cols="15" rows="10" name="memo">      </textarea>
            </div></div>
        </div>
    </div><br>
    <center>
        <input type="submit" value="공모전 검색"></center></div>
</body>
</html>
