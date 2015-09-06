package vn.edu.hcmuaf.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.service.LoginServiceImpl;
import vn.edu.hcmuaf.util.LinkService;

@Controller
@RequestMapping("/RechargeController")
public class RechargeController {
	private static final Logger logger = LoggerFactory.getLogger(RechargeController.class);
	@Autowired
	private LoginServiceImpl userService;

	@RequestMapping(value = "/addRecharge", method = RequestMethod.POST)
	public @ResponseBody String doAddRecharge(@RequestParam("email") String email, @RequestParam("seri") String seri) {
		String message = "FAIL";
		Map<String, String> params = new HashMap<String, String>();
		params.put("seri", seri);
		params.put("email", email);
		RestTemplate restTemplate = new RestTemplate();

		try {
			message = restTemplate.getForObject(LinkService.RECHARGE_ADD, String.class, params);
		} catch (Exception e) {
			logger.info("Null Exception!");
			logger.error(e.getMessage());
			return null;
		}
		return message;
	}

	@RequestMapping(value = "/getRecharges/{email}/user", method = RequestMethod.GET)
	public @ResponseBody String doGetListRecharge(@PathVariable("email") String email) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("email", email);
		RestTemplate restTemplate = new RestTemplate();

		String str = restTemplate.getForObject(LinkService.RECHARGE_GETBY_USER, String.class, params);
		return str;
	}

}
