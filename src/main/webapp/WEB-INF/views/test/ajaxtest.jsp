<%--
  Created by IntelliJ IDEA.
  User: data25
  Date: 2022-11-18
  Time: 오후 3:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      $.ajax({
        type: "GET",
        url: "/notice/Comment",
        dataType: "JSON",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        error: function() {
          console.log('통신실패!!');
        },
        success: function(response) {

          console.log("통신데이터 값 : " + response);
        }
      });
    });
  </script>
  <title>ajaxtest</title>
</head>
<body></body>

</html>