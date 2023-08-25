<%@ page import="com.multi.hontrip.mate.dto.MateBoardInsertDTO" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.multi.hontrip.mate.dto.MateBoardSelectOneDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="../resources/js/jquery-3.7.0.js"></script>
<input hidden id="userId" name="userId" value="<c:out value="${sessionScope.id}"/>">
<input hidden id="nickName" name="nickName" value="<c:out value="${sessionScope.username}" />">
<input hidden id="profileImage" name="profileImage" value="<c:out value="${sessionScope.profileImage}" />">



<%
    //*세션에서 유저아이디 불러옴 -> 없으면 no 있으면 유저아이디*//*
    if (session.getAttribute("id") != null) {
        long userId = (long) session.getAttribute("id");
        String userProfileImage = session.getAttribute("profileImage").toString();
        String userNickName = session.getAttribute("nickName").toString();
        request.setAttribute("mateSenderId", userId);
        request.setAttribute("mateSenderProfileImage", userProfileImage);
        request.setAttribute("mateSenderNickName", userNickName);
    }
%>
<%
    /* c:forEach 에서 사용할 배열 -> ageRangeStr */
    MateBoardSelectOneDTO mateBoardSelectOneDTO = (MateBoardSelectOneDTO) request.getAttribute("dto");
    String createdDate = mateBoardSelectOneDTO.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm"));

    request.setAttribute("createdDate", createdDate);
    if (!mateBoardSelectOneDTO.getAgeRangeId().isEmpty()) {
        String[] ageRangeStr = mateBoardSelectOneDTO.getAgeRangeId().split(",");
        for (int i = 0; i < ageRangeStr.length; i++) {
            ageRangeStr[i] = AgeRange.valueOf(Integer.parseInt(ageRangeStr[i]));
        }
        request.setAttribute("ageRangeStr", ageRangeStr);

        /* js에서 사용할 배열 문자열 -> ageRangeJS*/
        if (mateBoardSelectOneDTO.getAgeRangeId() != null || mateBoardSelectOneDTO.getAgeRangeId() != "") {
            String[] age = mateBoardSelectOneDTO.getAgeRangeId().split(",");
            String ageRangeJS = "";
            for (int i = 0; i < age.length; i++) {
                age[i] = AgeRange.valueOf(Integer.parseInt(age[i]));
                ageRangeJS += age[i];
                if (i < age.length - 1) {
                    ageRangeJS += ",";
                }
            }
            request.setAttribute("ageRangeJS", ageRangeJS);
        }
    } else {
        //String[] ageRangeStr = {};
        //request.setAttribute("ageRangeStr", ageRangeStr);
        String ageRangeJS = "";
        request.setAttribute("ageRangeJS", ageRangeJS);
    }
%>

<div class="content-wrapper">
    <header class="wrapper">
        <nav class="navbar navbar-expand-lg center-nav transparent navbar-light">
            <div class="container flex-lg-row flex-nowrap align-items-center">
                <div class="navbar-brand w-100">
                    <%--<a href="./index.html">
                        <img src="./assets/img/logo.png" srcset="./assets/img/logo@2x.png 2x" alt=""/>
                    </a>--%>
                </div>
                <div class="navbar-collapse offcanvas offcanvas-nav offcanvas-start">
                    <div class="offcanvas-header d-lg-none">
                        <h3 class="text-white fs-30 mb-0">Sandbox</h3>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"
                                aria-label="Close"></button>
                    </div>
                    <div class="offcanvas-body ms-lg-auto d-flex flex-column h-100">

                        <!-- /.navbar-nav -->

                        <!-- /.offcanvas-footer -->
                    </div>
                    <!-- /.offcanvas-body -->
                </div>
                <!-- /.navbar-collapse -->

            </div>
            <!-- /.container -->
        </nav>
        <!-- /.navbar -->
        <div class="offcanvas offcanvas-top bg-light" id="offcanvas-search" data-bs-scroll="true">
            <div class="container d-flex flex-row py-6">
                <form class="search-form w-100">
                    <input id="search-form" type="text" class="form-control" placeholder="Type keyword and hit enter">
                </form>
                <!-- /.search-form -->
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <!-- /.container -->
        </div>
        <!-- /.offcanvas -->
    </header>
    <!-- /header -->
    <section class="wrapper">
        <div class="container pt-10 pb-15 pt-md-12 pb-md-15 text-center">
            <div class="row">
                <div class="col-md-5 col-xl-8 mx-auto">
                    <!-- /.post-header -->
                </div>
                <!-- /column -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- /section -->


    <button hidden id="ableButton" class="btn btn-primary rounded-pill mx-1 mb-2 mb-md-0" data-bs-toggle="modal"
            data-bs-target="#ableApply">신청가능
    </button>

    <section class="wrapper bg-light">
        <div class="modal fade" tabindex="-1" id="ableApply">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content text-center">
                    <div class="modal-body">
                        <button class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        <div class="row">
                            <input hidden id="mateBoardId" value="${dto.id}">
                            <input hidden id="mateSenderId" value="${mateSenderId}">
                            <input hidden id="mateSenderNickName" value="${mateSenderNickName}">
                            <input hidden id="mateSenderProfileImage" value="${mateSenderProfileImage}">
                            <input hidden id="mateBoardGenderStr" value="${dto.gender.genderStr}">
                            <input hidden id="ageRangeJS" value="${ageRangeJS}">

                            <!-- /column -->
                        </div>
                        <!-- /.row -->
                        <h3>동행 신청 메세지</h3>
                        <p class="mb-6">자신의 여행 성향과 경험을 작성하면 매칭될 가능성 up!</p>
                        <div class="newsletter-wrapper">
                            <div class="row">
                                <div class="col-md-10 offset-md-1">
                                    <!-- Begin Mailchimp Signup Form -->
                                    <div id="mc_embed_signup">
                                        <form action="https://elemisfreebies.us20.list-manage.com/subscribe/post?u=aa4947f70a475ce162057838d&amp;id=b49ef47a9a"
                                              method="post" id="mc-embedded-subscribe-form"
                                              name="mc-embedded-subscribe-form" class="validate" target="_blank"
                                              novalidate>
                                            <div id="mc_embed_signup_scroll">
                                                <div class="mc-field-group input-group form-floating">
                                                    <textarea id="applicationMessage"
                                                              class="form-control mateBoardApplicationMessageTextarea"
                                                              placeholder="Textarea"
                                                              style="height: 150px; resize: none;"
                                                              required></textarea>
                                                    <label for="applicationMessage">Textarea</label>
                                                </div>
                                                <div id="mce-responses" class="clear">
                                                    <div class="response" id="mce-error-response"
                                                         style="display:none"></div>
                                                    <div class="response" id="mce-success-response"
                                                         style="display:none"></div>
                                                </div>
                                                <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->


                                                <div class="modal-footer mb-0 flex-md-row justify-content-between  align-items-center">
                                                    <button type="button" class="btn btn-secondary mateModalButton"
                                                            data-bs-dismiss="modal">취소
                                                    </button>
                                                    <button type="button" class="btn btn-primary mateModalButton"
                                                            onclick="send()">전송
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <!--End mc_embed_signup-->
                                </div>
                                <!-- /.newsletter-wrapper -->
                            </div>
                            <!-- /column -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!--/.modal-body -->
                </div>
                <!--/.modal-content -->
            </div>
            <!--/.modal-dialog -->
        </div>
        <!--/.modal -->


        <button hidden id="deleteButton" class="btn btn-primary rounded-pill mx-1 mb-2 mb-md-0" data-bs-toggle="modal"
                data-bs-target="#deleteBoard"> 삭제
        </button>

        <section class="wrapper bg-light">
            <div class="modal fade" tabindex="-1" id="deleteBoard">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content text-center">
                        <div class="modal-body">
                            <button class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            <div class="row">
                                <!-- /column -->
                            </div>
                            <!-- /.row -->
                            <div class="newsletter-wrapper">
                                <div class="row">
                                    <div class="col-md-10 offset-md-1">
                                        <!-- Begin Mailchimp Signup Form -->
                                        <div>
                                            <form action="https://elemisfreebies.us20.list-manage.com/subscribe/post?u=aa4947f70a475ce162057838d&amp;id=b49ef47a9a"
                                                  method="post"
                                                  name="mc-embedded-subscribe-form" class="validate" target="_blank"
                                                  novalidate>
                                                <div>
                                                    <div class="mc-field-group input-group form-floating">
                                                        삭제시 되돌릴 수 없습니다.
                                                        삭제하시겠습니까?
                                                    </div>
                                                    <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
                                                    <div style="position: absolute; left: -5000px;" aria-hidden="true">
                                                        <input type="text" name="b_ddc180777a163e0f9f66ee014_4b1bcfa0bc"
                                                               tabindex="-1" value=""></div>

                                                    <br>
                                                    <div>
                                                        <button type="button" class="btn btn-secondary mateModalButton"
                                                                data-bs-dismiss="modal">취소
                                                        </button>
                                                        <button type="button" class="btn btn-primary mateModalButton"
                                                                onclick="deleteAccept()">삭제
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <!--End mc_embed_signup-->
                                    </div>
                                    <!-- /.newsletter-wrapper -->
                                </div>
                                <!-- /column -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <!--/.modal-body -->
                    </div>
                    <!--/.modal-content -->
                </div>
                <!--/.modal-dialog -->
            </div>
            <!--/.modal -->


            <button hidden id="unableButton" class="btn btn-primary rounded-pill mx-1 mb-2 mb-md-0"
                    data-bs-toggle="modal"
                    data-bs-target="#unableApply">신청불가
            </button>

            <div class="modal fade" tabindex="-1" id="unableApply">
                <div class="modal-dialog modal-dialog-centered modal-sm">
                    <div class="modal-content text-center">
                        <div class="modal-body">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            <h2 class="mb-3 text-start" style="text-align: center;">동행인 신청 불가</h2>
                            <p class="lead mb-6 text-start">모집조건에 맞지 않습니다.</p>
                            <!--/.social -->
                        </div>
                        <!--/.modal-content -->
                    </div>
                    <!--/.modal-body -->
                </div>
                <!--/.modal-dialog -->
            </div>
            <!--/.modal -->


            <div class="container pb-12 pb-md-16">
                <div class="row">
                    <div class="col-lg-10 mx-auto">
                        <div class="blog single mt-n15">
                            <div class="card">
                                <form action="editpage" method="post">
                                    <img
                                            src="<c:url value='../resources/img/mateImg/${dto.thumbnail}'/>"
                                            alt="여행지 사진" style="width: 100%; height:600px; border-top-left-radius: 12px;
                                            border-top-right-radius: 12px;"/>
                                    <div class="card-body" style="padding-top: 0;">
                                        <div class="classic-view">


                                            <input hidden name="id" value=${dto.id}>
                                            <input hidden id="writerId" name="userId" value=${dto.userId}>
                                            <input hidden name="title" value="${dto.title}">
                                            <input hidden name="content" value="${dto.content}">
                                            <input hidden name="thumbnail" value="${dto.thumbnail}">
                                            <input hidden name="startDate" value="${dto.startDate}">
                                            <input hidden name="endDate" value="${dto.endDate}">
                                            <input hidden name="isFinish" value="${dto.isFinish}">
                                            <input hidden name="gender" value="${dto.gender}">
                                            <input hidden name="recruitNumber" value="${dto.recruitNumber}">
                                            <input hidden name="regionId" value="${dto.regionId}">
                                            <%--     <input hidden name="createdAt" value=${dto.createdAt}>--%>
                                            <input hidden name="ageRangeId" value=${dto.ageRangeId}>
                                            <input hidden id="ageRangeStrr" value=${ageRangeStr}>
                                            <input hidden id="ageRangeJSS" value=${ageRangeJS}>


                                            <article class="post">
                                                <div class="post-footer d-md-flex flex-md-row justify-content-md-between align-items-center mt-8">
                                                    <div class="mateUserDetails">
                                                        <div class="d-flex align-items-center">

                                                            <figure class="user-avatar"><img class="rounded-circle"
                                                                                             alt="유저 썸네일"
                                                                                             src="${dto.userProfileImage}"/>
                                                            </figure>
                                                            <div>
                                                                <h6 class="comment-author"><a href="#"
                                                                                              class="link-dark">${dto.userNickName}</a>
                                                                </h6>
                                                                <ul class="post-meta">
                                                                    <li>${dto.userGender.genderStr}</li>
                                                                    <li>${dto.userAgeRange.ageRangeStr}</li>
                                                                </ul>

                                                                <!-- /.post-meta -->
                                                            </div>
                                                            <!-- /div -->
                                                        </div>
                                                        <br>

                                                        <h3 class="h3 mb-5">${dto.title}</h3>
                                                        <div class="mb-3">
                                                            <i
                                                                    class="uil uil-calendar-alt"></i>
                                                            <fmt:parseDate value="${dto.startDate}" var="dateValue"
                                                                           pattern="yyyy-MM-dd"/>
                                                            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/> -
                                                            <fmt:parseDate value="${dto.endDate}"
                                                                           var="dateValue"
                                                                           pattern="yyyy-MM-dd"/>
                                                            <fmt:formatDate value="${dateValue}" pattern="MM/dd"/></li>

                                                            <span style="margin-right: 10px;"></span>


                                                            <i class="uil uil-location-pin-alt"></i>
                                                            ${dto.regionId.regionStr}
                                                            </li>

                                                            <span style="margin-right: 10px;"></span>

                                                            모집인원 ${dto.recruitNumber}명
                                                        </div>

                                                    </div>
                                                    <div class="mb-0 mb-md-16">
                                                        <div class="dropdown share-dropdown btn-group">
                                                            <c:if test="${dto.isFinish eq 0 && dto.userId ne user}">
                                                                <%-- <button id="application"
                                                                         class="btn btn-sm btn-red rounded-pill btn-icon btn-icon-start dropdown-toggle mb-0 me-0"
                                                                         data-bs-toggle="dropdown" aria-haspopup="true"
                                                                         aria-expanded="false">

                                                                 </button>--%>
                                                                <button type="button" id="application"
                                                                        onclick="applyMate()"
                                                                        class="btn btn-danger rounded-0 mateApplyCheckButton">
                                                                    동행인 신청하기
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${dto.isFinish eq 1}">
                                                                <a class="btn btn-secondary rounded-0 mateApplyCheckButton">모집완료</a>
                                                            </c:if>
                                                        </div>
                                                        <!--/.share-dropdown -->
                                                    </div>
                                                </div>

                                                <ul class="list-unstyled tag-list mb-0 flex-lg-wrap"
                                                    style="width: 100%">
                                                    <li class="btn btn-soft-ash btn-sm rounded-pill mb-2"
                                                        style="width: 14%">원해요
                                                    </li>
                                                    <li class="btn btn-soft-ash btn-sm rounded-pill mb-2"
                                                        style="width: 14%">
                                                        #${dto.gender.genderStr}</li>
                                                    <c:if test="${not empty ageRangeStr}">
                                                        <c:forEach items="${ageRangeStr}" var="age">
                                                            <li class="btn btn-soft-ash btn-sm rounded-pill mb-2"
                                                                style="width: 14%">
                                                                #${age}</li>
                                                        </c:forEach>
                                                    </c:if>
                                                </ul>
                                                <!-- /.post-footer -->
                                                <br>
                                                <br>
                                                <div class="post-content mb-5">

                                                    <p style="white-space:pre-wrap;">${dto.content}</p>
                                                    <!-- /.row -->
                                                </div>
                                                <!-- /.post-content -->
                                            </article>


                                            <br>


                                        </div>
                                        <!-- /.classic-view -->

                                        <!-- /.social -->
                                        <div class="swiper-container blog grid-view mb-2" data-margin="30"
                                             data-dots="true"
                                             data-items-md="2" data-items-xs="1">
                                            <div class="swiper">
                                                <div class="swiper-wrapper">
                                                    <div class="swiper-slide">
                                                        <article>
                                                            <div class="post-footer" style="width:600px;">
                                                                <ul class="post-meta mb-0">
                                                                    <li class="post-date"><i
                                                                            class="uil uil-calendar-alt"></i><span>${createdDate}
                                                                    </span>
                                                                    </li>
                                                                    <li class="post-comments"><i
                                                                            class="uil uil-eye"></i>조회수
                                                                    </li>
                                                                    <li class="post-comments"><i
                                                                            class="uil uil-comment"></i>댓글개수
                                                                    </li>
                                                                    <c:if test="${dto.userId eq user}">

                                                                        <button
                                                                                id="edit" type="submit"
                                                                                class="mateBoardUpdateDeleteButton"> 수정
                                                                        </button>

                                                                        <button type="button" id="delete"
                                                                                onclick="deleteMateBoard()"
                                                                                class="mateBoardUpdateDeleteButton">삭제
                                                                        </button>
                                                                    </c:if>
                                                                </ul>
                                                                <!-- /.post-meta -->
                                                            </div>
                                                            <!-- /.post-footer -->
                                                        </article>
                                                        <!-- /article -->
                                                    </div>
                                                    <!--/.swiper-slide -->
                                                </div>
                                                <!--/.swiper-wrapper -->
                                            </div>
                                            <!-- /.swiper -->
                                        </div>

                                        <!-- /.swiper-container -->


                                        <ol id="singlecomments" class="commentlist">
                                            <li class="comment">
                                                <div class="comment-header d-md-flex align-items-center">
                                                    <div class="d-flex align-items-center">
                                                        <figure class="user-avatar"><img class="rounded-circle"
                                                                                         alt=""
                                                                                         src=""/>
                                                        </figure>
                                                        <div>
                                                            <h6 class="comment-author"><a href="#"
                                                                                          class="link-dark">Nikolas
                                                                Brooten</a></h6>
                                                            <ul class="post-meta">
                                                                <li><i class="uil uil-calendar-alt"></i>21 Feb 2022
                                                                </li>
                                                            </ul>
                                                            <!-- /.post-meta -->
                                                        </div>
                                                        <!-- /div -->
                                                    </div>
                                                    <!-- /div -->
                                                    <div class="mt-3 mt-md-0 ms-auto">
                                                        <a href="#"
                                                           class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                class="uil uil-comments"></i> Reply</a>
                                                    </div>
                                                    <!-- /div -->
                                                </div>
                                                <!-- /.comment-header -->
                                                <p>Quisque tristique tincidunt metus non aliquam. Quisque ac risus
                                                    sit
                                                    amet
                                                    quam sollicitudin vestibulum vitae malesuada libero. Mauris
                                                    magna
                                                    elit,
                                                    suscipit non ornare et, blandit a tellus. Pellentesque dignissim
                                                    ornare
                                                    faucibus mollis.</p>
                                                <ul class="children">
                                                    <li class="comment">
                                                        <div class="comment-header d-md-flex align-items-center">
                                                            <div class="d-flex align-items-center">
                                                                <figure class="user-avatar"><img
                                                                        class="rounded-circle"
                                                                        alt=""
                                                                        src=""/>
                                                                </figure>
                                                                <div>
                                                                    <h6 class="comment-author"><a href="#"
                                                                                                  class="link-dark">Pearce
                                                                        Frye</a></h6>
                                                                    <ul class="post-meta">
                                                                        <li><i class="uil uil-calendar-alt"></i>22
                                                                            Feb
                                                                            2022
                                                                        </li>
                                                                    </ul>
                                                                    <!-- /.post-meta -->
                                                                </div>
                                                                <!-- /div -->
                                                            </div>
                                                            <!-- /div -->
                                                            <div class="mt-3 mt-md-0 ms-auto">
                                                                <a href="#"
                                                                   class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                        class="uil uil-comments"></i> Reply</a>
                                                            </div>
                                                            <!-- /div -->
                                                        </div>
                                                        <!-- /.comment-header -->
                                                        <p>Cras mattis consectetur purus sit amet fermentum. Integer
                                                            posuere
                                                            erat a ante venenatis dapibus posuere velit aliquet.
                                                            Etiam
                                                            porta
                                                            sem malesuada magna mollis.</p>
                                                        <ul class="children">
                                                            <li class="comment">
                                                                <div class="comment-header d-md-flex align-items-center">
                                                                    <div class="d-flex align-items-center">
                                                                        <figure class="user-avatar"><img
                                                                                class="rounded-circle" alt=""
                                                                                src=""/>
                                                                        </figure>
                                                                        <div>
                                                                            <h6 class="comment-author"><a href="#"
                                                                                                          class="link-dark">Nikolas
                                                                                Brooten</a></h6>
                                                                            <ul class="post-meta">
                                                                                <li>
                                                                                    <i class="uil uil-calendar-alt"></i>4
                                                                                    Apr 2022
                                                                                </li>
                                                                            </ul>
                                                                            <!-- /.post-meta -->
                                                                        </div>
                                                                        <!-- /div -->
                                                                    </div>
                                                                    <!-- /div -->
                                                                    <div class="mt-3 mt-md-0 ms-auto">
                                                                        <a href="#"
                                                                           class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                                                class="uil uil-comments"></i> Reply</a>
                                                                    </div>
                                                                    <!-- /div -->
                                                                </div>
                                                                <!-- /.comment-header -->
                                                                <p>Nullam id dolor id nibh ultricies vehicula ut id.
                                                                    Cras
                                                                    mattis consectetur purus sit amet fermentum.
                                                                    Aenean
                                                                    eu
                                                                    leo quam. Pellentesque ornare sem lacinia aenean
                                                                    bibendum nulla consectetur.</p>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>

                                        </ol>
                                    </div>
                                    <!-- /#comments -->
                                </form>
                                <hr>
                                <div id="comments">
                                    <h3 class="mb-6">5 Comments</h3>
                                    <hr>
                                    댓글작성: <input id="cmtContent" style="background: gray">
                                    <button type="button" id="commentWrite">작 성</button>
                                    <br>
                                    <br>
                                    댓글 수
                                    <div id="count"></div>
                                    <br>
                                    <div id="result">
                                        <c:choose>
                                            <c:when test="${list.isEmpty()}">
                                                <h6>등록된 댓글이 없습니다.</h6>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${list}" var="commentList">
                                                    <c:if test="${commentList.commentSequence eq '0'}">
                                                        <tr id="comment_tr${commentList.commentId}"><td>
                                               <li class="comment">
                                               <div class="comment-header d-md-flex align-items-center">
                                                   <div class="d-flex align-items-center">
                                                       <figure class="user-avatar"><img class="rounded-circle"alt=""src="${commentList.profileImage}"/>
                                                       </figure>
                                                       <div>
                                                           <h6 class="comment-author"><a href="#"class="link-dark">${commentList.nickname}</a></h6>
                                                           <ul class="post-meta">
                                                               <li><i class="uil uil-calendar-alt"></i>${commentList.createdAt}</li>
                                                           </ul>
                                                           <!-- /.post-meta -->
                                                       </div>
                                                       <!-- /div -->
                                                   </div>
                                                   <!-- /div -->
                                                   <div class="mt-3 mt-md-0 ms-auto">
                                                       <a href="#"
                                                          class="btn btn-soft-ash btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                                               class="uil uil-comments"></i> 답글달기</a>
                                                   </div>
                                                   <!-- /div -->
                                               </div>
                                               <!-- /.comment-header -->
                                               <p>${commentList.content}</p>
                                                                댓글 작성자 : ${commentList.nickname}, 댓글 내용
                                                                : ${commentList.content}, 작성날짜
                                                                : ${commentList.createdAt}
                                                                <a href="javascript:void(0);"
                                                                   onclick="showCcmtTextarea(${commentList.commentId})">답글
                                                                    달기</a>
                                                                <c:if test="${commentList.nickname eq nickName}">
                                                                    <a href="javascript:void(0);"
                                                                       onclick="showUpdateTextarea(${commentList.commentId})">수정</a>
                                                                    <button type="button" class="commentDelete"
                                                                            data-comment-id="${commentList.commentId}">
                                                                        삭제
                                                                    </button>
                                                                </c:if>

                                                                <c:forEach items="${reCommentList}" var="reComment">
                                                                    <c:if test="${commentList.commentId eq reComment.indentationNumber}">
                                                                        <br>
                                                                        --> 댓글 작성자 : ${reComment.nickname}, 댓글 내용 : ${reComment.content}, 작성날짜 : ${reComment.createdAt}
                                                                        <c:if test="${reComment.nickname eq nickName}">
                                                                            <a href="javascript:void(0);"
                                                                               onclick="showUpdateTextarea(${reComment.commentId})">수정</a>
                                                                            <button type="button" class="commentDelete"
                                                                                    data-comment-id="${reComment.commentId}">
                                                                                삭제
                                                                            </button>
                                                                            <div id="commentUpdate${reComment.commentId}"
                                                                                 style="display: none">
                                                                                <textarea
                                                                                        id="updateContent${reComment.commentId}"
                                                                                        placeholder="수정글을 입력해주세요">${reComment.content}</textarea>
                                                                                <br>
                                                                                <button type="button"
                                                                                        class="updateComment"
                                                                                        data-comment-id="${reComment.commentId}">
                                                                                    수정
                                                                                </button>
                                                                                <a href="javascript:void(0);"
                                                                                   onclick="closeTextarea(${reComment.commentId})">취소</a>
                                                                            </div>
                                                                        </c:if>
                                                                        <br>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <br>

                                                                <div id="commentUpdate${commentList.commentId}"
                                                                     style="display: none">
                                                                    <textarea id="updateContent${commentList.commentId}"
                                                                              placeholder="수정글을 입력해주세요">${commentList.content}</textarea>
                                                                    <br>
                                                                    <button type="button" class="updateComment"
                                                                            data-comment-id="${commentList.commentId}">
                                                                        수정
                                                                    </button>
                                                                    <a href="javascript:void(0);"
                                                                       onclick="closeTextarea(${commentList.commentId})">취소</a>
                                                                </div>

                                                                <div id="cComment${commentList.commentId}"
                                                                     style="display: none">
                                                                    <textarea id="cContent${commentList.commentId}"
                                                                              placeholder="답글을 입력해주세요"></textarea>
                                                                    <br>
                                                                    <button type="button" class="cCommentWrite"
                                                                            data-comment-id="${commentList.commentId}">
                                                                        답글 전송
                                                                    </button>
                                                                    <a href="javascript:void(0);"
                                                                       onclick="closeCTextarea(${commentList.commentId})">취소</a>
                                                                    <br>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                </div>
                                <!-- /.card-body -->
                            </div>
                            <!-- /.card -->
                        </div>
                        <!-- /.blog -->
                    </div>
                    <!-- /column -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container -->

        </section>
        <!-- /section -->
    </section>
</div>
<!-- /.content-wrapper -->
