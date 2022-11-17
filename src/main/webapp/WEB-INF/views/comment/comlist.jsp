<%@ page import="pcs.css.dto.MainDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="pcs.css.dto.CommentDTO" %><%--
  Created by IntelliJ IDEA.
  User: data25
  Date: 2022-11-17
  Time: 오전 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    boolean prev = (boolean) request.getAttribute("prev");
    boolean next = (boolean) request.getAttribute("next");

    int startPageNum = (int) request.getAttribute("startPageNum");
    int endPageNum = (int) request.getAttribute("endPageNum");
    int select = (int) request.getAttribute("select");
    List<CommentDTO> cList = (List<CommentDTO>) request.getAttribute("cList");
    MainDTO pDTO = (MainDTO) request.getAttribute("pDTO");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
