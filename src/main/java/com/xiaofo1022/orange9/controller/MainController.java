package com.xiaofo1022.orange9.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("mainController")
public class MainController {
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index() {
		return "login";
	}
	
	@RequestMapping(value="/system", method=RequestMethod.GET)
	public String system() {
		return "system2";
	}
	
	@RequestMapping(value="/order", method=RequestMethod.GET)
	public String order() {
		return "system2order";
	}
	
	@RequestMapping(value="/post", method=RequestMethod.GET)
	public String post() {
		return "system2post";
	}
	
	@RequestMapping(value="/model", method=RequestMethod.GET)
	public String model() {
		return "system2model";
	}
}
