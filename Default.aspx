<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="app.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.15/jquery-ui.min.js"
        type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
       <script>
        $(function () {

            $("#table1 tbody.rep-drag").sortable({
                revert: true
            });
            $("#table1 tbody.rep-drag").disableSelection();

        });
    </script>
       <div>
       <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="rptList_ItemDataBound" >
               <HeaderTemplate>
                   <table id="table1">
                       <thead>
                           <tr>
                           <th>
                                   seq_no
                               </th>
                               <th>
                                   Text
                               </th>
                               <th>
                                   use
                               </th>
                               <th>
                                   upd_idnm
                               </th>
                              <th>
                                   upd_date
                               </th>
                              <th>
                                   flag
                               </th>
                           </tr>
                       </thead>
                       <tbody class="rep-drag">
               </HeaderTemplate>
               <ItemTemplate>
                   <tr>
                   <td >
                      <asp:Literal ID="ltrSeq" Runat="server"></asp:Literal></td>
                           <%--<%# DataBinder.Eval(Container,"DataItem.SEQ_NO") %>--%>
                       </td>
                       <td>
                          <asp:TextBox ID="txtCommon" runat="server"></asp:TextBox>
                           <%--<%# DataBinder.Eval(Container,"DataItem.COMMON_TXT") %>--%>
                       </td>
                       <td>
                          <asp:DropDownList ID="ddlUseYn" Runat="server">
												<asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
												<asp:ListItem Value="N" Text="No"></asp:ListItem>
											</asp:DropDownList>
                           <%--<%# DataBinder.Eval(Container,"DataItem.USE_YN") %>--%>
                       </td>
                       <td>
                          <asp:Literal ID="ltrUpdIdNm" Runat="server"></asp:Literal></td>
                           <%--<%# DataBinder.Eval(Container,"DataItem.UPD_IDNM") %>--%>
                          
                       </td>
                      <td>
                         <asp:Literal ID="ltrUpdDate" Runat="server"></asp:Literal></td>
                           <%--<%# DataBinder.Eval(Container,"DataItem.UPD_DATE") %>--%>
                       </td>
                      <td>
                           <%# DataBinder.Eval(Container,"DataItem.FLAG") %>
                       </td>
                   </tr>
               </ItemTemplate>
               <FooterTemplate>
                   </tbody>
                   <tfoot>
                       <tr>
                           <th colspan="2">
                               &nbsp
                           </th>
                           <th>
                               <div id="total">
                               </div>
                           </th>
                       </tr>
                   </tfoot>
                   </table>
               </FooterTemplate>
           </asp:Repeater>
          <table>
             <tr>
                <td>
                   <asp:Button ID="btnSave" runat="server" Text="저장" OnClick="save_Click" />
                </td>
             </tr>
          </table>
    </div>
    </form>
</body>
</html>
