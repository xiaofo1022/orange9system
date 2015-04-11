package com.xiaofo1022.orange9.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.dao.ClientDao;
import com.xiaofo1022.orange9.modal.Client;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;

@Controller
@RequestMapping("/client")
public class ClientController {
	@Autowired
	private ClientDao clientDao;
	
	@RequestMapping(value = "/addClient", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addClient(@ModelAttribute("employee") Client client, BindingResult result) {
		clientDao.insertClient(client);
		return new SuccessResponse("Add Client Success");
	}
	
	@RequestMapping(value = "/getClientList", method = RequestMethod.GET)
	@ResponseBody
	public List<Client> getClientList() {
		return clientDao.getClientList();
	}
}
