package com.nsc.eui.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Properties;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.jsp.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nsc.dataaccess.ConnectionFactory;
import com.nsc.eui.*;
import com.nsc.utils.Constants;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.*;

import org.apache.log4j.Logger;

import java.io.InputStream;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFRow;

//Feb 2018
 
public class EUIWebMain extends javax.servlet.http.HttpServlet {	
	private EUIUtils utils = null;
	private String lastVisitedPage = "";
	private static final long serialVersionUID = 1L;
	//private static final HSSFRow HSSFRow = null;
	private Properties properties = new Properties();
	public String statusMsg;
	private HSSFRow HSSFRow;
	
	   private Logger LOGGER = Logger.getLogger(com.nsc.eui.controller.EUIWebMain.class);
	   
	public void init() throws ServletException {
		  utils = new EUIUtils();
		  getServletContext().setAttribute("EUIUtils", utils);
	      LOGGER.info("IN init()");
	      String msg = "";
	
	}
	
	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	//////////////////////////////////////////START OF EMAIL IMPORT CODE BLOCK/////////////////////////////////////////////////
	
	/*public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		EUIUser dbUser = (EUIUser)request.getSession().getAttribute("EUIUser");
	   
	 }*/         ////////////////////////////////END OF IMPORT EMAIL CODE BLOCK/////////////////////////////////////////////////

	//private void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
	String actionType = request.getParameter("actionType");	
	//System.out.println(actionType);    
	EUIUser dbUser = (EUIUser)request.getSession().getAttribute("EUIUser");
	request.getSession().setMaxInactiveInterval(3600);
		
	  String reqUserName = (String)request.getParameter("userName");
  	  String reqUserPswd = (String)request.getParameter("passWord");
  	  
  	String action = request.getParameter("actionType");
  	request.setAttribute("actionType", action);
    String pageName = request.getParameter("page");
    pageName = pageName == null ? "login.jsp" : pageName;
    //System.out.println(pageName);
    String loginURL = "/web/jsp/" + pageName;
    //String loginURL = "/" + pageName;
    System.out.println("URL ="+loginURL);
    //System.out.println("Action "+action);////////////////////////////
    
		if(dbUser == null) {
	          dbUser = new EUIUser();
	          request.getSession().setAttribute("EUIUser", dbUser);
	          request.getSession().setMaxInactiveInterval(3600);
		} 
		
		//System.out.println("SEan's Alert");
		if (dbUser.getUserLogin() == null) {
				if (reqUserName == null && pageName!="login.jsp") { //not logging in
					request.getSession().invalidate();
					 String msg = "sessionExp";
			 	     request.getSession().setAttribute("msg", msg);
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/web/jsp/login.jsp");
			        try {
			        	utils = new EUIUtils();
		 	        	 getServletContext().setAttribute("EUIUtils", utils);
		 	        	 LOGGER.info("IN init()");
			        	rd.forward(request, response);
						return;
					} catch (ServletException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
			        
				} else {
					//logging in, do nothing
					//response.sendRedirect("web/jsp/dashboard.jsp");///SR
					//return;
				}
		} else {
			//System.out.println("dbUser.getUserLogin is "+dbUser.getUserLogin());
		}
	      
		//comment out due to database upgrade or database being down - initial query at login
		     

      // If we are viewing a popup page, we'll be going back to the caller page, and we
      // don't want to blow away the caller page's selection info.
		//System.out.println("National Account Call1");
      if(!lastVisitedPage.equals(pageName)){
         lastVisitedPage = pageName;      
      }
	
	  if (action =="" || action==null) {
		  
	  }
	  
	  else if (action.equals("Login")) {
    	      	  
    	  utils.getUserLogin(dbUser, reqUserName, reqUserPswd);
    	 
    	  	    	  
    	 if (reqUserName==null || !dbUser.isActive()){  // Only allow access if user account is activated) 
    		 dbUser = null;
 	         request.getSession().setAttribute("EUIUser", dbUser);
 	         
 	         request.getSession().invalidate();
 	        RequestDispatcher rd = getServletContext().getRequestDispatcher("/web/jsp/login.jsp");
 	        //response.sendRedirect("web/jsp/login1.jsp?msg=noLogin");
 	        String msg = "noLogin";
 	        request.getSession().setAttribute("msg", msg);
 	        try {
 	        	 utils = new EUIUtils();
 	        	 getServletContext().setAttribute("EUIUtils", utils);
 	        	 LOGGER.info("IN init()"); 
				 //getServletContext().getRequestDispatcher(loginURL).forward(request, response);
				 rd.forward(request, response);
				 return;
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
 	         
 	        
    	  } else {
    		  request.getSession().setAttribute("EUIUser", dbUser);
    		  request.getSession().setAttribute("userLogin", reqUserName);
    		  request.getSession().setMaxInactiveInterval(3600);
    		 // utils.getDashboard(dbUser);  ////Gets vectors to populate the dashboard page
    	  }
		  		  
    	      	    	  
	    	  
	    	  //Add a New National Account
	  } else if (action.equals("NewNA")) {
	        	//System.out.println("National Account Call");
		  	 dbUser.action = action;
	         utils.getNationalAccountList(dbUser);
	          
	         utils.getPlatformList(dbUser); 
	  
	         
	   } else if (action.equals("NewNA_1")) {
       	//System.out.println("National Account Call");
	  	 dbUser.action = action;
	  	 dbUser.orderSource = (String)request.getParameter("orderSource"); 
	  	 dbUser.customerName = (String)request.getParameter("natAcct");
	  	 dbUser.customerName = dbUser.customerName.substring(11);
	  	 String[] custParts = dbUser.customerName.split("[(]");
	  	dbUser.customerName = custParts[0];
	  	 System.out.println(dbUser.customerName);
	  	 dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		 System.out.println(dbUser.nationalAccountNbr);
		 String[] parts = dbUser.nationalAccountNbr.split(" - ");
		 dbUser.customerNumber = parts[0];
		 dbUser.customerNumber = dbUser.customerNumber.substring(0, 3);
		 System.out.println("3 digit CustomerNumber +"+dbUser.customerNumber);
	  	 
        utils.getNationalAccountList(dbUser);
         
        utils.getPlatformList(dbUser); 
        
	   } else if (action.equals("NewNANetSupply")){ 
		         //dbUser.eplatform = (String)request.getParameter("eplatform");
		   		 String natAcct = request.getParameter("natAcct");
		   		// System.out.println(natAcct);
		   		 request.getSession().setAttribute("natAcct", natAcct);
		   		 String test = (String) request.getSession().getAttribute("natAcct");
		   		 //System.out.println(test);
		         dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		         String catalogView = (String) request.getParameter("catalogView");
		         request.getSession().setAttribute("catalogView", catalogView);
		        // System.out.println(catalogView);
		         
		         dbUser.nscatView = catalogView;
		         //System.out.println(dbUser.nscatView);
		        // utils.getNationalAccountList(dbUser);
		        /* String catalogbtnYes = request.getParameter("catalogbtnYes");
		         System.out.println(catalogbtnYes);
		         if(catalogbtnYes == "Yes"){
		        	 request.getSession().setAttribute("catalogbtnYes", catalogbtnYes);
		         System.out.println(catalogbtnYes);
		         }
		         String catalogbtnNo = request.getParameter("catalogbtnNo");
		         if(catalogbtnNo == "No"){
		        	 request.getSession().setAttribute("catalogbtnNo", catalogbtnNo);
		        	 
		         }
		         System.out.println(catalogbtnNo);*/
		         
		         String orderSource = (String)request.getParameter("orderSource");
		         request.getSession().setAttribute("orderSource", orderSource);
		         dbUser.orderSource = orderSource;
		        // dbUser.soldTo = natAcct;
		         //String customerName = request.getParameter("customerName");
		         //dbUser.customerName = customerName;
		         
		         /*if(!catalogbtnYes.equals("")){
		        	 dbUser.nscatView = catalogbtnYes;
		         }
		         if(!catalogbtnNo.equals("")){
		        	 dbUser.nscatView = catalogbtnNo;
		         }*/
		         utils.getNationalAccountList(dbUser); 
		         
		        // System.out.println(dbUser.nscatView);
		        
		         utils.getNationalAccountListEC(dbUser);
		        
		         		         
		         //get national account name based on CustMaj,CustMin # selected to display in dropdown
		         //utils.getNationalAccountName(dbUser, response);
		         	//get member list based on national account selected
		         	//DON'T DO - GET MEMBER LIST FROM DW ALREADY ASSOCIATED BY I5
		         
		         //utils.getMemberList(dbUser);
		         //utils.getMemberListNewAcct(dbUser);
		        // utils.getCompanyCode(dbUser, response);
		         
		         //re-populate dropdowns
		         //utils.getEcommercePlatform(dbUser);
		         //utils.getNationalAccountList(dbUser); 
		         
	   } else if (action.equals("NewNAEDI")){ 
	         //dbUser.eplatform = (String)request.getParameter("eplatform");
		     String natAcct = request.getParameter("natAcct");
		     request.getSession().setAttribute("natAcct", natAcct);
	         dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
	         
	         utils.getNationalAccountList(dbUser);
	         
	         String orderSource = (String)request.getParameter("orderSource");
	         request.getSession().setAttribute("orderSource", orderSource);
	         dbUser.orderSource = orderSource;
	         
	         String catalogView = (String) request.getParameter("catalogView");
	         request.getSession().setAttribute("catalogView", catalogView);
	        // System.out.println(catalogView);
	         
	         dbUser.catView = catalogView;
	        // System.out.println(dbUser.catView);

	         //get national account name based on CustMaj,CustMin # selected to display in dropdown
	         //utils.getNationalAccountName(dbUser, response);
	         	//get member list based on national account selected
	         	//DON'T DO - GET MEMBER LIST FROM DW ALREADY ASSOCIATED BY I5
	         
	         //utils.getMemberList(dbUser);
	         //utils.getMemberListNewAcct(dbUser);
	        // utils.getCompanyCode(dbUser, response);
	         
	         //re-populate dropdowns
	         //utils.getEcommercePlatform(dbUser);
	         //utils.getNationalAccountList(dbUser); 
	         
	   } else if (action.equals("SaveNewNA")) {
		  
		   
		   loginURL = "/web/jsp/viewNA.jsp";
		   
		   dbUser.routeToViewDtl = (String)request.getParameter("routeToViewDtl");
		   System.out.println(dbUser.routeToViewDtl);
		   //dbUser.custMaj = (String)request.getParameter("natAcct");
		   dbUser.custMaj = (String) request.getSession().getAttribute("natAcct");
		    System.out.println(dbUser.custMaj);
		   //dbUser.custMajor = String.format("%010d", Integer.parseInt(dbUser.custMaj));
		   dbUser.custMajor = dbUser.custMaj.substring(0, 9);
		   System.out.println(dbUser.custMajor);
		   dbUser.custMajor = String.format("%010d", Integer.parseInt(dbUser.custMajor));
		 //  System.out.println(dbUser.custMajor);
           //dbUser.natAcct = (String)request.getParameter("natAcct");
		   dbUser.natAcct = (String) request.getSession().getAttribute("natAcct");
          // System.out.println(dbUser.natAcct);
		   dbUser.soldTo = dbUser.natAcct.substring(0, 3);
		   //System.out.println(dbUser.soldTo);
           dbUser.action = (String)request.getParameter("actionType");
           request.getSession().setAttribute("actionType", actionType);
           
           dbUser.acctActive = (String)request.getParameter("acctActive");
           if(dbUser.acctActive == null){
        	  dbUser.acctActive = "";
           }
           
           dbUser.nsacctActive = (String)request.getParameter("acctActiveNS");
           if(dbUser.nsacctActive == null){
        	   dbUser.nsacctActive = "";
           }
           
           dbUser.activeCheck = (String)request.getParameter("activeCheck");
           System.out.println(dbUser.activeCheck);
           dbUser.activeCheckNS = (String)request.getParameter("activeCheckNS");
           System.out.println(dbUser.activeCheckNS);
           
           //System.out.println(dbUser.action);
           		//stored proc already set IsActive =1 => this value isn't passed into stored proc
           		//during new account
           /*dbUser.acctActive = (String)request.getParameter("acctActive");
           dbUser.productCatFlag = (String)request.getParameter("productCatFlag");
           dbUser.multipleSoldTo = (String)request.getParameter("multipleSoldTo");
           dbUser.custItemNbr = (String)request.getParameter("custItemNbr");
           dbUser.warning = (String)request.getParameter("warning");
           dbUser.poRequired = (String)request.getParameter("poRequired");*/
           //dbUser.orderSource = (String)request.getParameter("orderSource");
           dbUser.orderSource = (String) request.getSession().getAttribute("orderSource");
          // System.out.println(dbUser.orderSource);
           dbUser.nsddMT = (String)request.getParameter("nsddMT");
           if(dbUser.nsddMT == null){
        	   dbUser.nsddMT = "";
           }
          // System.out.println(dbUser.nsddMT);
           dbUser.nscustLocNbr = (String)request.getParameter("nscustLocNbr");
           if(dbUser.nscustLocNbr == null){
        	   dbUser.nscustLocNbr = "";
           }
           //System.out.println(dbUser.nscustLocNbr);
           dbUser.nscustURL = (String)request.getParameter("nscustURL");
           if(dbUser.nscustURL == null){
        	   dbUser.nscustURL = "";
           }
           //System.out.println(dbUser.nscustURL);
           dbUser.nslaunchDate = (String)request.getParameter("nslaunchDate");
           if(dbUser.nslaunchDate == null){
        	   dbUser.nslaunchDate = "";
           }
           if(!dbUser.nslaunchDate.equals("")){
           String year = dbUser.nslaunchDate.substring(6, 10);
           System.out.println(year);
           String month = dbUser.nslaunchDate.substring(0, 2);
           System.out.println(month);
           String day = dbUser.nslaunchDate.substring(3, 5);
           System.out.println(day);
           dbUser.nslaunchDate = year +"-"+ month+"-"+day ;
           System.out.println(dbUser.nslaunchDate);
           }
          // System.out.println(dbUser.nslaunchDate);
           dbUser.nsaddNotes = (String)request.getParameter("nsaddNotes");
           dbUser.nsaddNotes = dbUser.nsaddNotes.replace("'\",", "");
           if(dbUser.nsaddNotes == null){
        	   dbUser.nsaddNotes = "";
           }
          // System.out.println(dbUser.nsaddNotes);
           dbUser.nsimgUsed = (String)request.getParameter("nsimgUsed");
           if(dbUser.nsimgUsed == null){
        	   dbUser.nsimgUsed = "";
           }
          // System.out.println(dbUser.nsimgUsed);
           dbUser.nsenrichMent = (String)request.getParameter("nsenrichMent");
           if(dbUser.nsenrichMent == null){
        	   dbUser.nsenrichMent = "";
           }
          // System.out.println(dbUser.nsenrichMent);
           dbUser.nsdualOrdGuide = (String)request.getParameter("nsdualOrdGuide");
           if(dbUser.nsdualOrdGuide == null){
        	   dbUser.nsdualOrdGuide = "";
           }
          // System.out.println(dbUser.nsdualOrdGuide);
           dbUser.nscatView = (String) request.getSession().getAttribute("catalogView");
           if( dbUser.nscatView == null){
        	   dbUser.nscatView = "";
           }
           //request.getSession().setAttribute("catalogView", catalogView);
          // System.out.println(dbUser.nscatView);

           dbUser.nssDs = (String)request.getParameter("nssDs");
           if(dbUser.nssDs == null){
        	   dbUser.nssDs = "";
           }
           //System.out.println(dbUser.nssDs);
           dbUser.nsbarCodes = (String)request.getParameter("nsbarCodes");
           if(dbUser.nsbarCodes == null){
        	   dbUser.nsbarCodes = "";
           }
           //System.out.println(dbUser.nsbarCodes);
           dbUser.nsauthContact = (String)request.getParameter("nsauthContact");
           if(dbUser.nsauthContact == null){
        	   dbUser.nsauthContact = "";
           }
           //System.out.println(dbUser.nsauthContact);
           dbUser.nscontactEmail = (String)request.getParameter("nscontactEmail"); 
           if(dbUser.nscontactEmail == null){
        	   dbUser.nscontactEmail = "";
           }
           //System.out.println(dbUser.nscontactEmail);
           dbUser.nsccLogin = (String)request.getParameter("nsccLogin");
           if(dbUser.nsccLogin == null){
        	   dbUser.nsccLogin = "";
           }
          // System.out.println(dbUser.nsccLogin);
           dbUser.nscorpApproval = (String)request.getParameter("nscorpApproval");
           if(dbUser.nscorpApproval == null){
        	   dbUser.nscorpApproval = "";
           }
           //System.out.println(dbUser.nscorpApproval);
           dbUser.nsitemApproval = (String)request.getParameter("nsitemApproval");
           if(dbUser.nsitemApproval == null){
        	   dbUser.nsitemApproval = "";
           }
          // System.out.println(dbUser.nsitemApproval);
           dbUser.nsitemApprovalNote = (String)request.getParameter("nsitemApprovalNote");
           if(dbUser.nsitemApprovalNote == null){
        	   dbUser.nsitemApprovalNote = "";
           }
          // System.out.println(dbUser.nsitemApprovalNote);
           dbUser.nsadminPOEmail = (String)request.getParameter("nsadminPOEmail");
           if(dbUser.nsadminPOEmail == null){
        	   dbUser.nsadminPOEmail = "";
           }
           //System.out.println(dbUser.nsadminPOEmail);
           dbUser.nsadminEmail = (String)request.getParameter("nsadminEmail");
           if(dbUser.nsadminEmail == null){
        	   dbUser.nsadminEmail = "";
           }
           //System.out.println(dbUser.nsadminEmail);
           /*dbUser.nshidePrice = (String)request.getParameter("nshidePrice");
           if(dbUser.nshidePrice == null){
        	   dbUser.nshidePrice = "";
           }*/
           //System.out.println(dbUser.nshidePrice);
           dbUser.nsuserNamesText = (String)request.getParameter("nsuserNamesText");
           if(dbUser.nsuserNamesText == null){
        	   dbUser.nsuserNamesText = "";
           }
           //System.out.println(dbUser.nsuserNamesText);
           dbUser.nsuserPasswordText = (String)request.getParameter("nsuserPasswordText");
           if(dbUser.nsuserPasswordText == null){
        	   dbUser.nsuserPasswordText = "";
           }
           //System.out.println(dbUser.nsuserPasswordText);
           dbUser.nsfavList = (String)request.getParameter("nsfavList");
           if(dbUser.nsfavList == null){
        	   dbUser.nsfavList = "";
           }
           //System.out.println(dbUser.nsfavList);
           dbUser.nsfavListNote = (String)request.getParameter("nsfavListNote");
           if(dbUser.nsfavListNote == null){
        	   dbUser.nsfavListNote = "";
           }
           dbUser.nsfavListNote = dbUser.nsfavListNote.replace("'\",", "");
           if(dbUser.nsfavListNote == null){
        	   dbUser.nsfavListNote = "";
           }
           //System.out.println(dbUser.nsfavListNote);
           dbUser.nscleanupFlag = (String)request.getParameter("nscleanupFlag");
           if(dbUser.nscleanupFlag == null){
        	   dbUser.nscleanupFlag = "";
           }
          // System.out.println(dbUser.nscleanupFlag);
           dbUser.nsssoCustomer = (String)request.getParameter("nsssoCustomer");
           if(dbUser.nsssoCustomer == null){
        	   dbUser.nsssoCustomer = "";
           }
           dbUser.nsssoNotes = (String)request.getParameter("nsssoNotes");
           if(dbUser.nsssoNotes == null){
        	   dbUser.nsssoNotes = "";
           }
          // System.out.println(dbUser.nsssoCustomer);
           dbUser.nspunchOut = (String)request.getParameter("nspunchOut");
           if(dbUser.nspunchOut == null){
        	   dbUser.nspunchOut = "";
           }
           //System.out.println(dbUser.nspunchOut);
           dbUser.nspunchOutType = (String)request.getParameter("nspunchOutType");
           if(dbUser.nspunchOutType == null){
        	   dbUser.nspunchOutType = "";
           }
           //System.out.println(dbUser.nspunchOutType);
           dbUser.nsnetworkID = (String)request.getParameter("nsnetworkID");
           if(dbUser.nsnetworkID == null){
        	   dbUser.nsnetworkID = "";
           }
           dbUser.nscustomerID = (String)request.getParameter("nscustomerID");
           if(dbUser.nscustomerID == null){
        	   dbUser.nscustomerID = "";
           }
           dbUser.nssharedSecret = (String)request.getParameter("nssharedSecret");
           if( dbUser.nssharedSecret == null){
        	   dbUser.nssharedSecret = "";
           }
           //System.out.println(dbUser.nssharedSecret);
           dbUser.nspunchoutProvider = (String)request.getParameter("nspunchoutProvider");
           if(dbUser.nspunchoutProvider == null){
        	   dbUser.nspunchoutProvider = "";
           }
           //System.out.println(dbUser.nspunchoutProvider);
           dbUser.nsproviderCode = (String)request.getParameter("nsproviderCode");
           if(dbUser.nsproviderCode == null){
        	   dbUser.nsproviderCode = "";
           }
           //System.out.println(dbUser.nsproviderCode);
           dbUser.nscXml = (String)request.getParameter("nscXml");
           if(dbUser.nscXml == null){
        	   dbUser.nscXml = "";
           }
           //System.out.println(dbUser.nscXml);
           dbUser.nsfullPunchOut = (String)request.getParameter("nsfullPunchOut");
           if(dbUser.nsfullPunchOut == null){
        	   dbUser.nsfullPunchOut = "";
           }
           dbUser.nsfullPunchOut = dbUser.nsfullPunchOut.replace("'\",", "");
           if(dbUser.nsfullPunchOut == null){
        	   dbUser.nsfullPunchOut = "";
           }
           //System.out.println(dbUser.nsfullPunchOut);
           
           dbUser.ddMT = (String)request.getParameter("ddMT");
           if(dbUser.ddMT == null){
        	   dbUser.ddMT = "";
           }
          // System.out.println(dbUser.ddMT);
           dbUser.imgUsed = (String)request.getParameter("imgUsed");
           if(dbUser.imgUsed == null){
        	   dbUser.imgUsed = "";
           }
          // System.out.println(dbUser.imgUsed);
           dbUser.enrichMent = (String)request.getParameter("enrichMent");
           if(dbUser.enrichMent == null){
        	   dbUser.enrichMent = "";
           }
          // System.out.println(dbUser.enrichMent);
           dbUser.sDs = (String)request.getParameter("sDs");
           if(dbUser.sDs == null){
        	   dbUser.sDs = "";
           }
          // System.out.println(dbUser.sDs);
           dbUser.barCodes = (String)request.getParameter("barCodes");
           if(dbUser.barCodes == null){
        	   dbUser.barCodes = "";
           }
          // System.out.println(dbUser.barCodes);
           dbUser.catView =  (String)request.getSession().getAttribute("catalogView");
           if(dbUser.catView == null){
        	   dbUser.catView = "";
           }
           dbUser.addNotes = (String)request.getParameter("addNotes");
           if(dbUser.addNotes == null){
        	   dbUser.addNotes = "";
           }
           System.out.println("addnotes = "+dbUser.addNotes);
          //System.out.println(dbUser.catView);
           dbUser.ediLaunch = (String)request.getParameter("ediLaunch");
           if(dbUser.ediLaunch != null){
               String year = dbUser.ediLaunch.substring(6, 10);
               System.out.println(year);
               String month = dbUser.ediLaunch.substring(0, 2);
               System.out.println(month);
               String day = dbUser.ediLaunch.substring(3, 5);
               System.out.println(day);
               dbUser.ediLaunch = year +"-"+ month+"-"+day ;
               System.out.println(dbUser.ediLaunch);
               }
           dbUser.nsaddNotes= (String)request.getParameter("nsaddNotes");
           if(dbUser.nsaddNotes == null){
        	   dbUser.nsaddNotes = "";
           }
           System.out.println(dbUser.nsaddNotes);
           //System.out.println(dbUser.ediLaunch);
           
           dbUser.login = dbUser.getUserLogin();
           if(dbUser.login == null){
        	   dbUser.login = "";
           }
           //System.out.println(dbUser.login);
           
           dbUser.nsaddPunchOut = "";
           dbUser.nsnetworkID1 = "";
           dbUser.nscustomerID1 = "";
           dbUser.nspunchOutType1 = "";
           dbUser.nssharedSecret1 = "";
           dbUser.nspunchoutProvider1 = "";
           dbUser.nsproviderCode1 = "";
           dbUser.nscXml1 = "";
           dbUser.nsfullPunchOut1 = "";
          // dbUser.acctActive

        	   utils.saveNationalAccount(dbUser, response);
        	//////////////////////END of Saving New Account//////////////////// 
        	   
        	///////////////////////Query for Account Detail
        	   dbUser.nationalAccountNbr = dbUser.custMaj;
    		   System.out.println("NA NAME and NBR="+dbUser.nationalAccountNbr);
    		   String[] parts = dbUser.nationalAccountNbr.split(" - ");
    		   dbUser.customerNumber = parts[0];
    		   //request.setAttribute("parts1", parts1);
    		   System.out.println(dbUser.customerNumber);
    		   dbUser.custName = parts[1];
    		   //request.setAttribute("parts2", parts2);
    		   System.out.println(dbUser.custName);
    		   
    		   int length = dbUser.customerNumber.length();
    		  // System.out.print(length);
    		   dbUser.action = action;
    		   if(length != 10){
    		   
    			dbUser.customerNumber = "0" + dbUser.customerNumber;

    			dbUser.custMajor = String.format("%010d", Integer.parseInt(dbUser.customerNumber));
    			 
    		   System.out.println("10 digits?="+dbUser.nationalAccountNbr);
    		   System.out.println("Customer Majot "+dbUser.custMajor);
    		   }
    		   dbUser.routeToViewDtl = (String)request.getParameter("routeToViewDtl");
    	       //get national account info based on platform, national account and member selected
    	       utils.getNationalAccountDtl(dbUser, response);
    	       
    	     
  	    	 System.out.println("before if else= "+dbUser.usaClean);
  	    	 if(dbUser.usaClean ==null){
  	    		 dbUser.usaClean = "Yes";
  	    	 } else {
  	    		 dbUser.usaClean = "No"; 
  	    	 }
  	    	
  	    	 if(dbUser.locCount == null){
  	    		 dbUser.locCount = "0";
  	    	 }
  	    	
  	    	if(dbUser.locCount == null){
  	    		dbUser.locCount = "0";
  	    	}
  	    	
  	    	 if(dbUser.workflowCount == null){
  	    		 dbUser.workflowCount = "0";
  	    	 }
  	    	
  	    	 if(dbUser.locworkCount == null){
  	    		 dbUser.locworkCount = "0";
  	    	 }
  	    	
  	    	 if(dbUser.distCount == null){
  	    		 dbUser.distCount = "0";
  	    	 }
  	    	 
  	    	 if(dbUser.markSegment == null){
  	    		 dbUser.markSegment = "";
  	    	 }
  	    	 
  	    	 if(dbUser.assignedCSR == null){
  	    		 dbUser.assignedCSR = "N/A";
  	    	 }
  	    	 
  	    	 if(dbUser.zones == null){
  	    		 dbUser.zones = "N/A";
  	    	 }
  	    	
  	    	 if(dbUser.lsog == null){
  	    		 dbUser.lsog = "N";
  	    	 }
  	    	 
  	    	 if(dbUser.nscustItemNbr == null){
  	    		 dbUser.nscustItemNbr = "";
  	    	 }
  	    	 
  	    	 if(dbUser.percentItemNbr == null){
  	    		 dbUser.percentItemNbr = "0";
  	    	 }
    	       //int y = Integer.getInteger(nm);
    	      // System.out.println("Int y="+y);
    	       dbUser.custMajor = dbUser.custMajor.substring(0, 9);
    	       System.out.println("9 digit? "+dbUser.custMajor);
    	       utils.getNationalAccountName(dbUser, response);

    	       dbUser.customerNumber = dbUser.customerNumber.substring(1, 4);
    	       System.out.println(dbUser.customerNumber);
    	       dbUser.customerNumber = dbUser.customerNumber.replaceFirst("0", "");
    	       utils.getNationalAccountListEC(dbUser);
    	       
    	       String  routeToViewDtl = "";
    		   dbUser.routeToViewDtl = (String)request.getParameter("routeToViewDtl");
    		   actionType = (String)request.getParameter("routeToViewDtl");
    		   action = actionType = (String)request.getParameter("routeToViewDtl");
    	       request.setAttribute("actionType", action);
    	       System.out.println(actionType);
    	       System.out.println(routeToViewDtl); 
    	       System.out.println(action);
    	       
       ////////////////End of Query for Account Details
    	             
          // System.out.println(action);
	   } else if (action.equals("UpdateNA")) {
		     dbUser.action  = "UpdateNA";
		     request.setAttribute("actionType", action);
//		 get national accounts and member lists based on ecommerce platform select
	         utils.getNationalAccountListEC(dbUser); 
			  
	   } else if (action.equals("UpdateNA_1")){ 
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   System.out.println("NA NAME and NBR="+dbUser.nationalAccountNbr);
		   String[] parts = dbUser.nationalAccountNbr.split(" - ");
		   dbUser.customerNumber = parts[0];
		   //request.setAttribute("parts1", parts1);
		   System.out.println(dbUser.customerNumber);
		   dbUser.custName = parts[1];
		   //request.setAttribute("parts2", parts2);
		   System.out.println(dbUser.custName);
		   
		   int length = dbUser.customerNumber.length();
		  // System.out.print(length);
		   dbUser.action = action;
		   if(length != 10){
		   
			dbUser.customerNumber = "0" + dbUser.customerNumber;

			dbUser.custMajor = String.format("%010d", Integer.parseInt(dbUser.customerNumber));
			 
		   System.out.println("10 digits?="+dbUser.nationalAccountNbr);
		   System.out.println("Customer Majot "+dbUser.custMajor);
		   }
	       
	       //get national account info based on platform, national account and member selected
	       utils.getNationalAccountDtl(dbUser, response);
	       //int y = Integer.getInteger(nm);
	      // System.out.println("Int y="+y);
	       dbUser.custMajor = dbUser.custMajor.substring(0, 9);
	       System.out.println("9 digit? "+dbUser.custMajor);
	       utils.getNationalAccountName(dbUser, response);

	       dbUser.customerNumber = dbUser.customerNumber.substring(1, 4);
	       System.out.println(dbUser.customerNumber);
	       dbUser.customerNumber = dbUser.customerNumber.replaceFirst("0", "");
	       utils.getNationalAccountListEC(dbUser);
	       //utils.getPlatformList(dbUser); 
	       //was getMemberList on 10/3/08
	       //utils.getMemberListByCustomer(dbUser);
	       
	   } else if (action.equals("SaveUpdateNA")) {
		   
		   dbUser.routeToViewDtl = (String)request.getParameter("routeToViewDtl");
		   System.out.println(dbUser.routeToViewDtl);
		   loginURL = "/web/jsp/viewNA.jsp";
		   System.out.println(dbUser.nationalAccountNbr);
		   //dbUser.eplatform = (String)request.getParameter("eplatform");
           dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
           System.out.println(dbUser.nationalAccountNbr);
           dbUser.custMaj = (String)request.getParameter("natAcct");
           System.out.println(dbUser.custMaj);
           dbUser.custMaj = dbUser.custMaj.substring(0, 9);
           dbUser.custMaj = "0" + dbUser.custMaj;
           System.out.println(dbUser.custMaj);
           
		   dbUser.custMajor =  dbUser.custMaj;//String.format("%010d", Integer.parseInt(dbUser.custMaj));
		   System.out.println(dbUser.custMajor);
           dbUser.natAcct = (String)request.getParameter("natAcct");
           //System.out.println(dbUser.natAcct);
		   dbUser.soldTo = dbUser.natAcct.substring(0, 3);
		  // System.out.println(dbUser.soldTo);
           dbUser.action = (String)request.getParameter("actionType");
          // System.out.println(dbUser.action);
          
           		//stored proc already set IsActive =1 => this value isn't passed into stored proc
           		//during new account
           /*dbUser.acctActive = (String)request.getParameter("acctActive");
           dbUser.productCatFlag = (String)request.getParameter("productCatFlag");
           dbUser.multipleSoldTo = (String)request.getParameter("multipleSoldTo");
           dbUser.custItemNbr = (String)request.getParameter("custItemNbr");
           dbUser.warning = (String)request.getParameter("warning");
           dbUser.poRequired = (String)request.getParameter("poRequired");*/
           dbUser.acctActive = (String)request.getParameter("acctActive");
           System.out.println(dbUser.acctActive);
           if(dbUser.acctActive == null){
        	   dbUser.acctActive = "";
           }
           dbUser.nsacctActive = (String)request.getParameter("nsacctActive");
           System.out.println(dbUser.nsacctActive);
           if(dbUser.nsacctActive == null){
        	   dbUser.nsacctActive = ""; 
           }
           dbUser.activeCheck = (String)request.getParameter("activeCheck");
           System.out.println(dbUser.activeCheck);
           dbUser.activeCheckNS = (String)request.getParameter("activeCheckNS");
           System.out.println(dbUser.activeCheckNS);
           
           dbUser.orderSource = (String)request.getParameter("orderSource");
           //System.out.println(dbUser.orderSource);
           dbUser.nsddMT = (String)request.getParameter("nsddMT");
           if(dbUser.nsddMT ==null){
        	   dbUser.nsddMT = "";
           }
          // System.out.println(dbUser.nsddMT);
           dbUser.nscustLocNbr = (String)request.getParameter("nscustLocNbr");
           if(dbUser.nscustLocNbr ==null){
        	   dbUser.nscustLocNbr = "";
           }
          // System.out.println(dbUser.nscustLocNbr);
           dbUser.nscustURL = (String)request.getParameter("nscustURL");
           if(dbUser.nscustURL ==null){
        	   dbUser.nscustURL = "";
           }
           //System.out.println(dbUser.nscustURL);
           dbUser.nslaunchDate = (String)request.getParameter("nslaunchDate");
           if(dbUser.nslaunchDate ==null){
        	   dbUser.nslaunchDate = ""; 
           }
           System.out.println(dbUser.nslaunchDate);
           if(!dbUser.nslaunchDate.equals("")||dbUser.nslaunchDate != null){
           String year = dbUser.nslaunchDate.substring(6, 10);
           System.out.println(year);
           String month = dbUser.nslaunchDate.substring(0, 2);
           System.out.println(month);
           String day = dbUser.nslaunchDate.substring(3, 5);
           System.out.println(day);
           dbUser.nslaunchDate = year +"-"+ month+"-"+day ;
           System.out.println(dbUser.nslaunchDate);
          // System.out.println(dbUser.nslaunchDate);
           }
           System.out.println(dbUser.nsaddNotes);
           dbUser.nsaddNotes = (String)request.getParameter("nsaddNotes");
           if(dbUser.nsaddNotes ==null){
        	   dbUser.nsaddNotes = ""; 
           }
           System.out.println("Add Notes = "+dbUser.nsaddNotes);
           dbUser.nsimgUsed = (String)request.getParameter("nsimgUsed");
           if(dbUser.nsimgUsed ==null){
        	   dbUser.nsimgUsed = "";
           }
          // System.out.println(dbUser.nsimgUsed);
           dbUser.nsenrichMent = (String)request.getParameter("nsenrichMent");
           if(dbUser.nsenrichMent ==null){
        	   dbUser.nsenrichMent = "";
           }
          // System.out.println(dbUser.nsenrichMent);
           dbUser.nsdualOrdGuide = (String)request.getParameter("nsdualOrdGuide");
           if(dbUser.nsdualOrdGuide ==null){
        	   dbUser.nsdualOrdGuide = "";
           }
          // System.out.println(dbUser.nsdualOrdGuide);
           dbUser.nscatView = (String)request.getParameter("nscatView");
           if(dbUser.nscatView ==null){
        	   dbUser.nscatView = "";
           }
          // System.out.println(dbUser.nscatView);
           dbUser.nssDs = (String)request.getParameter("nssDs");
           if(dbUser.nssDs ==null){
        	   dbUser.nssDs = "";
           }
           //System.out.println(dbUser.nssDs);
           dbUser.nsbarCodes = (String)request.getParameter("nsbarCodes");
           if(dbUser.nsbarCodes == null){
        	   dbUser.nsbarCodes = "";
           }	
           //System.out.println(dbUser.nsbarCodes);
           dbUser.nsauthContact = (String)request.getParameter("nsauthContact");
           if(dbUser.nsauthContact ==null){
        	   dbUser.nsauthContact = "";
           }
           //System.out.println(dbUser.nsauthContact);
           dbUser.nscontactEmail = (String)request.getParameter("nscontactEmail");
           if(dbUser.nscontactEmail ==null){
        	   dbUser.nscontactEmail = "";
           }
           //System.out.println(dbUser.nscontactEmail);
           dbUser.nsccLogin = (String)request.getParameter("nsccLogin");
           if(dbUser.nsccLogin ==null){
        	   dbUser.nsccLogin = "";
           }
          // System.out.println(dbUser.nsccLogin);
           dbUser.nscorpApproval = (String)request.getParameter("nscorpApproval");
           if(dbUser.nscorpApproval ==null){
        	   dbUser.nscorpApproval = "";
           }
           //System.out.println(dbUser.nscorpApproval);
           dbUser.nsitemApproval = (String)request.getParameter("nsitemApproval");
           if(dbUser.nsitemApproval ==null){
        	   dbUser.nsitemApproval = "";
           }
           //System.out.println(dbUser.nsitemApproval);
           dbUser.nsitemApprovalNote = (String)request.getParameter("nsitemApprovalNote");
           if(dbUser.nsitemApprovalNote ==null){
        	   dbUser.nsitemApprovalNote = "";
           }
           //System.out.println(dbUser.nsitemApprovalNote);
           dbUser.nsadminPOEmail = (String)request.getParameter("nsadminPOEmail");
           if(dbUser.nsadminPOEmail ==null){
        	   dbUser.nsadminPOEmail = "";
           }
           //System.out.println(dbUser.nsadminPOEmail);
           dbUser.nsadminEmail = (String)request.getParameter("nsadminEmail");
           if(dbUser.nsadminEmail ==null){
        	   dbUser.nsadminEmail = "";
           }
           //System.out.println(dbUser.nsadminEmail);
           dbUser.nshidePrice = (String)request.getParameter("nshidePrice");
           if(dbUser.nshidePrice ==null){
        	   dbUser.nshidePrice = "";
           }
           //System.out.println(dbUser.nshidePrice);
           dbUser.nsuserNamesText = (String)request.getParameter("nsuserNamesText");
           if(dbUser.nsuserNamesText ==null){
        	   dbUser.nsuserNamesText = "";
           }
          // System.out.println(dbUser.nsuserNamesText);
           dbUser.nsuserPasswordText = (String)request.getParameter("nsuserPasswordText");
           if(dbUser.nsuserPasswordText ==null){
        	   dbUser.nsuserPasswordText = "";
           }
           //System.out.println(dbUser.nsuserPasswordText);
           dbUser.nsfavList = (String)request.getParameter("nsfavList");
           if(dbUser.nsfavList ==null){
        	   dbUser.nsfavList = "";
           }
          // System.out.println(dbUser.nsfavList);
           dbUser.nsfavListNote = (String)request.getParameter("nsfavListNote");
           if(dbUser.nsfavListNote ==null){
        	   dbUser.nsfavListNote = ""; 
           }
          // System.out.println(dbUser.nsfavListNote);
           dbUser.nscleanupFlag = (String)request.getParameter("nscleanupFlag");
           if(dbUser.nscleanupFlag ==null){
        	   dbUser.nscleanupFlag = "";
           }
           //System.out.println(dbUser.nscleanupFlag);
           dbUser.nsssoCustomer = (String)request.getParameter("nsssoCustomer");
           if(dbUser.nsssoCustomer ==null){
        	   dbUser.nsssoCustomer = "";
           }
           dbUser.nsssoNotes = (String)request.getParameter("nsssoNotes");
           if(dbUser.nsssoNotes ==null){
        	   dbUser.nsssoNotes = "";
           }
           //System.out.println(dbUser.nsssoCustomer);
           dbUser.nspunchOut = (String)request.getParameter("nspunchOut");
           if(dbUser.nspunchOut ==null){
        	   dbUser.nspunchOut = "";
           }
           //System.out.println(dbUser.nspunchOut);
           dbUser.nspunchOutType = (String)request.getParameter("nspunchOutType");
           if(dbUser.nspunchOutType ==null){
        	   dbUser.nspunchOutType = "";
           }
           dbUser.nsnetworkID = (String)request.getParameter("nsnetworkID");
           if(dbUser.nsnetworkID ==null){
        	   dbUser.nsnetworkID = "";
           }
           dbUser.nscustomerID = (String)request.getParameter("nscustomerID");
           if(dbUser.nscustomerID ==null){
        	   dbUser.nscustomerID = "";
           }
           //System.out.println(dbUser.nspunchOutType);
           dbUser.nssharedSecret = (String)request.getParameter("nssharedSecret");
           if(dbUser.nssharedSecret ==null){
        	   dbUser.nssharedSecret = "";
           }
           //System.out.println(dbUser.nssharedSecret);
           dbUser.nspunchoutProvider = (String)request.getParameter("nspunchoutProvider");
           if(dbUser.nspunchoutProvider ==null){
        	   dbUser.nspunchoutProvider = "";
           }
           //System.out.println(dbUser.nspunchoutProvider);
           dbUser.nsproviderCode = (String)request.getParameter("nsproviderCode");
           if(dbUser.nsproviderCode ==null){
        	   dbUser.nsproviderCode= "";
           }
          // System.out.println(dbUser.nsproviderCode);
           dbUser.nscXml = (String)request.getParameter("nscXml");
           if(dbUser.nscXml ==null){
        	   dbUser.nscXml = "";
           }
           //System.out.println(dbUser.nscXml);
           dbUser.nsfullPunchOut = (String)request.getParameter("nsfullPunchOut");
           if(dbUser.nsfullPunchOut ==null){
        	   dbUser.nsfullPunchOut = "";
           }
           
           //////////////
           dbUser.nsaddPunchOut = (String)request.getParameter("nsaddPunchOut");
           if(dbUser.nsaddPunchOut ==null){
        	   dbUser.nsaddPunchOut= "";
           }
           System.out.println(dbUser.nsaddPunchOut);
           dbUser.nspunchOutType1 = (String)request.getParameter("nspunchOutType1");
           if(dbUser.nspunchOutType1 ==null){
        	   dbUser.nspunchOutType1 = "";
           }
           dbUser.nsnetworkID1 = (String)request.getParameter("nsnetworkID1");
           if(dbUser.nsnetworkID1 ==null){
        	   dbUser.nsnetworkID1 = "";
           }
           dbUser.nscustomerID1 = (String)request.getParameter("nscustomerID1");
           if(dbUser.nscustomerID1 ==null){
        	   dbUser.nscustomerID1 = "";
           }
           //System.out.println(dbUser.nspunchOutType1);
           dbUser.nssharedSecret1 = (String)request.getParameter("nssharedSecret1");
           if(dbUser.nssharedSecret1 ==null){
        	   dbUser.nssharedSecret1 = "";
           }
          // System.out.println(dbUser.nssharedSecret1);
           dbUser.nspunchoutProvider1 = (String)request.getParameter("nspunchoutProvider1");
           if(dbUser.nspunchoutProvider1 ==null){
        	   dbUser.nspunchoutProvider1 = "";
           }
          // System.out.println(dbUser.nspunchoutProvider1);
           dbUser.nsproviderCode1 = (String)request.getParameter("nsproviderCode1");
           if(dbUser.nsproviderCode1 ==null){
        	   dbUser.nsproviderCode1 = "";
           }
           //System.out.println(dbUser.nsproviderCode1);
           dbUser.nscXml = (String)request.getParameter("nscXml1");
           if(dbUser.nscXml ==null){
        	   dbUser.nscXml = "";
           }
           //System.out.println(dbUser.nscXml1);
           dbUser.nsfullPunchOut1 = (String)request.getParameter("nsfullPunchOut1");
           if(dbUser.nsfullPunchOut1 ==null){
        	   dbUser.nsfullPunchOut1 = "";
           }
           
           System.out.println(dbUser.nsfullPunchOut1);
           
           //////////////////
           
           dbUser.ddMT = (String)request.getParameter("ddMT");
           if(dbUser.ddMT ==null){
        	   dbUser.ddMT = "";
           }
          // System.out.println(dbUser.ddMT);
           dbUser.imgUsed = (String)request.getParameter("imgUsed");
           if(dbUser.imgUsed ==null){
        	   dbUser.imgUsed = "";
           }
          // System.out.println(dbUser.imgUsed);
           dbUser.enrichMent = (String)request.getParameter("enrichMent");
           if(dbUser.enrichMent ==null){
        	   dbUser.enrichMent = "";
           }
           //System.out.println(dbUser.enrichMent);
           dbUser.sDs = (String)request.getParameter("sDs");
           if(dbUser.sDs ==null){
        	   dbUser.sDs = "";
           }
          // System.out.println(dbUser.sDs);
           dbUser.barCodes = (String)request.getParameter("barCodes");
           if(dbUser.barCodes ==null){
        	   dbUser.barCodes = "";
           }
           //System.out.println(dbUser.barCodes);
           dbUser.catView = (String)request.getParameter("catView");
           if(dbUser.catView ==null){
        	   dbUser.catView = "";
           }
           //System.out.println(dbUser.catView);
           dbUser.ediLaunch = (String)request.getParameter("ediLaunch");
           if(dbUser.ediLaunch ==null){
        	   dbUser.ediLaunch = "";
           }
           if(dbUser.ediLaunch != null ||dbUser.ediLaunch != ""){
               String year = dbUser.ediLaunch.substring(6, 10);
               System.out.println(year);
               String month = dbUser.ediLaunch.substring(0, 2);
               System.out.println(month);
               String day = dbUser.ediLaunch.substring(3, 5);
               System.out.println(day);
               dbUser.ediLaunch = year +"-"+ month+"-"+day ;
               System.out.println(dbUser.ediLaunch);
              // System.out.println(dbUser.nslaunchDate);
               }
           
           dbUser.addNotes = (String)request.getParameter("addNotes");
           if(dbUser.addNotes.equals("") || dbUser.addNotes == null){
        	   dbUser.addNotes = "";
           }
           System.out.println("addnotes = "+dbUser.addNotes);
           
           dbUser.login = dbUser.getUserLogin();
         
           				         
           	utils.saveNationalAccount(dbUser, response); //same stored proc as add new NA - typeAction is I or U
		//////////////End of Saving Update////////////////////////
           	
       //////////////Getting Account Detail/////////////////////
            
 	       //get national account info based on platform, national account and member selected
 	       utils.getNationalAccountDtl(dbUser, response);
 	       
 	     
	    	 System.out.println("before if else= "+dbUser.usaClean);
	    	 if(dbUser.usaClean ==null){
	    		 dbUser.usaClean = "Yes";
	    	 } else {
	    		 dbUser.usaClean = "No"; 
	    	 }
	    	
	    	 if(dbUser.locCount == null){
	    		 dbUser.locCount = "0";
	    	 }
	    	
	    	if(dbUser.locCount == null){
	    		dbUser.locCount = "0";
	    	}
	    	
	    	 if(dbUser.workflowCount == null){
	    		 dbUser.workflowCount = "0";
	    	 }
	    	
	    	 if(dbUser.locworkCount == null){
	    		 dbUser.locworkCount = "0";
	    	 }
	    	
	    	 if(dbUser.distCount == null){
	    		 dbUser.distCount = "0";
	    	 }
	    	 
	    	 if(dbUser.markSegment == null){
	    		 dbUser.markSegment = "";
	    	 }
	    	 
	    	 if(dbUser.assignedCSR == null){
	    		 dbUser.assignedCSR = "N/A";
	    	 }
	    	 
	    	 if(dbUser.zones == null){
	    		 dbUser.zones = "N/A";
	    	 }
	    	
	    	 if(dbUser.lsog == null){
	    		 dbUser.lsog = "N";
	    	 }
	    	 
	    	 if(dbUser.nscustItemNbr == null){
	    		 dbUser.nscustItemNbr = "";
	    	 }
	    	 
	    	 if(dbUser.percentItemNbr == null){
	    		 dbUser.percentItemNbr = "0";
	    	 }
 	       //int y = Integer.getInteger(nm);
 	      // System.out.println("Int y="+y);
 	       dbUser.custMajor = dbUser.custMajor.substring(0, 9);
 	       System.out.println("9 digit? "+dbUser.custMajor);
 	       utils.getNationalAccountName(dbUser, response);

 	       dbUser.customerNumber = dbUser.custMaj.substring(0, 3);
 	       System.out.println(dbUser.customerNumber);
 	       dbUser.customerNumber = dbUser.customerNumber.replaceFirst("0", "");
 	       utils.getNationalAccountListEC(dbUser);
 	       
 	       String  routeToViewDtl = "";
 		   dbUser.routeToViewDtl = (String)request.getParameter("routeToViewDtl");
 		   actionType = (String)request.getParameter("routeToViewDtl");
 		   action = actionType = (String)request.getParameter("routeToViewDtl");
 	       request.setAttribute("actionType", action);
 	       System.out.println(actionType);
 	       System.out.println(routeToViewDtl); 
 	       System.out.println(action);
 	       
 	       //////////////////////End of Account Detail//////////////////
           	
	   }  else if (action.equals("viewNA")){
		   
		   utils.getNationalAccountListEC(dbUser); 
		   
		   
	   } else if (action.equals("viewNADtl")){
		   
		   //utils.getNationalAccountListEC(dbUser); //create new stored proc for the National Account detail.
		   dbUser.natAcct = (String)request.getParameter("natAcct");
		   System.out.println("NAT ACCT+"+dbUser.natAcct);
		   request.getSession().setAttribute("natAcct", dbUser.natAcct);
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   dbUser.nationalAccountNbr = dbUser.nationalAccountNbr.substring(0,9);
		   dbUser.custName = (String)request.getParameter("natAcct");
		   System.out.println("CUST NAME="+dbUser.custName);
		   System.out.println(dbUser.nationalAccountNbr);
		   dbUser.action = action;
		   System.out.println("NAtional Account Number"+dbUser.nationalAccountNbr);
		   /*String[] parts = dbUser.nationalAccountNbr.split(",");
		   String parts1 = parts[0];
		   System.out.println(parts1);
		   String parts2 = "0" + parts[1];
		   //parts2.substring(1);
		   //request.setAttribute("parts2", parts2);
		   System.out.println(parts2);
		   dbUser.nationalAccountNbr = parts2;*/
		   String activeCheckNS = request.getParameter("activeCheckNS");
		   request.getSession().setAttribute("activeCheckNS", activeCheckNS);
		   String activeCheck = request.getParameter("activeCheck");
		   request.getSession().setAttribute("activeCheck", activeCheckNS);
		   int length = dbUser.nationalAccountNbr.length();
		  // System.out.println(dbUser.nationalAccountNbr);
		   if(length != 10){
			  dbUser.custMajor = String.format("%010d", Integer.parseInt(dbUser.nationalAccountNbr));
			  dbUser.nationalAccountNbr = dbUser.custMajor;
			  System.out.println("10digits?"+dbUser.nationalAccountNbr);
		   }
		   
	       utils.getNationalAccountDtl(dbUser, response);
	       
	       utils.getNationalAccountName(dbUser, response);
	       
	       //dbUser.nationalAccountNbr = String.format("%03d", Integer.parseInt(dbUser.nationalAccountNbr));
	       dbUser.nationalAccountNbr = dbUser.nationalAccountNbr.substring(1, 4);
	       dbUser.customerNumber = dbUser.nationalAccountNbr.replaceFirst("0", "");
	       System.out.println("NA ACct #="+dbUser.nationalAccountNbr);
	       
	       utils.getNationalAccountListEC(dbUser);
		   
		   
	   } else if (action.equals("UpdateMember")) {
	   
		   
		   //get list for National Accounts + ecommerce platform
		   //get list for Members + ecommerce platfrom
		   
		   utils.getNationalAccountListEC(dbUser);
		  // utils.getMemberListEC(dbUser);
		   
	   } else if (action.equals("UpdateMemberNA")) {
		   //get filtered list of Members based on national account selected
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   
		     String sepC =","; //separate customer & platform
	         String newStr = dbUser.nationalAccountNbr;
	         int dd = newStr.length();
	         int ee =0;

	         if (dd!=0) { //account selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.nationalAccountNbr = newStr.substring(0, ee);         			         	
	         	ee = ee +1;
	         	dbUser.eplatform = newStr.substring(ee,dd);
	         }

	         
	        utils.getNationalAccountName(dbUser, response);
		    
	        
	        //utils.getMemberList(dbUser);
	        utils.getMemberListByCustomer(dbUser);
		    
		       //utils.getOrderGuidePrefix(dbUser, response);
			   //utils.getOrderGuideList(dbUser);			   
	           //run this within getMemberUpdates and on JSP page within loop
	        
			  // utils.getMemberUpdatesCustOnly(dbUser);	
			   //repopulate dropdown
			   utils.getNationalAccountListEC(dbUser);
		  
		   
	   } else if (action.equals("UpdateMemberMem")) {
		   			// || action.equals("GetNAFromMemSB") - for super buyer
		   //get filtered list of National Accounts based on member major selected
		   
		   dbUser.memberNbr = (String)request.getParameter("member");
		   
		     String sepC =","; //separate member maj and min
	         String sepM = ";"; //ecommerce 
	         String newStr = dbUser.memberNbr;
	         String newStr1 = "";
	         String newStr2 = "";
	         int dd = newStr.length();
	         int ee =0;
	         int ff =0;
	         

	         if (dd!=0) { //members selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.memberNbr = newStr.substring(0, ee);
	         	ff = newStr.indexOf(sepM);
	         			         	
	         	ee = ee +1;
	         	dbUser.memberMinNbr = newStr.substring(ee,ff);
	         	ff = ff +1;
	         	
	         	dbUser.eplatform = newStr.substring(ff,dd);

	         } //end of if	         
		   
		 // utils.getNationalAccountListFromMem(dbUser);
		  utils.getMemberName(dbUser, response);
		  
		  		
				//utils.getMemberUpdatesMemOnly(dbUser);
				
			//re-populate member dropdown
			//utils.getMemberListEC(dbUser);
		   
	   } else if (action.equals("UpdateMemberDtl")) {
		   //listing of members based on member and national account selected
		   dbUser.memberNbr = (String)request.getParameter("member");
		   
		   String sepC =","; //separate member maj and min
	         String newStr = dbUser.memberNbr;
	         int dd = newStr.length();
	         int ee =0;

	         if (dd!=0) { //members selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.memberNbr = newStr.substring(0, ee);	         			         	
	         	ee = ee +1;
	         	dbUser.memberMinNbr = newStr.substring(ee,dd);

	         } //end of if
		   
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   dbUser.eplatform = (String)request.getParameter("eplatform");
		   

		 //  utils.getMemberUpdates(dbUser);
		   
		   //utils.getOrderGuidePrefix(dbUser, response); //don't use query for specific OG prefix in JSP
		 //  utils.getMulOGList(dbUser); //list of cust# with same company code
		 //  utils.getOrderGuideList(dbUser);
		  
		   
		   utils.getMemberName(dbUser, response);
		   
		   String prevMemMin= dbUser.memberMinNbr;
		   utils.getNationalAccountName(dbUser, response);
		   
		   dbUser.memberMinNbr = prevMemMin; //change member Min value back to original
		   
		   //repopulate member AND customer dropdown
		   utils.getNationalAccountListEC(dbUser);
		 //  utils.getMemberListEC(dbUser);
		   	   
		   
	   } else if (action.equals("SaveUpdateMember")) {
		   //save updates to members
		   String totRecords = (String)request.getParameter("totR");
		   dbUser.nationalAccountNbrMin = (String)request.getParameter("natAcctMin");
		   dbUser.eplatform = (String)request.getParameter("eplatform");
		   
		   int count=0;
		   int totR = Integer.parseInt(totRecords);
		   while (count < totR) {
			   
			   dbUser.memberMinNbr = (String)request.getParameter("memberMin"+count);
			   dbUser.memberNbr = (String)request.getParameter("member"+count);
			   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct"+count);
			   
			   dbUser.memberEmail = (String)request.getParameter("memberEmail"+count);
			   		if (dbUser.memberEmail=="" || dbUser.memberEmail.equals("")){
			   			dbUser.memberEmail = "orders@networkdistribution.com";
			   		}
			   dbUser.catalogName = (String)request.getParameter("orderGuide"+count);
			   		if (dbUser.catalogName.equals("none")) {
			   			dbUser.catalogName = "";
			   		} else { //OG select parse for zone

			   		String sepC ="Z"; //separate member maj and min
			   		String tempS="";
				    String newStr = dbUser.catalogName;
				    int dd = newStr.length();
				    int ee =0;

				     //if (dd!=0) { //OG selected selected
				       ee = newStr.indexOf(sepC);
				       if (ee> -1) { //OG selected selected and zone 
				       tempS = newStr.substring(0, ee);	 //catalogname without zone        			         	
				       ee = ee +1;
				       dbUser.zone = newStr.substring(ee,dd);
				         } else {
				        	 dbUser.zone="0";
				         }
			   				
		   			}
			   dbUser.memberActive = (String)request.getParameter("active"+count);			   
			   
			   		//if (dbUser.memberActive=="" || dbUser.memberActive.equals("")) {
		 
		 if (dbUser.memberActive!=null) {  
			 
			 if (dbUser.memberActive.length()==0) {
		    	  dbUser.memberActive = "-1";
		      }
		 } else {
			   			dbUser.memberActive = "-1";
			   			//field is disabled on UI, default to -1; stored proc handles and doesn't update this column in database
			   		}			   
			   
			   //add if select OG and then unselect...radio button don't go back to disable - default memberActive value back to -1
			   if (dbUser.catalogName=="")  {
				   dbUser.memberActive = "0";
			  
			   } else { //add on 7/13/2011 only update if OG is selected
				  // utils.saveMemberUpdates(dbUser);
			   }
			   
			   count++;
		   }
		   
		   
		   
	   	} else if (action.equals("UpdateLocation")) {
		   
		   //get list for National Accounts + ecommerce platform
		   //get list for Members + ecommerce platfrom
		   
		   utils.getNationalAccountListEC(dbUser);
		  // utils.getMemberListEC(dbUser);
		   
	   } else if (action.equals("UpdateLocationNA")) {
		   //get filtered list of Members based on national account selected
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   
		     String sepC =","; //separate customer & platform
	         String newStr = dbUser.nationalAccountNbr;
	         int dd = newStr.length();
	         int ee =0;

	         if (dd!=0) { //account selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.nationalAccountNbr = newStr.substring(0, ee);         			         	
	         	ee = ee +1;
	         	dbUser.eplatform = newStr.substring(ee,dd);
	         }
	         
	        utils.getNationalAccountName(dbUser, response);
		    
	        
	        //add 4/26/2011 get customer location w/o member selected
	        dbUser.memberNbr = "0"; 
	        dbUser.memberMinNbr ="00";
	       // utils.getNationalAccountMinList(dbUser);
	        
	        //utils.getMemberList(dbUser);
	        utils.getMemberListByCustomer(dbUser);
	        
	        //repopulate customer dropdown
	        utils.getNationalAccountListEC(dbUser);
		    
		   
	   } else if (action.equals("UpdateLocationMem")) {
		   //get filtered list of National Accounts based on member major selected
		   
		   dbUser.memberNbr = (String)request.getParameter("member");
		   
		   String sepC =","; //separate member maj and min
	         String sepM = ";"; //ecommerce 
	         String newStr = dbUser.memberNbr;
	         int dd = newStr.length();
	         int ee =0;
	         int ff =0;
	         

	         if (dd!=0) { //members selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.memberNbr = newStr.substring(0, ee);
	         	ff = newStr.indexOf(sepM);
	         			         	
	         	ee = ee +1;
	         	dbUser.memberMinNbr = newStr.substring(ee,ff);
	         	ff = ff +1;
	         	
	         	dbUser.eplatform = newStr.substring(ff,dd);

	         } //end of if
		   
		//  utils.getNationalAccountListFromMem(dbUser);
		  utils.getMemberName(dbUser, response);
		  
		  //repopulate member dropdown
		//   utils.getMemberListEC(dbUser);
		  	  
		  
	   } else if (action.equals("UpdateLocationNAMin")){
		   dbUser.memberNbr = (String)request.getParameter("member");
		   
		   String sepC =","; //separate member maj and min
	         String newStr = dbUser.memberNbr;
	         int dd = newStr.length();
	         int ee =0;         

	         if (dd!=0) { //members selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.memberNbr = newStr.substring(0, ee);	         			         	
	         	ee = ee +1;
	         	dbUser.memberMinNbr = newStr.substring(ee,dd);;

	         } //end of if
	         
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   dbUser.eplatform = (String)request.getParameter("eplatform");
		   
		//   utils.getNationalAccountMinList(dbUser);

		   utils.getNationalAccountName(dbUser, response);
		   utils.getMemberName(dbUser, response);
		   
		   //repopulate customer and member dropdown
		   utils.getNationalAccountListEC(dbUser);
		//   utils.getMemberListEC(dbUser);
		   
		   
	   } else if (action.equals("UpdateLocationDtl")) {
		   //listing of members based on member and national account selected
		   dbUser.memberNbr = (String)request.getParameter("member");
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   dbUser.eplatform = (String)request.getParameter("eplatform");
		   dbUser.nationalAccountNbrMin = (String)request.getParameter("natAcctMin");
		   
		   dbUser.acmCode = "-1"; //no altcustmin code at this point
		   
		     String sepC =","; //separate member maj and min
	         String newStr = dbUser.memberNbr;
	         int dd = newStr.length();
	         int ee =0;

	         if (dd!=0) { //members selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.memberNbr = newStr.substring(0, ee);	         			         	
	         	ee = ee +1;
	         	dbUser.memberMinNbr = newStr.substring(ee,dd);

	         } //end of if
		   
	         utils.getNationalAccountNameMin(dbUser, response); //get name from data warehouse specific to customer min location
			 utils.getMemberName(dbUser, response);
			 			   
		//   utils.getLocationUpdate(dbUser);
		 //  utils.getLocationUpdateC(dbUser);
		 //  utils.getCustomerMin(dbUser, response);
		   
		 //  utils.getAltCustMinFlag(dbUser, response); //determine if multiple records based on customer minor
		   	if (dbUser.custMinF.equals("1")) {
		   //		utils.getAltCustMinCodes(dbUser);
		   		dbUser.acmFlag = "Y";
		   		
		   	}
		   	
		   	
		   	//added 4/26/2011
	   } else if (action.equals("UpdateLocationDtl_noMem")) {
		   	//System.out.println("do new action");
		   //dbUser.memberNbr = (String)request.getParameter("member");
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   	//System.out.println(dbUser.nationalAccountNbr);
		   dbUser.eplatform = (String)request.getParameter("eplatform");
		   	//System.out.println(dbUser.eplatform);
		   dbUser.nationalAccountNbrMin = (String)request.getParameter("natAcctMin");
		   	//System.out.println(dbUser.nationalAccountNbrMin);
		   
		   dbUser.acmCode = "-1"; //no altcustmin code at this point
		   
		     //get memberNbr and memberMinNbr based on customer vendor association
		    utils.getMemberByCustomerLoc(dbUser, response);
		   
	         utils.getNationalAccountNameMin(dbUser, response); //get name from data warehouse specific to customer min location
			 //utils.getMemberName(dbUser, response);
			 			   
		//   utils.getLocationUpdate(dbUser);
		//   utils.getLocationUpdateC(dbUser);
		//   utils.getCustomerMin(dbUser, response);
		   
		//   utils.getAltCustMinFlag(dbUser, response); //determine if multiple records based on customer minor
		   	if (dbUser.custMinF.equals("1")) {
		   	//	utils.getAltCustMinCodes(dbUser);
		   		dbUser.acmFlag = "Y";
		   		
		   	}
		   
	   } else if (action.equals("UpdateLocationDtlACM")) {
		   //customer minor has multiple records or altcustmincode flag = Yes
		   //perfrom additional filter on display
		   
//		 listing of members based on member and national account selected
		   dbUser.memberNbr = (String)request.getParameter("member");
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   dbUser.eplatform = (String)request.getParameter("eplatform");
		   dbUser.nationalAccountNbrMin = (String)request.getParameter("natAcctMin");
		   dbUser.acmCode = (String)request.getParameter("custMinCode");
		   	   
		   
		   String sepC =","; //separate member maj and min
	         String newStr = dbUser.memberNbr;
	         int dd = newStr.length();
	         int ee =0;

	         if (dd!=0) { //members selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.memberNbr = newStr.substring(0, ee);	         			         	
	         	ee = ee +1;
	         	dbUser.memberMinNbr = newStr.substring(ee,dd);

	         } //end of if
		   
	         utils.getNationalAccountNameMin(dbUser, response); //get name from data warehouse specific to customer min location
			 utils.getMemberName(dbUser, response);
			 
		//   utils.getLocationUpdate(dbUser); //additional parameter of altcustmincode
		//   utils.getLocationUpdateC(dbUser); //additional parameter of altcustmincode
		//   utils.getCustomerMin(dbUser, response);
		   
		   
	   	   
	   } else if (action.equals("SaveUpdateLocation")) {
		   //save updates to members
		   //dbUser.memberMinNbr = (String)request.getParameter("memberMin");
		   dbUser.memberNbr = (String)request.getParameter("member");
		   dbUser.nationalAccountNbr = (String)request.getParameter("natAcct");
		   dbUser.nationalAccountNbrMin = (String)request.getParameter("natAcctMin");
		   dbUser.eplatform = (String)request.getParameter("eplatform");
		   
		   
		   String sepC =","; //separate member maj and min
	         String newStr = dbUser.memberNbr;
	         int dd = newStr.length();
	         int ee =0;

	         if (dd!=0) { //members selected
	         	ee = newStr.indexOf(sepC);
	         	dbUser.memberNbr = newStr.substring(0, ee);	         			         	
	         	ee = ee +1;
	         	dbUser.memberMinNbr = newStr.substring(ee,dd);

	         } //end of if
	         
		   
		   dbUser.memberEmail = (String)request.getParameter("memberEmail");
	   		if (dbUser.memberEmail=="" || dbUser.memberEmail.equals("")){
	   			//dbUser.memberEmail = "orders@networkdistribution.com";
	   			dbUser.memberEmail = "";
	   		}
	   		dbUser.catalogName = (String)request.getParameter("orderGuide");
	   		if (dbUser.catalogName.equals("none")) {
	   			dbUser.catalogName = "";
	   		} else { //add 11/10/2010
	   			
	   			String sepZ ="Z"; //pull out zone from catalog name
		   		String tempS="";
			    String newStr1 = dbUser.catalogName;
			    int aa = newStr1.length();
			    int bb =0;

			     //if (aa!=0) { //OG selected selected
			       bb = newStr1.indexOf(sepZ);
			       if (bb > -1) { //OG selected and has a zone
			       tempS = newStr1.substring(0, bb); //catalogname without zone        			         	
			       bb = bb +1;
			       dbUser.zone = newStr1.substring(bb,aa);
			         } 	else {
			        	 dbUser.zone="0";
			         }
			     //System.out.println("zone updtLoc "+dbUser.zone);
	   		}
	   		
	   		dbUser.memberActive = (String)request.getParameter("active");
	   		
	   		if (dbUser.memberActive!=null) { } else {
	   		dbUser.memberActive = "0";
	   			//field is disabled on UI, default to -1; stored proc handles and doesn't update this column in database
	   		}
	   		
	   		//if catalog selected and then unselected, default memberActive back to -1
	   		if (dbUser.catalogName=="") {
	   			dbUser.memberActive = "0";
	   			
	   		}
	   		
	   		
	   		dbUser.locPropID = (String)request.getParameter("lpID");
	   		dbUser.locationEmail = (String)request.getParameter("locationEmail");
	   		
	   		dbUser.acmCode = (String)request.getParameter("acmCode");
   		    dbUser.companyCode = (String)request.getParameter("companyCode");
   		    dbUser.userPrefix = (String)request.getParameter("username");
   		    dbUser.pswdPrefix = (String)request.getParameter("password");
   		    dbUser.secondaryMem = (String)request.getParameter("secondaryMember");
   		    
   		    dbUser.comments = (String)request.getParameter("comments");

		   
		 //  utils.saveLocationUpdate(dbUser);
		   
		   //version 2.0 EUI super buyer location update
		   
	   } else if (action.equals("Dashboard")) {
			  utils.getDashboard(dbUser);
			  
	   } else if (action.equals("AddUser")) {
	    	  //do nothing
	    	  
	      } else if (action.equals("NewUser")) {
	    	  
	    	  dbUser.uName = (String)request.getParameter("userN");
	    	  dbUser.uPswd = (String)request.getParameter("userP");
	    	  dbUser.uActive = (String)request.getParameter("active");
	    	  dbUser.uRole = (String)request.getParameter("role");
	    	  utils.addUser(dbUser, response);
	      
	      } else if (action.equals("ModifyProfile")) {
	    	  	//don't need to do anything
	    	  
	      } else if (action.equals("UpdateUser")) {
	    	  dbUser.userPswd = (String)request.getParameter("pswd");
	    	  dbUser.newPswd = (String)request.getParameter("newPswd");
	    	  dbUser.confirmPswd = (String)request.getParameter("confirmPswd");

	    	  utils.confirmUser(dbUser, response);
	      }   
	      
//	    Logout
	      else if(action.equals("Logout")){
	         dbUser = null;
	         request.getSession().setAttribute("EUIUser", dbUser);
	         request.getSession().invalidate();
	         String msg = "Logout";
	 	     request.getSession().setAttribute("msg", msg);
	         RequestDispatcher rd = getServletContext().getRequestDispatcher("/web/jsp/login.jsp");
	         try {
	        	 utils = new EUIUtils();
 	        	 getServletContext().setAttribute("EUIUtils", utils);
 	        	 LOGGER.info("IN init()"); 
				 rd.forward(request, response);
				 return;
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        // response.sendRedirect("ControllerServlet?page=exit.jsp");
	        
	      } 
	   

	      
	      //RequestDispatcher rd = request.getRequestDispatcher(loginURL);
	  try {
		  System.out.println(loginURL);
		//request.getRequestDispatcher(loginURL).forward(request, response);
		getServletContext().getRequestDispatcher(loginURL).forward(request, response);
		return;
	} catch (ServletException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	  
	      if (action !=null){
			  System.out.println("Action:" +action);
		  //if (action.equals("Export")) {} 
		  	//else {
		 //rd.forward(request, response);
		  		//getServletContext().getRequestDispatcher("login1.jsp").forward(request, response);
		  	//} 
		  //} else {
		  //rd.forward(request, response);	
			 // getServletContext().getRequestDispatcher("/requestFailed.jsp").forward(request, response);
		  }
		// rd.forward(request, response);
		  //getServletContext().getRequestDispatcher("/requestFailed.jsp").forward(request, response);
	      
	   }



	//private MultipartRequest MultipartRequest(HttpServletRequest request, String string, int i, DefaultFileRenamePolicy policy) {
	
	//private MultipartRequest MultipartRequest(EUIUser request, String string, int i, DefaultFileRenamePolicy policy) {
		// TODO Auto-generated method stub
		//return null;
	//}

	public void destroy() {
	      LOGGER.info("IN destroy()");
	      super.destroy();
	   }
}