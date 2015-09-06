package vn.edu.hcmuaf.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import vn.edu.hcmuaf.controller.admin.UploadController;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class DataUploadUtility {
	private static final Logger logger = LoggerFactory.getLogger(DataUploadUtility.class);
	private static final String VIDEO_DIR_IN_EC2 = "/usr/local/WowzaStreamingEngine/content";
	private static final String HOME_DIR_IN_EC2 = "/home/ec2-user/";
	private static final String KEY_DIR_IN_EC2 = "/usr/local/WowzaStreamingEngine/keys/";
	private static final String GEN_KEY_FILE = "genkeyWowzaCommand.sh";
	private static final String XML_HEADER = "\'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\'";
	private static final String BITRATE_720 = "1350000";
	private static final String BITRATE_480 = "850000";

	// http://flash.flowplayer.org/demos/plugins/streaming/bwcheck-smil.html

	public static boolean uploadVideoToWowza(Session session, String videoName, InputStream videoInputStream,
			InputStream keyInputStream) {
		boolean isTransferOk = false;

		try {
			// transfer data
			File localFile = fromStream2File(videoInputStream, "rrr", ".mp4");
			byte[] buffer = new byte[1500000];
			logger.info("begin transfer data scp " + videoName);
			isTransferOk = transferDataToEc2UsingScp(session, localFile, videoName, VIDEO_DIR_IN_EC2, buffer);

		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return isTransferOk;
	}

	private static File fromStream2File(InputStream in, String PREFIX, String SUFFIX) throws IOException {
		final File tempFile = File.createTempFile(PREFIX, SUFFIX);
		tempFile.deleteOnExit();
		try (FileOutputStream out = new FileOutputStream(tempFile)) {
			IOUtils.copy(in, out);
		}
		return tempFile;
	}

	public static String generateAndReadVideoKeyFromEc2(Session session, String videoName) {
		try {
			// upload key
			String fileUpLoadPath = ResourcesFolderUtility.getPathFromResourceFolder(UploadController.class,
					GEN_KEY_FILE);
			File localFile = new File(fileUpLoadPath);
			String pathToSaveInServer = HOME_DIR_IN_EC2;
			boolean isTranferGenKeyCommandFileOk = transferDataToEc2UsingScp(session, localFile, localFile.getName(),
					pathToSaveInServer, new byte[500]);
			logger.info("Transfer key ok " + isTranferGenKeyCommandFileOk);
			if (isTranferGenKeyCommandFileOk) {
				// if upload video is ok, generate key for this video
				logger.info("begin genkey");
				generateKeyFileForVideoInEC2(session, videoName);
				logger.info("end execute genkey");
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					logger.error(e.getMessage());
				}

				// read key of this video
				ChannelSftp sftpChannel = (ChannelSftp) session.openChannel("sftp");
				sftpChannel.connect();
				String keyLocation = KEY_DIR_IN_EC2 + videoName + ".key";
				logger.info(keyLocation);
				InputStream inputStream = sftpChannel.get(keyLocation);
				BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
				String keyLine = reader.readLine();
				while (keyLine.isEmpty()) {
					keyLine = reader.readLine();
				}
				logger.info(keyLine);
				String key = null;
				// key is delimited by :
				if (keyLine.split(":").length == 2) {
					key = keyLine.split(":")[1];
				}
				logger.info("key: " + key);

				create480pVideoInEC2(session, videoName);
				createKeyFileFor480pVideoInEC2(session, videoName);
				createSmilFileForVideo(session, videoName);
				if (key != null) {
					return key;
				}
			}

		} catch (JSchException | SftpException | IOException e) {
			logger.error(e.getMessage());
		}
		return "";
	}

	private static void generateKeyFileForVideoInEC2(Session session, String videoName) throws JSchException,
			IOException {
		Channel shellChannel = session.openChannel("shell");
		StringBuilder command = new StringBuilder();
		command.append("cd");
		command.append(" ");
		command.append(HOME_DIR_IN_EC2);
		command.append("\n");

		command.append("chmod 777");
		command.append(" ");
		command.append(GEN_KEY_FILE);
		command.append("\n");

		command.append("nohup");
		command.append(" ");
		command.append("./");
		command.append(GEN_KEY_FILE);
		command.append(" ");
		command.append(videoName);
		command.append(" ");
		command.append("&");
		command.append("\n");

		executeChannel(shellChannel, command.toString());
	}

	private static void create480pVideoInEC2(Session session, String videoName) throws JSchException, IOException {
		int indexOfDot = videoName.indexOf(".");
		String extension = videoName.substring(indexOfDot);
		String nameWithoutExtension = videoName.substring(0, indexOfDot);
		String newVideoName = nameWithoutExtension + "_480" + extension;
		StringBuilder command = new StringBuilder();
		command.append("cd");
		command.append(" ");
		command.append(VIDEO_DIR_IN_EC2);
		command.append("\n");

		command.append("nohup");
		command.append(" ");
		command.append("ffmpeg -i ");
		command.append(videoName);
		command.append(" -vf scale=854:480  -b:v 850k ");
		command.append(newVideoName);
		command.append(" ");
		command.append("&");
		command.append("\n");
		logger.info("create 480p video " + command.toString());
		Channel shellChannel = session.openChannel("shell");
		executeChannel(shellChannel, command.toString());
	}

	private static void createKeyFileFor480pVideoInEC2(Session session, String videoName) throws JSchException,
			IOException {
		int indexOfDot = videoName.indexOf(".");
		String nameWithoutExtension = videoName.substring(0, indexOfDot);
		String extension = videoName.substring(indexOfDot);
		String newVideoName = nameWithoutExtension + "_480" + extension;
		Channel shellChannel = session.openChannel("shell");
		StringBuilder command = new StringBuilder();

		command.append("cd");
		command.append(" ");
		command.append(KEY_DIR_IN_EC2);
		command.append("\n");

		command.append("nohup");
		command.append(" ");
		command.append("cp");
		command.append(" ");
		command.append(videoName);
		command.append(".key");
		command.append(" ");
		command.append(newVideoName);
		command.append(".key");
		command.append(" ");
		command.append("&");
		command.append("\n");

		executeChannel(shellChannel, command.toString());
	}

	private static void createSmilFileForVideo(Session session, String videoName) throws JSchException, IOException {
		int indexOfDot = videoName.indexOf(".");
		String nameWithoutExtension = videoName.substring(0, indexOfDot);
		String newName = nameWithoutExtension + ".smil";
		Channel shellChannel = session.openChannel("shell");
		StringBuilder command = new StringBuilder();

		command.append("cd");
		command.append(" ");
		command.append(VIDEO_DIR_IN_EC2);
		command.append("\n");

		command.append("nohup");
		command.append(" ");
		command.append("touch");
		command.append(" ");
		command.append(newName);
		command.append(" ");
		command.append("&");
		command.append("\n");

		command.append("echo");
		command.append(" ");
		command.append(XML_HEADER);
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'<smil>\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'<body>\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'<switch>\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'<video src=");
		command.append("\"");
		command.append(videoName);
		command.append("\"");
		command.append(" ");
		command.append("system-bitrate=");
		command.append("\"");
		command.append(BITRATE_720);
		command.append("\"");
		command.append("/>");
		command.append("\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'<video src=");
		command.append("\"");
		command.append(nameWithoutExtension);
		command.append("_480.mp4");
		command.append("\"");
		command.append(" ");
		command.append("system-bitrate=");
		command.append("\"");
		command.append(BITRATE_480);
		command.append("\"");
		command.append("/>");
		command.append("\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'</switch>\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'</body>\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		command.append("echo \'</smil>\'");
		command.append(">>");
		command.append(newName);
		command.append("\n");

		logger.info("create smil file: " + command.toString());
		executeChannel(shellChannel, command.toString());
	}

	private static void executeChannel(Channel shellChannel, String command) throws JSchException, IOException {
		shellChannel.setInputStream(IOUtils.toInputStream(command, "UTF-8"));
		shellChannel.setOutputStream(System.out);
		shellChannel.connect();
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			logger.error(e.getMessage());
		}
		shellChannel.disconnect();
	}

	private static boolean transferDataToEc2UsingScp(Session ss, File localFile, String videoName,
			String pathToSaveInServer, byte[] buffer) {
		BufferedOutputStream bufferedOutput = null;
		Channel channel = null;
		try {
			channel = ss.openChannel("exec");
			StringBuilder command = new StringBuilder();
			command.append("scp -t");
			command.append(" ");
			command.append(pathToSaveInServer);
			command.append("/");
			command.append(videoName);
			((ChannelExec) channel).setCommand(command.toString());

			// get I/O streams for remote scp
			OutputStream out = channel.getOutputStream();
			channel.connect();
			long fileSize = localFile.length();
			command = new StringBuilder();
			command.append("C0644");
			command.append(" ");
			command.append(fileSize);
			command.append(" ");
			command.append(videoName);
			command.append("\n");
			out.write(command.toString().getBytes());
			out.flush();

			// send a content of lfile
			InputStream inputStream = new FileInputStream(localFile);
			BufferedInputStream bufferedInput = new BufferedInputStream(inputStream);
			bufferedOutput = new BufferedOutputStream(out);
			long existSize = fileSize;
			while (true) {
				int length = bufferedInput.read(buffer, 0, buffer.length);
				if (length <= 0) {
					break;
				}
				bufferedOutput.write(buffer, 0, length);
				bufferedOutput.flush();
				existSize -= length;

				logger.info((int) ((double) (fileSize - existSize) / fileSize * 100) + " %");
			}
			bufferedInput.close();
			// send '\0'
			buffer[0] = 0;
			bufferedOutput.write(buffer, 0, 1);
			bufferedOutput.flush();

		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		} finally {
			if (bufferedOutput != null) {
				try {
					bufferedOutput.close();
				} catch (IOException e) {
					logger.error(e.getMessage());
				}
			}
			if (channel != null) {
				if (channel.isConnected()) {
					channel.disconnect();
				}
			}
		}
		return true;

	}
}
