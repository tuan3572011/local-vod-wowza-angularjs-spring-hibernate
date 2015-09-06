package vn.edu.hcmuaf.util;

public class ResourcesFolderUtility {

	public static String getPathFromResourceFolder(Class baseClass,
			String fileName) {
		String pathToFile = baseClass.getClassLoader().getResource(fileName)
				.getPath();

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
