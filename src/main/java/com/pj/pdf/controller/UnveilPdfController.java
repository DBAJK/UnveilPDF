package com.pj.pdf.controller;

import com.pj.pdf.service.UnveilPdfService;
import com.pj.pdf.vo.UnveilPdfVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class UnveilPdfController {
    @Autowired(required = false)
    UnveilPdfService unveilPdfService;
    private static final Logger logger = LoggerFactory.getLogger(UnveilPdfController.class);

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
    @GetMapping("/pjRegist")
    public String pjRegistRedirect() {
        return "redirect:/?formType=pjRegist";
    }
    @GetMapping("/pjDetail")
    public String pjDetailRedirect() {
        return "redirect:/?formType=pjDetail";
    }
    @GetMapping("/ocrForm")
    public String ocrRedirect() {
        return "redirect:/?formType=ocrForm";
    }
    @GetMapping("/myPage")
    public String myPageRedirect() {
        return "redirect:/?formType=myPage";
    }
    @GetMapping("/pdfResult")
    public String pdfResultRedirect() {
        return "redirect:/?formType=pdfResult";
    }

    @GetMapping("/popup/userPopup")
    public String userPopup(Model model) {
        List<UnveilPdfVO> userList = unveilPdfService.getUserList();
        model.addAttribute("userList", userList);
        return "popup/userPopup";
    }

    // 회원가입
    @RequestMapping("/saveJoinForm")
    @ResponseBody
    public void saveJoinForm(UnveilPdfVO vo){
        try {
            unveilPdfService.saveJoinForm(vo);
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
            cntChk = unveilPdfService.idCheck(userId);
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
        UnveilPdfVO userChk = unveilPdfService.userChk(vo);

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
            UnveilPdfVO user = unveilPdfService.findUserById(userId);  // DAO 통해 정보 조회
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
            unveilPdfService.updateUser(vo);
            session.setAttribute("userName", request.getParameter("userName"));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    // 프로젝트 저장
    @RequestMapping("/savePjForm")
    @ResponseBody
    public void savePjForm(UnveilPdfVO vo){
        try {
            unveilPdfService.savePjForm(vo);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    // 프로젝트 조회
    @GetMapping("/service/getProjectList")
    public String getProjectList(HttpSession session, UnveilPdfVO vo, Model model) {
        String userId = (String) session.getAttribute("userId");
        if (userId != null) {
            vo.setUserId(userId); // 세션 값이 있을 때만 설정
        }
        List<UnveilPdfVO> projectList = unveilPdfService.getProjectList(vo);
        model.addAttribute("projectList", projectList);

        return "/mainForm";
    }

    @GetMapping("/service/getPjDtlList")
    public String getPjDtlList(@RequestParam("projectId") int projectId,
                               @RequestParam("projectName") String projectName,
                               Model model) {
        List<UnveilPdfVO> pdfList = unveilPdfService.getProjectById(projectId);
        model.addAttribute("pdfList", pdfList);
        model.addAttribute("projectName", projectName);
        return "/pjDetail";
    }
    @GetMapping("/service/getPdfResult")
    public String getPdfResult(@RequestParam("pdfId") int pdfId, Model model) {
        // PDF 정보 조회
        List<UnveilPdfVO> pdfData = unveilPdfService.getPdfResultData(pdfId);
        model.addAttribute("pdfId", pdfId);
        model.addAttribute("pdfData", pdfData);
        return "/pdfResult";
    }

    // ocr 요청
    @PostMapping("/ocr/upload")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> handleUpload(HttpSession session,UnveilPdfVO vo, @RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        int userSeq = (int) session.getAttribute("userSeq");

        try {
            File tempFile = File.createTempFile("upload_", ".pdf");
            file.transferTo(tempFile);
            // 1. DB에 PDF 파일 정보 저장
            vo.setFileName(file.getOriginalFilename());
            vo.setFilePath(tempFile.getAbsolutePath());
            vo.setUserSeq(userSeq);
            unveilPdfService.insertPdfFile(vo);
            int pdfId = unveilPdfService.getPdfId();
            ProcessBuilder pb = new ProcessBuilder(
                    "C:/Program Files/Python313/python.exe",
                    "D:/workspace/UnveilPDF/src/main/webapp/resources/python/ocr.py",
                    tempFile.getAbsolutePath()
            );

            pb.redirectErrorStream(true);
            Process process = pb.start();

            BufferedReader stdoutReader = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8));
            StringBuilder resultBuilder = new StringBuilder();
            String line;

            while ((line = stdoutReader.readLine()) != null) {
                logger.info("[OCR STDOUT] " + line);
                resultBuilder.append(line).append("\n");
            }

            int exitCode = process.waitFor();
            logger.info("OCR Python script 종료 코드: " + exitCode);

            if (exitCode != 0) {
                throw new RuntimeException("Python script returned non-zero exit code");
            }
            String ocrResult = resultBuilder.toString();

            System.out.println(ocrResult);
            response.put("status", "success");
            response.put("ocrText", ocrResult);
            response.put("pdfId",pdfId);
            Pattern pagePattern = Pattern.compile("--- Page (\\d+) ---\\n(.*?)(?=(\\n--- Page \\d+ ---)|\\Z)", Pattern.DOTALL);
            Matcher matcher = pagePattern.matcher(ocrResult);

            while (matcher.find()) {
                int pageNo = Integer.parseInt(matcher.group(1));
                String ocrText = matcher.group(2).trim();

                vo.setPageNo(pageNo);
                vo.setOcrText(ocrText);
                unveilPdfService.insertOcrResult(vo);
            }
        } catch (Exception e) {
            logger.error("OCR 처리 중 예외 발생", e);
            response.put("status", "fail");
            response.put("message", e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

}