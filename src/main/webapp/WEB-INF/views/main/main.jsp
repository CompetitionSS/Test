<%@ page import="pcs.css.util.CmmUtil" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.dto.MainDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    boolean prev = (boolean) request.getAttribute("prev");
    boolean next = (boolean) request.getAttribute("next");

    int startPageNum = (int) request.getAttribute("startPageNum");
    int endPageNum = (int) request.getAttribute("endPageNum");
    int select = (int) request.getAttribute("select");
    List<MainDTO> mList = (List<MainDTO>) request.getAttribute("mList");
    MainDTO pDTO = (MainDTO) request.getAttribute("pDTO");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        #floatMenu {
            position: absolute;
            width: 100px;
            height: 100px;
            right: 100px;
            top: 150px;

            color: #fff;
            float:right;
        }
        #MOVE_TOP_BTN {
            position: fixed;
            right: 2%;
            bottom: 100px;
            z-index: 999;
        }


    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <meta charset="UTF-8" />
    <link rel="icon" href="" type="image/x-icon" />
    <title>constory - 너를 위한 공모전  </title>
    <script src="../js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <!-- Channel Plugin Scripts -->
    <script>
        (function() {
            var w = window;
            if (w.ChannelIO) {
                return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
            }
            var ch = function() {
                ch.c(arguments);
            };
            ch.q = [];
            ch.c = function(args) {
                ch.q.push(args);
            };
            w.ChannelIO = ch;
            function l() {
                if (w.ChannelIOInitialized) {
                    return;
                }
                w.ChannelIOInitialized = true;
                var s = document.createElement('script');
                s.type = 'text/javascript';
                s.async = true;
                s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
                s.charset = 'UTF-8';
                var x = document.getElementsByTagName('script')[0];
                x.parentNode.insertBefore(s, x);
            }
            if (document.readyState === 'complete') {
                l();
            } else if (window.attachEvent) {
                window.attachEvent('onload', l);
            } else {
                window.addEventListener('DOMContentLoaded', l, false);
                window.addEventListener('load', l, false);
            }
        })();
        ChannelIO('boot', {
            "pluginKey": "235cd768-4afe-4ebc-bcd1-e7448b26e366"
        });
    </script>
    <script type="text/javascript">
        function checkall (f){
            const checkboxes = document.getElementsByName('organizer2');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = f.checked
            })
        }


    </script>






</head>
<body>
<div class="back-to-top pointer" id="MOVE_TOP_BTN" onclick="scrollToTop();return false;">
    <input class="btn btn-primary btn-sm"  value="위로">
</div>
<meta name="viewport" content="width=device-width,initial-scale=1">
<div id ="floatMenu">
    <div class = "">
        <ul>
            <% if (session.getAttribute("SS_USER_ID") == null) {%>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="로그인"
                   onclick="location.href='/user/LoginForm'">
            </li>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="회원가입"
                   onclick="location.href='/user/UserRegForm'">
            </li>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="커뮤니티"
                   onclick="location.href='/notice/NoticeList'">
            </li>
            <%} else if (session.getAttribute("SS_USER_ID").equals("admin")) {%>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="로그아웃"
                   onclick="location.href='/user/LogOut'">
            </li>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="커뮤니티"
                   onclick="location.href='/notice/NoticeList'">
            </li>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="크롤링 결과 확인"
                   onclick="location.href='/main/mainCrawling'">
            </li>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="회원관리"
                   onclick="location.href='/user/UserManagement'">
            </li>
            <%} else {%>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="로그아웃"
                   onclick="location.href='/user/LogOut'">
            </li>
            <li class="li3">
            <input type="button" class="btn btn-outline-primary" value="커뮤니티"
                   onclick="location.href='/notice/NoticeList'">
            </li>
            <%}%>
        </ul>
    </div>

</div>

<div class="container">
    <div class="row">


        <div class="col-md-4">
            <a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
        </div>
        <div class="col-md-4">
            <a href="/main/main" style="text-decoration: none"><h1 style="text-align: center">"constory" <span
                    class="badge bg-secondary">"너를 위한 공모전 "</span></h1></a>
        </div>
    <div class="col-md-4"></div>

      </div>
    </div>



    <div class="container">
        <div class="row">
            <div class="col-12">

            </div>
        </div>
    </div>

    <%--<div class="container" style="height: 150px">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="btn-group" role="group" aria-label="Basic outlined example">
                    <% if (session.getAttribute("SS_USER_ID") == null) {%>

                    <input type="button" class="btn btn-outline-primary" value="로그인"
                           onclick="location.href='/user/LoginForm'">

                    <input type="button" class="btn btn-outline-primary" value="회원가입"
                           onclick="location.href='/user/UserRegForm'">


                    <input type="button" class="btn btn-outline-primary" value="커뮤니티"
                           onclick="location.href='/notice/NoticeList'">

                    <%} else if (session.getAttribute("SS_USER_ID").equals("admin")) {%>
                    <input type="button" class="btn btn-outline-primary" value="로그아웃"
                           onclick="location.href='/user/LogOut'">

                    <input type="button" class="btn btn-outline-primary" value="커뮤니티"
                           onclick="location.href='/notice/NoticeList'">

                    <input type="button" class="btn btn-outline-primary" value="크롤링 결과 확인"
                           onclick="location.href='/main/mainCrawling'">

                    <input type="button" class="btn btn-outline-primary" value="회원관리"
                           onclick="location.href='/user/UserManagement'">

                    <%} else {%>
                    <input type="button" class="btn btn-outline-primary" value="로그아웃"
                           onclick="location.href='/user/LogOut'">

                    <input type="button" class="btn btn-outline-primary" value="커뮤니티"
                           onclick="location.href='/notice/NoticeList'">

                    <%}%>
                </div>
            </div>
        </div>
    </div>--%>


    <form name="ex" method="get" action="/main/searchMain">

        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <%--공모전명 검색--%>
                    <div class="input-group mb-3">
                        <span class="input-group-text" style="text-align: center"
                              id="inputGroup-sizing-default">공모전명 검색</span>
                        <input type="text" class="form-control" aria-label="Sizing example input"
                               aria-describedby="inputGroup-sizing-default" placeholder="ex) 데이터" autofocus=""
                               name="c_name" size="20" maxlength="10">
                    </div>
                </div>
            </div>
        </div>


        <%--날짜검색--%>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group mb-3">
                        <span class="input-group-text" style="text-align: center"
                              id="inputGroup-sizing-default">날짜로 검색</span>
                        <input type="date" name="s_year" value="2022-01-01">
                        <div><input type="checkbox" id="s_year2" name="s_year2" value="2">선택</div>
                    </div>
                </div>
                <%--지역명 검색--%>
                <div class="col-md-6">
                    <div class="input-group mb-3">
                        <span class="input-group-text" style="text-align: center"
                              id="inputGroup-sizing-default">지역</span>
                        <select name="area" size="1">
                            <option>전체
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
                        <input type="text" name="area2" value="" size="20" maxlength="5" placeholder="직접입력">
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
                        <input type="text" name="deadline2" value="" size="20" maxlength="5" aria-label="First name"
                               class="form-control" placeholder="직접입력">
                    </div>
                </div>
            </div>
        </div>


        <%--응시대상자--%>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group mb-3">
                        <span class="input-group-text" style="text-align: center"
                              id="inputGroup-sizing-default">지원 대상</span>

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
                        <span class="input-group-text" style="text-align: center"
                              id="inputGroup-sizing-default">연도</span>
                        <input type="" value="" name="b_year" placeholder="연도 4자리만 입력"></div>
                </div>
            </div>
        </div>


        <%--주최사--%>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="input-group">
                        <span class="input-group-text" style="text-align: center"
                              id="inputGroup-sizing-default">주최사</span>
                        <div class="form-check">
                            <input type="checkbox" name="organizer2" checked="checked" onclick="checkall(this)">
                            전체<br>
                            <input type="checkbox" name="organizer2" checked="checked" value="1">정부/공공기관<br>
                            <input type="checkbox" name="organizer2" checked="checked" value="2">대기업<br>
                            <input type="checkbox" name="organizer2" checked="checked" value="3">중견/중소/벤처기업
                            <br>
                            <input type="checkbox" name="organizer2" checked="checked" value="4">비영리/협회/재단
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--  <div class="row-title"><div class="centered-text" >검색 기준일</div></div>
          <div class="row-content"><div class="centered-text" id="year2"></div> --%>

        <div class="container">
            <div class="row">
                <div class="col-md-6">
                </div>
                <div class="col-md-6">
                    <button class="btn btn-primary btn-lg" type="submit" style="float: right">검색</button>
                </div>
            </div>
        </div>


        <br>
    </form>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped table-bordered mt-4">
                    <tr>
                        <td width="300" height="90" align="center">공모전명</td>
                        <td width="200" align="center">지역</td>
                        <td width="300" align="center">마감일</td>
                        <td width="200" align="center">응시대상자</td>
                        <td width="200" align="center">주최사</td>
                        <td width="300" align="center">시작 날짜</td>
                        <td width="150" align="center">연도</td>
                        <td width="300" align="center">검색 기준일</td>


                    </tr>
                    <%
                        for (int i = 0; i < mList.size(); i++) {
                            MainDTO rDTO = mList.get(i);

                            if (rDTO == null) {
                                rDTO = new MainDTO();
                            }

                    %>

                    <tr>

                        <td align="center"><a href="<%=CmmUtil.nvl(rDTO.getUrl()) %>"
                                              style="text-decoration: none"><%=CmmUtil.nvl(rDTO.getC_name()) %>
                        </a>

                        </td>
                        <td align="center"><%=CmmUtil.nvl(rDTO.getArea()) %>
                        </td>
                        <td align="center"><%=CmmUtil.nvl(rDTO.getDeadline().substring(0, 10)) %>
                        </td>
                        <td align="center"><%=CmmUtil.nvl(rDTO.getCandidate()) %>
                        </td>
                        <td align="center"><%=CmmUtil.nvl(rDTO.getOrganizer()) %>
                        </td>
                        <td align="center"><%=CmmUtil.nvl(rDTO.getS_year().substring(0, 10)) %>
                        </td>
                        <td align="center"><%=CmmUtil.nvl(rDTO.getB_year()) %>
                        </td>
                        <td align="center"><%=CmmUtil.nvl(rDTO.getR_date().substring(0, 10)) %>
                        </td>
                    </tr>


                    <%
                        }
                    %>
                </table>
            </div>
        </div>
    </div>


    <div style="text-align: center; margin-bottom: 50px;">
        <% if (prev) {%>
        <button type="button" class="btn btn-secondary" onclick="location.href='/main/main?num=<%=select-1%>'">Prev
        </button>
        <%}%>
        <div class="btn-group " style="margin: 0 auto; display: inline-block;">
            <% for (int i = startPageNum; i <= endPageNum; i++) {
                if (select == i) {%>
            <a style="color: red;" href="/main/main?num=<%=i%>">
                <button class="btn btn-secondary">
                    <%=i%>
                </button>
            </a>
            <%} else {%>
            <a style="" href="/main/main?num=<%=i%>">
                <button class="btn btn-secondary">
                    <%=i%>
                </button>
            </a>
            <% }
            } %>
        </div>
        <% if (next) {%>
        <button type="button" class="btn btn-secondary" onclick="location.href='/main/main?num=<%=select+1%>'">Next
        </button>
        <% } %>
    </div>

    <script src="/js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {

            // 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
            var floatPosition = parseInt($("#floatMenu").css('top'));
            // 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

            $(window).scroll(function() {
                // 현재 스크롤 위치를 가져온다.
                var scrollTop = $(window).scrollTop();
                var newPosition = scrollTop + floatPosition + "px";

                /* 애니메이션 없이 바로 따라감
                 $("#floatMenu").css('top', newPosition);
                 */

                $("#floatMenu").stop().animate({
                    "top" : newPosition
                }, 500);

            }).scroll();

        });
        $(document).ready(function () {
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

        /*$(function() {
            $(window).scroll(function() {
                if ($(this).scrollTop() > 500) {
                    $('#MOVE_TOP_BTN').fadeIn();
                } else {
                    $('#MOVE_TOP_BTN').fadeOut();
                }
            });

            $("#MOVE_TOP_BTN").click(function() {
                $('html, body').animate({
                    scrollTop : 0
                }, 400);
                return false;
            });
        });
        var timeOut;
        function scrollToTop() {
            if (document.body.scrollTop!=0 || document.documentElement.scrollTop!=0){
                window.scrollBy(0,-1500);
                timeOut=setTimeout('scrollToTop()',1);
            }
            else clearTimeout(timeOut);
        }*/
        $( document ).ready( function() {
            $( window ).scroll( function() {
                if ( $( this ).scrollTop() > 200 ) {
                    $( '#MOVE_TOP_BTN' ).fadeIn();
                } else {
                    $( '#MOVE_TOP_BTN' ).fadeOut();
                }
            } );
            $( '#MOVE_TOP_BTN' ).click( function() {
                $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
                return false;
            } );
        } );

    </script>
</div>
</body>
</html>
