<%-- 
    Document   : myaccount
    Created on : Mar 4, 2024, 12:12:29 AM
    Author     : Tran Duy Dat - CE172036
--%>

<%@page import="Model.Administrator"%>
<%@page import="DAOs.AdministratorDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@include  file="components/head.jsp" %>
    </head>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="date"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
          input[type="email"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 10px 20px;
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .small {
            display: block;
            font-size: 14px; /* Kích thước chữ */
            color: red; /* Màu chữ */
        }
    </style>


    <body>
        <%@include  file="components/header.jsp" %>

        <%            if (cList != null) {
                for (Cookie c : cList) {
                    if (c.getName().equals("Administrator")) {
                        phone_number = c.getValue();
                        break;
                    }
                }
            }
            AdministratorDAO pDAO = new AdministratorDAO();
            ResultSet rs = pDAO.getAll(phone_number);
            AdministratorDAO dDAO = new AdministratorDAO();
            Administrator ra = dDAO.getInfo(phone_number);

            while (rs.next()) {
        %>

        <h2>Information of <%= ra.getName()%></h2>
        <form action="/Management" method="POST">
            <label for="value1">Phone_Number:</label><br>
            <input type="text" id="value1" name="phone_number" value="<%= rs.getString(1)%>"><br>

            <label for="value2">Email:</label><br>
            <input type="email" id="value2" name="email" value="<%= rs.getString(2)%>" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required><br>
            <%
                String emailFail = (String) request.getSession().getAttribute("emailFail");
                if (emailFail != null) {
            %>
            <small class="small"> <%= emailFail%> </small>
            <%
                    request.getSession().removeAttribute("emailFail");
                }
            %>
            <label for="value3">Name:</label><br>
            <input type="text" id="value3" name="name" value="<%= rs.getString(4)%>" required><br>

            <label for="female">Gender:</label>
            <div class="radio-container">
                <input type="radio" id="female" name="gender" value="Female" <%=rs.getString(5).equalsIgnoreCase("Female") ? "checked" : ""%>>
                <label for="female">Female</label>
            </div>

            <div class="radio-container">
                <input type="radio" id="male" name="gender" value="Male" <%=rs.getString(5).equalsIgnoreCase("Male") ? "checked" : ""%>>
                <label for="male">Male</label>
            </div>

            <label for="value5">Birthday:</label><br>
            <input type="date" id="value5" name="birthday" value="<%= rs.getString(6)%>"><br>
            <%
                String invalidDay = (String) request.getSession().getAttribute("invalidDay");
                if (invalidDay != null) {
            %>
            <small class="small">   <%= invalidDay%>  </small>
            <%
                    request.getSession().removeAttribute("invalidDay");

                }
            %>

            <label for="value6">Address:</label><br>
            <input type="text" id="value6" name="address" value="<%= rs.getString(7)%>" required><br>


            <button id="btnSave" type="submit" name="submit_saveAdmin">Save</button>
        </form>

        <%
            }
        %>
    </body>
</html>
