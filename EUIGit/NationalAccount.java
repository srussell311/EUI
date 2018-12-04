package com.nsc.eui;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import java.util.TreeMap;


public class NationalAccount extends Object {

	   public String nationalAccountID;
	   public String nationalAccountNbr;
	   public String parts2;
	   public String nationalAccountNbrMin;
	   public String nationalAccountName;
	   public String nationalAccountLocationName;
	   
	   //values in new national account form
	   public String superBuyerF;
	   public String productCatF;
	   public String popUpF;
	   public String poF;
	   public String custMinF;
	   public String companyCode;
	   public String userPrefix;
	   public String pswdPrefix;
	   public String ogPrefix;	  
	   
	   public String addr1;
	   public String addr2;
	   public String addr3;
	   public String addr4;
	   public String city;
	   public String state;
	   public String zip;
	   public String country;
	   
	   public String validF; //for new accounts validF=Y if new account doesn't already exist
	   
	   //////////New Drop Down menus for New Accounts Page SR 4/13/18
	   
	   public String customerNumber = null;
	   public String custName = null;
	   
	   public String acctActive = null;
	   public String productCatFlag = null;
	   public String multipleSoldTo = null;
	   public String custItemNbr = null;
	   public String warning = null;
	   public String poRequired = null;
	   public String orderSource = null;
	   public String ddMT = null;
	   public String imgUsed = null;
	   public String enrichMent = null;
	   public String sDs = null;
	   public String barCodes = null;
	   public String catView = null;
	   public String ediLaunch = null;
	   public String nsddMT = null;
	   public String nsacctActive = null;
	   public String nscustLocNbr = null;
	   public String nscustURL = null;
	   public String nslaunchDate = null;
	   public String nsaddNotes = null;
	   public String addNotes = null;
	   public String soldTo = null;
	   
	   //////////////////For the View PAge 5/22/18 SR
	   public String usaClean = null;
	   public String locCount = null;
	   public String locBudgets = null;
	   public String workflowCount = null;
	   public String locworkCount = null;
	   public String distCount = null;
	   public ArrayList marketSegment = new ArrayList();
	   public String markSegment = null;
	   public String assignedCSR = null;
	   public String zones = null;
	   public String lsog = null;
	   public String percentItemNbr = null;
	   ///////////////////////////////////////////
	   public String nsimgUsed = null;
	   public String nsenrichMent = null;
	   public String nsdualOrdGuide = null;
	   public String nscustItemNbr = null;
	   public String nscatView = null;
	   public String nssDs = null;
	   public String nsbarCodes = null;
	   public String nsauthContact = null;
	   public String nscontactEmail = null;
	   public String nsccLogin = null;
	   public String nscorpApproval = null;
	   public String nsitemApproval = null;
	   public String nsitemApprovalNote = null;
	   public String nsadminPOEmail = null;
	   public String nsadminEmail = null;
	   public String nshidePrice = null;
	   public String nsuserNames = null;
	   public String nsuserPassword = null;
	   public String nsuserNamesText = null;
	   public String nsuserPasswordText = null;
	   public String nsfavList = null;
	   public String nsfavListNote = null;
	   public String nscleanupFlag = null;
	   public String nsssoCustomer = null;
	   
	   public String nsnetworkID = null;
	   public String nscustomerID = null;
	   public String nspunchOut = null;
	   public String nspunchOutType = null;
	   public String nssharedSecret = null;
	   public String nspunchoutProvider = null;
	   public String nsproviderCode = null;
	   public String nscXml = null;
	   public String nsfullPunchOut = null;
	   
	   public String nsaddPunchOut = null;
	   public String nsnetworkID1 = null;
	   public String nscustomerID1 = null;
	   public String nspunchOut1 = null;
	   public String nspunchOutType1 = null;
	   public String nssharedSecret1 = null;
	   public String nspunchoutProvider1 = null;
	   public String nsproviderCode1 = null;
	   public String nscXml1 = null;
	   public String nsfullPunchOut1 = null;
	   ///////////////////////End of new Drop Down variables  SR 4/13/18
	   
	   
//	 groupItems KEY is sequenceID:itemID
	   //public Map groupItems = Collections.synchronizedMap(new HashMap());
	   public Map custList;
	   public Map memList;
	   
	   public NationalAccount () {

	   }
	   
	   public NationalAccount(String nationalAccountID, String nationalAccountNbr, String nationalAccountNbrMin, String nationalAccountName) {
		  this.nationalAccountID = nationalAccountID;
		  this.nationalAccountNbr = nationalAccountNbr;
		  this.nationalAccountNbrMin = nationalAccountNbrMin;
		  this.nationalAccountName = nationalAccountName;
	   }
	   
	   public NationalAccount (String nationalAccountNbr, String nationalAccountName) {
			  this.nationalAccountNbr = nationalAccountNbr;
			  this.nationalAccountName = nationalAccountName;
		   }
	   
	   
	
	}
	


