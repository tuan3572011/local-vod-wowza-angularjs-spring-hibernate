package vn.edu.hcmuaf.util;

import java.io.File;

public class ResourcesFolderUtility {

	public static String getPathFromResourceFolder(Class baseClass, String fileName) {
		StringBuilder builder = new StringBuilder();
		String pathToFile = baseClass.getClassLoader().getResource(fileName).getPath();
		if (File.separator.equals("\\")) {
			pathToFile = pathToFile.substring(1);
			for (char charact : pathToFile.toCharArray()) {
				if (charact == '/') {
					charact = '\\';
				}
				builder.append(charact);
			}
			pathToFile = builder.toString();
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
