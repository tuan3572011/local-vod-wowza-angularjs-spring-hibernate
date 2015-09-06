package vn.edu.hcmuaf.controller.admin;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.edu.hcmuaf.initListenner.ConfigServiceAndDBAddress;
import vn.edu.hcmuaf.util.DataUploadUtility;
import vn.edu.hcmuaf.util.ResourcesFolderUtility;

import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.UserInfo;

@Controller
@RequestMapping("/UploadController")
public class UploadController {
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

	private static final String TRAILER_IMAGE_UPLOAD_PATH = ConfigServiceAndDBAddress.imageServerAddress
			+ "/vod-wowza/";
	private String video_upload_secret_key = "";

	@RequestMapping("/Image/Layout")
	public String uploadImageLayout() {
		return "UploadImage";
	}

	private String randomName() {
		StringBuilder bd = new StringBuilder();
		Random rd = new Random();
		for (int i = 0; i < 5; i++) {
			bd.append(rd.nextInt(10));
		}
		bd.append(System.currentTimeMillis());
		return bd.toString();
	}

	@RequestMapping(value = "/Image/Save", method = RequestMethod.POST)
	public String doUploadImage(@RequestParam("image") MultipartFile multipart, Map<String, Object> map)
			throws IOException {
		logger.info("save image");
		InputStream inputStream = null;
		if (!multipart.isEmpty()) {
			try {
				inputStream = multipart.getInputStream();
				String originName = multipart.getOriginalFilename();
				long length = multipart.getSize();
				String imageType = originName.substring(originName.length() - 3);

				String contentType = "";
				if (imageType.equals("png")) {
					contentType = "image/png";
				} else if (imageType.equals("jpg")) {
					contentType = "image/jpeg";
				} else if (imageType.equals("gif")) {
					contentType = "image/gif";
				} else if (imageType.equals("tif")) {
					contentType = "image/tiff";
				} else if (imageType.equals("bmp")) {
					contentType = "image/bmp";
				} else {
					map.put("message", "Wrong type");
					return "upload";
				}
				// neu kieu anh ko dung voi anh goc
				String name = this.randomName() + "." + imageType;

				String folder = "Images";
				boolean isOK = UploadController.uploadDataToS3(inputStream, folder, name, length, contentType);
				if (isOK) {
					String imageUrl = TRAILER_IMAGE_UPLOAD_PATH + folder + "/" + name;
					map.put("message", imageUrl);
					logger.info("image location " + imageUrl);
				} else {
					map.put("message", "FAIL");
				}
			} catch (Exception e) {
				map.put("message", e.getMessage());
			}
		}

		return "UploadImage";
	}

	@RequestMapping("/Trailer/Layout")
	public String uploadTrailerLayout() {
		return "UploadTrailer";
	}

	@RequestMapping(value = "/Trailer/Save", method = RequestMethod.POST)
	public String doUploadTrailer(@RequestParam("trailer") MultipartFile multipart, Map<String, Object> map)
			throws IOException {
		InputStream inputStream = null;
		if (!multipart.isEmpty()) {
			try {
				inputStream = multipart.getInputStream();
				String originName = multipart.getOriginalFilename();
				long length = multipart.getSize();
				String trailerType = originName.substring(originName.length() - 3);
				String contentType = "application/octet-stream";
				String name = this.randomName() + "." + trailerType;
				String folder = "Trailer";
				logger.info("Upload to S3");
				boolean isOK = UploadController.uploadDataToS3(inputStream, folder, name, length, contentType);
				if (isOK) {
					map.put("message", TRAILER_IMAGE_UPLOAD_PATH + folder + "/" + name);
				} else {
					map.put("message", "FAIL");
				}
			} catch (Exception e) {
				map.put("message", e.getMessage());
			}
		}

		return "UploadTrailer";
	}

	@RequestMapping("/Film/Layout")
	public String uploadFilmLayout() {
		return "UploadFilm";
	}

	@RequestMapping(value = "/Film/Save", method = RequestMethod.POST)
	public String doUploadFilm(@RequestParam("film") MultipartFile multipartFilm, Map<String, Object> map)
			throws IOException {
		InputStream videoInputStream = null;
		InputStream keyInputStream = null;
		if (!multipartFilm.isEmpty()) {
			try {
				// keyInputStream = multipartKey.getInputStream();
				videoInputStream = multipartFilm.getInputStream();
				String hostAndUser = ConfigServiceAndDBAddress.streamingServerAddress;
				// validate video name
				String videoName = this.randomName() + ".mp4";
				logger.info("begin upto wowza");
				boolean isOK = this.uploadDataToWowza(hostAndUser, videoInputStream, videoName, keyInputStream);
				logger.info("end upto wowza");
				if (isOK) {
					map.put("message", videoName);
					map.put("key", video_upload_secret_key);
					logger.info(videoName + "--" + video_upload_secret_key);
				} else {
					map.put("message", "");
				}
			} catch (Exception e) {
				logger.error(e.getMessage());
				map.put("message", e.getMessage());
			}
		}

		return "UploadFilm";
	}

	private boolean uploadDataToWowza(String hostAndUser, InputStream videoInputStream, String videoName,
			InputStream keyInputStream) {

		// get key path
		String pathToKey = ResourcesFolderUtility.getPathFromResourceFolder(UploadController.class, "vod1.pem");
		logger.info(pathToKey);
		// open jsch session
		Session jschSession = null;
		try {
			jschSession = getJschSession(pathToKey, hostAndUser);
			jschSession.connect();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		// upload video using this session
		logger.info(jschSession.getHost() + jschSession.getUserName());
		DataUploadUtility.uploadVideoToWowza(jschSession, videoName, videoInputStream, keyInputStream);
		logger.info("end upload video");
		// generate key and read key from server
		video_upload_secret_key = DataUploadUtility.generateAndReadVideoKeyFromEc2(jschSession, videoName);
		// close session
		jschSession.disconnect();
		logger.info("session close");
		if (video_upload_secret_key.isEmpty()) {
			return false;
		} else {
			// jschSession.disconnect();
			return true;
		}
	}

	private static boolean uploadDataToS3(InputStream inputStream, String folder, String fileName, long fileLength,
			String contentType) throws IOException {
		boolean result = false;
		String existingBucketName = "vod-wowza";
		String keyName = folder + "/" + fileName;

		AmazonS3 s3Client = new AmazonS3Client(new PropertiesCredentials(
				UploadController.class.getResourceAsStream("AwsCredentials.properties")));

		// s3Client.setEndpoint("autoscaling.ap-southeast-1.amazonaws.com");
		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentType(contentType);
		objectMetadata.setContentLength(fileLength);
		PutObjectRequest putObjectRequest = new PutObjectRequest(existingBucketName, keyName, inputStream,
				objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead);
		PutObjectResult result1 = s3Client.putObject(putObjectRequest);
		inputStream.close();
		result = true;
		logger.info("Etag:" + result1.getETag() + "-->" + result);
		return result;
	}

	private static Session getJschSession(String pathToKey, String hostAndUser) throws JSchException {
		String[] hostAndUserArr = hostAndUser.split("@");
		if (hostAndUserArr.length != 2)
			return null;
		String user = hostAndUserArr[0];
		String host = hostAndUserArr[1];
		int port = 22;

		JSch jsch = new JSch();
		Session session = null;
		jsch.addIdentity(pathToKey);
		session = jsch.getSession(user, host, port);
		session.setUserInfo(new UserInfo() {
			@Override
			public void showMessage(String arg0) {
			}

			@Override
			public boolean promptYesNo(String arg0) {
				return true;
			}

			@Override
			public boolean promptPassword(String arg0) {
				return false;
			}

			@Override
			public boolean promptPassphrase(String arg0) {
				return false;
			}

			@Override
			public String getPassword() {
				return null;
			}

			@Override
			public String getPassphrase() {
				return null;
			}
		});
		return session;
	}

}