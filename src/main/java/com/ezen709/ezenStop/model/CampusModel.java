package com.ezen709.ezenStop.model;

import java.util.Hashtable;
import java.util.Map;

public class CampusModel {
	private String[] locationList = {"노원","종로","신촌","상봉","당산","송파","강남","안양","의정부","구리","일산","안산","성남 분당","성남 모란","김포","전주","이젠IT"};
	private int[] locationCode = {11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27};
	
	private Map<String,Integer> locationInfo = new Hashtable<>();
	
	public CampusModel() {
		for(int i = 0 ; i < this.locationList.length ; i++) {
			this.locationInfo.put(locationList[i], locationCode[i]);
		}
	}
	public String[] getLocationList() {
		return this.locationList;
	}
	public Map<String,Integer> getLocationInfo(){
		return this.locationInfo;
	}
}
