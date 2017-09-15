package us.duia.leejo0531.controller;

import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import us.duia.leejo0531.service.UserService;
import us.duia.leejo0531.vo.IdCheckVO;
import us.duia.leejo0531.vo.MajorVO;
import us.duia.leejo0531.vo.MinorVO;
import us.duia.leejo0531.vo.UserVO;

@Controller
public class UserController implements HttpSessionListener{
	private static final Logger logger=LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	UserService userSvc;
	
	public static Hashtable<String, String> loginSessionMonitor;

	// 현재 접속자 수
	public static int getActiveLoginSessionCount(){
		if(loginSessionMonitor == null){
			return 0;
		}else{
			return loginSessionMonitor.size();
		}
	}
	
	
	// 회원가입 양식 보기
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String joinForm(Model model){
		ArrayList<MajorVO> majorList = userSvc.getMajorList();
		model.addAttribute("majorList", majorList);
		return "user/joinPage";
	}
	
	@RequestMapping(value="minorList", method=RequestMethod.GET)
	public @ResponseBody ArrayList<MinorVO> minorList(){
		ArrayList<MinorVO> minorList = userSvc.getMinorList();
		return minorList;
	}
	
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public @ResponseBody IdCheckVO idCheck(String searchId){
		UserVO searchResult = userSvc.getUser(searchId);
		return new IdCheckVO(searchId, searchResult, true);
	}
	
	@RequestMapping(value="checkboxList", method=RequestMethod.GET)
	public @ResponseBody ArrayList<String> checkboxList(String minorName){
		ArrayList<String> checkboxList = userSvc.getCheckboxList(minorName);
		return checkboxList;
	}
	
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join(UserVO user, @RequestParam("checkboxArray[]") ArrayList<String> field){
		userSvc.insertUserInfo(user, field);
		return "redirect:/"; 
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String requestLogin(UserVO user,HttpSession session){	
		UserVO loginUser = userSvc.requestLogin(user);
		
		if(loginSessionMonitor == null) loginSessionMonitor = new Hashtable<String, String>();
		
		synchronized(loginSessionMonitor){
			loginSessionMonitor.put(session.getId(), loginUser.getId());
		}
		
		System.out.println(loginSessionMonitor+"확인용");

		session.setAttribute("userName", loginUser.getUserName());
		session.setAttribute("userId", loginUser.getId());
		session.setAttribute("userNum", loginUser.getUserNum());
		
		return "redirect:/";
	}
	
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout(HttpSession session){
		session.invalidate();
		synchronized (loginSessionMonitor) {
			loginSessionMonitor.remove(session.getId());
		}
		return "redirect:/";
	}
	
	@RequestMapping(value="updateUserInfo", method=RequestMethod.GET)
	public String updateUserInfoPage(Model model, HttpSession session){
		ArrayList<MajorVO> majorList = userSvc.getMajorList();
		model.addAttribute("majorList", majorList);
		return "user/updateUserInfoPage";
	}
	
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateUserInfo(UserVO user, @RequestParam("updatedCheckboxArray[]") ArrayList<String> field, HttpSession session){
		user.setUserNum((int)session.getAttribute("userNum"));
		userSvc.updateUserInfo(user, field);
		return "redirect:/";
	}
	
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public String openMyPage(Model model, HttpSession session){
		int questionsNum = userSvc.countQuestions((int)session.getAttribute("userNum"));
		int completedQuestions = userSvc.countCompletedQuestions((int)session.getAttribute("userNum"));
		int answersNum = userSvc.countAnswers((int)session.getAttribute("userNum"));
		model.addAttribute("qestionsNum", questionsNum);
		model.addAttribute("completedQuestions", completedQuestions);		
		model.addAttribute("answersNum", answersNum);
		return "mypage";
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
	}

}
