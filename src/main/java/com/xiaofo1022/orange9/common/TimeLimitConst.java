package com.xiaofo1022.orange9.common;

public class TimeLimitConst {
	public static final int TRANSFER_ID = 1;
	public static final int CONVERT_ID = 2;
	public static final int SHOOT_ID = 3;
	
	public static int getIdByTable(String tableName) {
		if (tableName.equals(OrderConst.TABLE_ORDER_FIX_SKIN)) {
			return 4;
		} else if (tableName.equals(OrderConst.TABLE_ORDER_FIX_BACKGROUND)) {
			return 5;
		} else {
			return 6;
		}
	}
}
