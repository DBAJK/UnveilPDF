package com.pj.pdf.controller;

import com.pj.pdf.service.UnveilPdfService;
import com.pj.pdf.vo.UnveilPdfVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class UnveilPdfController {
    @Autowired(required = false)
    UnveilPdfService kboPjService;

    @GetMapping("/")
    public String index(@RequestParam(value = "formType", required = false) String formType, Model model) {
        if (formType == null) {
            formType = "mainForm"; // 기본값
        }
        model.addAttribute("formType", formType);
        return "indexForm"; // => indexForm.jsp 출력
    }
    // 별도 URL을 통한 접근도 허용하려면 redirect 사용 가능
    @GetMapping("/loginForm")
    public String loginRedirect() {
        return "redirect:/?formType=login";
    }

    @GetMapping("/joinForm")
    public String joinRedirect() {
        return "redirect:/?formType=join";
    }
    @GetMapping("/mainForm")
    public String mainRedirect() {
        return "redirect:/?formType=main";
    }
    // 회원가입
    @RequestMapping("/saveJoinForm")
    @ResponseBody
    public void saveJoinForm(UnveilPdfVO vo){
        try {
            kboPjService.saveJoinForm(vo);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    // 회원가입 아이디 체크
    @RequestMapping("/idCheck")
    @ResponseBody
    public String idCheck(@RequestParam("userId") String userId){
        int cntChk=0;
        String cnt="0";
        try {
            cntChk = kboPjService.idCheck(userId);
            if(cntChk == 1){
                cnt = "1";
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return cnt;
    }

    // 로그인 하기
    @RequestMapping(value = "/service/loginForm", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String loginCheck(HttpServletRequest request, UnveilPdfVO vo) {
        String userName = "";
        vo.setUserId(request.getParameter("userId"));
        vo.setUserPwd(request.getParameter("userPwd"));
        UnveilPdfVO userChk = kboPjService.userChk(vo);

        if(userChk != null){
            HttpSession session = request.getSession();
            userName = userChk.getUserName();
            session.setAttribute("userId", vo.getUserId());
            session.setAttribute("userName", userName);
            session.setAttribute("userSeq", userChk.getUserSeq());
            return userName; // 로그인 성공
        }
        return "";
    }


    //로그아웃
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // 존재하는 세션만 가져옴
        if (session != null) {
            session.invalidate(); // 세션 무효화
        }
        return "redirect:/mainForm"; // 로그아웃 후 메인으로 이동
    }

    // 내 정보 조회
    @GetMapping("/myPageInfo")
    @ResponseBody
    public Map<String, Object> myPageInfo(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Map<String, Object> map = new HashMap<>();
        if (session != null && session.getAttribute("userId") != null){
            String userId = (String) session.getAttribute("userId");
            UnveilPdfVO user = kboPjService.findUserById(userId);  // DAO 통해 정보 조회
            map.put("status", "success");
            map.put("userId", user.getUserId());
            map.put("userName", user.getUserName());
        } else {
            map.put("status", "fail");
            map.put("message", "로그인 정보가 없습니다.");
        }
        return map;
    }

    // 정보 수정
    @RequestMapping("/updateUsersInfo")
    @ResponseBody
    public void updateUsersInfo(HttpServletRequest request, UnveilPdfVO vo){
        HttpSession session = request.getSession();
        try {
            vo.setUserId(request.getParameter("userId"));
            vo.setUserPwd(request.getParameter("userPwd"));
            vo.setUserName(request.getParameter("userName"));
            kboPjService.updateUser(vo);
            session.setAttribute("userName", request.getParameter("userName"));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}