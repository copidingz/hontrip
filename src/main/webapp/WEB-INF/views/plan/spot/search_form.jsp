<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <div class="col-md-9 col-xl-6 pe-xl-20" data-cues="slideInDown" data-group="page-title">
            <h1 class="display-1"><span class="underline-3 style-3 primary">여행지</span> 검색</h1>
        </div>
        <hr class="my-8" />
        <form id="spot-search-form" action="search" method="post" class="mt-5">
            <div class="custom-form-container">
                <div class="col-md-2 me-2">
                    <select class="form-select" id="category" name="category" form="spot-search-form"
                            aria-label="검색 범주" style="border: 1px solid rgba(8, 60, 130, 0.2);">
                        <option value="keyword" selected>여행지명</option>
                        <option value="area">지역명</option>
                    </select>
                </div>
                <input type="text" id="keyword" name="keyword" class="custom-form-control col-md-8 me-2">
                <input type="submit" value="검색" class="btn btn-primary col-md-2">
            </div>
        </form>
    </div>
</section>