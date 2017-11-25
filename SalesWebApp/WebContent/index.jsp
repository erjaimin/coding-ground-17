<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!   String query1 = "SELECT CUSTOMER.CUSTOMER_ID, CUSTOMER.CUSTOMER_NAME "+ 
			    "FROM CUSTOMER INNER JOIN SALES_ORDER ON SALES_ORDER.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID "+
			    "GROUP BY CUSTOMER.CUSTOMER_ID, CUSTOMER.CUSTOMER_NAME";
	  String query2 = "SELECT SUM(SALES_ORDER_LINE_ITEM.QUANTITY) AS Quantity, "+ 
			    "BOM.OUTPUT_DESCRIPTION AS Product, SALES_ORDER.BILLING_DATE FROM SALES_ORDER_LINE_ITEM "+ 
			    "INNER JOIN sales_order ON SALES_ORDER_LINE_ITEM.SALES_ORDER_ID = SALES_ORDER.SALES_ORDER_ID "+ 
			    "INNER JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = SALES_ORDER.CUSTOMER_ID "+
			    "INNER JOIN BOM ON BOM.EFFECTIVE_DATE = SALES_ORDER.DELIVERY_DATE "+ 
			    "AND BOM.OUTPUT_PRODUCT_ID = SALES_ORDER_LINE_ITEM.PRODUCT_ID "+ 
			    "WHERE CUSTOMER.CUSTOMER_ID = ? GROUP BY "+
			    "BOM.OUTPUT_DESCRIPTION, SALES_ORDER.BILLING_DATE";
	  String query3 ="SELECT SIM_DATE.SIM_DATE FROM CURRENT_SIM_DATE "+
			    "INNER JOIN SIM_DATE ON CURRENT_SIM_DATE.CUR_NB_DAYS> = SIM_DATE.NB_DAYS "+
			    "WHERE VDAY <= MAX_DAYS_PER_ROUND";
%>
<sql:setDataSource var = "ERPSIM" driver = "com.mysql.jdbc.Driver"
         url = "jdbc:mysql://localhost:3306/ERPSIM"
         user = "root"  password = "system"/>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Sales Statistics</title>
	<style type="text/css">
		input{
		}
	</style>
	<c:set property="" value=""></c:set>
	<script type="text/javascript">
		/*function loadScript(){
			if(localStorage.getItem('selectedValue')){
				document.getElementById("customerDropDown").options[localStorage.getItem('selectedValue')].selected = true;
				localStorage.removeItem('selectedValue')
			}
		}*/
	
		function fetchClientDetails(e){
				var selectedValue= e.options[e.selectedIndex].value;
				document.getElementById('btnTable').style.display = "inline-block";
				document.getElementById('btnGraph').style.display = "inline-block";
				alert(selectedValue);
				<c:set var="customerId" property="selectedValue" value="${selectedValue}"/>
				 alert("${customerId}");
			if(e.selectedIndex > 0){
				 <sql:query dataSource="${ERPSIM}" var="products"><%=query2%>
				 	<sql:param value = "${customerId}" />
				 </sql:query>
				 <c:forEach items="${products.rows}" var="product">
					 alert("${product}");
				</c:forEach>
				//localStorage.setItem('selectedValue', e.selectedIndex);
				//window.location.replace("index.jsp?client="+selectedValue);
				<%
				/* String customerId=request.getParameter("client");
				if(customerId != null){
						long curCustomer = Long.valueOf(customerId);
						if(productsMap.containsKey(curCustomer)){
							curProductList = productsMap.get(curCustomer);
							System.out.println("if-->"+curProductList);
						}else{
							 ResultSet productResultSet=  statement.executeQuery(query2.replace("cust_id", customerId));
							 List<List<String>> productList = new ArrayList();
							 while(productResultSet.next()){
				        		  List<String> list = new ArrayList();
				        		  list.add(0,productResultSet.getString(1));
				        		  list.add(1,productResultSet.getString(2));
				        		  list.add(2,productResultSet.getString(3));
				        		  productList.add(list);
				        	  }
							 productsMap.put(curCustomer, productList);
							 curProductList = productList;
							 System.out.println("else-->"+curProductList);
						}
					}	 */
				%>
			}else{
				document.getElementById('btnTable').style.display = "none";
				document.getElementById('btnGraph').style.display = "none";
				<%
					/* if(curProductList != null){
				 	 curProductList.clear();
					} */
				%>
			}
		}
	</script>
</head>
<body>
    <sql:query dataSource="${ERPSIM}" var="clients"><%=query1%></sql:query>
	<form>
		<div class="header">
	         Client :
	         <select id="customerDropDown" onchange="fetchClientDetails(this);">
	            <option value = "-1" selected>--Choose Client--</option>
	            <c:forEach items="${clients.rows}" var="client">
	            	<option value = "${client.CUSTOMER_ID}">${client.CUSTOMER_NAME}</option>
	            </c:forEach>
	         </select>
		     <input type="button" id="btnTable" value="Table" />
		     <input type="button" id="btnGraph" value="Graph" />
	    </div>  
	    <div>
	    	<table>
			  <tr>
			  	<th>Date</th>
			  	<th>Product</th>
			  	<th>Quantity</th>
			  </tr>
			   <c:forEach items="${products.rows}" var="product">
				   <tr>
				   		<td>${product.BILLING_DATE}</td>
				   		<td>${product.Product}</td>
				   		<td>${product.Quantity}</td>
				  </tr>
	           </c:forEach>
			 
			</table>
	    </div>   
     </form>
</body>
</html>