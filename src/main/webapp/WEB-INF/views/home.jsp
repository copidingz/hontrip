<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container pt-10 pt-md-12 pb-14 pb-md-8 text-center">
        <div class="row gx-lg-8 gx-xl-12 gy-10 gy-xl-0 mb-14 align-items-center">
            <div class="col-md-10 offset-md-1 offset-lg-0 col-lg-5 text-center text-lg-start">
                <h1 class="display-1 fs-54 mb-5 mx-md-n5 mx-lg-0 mt-7">계획하고, <br>기록하고, <br>
                    <span class="rotator-fade main-color">함께하는 여행</span></h1>
                <p class="lead fs-lg mb-7 ">지금부터 'HonTrip'을 통해 여행을 계획하고 / 기록하고 / 함께해보세요!</p>
                <span><a class="btn btn-lg btn-primary
                 rounded-pill me-2" href="/hontrip/user/sign-in">가입하고 글쓰기!</a></span>
            </div>
            <div class="col-lg-7 order-lg-2">
                <div class="swiper-container dots-over" data-margin="5" data-dots="true" data-nav="true" data-autoheight="true" data-autoplay="true" data-autoplaytime="4000">
                    <div class="swiper">
                        <div class="swiper-wrapper ">
                            <div class="swiper-slide bg-overlay bg-overlay-400 rounded">
                                <img src="<c:url value="/resources/img/common/메인1.jpg"/>" alt=""/>
                            </div>
                            <div class="swiper-slide bg-overlay bg-overlay-400 rounded">
                                <img src="<c:url value="/resources/img/common/메인2.jpg"/>" alt=""/>
                            </div>
                            <div class="swiper-slide bg-overlay bg-overlay-400 rounded">
                                <img src="<c:url value="/resources/img/common/메인3.jpg"/>" alt=""/>
                            </div>
                            <!--/.swiper-wrapper -->
                        </div>
                    </div>
                    <!-- /.swiper -->
                </div>
                <!-- /.swiper-container -->
            </div>
        </div>
    </div>
    <div class="overflow-hidden">
        <div class="text-soft-primary mx-n2">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 100">
                <path fill="rgba(255,90,70,0.1)" d="M1260,1.65c-60-5.07-119.82,2.47-179.83,10.13s-120,11.48-180,9.57-120-7.66-180-6.42c-60,1.63-120,11.21-180,16a1129.52,1129.52,0,0,1-180,0c-60-4.78-120-14.36-180-19.14S60,7,30,7H0v93H1440V30.89C1380.07,23.2,1319.93,6.15,1260,1.65Z"></path>
            </svg>
        </div>
    </div>
</section>

<style>
    .swiper-slide img {
        width: 100%;
        height: 100%;
        object-fit: fill;
        aspect-ratio: 4/3; /* 가로 세로 비율을 1:1로 설정합니다. */
        border-radius: 10px;
    }
</style>
<section class="wrapper bg-main-light">
    <div class="container pt-10 pt-lg-8 pb-5 pb-md-15">
    <section id="snippet-1" class="wrapper-border">
          <div class="container">
            <div class="swiper-container clients" data-margin="30" data-dots="false" data-loop="true" data-autoplay="true" data-autoplaytime="1" data-drag="false" data-speed="6000" data-items-xxl="4" data-items-xl="3" data-items-lg="5" data-items-md="2" data-items-xs="1">
              <div class="swiper">
                <div class="swiper-wrapper ticker">
                <c:forEach items="${topList}" var="postInfoDTO">
                    <div class="swiper-slide">
                    <!-- <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}"><img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" /></a> -->

                        <div class="project item">
                            <div class="card shadow-lg">
                                <figure class="card-img-top itooltip itooltip-aqua" title='<h5 class="mb-0">클릭하여 상세게시물 보기</h5>'>
                                    <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                                        <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt="" />
                                    </a>
                                </figure>
                                <div class="card-body">
                                    <div class="post-header">
                                        <div class="post-category mb-2 text-primary">${postInfoDTO.city}</div>
                                        <h4 class="mb-0">${postInfoDTO.title}</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </div>
                <!--/.swiper-wrapper -->
              </div>
              <!-- /.swiper -->
            </div>
            <!-- /.swiper-container -->
          </div>
          <!-- /.container -->
        </section>
        <!-- /section -->
    </div>
    <div class="container pt-10 pt-lg-8 pb-5 pb-md-15">
        <section id="snippet-2" class="wrapper-border">
            <div class="container">
                <h6 class="display-1 text-center top-ten"><span class="underline-3 style-3 primary">인기 있는</span> 여행지</h6>
                <div class="swiper-container clients" data-margin="30" data-dots="false" data-loop="true" data-autoplay="true" data-autoplaytime="1" data-drag="false" data-speed="6000" data-items-xxl="4" data-items-xl="3" data-items-lg="5" data-items-md="2" data-items-xs="1">
                    <div class="swiper">
                        <div class="swiper-wrapper ticker">
                            <c:forEach items="${topSpotList}" var="spot">
                                <div class="swiper-slide">
                                    <div class="project item">
                                        <div class="card shadow-lg">
                                            <figure class="card-img-top itooltip itooltip-aqua" title='<h5 class="mb-0">클릭하여 상세게시물 보기</h5>'>
                                                <a href="/hontrip/plan/detail?category=keyword&keyword=${spot.area}&contentId=${spot.spotContentId}">
                                                    <img src="${spot.image}">
                                                </a>
                                            </figure>
                                            <div class="card-body">
                                                <div class="post-header">
                                                    <div class="post-category mb-2 text-primary">${spot.area}</div>
                                                    <h4 class="mb-0" style="word-break: keep-all">${spot.title}</h4>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <!--/.swiper-wrapper -->
                    </div>
                    <!-- /.swiper -->
                </div>
                <!-- /.swiper-container -->
            </div>
            <!-- /.container -->
        </section>
        <!-- /section -->
    </div>
</section>
<section class="wrapper bg-main-light">
    <div class="overflow-hidden">
        <div class="divider text-light mx-n2">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 100">
                <path fill="white" d="M1260,1.65c-60-5.07-119.82,2.47-179.83,10.13s-120,11.48-180,9.57-120-7.66-180-6.42c-60,1.63-120,11.21-180,16a1129.52,1129.52,0,0,1-180,0c-60-4.78-120-14.36-180-19.14S60,7,30,7H0v93H1440V30.89C1380.07,23.2,1319.93,6.15,1260,1.65Z"></path>
            </svg>
        </div>
    </div>
</section>