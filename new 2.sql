<%@ Page language="c#" Codebehind="HSCST0010.aspx.cs" AutoEventWireup="false" Inherits="HSCS.WEB.T.HSCST0010" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>HSCST0010</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="Expires" content="0">
		<meta http-equiv="Last-Modified" content="0">
		<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
		<meta http-equiv="Pragma" content="no-cache">
		<script type=text/javascript language="javascript">
		
		</script>
	</HEAD>
	<body>
		<form id="HSCST0010" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" class="tblLayout">
				<tr>
					<td valign="top" width="10"><img height="512" src="../img/main_left01.gif" width="10"></td>
					<td valign="top" align="center">
						<!-- Main Title Start -->
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td class="topStyle"></td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="0" width="100%" border="0" class="tblTopTitle">
										<tr>
											<td class="topSpace"></td>
										</tr>
										<tr>
											<td class="Title01"><img height="15" src="../img/Tit_icon01.gif" width="27" align="absMiddle">점검입력 
												상용구 관리</td>
											<td class="post"><img height="7" src="../img/main_posticon01.gif" width="9"><span class="pageLocation">환경설정 
													&gt; 상용구 관리 &gt; <span class='subTitle'>점검입력 상용구 관리</span></span></td>
										</tr>
										<tr>
											<td class="topSpace_1"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!--Main Title END -->
						<!--TitleLine Start-->
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="5"><img height="5" src="../img/main_lineleft01.gif" width="5"></td>
								<td class="line01"></td>
								<td width="5"><img height="5" src="../img/main_linerignt01.gif" width="5"></td>
							</tr>
							<tr>
								<td colspan="3"></td>
							</tr>
						</table>
						<!--TitleLine END-->
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<colgroup>
								<col align="left" width="6%">
								<col align="left" width="78%">
								<col align="left" width="16%">
							</colgroup>
							<tr>
								<td class="Title03" colspan="3"><img src="../img/img_stit.gif" class="subIcon" align="left">PQC 
									상용구 관리</td>
							</tr>
							<tr style="HEIGHT:25px;COLOR:#6d6d6d;BACKGROUND-COLOR:#f7f7f7">
								<td align="center">
									<b>현장</b>
								</td>
								<td align="left">
									<asp:DropDownList ID="ddlSite" Runat="server" Width="220px" AutoPostBack="True" OnSelectedIndexChanged="siteChange"></asp:DropDownList>
								</td>
								<td class="btnLayoutStyle" rowspan="5" width="120" style="VERTICAL-ALIGN:top">
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td align="left"><img src="../img/c_btn_left.gif"></td>
														<td class="btnon" align="left" style="WIDTH:50px"><asp:button id="btnAdd" Width="100%" runat="server" Text="행추가" CssClass="incButton"></asp:button></td>
														<td align="left"><img src="../img/c_btn_right.gif"></td>
													</tr>
												</table>
											</td>
											<td class="btnSpace"></td>
											<td>
												<table border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td align="left"><img src="../img/c_btn_left.gif"></td>
														<td class="btnon" align="left" style="WIDTH:32px"><asp:button id="btnSave" Width="32px" runat="server" Text="저장" CssClass="incButton"></asp:button></td>
														<td align="left"><img src="../img/c_btn_right.gif"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table>
							<tr>
							</tr>
						</table>
						<table cellSpacing="1" cellPadding="0" width="100%" border="0" bgColor="#CCCCCC" >
							<asp:Repeater ID="rptList" Runat="server" OnItemDataBound="rptList_ItemDataBound" OnItemCommand="rptItemCommand">
								<HeaderTemplate>
									<tr class="listTitle">
										
										<th style="display:none">
											순번</th>
										<th>
											상용구</th>
										<th>
											우선순위</th>
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
										<th style="display:none">
											flag</th>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr style="BORDER-TOP: #000000 solid; BORDER-RIGHT: #000000 solid; BORDER-BOTTOM: #000000 solid; BORDER-LEFT: #000000 solid; BACKGROUND-COLOR: white">
										<td style="display:none">
											<asp:Literal ID="ltrSeq" Runat="server"></asp:Literal></td>
										<td>
											<asp:TextBox ID="txtCommonTxt" CssClass="tdTxtBox" runat="server" AutoPostBack="False"  ></asp:TextBox></td>
										<td align="center">
											<table>
												<tr>
													<td>
														<asp:Button ID="btnMoveUp" Runat="server" Text="↑" CommandName="up_Click"></asp:Button></td>
													<td>
														<asp:Button ID="btnMoveDn" Runat="server" Text="↓" CommandName="dn_Click"></asp:Button></td>
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
										<td style="display:none">
											<asp:Literal ID="ltrFlag" Runat="server"></asp:Literal></td>
									</tr>
								</ItemTemplate>
							</asp:Repeater>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
