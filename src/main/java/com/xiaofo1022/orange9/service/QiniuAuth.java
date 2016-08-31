package com.xiaofo1022.orange9.service;

import org.springframework.stereotype.Service;

import com.qiniu.util.Auth;

@Service
public class QiniuAuth {

	public static final String ACCESS_KEY = "XhFGi5pL60nW4KW-E85LBB4G0YRY1dUIiKCSN9_y";
	public static final String SECRET_KEY = "n8Y9x-P6Z8kNWqEghl0_on46p0n4lC-XDp4Yymuk";
	
	public static Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
	
	public String getUpToken(String bucket) {
		return auth.uploadToken(bucket);
	}
}
