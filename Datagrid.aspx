<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Datagrid.aspx.cs" Inherits="Datagrid.Datagrid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   <script type="text/javascript" >
      function rowUp(idx) {
         if (idx == 0) {
            return;
         }
         i = Number(idx) - 1;     // 대상
         k = Number(idx);    // event.this

         var objUpCommonTxt = document.getElementById("rptList_txtCommonTxt_" + i);      // 대상 id
         var objUpUseYn = document.getElementById("rptList_ddlUseYn_" + i);      // 대상 id
         var objOrgCommonTxt = document.getElementById("rptList_txtCommonTxt_" + k);      // 원본 id
         var objOrgUseYn = document.getElementById("rptList_ddlUseYn_" + k);      // 원본 id

         var valUpCommonTxt = objUpCommonTxt.value;
         var valUpUseYn = objUpUseYn[objUpUseYn.selectedIndex].value;
         var valOrgCommonTxt = objOrgCommonTxt.value
         var valOrgUseYn = objOrgUseYn[objOrgUseYn.selectedIndex].value;

         objUpCommonTxt.value = valOrgCommonTxt;
         objOrgCommonTxt.value = valUpCommonTxt;
         objUpUseYn.value = valOrgUseYn;
         objOrgUseYn.value = valUpUseYn;
      }

      function rowDn(idx) {
         i = Number(idx) + 1;     // 대상
         k = Number(idx);    // event.this

         var objUpCommonTxt = document.getElementById("rptList_txtCommonTxt_" + i);      // 대상 id
         var objUpUseYn = document.getElementById("rptList_ddlUseYn_" + i);      // 대상 id
         var objOrgCommonTxt = document.getElementById("rptList_txtCommonTxt_" + k);      // 원본 id
         var objOrgUseYn = document.getElementById("rptList_ddlUseYn_" + k);      // 원본 id

         if (objUpCommonTxt == null){
            return;
         }

         var valUpCommonTxt = objUpCommonTxt.value;
         var valUpUseYn = objUpUseYn[objUpUseYn.selectedIndex].value;
         var valOrgCommonTxt = objOrgCommonTxt.value
         var valOrgUseYn = objOrgUseYn[objOrgUseYn.selectedIndex].value;

         objUpCommonTxt.value = valOrgCommonTxt;
         objOrgCommonTxt.value = valUpCommonTxt;
         objUpUseYn.value = valOrgUseYn;
         objOrgUseYn.value = valUpUseYn;

      }

      function valChange(idx) {
         i = Number(idx);
         var objFlag = document.getElementById("rptList_ltrFlag_" + i);
         objFlag.value = "C";
      }

      function addRow() {
         var table = document.getElementById("rptList");
         var rowCount = table.rows.length;
         var row = table.insertRow(rowCount);
         // Create any cells and elements you need
         var cell1 = row.insertCell(0);
         var element1 = document.createElement("input");
         element1.type = "text";
         cell1.appendChild(element1);

      }
   </script>
</head>
<body>
    <form id="form1" runat="server">
       <table>
          <td align="right" style="width:100px">
            <asp:button id="btnAdd" Width="100%" runat="server" Text="AddRow" CssClass="incButton" OnClick="addNewRow"></asp:button>
          </td>
       </table>
    <table cellSpacing="1" cellPadding="0" width="100%" border="0" bgColor="#CCCCCC" >
							<asp:Repeater ID="rptList" Runat="server" OnItemDataBound="rptList_ItemDataBound" OnItemCommand="rptItemCommand" >
								<HeaderTemplate>
									<tr class="listTitle">
										
										<th style="display:none">
											순번</th>
										<th>
											Text</th>
										<th>
											정렬순서</th>
										<th>
											사용여부</th>
										<th>
											최종입력자</th>
										<th>
											최종등록일</th>
										<th>
											삭제</th>
										<th style="display:none">
											우선순위(data)</th>
										<th >
											flag</th>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr style="BORDER-TOP: #000000 solid; BORDER-RIGHT: #000000 solid; BORDER-BOTTOM: #000000 solid; BORDER-LEFT: #000000 solid; BACKGROUND-COLOR: white">
										<td style="display:none">
											<asp:Literal ID="ltrSeq" Runat="server"></asp:Literal></td>
										<td>
											<asp:TextBox ID="txtCommonTxt" CssClass="tdTxtBox" runat="server"   ></asp:TextBox></td>
										<td align="center">
											<table>
												<tr>
													<td>
														<asp:ImageButton ID="btnMoveUp" Runat="server" ImageUrl="~/img/up.png" Width="30" Height="20"   ></asp:ImageButton></td>
													<td>
														<asp:Button ID="btnMoveDn" Runat="server" Text="▽" CommandName="dn_Click"></asp:Button></td>
												</tr>
											</table>
										</td>
										<td align="center">
											<asp:DropDownList ID="ddlUseYn" Runat="server">
												<asp:ListItem Value="Y" Text="사용"></asp:ListItem>
												<asp:ListItem Value="N" Text="미사용"></asp:ListItem>
											</asp:DropDownList></td>
										<td>
											<asp:Literal ID="ltrUpdIdNm" Runat="server"></asp:Literal></td>
										<td>
											<asp:Literal ID="ltrUpdDate" Runat="server"></asp:Literal></td>
										<td align="center">
											<asp:Button ID="btnDel" Runat="server" Text="X" CommandName="del_Click"></asp:Button></td>
										<td style="display:none">
											<asp:Literal ID="ltrOrderSeq" Runat="server"></asp:Literal></td>
										<td >
											<asp:Literal ID="ltrFlag" Runat="server"></asp:Literal></td>
									</tr>
								</ItemTemplate>
							</asp:Repeater>
						</table>
       <table>
             <tr>
                <td>
                   <asp:Button ID="btnSave" runat="server" Text="저장" OnClick="save_Click" />
                </td>
                <td>
                   <input ID="btnAddRow" type="button" name="행추가" OnClick="addRow()" />
                </td>
             </tr>
          </table>
    </form>
</body>
</html>
