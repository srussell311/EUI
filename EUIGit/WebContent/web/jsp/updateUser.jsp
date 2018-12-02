<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>
<html>
<body id="wrapper">
<%
String actionType = (String)request.getParameter("actionType");
%>
<script language="Javascript">
	
   function UpdateUser() {
		if (document.updateU.pswd.value=="") {
			alert("Enter your current password.");
			document.updateU.pswd.focus();
		} else if (document.updateU.newPswd.value=="") {
			alert("You need to enter a new password.");
			document.updateU.newPswd.focus();
		} else if (document.updateU.confirmPswd.value=="") {
			alert("You need to confirm the new password.");
			document.updateU.confirmPswd.focus();
		} else if (document.updateU.newPswd.value != document.updateU.confirmPswd.value) {
			alert("You did not enter the same password twice.  Try again.");
			document.updateU.newPswd.focus();
		} else {
			document.updateU.page.value = "updateUser.jsp";
			document.updateU.actionType.value = "UpdateUser";
			document.updateU.submit();
		}
	}
   
</script>


<form action="ControllerServlet" method="post" name="updateU">
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputField">
		<span class="subTitle">Modify Profile</span><br /> <br />

		<% if (actionType.equals("ModifyProfile")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Current User:</td>
				<td><%=dbUser.getUserLogin()%></td>
			</tr>
			<tr>
				<td>Enter Current Password:</td>
				<td><input name="pswd" type="password" id="pswd" size="20"
					maxlength="20" /></td>
			</tr>
			<tr>
				<td>New Password:</td>
				<td><input name="newPswd" type="password" id="newPswd"
					size="20" maxlength="20" /></td>
			</tr>
			<tr>
				<td>Confirm New Password:</td>
				<td><input name="confirmPswd" type="password" id="confirmPswd"
					size="20" maxlength="20" /></td>
			</tr>
			<tr>
				<td colspan="2"><input name="save" type="button" id="save"
					value="Save" onClick="javascript:UpdateUser()" /></td>
			</tr>
		</table>

		<% } else if (actionType.equals("UpdateUser")) { 
   		if (dbUser.userUpdate.equals("Y")) {
   		%>
		<span class="requiredField">The user password has been
			successfully changed. Use the new password the next time you login to
			the Ecommerce UI.</span>
		<% } else { %>
		<span class="requiredField">The user password was not
			successfully changed. The current password entered did not match was
			is currently saved for this user.</span>
		<% } %>
		<% } else {} %>

	</div>
</form>



<%@ include file="navMenu.jsp"%>
</body>
</html>
