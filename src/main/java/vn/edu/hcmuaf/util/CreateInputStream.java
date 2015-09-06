package vn.edu.hcmuaf.util;

import java.io.InputStream;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.vod.model.Starring;

public class CreateInputStream {

	public static InputStream starringJson() {
		List<Starring> starrings = null;
		RestTemplate restTemplate = new RestTemplate();
		ParameterizedTypeReference<List<Starring>> responseType = new ParameterizedTypeReference<List<Starring>>() {
		};
		ResponseEntity<List<Starring>> result = restTemplate.exchange(
				LinkService.STAR_GETALL, HttpMethod.GET, null, responseType);
		if (result.getStatusCode().equals(HttpStatus.OK)) {
			starrings = result.getBody();
		}
		InputStream inputStream = IOUtils.toInputStream(new Gson()
				.toJson(starrings));
		return inputStream;
	}

}
