package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dto.*;

import java.util.List;

public interface ChatService {
    long createRoom(ChatInfoDTO chatInfoDTO);  //채팅 관련 서비스

    List<ChatSessionInfoDTO> getChatListById(Long id);

    void saveChatContent(ChatMessageDTO chatMessage);

    void updateLastJoinAt(Long userId, Long roomId);

    Long getChatRoomIdByPostIdAndGuestID(ChatInfoDTO chatInfoDTO);

    JoinChatInfo getChatRoomInfoByRoomIdAndUserId(ChatroomRequestDTO chatroomRequestDTO);
}
