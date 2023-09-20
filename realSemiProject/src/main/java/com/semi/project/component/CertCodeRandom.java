package com.semi.project.component;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Component;

@Component
public class CertCodeRandom {
	   
	private List<String> data = new ArrayList<>();
	   private List<String> data1 = new ArrayList<>();
	   private List<String> data2 = new ArrayList<>();
	   private List<String> data3 = new ArrayList<>();
	   private List<String> data4 = new ArrayList<>();
	   private Random r = new Random();
		   
		@PostConstruct
		public void init() {
			for(char i='A'; i <='Z'; i++) data.add(String.valueOf(i));
			for(char i='A'; i <='Z'; i++) data1.add(String.valueOf(i));
			for(char i='a'; i <='z'; i++) data.add(String.valueOf(i));
			for(char i='a'; i <='z'; i++) data2.add(String.valueOf(i));
			for(char i='0'; i <='9'; i++) data.add(String.valueOf(i));
			for(char i='0'; i <='9'; i++) data3.add(String.valueOf(i));
			
			data.add("!");
			data4.add("!");
			data.add("@");
			data4.add("@");
			data.add("#");
			data4.add("#");
			data.add("$");	
			data4.add("$");
			}
		   
		public String generatePassword() {
			StringBuilder password = new StringBuilder();
		        
	        password.append(data1.get(r.nextInt(data1.size())));
	        password.append(data2.get(r.nextInt(data2.size())));
	        password.append(data3.get(r.nextInt(data3.size())));
	        password.append(data4.get(r.nextInt(data4.size())));
		        
	        for (int i = 4; i < 10; i++) {
	            List<String> currentData = i % 2 == 0 ? data : data4;
	            password.append(currentData.get(r.nextInt(currentData.size())));
		    }
		        
	        return password.toString();
	   }
}
