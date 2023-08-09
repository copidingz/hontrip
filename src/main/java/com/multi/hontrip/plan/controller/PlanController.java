package com.multi.hontrip.plan.controller;


import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.service.PlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class PlanController {

    @Autowired
    PlanService planService;

    @RequestMapping("/plan_form") // 여행일정 insert
    public String showPlanForm() {
        return "plan_form";
    }

    @RequestMapping(value = "/insert_plan", method = RequestMethod.POST, consumes = "application/json")
    @ResponseBody // plan_form에서 insert한 정보 ajax로 insert_plan으로 전달
    public String insert(@RequestBody PlanDTO planDTO) {
        planDTO.setUserId(1L); // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
        planService.insert(planDTO);
        return "Plan inserted successfully!";
    }

    // 업데이트
    public String update(PlanDTO planDTO){
        PlanDTO newPlan = new PlanDTO();
        newPlan.setId(planDTO.getId());

        planService.update(newPlan);
        //return "redirect:plan.jsp";
        return null;
    }

    @RequestMapping("delete.plan")
    @ResponseBody
    public void delete(Long id, Model model) {
        planService.delete(id);
    }

    @RequestMapping("one.plan")
    @ResponseBody
    public PlanDTO one(Long id) {
        PlanDTO planDTO = planService.one(id);
        return planDTO;
    }

    // 여행 일정 list
    @RequestMapping("plan_list")
    public void list(Model model) {
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);
    }
}
