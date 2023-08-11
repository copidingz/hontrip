package com.multi.hontrip.user.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class UserInsertDTO {  //DB에 입력할 소셜 인증 사용자 정보
    private Long id;    // 내부 회원 ID
    private String provider;    //Oauth 공급자
    private Long socialId;    //Oauth 공급ID
    private String nickName;    //닉네임
    private String profileImage;    //프로필 이미지
    private int ageRangeId;        //연령대    - null일 수 있음
    private int gender;      //성별   - null일 수 있음
    private String email;   //이메일
    private String accessTocken;    //접근토큰
    private LocalDateTime expiresAt;    //만료일자
    private String refreshToken;    //리프레시토큰
    private LocalDateTime refreshTokenExpiresAt;    //리프레시토큰 만료일자
    private LocalDateTime createdAt;    //생성일자

    public static UserDTO convertToInsertUserDTO(UserInsertDTO userInsertDTO) { //user DB 입력 정보를 UserDTO에 넣기
        String ageRange= AgeRange.getDescriptionFromId(userInsertDTO.getAgeRangeId());
        String gender = Gender.getDescriptionFromId(userInsertDTO.getGender());
        return UserDTO.builder()
                .id(userInsertDTO.getId())
                .nickName(userInsertDTO.getNickName())
                .profileImage(userInsertDTO.getProfileImage())
                .ageRange(ageRange)
                .gender(gender)
                .email(userInsertDTO.getEmail())
                .build();
    }
}

