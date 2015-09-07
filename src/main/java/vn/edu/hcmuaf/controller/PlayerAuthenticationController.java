package vn.edu.hcmuaf.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.util.LinkService;
import vn.edu.hcmuaf.util.TokenUtils;

import com.vod.model.Episodes;
import com.vod.model.Movie;

/**
 * Created with IntelliJ IDEA. User: xvitcoder Date: 12/21/12 Time: 12:22 AM
 */
@Controller
@RequestMapping("/PlayerAuthenticationController")
public class PlayerAuthenticationController {
	private static final Logger logger = LoggerFactory.getLogger(PlayerAuthenticationController.class);
	private static final Map<String, String> sessionID_VideoKey_Map = new HashMap<String, String>();

	@RequestMapping(value = "/layout", method = RequestMethod.GET)
	public String doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// }
		logger.info("-----------------Layout-------------------");
		return "Player";
	}

	@RequestMapping
	public void getKey(HttpServletRequest request, HttpServletResponse response) {
		logger.info("-----------------DO GET------------");
		String sessionID = request.getSession().getId();
		logger.info("SessionID = " + sessionID);
		if (sessionID_VideoKey_Map.containsKey(sessionID)) {
			String key = sessionID_VideoKey_Map.get(sessionID);
			if (key != null) {
				sessionID_VideoKey_Map.remove(sessionID);
				try {
					this.tranferKey(key.trim(), response);
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
			}
		}
	}

	private boolean isUserRegisterFilm(String email, String idFilm) {
		String check = "FAIL";
		Map<String, String> params = new HashMap<String, String>();
		params.put("email", email);
		params.put("idFilm", idFilm);

		RestTemplate restTemplate = new RestTemplate();
		try {
			restTemplate.getForObject(LinkService.REGIS_GETBY_EMAIL_IDFILM, Void.class, params);
			logger.info("OK");
			check = "OK";
		} catch (HttpClientErrorException e) {
			if (e.getStatusCode().equals(HttpStatus.NOT_FOUND)) {
				logger.info("NOT FOUND");
			}
		}
		if (check.equals("OK")) {
			return true;
		}
		return false;
	}

	private String getEpisodeKey(String movieId) {
		Episodes episode = null;
		Map<String, String> params = new HashMap<String, String>();
		params.put("epId", movieId);
		RestTemplate restTemplate = new RestTemplate();

		episode = restTemplate.getForObject(LinkService.EPISODE_GETBY_ID, Episodes.class, params);
		return episode.getMovie_key();
	}

	private String getMovieKey(String movieId) {
		Movie movie = null;
		Map<String, String> params = new HashMap<String, String>();
		params.put("movieId", movieId);
		RestTemplate restTemplate = new RestTemplate();

		movie = restTemplate.getForObject(LinkService.MOVIE_GETBY_ID, Movie.class, params);
		return movie.getMovie_key();

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@RequestMapping(method = RequestMethod.POST)
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String movieId = request.getParameter("movieId");
		String movieType = request.getParameter("type");

		logger.info("-----------------DO POST---------");
		HttpServletRequest httpRequest = this.getAsHttpRequest(request);

		String authToken = this.extractAuthTokenFromRequest(httpRequest);
		logger.info("authToken:" + authToken);
		String email = TokenUtils.getUserNameFromToken(authToken);

		if (email != null) {
			boolean isUserRegisterFilm = this.isUserRegisterFilm(email, movieId);
			if (isUserRegisterFilm) {
				String key = "";
				if (movieType.equals("movie")) {
					key = this.getMovieKey(movieId);
				} else {
					key = this.getEpisodeKey(movieId);
				}
				String sessionID = request.getSession().getId();
				sessionID_VideoKey_Map.put(sessionID, key);
			}

		}
		logger.info("-----------------END DO POST-----------");
	}

	private void tranferKey(String keyStr, HttpServletResponse response) throws IOException {
		logger.info("Do authentication");
		response.setHeader("Content-Type", "binary/octet-stream");
		response.setHeader("Pragma", "no-cache");
		logger.info("Send secret key " + keyStr + " to client");

		int len = keyStr.length() / 2;
		byte[] keyBuffer = new byte[len];

		for (int i = 0; i < len; i++)
			keyBuffer[i] = (byte) Integer.parseInt(keyStr.substring(i * 2, (i * 2) + 2), 16);

		OutputStream outs = response.getOutputStream();
		outs.write(keyBuffer);
		outs.flush();
	}

	private HttpServletRequest getAsHttpRequest(ServletRequest request) {
		if (!(request instanceof HttpServletRequest)) {
			throw new RuntimeException("Expecting an HTTP request");
		}

		return (HttpServletRequest) request;
	}

	private String extractAuthTokenFromRequest(HttpServletRequest httpRequest) {
		/* Get token from header */
		String authToken = httpRequest.getHeader("X-Auth-Token");

		/* If token not found get it from request parameter */
		if (authToken == null) {
			authToken = httpRequest.getParameter("token");
		}

		return authToken;
	}
}