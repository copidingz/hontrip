if (window.location.href.includes('/mate/insert')) {

    //인서트창으로 돌아오지 못하게 막음
    window.history.forward();

    $(function () {
        $('#complete').on("click", function () {
            /*console.log(
                $('#userId').val()
                , $('#imageInput')[0].files[0]
                , $("input[name='regionId']:checked").val()
                , $('#ageRangeId').val()
                , $('#title').val()
                , $('#content').val()
                , $('#mateStartDate').val()
                , $('#mateEndDate').val()
                , $('#recruitNumber').val()
                , $("input[name='gender']:checked").val()
                , $('#isFinish').val()
            )*/

            if ($('#imageInput')[0].files[0] == null) {
                $('#mateImageEmptyWarning').show();
            }

            if ($('#title').val() == null || $('#title').val() == "") {
                $('#mateTitleEmptyWarning').show();
            }

            if ($('#content').val() == null || $('#content').val() == "") {
                $('#mateContentEmptyWarning').show();
            }
            if ($('#mateStartDate').val() == null || $('#mateStartDate').val() == ""
                || $('#mateEndDate').val() == null || $('#mateEndDate').val() == "") {
                $('#mateDateEmptyWarning').show();
            }

            const formData = new FormData();
            formData.append("userId", $('#userId').val())
            formData.append("file", $('#imageInput')[0].files[0])
            formData.append("regionId", $("input[name='regionId']:checked").val())
            formData.append("ageRangeId", $("input[name='ageRangeId']:checked").val())
            formData.append("title", $('#title').val())
            formData.append("content", $('#content').val().replaceAll(/(?:\r\n|\r|\n)/g, '<br>'))
            formData.append("startDate", $('#mateStartDate').val())
            formData.append("endDate", $('#mateEndDate').val())
            formData.append("recruitNumber", $('#recruitNumber').val())
            formData.append("gender", $("input[name='gender']:checked").val())
            formData.append("isFinish", $('#isFinish').val())

            if ($('#imageInput')[0].files[0] != null && ($('#title').val() != null && $('#title').val() != "")
                && ($('#content').val() != null && $('#content').val() != "") &&
                ($('#mateStartDate').val() != null && $('#mateStartDate').val() != "" &&
                    $('#mateEndDate').val() != null && $('#mateEndDate').val() != "")) {
                $.ajax({
                    type: "POST",
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    url: "insert",
                    data: formData,
                    success: function (boardId) {
                        console.log(boardId)
                        location.href =
                            boardId
                    },
                    error: function (e) {
                        console.log(e);
                    }
                })
            }
        })
    })

    const imageInput = document.getElementById("imageInput");
    const uploadYourImage = document.getElementById("uploadYourImage");
    const uploadedImage = document.getElementById("upldimg");

    uploadYourImage.addEventListener("click", () => {
        imageInput.click();
    });

    uploadedImage.addEventListener("click", () => {
        imageInput.click();
    });

    imageInput.addEventListener("change", (event) => {
        uploadYourImage.hidden = true;
        uploadedImage.hidden = false;
        const selectedFile = event.target.files[0];
        if (selectedFile) {
            const reader = new FileReader();
            reader.onload = (e) => {
                uploadedImage.src = e.target.result;
            };
            reader.readAsDataURL(selectedFile);
        }
    });


    function ageRangeChecked() {
        let checkedArr = [];
        let checkboxes = document.querySelectorAll('input[type="checkbox"][name="age"]:checked');
        for (let i = 0; i < checkboxes.length; i++) {
            checkedArr.push(checkboxes[i].value);
        }
        let checkedStr = checkedArr[0];
        for (let i = 1; i < checkedArr.length; i++) {
            checkedStr += "," + checkedArr[i];
        }
        console.log(checkedStr)
        if (checkboxes.length === 0) {
            checkedStr = ""
        }
        $('#ageRangeId').attr('value', checkedStr);
    }

    function dateInit() {
        let today = new Date();
        let dd = today.getDate();
        let mm = today.getMonth() + 1; // 0부터 시작하므로 1을 더해줍니다.
        const yyyy = today.getFullYear();

        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        const fomattedToday = yyyy + '-' + mm + '-' + dd;
        $('#mateStartDate').prop("min", fomattedToday);
        $('#mateEndDate').prop("min", fomattedToday);
    }

    $(document).ready(function () {
        dateInit();

        $('#mateStartDate').on('change', function () {
            $('#mateEndDate').prop("min", $(this).val());
            $('#mateDateEmptyWarning').hide();
        });

        $('#mateEndDate').on('change', function () {
            $('#mateStartDate').prop("max", $(this).val());
            $('#mateDateEmptyWarning').hide();
        });

        $('#title').on('input', function () {
            $('#mateTitleEmptyWarning').hide();
        });

        $('#content').on('input', function () {
            $('#mateContentEmptyWarning').hide();
        });


        $('#imageInput').on('change', function () {
            $('#mateImageEmptyWarning').hide();
        });
    });
}


/*동행인 게시판 수정페이지*/
if (window.location.href.includes('/mate/editpage')) {
    function boardInit() {

        if ($('#mateBoardDbAgeRangeId').val() != "") {
            let ageRange = $('#mateBoardDbAgeRangeId').val();
            let ageRangeArr = ageRange.split(",");
            for (let i = 0; i < ageRangeArr.length; i++) {
                $('#' + ageRangeArr[i]).prop("checked", true)
            }
            $('#ageRangeId').attr('value', $('#mateBoardDbAgeRangeId').val());
        }

        $('#isFinish').val($('#mateBoardDbIsFinish').val()).prop("selected", true);
        $('#recruitNumber').val($('#mateBoardDbRecruitNumber').val()).prop("selected", true);
    }

    function ageRangeChecked() {
        let checkedArr = [];
        let checkboxes = document.querySelectorAll('input[type="checkbox"][name="age"]:checked');
        for (let i = 0; i < checkboxes.length; i++) {
            checkedArr.push(checkboxes[i].value);
        }
        let checkedStr = checkedArr[0];
        for (let i = 1; i < checkedArr.length; i++) {
            checkedStr += "," + checkedArr[i];
        }
        console.log(checkedStr)
        if (checkboxes.length === 0) {
            checkedStr = ""
        }
        $('#ageRangeId').attr('value', checkedStr);
    }

    function genderChecked() {
        let genderVal = document.querySelector('input[type="radio"][name="genders"]:checked');
        $('#gender').val(genderVal.value);
    }


//여행 시작, 마지막날짜 설정 및 min 설정
    function dateInit() {
        let today = new Date();
        let dd = today.getDate();
        let mm = today.getMonth() + 1; // 0부터 시작하므로 1을 더해줍니다.
        const yyyy = today.getFullYear();

        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        const formattedToday = yyyy + '-' + mm + '-' + dd;
        const maxDay = (yyyy + 2) + '-' + mm + '-' + dd;

        $('#mateStartDate').prop("min", formattedToday);
        $('#mateEndDate').prop("min", formattedToday);

        $('#mateStartDate').on('change', function () {
            $('#mateEndDate').prop("min", $(this).val());
        });

        $('#mateEndDate').on('change', function () {
            $('#mateStartDate').prop("max", $(this).val());
        });
    }

    $(document).ready(function () {
        boardInit();
        dateInit();
    });

    $(function () {
        $('#edit').on("click", function () {
            if ($('#file')[0].files[0] == null) {
                $.ajax({
                    method: "POST",
                    url: "edit",
                    data: {
                        id: $('#mateBoardId').val(),
                        regionId: $("input[name='regionId']:checked").val(),
                        ageRangeId: $("input[name='ageRangeId']:checked").val(),
                        title: $('#title').val(),
                        content: $('#content').val().replaceAll(/(?:\r\n|\r|\n)/g, '<br>'),
                        thumbnail: $('#mateBoardThumbnail').val(),
                        startDate: $('#mateStartDate').val(),
                        endDate: $('#mateEndDate').val(),
                        recruitNumber: $('#recruitNumber').val(),
                        gender: $("input[name='gender']:checked").val(),
                        isFinish: $('#isFinish').val()
                    },
                    success: function () {
                        location.href = $('#mateBoardId').val();
                    },
                    error: function (e) {
                        console.log(e);
                    }
                })
            } else {
                const formData = new FormData();
                formData.append("id", $('#mateBoardId').val())
                formData.append("file", $('#file')[0].files[0])
                formData.append("regionId", $("input[name='regionId']:checked").val())
                formData.append("ageRangeId", $("input[name='ageRangeId']:checked").val())
                formData.append("title", $('#title').val())
                formData.append("content", $('#content').val().replaceAll(/(?:\r\n|\r|\n)/g, '<br>'))
                formData.append("startDate", $('#mateStartDate').val())
                formData.append("endDate", $('#mateEndDate').val())
                formData.append("recruitNumber", $('#recruitNumber').val())
                formData.append("gender", $("input[name='gender']:checked").val())
                formData.append("isFinish", $('#isFinish').val())
                $.ajax({
                    method: "POST",
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false,
                    url: "edit",
                    data: formData,
                    success: function () {
                        location.href = $('#mateBoardId').val();
                    },
                    error: function (e) {
                        console.log(e);
                    }
                })
            }
        })
    })

    const imageInput = document.getElementById("file");
    const uploadYourImage = document.getElementById("uploadYourImage");
    const uploadedImage = document.getElementById("upldimg");


    uploadedImage.addEventListener("click", () => {
        imageInput.click();
    });

    imageInput.addEventListener("change", (event) => {
        const selectedFile = event.target.files[0];
        if (selectedFile) {
            const reader = new FileReader();
            reader.onload = (e) => {
                uploadedImage.src = e.target.result;
            };
            reader.readAsDataURL(selectedFile);
        }
    });
}


// 동행인 상세게시판
if (window.location.href.includes('/mate/')) {
    function applyMate() {
        //로그인 안했을 경우 로그인창을 띄움ss
        if ($('#mateSenderId').val() == "") {
            location.href = "../user/sign-in"
            //로그인 했을 경우
        } else {
            //신청자의 성별, 연령대를 가져온 후, 모집조건에 적합한지 체크한다
            $.ajax({
                url: "findUserGenderAge",
                data: {
                    id: $('#mateSenderId').val()
                },
                dataType: "json",
                success: function (json) {
                    //게시글 작성자가 원하는 연령대 리스트 생성
                    let ageRangeStrArr = [];

                    //ageRanggeJs의 value가 공백이 아닐때
                    if ($('#ageRangeJS').val() != "") {
                        ageRangeStrArr = $('#ageRangeJS').val().split(",");
                    }

                    //ageRanggeJs의 value가 공백이 아닐때 && 1개일때(,가 없을때)
                    if ($('#ageRangeJS').val() != "" && !$('#ageRangeJS').val().includes(",")) {
                        ageRangeStrArr[0] = $('#ageRangeJS').val();
                    }

                    console.log($('#ageRangeJS').val())
                    console.log("젠더 원트: " + $('#mateBoardGenderStr').val())
                    console.log("에이지 원트: " + ageRangeStrArr)
                    console.log("유저젠더: " + json.gender)
                    console.log("유저나이: " + json.ageRange)
                    console.log(json.ageRange == "나이정보 없음")

                    //모집조건에 부합하다면
                    //성별, 연령대 아무나 처리
                    if (json.id == $('#mateSenderId').val() && (json.gender === $('#mateBoardGenderStr').val() ||
                            $('#mateBoardGenderStr').val() == "성별무관" || json.gender == "정보없음")
                        && (ageRangeStrArr.includes(json.ageRange) || ageRangeStrArr.includes("전연령")
                            || ageRangeStrArr.length == 0 || json.ageRange == "나이정보 없음")) {
                        $("#ableButton").click();
                        //모집조건에 부합하지 않다면
                    } else {
                        $("#unableButton").click()
                    }
                },
                error: function (e) {
                    console.log(e)
                }
            })//ajax
        }
    }


    /*모달에서 삭제버튼을 눌렀을때 */
    function deleteAccept() {
        $.ajax({
            url: "delete",
            data: {
                id: $('#mateBoardId').val()
            },
            success: function (result) {
                location.href = "../mate/bbs_list?page=1"
            }, error: function (e) {
                console.log(e)
            }
        })
    }


    /*삭제시 경고 모달*/
    function deleteMateBoard() {
        $('#deleteButton').click();
    }

    /* 셀렉트원에서 -> 동행인신청버튼누르고 + 신청조건에 맞는사람일경우에 넣기 */


    //동행인신청메세지 모달에서 전송버튼을 눌렀을때
    function send() {
        if ($('#applicationMessage').val().trim() == "") {
            $('#applicationMessage').val("같이 여행가요")
        }
        $.ajax({
            type: "POST",
            url: "insertMatchingAlarm",
            data: {
                mateBoardId: $('#mateBoardId').val(),
                senderId: $('#mateSenderId').val(),
                content: $("#applicationMessage").val()
            },
            success: function () {
                //동행 신청 메세지를 전송한 후, 모달을 끄고
                location.reload()
                //동행인 신청 알람 보내기
                sendAlarm($('#mateBoardId').val(), $('#mateSenderId').val(),
                    $('#mateSenderNickName').val(), $('#mateSenderProfileImage'),
                    $('#writerId').val(), $("#applicationMessage").val())

                //동행인 신청 버튼 비활성화
                $('#application').attr('disabled', 'disabled');
            }, error: function (e) {
                console.log(e)
            }
        })
    }

    $(document).ready(function () {
        let login = $('#mateSenderId').val();

        //로그인 했고,
        if (login != "") {

            //이미 지원한 경우 동행인 신청 버튼 비활성화
            $.ajax({
                url: "checkApply",
                data: {
                    senderId: $('#mateSenderId').val(),
                    mateBoardId: $('#mateBoardId').val()
                },
                dataType: "json",
                success: function (result) {
                    if (result === 1) {
                        $('#application').attr('disabled', 'disabled');
                    }
                },
                error: function (e) {
                    console.log(e)
                }
            })
        }
    });


    function updateCommentSection(commentListRe) {
        let comments = "";
        let cCount = commentListRe.list.length;
        let rCount = commentListRe.reCommentList.length;
        let commentListCount = "";
        if (cCount > 0) {
            for (let i = 0; i < cCount; i++) {
                let commentList = commentListRe.list[i];
                if (commentList.commentSequence == 0) {
                    comments += `
                        <li class="comment">
                            <div class="comment-header d-md-flex align-items-center">
                                <div class="d-flex align-items-center">
                                    <figure class="user-avatar">
                                        <img class="rounded-circle" alt="" src="${commentList.profileImage}" />
                                    </figure>
                                    <div>
                                        <h6 class="comment-author">
                                            <a href="#" class="link-dark">${commentList.nickname}</a>
                                        </h6>
                                        <ul class="post-meta">
                                            <li><i class="uil uil-calendar-alt"></i>${commentList.createdAt}</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="mt-3 mt-md-0 ms-auto">
                                    <a href="javascript:void(0);" onclick="showCcmtTextarea(${commentList.commentId})"
                                       class="btn btn-outline-primary btn-sm rounded-pill btn-icon btn-icon-start mb-0"><i
                                            class="uil uil-comments"></i> 답글 달기</a>
                                </div>
                            </div>
                            <p><h3>${commentList.content}</h3></p>
                        </li>
                    `;

                    if (commentList.userId == sessionUserId) {
                        comments += `
                            <a class="btn btn-primary rounded-pill" href="javascript:void(0);" onclick="showUpdateTextarea(${commentList.commentId})">수정</a>
                            <div class="d-flex justify-content-end">
                                <button type="button" class="commentDelete btn btn-primary rounded-pill" data-comment-id="${commentList.commentId}">삭제</button>
                            </div>
                            <div id="commentUpdate${commentList.commentId}" style="display: none">
                                <textarea id="updateContent${commentList.commentId}" class="mate-comment-content form-control" placeholder="수정글을 입력해주세요" required>${commentList.content}</textarea>
                                <br>
                                <button type="button" class="updateComment btn btn-primary rounded-pill" data-comment-id="${commentList.commentId}">수정</button>
                                <a class="btn btn-soft-primary rounded-pill" href="javascript:void(0);" onclick="closeTextarea(${commentList.commentId})">취소</a>
                            </div>
                        `;
                    }

                    for (let i = 0; i < rCount; i++) {
                        let replyList = commentListRe.reCommentList[i];
                        if (commentList.commentId == replyList.indentationNumber) {
                            comments += `
                                <ul class="children">
                                    <li class="comment">
                                        <div class="comment-header d-md-flex align-items-center">
                                            <div class="d-flex align-items-center">
                                                <figure class="user-avatar">
                                                    <img class="rounded-circle" alt="" src="${replyList.profileImage}" />
                                                </figure>
                                                <div>
                                                    <h6 class="comment-author"><a href="#" class="link-dark">${replyList.nickname}</a></h6>
                                                    <ul class="post-meta">
                                                        <li><i class="uil uil-calendar-alt"></i>${replyList.createdAt}</li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <p><h3>${replyList.content}</h3></p>
                            `;

                            if (replyList.userId == sessionUserId) {
                                comments += `
                                    <a class="btn btn-primary rounded-pill" href="javascript:void(0);" onclick="showUpdateTextarea(${replyList.commentId})">수정</a>
                                    <div class="d-flex justify-content-end">
                                        <button type="button" class="commentDelete btn btn-primary rounded-pill" data-comment-id="${replyList.commentId}">삭제</button>
                                    </div>
                                    <div id="commentUpdate${replyList.commentId}" style="display: none">
                                        <textarea id="updateContent${replyList.commentId}" class="mate-comment-content form-control" placeholder="수정글을 입력해주세요">${replyList.content}</textarea>
                                        <br>
                                        <button type="button" class="updateComment btn btn-primary rounded-pill" data-comment-id="${replyList.commentId}">수정</button>
                                        <a class="btn btn-soft-primary rounded-pill" href="javascript:void(0);" onclick="closeTextarea(${replyList.commentId})">취소</a>
                                    </div>
                                `;
                            }

                            comments += `</li></ul>`;
                        }
                    }
                    comments += `
                        <div id="cComment${commentList.commentId}" style="display: none">
                            <textarea id="cContent${commentList.commentId}" class="mate-comment-content form-control" placeholder="답글을 입력해주세요"></textarea>
                            <br>
                            <button type="button" class="cCommentWrite btn btn-outline-primary rounded-pill" data-comment-id="${commentList.commentId}">답글 전송</button>
                            <a class="btn btn-soft-primary rounded-pill" href="javascript:void(0);" onclick="closeCTextarea(${commentList.commentId})">취소</a>
                            <br>
                        </div>
                    `;


                }
            }
        } else {
            comments += "<div>";
            comments += "<h6>등록된 댓글이 없습니다.</h6>";
            comments += "</div>";
        }
        commentListCount += `<h3 class="mb-6">${commentListRe.commentListCount} 댓글</h3>`
        $('#clc').empty().html(commentListCount);
        $('#result').html(comments);
    }

    function showUpdateTextarea(commentId) {
        var updateField = document.getElementById("commentUpdate" + commentId);
        updateField.style.display = "block";
    }

    function closeTextarea(commentId) {
        var updateField = document.getElementById("commentUpdate" + commentId);
        updateField.style.display = "none";
    }

    function showCcmtTextarea(commentId) {
        var updateField = document.getElementById("cComment" + commentId);
        updateField.style.display = "block";
    }

    function closeCTextarea(commentId) {
        var updateField = document.getElementById("cComment" + commentId);
        updateField.style.display = "none";
    }

    $(function () {
        $('#commentWrite').click(function () {
            var userId = $('#userId').val();
            var nickname = $('#nickName').val();

            if (!userId) {
                alert("로그인 해주세요.");
                return;
            }
            $.ajax({
                url: "/hontrip/mate/comment_insert",
                data: {
                    mateBoardId: $('#mateBoardId').val(),
                    content: $('#cmtContent').val(),
                    userId: userId,
                    nickname: nickname
                },
                dataType: "json",
                success: function (cmtListRe) {
                    updateCommentSection(cmtListRe);
                    $('#cmtContent').val("");
                },
                error: function () {
                    alert("실패!");
                } // error
            });
        }); // commentWrite

        //댓글,답글 삭제
        $(document).on('click', '.commentDelete', function () {
            let commentId = $(this).data("comment-id");
            console.log(commentId);
            $.ajax({
                url: "/hontrip/mate/comment_delete",
                dataType: "json",
                data: {
                    commentId: commentId,
                    mateBoardId: $('#mateBoardId').val(),
                    userId: $('#userId').val()
                },
                success: function (cmtListRe) {
                    updateCommentSection(cmtListRe);
                },
                error: function () {
                    console.log("삭제 실패");
                }
            })
        }) // commentDelete


        //댓글 수정
        $(document).on('click', '.updateComment', function () {
            let commentId = $(this).data("comment-id");
            let content = $('#updateContent' + commentId).val(); // 올바른 값을 가져오기 위해 .val() 사용
            $.ajax({
                url: "/hontrip/mate/comment_edit",
                dataType: "json",
                data: {
                    commentId: commentId,
                    mateBoardId: $('#mateBoardId').val(),
                    content: content
                },
                success: function (cmtListRe) {
                    updateCommentSection(cmtListRe);
                },
                error: function () {
                    console.log("수정 실패");
                }
            })
        }) // commentUpdate

        //답글 수정
        $(document).on('click', '.cCommentWrite', function () {
            let commentId = $(this).data("comment-id");
            let content = $('#cContent' + commentId).val(); // 올바른 값을 가져오기 위해 .val() 사용
            $.ajax({
                url: "/hontrip/mate/reply_insert",
                dataType: "json",
                data: {
                    mateBoardId: $('#mateBoardId').val(),
                    content: content,
                    userId: $('#userId').val(),
                    nickname: $('#nickName').val(),
                    commentSequence: '1',
                    commentId: commentId,
                    indentationNumber: commentId
                },
                success: function (cmtListRe) {
                    updateCommentSection(cmtListRe);
                },
                error: function () {
                    console.log("수정 실패");
                }
            })
        }) // commentUpdate


    }); // $

}


