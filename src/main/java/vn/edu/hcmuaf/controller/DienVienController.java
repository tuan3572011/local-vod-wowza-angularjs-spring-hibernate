package vn.edu.hcmuaf.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.util.LinkService;

import com.vod.model.Starring;

@Controller
@RequestMapping(value = "/DienVienController")
public class DienVienController {
	private static final Logger logger = LoggerFactory.getLogger(DienVienController.class);

	@RequestMapping(value = "/layout")
	public String addStarringLayout(Model model) {
		model.addAttribute("starring", new Starring());
		logger.info("Them dien vien controller");
		return "ThemDienVien";
	}

	@RequestMapping(value = "/DetailLayout")
	public String DetailStarringLayout() {
		return "ThongTinDienVien";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String saveStarring(@ModelAttribute Starring starring, Model model) {
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Void> entity = restTemplate.postForEntity(LinkService.STAR_ADD, starring, Void.class);
		boolean isSaveOk = true;
		if (entity.getStatusCode().equals(HttpStatus.OK)) {
			isSaveOk = true;
		} else {
			isSaveOk = false;
		}
		if (isSaveOk) {
			model.addAttribute("message", isSaveOk);
		}
		logger.info("save starring: " + isSaveOk);
		return "ThemDienVien";
	}

	@ResponseBody
	@RequestMapping(value = "/StarringDetail/{starringId}", method = RequestMethod.GET)
	public Starring getStarringDetail(@PathVariable(value = "starringId") Integer starringId) {
		Starring starring = null;
		RestTemplate restTemplate = new RestTemplate();
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("starId", starringId);
		ResponseEntity<Starring> result = restTemplate.exchange(LinkService.STAR_GETBY_ID, HttpMethod.GET, null,
				Starring.class, params);
		if (result.getStatusCode().equals(HttpStatus.OK)) {
			starring = result.getBody();
		}
		logger.info(starring.getName());
		return starring;
	}
}
