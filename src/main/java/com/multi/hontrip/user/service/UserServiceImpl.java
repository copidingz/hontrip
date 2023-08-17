package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dao.UserDAO;
import com.multi.hontrip.user.dto.LoginUrlData;
import com.multi.hontrip.user.dto.UserDTO;
import com.multi.hontrip.user.dto.UserInsertDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements  UserService{   //사용자 회원처리

    private final UserDAO userDAO;
    @Qualifier("kakaoService")
    private final OauthService kakaoService;
    @Qualifier("naverService")
    private final OauthService naverService;

    @Override
    public List<LoginUrlData> getUrls(){   //로그인 가능한 소셜ouath주소 리스트로 저장
        List<LoginUrlData> urlList = new ArrayList<>();
        urlList.add(new LoginUrlData("kakao",kakaoService.getLoginUrl(),"/resources/img/user/kakao_login_medium_narrow.png"));    //카카오
        urlList.add(new LoginUrlData("naver",naverService.getLoginUrl(),"/resources/img/user/btnG_완성형.png"));   //네이버
        return urlList;
    }

    @Override
    public UserDTO getUserInfByAuth(HttpServletRequest request, String provider) throws Exception { //소셜 인증정보를 통해 DB저장
        UserInsertDTO userInsertDTO =null;  //DB에 입력할 정보
        String logOutUrl = null;
        if(provider.equals("kakao")){   //카카오 인증인 경우
            userInsertDTO=kakaoService.getOauthInfo(request.getParameter("code"),null);  //카카오 인증 받아오기
        }else if(provider.equals("naver")){
            userInsertDTO=naverService.getOauthInfo(request.getParameter("code"),request.getParameter("state"));
        }

        // 기존 회원 판별
        Long userId = userDAO.findIdByProviderAndSocialID(userInsertDTO.getProvider(),userInsertDTO.getSocialId());
        if(userId==null){ //db 신규저장
           userInsertDTO = userDAO.saveUserInfo(userInsertDTO); //신규 회원 저장
        }else{  //db 정보 갱신
            userInsertDTO.setId(userId);    //id 넣어서 해당 정보 update
            userDAO.updateUserInfo(userInsertDTO);  // update
        }
        return UserInsertDTO.convertToInsertUserDTO(userInsertDTO,logOutUrl); // 세션에 넣을 정보 저장
    }

    @Override
    public void logOut(Long userId) {   //로그아웃시 사용자 access 토큰 관련 정보 지우기
        userDAO.removeAccessToken(userId);
    }

    @Override
    public String getUserLogOutUrl(Long id) {       // id로 공급자 검색해서 로그아웃 url 반환
        String provider = userDAO.getProviderById(id);  // 공급자 검색
        if(provider.equals("kakao")) {
            return kakaoService.getLogOutUrl();   // kakao 로그아웃 url 반환
        }else if(provider.equals("naver")){
            return naverService.getLogOutUrl();
        }
        return "/";
    }
}
