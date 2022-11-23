
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pcs.css.dto.NoticeDTO" %>
<%@ page import="pcs.css.util.CmmUtil" %>
<%
  NoticeDTO rDTO = (NoticeDTO) request.getAttribute("rDTO");

//공지글 정보를 못불러왔다면, 객체 생성
  if (rDTO == null) {
    rDTO = new NoticeDTO();

  }

  String ss_user_id = CmmUtil.nvl((String) session.getAttribute("SESSION_USER_ID"));

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
  int edit = 1;

//로그인 안했다면....
  if (ss_user_id.equals("")) {
    edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
  } else if (ss_user_id.equals(CmmUtil.nvl(rDTO.getUser_id()))) {
    edit = 2;

  }

  System.out.println("user_id : " + CmmUtil.nvl(rDTO.getUser_id()));
  System.out.println("ss_user_id : " + ss_user_id);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>게시판 글보기</title>
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
          crossorigin="anonymous"
  />

  <script src="https://kit.fontawesome.com/9e30f8c908.js" crossorigin="anonymous"></script>

  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.1/mdb.min.js"></script>

  <script type="text/javascript">
    window.onload = function () {
      var writeCommentBtn = document.getElementById("writeCommentBtn");
      writeCommentBtn.addEventListener("click", onWriteCommentClick);

      // 로그인 버튼
      var loginBtn = document.getElementById("loginBtn");
      loginBtn.addEventListener("click", onLoginBtnClick);
    };

    // 글 쓰기 클릭
    function onWriteCommentClick() {
      const comment = document.querySelector("#writeComment").value;
      console.log("Comment -> " + comment);
    }

    // 로그인 클릭
    function onLoginBtnClick() {
      console.log("Click Login");
    }
  </script>
</head>
<body>
<!-- Navbar -->
<nav class="container py-4 align-items-center navbar navbar-expand-lg navbar-light">
  <div class="container-fluid">
    <button
            class="navbar-toggler"
            type="button"
            data-mdb-toggle="collapse"
            data-mdb-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation"
    >
      <i class="fas fa-bars"></i>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <a class="navbar-brand mt-2 mt-lg-0" href="#">
        <img src="https://assets.cdn.soomgo.com/icons/icon-navi-logo.svg" />
      </a>
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="/Main.jsp">메인</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="NoticeInfo.jsp">자유게시판</a>
        </li>
      </ul>
    </div>

    <div class="d-flex align-items-center">
      <div class="dropdown">
        <div class="dropdown-toggle d-flex align-items-center hidden-arrow" href="#" id="navbarDropdownMenuAvatar" role="button" data-mdb-toggle="dropdown" aria-expanded="false">
          <i class="fas fa-cog"></i>
        </div>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuAvatar">
          <li>
            <a id="loginBtn" class="dropdown-item" href="#">로그인</a>
          </li>
          <!-- <li>
            <a class="dropdown-item" href="#">로그아웃</a>
          </li> -->
        </ul>
      </div>
    </div>
  </div>
</nav>
<!-- Navbar -->

<section class="container">
  <div class="py-4 card">
    <div class="row navbar navbar-expand-lg justify-content-between px-3">
      <!-- <%=CmmUtil.nvl(rDTO.getTitle())%> -->
      <div class="fw-bold fs-5 text-truncate col-10" style="max-width: 90%">2022년 제5회 환자안전주간 행사 국민의 안전을 지키는 '정확하고 올바른 투약'</div>
      <!-- <%=CmmUtil.nvl(rDTO.getRead_cnt())%> -->
      <div class="text-muted col-2 text-end" style="font-size: 14px">조회수: 670</div>
    </div>

    <hr class="hr" />

    <!-- Author -->
    <div class="px-3">
      <span class="me-1">작성자: 공돌이</span>
      <span> / </span>
      <!-- <%=CmmUtil.nvl(rDTO.getReg_dt())%> -->
      <span>작성일: 2022-11-22</span>
    </div>

    <div class="text-muted px-3 py-5" style="min-height: 400px">
      <!-- <%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br />") %> -->
      2022년 제5회 환자안전주간 행사 국민의 안전을 지키는 '정확하고 올바른 투약'<br /><br />
      ■ 행사개요 제5회 환자안전의 날 주제는 '정확하고 올바른 투약'입니다. 주제와 관련된 다채로운 전시.체험 프로그램이 운영될 예정이오니 많은 관심과 참여 부탁드립니다.<br /><br />
      ■ 행사일정 및 장소 - 행사 일정 : 2022년 9월 17일 [토] 11:00 ~ 16:00 - 행사 장소 : 서울어린이대공원 열린무대 앞<br /><br />
      ■ 행사내용 - 스탬프랠리 경품 이벤트 - 환자안전 홍보 영상 전시 - 심폐소생술 교육 등 대한민국 모든 공모전 [위비티]( https://www.wevity.com )
    </div>
  </div>
</section>

<!-- Comment -->
<section>
  <div class="container my-5 py-5">
    <h4 class="mb-3">댓글 4개</h4>
    <div class="row d-flex justify-content-center">
      <div class="col-md-12 col-lg-12">
        <div class="card text-dark">
          <div class="card-body p-4">
            <div class="d-flex flex-start">
              <div>
                <div class="d-flex align-items-center mb-1">
                  <h6 class="fw-bold mb-0 me-1">가나다1</h6>
                  <span class="badge bg-primary">작성자</span>
                </div>
                <div class="d-flex align-items-center mb-3">
                  <p class="mb-0">2022-11-27</p>
                </div>
                <p class="mb-0">댓글 부탁드려요</p>
              </div>
            </div>
          </div>

          <hr class="my-0" />

          <div class="card-body p-4">
            <div class="d-flex flex-start">
              <div>
                <div class="d-flex align-items-center mb-1">
                  <h6 class="fw-bold mb-0 me-1">가나다2</h6>
                </div>
                <div class="d-flex align-items-center mb-3">
                  <p class="mb-0">2022-11-27</p>
                </div>
                <p class="mb-0">좋은 컨텐츠에요. 공유 감사합니다</p>
              </div>
            </div>
          </div>

          <hr class="my-0" style="height: 1px" />

          <div class="card-body p-4">
            <div class="d-flex flex-start">
              <div>
                <div class="d-flex align-items-center mb-1">
                  <h6 class="fw-bold mb-0 me-1">가나다3</h6>
                </div>
                <div class="d-flex align-items-center mb-3">
                  <p class="mb-0">2022-11-27</p>
                </div>
                <p class="mb-0">상세 일정이 궁금해요.</p>
              </div>
            </div>
          </div>

          <hr class="my-0" />

          <div class="card-body p-4">
            <div class="d-flex flex-start">
              <div>
                <div class="d-flex align-items-center mb-1">
                  <h6 class="fw-bold mb-0 me-1">가나다4</h6>
                </div>
                <div class="d-flex align-items-center mb-3">
                  <p class="mb-0">2022-11-27</p>
                </div>
                <p class="mb-0">포스터는 없나요</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Write Comment -->
        <div class="card-footer py-3 border-0" style="background-color: #f8f9fa">
          <div class="form-outline form-floating w-100">
            <textarea class="form-control form-control-lg" id="writeComment" rows="6" style="background: #fff; font-size: 16px" placeholder="댓글 작성"></textarea>
            <label class="form-label" for="writeComment">댓글 작성</label>
          </div>
          <div class="float-end mt-2 pt-1">
            <button type="button" id="writeCommentBtn" class="btn btn-primary" onclick="onWriteCommentClick">글 쓰기</button>
          </div>
        </div>
        <!-- Write Comment -->
      </div>
    </div>
  </div>
</section>

<nav class="pb-5">
  <ul class="pagination justify-content-center">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
        <span class="sr-only">Previous</span>
      </a>
    </li>
    <li class="page-item active"><a class="page-link" href="#">1</a></li>
    <!-- <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item"><a class="page-link" href="#">5</a></li> -->
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
        <span class="sr-only">Next</span>
      </a>
    </li>
  </ul>
</nav>

</body>
</html>
