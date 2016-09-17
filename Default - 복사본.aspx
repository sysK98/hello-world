<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   <script type="text/javascript">
      $(document).ready(function () {
         $("#btnInsert").click(function () {
            var data = {
               details: {
                  RollNo: $("#txtRollNo").val(),
                  FirstName: $("#txtFirstName").val(),
                  LastName: $("#txtLastName").val(),
                  MobileNo: $("#txtMobileNo").val()
               }
            };
            $.ajax({
               url:"Default.aspx/InsertStudent",
            data:JSON.stringify(data),
            datatype: "json",
            type: "POST",
               contentType: "application/json; charset=utf-8",
            success:function(result){
               alert(result.d);
            }
            });
            return false;
         });

         $("#btnUpdate").click(function () {
            var data = {
               details: {
                  RollNo: $("#txtRollNo").val(),
                  FirstName: $("#txtFirstName").val(),
                  LastName: $("#txtLastName").val(),
                  MobileNo: $("#txtMobileNo").val()
               }
            };
            $.ajax({
               url: "Default.aspx/UpdateStudent",
               data: JSON.stringify(data),
               datatype: "json",
               type: "POST",
               contentType: "application/json; charset=utf-8",
               success: function (result) {
                  alert(result.d);
               }
            });
            return false;
         });

         $("#btnDelete").click(function () {
            var data = { rollno: $("#txtRollNo").val() };
            $.ajax({
               url: "Default.aspx/DeleteStudent",
               data: JSON.stringify(data),
               datatype: "json",
               type: "POST",
               contentType: "application/json; charset=utf-8",
               success: function (result) {
                  alert(result.d);
               }
            });
            return false;
         });
      });
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <center>
               <table>
                  <tr>
                     <th>Roll No:</th>
                     <td>
                        <asp:TextBox runat="server" ID="txtRollNo" />
                     </td>
                  </tr>
                  <tr>
                     <th>
                        First name :
                     </th>
                     <td>
                        <asp:TextBox runat="server" ID="txtFirstName" />
                     </td>
                  </tr>
                  <tr>
                     <th>
                        Last Name :
                     </th>
                     <td>
                        <asp:TextBox runat="server" ID="txtLastName" />
                     </td>
                  </tr>
                  <tr>
                     <th>
                        Mobileno :
                     </th>
                     <td>
                        <asp:TextBox runat="server" ID="txtMobileNo" />
                     </td>
                  </tr>
                  <tr>
                     <th colspan="2">
                        <asp:Button Text="Insert" ID="btnInsert" runat="server" OnClick="btnInsert_Click" />
                        <asp:Button Text="Update" ID="btnUpdate" runat="server" />
                        <asp:Button Text="Delete" ID="btnDelete" runat="server" />
                     </th>
                  </tr>
               </table>
         </center>
    </div>
    </form>
</body>
</html>
