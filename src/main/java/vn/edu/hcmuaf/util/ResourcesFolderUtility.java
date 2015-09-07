package vn.edu.hcmuaf.util;

import java.io.File;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ResourcesFolderUtility {
	private static final Logger logger = LoggerFactory
			.getLogger(ResourcesFolderUtility.class);

	public static String getPathFromResourceFolder(Class baseClass,
			String fileName) {
		StringBuilder builder = new StringBuilder();
		String pathToFile = baseClass.getClassLoader().getResource(fileName)
				.getPath();
		logger.info(File.separator);
		if (File.separator.equals("\\")) {
			logger.info("Windows system");
			pathToFile = pathToFile.substring(1);
			for (char charact : pathToFile.toCharArray()) {
				if (charact == '/') {
					charact = '\\';
				}
				builder.append(charact);
			}
			pathToFile = builder.toString();
			logger.info(pathToFile);
		}
		// remove %20 if have any
		String[] pathToFileArr = pathToFile.split("%20");
		if (pathToFileArr.length != 1) {
			pathToFile = "";
			for (String partPathToFile : pathToFileArr) {
				pathToFile += partPathToFile + " ";
			}
		}
		return pathToFile.trim();

	}
}
