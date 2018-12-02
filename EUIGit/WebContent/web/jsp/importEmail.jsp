<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>


<script language="Javascript">
	//function CancelForm() { //cancel out of import, return to formulary display for same customer & member
		//document.importE.actionType.value ="Home";
		//document.importE.page.value = "index.jsp";
		//document.importE.submit();
	//}
	
	function UploadEmail() { 
		if (document.importE.eplatform.value=="none") {
			alert("Select an Ecommerce Platform.");
			document.importE.eplatform.focus();
		}
		else {
		document.importE.actionType.value ="ImportEmail";
		document.importE.page.value = "importEmail.jsp";
		document.importE.submit();
		}
	}
	
</script>


<script type="text/javascript">
function noenter() {
  return !(window.event && window.event.keyCode == 13); }
</script>

<%
   String actionType = (String)request.getParameter("actionType");
	
   %>

<form
	action="ControllerServlet?page=importEmail.jsp&actionType=ImportEmail"
	enctype="multipart/form-data" method="post" name="importE" id="importE">
	<!--action => ?page=importEmail.jsp&actionType=ImportEmail -->
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputField">
		<span class="subTitle">Import Emails</span>

		<table border="0">
			<tr>
				<td>Ecommerce Platform:</td>
				<td><select name="eplatform" id="eplatform">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int i = 0; i < dbUser.ecPlatformList.size(); i++) {
         Vector ecPlatform = (Vector) dbUser.ecPlatformList.elementAt(i); %>
						<option value="<%=ecPlatform.elementAt(0)%>"><%=ecPlatform.elementAt(1)%></option>
						<%    }			
%>
				</select></td>
			</tr>
			<tr>
				<td>Excel File:</td>
				<td><input name="emailFile" type="file" id="emailFile"
					size="75" onkeypress="return noenter()" /></td>
			</tr>

			<tr>
				<td colspan="2"><input type="button" name="import" id="import"
					value="Import" onclick="javascript:UploadEmail()" /> <!-- <input type="button" name="cancel" id="cancel" value="Cancel" onclick="javascript:CancelForm()" />   -->
				</td>
			</tr>
		</table>

		<br /> <br /> <span class="totRecords">Example of Excel
			Format:</span><br /> <img src="web/images/importEmail.jpg" width="397"
			height="181" border="0" alt="Format of Excel File">
	</div>

</form>


<%@ include file="navMenu.jsp"%>
