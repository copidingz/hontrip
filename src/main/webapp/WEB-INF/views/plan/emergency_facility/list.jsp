<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75 text-center">
        <h1 class="mb-5">응급시설 조회</h1>
        <form id="emergency_facility_search_form" class="mt-3 left-aligned" method="post" action="filter_list">
            <div class="input-group mb-3">
                <select id="categorySelect" name="categoryGroupName" form="emergency_facility_search_form"
                        class="form-select">
                    <option value="" selected>전체</option>
                    <option value="병원">병원</option>
                    <option value="약국">약국</option>
                </select>
                <input type="text" id="addressName" name="addressName" class="form-control me-2" placeholder="주소 입력"
                       value="">
                <button type="submit" name="filterType" value="address" class="btn btn-primary">검색</button>
            </div>
        </form>
        <%--<ul class="unordered-list mt-4">
            <c:forEach items="${list}" var="emergency_facility">
                <div class="card mt-2">
                    <div class="card-body left-aligned">
                            <strong>응급시설 id:</strong> ${emergency_facility.id}<br>
                            <strong>응급시설 카테고리 그룹:</strong> ${emergency_facility.categoryGroupName}<br>
                            <strong>응급시설 이름:</strong> ${emergency_facility.placeName}<br>
                            <strong>응급시설 주소:</strong> ${emergency_facility.addressName}<br>
                            <strong>응급시설 전화번호:</strong> ${emergency_facility.phone}<br>
                            <strong>응급시설 URL:</strong> <a href="${emergency_facility.placeUrl}" target="_blank"
                                                          class="custom-a">${emergency_facility.placeUrl}</a><br>
                        </div>
                </div>
            </c:forEach>
        </ul>--%>
    </div>

    <div class="loading-overlay d-none" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(255,255,255,0.8); z-index: 9999; display: flex; align-items: center; justify-content: center;">
        <div class="spinner-border text-primary" style="width: 4rem; height: 4rem;"></div>
    </div>
</section>

<script>
    $(document).ready(function() {
        $('#emergency_facility_search_form').on('submit', function() {
            $('.loading-overlay').removeClass('d-none');
        });
    });


    $(document).on("submit", "#emergency_facility_search_form", function (e) {
        e.preventDefault();

        $.ajax({
            url: "/hontrip/plan/emergency_facility/filter_list",
            method: "POST",
            data: $(this).serialize(),
            success: function (data) {
                $("#modalContent").html(data);
                $('.loading-overlay').addClass('d-none');  // Hide
            },
            error: function () {
                alert("안전정보 검색에 실패했습니다.");
                $('.loading-overlay').addClass('d-none');  // Hide
            }
        });
    });

    // closed
    $(document).on('hidden.bs.modal', '#modalContent', function () {
        $('.loading-overlay').addClass('d-none');
    });
</script>
