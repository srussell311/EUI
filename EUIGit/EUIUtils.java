package com.nsc.eui;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Vector;

import org.apache.catalina.connector.Request;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletResponse;

import com.nsc.dataaccess.ConnectionFactory;
import com.nsc.dataaccess.DataAccessException;
import com.nsc.eui.*;
import com.nsc.utils.Constants;
import com.oreilly.servlet.MultipartRequest;

import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFFooter;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.util.HSSFColor;

//Feb 2018

public class EUIUtils {
   private SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a");  
   
   private Logger LOGGER = Logger.getLogger(com.nsc.eui.EUIUtils.class);
   
   public void getUserLogin(EUIUser dbUser, String reqUserName, String reqUserPswd) {
	      dbUser.setUserLogin(reqUserName);
	      //set userLogin to login name entered
	      
	      /*Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
	         oPStmt = oConn.prepareCall("usp_FMTGetLogin @userN = "+ dbUser.getUserLogin() +
	        		 		", @userP = "+ reqUserPswd+"");
	         oRS = oPStmt.executeQuery();
	         String userA = "";
	         if (oRS.next()) {
	        	userA = oRS.getString("Active");
	            dbUser.setBusinessRole(oRS.getString(3)); // A-Admin, CSR-Customer Service Rep, O-Other, EC-Ecommerce   
	         }
	         
        	 if (userA.equals("Y")){
        		 dbUser.setActive(true);
        	 } else {
        		 dbUser.setActive(false);
        	 }
        	 
//        	IF USER DOESN'T HAVE ADMIN OR ECOMMERCE (EC) ROLE, NOT ALLOWED ACCESS TO APP
        	 if (dbUser.getBusinessRole().equals("A") || dbUser.getBusinessRole().equals("EC")) {
        		 dbUser.setActive(true);
        	 } else {
        		 dbUser.setActive(false);
        	 }
	         
	      } 
	      catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser UserLogin from FormularyUser table for EUI. " + e);
	      } 
	      finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in getUserLogin. " + e);
	            e.printStackTrace();
	         }
	      }*/
	   }
   
   
   public void confirmUser(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;	
	      String actualP = "";
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
	         oPStmt = oConn.prepareCall("usp_FMTConfirmUser @UserLogin = '" + dbUser.getUserLogin()+"'");
	         oRS = oPStmt.executeQuery();
	    	 while (oRS.next()) {
	    	 actualP = oRS.getString("currP");
	         }

	    	 
	    	 if (actualP.equals(dbUser.userPswd)) {
	    	 oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
		     oPStmt = oConn.prepareCall("usp_FMTUpdateUser @UserLogin = '" + dbUser.getUserLogin() +
		    		 "', @UserPswd= '"+ dbUser.newPswd+ "', @PrevPswd = '"+ dbUser.userPswd +
		     "', @fname='', @lname='', @email='', @phone='', @active='', @role='', @maintF='N'," +
    		 " @type='other'");
		     
		     oPStmt.executeUpdate();
	    		 
		     dbUser.userUpdate = "Y";
	    	 } else {
	    		 //no update occurred
	    		 dbUser.userUpdate = "N";
	    	 }
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in confirming user in FormularyUser table for EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::FMTConfirmUser. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   public void addUser(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      String userExist = "";
	      int rowC=0;
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
	         oPStmt = oConn.prepareCall("usp_FMTConfirmUser @UserLogin = '" + dbUser.uName+"'");
	         oRS = oPStmt.executeQuery();
	    	 while (oRS.next()) {
	    	 userExist = oRS.getString("currP"); 
	    	 rowC = oRS.getRow();
	         }
	    	 
	    	 if (rowC==0) { //user doesn't already exist
	    	 oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
		     oPStmt = oConn.prepareCall("usp_FMTAddUser @userN = '" + dbUser.uName +
		    		 "', @userP= '"+ dbUser.uPswd+ "', @role = '"+ dbUser.uRole +"'," +
		    		 "@active = '"+ dbUser.uActive +"'");
		     oPStmt.executeUpdate();
	    		 
		     dbUser.userUpdate = "Y";
	    	 } else {
	    		 //username already exists, user not added
	    		 dbUser.userUpdate = "N";
	    	 }
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in adding user in FormularyUser table for EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIAddUser. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getUserList(EUIUser dbUser) {
	   getVectorUL(dbUser, "usp_FMTGetUsers");
	   }
   
   public void getVectorUL(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.userList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("userName"));  
	            dbUser.userList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for EUI Users. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getCurrDate(EUIUser dbUser, HttpServletResponse response) throws IOException {
	    Connection oConn = null;
	    PreparedStatement oPStmt = null;
	    ResultSet oRS = null;
	    try {
	       oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
	       oPStmt = oConn.prepareCall("usp_FMTGetCurrDate");
	       oRS = oPStmt.executeQuery();
	       while (oRS.next()) {
	          dbUser.currDate = oRS.getString("currDate");
	          dbUser.currDate1 = oRS.getString("currDate1");
	       }
	       
	    } catch (Exception e) {
	       LOGGER.info("Exception in getting dbUser getCurrDate from FMT. " + e);
	    } finally {
	       try {
	          if (oRS != null)
	             oRS.close();
	          if (oPStmt != null)
	             oPStmt.close();
	          if (oConn != null)
	             oConn.close();
	       } catch (SQLException e) {
	          LOGGER.info("SQLException in FMTUtils::getCurrDate. " + e);
	          e.printStackTrace();
	       }
	    }
	}
   
  /* public void getEcommercePlatform(EUIUser dbUser) {
	   getVectorEP(dbUser, "Select Platform, PlatformScreenName from EcommercePlatforms Where ID!=1");
	   //exclude Access platform  11/05/2010 SAP Phase 2
   		}
  
   public void getVectorEP(EUIUser dbUser, String sql) {
	   
	      Connection oConn = null;
	      //PreparedStatement oPStmt = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      dbUser.ecPlatformList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         //oPStmt = oConn.prepareCall(sql);
	         oStmt = oConn.createStatement();
	         //oRS = oPStmt.executeQuery();
	         oRS = oStmt.executeQuery(sql);
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("Platform"));
	            v.add(1, oRS.getString("PlatformScreenName")); 
	            dbUser.ecPlatformList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for Ecommerce Platforms. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            //oPStmt.close();
	            oStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }*/
   
     
   
   public void getNationalAccountList(EUIUser dbUser) {
	   
	   getVectorNAL(dbUser, "usp_EUI_GetNewNationalAccountList @action = '"+dbUser.action+"', @customerNbr = '"+dbUser.customerNumber+"'"); 
	   
	   
	   //dbUser.eplatform = "netsupply";
	  // getVectorNAL(dbUser, "usp_EUI_GetNationalAccountList @Platform='"+dbUser.eplatform+"'");
	   //System.out.println("Get National Account"+dbUser);
	   }
   
   public void getVectorNAL(EUIUser dbUser, String sql) {
	    
	   	  Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      Statement oStmt = null;
	      dbUser.nationalAccountList.clear();
	     
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("CustomerName")); //non-formatted customer #
	            v.add(1, oRS.getString("SoldTo"));
	            //v.add(2, oRS.getString("CustNbr_f")); //formatted customer #
	            //v.add(3, oRS.getString("CustMinNbr")); //customer minor #
	            
	            dbUser.nationalAccountList.add(v);
	         } 
	         
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for NationalAccount or Customer List. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   ////////////////////////////////////////
   public void getPlatformList(EUIUser dbUser) {
	   //System.out.println("ACTION TYPE="+dbUser.action);
	   
	   //getVectorPlatform(dbUser, "usp_EUI_GetEcommercePlatform"); 
	   
	   getVectorPlatform(dbUser, "usp_EUI_GetEcommercePlatform @orderSource = '"+dbUser.orderSource
       		 +"', @action = '"+dbUser.action+"'"); 
	   
	   }
   
   public void getVectorPlatform(EUIUser dbUser, String sql) {
	    
	   	  Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      Statement oStmt = null;
	      dbUser.platform.clear();
	     
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next()){
	            Vector v = new Vector();
	            v.add(0, oRS.getString("Platform"));
	            dbUser.platform.add(v);
	           
	         } 
	         
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for NationalAccount or Customer List. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   
   /////////////////////////////////////////
    
   
   public void getNationalAccountName(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      NationalAccount naAcct = new NationalAccount();
		    	
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         //oRS = oStmt.executeQuery("Select Upper(NatlAcctName) naName, RIGHT('000' + CAST(CustomerMaj as VARCHAR), 3) AS custNbr, SuperUserFlag "+
	        		// "From ecommerce.dbo.nsc_CSR_FromIndura Where CustomerMaj = " + dbUser.nationalAccountNbr+"");
	         //4/26/2010 => no longer using Indura 
	         //oRS = oStmt.executeQuery("Select Upper(CustName) naName, RIGHT('000' + CAST(CustNbr as VARCHAR), 3) AS custNbr, '1' SuperUserFlag "+
	        		 //"From FormularyManagement.dbo.Formulary_CSR Where CustNbr = " + dbUser.nationalAccountNbr+"");
	        // System.out.println("SELECT DISTINCT c.customerName as CustomerName, right('000'+cast(c.custmajnbr AS VARCHAR),3)+cast(c.custminnbr AS VARCHAR) as SoldToFROM SAPFMTIPT.dbo.SAP_Customer c JOIN formularymanagement.dbo.view_Formulary_publishedOG_Header vph on c.CustMajNbr=vph.CustomerMajorLEFT JOIN Ecommerce.dbo.EUI_EcommerceCustomer eec on eec.CustomerMajor=c.CustMajNbr WHERE c.DeleteFlag='N'and c.CompanyCode=2000 and c.CustMinNbr='000000'and eec.SoldTo = "+dbUser.nationalAccountNbr+"");
	    	         		
	         oRS = oStmt.executeQuery("SELECT DISTINCT c.customerName as CustomerName, right('000'+cast(c.custmajnbr AS VARCHAR),3)+cast(c.custminnbr AS VARCHAR) as SoldTo FROM SAPFMTIPT.dbo.SAP_Customer c JOIN formularymanagement.dbo.view_Formulary_publishedOG_Header vph on c.CustMajNbr=vph.CustomerMajor LEFT JOIN Ecommerce.dbo.EUI_EcommerceCustomer eec on eec.CustomerMajor=c.CustMajNbr WHERE c.DeleteFlag='N'and c.CompanyCode=2000 and c.CustMinNbr='000000' and eec.SoldTo = "+dbUser.custMajor+"");
	         
	    	 while (oRS.next()) {
	    	 naAcct.nationalAccountName = oRS.getString("CustomerName");
	    	// System.out.println(naAcct.nationalAccountName);
	    	 naAcct.nationalAccountNbr = oRS.getString("SoldTo");
	    	// System.out.println(naAcct.nationalAccountNbr);
	    	 //naAcct.superBuyerF = oRS.getString("SuperUserFlag");
	         }
	    	 //dbUser.superBuyerF = naAcct.superBuyerF; 
	    	 dbUser.nationalAccountName = naAcct.nationalAccountName;
	    	 dbUser.naNbrF = naAcct.nationalAccountNbr;
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting actual NationalAccount Name from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetCustomerName. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getNationalAccountNameMin(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      NationalAccount naAcct = new NationalAccount(); 
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();

	         oRS = oStmt.executeQuery("Select Right('0000' + CAST(custmajnbr as Varchar),4) custNbr, Upper(CustomerName) nameAcct, upper(Name2) minLocName"
	       	      +" ,s.Zone zone FROM SAPFMTIPT.dbo.SAP_Customer INNER JOIN SAPFMTIPT.dbo.SAP_State s on s.StateAbbr = Region"
	       	      +" WHERE custmajnbr="+dbUser.nationalAccountNbr           
	       	      +" and custminnbr =RIGHT('000000'+ '"+dbUser.nationalAccountNbrMin+"',6)"
	       	      +" and CompanyCode = 2000 and DeleteFlag='N' ");  
	         
	 //"Select Upper(NatlAcctName) naName, RIGHT('000' + CAST(CustomerMaj as VARCHAR), 3) AS custNbr, SuperUserFlag From nsc_CSR_FromIndura Where CustomerMaj = " + dbUser.nationalAccountNbr+"");
	    	 while (oRS.next()) {
	    	 naAcct.nationalAccountName = oRS.getString("nameAcct") +" : "+ oRS.getString("minLocName");
	    	 naAcct.nationalAccountNbr = oRS.getString("custNbr");
	    	 dbUser.zone = oRS.getString("zone");
	    	 //naAcct.superBuyerF = oRS.getString("SuperUserFlag");
	         }
	    	 //dbUser.superBuyerF = naAcct.superBuyerF; 
	    	 dbUser.nationalAccountName = naAcct.nationalAccountName;
	    	 dbUser.naNbrF = naAcct.nationalAccountNbr;
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting actual NationalAccountMin Name from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetCustomerAccountMinName. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getNationalAccountMinNameOnly(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();

	         oRS = oStmt.executeQuery("Select Right('000' + CAST(custmajnbr as Varchar),3) custNbr, Upper(CustomerName) nameAcct, upper(Name2) minLocName"
	       	      +" FROM SAPFMTIPT.dbo.SAP_Customer "
	       	      +" WHERE custmajnbr="+dbUser.nationalAccountNbr           
	       	      +" and custminnbr =RIGHT('000000' +"+dbUser.nationalAccountNbrMin+",6)"
	       	      +" and CompanyCode = 2000 and DeleteFlag='N'");
	    	 while (oRS.next()) {
	    	dbUser.nationalAccountMinName = oRS.getString("minLocName");
	         }
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting NationalAccountMinNameOnly from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetCustomerAccountMinNameOnly. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   public void getMemberList(EUIUser dbUser) {
	   getVectorML(dbUser, "usp_EUI_GetMembers @custMaj = " + dbUser.nationalAccountNbr+", @Platform='"+ dbUser.eplatform+"'");
	   }
   
   public void getVectorML(EUIUser dbUser, String sql) {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.memberList.clear();
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next()) {
	        	 Vector v = new Vector();
	        	 
	        	    v.add(0, oRS.getString("catalogmbrmjr")); //non-formatted mbr #
	        	    v.add(1, oRS.getString("catalogmbrmjr_f")); //formatted mbr #
		            v.add(2, oRS.getString("catalogmbrmin")); //non-formatted mbr minor #
		            v.add(3, oRS.getString("catalogmbrmin_f")); //non-formatted mbr minor #
		            v.add(4, oRS.getString("NameMember")); //member Name
		            
		            dbUser.memberList.add(v);
	         }
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser vector getMemberList from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getMemberList. " + e);
	            e.printStackTrace();
	         }
	      }
   }
   
   
   public void getMemberListNewAcct(EUIUser dbUser) {
	   
	   getVectorMLNA(dbUser, "SELECT DISTINCT m.mbrmajnbr, m.mbrminnbr, Upper(m.MemberName) namemember,"
			   +" RIGHT('000' + CAST(m.mbrmajnbr as VARCHAR), 3) mbrmajnbr_f,"
			   +" RIGHT('00' + CAST(m.mbrminnbr as VARCHAR), 2) mbrminnbr_f"
			   +" FROM SAPFMTIPT.dbo.SAP_customer c "
			   +" INNER JOIN SAPFMTIPT.dbo.SAP_CustomerVendor cm on cm.CustMaj = RIGHT('0000' +'"+dbUser.nationalAccountNbr+"', 4)"
			   +" and cm.CustMin = c.CustMinNbr INNER JOIN SAPFMTIPT.dbo.sap_Member m ON cm.MbrMaj=m.MbrMajNbr"
			   +" and m.MbrMinNbr = cm.MbrMin WHERE c.CompanyCode = 2000 and m.CompanyCode = 2000 "
			   +" AND (m.mbrmajnbr !=500 and m.mbrmajnbr !=999) AND c.custMajNbr="+dbUser.nationalAccountNbr);
	   
   //get list of associated member ONLY based on customer # - no join with ALP or NLP table - new account
  //so record in alp or nlp table doesn't exist at this time
   }
   
   public void getVectorMLNA(EUIUser dbUser, String sql) {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      dbUser.memberList.clear();
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         oRS = oStmt.executeQuery(sql);
	         while (oRS.next()) {
	        	 Vector v = new Vector();
	        	 
	        	    v.add(0, oRS.getString("mbrmajnbr")); //non-formatted mbr #
	        	    v.add(1, oRS.getString("mbrmajnbr_f")); //formatted mbr #
		            v.add(2, oRS.getString("mbrminnbr")); //non-formatted mbr minor #
		            v.add(3, oRS.getString("mbrminnbr_f")); //non-formatted mbr minor #
		            v.add(4, oRS.getString("namemember")); //member Name
		            
		            dbUser.memberList.add(v);
	         }
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser vector getMemberList from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getMemberList. " + e);
	            e.printStackTrace();
	         }
	      }
   }

   
   public void getMemberListByCustomer(EUIUser dbUser) {
	   getVectorMLNNA(dbUser, "usp_EUI_GetMembersByCustomer @custMaj = " + dbUser.nationalAccountNbr
			   +", @Platform="+dbUser.eplatform);
	   
	   //LOGGER.info("usp_EUI_GetMembersByCustomer @custMaj = " + dbUser.nationalAccountNbr
			 //  +", @Platform="+dbUser.eplatform);
	   }
   
   public void getVectorMLNNA(EUIUser dbUser, String sql) {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.memberList.clear();
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next()) {
	        	 Vector v = new Vector();
	        	 
	        	    v.add(0, oRS.getString("mbrmaj")); //non-formatted mbr #
	        	    v.add(1, oRS.getString("mbrmajnbr_f")); //formatted mbr #
		            v.add(2, oRS.getString("mbrmin")); //non-formatted mbr minor #
		            v.add(3, oRS.getString("mbrminnbr_f")); //non-formatted mbr minor #
		            v.add(4, oRS.getString("namemember")); //member Name
		            
		            dbUser.memberList.add(v);
	         }
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser vector getMemberListByCustomer from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getMemberListByCustomer. " + e);
	            e.printStackTrace();
	         }
	      }
   }
   
   
   //for super buyer functionality EUI 2.0
   public void getMemberListByCustomerSB(EUIUser dbUser) {
	   getVectorMLNNASB(dbUser, "usp_EUI_GetMembersByCustomerSB @custMaj = " + dbUser.nationalAccountNbr
			   +", @Platform="+dbUser.eplatform);
	   }
   
   public void getVectorMLNNASB(EUIUser dbUser, String sql) {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.memberList.clear();
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next()) {
	        	 Vector v = new Vector();
	        	 
	        	    v.add(0, oRS.getString("mbrmaj")); //non-formatted mbr #
	        	    v.add(1, oRS.getString("mbrmajnbr_f")); //formatted mbr #
		            v.add(2, oRS.getString("mbrmin")); //non-formatted mbr minor #
		            v.add(3, oRS.getString("mbrminnbr_f")); //non-formatted mbr minor #
		            v.add(4, oRS.getString("namemember")); //member Name
		            
		            dbUser.memberList.add(v);
	         }
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser vector getMemberListByCustomerSB from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getMemberListByCustomerSB. " + e);
	            e.printStackTrace();
	         }
	      }
   }
   
   
   public void getDashboard(EUIUser dbUser) {
	   getVectorDashboard(dbUser, "usp_EUI_GetDashboard");
	   }
   
   public void getVectorDashboard(EUIUser dbUser, String sql) {    /////////////////////////DASHBOARD Code Block
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.reportList.clear();
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         
	         Statement oStmt1 =null;
	         ResultSet oRS1 = null;
	         oStmt1 = oConn.createStatement();
	         
	         while (oRS.next()) {
	        	 Vector v = new Vector();
	        	 
	        	    v.add(0, oRS.getString("Action")); 
	        	    v.add(1, oRS.getString("CustomerMaj")); 
		            v.add(2, oRS.getString("CustomerMin"));
		            v.add(3, oRS.getString("MemberMaj")); 
		            v.add(4, oRS.getString("MemberMin")); 
		            v.add(5, oRS.getString("PrevMemberMaj")); 
		            v.add(6, oRS.getString("PrevMemberMin")); 
		            v.add(7, oRS.getString("UpdateDate")); 
		            v.add(8, oRS.getString("CustMin"));  //formatted customer minor#
		            
		            ///////////////Unprocessed Orders
		          //  v.add(9, oRS.getString("ShipTo")); 
		           // v.add(10, oRS.getString("DateCreated")); 
		           // v.add(11, oRS.getString("E2WOrder")); 
		           // v.add(12, oRS.getString("OrderTotal")); 
		            
		            //////////////
		            
		            
		            dbUser.reportList.add(v);
	         }
	        
	         
	         ///New code for Unproccessed Orders Vector S.R.////
	       /* oRS1 = oStmt1.executeQuery("");
	         while (oRS1.next()){
	        	 Vector v1 = new Vector();
	        	 
	        	 	v1.add(0, oRS.getString("")); 
	        	 	v1.add(1, oRS.getString(""));
	        	 	v1.add(2, oRS.getString(""));
	        	 	v1.add(3, oRS.getString(""));
	        	 	v1.add(4, oRS.getString(""));
	        	 	v1.add(5, oRS.getString(""));
	        	 	v1.add(6, oRS.getString(""));
	        	 	v1.add(7, oRS.getString(""));
	        	 	
	        	 	dbUser.reportList.add(v1);
	        	 
	         }*/
	         
	       ///New code for Unable to Punch Out Vector S.R.////
	        /* oRS1 = oStmt1.executeQuery("");
	         while (oRS1.next()){
	        	 Vector v2 = new Vector();
	        	 
	        	 	v2.add(0, oRS.getString("")); 
	        	 	v2.add(1, oRS.getString(""));
	        	 	v2.add(2, oRS.getString(""));
	        	 	v2.add(3, oRS.getString(""));
	        	 	v2.add(4, oRS.getString(""));
	        	 	v2.add(5, oRS.getString(""));
	        	 	v2.add(6, oRS.getString(""));
	        	 	v2.add(7, oRS.getString(""));
	        	 	
	        	 	dbUser.reportList.add(v2);
	        	 
	         }*/
	         
	         ///New code for Unable to Punch Out Vector S.R.////
	        /* oRS1 = oStmt1.executeQuery("");
	         while (oRS1.next()){
	        	 Vector v2 = new Vector();
	        	 
	        	 	v2.add(0, oRS.getString("")); 
	        	 	v2.add(1, oRS.getString(""));
	        	 	v2.add(2, oRS.getString(""));
	        	 	v2.add(3, oRS.getString(""));
	        	 	v2.add(4, oRS.getString(""));
	        	 	v2.add(5, oRS.getString(""));
	        	 	v2.add(6, oRS.getString(""));
	        	 	v2.add(7, oRS.getString(""));
	        	 	
	        	 	dbUser.reportList.add(v2);
	        	 
	         } */
	      ///New code for Jobs Vector S.R.////
	         /*oRS1 = oStmt1.executeQuery("");
	         while (oRS1.next()){
	        	 Vector v3 = new Vector();
	        	 
	        	 	v3.add(0, oRS.getString("")); 
	        	 	v3.add(1, oRS.getString(""));
	        	 	v3.add(2, oRS.getString(""));
	        	 	v3.add(3, oRS.getString(""));
	        	 	v3.add(4, oRS.getString(""));
	        	 	v3.add(5, oRS.getString(""));
	        	 	v3.add(6, oRS.getString(""));
	        	 	v3.add(7, oRS.getString(""));
	        	 	
	        	 	dbUser.reportList.add(v3);
	        	 
	         }*/
	         
	       ///New code for New Locations S.R.////
	        /* oRS1 = oStmt1.executeQuery("");
	         while (oRS1.next()){
	        	 Vector v4 = new Vector();
	        	 
	        	 	v4.add(0, oRS.getString("")); 
	        	 	v4.add(1, oRS.getString(""));
	        	 	v4.add(2, oRS.getString(""));
	        	 	v4.add(3, oRS.getString(""));
	        	 	v4.add(4, oRS.getString(""));
	        	 	v4.add(5, oRS.getString(""));
	        	 	v4.add(6, oRS.getString(""));
	        	 	v4.add(7, oRS.getString(""));
	        	 	
	        	 	dbUser.reportList.add(v4);
	        	 
	         }*/
	         
	         
	         ///End New code S.R.////  
	         
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser vector getDashboard from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getDashboard. " + e);
	            e.printStackTrace();
	         }
	      }
   }
   
   
   public void getCompanyCode(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      NationalAccount natAcct = new NationalAccount();
	      try {	    	   
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         oRS = oStmt.executeQuery("Select NewCompanyCode = max(CompanyCode)+1 from "+dbUser.eplatform+"LocationProperties");
	         while (oRS.next()) {
	            natAcct.companyCode = oRS.getString("NewCompanyCode");
	         }
	         dbUser.companyCode = natAcct.companyCode;
	         
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser companyCode from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getCompanyCode. " + e);
	            e.printStackTrace();
	         }
	      }
}

   /*public void validateSQLNewAccount(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      int recordC = 0;
	      NationalAccount natAcct = new NationalAccount();
	      try {	    	   
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         oRS = oStmt.executeQuery(dbUser.validateSQL);
	         while (oRS.next()) {
	            recordC = oRS.getRow();
	         }
	         if (recordC ==0 || recordC >0) {
	        	 //records returned
	        	 dbUser.validSQLF = "Y";
	         }
	         
	         //LOGGER.info("Validating SQL # of records "+recordC);
	         
	      } catch (Exception e) {
	         LOGGER.info("Exception in validating SQL. " + e);
	         dbUser.validSQLF = "N";
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::validateSQL for New National Account. " + e);
	            dbUser.validSQLF = "N";
	            e.printStackTrace();
	         }
	      }
}*/
   
   public void saveNationalAccount(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      
	     // System.out.println(dbUser.acctActive);
	   // System.out.println(dbUser.nsacctActive);
	     // System.out.println(dbUser.activeCheck);
	   // System.out.println(dbUser.activeCheckNS);
	      //Statement oStmt = null; ///////Added for testing SR 4/13
	     // ResultSet oRS = null;/////////Added for testing SR 4/13
		    	
	      try {
	    	  
	    	 // System.out.println(dbUser.orderSource);
	    	 // System.out.println(dbUser.catView);
	    	 // System.out.println(dbUser.nscatView);
	       		 //+", @custNbrMin ="+dbUser.nationalAccountNbrMin
     		 //+", @memMaj="+dbUser.selMember
     		 //+", @memMin="+dbUser.memberMinNbr
     		 ///////New Variables for New Account S.R. 4/6/18//////

	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	        /* oPStmt = oConn.prepareCall("usp_EUI_GetNationalAccountUpdate @action ='"+dbUser.action
	         		 +"', @custMaj ='"+dbUser.custMajor
	         		 +"', @soldTo ="+dbUser.soldTo
	         		 +", @orderSource='"+dbUser.orderSource
	         		 +"', @nsacctActive='"+dbUser.nsacctActive
	         		 +"', @nsddMT='"+dbUser.nsddMT
	         		 +"', @nscustLocNbr='"+dbUser.nscustLocNbr
	         		 +"', @nscustURL='"+dbUser.nscustURL
	         		 +"', @nslaunchDate='"+dbUser.nslaunchDate
	         		 +"', @nsaddNotes='"+dbUser.nsaddNotes
	         		 +"', @nsimgUsed='"+dbUser.nsimgUsed
	         		 +"', @nsenrichMent='"+dbUser.nsenrichMent
	         		 +"', @nsdualOrdGuide='"+dbUser.nsdualOrdGuide
	         		 +"', @nscatView='"+dbUser.nscatView
	         		 +"', @nssDs='"+dbUser.nssDs
	         		 +"', @nsbarCodes='"+dbUser.nsbarCodes
	         		 +"', @nsauthContact='"+dbUser.nsauthContact
	         		 +"', @nscontactEmail='"+dbUser.nscontactEmail
	         		 +"', @nsccLogin='"+dbUser.nsccLogin
	         		 +"', @nscorpApproval='"+dbUser.nscorpApproval
	         		 +"', @nsitemApproval='"+dbUser.nsitemApproval
	         		 +"', @nsitemApprovalNote='"+dbUser.nsitemApprovalNote 
	         		 +"', @nsadminPOEmail='"+dbUser.nsadminPOEmail
	         		 +"', @nsadminEmail='"+dbUser.nsadminEmail
	         		 +"', @nshidePrice='"+dbUser.nshidePrice 
	         		 +"', @nsuserNamesText='"+dbUser.nsuserNamesText
	         		 +"', @nsuserPasswordText='"+dbUser.nsuserPasswordText
	         		 +"', @nsfavList='"+dbUser.nsfavList
	         		 +"', @nsfavListNote='"+dbUser.nsfavListNote
	         		 +"', @nscleanupFlag='"+dbUser.nscleanupFlag
	         		 +"', @nsssoCustomer='"+dbUser.nsssoCustomer
	         		 +"', @nsssoNotes='"+dbUser.nsssoNotes
	         		 +"', @nspunchOut='"+dbUser.nspunchOut
	         		 +"', @nsnetworkID='"+dbUser.nsnetworkID
	         		 +"', @nscustomerID='"+dbUser.nscustomerID
	         		 +"', @nspunchOutType='"+dbUser.nspunchOutType
	         		 +"', @nssharedSecret='"+dbUser.nssharedSecret
	         		 +"', @nspunchoutProvider='"+dbUser.nspunchoutProvider
	         		 +"', @nsproviderCode='"+dbUser.nsproviderCode
	         		 +"', @nscXml='"+dbUser.nscXml 
	         		 +"', @nsfullPunchOut='"+dbUser.nsfullPunchOut
	         		 +"', @nsaddPunchOut='"+dbUser.nsaddPunchOut
	         		 +"', @nsnetworkID1='"+dbUser.nsnetworkID1
	         		 +"', @nscustomerID1='"+dbUser.nscustomerID1
	         		 +"', @nspunchOutType1='"+dbUser.nspunchOutType1
	         		 +"', @nssharedSecret1='"+dbUser.nssharedSecret1
	         		 +"', @nspunchoutProvider1='"+dbUser.nspunchoutProvider1
	         		 +"', @nsproviderCode1='"+dbUser.nsproviderCode1
	         		 +"', @nscXml1='"+dbUser.nscXml1 
	         		 +"', @nsfullPunchOut1='"+dbUser.nsfullPunchOut1
	         		 +"', @acctActive='"+dbUser.acctActive
	         		 +"', @ddMT='"+dbUser.ddMT
	         		 +"', @imgUsed='"+dbUser.imgUsed
	         		 +"', @enrichMent='"+dbUser.enrichMent
	         		 +"', @sDs='"+dbUser.sDs
	         		 +"', @barCodes='"+dbUser.barCodes
	         		 +"', @catView='"+dbUser.catView
	         		 +"', @addNotes='"+dbUser.addNotes
	         		 +"', @ediLaunch='"+dbUser.ediLaunch 
	        		 +"', @userLogin='"+dbUser.getUserLogin()+"'");*/
	         
	         oPStmt = oConn.prepareCall("usp_EUI_GetNationalAccountUpdate @action ='"+dbUser.action
	         		 +"', @CustomerMajor  ="+dbUser.soldTo
	         		 +", @SoldTo ='"+dbUser.custMajor 
	         		 +"', @Platform='"+dbUser.orderSource
	         		 +"', @NetworkImagesProvided='"+dbUser.nsimgUsed
	         		 +"', @NetworkEnrichmentProvided='"+dbUser.nsenrichMent
	         		 +"', @NetworkSDSProvided='"+dbUser.nssDs
	         		 +"', @NetworkBarcodesProvided='"+dbUser.nsbarCodes
	         		 +"', @CatalogSetup='"+dbUser.nscatView
	         		 +"', @DisplayLocID='"+dbUser.nscustLocNbr
	         		 +"', @UserCorpApprovalRequired='"+dbUser.nscorpApproval
	         		 +"', @UserCorpApprovalEmail='"+dbUser.nscontactEmail
	         		 +"', @UserCorpApproverCopiedOnLogin='"+dbUser.nsccLogin
	         		 +"', @ItemCorpApprovalRequired='"+dbUser.nsitemApproval
	         		 +"', @ItemCorpApprovalEmail='"+dbUser.nsitemApprovalNote
	         		 +"', @CustomerAdmins='"+dbUser.nsauthContact
	         		 +"', @CustomerAdminsCopiedOnEmails='"+dbUser.nsadminEmail
	         		 +"', @UsernameTemplate='"+dbUser.nsuserNamesText
	         		 +"', @PasswordTemplate='"+dbUser.nsuserPasswordText
	         		 +"', @NetSupplyURLOnCustIntranet='"+dbUser.nscustURL
	         		 +"', @NetSupplyMultipleCatalogCustomer='"+dbUser.nsdualOrdGuide
	         		 +"', @EcommerceLaunchDate='"+dbUser.nslaunchDate
	         		 +"', @UserCleanupFlag='"+dbUser.nscleanupFlag
	         		 +"', @Notes='"+dbUser.nsaddNotes
	         		 +"', @IsActiveDDMT='"+dbUser.nsddMT
	         		 +"', @StartupFavoriteListFlag='"+dbUser.nsfavList
	         		 +"', @StartupFavoriteList='"+dbUser.nsfavListNote
	        		 +"', @CreatedBy='"+dbUser.getUserLogin() 
	        		 +"', @nsacctActive='"+dbUser.nsacctActive
	        		
	         		 +"', @NetworkImagesProvided1='"+dbUser.imgUsed
	         		 +"', @NetworkEnrichmentProvided1='"+dbUser.enrichMent
	         		 +"', @NetworkSDSProvided1='"+dbUser.sDs
	         		 +"', @NetworkBarcodesProvided1='"+dbUser.barCodes
	         		 +"', @CatalogSetup1='"+dbUser.catView
	         		 +"', @EcommerceLaunchDate1='"+dbUser.ediLaunch
	         		 +"', @Notes1='"+dbUser.addNotes
	         		 +"', @IsActiveDDMT1='"+dbUser.ddMT
	         		 +"', @ediacctActive='"+dbUser.acctActive
	         		                       											//////// +"', @nsadminPOEmail='"+dbUser.nsadminPOEmail
 																					////////+"', @nshidePrice='"+dbUser.nshidePrice 
	        		 +"', @PunchoutProvider='"+dbUser.nspunchoutProvider
	        		 +"', @Type='"+dbUser.nspunchOutType
	        		 +"', @PunchoutProviderCode='"+dbUser.nsproviderCode
	        		 +"', @NetworkIdentity='"+dbUser.nsnetworkID
	        		 +"', @CustomerIdentity='"+dbUser.nscustomerID
	        		 +"', @SharedSecret='"+dbUser.nssharedSecret
	        		 +"', @LocExchanged='"+dbUser.nscXml
	        		 +"', @Notes='"+dbUser.nsfullPunchOut
	        		 +"', @IsActive='"+dbUser.nspunchOut

	         		 +"', @PunchoutProvider1='"+dbUser.nspunchoutProvider1
	         		 +"', @nspunchOutType1='"+dbUser.nspunchOutType1
	         		 +"', @PunchoutProviderCode1='"+dbUser.nsproviderCode1
	         		 +"', @NetworkIdentity1='"+dbUser.nsnetworkID1
	         		 +"', @CustomerIdentity1='"+dbUser.nscustomerID1
	         		 +"', @SharedSecret1='"+dbUser.nssharedSecret1
	         		 +"', @LocExchanged1='"+dbUser.nscXml1
	         		 +"', @Notes2='"+dbUser.nsfullPunchOut1
	         		 +"', @IsActive1='"+dbUser.nsaddPunchOut 
	         		
	         		 +"', @nsssoCustomer='"+dbUser.nsssoCustomer
	         		 +"', @nsssoNotes='"+dbUser.nsssoNotes+"'");
	         
	         		oPStmt.executeUpdate();
	         		
	         	  //System.out.println(dbUser.orderSource);
	   	    	  //System.out.println(dbUser.catView);
	   	    	  //System.out.println(dbUser.nscatView);
	         
	         		
	         if((dbUser.acctActive != dbUser.activeCheck)||(dbUser.nsacctActive != dbUser.activeCheckNS)){
	        	         /////////////////This is the new stored proc created by Cheryl to update new locations
	        	  oPStmt = oConn.prepareCall("ups_EUI_NetSupply_NewAndUpdatedLocations");
	        	  oPStmt.execute();
	         }
	         
	         if(dbUser.nscatView.equals("Y") & dbUser.orderSource.equals("NetSupply")){
	         /////////////////This is the new stored proc created by Cheryl to update new locations
	        	 oPStmt = oConn.prepareCall("ups_EUI_NetSupply_NewAndUpdatedLocations");
	        	 oPStmt.execute();
	         }
	         
	         if(dbUser.nscatView.equals("N") & dbUser.orderSource.equals("NetSupply")){
	        	 oPStmt = oConn.prepareCall("ups_EUI_NetSupply_NewAndUpdatedLocations");
	        	 oPStmt.execute();
	         }
	        		 
	        
	        if(dbUser.catView.equals("Y") & !dbUser.orderSource.equals("NetSupply")){
	        	oPStmt = oConn.prepareCall("ups_EUI_NetSupply_NewAndUpdatedLocations");
	        	oPStmt.execute();
	        }
	         
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in saving new NationalAccount in EUI. " + e);
	      } finally {
	         try {
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUISaveNationalAccount. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
  //used for updating National Accounts
   
   //initial list of active national accounts & platform - no filter
   public void getNationalAccountListEC(EUIUser dbUser) {
	  // System.out.println("usp_EUI_GetActiveNationalAccountList @natAcct ='"+dbUser.customerNumber+"', @action = '"+dbUser.action+"'");
	  // getVectorNALEC(dbUser, "usp_EUI_GetNationalAccountListPlatform");
	   getVectorNALEC(dbUser, "usp_EUI_GetActiveNationalAccountList @natAcct ='"+dbUser.customerNumber+"', @action = '"+dbUser.action+"'");
	   
	   }
   
   public void getVectorNALEC(EUIUser dbUser, String sql) {
	    	//System.out.println(sql);
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.nationalAccountList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("CustomerName")); //non-formatted customer #
	            v.add(1, oRS.getString("SoldTo")); //formatted customer #
	           // v.add(2, oRS.getString("custName"));
	            //v.add(3, oRS.getString("platformName"));
	            
	            dbUser.nationalAccountList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for NationalAccount & ecommerce platform for Update. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   
   public void getMemberName(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      Member mem = new Member();
		    	
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
	         oPStmt = oConn.prepareCall("usp_FMTGetMemberNameO @MemberID = " + dbUser.memberNbr
	        		 +", @MemberMin="+dbUser.memberMinNbr+"");
	         
	         oRS = oPStmt.executeQuery();
	    	 while (oRS.next()) {
	    	 mem.memberName = oRS.getString("memName");
	    	 mem.memberNbr = oRS.getString("MemNbr_f"); //formatted member number to display
	    	 mem.memberMinNbr = oRS.getString("MemMin_f"); //formatted member minor number to display
	         }
	    	 dbUser.memberName = mem.memberName;
	    	 dbUser.memNbrF = mem.memberNbr;
	    	 dbUser.memMinNbrF = mem.memberMinNbr; 
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting actual Member Name & # from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetMemberName. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   //new 4/26/2011
   public void getMemberByCustomerLoc(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      Member mem = new Member();
		    	
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall("usp_EUI_GetCustomerMemberAssoc @CustMaj = " + dbUser.nationalAccountNbr
	        		 +", @CustMin="+dbUser.nationalAccountNbrMin+"");
	         
	         oRS = oPStmt.executeQuery();
	    	 while (oRS.next()) {
	    	 mem.memberName = oRS.getString("memName");
	    	 mem.memberNbr = oRS.getString("memNbr"); //formatted member number to display
	    	 mem.memberMinNbr = oRS.getString("memMinNbr"); //formatted member minor number to display
	         }
	    	 dbUser.memberName = mem.memberName;
	    	 dbUser.memNbrF = mem.memberNbr;
	    	 dbUser.memMinNbrF = mem.memberMinNbr; 
	    	 
	    	 dbUser.memberNbr = mem.memberNbr;
	    	 dbUser.memberMinNbr = mem.memberMinNbr;
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting member name & # associated to customer location from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetMemberByCustomerLoc. " + e);
	            e.printStackTrace();
	         }
	      }
	   }

   
   
   public void getNationalAccountDtl(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;  /////////////////This is the stored proc. the pulls back results for existing Nat. Accounts -- SR 4/13/2018
	      //PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      NationalAccount natAcct = new NationalAccount();
	      Statement oStmt = null;
	      
	      Connection oConn1 = null; 
	      ResultSet oRS1 = null;
	      Statement oStmt1 = null;
     
	      	//System.out.println();
	     // PreparedStatement oPStmt = null;
	      	int custlength = dbUser.custMajor.length();
	      	
	      	if(custlength != 10){
	      		dbUser.custMajor = "0" + dbUser.custMajor;
	      		//System.out.println(dbUser.custMajor);
	      	}
	      	
	      	
		    	
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	        // System.out.println(dbUser.nationalAccountNbr);
	         oStmt = oConn.createStatement();
	         //System.out.println("Select * From dbo.EUI_EcommerceCustomer Where SoldTo = '"+dbUser.custMajor+"'");
	         oRS = oStmt.executeQuery("Select * From dbo.EUI_EcommerceCustomer Where SoldTo = '"+dbUser.custMajor+"'");
	    	 while (oRS.next()) {
	    		 	///Variables for Punchout National Accounts
	    	 natAcct.nationalAccountNbr = oRS.getString("CustomerMajor");
	    	// System.out.println(natAcct.nationalAccountNbr);
	    	 natAcct.nsacctActive = oRS.getString("IsActiveNetSupply");
	    	 natAcct.acctActive = oRS.getString("IsActiveNetSupply");
	    	 natAcct.soldTo = oRS.getString("SoldTo");
	    	// System.out.println(natAcct.soldTo);
	    	 natAcct.orderSource = oRS.getString("Platform");
	    	 natAcct.ddMT = oRS.getString("IsActiveDDMT");
	    	 natAcct.imgUsed = oRS.getString("NetworkImagesProvided");
	    	 natAcct.enrichMent = oRS.getString("NetworkEnrichmentProvided");
	    	 natAcct.sDs = oRS.getString("NetworkSDSProvided");    
	    	 natAcct.barCodes = oRS.getString("NetworkBarcodesProvided");
	    	 natAcct.catView = oRS.getString("CatalogSetup");
	    	 natAcct.ediLaunch = oRS.getString("EcommerceLaunchDate");
	    	 if(!natAcct.ediLaunch.equals("")){
	    	 String year = natAcct.ediLaunch.substring(0, 4);
	          // System.out.println(year);
	           String month = natAcct.ediLaunch.substring(5, 7);
	          // System.out.println(month);
	           String day = natAcct.ediLaunch.substring(8, 10);
	          // System.out.println(day);
	           natAcct.ediLaunch = month +"-"+day+"-"+year;
	          // System.out.println(natAcct.ediLaunch);
	    	 }
	    	 ////Variables for NetSupply Accounts
	    	 natAcct.nsuserNamesText = oRS.getString("UsernameTemplate");
	    	 natAcct.nsuserPasswordText = oRS.getString("PasswordTemplate");
	    	 natAcct.nsddMT = oRS.getString("IsActiveDDMT"); 
	    	 natAcct.nscustLocNbr = oRS.getString("DisplayLocID"); 
	    	 natAcct.nscustURL = oRS.getString("NetSupplyURLOnCustIntranet");
	    	 natAcct.nslaunchDate = oRS.getString("EcommerceLaunchDate");
	    	 if(!natAcct.nslaunchDate.equals("")){
		    	 String year = natAcct.nslaunchDate.substring(0, 4);
		          // System.out.println(year);
		           String month = natAcct.nslaunchDate.substring(5, 7);
		           //System.out.println(month);
		           String day = natAcct.nslaunchDate.substring(8, 10);
		           //System.out.println(day);
		           natAcct.nslaunchDate = month +"-"+day+"-"+year;
		           //System.out.println(natAcct.nslaunchDate);
		    	 }
	    	 natAcct.nsaddNotes = oRS.getString("Notes"); //???
	    	 natAcct.addNotes = oRS.getString("Notes");
	    	 natAcct.nsimgUsed = oRS.getString("NetworkImagesProvided");
	    	 natAcct.nsenrichMent = oRS.getString("NetworkEnrichmentProvided"); 
	    	 natAcct.nssDs = oRS.getString("NetworkSDSProvided");
	    	 natAcct.nsbarCodes = oRS.getString("NetworkBarcodesProvided");
	    	 natAcct.nsdualOrdGuide = oRS.getString("NetSupplyMultipleCatalogCustomer");
	    	 natAcct.nscatView = oRS.getString("CatalogSetup");
	    	 natAcct.nscontactEmail = oRS.getString("UserCorpApprovalEmail");
	    	 natAcct.nsauthContact = oRS.getString("CustomerAdmins");
	    	 if(natAcct.nscontactEmail == null){
	    		 natAcct.nscontactEmail = "";
	    	 }
	    	 natAcct.nsccLogin = oRS.getString("UserCorpApproverCopiedOnLogin");
	    	 if(natAcct.nsccLogin == null){
	    		 natAcct.nsccLogin = "";
	    	 }
	    	 natAcct.nscorpApproval = oRS.getString("UserCorpApprovalRequired");
	    	 natAcct.nsitemApproval = oRS.getString("ItemCorpApprovalRequired");
	    	// natAcct.nsadminPOEmail = oRS.getString("CustomerAdmins");
	    	 natAcct.nsadminEmail = oRS.getString("CustomerAdminsCopiedOnEmails");
	    	 natAcct.nshidePrice = "";
	    	 natAcct.nsitemApprovalNote = oRS.getString("ItemCorpApprovalEmail");
	    	 if(natAcct.nsitemApprovalNote == null){
	    		 natAcct.nsitemApprovalNote = "";
	    	 }

	    	 natAcct.nsuserNames = oRS.getString("UsernameTemplate");
	    	 natAcct.nsuserPassword = oRS.getString("PasswordTemplate");
	    	 natAcct.nsfavList = "";
	    	 natAcct.nsfavListNote = oRS.getString("StartupFavoriteList");
	    	 if(natAcct.nsfavListNote == null){
	    		 natAcct.nsfavListNote = "";
	    	 }
	    	 natAcct.nscleanupFlag = oRS.getString("UserCleanupFlag");
	    	 }
	    	  
	    	/* oRS = oStmt.executeQuery("Select COUNT (CustomerMajor) as CustomerMajorCount From dbo.EUI_NetSupplyPunchoutSSO Where CustomerMajor  = '"+natAcct.nationalAccountNbr+"'");
	    	 while (oRS.next()) {
	    		 String pnhcount = oRS.getString("CustomerMajorCount");
	    		 System.out.println(pnhcount);
	    	 }*/
	    	 	//////Query for SSO/PunchOut customer
	    	 	//System.out.println(natAcct.nationalAccountNbr);
	    	
	    	 int x = 1;
	    	 int y = 1;
	    	 String yy = "1";
	    	 oRS = oStmt.executeQuery("Select * From dbo.EUI_NetSupplyPunchoutSSO Where CustomerMajor  = '"+natAcct.nationalAccountNbr+"'");
	    	 while (oRS.next()) { 
	    	 
	    	 natAcct.nspunchOut = oRS.getString("IsActive");
	    	 natAcct.nspunchOutType = oRS.getString("Type");
	    	 natAcct.nssharedSecret = oRS.getString("SharedSecret");
	    	 natAcct.nspunchoutProvider = oRS.getString("PunchoutProvider");
	    	 natAcct.nsnetworkID = ("NetworkIdentity");
	    	 natAcct.nscustomerID = ("CustomerIdentity");
	    	 natAcct.nsproviderCode = oRS.getString("PunchoutProviderCode");
	    	 natAcct.nscXml = oRS.getString("LocExchanged");
	    	 natAcct.nsfullPunchOut = oRS.getString("Notes");
	    	 x++;
	    	// System.out.println("Select * From dbo.EUI_NetSupplyPunchoutSSO Where CustomerMajor  = '"+natAcct.nationalAccountNbr+"' and PunchoutProvider != '"+natAcct.nspunchoutProvider+"'");
	    	 oStmt1 = oConn.createStatement();	
	    	 oRS1 = oStmt1.executeQuery("Select * From dbo.EUI_NetSupplyPunchoutSSO Where CustomerMajor  = '"+natAcct.nationalAccountNbr+"' and PunchoutProvider != '"+natAcct.nspunchoutProvider+"'");
	    	 		while (oRS1.next()) { 
	    	 			 natAcct.nspunchOut1 = oRS1.getString("IsActive");
	    		    	 natAcct.nspunchOutType1 = oRS1.getString("Type");
	    		    	 natAcct.nssharedSecret1 = oRS1.getString("SharedSecret");
	    		    	 natAcct.nspunchoutProvider1 = oRS1.getString("PunchoutProvider");
	    		    	 natAcct.nsnetworkID1 = oRS1.getString("NetworkIdentity");
	    		    	 natAcct.nscustomerID1 = oRS1.getString("CustomerIdentity");
	    		    	 natAcct.nsproviderCode1 = oRS1.getString("PunchoutProviderCode");
	    		    	 natAcct.nscXml1 = oRS1.getString("LocExchanged");
	    		    	 natAcct.nsfullPunchOut1 = oRS1.getString("Notes");
	    		    	 y++;
	    	 		}
	    	 }
	    	 
	    	 if(x==1){
	    		 
		    	 natAcct.nspunchOut = "";
		    	 natAcct.nspunchOutType = "";
		    	 natAcct.nssharedSecret = "";
		    	 natAcct.nspunchoutProvider = "";
		    	 natAcct.nsnetworkID = "";
		    	 natAcct.nscustomerID = "";
		    	 natAcct.nsproviderCode = "";
		    	 natAcct.nscXml = "";
		    	 natAcct.nsfullPunchOut = ""; 
	    	 }
	    	 if(y==1){
		    	 natAcct.nspunchOut1 = "";
		    	 natAcct.nspunchOutType1 = "";
		    	 natAcct.nssharedSecret1 = "";
		    	 natAcct.nspunchoutProvider1 = "";
		    	 natAcct.nsnetworkID1 = "";
		    	 natAcct.nscustomerID1 = "";
		    	 natAcct.nsproviderCode1 = "";
		    	 natAcct.nscXml1 = "";
		    	 natAcct.nsfullPunchOut1 = "";
		    	
	    	 }
	    	 
	    	 if(y==1){
	    		 natAcct.nsaddPunchOut = "N";
	    	 } else{
	    		 natAcct.nsaddPunchOut = "Y"; 
	    	 }
	    		
	    	 dbUser.nsaddPunchOut = natAcct.nsaddPunchOut;
	    	 //System.out.println(dbUser.nsaddPunchOut);
	    	 dbUser.orderSource = natAcct.orderSource;
	    	//System.out.println(dbUser.orderSource);
	    	 dbUser.ddMT = natAcct.ddMT;
	    	// System.out.println(dbUser.ddMT);
	    	 if(dbUser.ddMT == null){
	    		 dbUser.ddMT = "";
	    	 }
	    	 dbUser.imgUsed = natAcct.imgUsed;
	    	 //System.out.println(dbUser.imgUsed);
	    	 dbUser.enrichMent = natAcct.enrichMent;
	    	// System.out.println(dbUser.enrichMent);
	    	 dbUser.sDs = natAcct.sDs;
	    	// System.out.println(dbUser.sDs);
	    	 dbUser.barCodes = natAcct.barCodes;
	    	// System.out.println(dbUser.barCodes);
	    	 dbUser.catView = natAcct.catView;
	    	// System.out.println(dbUser.catView);
	    	 dbUser.nsddMT = natAcct.nsddMT;
	    	 //System.out.println(dbUser.nsddMT);
	    	 dbUser.ediLaunch = natAcct.ediLaunch;
	    	 //System.out.println(dbUser.ediLaunch);
	    	 dbUser.nsddMT = natAcct.nsddMT;
	    	 //System.out.println(dbUser.nsddMT);
	    	 dbUser.nscustLocNbr = natAcct.nscustLocNbr;
	    	 //System.out.println(dbUser.nscustLocNbr);
	    	 dbUser.nscustURL = natAcct.nscustURL;
	    	// System.out.println(dbUser.nscustURL);
	    	 dbUser.nslaunchDate = natAcct.nslaunchDate;
	    	// dbUser.nslaunchDate = subString(0,3);
	    	 dbUser.nsaddNotes = natAcct.nsaddNotes; ///////////////////
	    	// System.out.println(dbUser.nsaddNotes);
	    	 dbUser.addNotes = natAcct.addNotes;
	    	// System.out.println(dbUser.addNotes);
	    	 dbUser.nsimgUsed = natAcct.nsimgUsed;
	    	// System.out.println(dbUser.nsimgUsed);
	    	 dbUser.nsenrichMent = natAcct.nsenrichMent;
	    	// System.out.println(dbUser.nsenrichMent);
	    	 dbUser.nssDs = natAcct.nssDs;
	    	// System.out.println(dbUser.nssDs);
	    	 dbUser.nsbarCodes = natAcct.nsbarCodes;
	    	// System.out.println(dbUser.nsbarCodes);
	    	 dbUser.nsdualOrdGuide = natAcct.nsdualOrdGuide;
	    	// System.out.println(dbUser.nsdualOrdGuide);
	    	 
	    	// System.out.println(dbUser.nscustItemNbr);
	    	 dbUser.nscatView = natAcct.nscatView;
	    	// System.out.println(dbUser.nscatView);
	    	 dbUser.nssDs = natAcct.nssDs;
	    	// System.out.println(dbUser.nssDs);
	    	 dbUser.nsbarCodes = natAcct.nsbarCodes;
	    	// System.out.println(dbUser.nsbarCodes);
	    	 dbUser.nsauthContact = natAcct.nsauthContact;
	    	//System.out.println("");
	    	 if(dbUser.nsauthContact == null){
	    		 dbUser.nsauthContact = "";
	    	 }
	    	// System.out.println(dbUser.nsauthContact);
	    	 dbUser.nscontactEmail = natAcct.nscontactEmail;
	    	// System.out.println(dbUser.nscontactEmail);
	    	 dbUser.nsccLogin = natAcct.nsccLogin;
	    	// System.out.println(dbUser.nsccLogin);
	    	 dbUser.nscorpApproval = natAcct.nscorpApproval;
	    	// System.out.println(dbUser.nscorpApproval);
	    	 dbUser.nsitemApproval = natAcct.nsitemApproval;
	    	// System.out.println(dbUser.nsitemApproval);
	    	 dbUser.nsitemApprovalNote = natAcct.nsitemApprovalNote;
	    	// System.out.println(dbUser.nsitemApprovalNote);
	    	 dbUser.nsadminPOEmail = natAcct.nsadminPOEmail;
	    	// System.out.println(dbUser.nsadminPOEmail);
	    	 dbUser.nsadminEmail = natAcct.nsadminEmail;
	    	 dbUser.nshidePrice = natAcct.nshidePrice;
	    	// System.out.println(dbUser.nshidePrice);
	    	 dbUser.nsuserNames = natAcct.nsuserNames;
	    	// System.out.println(dbUser.nsuserNames);
	    	 dbUser.nsuserPassword = natAcct.nsuserPassword;
	    	// System.out.println(dbUser.nsuserPassword);
	    	 dbUser.nsfavList = natAcct.nsfavList;
	    	// System.out.println(dbUser.nsfavList);
	    	 dbUser.nsfavListNote = natAcct.nsfavListNote;
	    	 if(dbUser.nsfavListNote == null){
	    		 dbUser.nsfavListNote = "";
	    	 }
	    	 dbUser.nscleanupFlag = natAcct.nscleanupFlag;
	    	// System.out.println(dbUser.nscleanupFlag);
	    	 dbUser.nsssoCustomer = natAcct.nsssoCustomer;
	    	 if(dbUser.nsssoCustomer == null){
	    		 dbUser.nsssoCustomer = "";
	    	 }
	    	// System.out.println(dbUser.nsssoCustomer);
	    	 dbUser.nspunchOut = natAcct.nspunchOut;
	    	 //System.out.println(dbUser.nspunchOut);
	    	 dbUser.nspunchOutType = natAcct.nspunchOutType;
	    	// System.out.println(dbUser.nspunchOutType);
	    	 dbUser.nsnetworkID = natAcct.nsnetworkID;
	    	 dbUser.nscustomerID = natAcct.nscustomerID;
	    	 dbUser.nssharedSecret = natAcct.nssharedSecret;
	    	// System.out.println(dbUser.nssharedSecret);
	    	 dbUser.nspunchoutProvider = natAcct.nspunchoutProvider;
	    	// System.out.println(dbUser.nspunchoutProvider);
	    	 dbUser.nsproviderCode = natAcct.nsproviderCode;
	    	// System.out.println(dbUser.nsproviderCode);
	    	 dbUser.nscXml = natAcct.nscXml;
	    	// System.out.println(dbUser.nscXml);
	    	 dbUser.nsfullPunchOut = natAcct.nsfullPunchOut;
	    	 
	    	 dbUser.nsacctActive = natAcct.nsacctActive;
	    	 dbUser.acctActive = natAcct.acctActive;
	    	 
	    	 dbUser.nspunchOut1 = natAcct.nspunchOut1;
	    	 dbUser.nspunchOutType1 = natAcct.nspunchOutType1;
	    	 dbUser.nsnetworkID1 = natAcct.nsnetworkID1;
	    	 dbUser.nscustomerID1 = natAcct.nscustomerID1;
	    	 dbUser.nssharedSecret1 = natAcct.nssharedSecret1;
	    	 dbUser.nspunchoutProvider1 = natAcct.nspunchoutProvider1;
	    	 dbUser.nsproviderCode1 = natAcct.nsproviderCode1;
	    	 dbUser.nscXml1 = natAcct.nscXml1;
	    	 dbUser.nsfullPunchOut1 = natAcct.nsfullPunchOut1;
	    	// System.out.println(dbUser.nsfullPunchOut);
	    	 dbUser.nsuserNamesText = natAcct.nsuserNamesText;
	    	// System.out.println(dbUser.nsuserNamesText);
	    	 dbUser.nsuserPasswordText = natAcct.nsuserPasswordText;
	    	// System.out.println(dbUser.nsuserPasswordText);
	    	 dbUser.nsfavList = natAcct.nsfavList;
	    	// System.out.println(dbUser.nsfavList);
	    	 dbUser.nscleanupFlag = natAcct.nscleanupFlag;
	    	// System.out.println(dbUser.nscleanupFlag);
	    	 
	    	 ///////////////////////////////////////////////Beginning of QUERIES for the View National Accounts Page/////////////////////////////////////////
	    	// System.out.println(dbUser.action);
	    	// System.out.println(dbUser.routeToViewDtl);
	    	 
	    	 if(dbUser.action.equals("viewNADtl")||dbUser.routeToViewDtl.equals("viewNADtl")){   /////////////////Condition to runs these queries only if the View NAtional account has been selected.
	    	 //////SSO USA Clean Query
	    	// System.out.println("SSO USA Clean="+natAcct.nationalAccountNbr);
	    	// System.out.println("Select COUNT (CustomerMaj) as SSOcount From dbo.USAClean_NetSupply_Customers where CustomerMaj = '"+natAcct.nationalAccountNbr+"'");
	    	 oRS = oStmt.executeQuery("Select COUNT (CustomerMaj) as SSOcount From dbo.USAClean_NetSupply_Customers where CustomerMaj = '"+natAcct.nationalAccountNbr+"'");
	    	 while (oRS.next()) { 
	    		 natAcct.usaClean = oRS.getString("SSOcount");
	    	 }
	    	 
	    			 
	    	 //System.out.println("After SSO loop ="+natAcct.usaClean);
	    	///////////////// Location Count / Member Count Query
	    	      	//System.out.println("Select COUNT(distinct(c.custminnbr)) as LocCount, count(Distinct(m.MemberName)) as MemberCount from SAPFMTIPT.dbo.SAP_Customer c JOIN SAPFMTIPT.dbo.SAP_State st on st.stateabbr=c.region JOIN SAPFMTIPT.dbo.SAP_CustomerVendor cv on cv.companycode=c.companycode and cv.custmaj=RIGHT('0000'+cast(c.custmajnbr as varchar),4) and cv.custmin=c.custminnbr JOIN SAPFMTIPT.dbo.SAP_Member m on m.mbrmajnbr=cv.mbrmaj and m.mbrminnbr=cv.mbrmin and m.companycode=cv.companycode Left JOIN FormularyManagement.dbo.view_Curr_Formulary_History fh on fh.CustomerMajor=c.CustMajNbr and fh.MemberMajor=m.MbrMajNbr and fh.MemberMinor=m.MbrMinNbr and st.Zone=fh.ZoneNumber and fh.CustomerMinor=0  where c.companycode=2000 and m.CompanyCode=2000 and m.DeleteFlag='N' and c.deleteflag='N' and cv.deleteflag = 'N' and VendorType = 'VN'and not m.MbrMajNbr in (520) and c.custmajnbr ='"+natAcct.nationalAccountNbr+"'");
	    	 oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
	    	 oStmt = oConn.createStatement();
	    	 oRS = oStmt.executeQuery("Select COUNT(distinct(c.custminnbr)) as LocCount, count(Distinct(m.MbrMajNbr)) as MemberCount from SAPFMTIPT.dbo.SAP_Customer c JOIN SAPFMTIPT.dbo.SAP_State st on st.stateabbr=c.region JOIN SAPFMTIPT.dbo.SAP_CustomerVendor cv on cv.companycode=c.companycode and cv.custmaj=RIGHT('0000'+cast(c.custmajnbr as varchar),4) and cv.custmin=c.custminnbr JOIN SAPFMTIPT.dbo.SAP_Member m on m.mbrmajnbr=cv.mbrmaj and m.mbrminnbr=cv.mbrmin and m.companycode=cv.companycode Left JOIN FormularyManagement.dbo.view_Curr_Formulary_History fh on fh.CustomerMajor=c.CustMajNbr and fh.MemberMajor=m.MbrMajNbr and fh.MemberMinor=m.MbrMinNbr and st.Zone=fh.ZoneNumber and fh.CustomerMinor=0  where c.companycode=2000 and m.CompanyCode=2000 and m.DeleteFlag='N' and c.deleteflag='N' and cv.deleteflag = 'N' and VendorType = 'VN'and not m.MbrMajNbr in (520) and c.custmajnbr ='"+natAcct.nationalAccountNbr+"'");
	    	 	while (oRS.next()) { 
	    	 		natAcct.locCount = oRS.getString("LocCount");
	    	 		natAcct.distCount = oRS.getString("MemberCount");
	    	 }
	    	 
	    	 ///////////////Query CSR assigned to the national account
				//oConn = ConnectionFactory.getInstance().getConnection(Constants.FORMULARY_MGMT_DATASOURCE);
			oStmt = oConn.createStatement();
			oStmt1 = oConn.createStatement();
			
			//System.out.println("Select fu.FirstName, fu.LastName from formularyuser fu JOIN formulary_CSR fc on fu.loginID = ModifiedBy Where CustNbr = "+natAcct.nationalAccountNbr+"");
			oRS = oStmt.executeQuery("SELECT fu.FirstName, fu.LastName,fu.PhoneNbr,[CustNbr],[CustName], 'Assigned' as Type FROM [FormularyManagement].[dbo].[Formulary_CSR] cs join [dbo].[FormularyUser] fu on cs.CSRContactID=fu.UserID Where CustNbr = "+natAcct.nationalAccountNbr+" order by 3, 5");
				while(oRS.next()){
					String firstName = oRS.getString("FirstName");
					String lastName =  oRS.getString("LastName");
					String phone = oRS.getString("PhoneNbr");
					String input = phone;
					int length = phone.length();
					//System.out.println(length);
					if(phone.length() > 9){
						phone = phone.substring(phone.length() -4);	
					//	System.out.println(phone);
					}
					//String output1 = "ext." + input.substring(6, 10);
					phone = "ext. " + phone;
					//System.out.println("phone number=" +phone);
					natAcct.assignedCSR = firstName + " " + lastName + ", " + phone;
					//System.out.println(natAcct.assignedCSR);
					
					oRS1 = oStmt1.executeQuery("SELECT fu.FirstName, fu.LastName,fu.PhoneNbr,[CustNbr],[CustName], 'secondary' as Type FROM [FormularyManagement].[dbo].[Formulary_CSR_Secondary] cs join [dbo].[FormularyUser] fu on cs.CSRContactID=fu.UserID Where CustNbr = "+natAcct.nationalAccountNbr+"");
						while(oRS1.next()){
							String firstName2 = oRS1.getString("FirstName");
							String lastName2 =  oRS1.getString("LastName");
							String phone2 = oRS1.getString("PhoneNbr");
							if(phone2.length() > 9){
								phone2 = phone2.substring(phone2.length() -4);	
								//System.out.println(phone2);
							}
							//String output2 = "ext." + input.substring(6, 10);
							phone2 = "ext. " + phone2;
							natAcct.assignedCSR = natAcct.assignedCSR + "\n" + firstName2 + " " + lastName2 + ", " + phone2;
					}
				}
					
				///////////Query checks if there are LSOG's for the NAtional Account	
				oStmt = oConn.createStatement();
				oRS = oStmt.executeQuery("select distinct COUNT (a.custnbr) as CustomberNumber from FormularyHdr a inner join sapfmtipt.dbo.sap_customer b on a.custnbr = b.custmajnbr where a.LocationOGFlag = 'Y' and a.DeleteFlag='N' and b.custminnbr =000000 and b.DeleteFlag='N' and a.custnbr = "+natAcct.nationalAccountNbr+" ");
					while(oRS.next()){
						natAcct.lsog = oRS.getString("CustomberNumber");
						//System.out.println(natAcct.lsog);
					}
					
			////////////////Query to check if national account uses customer item numbers	
			oStmt = oConn.createStatement();
			oRS = oStmt.executeQuery("select distinct custnbr from FormularyHdr where AltNumber_NSFlag='Y' and custnbr = "+natAcct.nationalAccountNbr+"");
					while(oRS.next()){
						natAcct.nscustItemNbr = oRS.getString("custnbr");
						//System.out.println("customer item number "+natAcct.nscustItemNbr);
					}
			
					////////Query for percentage of items with customer item numbers
			oStmt = oConn.createStatement();
			oRS = oStmt.executeQuery("select (sum(case when CustomerPartNumber ='' Then 0 else 1 end)*1.0)/(count(univitemcode)) as CustomerPartNumber from view_Curr_Formulary_History fh where CustomerMajor = "+natAcct.nationalAccountNbr+"");
					while(oRS.next()){
						natAcct.percentItemNbr = oRS.getString("CustomerPartNumber");
							//System.out.println("customer item number "+natAcct.percentItemNbr);
					}
	    	 
	    	 
	    	////////////Locations with Budgets
					 String replaceFirst = natAcct.soldTo.substring(2);
	    	         //System.out.println("SELECT COUNT (ERPAddressId) as LocationsBudgets FROM ERP2Web47_Network.dbo.ssAddress a LEFT JOIN ERP2Web47_Network.dbo.e2wBudgetMaster b on b.ShipTo=a.ERPAddressId and a.ParentAddressId=b.SoldTo Left Join ERP2Web47_Network.dbo.e2wWorkflowShipToAssociation wa on wa.shipto=a.ERPAddressId Left JOIN ERP2Web47_Network.dbo.e2wWorkflow w on w.workflowid=wa.workflowid WHERE a.ParentAddressId in ("+dbUser.nationalAccountNbr+")and a.IsActive = 1 and b.FiscalYear = YEAR(GETDATE())");
	    	         //System.out.println("Nat Acct substring="+replaceFirst);
	    	 oConn = ConnectionFactory.getInstance().getConnection(Constants.ERP2SQL_DATASOURCE);
	    	 oStmt = oConn.createStatement();
	    	 oRS = oStmt.executeQuery("SELECT COUNT (ERPAddressId) as LocationsBudgets FROM ERP2Web47_Network.dbo.ssAddress a LEFT JOIN ERP2Web47_Network.dbo.e2wBudgetMaster b on b.ShipTo=a.ERPAddressId and a.ParentAddressId=b.SoldTo Left Join ERP2Web47_Network.dbo.e2wWorkflowShipToAssociation wa on wa.shipto=a.ERPAddressId Left JOIN ERP2Web47_Network.dbo.e2wWorkflow w on w.workflowid=wa.workflowid WHERE a.ParentAddressId in ("+dbUser.nationalAccountNbr+")and a.IsActive = 1 and b.FiscalYear = YEAR(GETDATE())");
	    	 while (oRS.next()) { 
	    		 natAcct.locBudgets = oRS.getString("LocationsBudgets");
	    	 }
	    	 	//System.out.println(natAcct.locBudgets);
	    	 ///////////Locations with workflows count
	    	       // System.out.println("Select a.ParentAddressId ,count(distinct(wa.WorkflowId)) as WorkflowCount, count(a.ERPAddressId) as LocWithWorkflows FROM [ERP2Web47_Network].[dbo].[ssAddress] a Join [ERP2Web47_Network].[dbo].[e2wWorkflowShipToAssociation] wa on wa.shipto=a.ERPAddressId JOIN [ERP2Web47_Network].[dbo].[e2wWorkflow] w on w.workflowid=wa.workflowid WHERE a.IsActive=1 and w.IsEnabled=1 and a.ParentAddressId in "+dbUser.nationalAccountNbr+" group by a.ParentAddressId");
	    	 //oConn = ConnectionFactory.getInstance().getConnection(Constants.ERP2SQL_DATASOURCE);
	    	 oStmt = oConn.createStatement();
	    	 oRS = oStmt.executeQuery("Select a.ParentAddressId ,count(distinct(wa.WorkflowId)) as WorkflowCount, count(a.ERPAddressId) as LocWithWorkflows FROM [ERP2Web47_Network].[dbo].[ssAddress] a Join [ERP2Web47_Network].[dbo].[e2wWorkflowShipToAssociation] wa on wa.shipto=a.ERPAddressId JOIN [ERP2Web47_Network].[dbo].[e2wWorkflow] w on w.workflowid=wa.workflowid WHERE a.IsActive=1 and w.IsEnabled=1 and a.ParentAddressId in ("+dbUser.nationalAccountNbr+") group by a.ParentAddressId");
	    	 while (oRS.next()) { 
	    		 natAcct.workflowCount = oRS.getString("WorkflowCount");
	    		 natAcct.locworkCount = oRS.getString("LocWithWorkflows");
	    	 }
	    	 
	    	 /////////////////Market Segments
	    	oConn = ConnectionFactory.getInstance().getConnection(Constants.SAP_DATASOURCE);
	    	 natAcct.marketSegment.clear();
	    	 oStmt = oConn.createStatement();
	    	 	    // System.out.println("Select Distinct NameMktSegment From SAPFMTIPT.dbo.SAP_MarketSegment sm JOIN SAPFMTIPT.dbo.SAP_Customer sc on sc.MktSegmentCode = sm.MktSegMentCode where CompanyCode = 2000 and DeleteFlag = 'N' and CustMajNbr ="+natAcct.nationalAccountNbr+"");
	    	 oRS = oStmt.executeQuery("Select Distinct NameMktSegment From SAPFMTIPT.dbo.SAP_MarketSegment sm JOIN SAPFMTIPT.dbo.SAP_Customer sc on sc.MktSegmentCode = sm.MktSegMentCode where CompanyCode = 2000 and DeleteFlag = 'N' and CustMajNbr ="+natAcct.nationalAccountNbr+"");
	    	 while (oRS.next()) { 
	    		 natAcct.marketSegment.add((String)oRS.getString("NameMktSegment"));
	    	 }
	    	 	//////////////For loop to create comma delimited market segments if more than one exists.
	    	 	for(int i = 0; i < natAcct.marketSegment.size();i++){
					natAcct.markSegment = natAcct.markSegment + natAcct.marketSegment.get(i) + ", ";
				}
				if(!(natAcct.markSegment.equalsIgnoreCase(""))){
					natAcct.markSegment = natAcct.markSegment.substring(4, natAcct.markSegment.length() - 2);	
				}
				
				
				//////////////Query for Utilities zone 9/10	
			//System.out.println("Select CustMajNbr From SAP_Customer Where Zone_PriceGroup = 'z9' or Zone_PriceGroup = 'z10' and CustMajNbr = "+natAcct.nationalAccountNbr+"");
			//oConn = ConnectionFactory.getInstance().getConnection(Constants.SAP_DATASOURCE);
			int z = 0;
			oStmt = oConn.createStatement();
			oRS = oStmt.executeQuery("Select DISTINCT COUNT (CustMajNbr) as CustMajNbr From SAP_Customer Where (Zone_PriceGroup = 'z9' or Zone_PriceGroup = 'z10') and CustMajNbr = "+natAcct.nationalAccountNbr+"");
					while(oRS.next()){
						z++;
					}
					
					if(z == 0){
						natAcct.zones = "No";
					} else {
						natAcct.zones = "Yes";
					}
	    	 
	    	
				
			
			
				
			//oConn = ConnectionFactory.getInstance().getConnection(Constants.SAP_DATASOURCE);
			
	    	 
	    	 dbUser.usaClean = natAcct.usaClean;
	    	// System.out.println("before if else= "+dbUser.usaClean);
	    	 if(!dbUser.usaClean.equals("0")){
	    		 dbUser.usaClean = "Yes";
	    	 } else {
	    		 dbUser.usaClean = "No"; 
	    	 }
	    	 dbUser.locCount = natAcct.locCount;
	    	 if(dbUser.locCount == null){
	    		 dbUser.locCount = "0";
	    	 }
	    	 dbUser.locBudgets = natAcct.locBudgets;
	    	if(dbUser.locBudgets == null){
	    		dbUser.locBudgets = "0";
	    	}
	    	 dbUser.workflowCount = natAcct.workflowCount;
	    	 if(dbUser.workflowCount == null){
	    		 dbUser.workflowCount = "0";
	    	 }
	    	 dbUser.locworkCount = natAcct.locworkCount;
	    	 if(dbUser.locworkCount == null){
	    		 dbUser.locworkCount = "0";
	    	 }
	    	 dbUser.distCount = natAcct.distCount;
	    	 if(dbUser.distCount == null){
	    		 dbUser.distCount = "0";
	    	 }
	    	 dbUser.markSegment = natAcct.markSegment;
	    	 if(dbUser.markSegment == null){
	    		 dbUser.markSegment = "";
	    	 }
	    	 dbUser.assignedCSR = natAcct.assignedCSR;
	    	 if(dbUser.assignedCSR == null){
	    		 dbUser.assignedCSR = "N/A";
	    	 }
	    	 dbUser.zones = natAcct.zones;
	    	 if(dbUser.zones == null){
	    		 dbUser.zones = "N/A";
	    	 }
	    	 dbUser.lsog = natAcct.lsog;
	    	 if(dbUser.lsog == null){
	    		 dbUser.lsog = "N";
	    	 }
	    	 dbUser.nscustItemNbr = natAcct.nscustItemNbr;
	    	 if(dbUser.nscustItemNbr == null){
	    		 dbUser.nscustItemNbr = "";
	    	 }
	    	 dbUser.percentItemNbr = natAcct.percentItemNbr;
	    	 if(dbUser.percentItemNbr == null){
	    		 dbUser.percentItemNbr = "";
	    	 }
	    	 double percentage = Double.valueOf(dbUser.percentItemNbr);
	    	// System.out.println(percentage);
	    	 percentage = Math.round(percentage * 100);
	    	 System.out.println(percentage);
	    	 dbUser.percentItemNbr = Double.toString(percentage);
	    	 if(dbUser.percentItemNbr == null){
	    		 dbUser.percentItemNbr = "0";
	    		 // System.out.println("Percentage "+dbUser.percentItemNbr);
	    	 }
	    	
	    }
	    	 
///////////////////////////////////////////////Beginning of QUERIES for the View National Accounts Page/////////////////////////////////////////
	    	 
	    	 
	    	 /////////////////////////////////////////
	    	 /*dbUser.companyCode = natAcct.companyCode;
	    	 dbUser.poF = natAcct.poF;
	    	 dbUser.popUpF = natAcct.popUpF;
	    	 dbUser.productCatF = natAcct.productCatF;
	    	 dbUser.custMinF = natAcct.custMinF;
	    	 dbUser.userPrefix = natAcct.userPrefix;
	    	 dbUser.pswdPrefix = natAcct.pswdPrefix;
	    	 dbUser.ogPrefix = natAcct.ogPrefix;
	    	 dbUser.superBuyerF = natAcct.superBuyerF;
	    	 dbUser.addr1 = natAcct.addr1;
	    	 dbUser.addr2 = natAcct.addr2;
	    	 dbUser.addr3 = natAcct.addr3;
	    	 dbUser.addr4 = natAcct.addr4;
	    	 dbUser.city = natAcct.city;
	    	 dbUser.state = natAcct.state;
	    	 dbUser.zip = natAcct.zip;
	    	 dbUser.country = natAcct.country;*/
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting National Account Dtls for Update. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	            
	            	if (oRS1 != null)
		               oRS1.close();
		            if (oStmt1 != null)
		               oStmt1.close();
		            if (oConn1 != null)
		               oConn1.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetNationalAccountDtl. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   
private String subString(int i, int j) {
	// TODO Auto-generated method stub
	return null;
}


// initial list of active national accounts & platform - no filter     ////////////////////Member List Platform
  /* public void getMemberListEC(EUIUser dbUser) {
	   getVectorMLEC(dbUser, "usp_EUI_GetMemberListPlatform");
	   }
   
   public void getVectorMLEC(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.memberList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("mbrmaj")); //non-formatted member #
	            v.add(1, oRS.getString("mbrmajnbr_f")); //formatted member #
	            v.add(2, oRS.getString("mbrmin")); //non-formatted member minor#
	            v.add(3, oRS.getString("mbrminnbr_f")); //formatted member minor#
	            v.add(4, oRS.getString("namemember"));
	            v.add(5, oRS.getString("platform"));
	            
	            dbUser.memberList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for MemberList & ecommerce platform for Update Member. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }*/
   
   
    
  /* public void getNationalAccountListFromMem(EUIUser dbUser) {
	   getVectorNALFromMem(dbUser, "usp_EUI_GetNationalAccountListMem @memberNbr='"+dbUser.memberNbr   ///////////////National Account List From Member
			   +"', @Platform='"+dbUser.eplatform+"', @memberMinNbr='"+dbUser.memberMinNbr+"'");
	   
	   /*LOGGER.info("usp_EUI_GetNationalAccountListMem @memberNbr='"+dbUser.memberNbr
			   +"', @Platform='"+dbUser.eplatform+"', @memberMinNbr='"+dbUser.memberMinNbr+"'"); 
	   }
   
   public void getVectorNALFromMem(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.nationalAccountList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("custNbr")); //non-formatted member #
	            v.add(1, oRS.getString("custNbr_f")); //formatted member #
	            v.add(2, oRS.getString("custName")); //customer name
	            
	            dbUser.nationalAccountList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for NationalAccount List based on Member selected for Update Member. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }*/
   
   
   
   /*public void getOrderGuidePrefix(EUIUser dbUser, HttpServletResponse response) throws IOException {  //////////////////Order Prefix????
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      try {	    	   
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         oRS = oStmt.executeQuery("Select CatalogPrefix from "+dbUser.eplatform+"_CustomerMaster Where CustomerNumber="+dbUser.nationalAccountNbr+"");
	         while (oRS.next()) {
	            dbUser.ogPrefix = oRS.getString("CatalogPrefix");
	         }
	         
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting dbUser order guide prefix for Update Member in EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getOrderGuidePrefix. " + e);
	            e.printStackTrace();
	         }
	      }
}*/
   
   
  /* public void getMulOGList(EUIUser dbUser) {      /////////////////////////Mul Order Guide List
	    
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;	 
	      String custNbr = "";
	      int rowN =1;
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();   
	         oRS = oStmt.executeQuery("Select distinct(CompanyCode) ccode from ecommerce.dbo."+dbUser.eplatform+
	        		 "LocationProperties Where CustomerMaj="+dbUser.nationalAccountNbr+"");
	         	 while (oRS.next()) {
	        	 dbUser.companyCode = oRS.getString("ccode");
	         }
	         
	         oRS = oStmt.executeQuery("Select distinct(CustomerMaj) custMaj from ecommerce.dbo."+dbUser.eplatform+"LocationProperties"+
	         		" Where CompanyCode ="+dbUser.companyCode+"");
	         while (oRS.next()) {
	        	 rowN = oRS.getRow();
	        	 custNbr = oRS.getString("custMaj");

	        	 	if (rowN==1) {
	        	 	dbUser.custList = custNbr;
	        	 	} else {
	        	 	dbUser.custList = dbUser.custList.concat(", ").concat(custNbr);
	        	 	}
	        	 }

	         //LOGGER.info(dbUser.companyCode);
	         //LOGGER.info(dbUser.custList);
	      }
	      catch(Exception e)
	     {
	         LOGGER.info("Exception in getting customer list with same company code for OG selection. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }*/
   
   
  /* public void getOrderGuideList(EUIUser dbUser) {
	   getVectorOGList(dbUser, "usp_EUI_GetFMTOrderGuide @custMaj ='"+dbUser.custList     ///////////////Order Guide List for Location
			   +"', @mbrMaj = '"+dbUser.memberNbr+"'");
	   
	   //LOGGER.info("usp_EUI_GetFMTOrderGuide @custMaj ='"+dbUser.custList
			//   +"', @mbrMaj = '"+dbUser.memberNbr+"'");
	   }
   
   public void getVectorOGList(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;	      
	      dbUser.ogList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);         
	         	         
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	        	 Vector v = new Vector();
		            v.add(0, oRS.getString("MbrNbr")); //non-formatted member #
		            v.add(1, oRS.getString("memNbr_f")); //formatted member #
		            v.add(2, oRS.getString("MbrMin")); //non-formatted member minor#
		            v.add(3, oRS.getString("memMin_f")); //formatted member minor#
		            v.add(4, oRS.getString("NameMember"));
		            v.add(5, oRS.getString("custMinNbr_f")); //formatted customer min #
		            v.add(6, oRS.getString("CustMinNbr")); //non-formatted customer min # => -1 of no specific location
		            v.add(7, oRS.getString("CustNbr"));
		            v.add(8, oRS.getString("NameAcct"));
		            v.add(9, oRS.getString("zone"));
		            
		            dbUser.ogList.add(v);
	         }

	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for order guide list List for Update Member. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }*/
   
   
     
  /* public void getMemberUpdatesCustOnly(EUIUser dbUser) {
	   getVectorMemberUpdatesCO(dbUser, "usp_EUI_GetMemberUpdates @memberNbr= -1"
			   +", @Platform='"+dbUser.eplatform+"', @custNbr="+dbUser.nationalAccountNbr
			   +", @memberMinNbr =-1");	   
	   
	    /* LOGGER.info("usp_EUI_GetMemberUpdates @memberNbr= -1"
			   +", @Platform='"+dbUser.eplatform+"', @custNbr="+dbUser.nationalAccountNbr
			   +", @memberMinNbr =-1");	    
   }
	      
   public void getVectorMemberUpdatesCO(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      PreparedStatement oPStmt1 = null;  //get total counts
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      ResultSet oRS1 = null;
	      
	      Statement oStmt1 = null;

	      int cR =0;
	      String numRec = "";
	     
	      String countRec =null;
	      String countActive=null;
	      String countInactive=null;
	      
	      int countR =0;
	      int countA =0;
	      int countI =0;
	      
	      String actInc = null;
	      String memN = null;
	      String custN =null;
	      String memMN = null;
	      
	      String memberName = "";
	      String customerName = "";
	      String catalogPrefix = "";
	      
	      String zoneNum = ""; //add 7/14/2011 to group OG by zone
	      
	      dbUser.memberEmailList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oStmt = oConn.createStatement();
	         oStmt1 = oConn.createStatement();
	         
	         oRS1 = oStmt.executeQuery("Select CatalogPrefix from "+dbUser.eplatform
	            		+"_CustomerMaster Where CustomerNumber="+dbUser.nationalAccountNbr+"");
	            while (oRS1.next()){
	            	catalogPrefix = oRS1.getString("CatalogPrefix");
	            }
	         	         
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	        	 Vector v = new Vector();
		            v.add(0, oRS.getString("mbrNbr_f")); //formatted member #
		            v.add(1, oRS.getString("mbrMinNbr_f")); //formatted member min #
		            
		            //add 7/14
		            zoneNum = oRS.getString("zone");
		            
		            memN = oRS.getString("mbrmaj");
		            //custN = oRS.getString("custNbr");
		            custN = dbUser.nationalAccountNbr;
		            memMN = oRS.getString("mbrmin");	
		            
		            //determine if member maj/min already exist in alp or nlp table
		            oPStmt1 = oConn.prepareCall("usp_EUI_GetTotalMemberUpdate @custMaj="+custN
					+", @mbrMaj='"+memN+"', @mbrMin='"+memMN+"', @platform='"+dbUser.eplatform+"'");
					
		            oRS1 = oPStmt1.executeQuery();  
		            
			         while (oRS1.next())
			         { 
			        	 countRec = oRS1.getString("total");
			         }
			         countR = Integer.parseInt(countRec);
			         
			         /*oRS1 = oStmt1.executeQuery("SELECT count(*) total FROM "+dbUser.eplatform+"LocationProperties WHERE"
					+" CustomerMaj="+custN+" and CustomerMin in (Select c.custminnbr from"
					+" sql.nsc_data_warehouse.dbo.view_curr_customer c JOIN sql.nsc_data_warehouse.dbo.view_curr_nationalAccount"
					+" na ON na.natlacctid=c.natlacctid JOIN sql.nsc_data_warehouse.dbo.view_curr_custmember cm"
					+" ON cm.customerid=c.customerid JOIN sql.nsc_data_warehouse.dbo.view_curr_nscmember m "
					+" ON cm.memberid=m.memberid WHERE cm.PrimaryAgentFlg = 'Y' AND na.custmajnbr ="
					+custN+" AND m.mbrmajnbr="+memN+" AND m.mbrminnbr="+memMN+") and IsActive=0");*/
			        /* oPStmt1 = oConn.prepareCall("usp_EUI_GetTotalInactiveMemberUpdate @custMaj="+custN
					+", @mbrMaj='"+memN+"', @mbrMin='"+memMN+"', @platform='"+dbUser.eplatform+"'");
					
			         oRS1 = oPStmt1.executeQuery(); 
								
						while (oRS1.next())
							{ 
							countInactive= oRS1.getString("total");
							}
							countI = Integer.parseInt(countInactive);
								
			         
			        if (countR==0) { //no record in alp or nlp based on member maj/min from DW
			        	 
			        	v.add(2, "orders@networkdistribution.com"); //email Address
				        v.add(3, ""); 
				        v.add(4, custN); //non-formatted customer #
				        v.add(5, dbUser.naNbrF); //formatted customer #
				        v.add(6, "0"); //default to inactive
				        
				        //add 7/13/2011
				        v.add(7, "");
				        v.add(8, "");
				        v.add(9, "");
				        v.add(10, "");
				        v.add(11, oRS.getString("zone"));
			        	 
			         } else { //record return
			        	 
			      oPStmt1 = oConn.prepareCall("usp_EUI_GetMemberUpdatesDtl @custMaj="+custN
			 		+", @mbrMaj='"+memN+"', @mbrMin='"+memMN+"', @platform='"+dbUser.eplatform+"', @zone="+zoneNum+"");
			      
			    // LOGGER.info("return record w/zone" + "usp_EUI_GetMemberUpdatesDtl @custMaj="+custN
					 		//+", @mbrMaj='"+memN+"', @mbrMin='"+memMN+"', @platform='"+dbUser.eplatform+"', @zone="+zoneNum+"");  
			 		  
			      oRS1 = oPStmt1.executeQuery(); 	
						    		
			         while (oRS1.next())
			         {  
		            v.add(2, oRS1.getString("mEmail")); //email Address
		            v.add(3, oRS1.getString("CatalogName")); 
		            v.add(4, oRS1.getString("custNbr")); //formatted customer #
		            v.add(5, oRS1.getString("custNbr_f")); //formatted customer min #

			         } //end of RS1a
			         
			            
				            if (countI==countR) { //all are inactive
				            	dbUser.memberActive = "0";
				            } else if (countI==0) { //all are active
				            	dbUser.memberActive = "1";
				            } else {
				            	dbUser.memberActive = "-1"; //mix of active and inactive
				            }
				            actInc = dbUser.memberActive;
				            v.add(6, actInc); //active
	        	 
			         } //end of if catalog maj/min in alp or nlp match with member maj/min in data warehouse
		            
			        
			            //re-initalize values
			         countRec = "";
			         countActive = "";
			         countInactive = "";
			         countR = 0;
			         countA = 0;
			         countI = 0;
			         
			         numRec = "";
			         cR=0;		            

			        v.add(7, oRS.getString("namemember")); //name of member
		            v.add(8, oRS.getString("mbrmaj")); //member #
		            v.add(9, oRS.getString("mbrmin")); //member min #
		            v.add(10, catalogPrefix); //member min #
		            	v.add(11, oRS.getString("zone")); //zone of location
		            
		            dbUser.memberEmailList.add(v);
	         }
	         
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for member email list based on Customer ONLY for Update Member. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oRS1.close();
	            oPStmt.close();
	            oStmt.close();
	            oStmt1.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }*/
   
	         
	         
  /* public void getMemberUpdatesMemOnly(EUIUser dbUser) {
	   getVectorMemberUpdatesMO(dbUser, "usp_EUI_GetMemberUpdates @memberNbr='"+dbUser.memberNbr
			   +"', @Platform='"+dbUser.eplatform+"', @custNbr= -1"
			   +", @memberMinNbr ='"+dbUser.memberMinNbr+"'");
	   
	   /* LOGGER.info("usp_EUI_GetMemberUpdates @memberNbr='"+dbUser.memberNbr
			   +"', @Platform='"+dbUser.eplatform+"', @custNbr= -1"
			   +", @memberMinNbr ='"+dbUser.memberMinNbr+"'"); 
	   
	   
   }
   
   public void getVectorMemberUpdatesMO(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      Statement oStmt = null;
	      
	      ResultSet oRS = null;
	      ResultSet oRS1 = null;
	      
	      String countRec =null;
	      String countActive=null;
	      String countInactive=null;
	      int countR =0;
	      int countA =0;
	      int countI =0;
	      
	      String actInc = null;
	      String memN = null;
	      String custN =null;
	      String memMN = null;
	      
	      String memberName = "";
	      String customerName = "";
	      String catalogPrefix = "";
	      
	      dbUser.memberEmailList.clear();
	         
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oStmt = oConn.createStatement();
		         oRS = oPStmt.executeQuery();
		         while (oRS.next())
		         {
   	 	        	 
		        	 Vector v = new Vector();
			            //v.add(0, oRS.getString("mbrNbr_f")); //formatted member #
			            //v.add(1, oRS.getString("mbrMinNbr_f")); //formatted member min #
				        v.add(0, oRS.getString("custmaj")); //non-formatted customer #
				        v.add(1, oRS.getString("custNbr_f")); //formatted customer #
				        
				        custN = oRS.getString("custmaj");
				       // memN = oRS.getString("mbrmaj");
				        //memMN = oRS.getString("mbrmin");
 				         
				         oRS1 = oStmt.executeQuery("Select CatalogPrefix from ecommerce.dbo."+dbUser.eplatform
				            		+"_CustomerMaster Where CustomerNumber="+custN+"");
				            while (oRS1.next()){
				            	catalogPrefix = oRS1.getString("CatalogPrefix");
				            }
				         
				            oRS1 = oStmt.executeQuery("Select distinct(c.CustomerName) custName"+
				            		" FROM SAPFMTIPT.dbo.SAP_customer c"+
				            		" Where c.CompanyCode = 2000 and c.CustMinNbr ='000000' and c.CustMajNbr="+custN);
			            while (oRS1.next()){
			            	customerName = oRS1.getString("custName");
			            	}		
			              
				         v.add(2, customerName); //name of customer
				         v.add(3, catalogPrefix); //catalog prefix
				         v.add(4, oRS.getString("zone")); //zone of location

				         
				         customerName = "";
				         catalogPrefix="";
			            dbUser.memberEmailList.add(v);
		         
		         } //end of while 
		         
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for member email list based on Member ONLY selected for Update Member. " + e);
	      }
	      finally{
	         try {
	        	 oRS.close();
		         oRS1.close();
		         oPStmt.close();
		         oStmt.close();
		         oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }   */      

	         
     
  /* public void getMemberUpdates(EUIUser dbUser) {
	   getVectorMemberUpdates(dbUser, "usp_EUI_GetMemberUpdates @memberNbr='"+dbUser.memberNbr
			   +"', @Platform='"+dbUser.eplatform+"', @custNbr="+dbUser.nationalAccountNbr
			   +", @memberMinNbr ='"+dbUser.memberMinNbr+"'");
	   
	 /* LOGGER.info("usp_EUI_GetMemberUpdates @memberNbr='"+dbUser.memberNbr
			   +"', @Platform='"+dbUser.eplatform+"', @custNbr="+dbUser.nationalAccountNbr
			   +", @memberMinNbr ='"+dbUser.memberMinNbr+"'"); 
	   
	   }
   
   public void getVectorMemberUpdates(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      PreparedStatement oPStmt1 = null;  //get total counts
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      ResultSet oRS1 = null;
	     
	      String countRec =null;
	      String countActive=null;
	      String countInactive=null;
	      
	      int countR =0;
	      int countA =0;
	      int countI =0;
	      
	      String actInc = null;
	      String memN = null;
	      String custN =null;
	      String memMN = null;
	      
	      String catalogPrefix = "";
	      
	      dbUser.memberEmailList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oStmt = oConn.createStatement();
	         	         	         
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {		     		
		        	 Vector v = new Vector();
			            v.add(0, oRS.getString("mEmail")); //email Address
			            v.add(1, oRS.getString("CatalogName")); 

			            memN = dbUser.memberNbr;
			            custN = dbUser.nationalAccountNbr;
			            memMN = dbUser.memberMinNbr;
			           
			            oRS1 = oStmt.executeQuery("Select CatalogPrefix from "+dbUser.eplatform
			            		+"_CustomerMaster Where CustomerNumber="+custN+"");
			            while (oRS1.next()){
			            	catalogPrefix = oRS1.getString("CatalogPrefix");
			            }
			            
			            
			            oPStmt1 = oConn.prepareCall("usp_EUI_GetTotalMemberUpdate @custMaj="+custN
					    		+", @mbrMaj='"+memN+"', @mbrMin='"+memMN+"', @platform="+dbUser.eplatform+"");
					    oRS1 = oPStmt1.executeQuery();
			            
					    while (oRS1.next()){
			            countRec = oRS1.getString("total");
			            }
			            countR = Integer.parseInt(countRec);
			            
			            oPStmt1 = oConn.prepareCall("usp_EUI_GetTotalActiveMemberUpdate @custMaj="+custN
					    		+", @mbrMaj='"+memN+"', @mbrMin='"+memMN+"', @platform="+dbUser.eplatform+"");
					    oRS1 = oPStmt1.executeQuery();
			            
					    while (oRS1.next()){
			            countActive = oRS1.getString("total");
			            }
			            countA = Integer.parseInt(countActive);
			            
			            
			            if (countA==countR) {
							 actInc = "1"; //all are active	 
						 } else if (countA==0) { //no active => all are InActive
							 actInc ="0";
						 } else { //a mix of active and inactive - no need to do count for InActive records
							 actInc="-1";
						 }
			            
				            //re-initalize values
				         countRec = "";
				         countActive = "";
				         countInactive = "";
				         countR = 0;
				         countA = 0;
				         countI = 0;
			            
			            v.add(2, actInc); //active
			            v.add(3, catalogPrefix); //prefix
			            
			            v.add(4, oRS.getString("Zone"));
			            
			            dbUser.memberEmailList.add(v);
		         }
	         		         	         
	         
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for member email list based on Member & Customer selected for Update Member. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oRS1.close();
	            oPStmt.close();
	            oStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   
   public void saveMemberUpdates(EUIUser dbUser) throws IOException {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall("usp_"+dbUser.eplatform+"_LocationPropertiesMemberUpdate @updatedBy = '"+dbUser.getUserLogin()
	        		 //+"', @ID ="+dbUser.locPropID
	        		 +"', @CustomerMaj="+dbUser.nationalAccountNbr
	        		 +", @MbrMjr="+dbUser.memberNbr
	        		 +", @MbrMin="+dbUser.memberMinNbr
	        		 +", @CatlogMbrPOEmail='"+dbUser.memberEmail
	        		 //+"', @LocationPOEmail='"+dbUser.locationEmail
	        		 +"', @CatalogName='"+dbUser.catalogName
	        		 +"', @IsActive="+dbUser.memberActive
	        		 +",  @Zone="+dbUser.zone //add 11/10/2010
	        		 //+", @ActionType='U'");
	        		 +"");	         
	         
	         LOGGER.info("usp_"+dbUser.eplatform+"_LocationPropertiesMemberUpdate @updatedBy = '"+dbUser.getUserLogin()
	        		 +"', @CustomerMaj="+dbUser.nationalAccountNbr
	        		 +", @MbrMjr="+dbUser.memberNbr
	        		 +", @MbrMin="+dbUser.memberMinNbr
	        		 +", @CatlogMbrPOEmail='"+dbUser.memberEmail
	        		 +"', @CatalogName='"+dbUser.catalogName
	        		 +"', @IsActive="+dbUser.memberActive
	        		 +", @Zone="+dbUser.zone //add 11/10/2010
	        		 +"");
	         
	         //*** uncomment when ready to test ****///
	      /*  oPStmt.executeUpdate();
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in update Member Emails in EUI. " + e);
	      } finally {
	         try {
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUISaveMemberUpdates. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   public void getNationalAccountMinList(EUIUser dbUser) {
	   getVectorNAMin(dbUser, "usp_EUI_GetNationalAccountMinList @custNbr="+dbUser.nationalAccountNbr
			   +", @memberNbr='"+dbUser.memberNbr
			   +"', @memberMin='"+dbUser.memberMinNbr
			   +"', @Platform='"+dbUser.eplatform+"'");
	   
	   /*LOGGER.info("usp_EUI_GetNationalAccountMinList @custNbr="+dbUser.nationalAccountNbr
			   +", @memberNbr='"+dbUser.memberNbr
			   +"', @memberMin='"+dbUser.memberMinNbr
			   +"', @Platform='"+dbUser.eplatform+"'");*/
	/*   }
   public void getVectorNAMin(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.nationalAccountMinList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	        	 Vector v = new Vector();
		            v.add(0, oRS.getString("custMin")); //non-formatted member minor#
		            v.add(1, oRS.getString("custMin_f")); //formatted member minor#
		            
		            dbUser.nationalAccountMinList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for customer min List based on customer selected for Update Location. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }

   
   public void getAltCustMinFlag(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      //PreparedStatement oPStmt = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
		    	
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         oRS = oStmt.executeQuery("Select AltCustMinCodeFlag from ecommerce.dbo."+dbUser.eplatform+"_CustomerMaster Where CustomerNumber="+dbUser.nationalAccountNbr+"");
	    	 while (oRS.next()) {
	    		 dbUser.custMinF = oRS.getString("AltCustMinCodeFlag");
	         }
	    	 
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting AltCustMinFlag for customer maj for Location Update. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetAltCustMinFlag. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getAltCustMinCodes(EUIUser dbUser) {

	   getVectorACM(dbUser, "Select AltCustMinCode from "+dbUser.eplatform+"LocationProperties where customerMaj="
			   +dbUser.nationalAccountNbr+" and RIGHT('000'+ cast(catalogMbrMjr as varchar),3)='"+dbUser.memberNbr
			   +"' and RIGHT('00'+ cast(catalogMbrMin as varchar),2) ='"+dbUser.memberMinNbr
			   +"' and customermin="+dbUser.nationalAccountNbrMin);	
	   
	   /* LOGGER.info("Select AltCustMinCode from "+dbUser.eplatform+"LocationProperties where customerMaj="
			   +dbUser.nationalAccountNbr+" and RIGHT('000'+ cast(catalogMbrMjr as varchar),3)='"+dbUser.memberNbr
			   +"' and RIGHT('00'+ cast(catalogMbrMin as varchar),2) ='"+dbUser.memberMinNbr
			   +"' and customermin="+dbUser.nationalAccountNbrMin); */
	  ///////////////// }
   
  /* public void getVectorACM(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      //PreparedStatement oPStmt = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      dbUser.custMinCode.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         oRS = oStmt.executeQuery(sql);
	         while (oRS.next())
	         {
	        	 Vector v = new Vector();
		            v.add(0, oRS.getString("AltCustMinCode"));             
		            dbUser.custMinCode.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for alt cust min codes for Update Location. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getLocationUpdate(EUIUser dbUser) {
	   
	   getVectorLocationUpdate(dbUser, "usp_EUI_GetLocationDtl @ePlatform='"+dbUser.eplatform
			   +"', @custNbr="+dbUser.nationalAccountNbr
			   +", @custMinNbr="+dbUser.nationalAccountNbrMin
			   +", @acmCode='"+dbUser.acmCode+"'");
	   
	/*   LOGGER.info("usp_EUI_GetLocationDtl @ePlatform='"+dbUser.eplatform
			   +"', @custNbr="+dbUser.nationalAccountNbr
			   +", @custMinNbr="+dbUser.nationalAccountNbrMin
			   +", @acmCode='"+dbUser.acmCode+"'"); */
	   
	   //}
   
  /* public void getVectorLocationUpdate(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.memberEmailList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	        	 Vector v = new Vector();
		            v.add(0, oRS.getString("AltCustMinCode")); 
		            v.add(1, oRS.getString("PONumberRequired")); 
		            v.add(2, oRS.getString("SecondaryMember"));
		            v.add(3, oRS.getString("Username")); 
		            v.add(4, oRS.getString("Password")); 
		            v.add(5, oRS.getString("CatalogName")); 
		            v.add(6, oRS.getString("locEmail")); 
		            v.add(7, oRS.getString("memEmail"));
		            v.add(8, oRS.getString("IsActive"));
		            v.add(9, oRS.getString("UpdatedBy"));
		            v.add(10, oRS.getString("DateUpdated"));
		            v.add(11, oRS.getString("ID")); //location properties ID
		            v.add(12, oRS.getString("CompanyCode"));
		            
		            dbUser.memberEmailList.add(v);
		            
		            dbUser.locPropID = oRS.getString("ID"); //pass in to get comments
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for location update based on Member, NA, Ecommerce platform selected for Update Location. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getLocationUpdateC(EUIUser dbUser) {
	   getVectorLocationUpdateC(dbUser, "usp_EUI_GetLocationComments @ID="+dbUser.locPropID
			   +", @Platform='"+dbUser.eplatform+"'");
	   
	   /* LOGGER.info("usp_EUI_GetLocationComments @ID="+dbUser.locPropID
			   +", @Platform='"+dbUser.eplatform+"'"); */
	   
	   //////////}
   
 /*  public void getVectorLocationUpdateC(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.locationList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	        	 Vector v = new Vector();
		            v.add(0, oRS.getString("Comment")); 
		            v.add(1, oRS.getString("DateCreated")); 
		            v.add(2, oRS.getString("CreatedBy"));
		            		            
		            dbUser.locationList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for location update based on Member, NA, Ecommerce platform selected for Update Location. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   
   public void getCustomerMin(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      NationalAccount natAcct = new NationalAccount();
	      try {	    	   
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();

	         oRS = oStmt.executeQuery("select distinct RIGHT('000000' + CAST(LTRIM('"+dbUser.nationalAccountNbrMin
	        		 +"') as VARCHAR), 6) AS custMinF from SAPFMTIPT.dbo.SAP_Customer Where CustMajNbr="+
	        		 dbUser.nationalAccountNbr+"");
	         while (oRS.next()) {
	            natAcct.custMinF = oRS.getString("custMinF");
	         }
	         
	         dbUser.naMinNbrF = natAcct.custMinF;
	         
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting formatted customer min# for update Location. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::getCustomerMin. " + e);
	            e.printStackTrace();
	      }
	      }      
   }
   
   public void saveLocationUpdate(EUIUser dbUser) throws IOException {
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oPStmt = oConn.prepareCall("usp_"+dbUser.eplatform+"_LocationPropertiesUpdate @updatedBy = '"+dbUser.getUserLogin()
	        		 +"', @ID ="+dbUser.locPropID
	        		 +", @CatalogMbrMjr="+dbUser.memberNbr
	        		 +", @CatalogMbrMin="+dbUser.memberMinNbr
	        		 +", @CustomerMaj="+dbUser.nationalAccountNbr
	        		 +", @CustomerMin="+dbUser.nationalAccountNbrMin
	        		 +", @AltCustMinCode='"+dbUser.acmCode
	        		 +"', @CompanyCode="+dbUser.companyCode
	        		 +", @UserName='"+dbUser.userPrefix
	        		 +"', @Password='"+dbUser.pswdPrefix
	        		 +"', @CatlogMbrPOEmail='"+dbUser.memberEmail
	        		 +"', @LocationPOEmail='"+dbUser.locationEmail
	        		 +"', @CatalogName='"+dbUser.catalogName
	        		 +"', @SecondaryMember='"+dbUser.secondaryMem
	        		 +"', @IsActive="+dbUser.memberActive
	        		 +", @Zone="+dbUser.zone
	        		 +", @ActionType='U'");	
	         
	         
	         /*LOGGER.info("usp_"+dbUser.eplatform+"_LocationPropertiesUpdate @updatedBy = '"+dbUser.getUserLogin()
	        		 +"', @ID ="+dbUser.locPropID
	        		 +", @CatalogMbrMjr="+dbUser.memberNbr
	        		 +", @CatalogMbrMin="+dbUser.memberMinNbr
	        		 +", @CustomerMaj="+dbUser.nationalAccountNbr
	        		 +", @CustomerMin="+dbUser.nationalAccountNbrMin
	        		 +", @AltCustMinCode='"+dbUser.acmCode
	        		 +"', @CompanyCode="+dbUser.companyCode
	        		 +", @UserName='"+dbUser.userPrefix
	        		 +"', @Password='"+dbUser.pswdPrefix
	        		 +"', @CatlogMbrPOEmail='"+dbUser.memberEmail
	        		 +"', @LocationPOEmail='"+dbUser.locationEmail
	        		 +"', @CatalogName='"+dbUser.catalogName
	        		 +"', @SecondaryMember='"+dbUser.secondaryMem
	        		 +"', @IsActive="+dbUser.memberActive
	        		  +", @Zone="+dbUser.zone
	        		 +", @ActionType='U'");  */
	         
	         //*** uncomment when ready to test ****//
	        /* oPStmt.executeUpdate();
	         
	         String commentsSQL = "";
	         if (dbUser.eplatform.equals("Access")) {
	        	 
	         commentsSQL = "usp_Access_LocationCommentsAdd @ALP_ID ="+dbUser.locPropID
	        		 +", @Comments='"+dbUser.comments+"', @updatedBy="+dbUser.getUserLogin();
	         } else {
	         commentsSQL = "usp_NetSupply_LocationCommentsAdd @NLP_ID ="+dbUser.locPropID
        		 +", @Comments='"+dbUser.comments+"', @updatedBy="+dbUser.getUserLogin();	 
	         }
	         
	         //LOGGER.info(commentsSQL);
	         
	         oPStmt = oConn.prepareCall(commentsSQL);
	         //*** uncomment when ready to test ****///
	        /* oPStmt.executeUpdate();
	    	 	    	 
	      } catch (Exception e) {
	         LOGGER.info("Exception in Update Location in EUI. " + e);

	      } finally {
	         try {
	            if (oPStmt != null)
	               oPStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUISaveLocationUpdate. " + e);
	            e.printStackTrace();
	         }
	      }
	   }*/
   
   
   //super buyer location update
   
   public void getNationalAccountSBLoc(EUIUser dbUser) {
	   String sql = "";
	   if (dbUser.eplatform.equals("Access")) {
		   sql = "SELECT CompanyCode, ID, CustomerMin FROM ecommerce.dbo.AccessLocationProperties"+
		   " Where customermaj="+dbUser.nationalAccountNbr+" and isactive=1 Order by CustomerMin";
	   } else { //netSupply
		   sql = "SELECT CompanyCode, ID, CustomerMin FROM ecommerce.dbo.NetSupplyLocationProperties"+
		   " Where customermaj="+dbUser.nationalAccountNbr+" and isactive=1 Order by CustomerMin";
	   }
	   
	   getVectorNASBLoc(dbUser, sql);
	   }
   
   public void getVectorNASBLoc(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.nationalAccountMinList.clear();
	     	      
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         //oPStmt = oConn.prepareCall(sql);
	         oPStmt = oConn.prepareStatement(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("CompanyCode")); 
	            v.add(1, oRS.getString("ID")); 
	            v.add(2, oRS.getString("CustomerMin")); 
	            //v.add(3, oRS.getString("altcustmin"));
	            
	            dbUser.nationalAccountMinList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for customer min locations for super buyer. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   public void getNationalAccountMemSBLoc(EUIUser dbUser) {
	   String sql = "";

	    if (dbUser.eplatform.equals("Access")) {
			   sql = "SELECT CompanyCode, ID, CustomerMin FROM ecommerce.dbo.AccessLocationProperties"+
			   " Where customermaj="+dbUser.nationalAccountNbr+" and isactive=1"+
			   " and CatalogMbrMjr ='"+dbUser.memberNbr+"' and CatalogMbrMin='"+dbUser.memberMinNbr+"'";
		   } else { //netSupply
			   sql = "SELECT CompanyCode, ID, CustomerMin FROM ecommerce.dbo.NetSupplyLocationProperties"+
			   " Where customermaj="+dbUser.nationalAccountNbr+" and isactive=1"+
			   " and CatalogMbrMjr ='"+dbUser.memberNbr+"' and CatalogMbrMin='"+dbUser.memberMinNbr+"'";
		   }
	   
	   getVectorNAMemSBLoc(dbUser, sql);
	   }
   
   public void getVectorNAMemSBLoc(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      dbUser.nationalAccountMinList.clear();
	     	      
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         //oPStmt = oConn.prepareCall(sql);
	         oPStmt = oConn.prepareStatement(sql);
	         oRS = oPStmt.executeQuery();
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("CompanyCode")); 
	            v.add(1, oRS.getString("ID")); 
	            v.add(2, oRS.getString("CustomerMin")); 
	            //v.add(3, oRS.getString("altcustmincode")); 
	            
	            dbUser.nationalAccountMinList.add(v);
	         }
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for customer min locations for super buyer - additional filter of member #. " + e);
	      }
	      finally{
	         try {
	            oRS.close();
	            oPStmt.close();
	            oConn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getNationalAccountMinNbr(EUIUser dbUser, HttpServletResponse response) throws IOException {
	      Connection oConn = null;
	      Statement oStmt = null;
	      ResultSet oRS = null;
	      
	      try {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         
	         if (dbUser.eplatform.equals("Access")) {
	         oRS = oStmt.executeQuery("Select CustomerMin From ecommerce.dbo.AccessLocationProperties Where ID="+dbUser.locPropID);
	    	 while (oRS.next()) {
	    	 dbUser.nationalAccountNbrMin = oRS.getString("CustomerMin");
	         }
	         } else {
	        oRS = oStmt.executeQuery("Select CustomerMin From ecommerce.dbo.NetSupplyLocationProperties Where ID="+dbUser.locPropID);
		    while (oRS.next()) {
		    dbUser.nationalAccountNbrMin = oRS.getString("CustomerMin");	 
	         }
	         }	    
	         
	      } catch (Exception e) {
	         LOGGER.info("Exception in getting actual NationalAccountMin Name from EUI. " + e);
	      } finally {
	         try {
	            if (oRS != null)
	               oRS.close();
	            if (oStmt != null)
	               oStmt.close();
	            if (oConn != null)
	               oConn.close();
	         } catch (SQLException e) {
	            LOGGER.info("SQLException in EUIUtils::EUIGetCustomerAccountMinName. " + e);
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getSuperBuyerLocations(EUIUser dbUser) {
	   String sql = "";
	   if (dbUser.eplatform.equals("Access")) {
		   sql = "SELECT childcustomermaj custMaj, childcustomermin custMin, ID FROM ecommerce.dbo.access_masteraccounts"+
		   " where accesslocationproperties_id="+dbUser.locPropID+" and isactive=1 and updatetype=1"+
		   " Order By 1,2";
	   
	   } else {
		   sql = "SELECT childcustomermaj custMaj, childcustomermin custMin, ID FROM ecommerce.dbo.netsupply_masteraccounts"+
		   " where netsupplylocationproperties_id="+dbUser.locPropID+" and isactive=1 and updatetype=1"+
		   " Order By 1,2";
	   }
	   
	   //LOGGER.info("sql for superbuyers: "+sql);
	   
	   getVectorSBLoc(dbUser, sql);
	   }
   
   public void getVectorSBLoc(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      ResultSet oRS1 = null;
	      Statement oStmt = null;
	      String custACM = "";
	      dbUser.superBuyerList.clear();
	      try
	      {
	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         //oPStmt = oConn.prepareCall(sql);
	         oStmt = oConn.createStatement();
	         oPStmt = oConn.prepareStatement(sql);
	         	         
	         oRS = oPStmt.executeQuery();
	         String custMaj = "";
	         String custMin = "";
	         String custMinName = "";         
	         
	         while (oRS.next())
	         {
	            Vector v = new Vector();
	            v.add(0, oRS.getString("custMaj")); 
	            custMaj = oRS.getString("custMaj");
	            v.add(1, oRS.getString("custMin"));
	            custMin = oRS.getString("custMin");
	            v.add(2, oRS.getString("ID")); 
	            

	            oRS1=oStmt.executeQuery("SELECT c.Name2 addr1 FROM SAPFMTIPT.dbo.SAP_Customer c "+ 
	            "where c.custmajnbr = "+custMaj+" and c.custminnbr=RIGHT('000000'+ '"+custMin+"',6) and c.CompanyCode = 2000");
	       				
	           /* LOGGER.info("SB  SELECT c.Name2 addr1 FROM SAPFMTIPT.dbo.SAP_Customer c "+ 
	            "where c.custmajnbr = "+custMaj+" and c.custminnbr=RIGHT('000000'+ '"+custMin+"',6) and c.CompanyCode = 2000");
	            */
	            
	            while (oRS1.next()) {
	       					custMinName = oRS1.getString("addr1");	
	       					}
	       					v.add(3, custMinName);
	       	            dbUser.superBuyerList.add(v);
	       	            
	       	            //clear out value
	       	            custMaj = "";
	       	            custMin = "";
	       	            custMinName = "";

	         }
	         
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for Super Buyers. " + e);
	      }
	      finally{
	         try {
	            //oRS.close();
	            //oPStmt.close();
	            //oConn.close();
	        	 
	        	 if (oRS != null)
		               oRS.close();
	        	 if (oRS1 !=null)
	        		 	oRS1.close();
		         if (oStmt != null)
		               oStmt.close();
		         if (oPStmt != null)
		        	 	oPStmt.close();
		         if (oConn != null)
		               oConn.close();
		         
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	   }
   
   
   public void getNonSuperBuyerLocations(EUIUser dbUser) {
	   String sql = "";
	   if (dbUser.eplatform.equals("Access")) {

	   sql = "SELECT CustomerMaj custMaj, CustomerMin custMin, ID FROM ecommerce.dbo.AccesslocationProperties"+
	   " Where companycode = "+dbUser.companyCode+" and isactive=1"+ 
	   " and not ID in (SELECT alp.ID FROM ecommerce.dbo.AccesslocationProperties alp"+
	   " JOIN ecommerce.dbo.Access_MasterAccounts ama on ama.childcustomermaj=alp.customermaj and ama.childcustomermin=alp.customermin"+
	   " Where alp.isactive=1 and ama.accesslocationproperties_id="+dbUser.locPropID+" and ama.isactive=1 and ama.updatetype=1)"+
	   " Order by 1, 2";
	   
	   } else {

	   sql = "SELECT CustomerMaj custMaj, CustomerMin custMin, ID FROM ecommerce.dbo.NetsupplylocationProperties"+
	   " Where companycode = "+dbUser.companyCode+" and isactive=1"+ 
	   " and not ID in (SELECT nlp.ID FROM ecommerce.dbo.NetsupplylocationProperties nlp"+
	   " JOIN ecommerce.dbo.NetSupply_MasterAccounts nma on nma.childcustomermaj=nlp.customermaj and nma.childcustomermin=nlp.customermin"+
	   " Where nlp.isactive=1 and nma.netsupplylocationproperties_id="+dbUser.locPropID+" and nma.isactive=1 and nma.updatetype=1)"+
	   " Order by 1, 2";
	   }
	   
	   //LOGGER.info("sql for non superbuyers: "+sql);
	   
	   getVectorNoSB(dbUser, sql);
	   
   }
   
   
   
   public void getVectorNoSB(EUIUser dbUser, String sql) {
	    
	      Connection oConn = null;
	      PreparedStatement oPStmt = null;
	      ResultSet oRS = null;
	      ResultSet oRS1 = null;
	      Statement oStmt = null;
	      dbUser.superBuyerNonList.clear();
	      try
	      {

	         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
	         oStmt = oConn.createStatement();
	         oPStmt = oConn.prepareStatement(sql);
         
	         oRS = oPStmt.executeQuery();
	         String custMaj = "";
	         String custMin = "";
	         String custMinName = "";
	         
	         while (oRS.next())
	         {
	            Vector vN = new Vector();
	            vN.add(0, oRS.getString("custMaj")); 
	            custMaj = oRS.getString("custMaj");
	            vN.add(1, oRS.getString("custMin")); 
	            custMin = oRS.getString("custMin");
	            vN.add(2, oRS.getString("ID"));
	            
	            if (custMaj=="") {} else {
	            
	            	/* oRS1=oStmt.executeQuery("SELECT c.addr1 FROM SQL.nsc_data_warehouse.dbo.view_curr_nationalAccount na "+ 
	         "inner JOIN SQL.nsc_data_warehouse.dbo.view_curr_customer c on c.natlacctid=na.natlacctid "+
	         "where na.custmajnbr = "+custMaj+" and c.custminnbr="+custMin); */
	            	oRS1=oStmt.executeQuery("SELECT c.Name2 addr1 FROM SAPFMTIPT.dbo.SAP_Customer c "+ 
	           	         "where c.custmajnbr = "+custMaj+" and c.custminnbr=RIGHT('000000'+ '"+custMin+"', 6)"+
	           	         " and c.CompanyCode = 2000");
	            	
	            	/*LOGGER.info("NOSB  SELECT c.Name2 addr1 FROM SAPFMTIPT.dbo.SAP_Customer c "+ 
	           	         "where c.custmajnbr = "+custMaj+" and c.custminnbr=RIGHT('000000'+ '"+custMin+"', 6)"+
	           	         " and c.CompanyCode = 2000"); */
	            	
					while (oRS1.next()) {
					custMinName = oRS1.getString("addr1");	
					}
					//LOGGER.info(custMinName);
	            }
					vN.add(3, custMinName);
	            dbUser.superBuyerNonList.add(vN);
	            
	            //clear out value
	            custMaj = "";
	            custMin = "";
	            custMinName = "";
	         }
	         	              
	      }
	      catch(Exception e)
	      {
	         LOGGER.info("Exception in getVector for non Super Buyers. " + e);
	      }
	      finally{
	         try {
	           // oRS.close();
	            //oRS1.close();
	            //oStmt.close();
	           // oPStmt.close();
	           // oConn.close();
	        	 
	        	 if (oRS != null)
		               oRS.close();
		         if (oStmt != null)
		               oStmt.close();
		         if (oRS1 != null)
		               oRS1.close();
		         if (oPStmt != null)
		               oPStmt.close();
		         if (oConn != null)
		               oConn.close();
		         
	         } catch (SQLException e) {
	            e.printStackTrace();
	      }
	   }
   }   
   
	      
public void saveSuperBuyer(EUIUser dbUser) throws IOException {
		      Connection oConn = null;
		      PreparedStatement oPStmt = null;
		      Statement oStmt = null;
		      ResultSet oRS = null;
		      String custMaj = ""; //Maj# of super buyer location saved as childcustomermaj
		      String custMin = ""; //Min# of super buyer location saved as childcustomermin
		      String countMA = "";
		      String countLP = "";
		      String sql = "";
		      
		      try {
		         oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
		         
		         //get specific customer maj and min to save as child values for specific location selcted for superbuyer
			      oStmt = oConn.createStatement();
			      
			      
			         String sepC ="_"; //get ID type - ama/nma vs. alp/nlp
			         String newStr = dbUser.sbLoc;
			         int dd = newStr.length();
			         int ee =0;

			         	ee = newStr.indexOf(sepC);
			         	dbUser.sbLoc = newStr.substring(0, ee);	  
			         		//LOGGER.info("sbLoc wo type: "+dbUser.sbLoc);
			         	ee = ee +1;
			         	newStr = newStr.substring(ee,dd);
			         	//LOGGER.info("type of sbLoc: "+newStr);
			         	
			         	if (newStr.equals("MA")) { //ID from MasterAccounts
			      
			    	 oRS = oStmt.executeQuery("Select ChildCustomerMaj, ChildCustomerMin, ISNULL(ChildAltCustMinCode,'') ChildAltCustMinCode From "+dbUser.eplatform+"_MasterAccounts"+
				    		  " Where ID = "+dbUser.sbLoc);
				      while (oRS.next()) {
				    	  custMaj = oRS.getString("ChildCustomerMaj");
				    	  custMin = oRS.getString("ChildCustomerMin");
				    	  dbUser.acmCode = oRS.getString("ChildAltCustMinCode");
				      	}	
				      /* sql = "Select ChildCustomerMaj, ChildCustomerMin From "+dbUser.eplatform+"_MasterAccounts"+
				    		  " Where ID = "+dbUser.sbLoc+""; */
			         	
			         	} else { //not a ama/nma ID, get info form ALP/NLP
			            
			      oRS = oStmt.executeQuery("Select CustomerMaj, CustomerMin, ISNULL(AltCustMinCode,'') AltCustMinCode From "+dbUser.eplatform+"LocationProperties"+
			    		  " Where ID = "+dbUser.sbLoc);
			      while (oRS.next()) {
			    	  custMaj = oRS.getString("CustomerMaj");
			    	  custMin = oRS.getString("CustomerMin");
			    	  dbUser.acmCode = oRS.getString("AltCustMinCode");
			      	}
			       /* sql = "Select CustomerMaj, CustomerMin, AltCustMinCode From "+dbUser.eplatform+"LocationProperties"+
			    		  " Where ID = "+dbUser.sbLoc+""; */
			      }
			      //LOGGER.info("Query to get child custMaj & min: "+sql);
		         
		         oPStmt = oConn.prepareCall("usp_EUI_SaveSuperBuyer @updatedBy = '"+dbUser.getUserLogin()
		        		 +"', @ID ="+dbUser.locPropID
		        		 +", @LocID="+dbUser.sbLoc
		        		 +", @LocType='"+newStr+"'"
		        		 +", @CustomerMaj="+custMaj
		        		 +", @CustomerMin="+custMin
		        		 +", @eplatform='"+dbUser.eplatform
		        		 +"', @acmCode='"+dbUser.acmCode
		        		 +"', @updateType='SB'");	
		         
		         
		          /* LOGGER.info("usp_EUI_SaveSuperBuyer @updatedBy = '"+dbUser.getUserLogin()
		        		 +"', @ID ="+dbUser.locPropID
		        		 +", @LocID="+dbUser.sbLoc
		        		 +", @LocType='"+newStr+"'"
		        		 +", @CustomerMaj="+custMaj
		        		 +", @CustomerMin="+custMin
		        		 +", @eplatform='"+dbUser.eplatform
		        		 +"', @acmCode='"+dbUser.acmCode
		        		 +"', @updateType='SB'");	*/	
		         
		         //*** uncomment when ready to test ****//
		         oPStmt.executeUpdate();
		    	 	    	 
		      } catch (Exception e) {
		         LOGGER.info("Exception in Save Super Buyer Locations. " + e);

		      } finally {
		         try {
		        	if (oStmt != null)
			            oStmt.close();
		        	if (oRS != null)
			            oRS.close();
		        	if (oPStmt != null)
		               oPStmt.close();
		            if (oConn != null)
		               oConn.close();
		         } catch (SQLException e) {
		            LOGGER.info("SQLException in EUIUtils::EUISaveSuperBuyer. " + e);
		            e.printStackTrace();
		         }
		      }	      	      
	   }
   

public void saveNonSuperBuyer(EUIUser dbUser) throws IOException {
    Connection oConn = null;
    PreparedStatement oPStmt = null;
    Statement oStmt = null;
    ResultSet oRS = null;
    String custMaj = ""; //Maj# of super buyer location saved as childcustomermaj
    String custMin = ""; //Min# of super buyer location saved as childcustomermin
    String countMA = "";
    String countLP = "";
    String sql = "";
    
    try {
       oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
       
//     get specific customer maj and min to save as child values for specific location selcted for superbuyer
	      oStmt = oConn.createStatement();

	      	 String sepC ="_"; //get ID type - ama/nma vs. alp/nlp
	         String newStr = dbUser.nonSBLoc;
	         int dd = newStr.length();
	         int ee =0;

	         	ee = newStr.indexOf(sepC);
	         	dbUser.nonSBLoc = newStr.substring(0, ee);	  
	         		//LOGGER.info("nonSBLoc wo type: "+dbUser.nonSBLoc);
	         	ee = ee +1;
	         	newStr = newStr.substring(ee,dd);
	         	//LOGGER.info("type of nonSBLoc: "+newStr);
	         	
	         	if (newStr.equals("MA")) { //ID from MasterAccounts
	         			         		
	    	 oRS = oStmt.executeQuery("Select ChildCustomerMaj, ChildCustomerMin From "+dbUser.eplatform+"_MasterAccounts"+
		    		  " Where ID = "+dbUser.nonSBLoc);
		      while (oRS.next()) {
		    	  custMaj = oRS.getString("ChildCustomerMaj");
		    	  custMin = oRS.getString("ChildCustomerMin");
		      	}	
		      sql = "Select ChildCustomerMaj, ChildCustomerMin From "+dbUser.eplatform+"_MasterAccounts"+
		    		  " Where ID = "+dbUser.nonSBLoc+"";
	     
	     } else { //not a superbuer, get info form ALP/NLP
	      
	      oRS = oStmt.executeQuery("Select CustomerMaj, CustomerMin From "+dbUser.eplatform+"LocationProperties"+
	    		  " Where ID = "+dbUser.nonSBLoc);
	      while (oRS.next()) {
	    	  custMaj = oRS.getString("CustomerMaj");
	    	  custMin = oRS.getString("CustomerMin");
	      	}
	      sql = "Select CustomerMaj, CustomerMin From "+dbUser.eplatform+"LocationProperties"+
	    		  " Where ID = "+dbUser.nonSBLoc+"";
	      }
	      //LOGGER.info("Query to get child custMaj & min: "+sql);
	      
	      
       oPStmt = oConn.prepareCall("usp_EUI_SaveSuperBuyer @updatedBy = '"+dbUser.getUserLogin()
      		 +"', @ID ="+dbUser.locPropID
      		+", @LocID="+dbUser.nonSBLoc
      		+", @LocType='"+newStr+"'"
      		 +", @CustomerMaj="+custMaj
      		 +", @CustomerMin="+custMin
      		 +", @eplatform='"+dbUser.eplatform
      		+"', @acmCode='"+dbUser.acmCode
      		 +"', @updateType='NSB'");	
       
       
     /*  LOGGER.info("usp_EUI_SaveNonSuperBuyer @updatedBy = '"+dbUser.getUserLogin()
      		 +"', @ID ="+dbUser.locPropID
      		+", @LocID="+dbUser.nonSBLoc
      		+", @LocType='"+newStr+"'"
      		 +", @CustomerMaj="+custMaj
      		 +", @CustomerMin="+custMin
      		 +", @eplatform='"+dbUser.eplatform
      		+"', @acmCode='"+dbUser.acmCode
      		 +"', @updateType='NSB'");		*/
       
       //*** uncomment when ready to test ****//
       oPStmt.executeUpdate();
  	 	    	 
    } catch (Exception e) {
       LOGGER.info("Exception in Save Non Super Buyer Locations. " + e);

    } finally {
       try {
    	   if (oStmt != null)
	            oStmt.close();
          if (oRS != null)
	            oRS.close();
    	   if (oPStmt != null)
             oPStmt.close();
          if (oConn != null)
             oConn.close();
       } catch (SQLException e) {
          LOGGER.info("SQLException in EUIUtils::EUISaveNonSuperBuyer. " + e);
          e.printStackTrace();
       }
    }	      	      
}




} //end of EUI Utils   
   
  
