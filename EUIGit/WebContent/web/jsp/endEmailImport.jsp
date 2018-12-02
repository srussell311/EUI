
<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>


<form>
	<div id="inputField">
		<span class="subTitle">Import Emails<br />
		<br /> <% //if (dbUser.readXL.goodImport.equals("Y")) {  %> The import
			was successfully completed.
		</span><br />

		<% //} else { %>

		<span class="errorField">The import failed. Either the imported
			file could not be found or there was problem with the formatting of
			the file. Please <a
			href="ControllerServlet?page=importEmail.jsp&action=Import">try
				again</a>.
		</span><br />
		<% //} %>

	</div>

</form>
<%@ include file="navMenu.jsp"%>
