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
import com.xiaofo1022.orange9.modal.OrderNo;
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
		this.createClientMainModelMap(clientId, 0, modelMap);
		return "lufter/clientpage";
	}
	
	private void createClientMainModelMap(int clientId, int orderId, ModelMap modelMap) {
		List<Order> orderList = orderDao.getOrderListByClient(clientId);
		ClientOrder clientOrder = null;
		List<OrderNo> orderNoList = null;
		if (orderList != null && orderList.size() > 0) {
			orderNoList = new ArrayList<OrderNo>(orderList.size());
			for (Order order : orderList) {
				OrderNo orderNo = new OrderNo(order.getId(), order.getOrderNo());
				orderNoList.add(orderNo);
			}
			Order order = null;
			if (orderId == 0) {
				order = orderList.get(0);
			} else {
				order = orderDao.getOrderDetail(orderId);
			}
			clientOrder = new ClientOrder();
			clientOrder.setOrderId(order.getId());
			clientOrder.setOrderNo(order.getOrderNo());
			clientOrder.setStatus(order.getOrderStatus().getName());
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
		modelMap.addAttribute("orderNoList", orderNoList);
	}
	
	@RequestMapping(value = "/main/{clientId}/{orderId}", method = RequestMethod.GET)
	public String main(@PathVariable int clientId, @PathVariable int orderId, ModelMap modelMap) {
		this.createClientMainModelMap(clientId, orderId, modelMap);
		return "lufter/clientpage";
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
	
	@RequestMapping(value = "/updateClient", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse updateClient(@ModelAttribute("employee") Client client, BindingResult result, HttpServletRequest request) {
		Client existClient = clientDao.getClient(client.getId());
		if (existClient != null) {
			if (!existClient.getClientPhone().equals(client.getClientPhone())) {
				if (userDao.getUserByPhone(client.getClientPhone()) != null) {
					return new FailureResponse(Message.EXIST_USER_PHONE);
				}
				User clientUser = userDao.getUserByPhone(existClient.getClientPhone());
				if (clientUser != null) {
					userDao.updateUserPhone(clientUser.getId(), client.getClientPhone());
				}
			}
			clientDao.updateClient(client);
		}
		return new SuccessResponse("Update Client Success");
	}
	
	@RequestMapping(value = "/deleteClient/{clientId}", method = RequestMethod.POST)
	@ResponseBody
	public CommonResponse deleteClient(@PathVariable int clientId, HttpServletRequest request) {
		Client existClient = clientDao.getClient(clientId);
		if (existClient != null) {
			User clientUser = userDao.getUserByPhone(existClient.getClientPhone());
			if (clientUser != null) {
				userDao.deleteUser(clientUser.getId());
			}
			clientDao.deleteClient(clientId);
		}
		return new SuccessResponse("Delete Client Success");
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
