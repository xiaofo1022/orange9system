package com.xiaofo1022.orange9.dao.common;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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
import com.xiaofo1022.orange9.util.Base64Util;

@Repository
public class CommonDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public static SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat datetimeFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
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
	
	public <T> T getFirst(final Class<T> cls, String sql, Object... args) {
		List<T> resultList = query(cls, sql, args);
		if (resultList != null && resultList.size() > 0) {
			return resultList.get(0);
		} else {
			return null;
		}
	}
	
	public <T> List<T> query(final Class<T> cls, String sql, Object... args) {
		return jdbcTemplate.query(sql, new ParameterizedRowMapper<T>() {
			public T mapRow(ResultSet resultSet, int arg1) throws SQLException {
				T entity = null;
				try {
					entity = cls.newInstance();
					Field[] fields = cls.getDeclaredFields();
					for (Field field : fields) {
						field.setAccessible(true);
						Column column = field.getAnnotation(Column.class);
						if (column != null) {
							String columnName = column.value();
							boolean isImage = column.isImage();
							boolean isFormatDate = column.isFormatDate();
							boolean isFormatDatetime = column.isFormatDatetime();
							
							try {
								resultSet.findColumn(columnName);
							} catch (Exception e) {
								continue;
							}
							
							Class<?> type = field.getType();
							
							if (type == int.class) {
								field.set(entity, resultSet.getInt(columnName));
							} else if (type == double.class) {
								field.set(entity, resultSet.getDouble(columnName));
							} else if (type == String.class) {
								if (isFormatDate) {
									field.set(entity, dateFormatter.format(resultSet.getDate(columnName)));
								} else if (isFormatDatetime) {
									field.set(entity, datetimeFormatter.format(new Date(resultSet.getTimestamp(columnName).getTime())));
								} else if (isImage) {
									String imageSource = resultSet.getString(columnName);
									if (imageSource == null || imageSource.equals("")) {
										field.set(entity, "/orange9/images/header/gray_blank.jpg");
									} else {
										field.set(entity, Base64Util.getJpgHeader() + resultSet.getString(columnName));
									}
								} else {
									field.set(entity, resultSet.getString(columnName));
								}
							} else if (type == Date.class) {
								Timestamp timestamp = resultSet.getTimestamp(columnName);
								if (timestamp != null) {
									field.set(entity, new Date(timestamp.getTime()));
								}
							}
						}
						JoinTable joinTable = field.getAnnotation(JoinTable.class);
						if (joinTable != null) {
							String tableName = joinTable.tableName();
							String joinField = joinTable.joinField();
							Field jf = cls.getDeclaredField(joinField);
							jf.setAccessible(true);
							Class<?> fieldType = field.getType();
							Object fieldValue = jf.get(entity);
							if (fieldValue != null) {
								String joinSql = "SELECT * FROM " + tableName + " WHERE ID = ?";
								field.set(entity, getFirst(fieldType, joinSql, fieldValue));
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
