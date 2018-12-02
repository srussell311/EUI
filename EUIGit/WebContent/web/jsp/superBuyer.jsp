<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page
	import="java.lang.*, java.io.*, java.util.*, java.text.*, java.sql.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>

<%
String actionType = (String)request.getParameter("actionType");
%>
<script language="Javascript">
	 
   function getLocationDtlSB() {
   //gets customer min location listing based on customer/national account ONLY
   document.superB.actionType.value="GetLocationsSB";
   document.superB.submit();
   }
   
   
   function getSBDtl() {
   //gets super buyer locations based on customer/national account
   document.superB.actionType.value="SuperBuyerLoc";
   document.superB.submit();
   }
   

  function getSBMem() {
   //gets customer min locations based on customer AND member
   document.superB.actionType.value="SuperBuyerMem";
   document.superB.submit();
   }
   
   function getSBMemDtl() {
   //gets super buyer locations based on customer AND member
   document.superB.actionType.value="SuperBuyerMemLoc";
   document.superB.submit();
   }
   
   
   function SaveSuperBuyer(){
   		showSelected()
		showUnSelected()
			document.superB.actionType.value = "SaveSuperBuyer";
			document.superB.page.value="superBuyer.jsp"
			document.superB.submit();
	}
	
	function Cancel(){
			document.superB.actionType.value = "SuperBuyer";
			document.superB.page.value="superBuyer.jsp"
			document.superB.submit();
	}
   
  
//multiple selection boxes
var selectedList;
var availableList;
function createListObjects(){
    availableList = document.getElementById("availableOptions");
    selectedList = document.getElementById("selectedOptions");
}
/*function delAttribute(){
    var selIndex = selectedList.selectedIndex;
    //if(selIndex < 0)
        //return;
		for (i=selIndex; i>=0; i--) {
    availableList.appendChild(selectedList.options.item(selIndex))
		}
    selectNone(selectedList,availableList);
    setSize(availableList,selectedList);
}

function addAttribute(){
var addIndex = availableList.selectedIndex;
    //if(addIndex < 0)
    //return;
		for (i=addIndex; i>=0; i--) {
    selectedList.appendChild(availableList.options.item(addIndex));
		}
    selectNone(selectedList,availableList);
    setSize(selectedList,availableList);

}
*/


//new code
function addOption(theSel, theText, theValue)
{
  var newOpt = new Option(theText, theValue);
  var selLength = theSel.length;
  theSel.options[selLength] = newOpt;
}

function deleteOption(theSel, theIndex)
{ 
  var selLength = theSel.length;
  if(selLength>0)
  {
    theSel.options[theIndex] = null;
  }
}

function moveOptions(theSelFrom, theSelTo)
{
  
  var selLength = theSelFrom.length;
  var selectedText = new Array();
  var selectedValues = new Array();
  var selectedCount = 0;
  
  var i;
  
  // Find the selected Options in reverse order
  // and delete them from the 'from' Select.
  for(i=selLength-1; i>=0; i--)
  {
    if(theSelFrom.options[i].selected)
    {
      selectedText[selectedCount] = theSelFrom.options[i].text;
      selectedValues[selectedCount] = theSelFrom.options[i].value;
      deleteOption(theSelFrom, i);
      selectedCount++;
    }
  }
  
  // Add the selected text/values in reverse order.
  // This will add the Options to the 'to' Select
  // in the same order as they were in the 'from' Select.
  for(i=selectedCount-1; i>=0; i--)
  {
    addOption(theSelTo, selectedText[i], selectedValues[i]);
  }
  
}




function delAll(){
    var len = selectedList.length -1;
    for(i=len; i>=0; i--){
        availableList.appendChild(selectedList.item(i));
    }
    selectNone(selectedList,availableList);
    setSize(selectedList,availableList);
    
}
function addAll(){
    var len = availableList.length -1;
    for(i=len; i>=0; i--){
        selectedList.appendChild(availableList.item(i));
    }
    selectNone(selectedList,availableList);
    setSize(selectedList,availableList);
    
}
function selectNone(list1,list2){
    list1.selectedIndex = -1;
    list2.selectedIndex = -1;
    addIndex = -1;
    selIndex = -1;
}
function setSize(list1,list2){
    list1.size = getSize(list1);
    list2.size = getSize(list2);
}
function getSize(list){
    /* Mozilla ignores whitespace, IE doesn't - count the elements in the list */
    var len = list.childNodes.length;
    var nsLen = 0;
    //nodeType returns 1 for elements
    for(i=0; i<len; i++){
        if(list.childNodes.item(i).nodeType==1)
            nsLen++;
    }
    if(nsLen<2)
        return 2;
    else
        return nsLen;
}
function showSelected(){
    var optionList = document.getElementById("selectedOptions").options;
    var data = '';
    var len = optionList.length;
    for(i=0; i<len; i++){
        if(i>0)
            data += ',';
        data += optionList.item(i).value;
    }
    //alert(data);
	document.superB.sbLocations.value = data;
}

function showUnSelected(){
    var optionList = document.getElementById("availableOptions").options;
    var data = '';
    var len = optionList.length;
    for(i=0; i<len; i++){
        if(i>0)
            data += ',';
        data += optionList.item(i).value;
    }
    //alert(data);
	document.superB.nonSBLocations.value = data;
}
</script>

<body onLoad="createListObjects()">

	<div id="inputField">

		<form action="ControllerServlet?page=superBuyer.jsp" method="post"
			name="superB">
			<input type=hidden name='actionType' value=""> <input
				type=hidden name='page' value=""> <span class="subTitle">Super
				Buyer Location </span> <br /> <br /> <input type="hidden"
				value="<%=actionType%>" name="currentAction" />

			<% if (actionType.equals("SuperBuyer")) { %>
			<table border="0" cellpadding="0">
				<tr>
					<td>National Account:</td>
					<td><select name="natAcct" id="natAcct"
						onChange="javascript:getLocationDtlSB()">
							<option value="none" selected="selected">--- Select One
								---</option>
							<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
							<option
								value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
								-
								<%=natAcct.elementAt(2)%> -
								<%=natAcct.elementAt(3)%></option>
							<%    }			
%>
					</select></td>
				</tr>
			</table>


			<% } if (actionType.equals("GetLocationsSB")) { %>

			<table border="0" cellpadding="0">

				<tr>
					<td>National Account:</td>
					<td><select name="natAcct" id="natAcct"
						onChange="getLocationDtlSB()">
							<option value="<%=dbUser.nationalAccountNbr%>"
								selected="selected"><%=dbUser.naNbrF%> -
								<%=dbUser.nationalAccountName%> -
								<%=dbUser.eplatform%></option>
							<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
							<option
								value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
								-
								<%=natAcct.elementAt(2)%> -
								<%=natAcct.elementAt(3)%></option>
							<%    }			
%>
					</select> <input type="hidden" name="eplatform"
						value="<%=dbUser.eplatform%>" /> <input type="hidden"
						name="natAcct" value="<%=dbUser.nationalAccountNbr%>" /></td>

				</tr>
				<tr>
					<td>E-Commerce Platform:</td>
					<td><%=dbUser.eplatform%></td>
				</tr>

				<tr>
					<td>Member:</td>
					<td><select name="member" onChange="javascript:getSBMem()">
							<option value="none" selected="selected">--- Select One
								---</option>
							<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
							<option
								value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>"><%=memberL.elementAt(1)%>
								-
								<%=memberL.elementAt(3)%> -
								<%=memberL.elementAt(4)%></option>
							<%    }			
%>
					</select></td>
				</tr>

				<tr>

					<td>Customer Minor# or Location:</td>
					<td><select name="natAcctMin" onChange="javascript:getSBDtl()">
							<option value="none" selected="selected">--- Select One
								---</option>
							<%
		for (int m = 0; m < dbUser.nationalAccountMinList.size(); m++) {
         Vector custMinL = (Vector) dbUser.nationalAccountMinList.elementAt(m); %>
							<option
								value="<%=custMinL.elementAt(0)%>,<%=custMinL.elementAt(1)%>"><%=custMinL.elementAt(2)%></option>
							<%    }			
%>
					</select></td>

				</tr>

			</table>

			<% }

if (actionType.equals("SuperBuyerLoc")) { //no member selected - only customer and customerMin location
%>
			<table border="0" cellpadding="0">

				<tr>
					<td>National Account:</td>
					<td><select name="natAcct" id="natAcct"
						onChange="javascript:getLocationDtlSB()">
							<option value="<%=dbUser.nationalAccountNbr%>"
								selected="selected"><%=dbUser.naNbrF%> -
								<%=dbUser.nationalAccountName%> -
								<%=dbUser.eplatform%></option>
							<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
							<option
								value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
								-
								<%=natAcct.elementAt(2)%> -
								<%=natAcct.elementAt(3)%></option>
							<%    }			
%>
					</select> <input type="hidden" name="eplatform"
						value="<%=dbUser.eplatform%>" /> <input type="hidden"
						name="natAcct" value="<%=dbUser.nationalAccountNbr%>" /></td>

				</tr>

				<tr>
					<td>E-Commerce Platform:</td>
					<td><%=dbUser.eplatform%></td>

				</tr>

				<tr>
					<td>Member:</td>
					<td><select name="member" onChange="javascript:getSBMem()">
							<option value="none" selected="selected">--- Select One
								---</option>
							<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
							<option
								value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>"><%=memberL.elementAt(1)%>
								-
								<%=memberL.elementAt(3)%> -
								<%=memberL.elementAt(4)%></option>
							<%    }			
%>
					</select></td>
				</tr>

				<tr>

					<td>Customer Minor# or Location:</td>
					<td><select name="natAcctMin" onChange="javascript:getSBDtl()">
							<option value="<%=dbUser.companyCode%>,<%=dbUser.locPropID%>"
								selected="selected"><%=dbUser.nationalAccountNbrMin%> -
								<%=dbUser.nationalAccountMinName%></option>
							<%
		for (int m = 0; m < dbUser.nationalAccountMinList.size(); m++) {
         Vector custMinL = (Vector) dbUser.nationalAccountMinList.elementAt(m); %>
							<option
								value="<%=custMinL.elementAt(0)%>,<%=custMinL.elementAt(1)%>"><%=custMinL.elementAt(2)%></option>
							<%    }			
%>
					</select></td>

				</tr>

			</table>

			<br />
			<table>
				<tr>
					<td colspan="3" align="center"><span class="helpText">To
							select more than one location, hold down the Shift key while
							selecting.</span></td>
				</tr>
				<tr>
					<td align="center">Non-Super Buyer Locations<br /> <select
						name="availableOptions" size="6" multiple="multiple"
						id="availableOptions" style="width: 350px; height: 120px">
							<%		   
		for (int n = 0; n < dbUser.superBuyerNonList.size(); n++) {
         Vector sbNonL = (Vector) dbUser.superBuyerNonList.elementAt(n); 
		
		 %>
							<option value="<%=sbNonL.elementAt(2)%>_LP"><%=sbNonL.elementAt(0)%>
								-
								<%=sbNonL.elementAt(1)%> -
								<%=sbNonL.elementAt(3)%></option>
							<%   }	
		%>
					</select> <br />
					<input type="hidden" name="nonSBLocations" />
					</td>

					<td align="center" valign="top"><div align="center">
							<br />
							<button onClick="addAll()">&gt;&gt;&gt;</button>
							<br>
							<!-- <button onClick="addAttribute()">&gt;</button>
          <br>          
             <button onClick="delAttribute()">&lt;</button> -->

							<button
								onClick="moveOptions(this.form.availableOptions, this.form.selectedOptions);">&gt;</button>
							<br />
							<button
								onClick="moveOptions(this.form.selectedOptions, this.form.availableOptions);">&lt;</button>


							<br>
							<br />
							<button onClick="delAll()">&lt;&lt;&lt;</button>
							<br />
						</div></td>

					<td align="center">Current Super Buyer Locations<br /> <select
						name="selectedOptions" size="6" multiple="multiple"
						id="selectedOptions" style="width: 350px; height: 120px">

							<%
		for (int s = 0; s < dbUser.superBuyerList.size(); s++) {
         Vector sbL = (Vector) dbUser.superBuyerList.elementAt(s); %>
							<option value="<%=sbL.elementAt(2)%>_MA"><%=sbL.elementAt(0)%>
								-
								<%=sbL.elementAt(1)%> -
								<%=sbL.elementAt(3)%></option>
							<%    }	
		%>
					</select> <br />
					<input type="hidden" name="sbLocations" />
					</td>
				</tr>
				<tr>
					<td colspan="3"><input type="button" name="Submit" id="Submit"
						value="Save" onClick="SaveSuperBuyer()" /> <input type="button"
						name="Submit" id="Submit" value="Cancel" onClick="Cancel()" /> <input
						type="hidden" name="ALPNLP_id" value="<%=dbUser.locPropID%>" /> <input
						type="hidden" name="companyCode" value="<%=dbUser.companyCode%>" />
						<input type="hidden" name="customerMin"
						value="<%=dbUser.nationalAccountNbrMin%>" /> <% if (actionType.equals("SuperBuyerMemLoc")) { %>
						<input type="hidden" name="memberMaj"
						value="<%=dbUser.memberNbr%>" /> <input type="hidden"
						name="memberMin" value="<%=dbUser.memberMinNbr%>" /> <% } else { %>
						<input type="hidden" name="memberMaj" value="0" /> <input
						type="hidden" name="memberMin" value="-1" /> <% } %> <!-- <button onClick="showSelected()">Show</button> 
        <button onClick="showUnSelected()">Show NON-SB</button> --></td>
				</tr>
			</table>


		</form>

		<% } if (actionType.equals("SuperBuyerMem")) { //get cust list based on customer AND member
%>

		<table border="0" cellpadding="0">

			<tr>
				<td>National Account:</td>
				<td><select name="natAcct" id="natAcct"
					onChange="getLocationDtlSB()">
						<option value="<%=dbUser.nationalAccountNbr%>" selected="selected"><%=dbUser.naNbrF%>
							-
							<%=dbUser.nationalAccountName%> -
							<%=dbUser.eplatform%></option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option
							value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
							-
							<%=natAcct.elementAt(2)%> -
							<%=natAcct.elementAt(3)%></option>
						<%    }			
%>
				</select> <input type="hidden" name="eplatform" value="<%=dbUser.eplatform%>" />
					<input type="hidden" name="natAcct"
					value="<%=dbUser.nationalAccountNbr%>" /></td>
			</tr>
			<tr>
				<td>E-Commerce Platform:</td>
				<td><%=dbUser.eplatform%></td>
			</tr>

			<tr>
				<td>Member:</td>
				<td><select name="member" onChange="javascript:getSBMem()">
						<% if (dbUser.memberNbr.equals("0")) {%>
						<option value="none">--- Select One ---</option>
						<% } else { %>
						<option value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>"
							selected="selected"><%=dbUser.memNbrF%> -
							<%=dbUser.memMinNbrF%> -
							<%=dbUser.memberName%>
						</option>
						<% } %>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%></option>
						<%    }			
%>
						<option value="none">--- No Member ---</option>
				</select></td>
			</tr>

			<tr>

				<td>Customer Minor# or Location:</td>
				<td><select name="natAcctMin"
					<% if (dbUser.memberNbr.equals("0")) {%>
					onChange="javascript:getSBDtl()" <% } else { %>
					onchange="javascript:getSBMemDtl()" <% } %>>
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		int count=0;
		for (int m = 0; m < dbUser.nationalAccountMinList.size(); m++) {
         Vector custMinL = (Vector) dbUser.nationalAccountMinList.elementAt(m); %>
						<option
							value="<%=custMinL.elementAt(0)%>,<%=custMinL.elementAt(1)%>"><%=custMinL.elementAt(2)%></option>
						<%   
		count++;
		 }			
%>
				</select> <% if (count==0) { %> <br />
				<span class="errorField"> No customer minor locations exists
						for the member selected.<br /> <br /> Please select a different
						member.
				</span> <% } %></td>
			</tr>
		</table>

		<% }

if (actionType.equals("SuperBuyerMemLoc")) { //super buyer locations based on customer/member and cust min location
%>

		<table border="0" cellpadding="0">

			<tr>
				<td>National Account:</td>
				<td><select name="natAcct" id="natAcct"
					onChange="javascript:getLocationDtlSB()">
						<option value="<%=dbUser.nationalAccountNbr%>" selected="selected"><%=dbUser.naNbrF%>
							-
							<%=dbUser.nationalAccountName%> -
							<%=dbUser.eplatform%></option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option
							value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
							-
							<%=natAcct.elementAt(2)%> -
							<%=natAcct.elementAt(3)%></option>
						<%    }			
%>
				</select> <input type="hidden" name="eplatform" value="<%=dbUser.eplatform%>" />
					<input type="hidden" name="natAcct"
					value="<%=dbUser.nationalAccountNbr%>" /></td>

			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td><%=dbUser.eplatform%></td>

			</tr>

			<tr>
				<td>Member:</td>
				<td><select name="member" onChange="javascript:getSBMem()">
						<option value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>"
							selected="selected"><%=dbUser.memNbrF%> -
							<%=dbUser.memMinNbrF%> -
							<%=dbUser.memberName%>
						</option>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%></option>
						<%    }			
%>
				</select></td>
			</tr>

			<tr>

				<td>Customer Minor# or Location:</td>
				<td><select name="natAcctMin"
					onChange="javascript:getSBMemDtl()">
						<option value="<%=dbUser.companyCode%>,<%=dbUser.locPropID%>"
							selected="selected"><%=dbUser.nationalAccountNbrMin%> -
							<%=dbUser.nationalAccountMinName%></option>
						<%
		for (int m = 0; m < dbUser.nationalAccountMinList.size(); m++) {
         Vector custMinL = (Vector) dbUser.nationalAccountMinList.elementAt(m); %>
						<option
							value="<%=custMinL.elementAt(0)%>,<%=custMinL.elementAt(1)%>"><%=custMinL.elementAt(2)%></option>
						<%    }			
%>
				</select></td>

			</tr>

		</table>

		<br />
		<table>
			<tr>
				<td colspan="3" align="center"><span class="helpText">To
						select more than one location, hold down the Shift key while
						selecting.</span></td>
			</tr>

			<tr>
				<td align="center">Non-Super Buyer Locations<br /> <select
					name="availableOptions" size="6" multiple="multiple"
					id="availableOptions" style="width: 350px; height: 120px">
						<%		   
		for (int n = 0; n < dbUser.superBuyerNonList.size(); n++) {
         Vector sbNonL = (Vector) dbUser.superBuyerNonList.elementAt(n); 
		
		 %>
						<option value="<%=sbNonL.elementAt(2)%>_LP"><%=sbNonL.elementAt(0)%>
							-
							<%=sbNonL.elementAt(1)%> -
							<%=sbNonL.elementAt(3)%></option>
						<%    }			
		%>
				</select> <br />
				<input type="hidden" name="nonSBLocations" />
				</td>

				<td align="center" valign="top"><div align="center">
						<br />
						<button onClick="addAll()">&gt;&gt;&gt;</button>
						<br>
						<!-- <button onClick="addAttribute()">&gt;</button>
          <br>          
             <button onClick="delAttribute()">&lt;</button> -->

						<button
							onClick="moveOptions(this.form.availableOptions, this.form.selectedOptions);">&gt;</button>
						<br />
						<button
							onClick="moveOptions(this.form.selectedOptions, this.form.availableOptions);">&lt;</button>

						<br>
						<br />
						<button onClick="delAll()">&lt;&lt;&lt;</button>
						<br />
					</div></td>

				<td align="center">Current Super Buyer Locations<br /> <select
					name="selectedOptions" size="6" multiple="multiple"
					id="selectedOptions" style="width: 350px; height: 120px">

						<%
		for (int s = 0; s < dbUser.superBuyerList.size(); s++) {
         Vector sbL = (Vector) dbUser.superBuyerList.elementAt(s); %>
						<option value="<%=sbL.elementAt(2)%>_MA"><%=sbL.elementAt(0)%>
							-
							<%=sbL.elementAt(1)%> -
							<%=sbL.elementAt(3)%></option>
						<%    }	
		%>
				</select> <br />
				<input type="hidden" name="sbLocations" />
				</td>
			</tr>
			<tr>
				<td colspan="3"><input type="button" name="Submit" id="Submit"
					value="Save" onClick="SaveSuperBuyer()" /> <input type="button"
					name="Submit" id="Submit" value="Cancel" onClick="Cancel()" /> <input
					type="hidden" name="ALPNLP_id" value="<%=dbUser.locPropID%>" /> <input
					type="hidden" name="companyCode" value="<%=dbUser.companyCode%>" />
					<input type="hidden" name="customerMin"
					value="<%=dbUser.nationalAccountNbrMin%>" /> <input type="hidden"
					name="memberMaj" value="<%=dbUser.memberNbr%>" /> <input
					type="hidden" name="memberMin" value="<%=dbUser.memberMinNbr%>" />


					<!-- <button onClick="showSelected()">Show</button> 
        <button onClick="showUnSelected()">Show NON-SB</button> --></td>
			</tr>
		</table>


		</form>

		<%
}

if (actionType.equals("SaveSuperBuyer")) { 

String confirmMsg = "";
confirmMsg = "The super buyer location information was successfully saved.";

%>


		<span class="subTitle"> Customer: <%=dbUser.naNbrF%> - <%=dbUser.nationalAccountName%>
			- <%=dbUser.eplatform%><br /> Customer Location: <%=dbUser.nationalAccountNbrMin%>
			- <%=dbUser.nationalAccountMinName%><br /> <% if (dbUser.memberNbr.equals("0")) {} else { %>
			Member: <%=dbUser.memberNbr%> - <%=dbUser.memberMinNbr%> - <%=dbUser.memberName%>
			<% } %><br />
		<br /> <%=confirmMsg%></span><br /> <br />

		<table width="50%">
			<tr>
				<td>Super Buyer Locations</td>
			</tr>

			<% for (int s = 0; s < dbUser.superBuyerList.size(); s++) {
         Vector sbL = (Vector) dbUser.superBuyerList.elementAt(s); %>
			<tr>
				<td><%=sbL.elementAt(0)%> - <%=sbL.elementAt(1)%> - <%=sbL.elementAt(3)%></td>
			</tr>
			<%    }	
		%>


			<tr>
				<td colspan="2"><hr /></td>
			</tr>

			<tr>
				<td>Non-Super Buyer Locations</td>
			</tr>

			<%
		for (int n = 0; n < dbUser.superBuyerNonList.size(); n++) {
         Vector sbNonL = (Vector) dbUser.superBuyerNonList.elementAt(n); %>
			<tr>
				<td><%=sbNonL.elementAt(0)%> - <%=sbNonL.elementAt(1)%> - <%=sbNonL.elementAt(3)%></td>
			</tr>
			<%    }	
		%>


		</table>


		<% } //super buyer location info saved 
%>


	</div>

	<%@ include file="navMenu.jsp"%>


</body>
</html>