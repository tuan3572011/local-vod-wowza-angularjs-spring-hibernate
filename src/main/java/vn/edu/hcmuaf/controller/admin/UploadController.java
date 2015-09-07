package vn.edu.hcmuaf.controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
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

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.UserInfo;

@Controller
@RequestMapping("/UploadController")
public class UploadController {
	private static final Logger logger = LoggerFactory
			.getLogger(UploadController.class);

	private static final String TRAILER_IMAGE_UPLOAD_PATH = ConfigServiceAndDBAddress.imageServerAddress;
	private static final String IMAGE_PATH_SERVER = ConfigServiceAndDBAddress.imagePathInServer;
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
	public String doUploadImage(@RequestParam("image") MultipartFile multipart,
			Map<String, Object> map) throws IOException {
		logger.info("save image");
		File folder = new File(IMAGE_PATH_SERVER);
		boolean isOK = true;
		String name = "";
		if (!multipart.isEmpty()) {
			try {
				String originName = multipart.getOriginalFilename();
				String imageType = originName
						.substring(originName.length() - 3);

				// neu kieu anh ko dung voi anh goc
				name = this.randomName() + "." + imageType;

				if (!folder.exists()) {
					folder.mkdirs();
				}
				multipart.transferTo(new File(IMAGE_PATH_SERVER + "\\" + name));
			} catch (Exception e) {
				isOK = false;
				map.put("message", e.getMessage());
			}
			if (isOK) {
				String imageUrl = TRAILER_IMAGE_UPLOAD_PATH + "/" + name;
				map.put("message", imageUrl);
				logger.info("image location " + imageUrl);
			} else {
				map.put("message", "FAIL");
			}
		}
		return "UploadImage";
	}

	@RequestMapping("/Trailer/Layout")
	public String uploadTrailerLayout() {
		return "UploadTrailer";
	}

	@RequestMapping("/Film/Layout")
	public String uploadFilmLayout() {
		return "UploadFilm";
	}

	@RequestMapping(value = "/Film/Save", method = RequestMethod.POST)
	public String doUploadFilm(
			@RequestParam("film") MultipartFile multipartFilm,
			Map<String, Object> map) throws IOException {
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
				boolean isOK = this.uploadDataToWowza(hostAndUser,
						videoInputStream, videoName, keyInputStream);
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

	private boolean uploadDataToWowza(String hostAndUser,
			InputStream videoInputStream, String videoName,
			InputStream keyInputStream) {

		// get key path
		String pathToKey = ResourcesFolderUtility.getPathFromResourceFolder(
				UploadController.class, "vod1.pem");
		logger.info(pathToKey);
		// open jsch session
		Session jschSession = null;
		try {
			jschSession = getJschSession(pathToKey, hostAndUser);
			logger.info(pathToKey + "----" + hostAndUser);
			jschSession.connect();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		// tranfer genkey file to server
		DataUploadUtility.transferGenKeyFileToEC2(jschSession);
		// upload video using this session
		logger.info(jschSession.getHost() + jschSession.getUserName());
		DataUploadUtility.uploadVideoToWowza(jschSession, videoName,
				videoInputStream, keyInputStream);
		logger.info("end upload video");
		// generate key and read key from server
		video_upload_secret_key = DataUploadUtility
				.generateAndReadVideoKeyFromEc2(jschSession, videoName);
		// close session

		logger.info("session close");
		if (video_upload_secret_key.isEmpty()) {
			jschSession.disconnect();
			return false;
		} else {
			jschSession.disconnect();
			return true;
		}
	}

	private static Session getJschSession(String pathToKey, String hostAndUser)
			throws JSchException {
		String[] hostAndUserArr = hostAndUser.split("@");
		if (hostAndUserArr.length != 2)
			return null;
		String user = hostAndUserArr[0];
		String host = hostAndUserArr[1];
		int port = 22;

		JSch jsch = new JSch();
		Session session = null;
		session = jsch.getSession(user, host, port);
		session.setPassword("123qweqwe");
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