package com.nsc.eui;

import java.util.Collections;
import java.util.Map;
import java.util.TreeMap;


public class Member {

	   public String memberID;
	   public String memberName;
	   public String memberNbr;
	   public String memberLoc;
	   public String memberMinNbr;

	   
	
//groupItems KEY is sequenceID:itemID
//public Map groupItems = Collections.synchronizedMap(new HashMap());
public Map custList;
public Map memList;

public Member () {

}

public Member(String memberID, String memberNbr, String memberMinNbr, String memberName, String memberLoc) {
	  this.memberID = memberID;
	  this.memberNbr = memberNbr;
	  this.memberMinNbr = memberMinNbr;
	  this.memberName = memberName;
	  this.memberLoc = memberLoc;
}

}