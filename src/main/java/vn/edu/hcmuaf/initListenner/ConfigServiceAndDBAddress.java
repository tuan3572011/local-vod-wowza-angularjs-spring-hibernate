package vn.edu.hcmuaf.initListenner;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;

import vn.edu.hcmuaf.controller.PhimLeController;

/**
 * Application Lifecycle Listener implementation class ConfigServiceAndDBAddress
 *
 */
public class ConfigServiceAndDBAddress implements ServletContextListener {
	public static String streamingServerAddress = "";
	public static String resfulServerAddress = "";
	public static String imageServerAddress = "";

	private Logger logger = LoggerFactory.getLogger(ConfigServiceAndDBAddress.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletContextListener#contextDestroyed(javax.servlet.
	 * ServletContextEvent)
	 */
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.ServletContextListener#contextInitialized(javax.servlet
	 * .ServletContextEvent)
	 */
	@Override
	public void contextInitialized(ServletContextEvent arg0) {

		Properties properties = new Properties();
		try {
			properties.load(PhimLeController.class.getResourceAsStream("/serverAddressConfig.properties"));
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		streamingServerAddress = properties.getProperty("StreamingServerAddress").trim();
		resfulServerAddress = properties.getProperty("ResfulServerAddress").trim();
		imageServerAddress = properties.getProperty("ImageServerAddress").trim();

		System.out.println("IP ADDRESS OF ALL SERVER" + streamingServerAddress + resfulServerAddress
				+ imageServerAddress);
		logger.info("IP ADDRESS OF ALL SERVER" + streamingServerAddress + resfulServerAddress + imageServerAddress);

	}

}