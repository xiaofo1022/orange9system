package com.xiaofo1022.orange9.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class PicDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<String> getSelectedImageNames(int orderId) {
		return jdbcTemplate.query("SELECT FILE_NAME FROM ORDER_TRANSFER_IMAGE_DATA WHERE ORDER_ID = ? AND IS_SELECTED = 1 ORDER BY ID",
			new ParameterizedRowMapper<String>() {
				public String mapRow(ResultSet resultSet, int index) throws SQLException {
					return resultSet.getString("FILE_NAME");
				}
			},
		orderId);
	}
}
