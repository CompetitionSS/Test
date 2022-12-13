<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pcs.css.dto.UserInfoDTO" %>
<%@ page import="pcs.css.util.EncryptUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<UserInfoDTO> uList = (List<UserInfoDTO>) request.getAttribute("uList");
    if(uList == null) uList = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>


    <style>
        .grid-adm-members{
            display:grid;
            grid-template-columns:10% 20% 20% 20% 20% 10%;
        }

        .admMemberList > tbody > tr{
            border-top:1px solid #ddd;
            box-sizing:border-box;
        }
        .admMemberList > tbody > tr > th{
            border-top:1px solid #ddd;
            box-sizing:border-box;
        }
        .admMemberList > tbody > tr:first-child{
            border-top:0px;
        }

        .grid-adm-members{
            display:grid;
            grid-template-columns:10% 20% 20% 20% 20% 10%;
        }

        .admMemberList > tbody > tr{
            border-top:1px solid #ddd;
            box-sizing:border-box;
        }

        .admMemberList > tbody > tr:first-child{
            border-top:0px;
        }

        @media screen and (max-width:767px) {
            #aside {
                position: fixed !important;
                top: 0 !important;
                width: 280px !important;
                right: -280px !important;
            }
            .mobile-menu #aside {
                right: 0 !important;
            }
        }


        body {
            background: #f2f2f2;
            font-family: 'Open Sans', sans-serif;
        }

        .search {
            width: 100%;
            display: flex;
        }

        .searchTerm {
            width: 80%;
            border: 3px solid #4B5563;
            border-right: none;
            padding: 5px;
            height: 2.25rem;
            border-radius: 5px 0 0 5px;
            outline: none;
            color: #9DBFAF;
        }

        .searchTerm:focus {
            color: #4B5563;
        }
        #floatMenu {
            position: absolute;
            width: 100px;
            height: 100px;
            right: 10px;
            top: 150px;

            color: #fff;
            float:right;
        }
        .searchButton {
            width: 40px;
            height: 36px;
            border: 1px solid #4B5563;
            background: #4B5563;
            text-align: center;
            color: #fff;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-size: 20px;
        }

        /*Resize the wrap to see the search bar change!*/
        .wrap {
            width: 400px;
            left: 50%;
        }
        .li3{
            margin-top: 20px;
            margin-bottom: 10px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <meta charset="utf-8">
    <title>회원 관리 페이지 - 관리자</title>
</head>
<body>

<!-- 테일윈드 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">

<!-- 데이지UI -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/1.14.2/full.css">

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- 반응형 메타태그 -->
<meta name="viewport" content="width=device-width,initial-scale=1">
    <div id ="floatMenu">
        <div class = "">
            <ul>
                <li class = "li3">
                    <input type="button" class ="btn btn-outline-primary" value="메인페이지" onclick="location.href='/user/LoginForm'">
                </li>
                <li class = "li3">
                    <input type="button" class ="btn btn-outline-primary" value="회원관리" onclick="location.href='/user/UserRegForm'">
                </li>
                <li class = "li3">
                    <input type="button" class ="btn btn-outline-primary" value="게시물관리" onclick="location.href='/notice/NoticeList'">
                </li>
            </ul>
        </div>

    </div>

    <div>
        <div class="shadow-xl border border-gray-200 rounded-xl w-full min-h-screen ml-2 mb-4">

        <div style="text-align: center; margin-top: 1%"><strong>회원관리</strong></div>
            <div style="float: right; margin-top: 1%; margin-bottom: 2%; margin-right: 1.5%;">
                <div class="wrap">
                    <div class="search">
                        <input type="text" class="searchTerm" placeholder="Search">
                        <button type="submit" class="searchButton">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>

            <table class="admMemberList w-11/12 mx-auto mt-4" id="inventory">
            <thead>
            <tr class="bg-gray-600 text-white grid-adm-members text-center font-bold py-2 px-1">
                <th>
                    <input type="checkbox">
                </th>
                <th style="cursor: pointer;">번호</th>
                <th style="cursor: pointer;">아이디</th>
                <th style="cursor: pointer;">이름</th>
                <th style="cursor: pointer;">이메일</th>

                <th style="cursor: pointer;">탈퇴</th>
            </tr>
            </thead>
            <tbody class="shadow">
            <% for (int i = 0; i < uList.size(); i++) { %>
            <tr class="grid-adm-members py-2 px-1 text-center" >
                <td>
                    <input type="checkbox">
                </td>
                <td><%= uList.get(i).getUser_seq()%></td>
                <td><%= uList.get(i).getUser_id()%></td>
                <td><%= uList.get(i).getUser_name()%></td>
                <td><%= EncryptUtil.decAES128CBC(uList.get(i).getEmail())%></td>
                <td>
                    <button type="button" class="btn-primary btn" onclick="deleteid(<%=uList.get(i).getUser_seq()%>)"></button>
                </td>
            </tr>
            <% }%>
            </tbody>
        </table>
    </div>

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
    function deleteid(user_seq){
        $.ajax({
                type:"delete",
                url:"/user/UserDelete",
                data:{user_seq:user_seq},
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                success(){
                    console.log(user_seq+"번째 아이디가 삭제되었습니다.");
                }

        }


        )
    }
    $(document).ready(function(){
        $('#inventory th').each(function (column) {
            $(this).click(function() {
                if($(this).is('.asc')) {      // 현재 오름차순인 경우
                    $(this).removeClass('asc');
                    $(this).addClass('desc');   // 내림차순으로 변경

                    sortdir=-1;

                } else {   // 현재 오름차순 아닌 경우
                    $(this).addClass('asc');   // 오름차순으로 변경
                    $(this).removeClass('desc'); sortdir=1;

                }

                $(this).siblings().removeClass('asc');
                $(this).siblings().removeClass('desc');

                var rec = $('#inventory').find('tbody>tr').get();

                rec.sort(function (a, b) {
                    var val1 = $(a).children('td').eq(column).text().toUpperCase();
                    var val2 = $(b).children('td').eq(column).text().toUpperCase();
                    return (val1 < val2)?-sortdir:(val1>val2)?sortdir:0;
                });

                $.each(rec, function(index, row) {
                    $('#inventory tbody').append(row);
                });
            });
        });
    });
    </script>
</body>
</html>