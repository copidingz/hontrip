<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>
<%
    long userId = 0;
    if (session.getAttribute("id") != null) {
        userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container-fluid container rounded shadow-sm mt-15 mb-20 w-75 p-3">
        <div class="col-md-9 col-xl-6 pe-xl-20" data-cues="slideInDown" data-group="page-title">
            <h1 class="display-1"><span class="underline-3 style-3 primary">항공권</span> 검색</h1>
        </div>
        <hr class="my-8" />
        <form id="flight-search-form" action="search-flight" method="post">
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="form-control d-flex flex-column">
                        <p>출발 공항</p>
                        <span class="form-select-wrapper mb-4">
                <select name="depAirportName" id="depAirportName" form="flight-search-form" class="form-select" style="border: 1px solid rgba(8, 60, 130, 0.2);" required>
                    <option value="KIMPO" selected>김포</option>
                    <option value="INCHEON">인천</option>
                    <option value="JEJU">제주</option>
                    <option value="GIMHAE">김해</option>
                    <option value="DAEGU">대구</option>
                    <option value="CHEONGJU">청주</option>
                    <option value="GWANGUJU">광주</option>
                    <option value="POHANG">포항</option>
                    <option value="YANGYANG">양양</option>
                    <option value="WONJU">원주</option>
                    <option value="YEOSU">여수</option>
                    <option value="ULSAN">울산</option>
                    <option value="SACHEON">사천</option>
                    <option value="MUAN">무안</option>
                    <option value="GUNSAN">군산</option>
                </select>
            </span>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="form-control d-flex flex-column">
                        <p>도착 공항</p>
                        <span class="form-select-wrapper mb-4">
            <select name="arrAirportName" id="arrAirportName" form="flight-search-form" class="form-select" style="border: 1px solid rgba(8, 60, 130, 0.2);" required>
                <option value="KIMPO">김포</option>
                <option value="INCHEON">인천</option>
                <option value="JEJU" selected>제주</option>
                <option value="GIMHAE">김해</option>
                <option value="DAEGU">대구</option>
                <option value="CHEONGJU">청주</option>
                <option value="GWANGUJU">광주</option>
                <option value="POHANG">포항</option>
                <option value="YANGYANG">양양</option>
                <option value="WONJU">원주</option>
                <option value="YEOSU">여수</option>
                <option value="ULSAN">울산</option>
                <option value="SACHEON">사천</option>
                <option value="MUAN">무안</option>
                <option value="GUNSAN">군산</option>
            </select>
        </span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 mb-4">
                    <div class="form-control d-flex flex-column">
                        <p>출발일</p>
                        <span class="mb-4">
                            <input type="date" id="depDate" name="depDate"
                                   class="form-control"
                                   required>
                        </span>
                    </div>
                </div>
            </div>
            <input type="submit" value="항공편 검색" class="btn btn-primary col-md-12">
        </form>
    </div>
</section>