//이건 셀렉트원에서 -> 동행인신청버튼누르고 + 신청조건에 맞는사람일경우에 넣기
let stompClient = null;
$(document).ready(function () {
    if ($('#mateLoginUserId') != "" && stompClient == null) {
        connectStomp()
    }
});

//웹소켓 연결 + 알림을 받기 위해 자신의 아이디를 구독
function connectStomp() {
    let socket = new SockJS('${pageContext.request.contextPath}/matews');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        console.log(frame);
        stompClient.subscribe('/sub/' + $('#mateLoginUserId').val(), function (result) {
            applyAlarm(JSON.parse(result.body));
        })
    })
}

//stomp 설정 끊음
function stompDisconnect() {
    if (stompClient != null) {
        stompClient.disconnect();
    }
    console.log('해제됨')
}

function applyAlarm(result) {
    /*let response = document.getElementById('alarmResult');
    let p = document.createElement('p');
    p.innerHTML = "senderId :" + result.senderId + ", message: " + result.content;
    response.appendChild(p);*/
    $('#alertSpan').text("senderId :" + result.senderId + ", message: " + result.content);
}