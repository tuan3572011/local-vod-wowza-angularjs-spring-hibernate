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

import com.vod.model.Comment;
import com.vod.model.Movie;
import com.vod.model.User;

@Controller
@RequestMapping("/CommentController")
public class CommentController {
	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

	@Autowired
	private LoginServiceImpl userService;

	@RequestMapping(value = "/getByMovieId/{filmId}", method = RequestMethod.GET)
	public @ResponseBody String doGetCommentByMovieId(@PathVariable("filmId") String filmId) {
		String comments = getByMovieId(filmId);
		return comments;
	}

	private String getByMovieId(String filmId) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("filmId", filmId);
		RestTemplate restTemplate = new RestTemplate();

		String str = restTemplate.getForObject(LinkService.COMMENT_GETBY_MOVIE, String.class, params);

		return str;
	}

	@ResponseBody
	@RequestMapping(value = "/Save", method = RequestMethod.POST)
	public String save(@RequestParam("email") String userEmail, @RequestParam("comment") String commentContent,
			@RequestParam("movieId") String movieId) {
		logger.info("mv id " + movieId);
		User user = userService.getUser(userEmail);
		Comment comment = new Comment();
		comment.setContent(commentContent);
		comment.setUser(user);
		Movie movie = getById(movieId);
		comment.setMovieOdd(movie);
		RestTemplate restTemplate = new RestTemplate();
		// + movie.getType();
		String url = LinkService.COMMENT_ADD;
		restTemplate.postForEntity(url, comment, Void.class);
		String comments = this.getByMovieId(movieId);
		return comments;
	}

	private Movie getById(String movieId) {
		Movie movie = null;
		Map<String, String> params = new HashMap<String, String>();
		params.put("movieId", movieId);
		RestTemplate restTemplate = new RestTemplate();

		movie = restTemplate.getForObject(LinkService.MOVIE_GETBY_ID, Movie.class, params);
		logger.info(movie.getEngName());
		return movie;
	}
}
