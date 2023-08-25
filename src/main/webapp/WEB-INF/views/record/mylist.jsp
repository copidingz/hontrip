<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="map-container">
  <div id="map"></div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&autoload=true"></script>
<script>

var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(36.3504, 127.3845), // 지도의 중심 좌표
        level: 13 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

<c:forEach items="${mymap}" var="locationDTO">
    var marker = new kakao.maps.Marker({ // 마커 생성
        map: map,
        position: new kakao.maps.LatLng(${locationDTO.lat}, ${locationDTO.lon}) // 마커 위치 설정
    });

    var infowindow = new kakao.maps.InfoWindow({
        content: '<div> ${locationDTO.city}</div>' // 인포윈도우 내용 설정
    });

    // 마커 클릭 이벤트 등록
       kakao.maps.event.addListener(marker, 'click',
       function() {
         // 초기화
         $("#mylist-section").hide();
         $("#list-mylocation-result2").hide();
         $("#list-mylocation-result3").hide();
           $.ajax({
               type: "GET",
               url: "list-mylocation", // 요청할 URL
               data: { locationId: ${locationDTO.id} }, // 마커의 locationId를 전달
               dataType: "html",
               success: function(response) {
                 $("#list-mylocation-result").html(response).show(); // 결과를 표시하도록 변경
               },
               error: function() {
                   // 에러 처리
                   console.log("AJAX 요청 실패");
               }
           });
       });

       kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
       kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
   </c:forEach>



// 인포윈도우를 표시하는 클로저 생성 함수
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저 생성 함수
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

</script>

<!-- 검색어 입력창을 포함한 컨테이너 -->
<div id="search-container">
  <input type="text" id="city" placeholder="장소 검색어를 입력하세요">
  <button id="searchButton">검색</button>
</div>

<!-- 검색어 입력시 ajax -->
<script>
$(document).ready(function() {
  // 검색 버튼 클릭 이벤트 처리
  $('#searchButton').click(function() {
    // 초기화
      $("#mylist-section").hide();
      $("#list-mylocation-result").hide();
      $("#list-mylocation-result3").hide();
    var city = $('#city').val();
     // 검색어가 비어있지 않을 경우에만 Ajax 요청
    if (city !== '') {
      // Ajax 요청
      $.ajax({
        type: 'GET',
        url: "list-mylocation2",
        data: { city: city },
        success: function(response) {
          // 결과를 결과창에 표시
            $("#list-mylocation-result2").html(response).show(); // 결과를 표시하도록 변경
        },
        error: function() {
          // 오류 처리
          alert('검색한 자료가 없습니다.');
        }
      });
    }
  });
});
</script>

<!-- 드롭다운 컨테이너 -->
  <select id="locationDropdown">
    <option value="" disabled selected>지역을 선택하세요</option>
    <c:forEach items="${locationList}" var="locationDTO">
        <option value="${locationDTO.id}">${locationDTO.city}</option>
    </c:forEach>
  </select>

<!-- 드롭박스 선택시 ajax -->
<script>
  $(document).ready(function() {
    // 드롭다운 선택 이벤트 처리
    $('#locationDropdown').change(function() {
      // 초기화
      $("#mylist-section").hide();
      $("#list-mylocation-result").hide();
      $("#list-mylocation-result2").hide();

      var selectedLocationId = $(this).val();

      $.ajax({
        type: 'GET',
        url: "list-mylocation3",
        data: { locationId: selectedLocationId },
        success: function(response) {
          $("#list-mylocation-result3").html(response).show();
        },
        error: function() {
          // 오류 처리
          alert('검색한 자료가 없습니다.');
        }
      });
    });
  });
</script>


<!-- 내 게시물 표시 부분 -->
<div id="mylist-section">
<a href="feedlist?isVisible=1"><button>공유피드</button></a><br>
<a href="createpost"><button>게시글작성버튼</button></a><br>
내 게시물 전체 리스트
<hr color="red">
    <c:forEach items="${mylist}" var="createPostDTO">
        <div id = "mylistone">
                    <img src="<c:url value='/${createPostDTO.thumbnail}'/>"width="300" height="180"><br>,
                    유저정보 : ${createPostDTO.userId},
                    지역id : ${createPostDTO.locationId},
                    글제목 : ${createPostDTO.title},
                    공개여부: ${createPostDTO.isVisible} <br>
        </div>
    </c:forEach>
</div>

<!-- 마커 클릭 시 해당 지역 게시물 표시 부분 -->
<div id="list-mylocation-result" ></div>

<!-- 검색어 검색 시 해당 지역 게시물 표시 부분 -->
<div id="list-mylocation-result2" ></div>

<!-- 드롭다운 선택 시 해당 지역 게시물 표시 부분 -->
<div id="list-mylocation-result3" ></div>
