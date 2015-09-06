package vn.edu.hcmuaf.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.util.LinkService;

/**
 * Created with IntelliJ IDEA. User: xvitcoder Date: 12/20/12 Time: 5:27 PM
 */
@Controller
@RequestMapping("/CaNhanController")
public class CaNhanController {
	
	@RequestMapping(value = "/layout")
	public String getIndexPage(Map<String, Object> map) {
		return "canhan";
	}
	
	@RequestMapping(value = "/history/{email}/regis", method = RequestMethod.GET)
	public @ResponseBody String doGetHistory(@PathVariable(value = "email") String email) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("email", email);
		RestTemplate restTemplate = new RestTemplate();

		String str = restTemplate.getForObject(
				LinkService.REGIS_GET_HISTORY, String.class, params);

		return str;
	}

	@RequestMapping(value = "/thongtin/layout", method = RequestMethod.GET)
	public String doGetLayOutThongTin() {
		return "thongtincanhan";
	}

	@RequestMapping(value = "/recharge/layout", method = RequestMethod.GET)
	public String doGetLayOutRecharge() {
		return "recharge";
	}

	@RequestMapping(value = "/history/layout", method = RequestMethod.GET)
	public String doGetLayOutHistory() {
		return "historyRegister";
	}

}
