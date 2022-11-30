<%@ page import="pcs.css.util.CmmUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ss_user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
	String CKEditorFuncNum = (String) request.getAttribute("CKNUM");
	String fileurl = (String) request.getAttribute("fileurl");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<script src="/js/jquery-3.6.1.min.js" type="text/javascript"></script>

	<script type="text/javascript" src="../js/ckeditor/ckeditor.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>게시판 글쓰기</title>
	<script type="text/javascript">

		//전송시 유효성 체크
		function doSubmit(f){
			if(f.title.value == ""){
				alert("제목을 입력하시기 바랍니다.");
				f.title.focus();
				return false;
			}

			if(calBytes(f.title.value) > 200){
				alert("최대 200Bytes까지 입력 가능합니다.");
				f.title.focus();
				return false;
			}

			var noticeCheck = false; //체크 여부 확인 변수
			for(var i=0;i<f.noticeYn.length;i++){
				if (f.noticeYn[i].checked){
					noticeCheck = true;
				}
			}

			if(CKEDITOR.instances.contents.getData() ==''
					|| CKEDITOR.instances.contents.getData().length ==0){
				alert("내용을 입력해주세요.");
				$("#contents").focus();
				return false;
			}

			if(calBytes(f.contents.value) > 4000){
				alert("최대 4000Bytes까지 입력 가능합니다.");
				f.contents.focus();
				return false;
			}


		}

		//글자 길이 바이트 단위로 체크하기(바이트값 전달)
		function calBytes(str){

			var tcount = 0;
			var tmpStr = new String(str);
			var strCnt = tmpStr.length;

			var onechar;
			for (i=0;i<strCnt;i++){
				onechar = tmpStr.charAt(i);

				if (escape(onechar).length > 4){
					tcount += 2;
				}else{
					tcount += 1;
				}
			}

			return tcount;
		}

	</script>
</head>
<body onload="doOnload();">



<div class="container">
	<div class="row">
		<div class="col-md-4">
			<a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
		</div>
		<div class="col-md-4">
			<a href="/main/main" style="text-decoration: none"> <h1 style="text-align: center" >"constory" <span class="badge bg-secondary">"게시글 작성"</span></h1></a>
		</div>
		<div class="col-md-4"></div>
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

				<input type="button" class ="btn btn-outline-primary" value="자유게시판" onclick="location.href='/notice/NoticeList'">

				<input type="button" class ="btn btn-outline-primary" value="리뷰게시판" onclick="location.href='/noticeReview/NoticeReviewList'">

				<%}else if(session.getAttribute("SS_USER_ID").equals("admin")){%>
				<input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">

				<input type="button" class ="btn btn-outline-primary" value="자유게시판" onclick="location.href='/notice/NoticeList'">

				<input type="button" class ="btn btn-outline-primary" value="리뷰게시판" onclick="location.href='/noticeReview/NoticeReviewList'">

				<input type="button" class ="btn btn-outline-primary" value="회원관리" onclick="location.href='/user/UserManagement'">

				<%}else{%>
				<input type="button" class ="btn btn-outline-primary" value="로그아웃" onclick="location.href='/user/LogOut'">

				<input type="button" class ="btn btn-outline-primary" value="커뮤니티" onclick="location.href='/notice/NoticeList'">
				<input type="button" class ="btn btn-outline-primary" value="자유게시판" onclick="location.href='/notice/NoticeList'">

				<input type="button" class ="btn btn-outline-primary" value="리뷰게시판" onclick="location.href='/noticeReview/NoticeReviewList'">

				<%}%>
			</div>
		</div>
	</div>
</div>


<form name="f" method="post" action="/notice/NoticeInsert" target= "ifrPrc" onsubmit="return doSubmit(this);" enctype="multipart/form-data">
	<div class="container">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<div class="input-group mb-3">
					<span class="input-group-text" id="basic-addon1">제목</span>
					<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="title">
				</div>
			</div>
			<div class="col-3">
				<input type="hidden" name="ReviewYN" value="N" />
				<input type="hidden" name="user_id" value="<%=ss_user_id%>" />
				<div class="form-check form-switch">
					<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked name="noticeYn" value="Y">
					<label class="form-check-label" for="flexSwitchCheckChecked">공지글여부</label>
				</div>
			</div>
		</div>
	</div>






	<div class="container">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<textarea name="contents" ></textarea>


			</div>
			<div class="col-3"></div>
		</div>
	</div>






	<div class="container" style="">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6">
				<div class="btn-group" role="group" aria-label="Basic outlined example" style="float: right">
					<input  type="submit"  class ="btn btn-outline-primary" value="등록" />
					<input  type="reset"  class ="btn btn-outline-primary" value="다시 작성" />
				</div>
			</div>
			<div class="col-3"></div>
		</div>
	</div>


</form>
<!-- 프로세스 처리용 iframe / form 태그에서 target을 iframe으로 한다. -->
<iframe name="ifrPrc" style="display:none"></iframe>
<script type="text/javascript">
	var ckeditor_config = {

		filebrowserUploadUrl: "/notice/upload",
		height: 500,
		width : '100%',

		enterMode : CKEDITOR.ENTER_BR , // 엔터키를 <br> 로 적용함. 

		shiftEnterMode : CKEDITOR.ENTER_P , // 쉬프트 + 엔터를 <p> 로 적용함. 

	};
	CKEDITOR.replace('contents'
			,ckeditor_config);
	CKEDITOR.on('dialogDefinition',function(ev){
		var dialogName = ev.data.name;
		var dialog =ev.data.definition.dialog;
		var dialogDefinition = ev.data.definition;
		if(dialogName == 'image') {
			dialog.on('show', function (obj) {
				this.selectPage('Upload');
			});
			dialogDefinition.removeContents('advanced');
			dialogDefinition.removeContents('Link');
		}
	})
</script>
</body>
</html>