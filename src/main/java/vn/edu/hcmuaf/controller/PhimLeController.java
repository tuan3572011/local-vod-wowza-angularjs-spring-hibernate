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

import com.vod.model.Movie;

/**
 * Created with IntelliJ IDEA. User: xvitcoder Date: 12/21/12 Time: 12:22 AM
 */
@Controller
@RequestMapping("/PhimLeController")
public class PhimLeController {

	@RequestMapping("/layout")
	public String getTrainPartialPage(Map<String, Object> map) {
		System.out.println("begin phim le layout");
		// map.put("movies", getListMovie());
		return "PhimLe";
	}

	@RequestMapping(value = "/movie/{movieId}", method = RequestMethod.GET)
	public @ResponseBody Movie doShowABC(@PathVariable("movieId") String movieId) {
		Movie movie = getById(movieId);
		return movie;
	}

	@RequestMapping(value = "/FilterBy/{orderId}/{categoryId}/{publishYear}/{countryId}/{page}", method = RequestMethod.GET)
	public @ResponseBody String doFilter(@PathVariable("publishYear") String year,
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

		String str = restTemplate.getForObject(LinkService.MOVIE_FILTER, String.class, params);

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

		Integer str = restTemplate.getForObject(LinkService.MOVIE_FILTER_TOTAL_PAGE, Integer.class, params);

		return str;
	}

	private Movie getById(String movieId) {
		Movie movie = null;
		Map<String, String> params = new HashMap<String, String>();
		params.put("movieId", movieId);
		RestTemplate restTemplate = new RestTemplate();

		movie = restTemplate.getForObject(LinkService.MOVIE_GETBY_ID, Movie.class, params);
		return movie;
	}
}
