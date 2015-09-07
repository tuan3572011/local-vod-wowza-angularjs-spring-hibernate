package vn.edu.hcmuaf.controller;

import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.util.LinkService;

import com.vod.model.Director;
import com.vod.model.Starring;

@Controller
@RequestMapping("/GetJsonController")
public class GetJsonDataController {

	@ResponseBody
	@RequestMapping(value = "/Director", method = RequestMethod.POST)
	public List<Director> getAllDirector() {
		List<Director> directors = null;
		RestTemplate restTemplate = new RestTemplate();

		ParameterizedTypeReference<List<Director>> responseType = new ParameterizedTypeReference<List<Director>>() {
		};
		ResponseEntity<List<Director>> result = restTemplate.exchange(LinkService.DIRECTOR_GETALL, HttpMethod.GET,
				null, responseType);

		if (result.getStatusCode().equals(HttpStatus.OK)) {
			directors = result.getBody();
		}
		return directors;

	}

	@ResponseBody
	@RequestMapping(value = "/Starring", method = RequestMethod.POST)
	public List<Starring> getAllStarring() {

		List<Starring> starrings = null;
		RestTemplate restTemplate = new RestTemplate();

		ParameterizedTypeReference<List<Starring>> responseType = new ParameterizedTypeReference<List<Starring>>() {
		};
		ResponseEntity<List<Starring>> result = restTemplate.exchange(LinkService.STAR_GETALL, HttpMethod.GET, null,
				responseType);

		if (result.getStatusCode().equals(HttpStatus.OK)) {
			starrings = result.getBody();
		}
		return starrings;
	}

}
