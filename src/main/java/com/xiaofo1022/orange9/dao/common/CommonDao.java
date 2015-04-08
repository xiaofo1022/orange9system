package com.xiaofo1022.orange9.dao.common;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.mysql.jdbc.Statement;

@Repository
public class CommonDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int insert(final String sql, final Object... args) {
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				for (int i = 0; i < args.length; i++) {
					ps.setObject(i + 1, args[i]);
				}
				return ps;
			}
		}, keyHolder);
		return keyHolder.getKey().intValue();
	}
	
	public int update(String sql, Object... args) {
		return jdbcTemplate.update(sql, args);
	}
	
	public <T> List<T> query(final Class<T> cls, String sql, Object... args) {
		return jdbcTemplate.query(sql, new ParameterizedRowMapper<T>() {
			public T mapRow(ResultSet resultSet, int arg1) throws SQLException {
				T entity = null;
				try {
					entity = cls.newInstance();
					Field[] fields = cls.getDeclaredFields();
					for (Field field : fields) {
						Column column = field.getAnnotation(Column.class);
						if (column != null) {
							field.setAccessible(true);
							String columnName = column.value();
							
							try {
								resultSet.findColumn(columnName);
							} catch (Exception e) {
								continue;
							}
							
							Class<?> type = field.getType();
							
							if (type == int.class) {
								field.set(entity, resultSet.getInt(columnName));
							} else if (type == String.class) {
								field.set(entity, resultSet.getString(columnName));
							} else if (type == Date.class) {
								field.set(entity, new Date(resultSet.getDate(columnName).getTime()));
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return entity;
			}
		}, 
		args);
	}
}