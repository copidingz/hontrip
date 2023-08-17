package com.multi.hontrip.mate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mate")
public class ChatController {

    @RequestMapping("/chat-room")
    public String chatRoom(){
        return "/mate/chat-romm-view";
    }

    @RequestMapping("/chat")
    public String chat(){
        return "/mate/chat-view";
    }
}
