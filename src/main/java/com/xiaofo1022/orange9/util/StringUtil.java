package com.xiaofo1022.orange9.util;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
  public static String replaceTextParams(String text, Map<String, String> paramMap) {
    String result = text;

    try {
      for (String key : paramMap.keySet()) {
        String regExp = "\\<" + key + "\\>";

        Pattern pattern = Pattern.compile(regExp);
        Matcher matcher = pattern.matcher(text);

        if (matcher.find()) {
          String value = paramMap.get(key) == null ? "" : paramMap.get(key);
          result = result.replaceAll(regExp, value);
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return result;
  }
}
