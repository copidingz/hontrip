package com.multi.hontrip.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class UserController {
    @RequestMapping("/users")
    public String home(Model model){
        model.addAttribute("title","테스트중");
        System.out.println("user");
        return "user/home";
    }
}
