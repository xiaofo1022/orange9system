package com.xiaofo1022.orange9.modal;

import com.xiaofo1022.orange9.dao.common.Column;

public class Count {
	@Column("CNT")
	private int cnt;

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
}
