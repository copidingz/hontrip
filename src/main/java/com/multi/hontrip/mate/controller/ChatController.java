package com.multi.hontrip.mate.controller;

import com.multi.hontrip.mate.dto.ChatInfoDTO;
import com.multi.hontrip.mate.dto.ChatSessionInfoDTO;
import com.multi.hontrip.mate.dto.ChatroomRequestDTO;
import com.multi.hontrip.mate.dto.JoinChatInfo;
import com.multi.hontrip.mate.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/mate")
public class ChatController {
    private final ChatService chatService;

    @PostMapping("/create-chatroom")    //form으로 보낼때는 requestBody 쓰지 마시오
    public ModelAndView createChatRoom(ChatInfoDTO chatInfoDTO, ModelAndView modelAndView) { // 채팅방 새로 생성하기(post소유주만 가능)  : 채팅 후 환영인사까지 하기 위해
        Long roomId = chatService.getChatRoomIdByPostIdAndGuestID(chatInfoDTO);
        if (roomId == null) {
            ChatSessionInfoDTO chatSessionInfoDTO = chatService.createRoom(chatInfoDTO);
            chatSessionInfoDTO.setChatRoomName(chatInfoDTO.getChatRoomName());
            modelAndView.addObject("chatSessionInfo",chatSessionInfoDTO);
            modelAndView.setViewName("/mate/chatroom-view");   //바로 뷰로 넘김
        } else {    //이미 존재하는 방이면
            modelAndView.setViewName("redirect:/mate/join-chat/"+roomId+"?user_id="+chatInfoDTO.getOwnerId());
        }
        return modelAndView;
    }

    @PostMapping("my-chat-list")
    public List<ChatSessionInfoDTO> findAllRooms(HttpSession session) { // 내 채팅방 리스트 전체 가져오기
        Long id = (Long) session.getAttribute("id");
        List<ChatSessionInfoDTO> chatRoomDTOList = chatService.getChatListById(id);
        return chatRoomDTOList;
    }

    @GetMapping("/chat-view")
    public ModelAndView chatPage(ModelAndView modelAndView) {
        modelAndView.setViewName("/mate/chat-view");
        return modelAndView;
    }

    @GetMapping("/join-chat/{roomId}")
    public ModelAndView joinChat(@PathVariable("roomId") Long roomId,
                                 @RequestParam("user_id") Long userId,
                                 ModelAndView modelAndView) {
        // TODO 원래 session정보에서 sender를 가져와야 하나 지금은 Query로 가져옴
        // 쳇방 정보를 가져와야함
        ChatroomRequestDTO chatroomRequestDTO = ChatroomRequestDTO.builder()
                .roomId(roomId)
                .senderId(userId)
                .build();
        // 이전 쳇정보를 가져와야 함
        JoinChatInfo joinChatInfo = chatService.getChatRoomInfoByRoomIdAndUserId(chatroomRequestDTO);
        //model setting
        modelAndView.addObject("joinChatInfo",joinChatInfo);
        modelAndView.setViewName("/mate/chatroom-view");
        return modelAndView;
    }
}