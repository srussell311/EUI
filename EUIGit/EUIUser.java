package com.nsc.eui;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Map;
import java.util.TreeMap;
import java.util.Vector;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class EUIUser {
   private int dbUserID;
   private boolean active; 
   private String businessRole;  // A-Admin, CSR-Customer Service Rep, O-Other
   private String userLogin; //username of logged in user
   
   //used to update user profile
   public String userPswd = null;
   public String newPswd = null;
   public String confirmPswd = null;
   public String userUpdate =null;
   
   //for new user; performed by EUI admin
   public String uName = null;
   public String uPswd = null;
   public String uActive = null;
   public String uRole = null;
   
   //public UserPreferences userPrefs = new UserPreferences();
   
  
   // Collection objects for the report & formulary filter results returned from database queries
   public Vector nationalAccountList = null; //national account (customer) list
   public Vector memberList = null; //member list 
   public Vector nationalAccountMinList = null; //national account minor(customer) list
   public Vector memberMinList = null; //member minor list
   public Vector ecPlatformList = null; //ecommerce platform list 
   public Vector memberEmailList =null; //member email update list
   public Vector ogList = null; //list of order guides
   public Vector locationList =null; //comments for locations
   public Vector custMinCode =null; //multiple location per customer maj/min
   public Vector superBuyerList =null; //list of current super buyers
   public Vector superBuyerNonList = null; //list of non-super buyers
   public Vector reportList = null; // dashboard report added 5/31/2011
   public Vector platform = new Vector(); //dynamically builds the order source drop down menu of the new/update national account pages
    
   public Vector userList = null; //user list - users that have login to app
   
   
   //values displayed after selected from dropdowns
   public String nationalAccountName = new String();
   public String nationalAccountNbr = new String(); // customer number
   public String nationalAccountNbrMin = new String(); // customer min number
   public String nationalAccountMinName = new String(); // customer min number
   public String memberName = new String();
   public String memberID = new String(); //formated member number
   public String memberNbr = new String(); //looping through list of selected members (action ID of member)
   public String memberMinNbr = new String();
   public String nationalAccountLocationName = new String();
   
   public String naNbrF = new String(); //formatted customer or national account #
   public String naMinNbrF = new String(); //formatted customer minor (location) #
   public String memNbrF = new String(); //formatted member #
   public String memMinNbrF = new String(); //formatted member minor #
   
   
// Date fields for calendar popups on various reports
   SimpleDateFormat formatter = new SimpleDateFormat ("mm/dd/yyyy");
   public String currDate; //format is mm-dd-yyyy
   public String currDate1; //format is mm/dd/yyyy
     
   // Default settings for report controls (dropdowns, download options)
    
   //selected values from dropdown
   public String eplatform = null;
   public String natAcct = null;
   public String selMember = null;
   
   //new account
   public String superBuyerF = null;
   public String productCatF = null;
   public String popUpF = null;
   public String poF = null;
   public String custMinF = null;
   public String companyCode = null;
   public String userPrefix = null;
   public String pswdPrefix = null;
   public String ogPrefix = null;
   public String validateSQL = null;
   public String ddmtActive =null; //if account active through customer master table vs. DDTM tables
   
   public String addr1 = null;
   public String addr2 = null;
   public String addr3 = null;
   public String addr4 = null;
   public String city = null;
   public String state = null;
   public String zip = null;
   public String country = null;
   ///New Drop Down menus for New Accounts Page
   public String action = null;
   public String imagedUsed = null;
   public String acctActive = null;
   public String activeCheck = null;
   
   public String customerNumber = null;
   public String custName = null;
   
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
   
   public String custMaj = null;
   public int customerMajor = 0;
   public String custMajor = null;
   public String customerName = null;
   public String soldTo = null;
   public String nscustLocNbr = null;
   public String nscustURL = null;
   public String nslaunchDate = null;
   public SimpleDateFormat luanchDate = null;
   public String nsaddNotes = null;
   public String addNotes = null;
   ///variable just for View NA page 5/22/18 S.R.
   public String routeToViewDtl = null; 
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
   ////////////////////////////////////////
   public String nsacctActive = null;
   public String activeCheckNS = null;
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
   public String nsadminEmail = "";
   public String nshidePrice = null;
   public String nsuserNames = null;
   public String nsuserPassword = null;
   public String nsuserNamesText = null;
   public String nsuserPasswordText = null;
   public String nsfavList = null;
   public String nsfavListNote = null;
   public String nscleanupFlag = null;
   public String nsssoCustomer = null;
   public String nsssoNotes = null;
   
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
   
   public String login = null;
   
   ///////////////////////End of new Drop Down variables
   
   //member Updates
   public String memberEmail = null;
   public String catalogName = null;
   public String memberActive = null;
   public String locationEmail = null;
   public String comments = null; //comments for member and location updates
   public String locPropID =null;
   public String locPropCommentsID =null;
 
   
   public String validF=null;
   public String validSQLF=null;
   public String succssF="Y"; //update successful with no exceptions
   public String acmFlag ="N"; //if alt cust min code flag = 1, set this value =Y to prompt for additional filter
   							   //when updating a location
   public String acmCode =null; //actual altcustmincode value for final filter of update location
   public String secondaryMem = null; //queried and passed to update location sp - NOT USED IN APP
   
   public String typeAction = null; //I or U if insert or update
   
   public String totRecords = null; //used to loop through multiple records
   
   public String superBuyer = null; //array of super buyer location ID's
   public String noSuperBuyer = null; //array of super buyer location ID's
   public String sbLoc = ""; //specific location ID
   public String nonSBLoc = ""; //specific location ID that is NOT super buyer
   
   public String custList = null; //comma separated list of cust#'s for Multiple OG dd
   
   //add 11/10/2010 for SAP Phase 2
   public String zone = null; //store zone for each location based on order guide selected
   							//possible to have more than 1 OG for cust/member combo with different zones
   
   
   //public ReadXL readXL = new ReadXL();
  
   //public EUIUser(javax.servlet.http.HttpServletRequest request, 
			//java.lang.String saveDirectory,
           //int maxPostSize,
           //DefaultFileRenamePolicy policy)
    //throws java.io.IOException {
		
	//}
   
   public EUIUser() {
	   		//list of vectors
            nationalAccountList = new Vector();
            memberList = new Vector();
            ecPlatformList = new Vector();            
            userList = new Vector();
            memberEmailList = new Vector();
            ogList = new Vector();
            nationalAccountMinList = new Vector();
            memberMinList = new Vector();
            locationList = new Vector();
            custMinCode = new Vector();
            superBuyerList = new Vector();
            superBuyerNonList = new Vector();
            reportList = new Vector();
            
   }

      
   //private String setDateToCurrentDay() {
	      //Calendar currDay = Calendar.getInstance();

	      //int dayOfWeek = currDay.get(Calendar.DAY_OF_WEEK);
	      //int dayOfYear = currDay.get(Calendar.DAY_OF_YEAR);
	      //currDay.set(Calendar.DAY_OF_YEAR, dayOfYear);
	      //return formatter.format(currDay.getTime());
	   //}
   
   public boolean isActive() {
      return active;
   }
   public void setActive(boolean active) {
      this.active = active;
   }
  
   //used for parameters passed in to stored proc located in EUIUtils.java file
   
   public String getBusinessRole() {
	      return businessRole;
	   }
   public void setBusinessRole(String businessRole) {
	      this.businessRole = businessRole;
	   }
   
   public String getUserLogin() {
	      return userLogin;
	   }
   public void setUserLogin(String userLogin) {
 	      this.userLogin = userLogin;
	   }
   
 
   public String getNationalAccountNbr() {
	      return nationalAccountNbr;
	   }
   public void setNationalAccountNbr(String nationalAccountNbr) {
	      this.nationalAccountNbr = nationalAccountNbr;
	   }
   
   public String getNationalAccountName() {
	      return nationalAccountName;
	   }
   
   public void setNationalAccountName(String nationalAccountName) {
	      this.nationalAccountName = nationalAccountName;
	   }
   
   public String getMemberID() {
	      return memberID;
	   }
   public void setMemberID(String memberID) {
	      this.memberID = memberID;
	   }
   
   public String getMemberName() {
	   	return memberName;
   }
 
  public void setMemberName (String memberName) {
	  this.memberName = memberName;
  }
   
}
