package com.xiaofo1022.orange9.modal;

import com.xiaofo1022.orange9.dao.common.Column;

public class OrderStatusCount {
	@Column("STATUS_COUNT")
	private int statusCount;

	public int getStatusCount() {
		return statusCount;
	}

	public void setStatusCount(int statusCount) {
		this.statusCount = statusCount;
	}
}
