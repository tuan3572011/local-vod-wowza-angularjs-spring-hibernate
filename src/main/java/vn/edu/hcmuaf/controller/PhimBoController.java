package vn.edu.hcmuaf.controller;

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

import com.vod.model.MovieSearch;
import com.vod.model.MovieSerie;

/**
 * Created with IntelliJ IDEA. User: xvitcoder Date: 12/21/12 Time: 12:22 AM
 */
@Controller
@RequestMapping("/PhimBoController")
public class PhimBoController {

	@RequestMapping("/layout")
	public String getTrainPartialPage(Map<String, Object> map) {
		return "PhimBo";
	}

	@RequestMapping(value = "/serie/{movieId}", method = RequestMethod.GET)
	public @ResponseBody MovieSerie doShowSerieDetail(@PathVariable("movieId") String movieId) {
		MovieSerie movie = getById(movieId);
		return movie;
	}

	@RequestMapping(value = "/jsonsearch", method = RequestMethod.GET)
	public @ResponseBody String doGetJsonSearch() {
		System.out.println(LinkService.SEARCH_FILM_JSON);
		RestTemplate restTemplate = new RestTemplate();
		String result = restTemplate.getForObject(LinkService.SEARCH_FILM_JSON, String.class);
		return result;
	}

	@RequestMapping(value = "/FilterBy/{orderId}/{categoryId}/{publishYear}/{countryId}/{page}", method = RequestMethod.GET)
	public @ResponseBody String doFilter(@PathVariable("publishYear") String year,
			@PathVariable("orderId") String orderId, @PathVariable("categoryId") String categoryId,
			@PathVariable("countryId") String countryId, @PathVariable("page") String page) {

		Map<String, String> params = new HashMap<String, String>();
		params.put("categoryId", categoryId);
		params.put("orderId", orderId);
		params.put("publishYear", year);
		params.put("countryId", countryId);
		params.put("page", page);

		RestTemplate restTemplate = new RestTemplate();

		String str = restTemplate.getForObject(LinkService.SERIE_FILTER, String.class, params);

		return str;
	}

	@RequestMapping(value = "/GetTotalFilterPage/{orderId}/{categoryId}/{publishYear}/{countryId}/{page}", method = RequestMethod.GET)
	public @ResponseBody Integer getTotalFilterPage(@PathVariable("publishYear") String year,
			@PathVariable("orderId") String orderId, @PathVariable("categoryId") String categoryId,
			@PathVariable("countryId") String countryId, @PathVariable("page") String page) {

		try {
			Integer.parseInt(page);
		} catch (NumberFormatException ex) {
			page = "1";
		}

		Map<String, String> params = new HashMap<String, String>();
		params.put("categoryId", categoryId);
		params.put("orderId", orderId);
		params.put("publishYear", year);
		params.put("countryId", countryId);
		params.put("page", page);

		RestTemplate restTemplate = new RestTemplate();
		Integer str = restTemplate.getForObject(LinkService.SERIE_FILTER_TOTAL_PAGE, Integer.class, params);

		return str;
	}

	private MovieSerie getById(String movieId) {
		MovieSerie movie = null;
		Map<String, String> params = new HashMap<String, String>();
		params.put("serieId", movieId);
		RestTemplate restTemplate = new RestTemplate();

		movie = restTemplate.getForObject(LinkService.SERIE_GETBY_ID, MovieSerie.class, params);
		return movie;
	}

}