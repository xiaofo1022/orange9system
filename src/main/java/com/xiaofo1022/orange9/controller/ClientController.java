package com.xiaofo1022.orange9.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.orange9.common.Message;
import com.xiaofo1022.orange9.common.RoleConst;
import com.xiaofo1022.orange9.dao.ClientDao;
import com.xiaofo1022.orange9.dao.OrderDao;
import com.xiaofo1022.orange9.dao.OrderPostProductionDao;
import com.xiaofo1022.orange9.dao.OrderTransferDao;
import com.xiaofo1022.orange9.dao.UserDao;
import com.xiaofo1022.orange9.modal.Client;
import com.xiaofo1022.orange9.modal.ClientMessage;
import com.xiaofo1022.orange9.modal.ClientOrder;
import com.xiaofo1022.orange9.modal.Order;
import com.xiaofo1022.orange9.modal.User;
import com.xiaofo1022.orange9.response.CommonResponse;
import com.xiaofo1022.orange9.response.FailureResponse;
import com.xiaofo1022.orange9.response.SuccessResponse;

@Controller
@RequestMapping("/client")
@Transactional
public class ClientController {
	@Autowired
	private ClientDao clientDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private OrderTransferDao orderTransferDao;
	@Autowired
	private OrderPostProductionDao orderPostProductionDao;
	
	@RequestMapping(value = "/main/{clientId}", method = RequestMethod.GET)
	public String main(@PathVariable int clientId, ModelMap modelMap) {
		List<Order> orderList = orderDao.getOrderListByClient(clientId);
		ClientOrder clientOrder = null;
		List<Integer> orderIdList = null;
		if (orderList != null && orderList.size() > 0) {
			orderIdList = new ArrayList<Integer>(orderList.size());
			for (Order order : orderList) {
				orderIdList.add(order.getId());
			}
			Order order = orderList.get(0);
			clientOrder = new ClientOrder();
			clientOrder.setOrderId(order.getId());
			clientOrder.setClientId(clientId);
			if (order.getOrderGoods() != null) {
				clientOrder.setGoodsCount(order.getOrderGoods().getAllCount());
			}
			clientOrder.setShootDateLabel(order.getShootDateLabel());
			clientOrder.setShootHalf(order.getShootHalf());
			clientOrder.setOrderTransferImageDataList(orderTransferDao.getTransferImageDataListByOrder(order.getId()));
			clientOrder.setOrderFixedImageDataList(orderPostProductionDao.getOrderFixedImageDataList(order.getId()));
		}
		modelMap.addAttribute("order", clientOrder);
		modelMap.addAttribute("orderIdList", orderIdList);
		return "system2clientpage";
	}
	
	@RequestMapping(value = "/addClient", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addClient(@ModelAttribute("employee") Client client, BindingResult result, HttpServletRequest request) {
		if (userDao.getUserByPhone(client.getClientPhone()) != null) {
			return new FailureResponse(Message.EXIST_USER_PHONE);
		}
		clientDao.insertClient(client);
		User user = new User();
		user.setName(client.getClientName());
		user.setRoleId(RoleConst.CLIENT_ID);
		user.setPassword(RoleConst.DEFAULT_PASSWORD);
		user.setPhone(client.getClientPhone());
		user.setBossId(client.getId());
		userDao.insertUser(user);
		return new SuccessResponse("Add Client Success");
	}
	
	@RequestMapping(value = "/getClientList", method = RequestMethod.GET)
	@ResponseBody
	public List<Client> getClientList() {
		return clientDao.getClientList();
	}
	
	@RequestMapping(value = "/addClientMessage", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse addClientMessage(@RequestBody ClientMessage clientMessage, BindingResult result) {
		clientDao.insertClientMessage(clientMessage);
		return new SuccessResponse("Add Client Message Success");
	}
	
	@RequestMapping(value = "/getClientMessageList/{clientId}/{orderId}", method = RequestMethod.GET)
	@ResponseBody
	public List<ClientMessage> getClientMessageList(@PathVariable int clientId, @PathVariable int orderId) {
		return clientDao.getClientMessageList(clientId, orderId);
	}
}
