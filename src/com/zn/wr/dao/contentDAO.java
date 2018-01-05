package com.zn.wr.dao;


import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import org.springframework.stereotype.Repository;

@Repository
public class contentDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public boolean insert(String content){
		try{
			String sql = " INSERT INTO w_content(content, createtime, updatetime)VALUES (?,now(), now())";
			Object[] params = new Object[]{content};
			
			jdbcTemplate.update(sql, params);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	public String search(){
		String content = null;
		try{
			String sql = "SELECT content from w_content ORDER BY updatetime DESC LIMIT 1";
			content = (String) jdbcTemplate.queryForObject(sql, java.lang.String.class);
		}catch(Exception e){
			e.printStackTrace();
		}
		return content;
	}
}
