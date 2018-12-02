<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>

<%
String actionType = (String)request.getParameter("actionType");
%>
<script language="Javascript">
   
   function ECAction() {
   		if (document.ecAction.ecAction.value=="0") {
			alert("Select an Ecommerce action you would like to perform.");
			document.ecAction.ecAction.focus();
		} else {
			if (document.ecAction.ecAction.value=="newNA") {
				document.ecAction.actionType.value = "NewNA";
				document.ecAction.page.value="newNA.jsp";
				document.ecAction.submit();
			}
			if (document.ecAction.ecAction.value=="updateNA") {
				document.ecAction.actionType.value = "UpdateNA";
				document.ecAction.page.value="updateNA.jsp";
				document.ecAction.submit();
			}
			if (document.ecAction.ecAction.value=="updateMember") {
				document.ecAction.actionType.value = "UpdateMember";
				document.ecAction.page.value="updateMember.jsp";
				document.ecAction.submit();
			}
			if (document.ecAction.ecAction.value=="updateLocation") {
				document.ecAction.actionType.value = "UpdateLocation";
				document.ecAction.page.value="updateLocation.jsp";
				document.ecAction.submit();
			}
			if (document.ecAction.ecAction.value=="importE") {
				document.ecAction.actionType.value = "Import";
				document.ecAction.page.value="importEmail.jsp";
				document.ecAction.submit();
			}
			if (document.ecAction.ecAction.value=="superBuyer") {
				document.ecAction.actionType.value = "SuperBuyer";
				document.ecAction.page.value="superBuyer.jsp";
				document.ecAction.submit();
			}
		}
	}
   
</script>


<form action="ControllerServlet" method="post" name="ecAction">
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputField">
		<span class="subTitle">Select an Action</span> <br /> <br />
		<table>
			<tr>
				<td><select name="ecAction" onChange="javascript:ECAction()">
						<option value='0' selected="selected">--- Select One ---</option>
						<option value="newNA">Add New National Account</option>
						<option value="updateNA">Update National Account</option>
						<option value="updateMember">Update Member</option>
						<option value="updateLocation">Update Location</option>
						<option value="superBuyer">Super Buyer</option>
						<option value="importE">Import Email</option>
				</select></td>
		</table>


	</div>
</form>

<div id="actionField">

	<!-- list expire reports -->



</div>


<%@ include file="navMenu.jsp"%>

</body>
</html>