package vn.edu.hcmuaf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.util.LinkService;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.vod.model.MovieSearch;

/**
 * Created with IntelliJ IDEA. User: xvitcoder Date: 12/21/12 Time: 12:23 AM
 */
@Controller
@RequestMapping("/TimKiemController")
public class TimKiemController {

	@RequestMapping("/layout")
	public String getCarPartialPage(Map<String, Object> map) {
		map.put("topIMDB", topIMDB());
		return "TimKiem";
	}

	@RequestMapping(value = "/Search/{dataSearch}", method = RequestMethod.GET)
	public @ResponseBody
	List<MovieSearch> searchFilm(@PathVariable("dataSearch") String dataSearch) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("searchData", dataSearch);
		RestTemplate restTemplate = new RestTemplate();

		String str = restTemplate.getForObject(LinkService.SEARCH_FILM,
				String.class, params);

		List<MovieSearch> movies = new ArrayList<MovieSearch>();
		Gson gson = new Gson();
		TypeToken<List<MovieSearch>> token = new TypeToken<List<MovieSearch>>() {
		};
		movies = gson.fromJson(str.toString(), token.getType());
		return movies;
	}

	private List<MovieSearch> topIMDB() {
		List<MovieSearch> movies = null;
		RestTemplate restTemplate = new RestTemplate();
		ParameterizedTypeReference<List<MovieSearch>> responseType = new ParameterizedTypeReference<List<MovieSearch>>() {
		};
		ResponseEntity<List<MovieSearch>> result = restTemplate.exchange(
				LinkService.TOPIMDB, HttpMethod.GET, null, responseType);
		if (result.getStatusCode().equals(HttpStatus.OK)) {
			movies = result.getBody();
		}
		return movies;
	}
}