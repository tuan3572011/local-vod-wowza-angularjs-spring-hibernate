package vn.edu.hcmuaf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/PhimXemNhieu")
public class PhimXemNhieuController {

	@RequestMapping("/layout")
	public String getRailwayStationPartialPage(ModelMap modelMap) {
		return "PhimXemNhieu";
	}
}
