package vn.edu.hcmuaf.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.vod.model.Card;

@Controller
@RequestMapping("/CardController")
public class CardController {

	@RequestMapping("/layout")
	public String doShow(Map<String, Object> map) {
		map.put("cards", getListCard());
		return "admin/card";
	}

	private List<Card> getListCard() {
		List<Card> cards = null;
		final String url = "http://servicevod-lee07.rhcloud.com/VOD-ServiceProject/card/all";
		RestTemplate restTemplate = new RestTemplate();
		ParameterizedTypeReference<List<Card>> responseType = new ParameterizedTypeReference<List<Card>>() {
		};
		ResponseEntity<List<Card>> result = restTemplate.exchange(url,
				HttpMethod.GET, null, responseType);

		if (result.getStatusCode().equals(HttpStatus.OK)) {
			cards = result.getBody();
		}
		return cards;
	}
}
