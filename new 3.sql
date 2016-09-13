using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;

using HSCS.BIZ.T;
using HSCS.BIZ.UTL;


namespace HSCS.WEB.T
{
	/// <summary>
	/// HSCST0010에 대한 요약 설명입니다.
	/// </summary>
	public class HSCST0010 : PageBase
	{

		#region 변수 및 컨트롤 선언

		protected System.Web.UI.WebControls.DropDownList ddlSite;
		protected System.Web.UI.WebControls.DropDownList ddlUseYn;
		protected System.Web.UI.WebControls.Repeater rptList;
		protected System.Web.UI.WebControls.DataGrid dgList;
		protected System.Web.UI.HtmlControls.HtmlInputButton btnSearch;
		protected HSCS.WEB.Common.PageUtil util;

		protected HSCS.BIZ.UTL.BindSiteDDL m_bizObject = new HSCS.BIZ.UTL.BindSiteDDL();
		protected System.Web.UI.WebControls.Button btnAdd;
		protected System.Web.UI.WebControls.Button btnSave;
		protected System.Web.UI.WebControls.Button btnMoveUp;
		private PageUtility _util;
		
		private BIZ.T.C_CST010 cst = new C_CST010();
		
		private PageUtility getUtil()
		{
			if(_util == null)
				_util = new PageUtility(this.Page);
			return _util;
		}

		#endregion
	
		private void Page_Load(object sender, System.EventArgs e)
		{

			btnSave.Attributes.Add("onclick", "return confirm('저장 하시겠습니까??')"); 

			if(!IsPostBack)
			{
				m_bizObject.SetDDLSite(ddlSite, Session["LogID"]);

				if ( Request.QueryString["SiteCode"] != null )
				{
					ddlSite.SelectedValue = Request.QueryString["SiteCode"];
				}
				
				bind_dataGrid();
				
			}

			
		}

		private void bind_dataGrid()
		{
			DataSet ds = cst.GetT010List(ddlSite.SelectedValue);
			if(ds != null)
			{
				rptList.DataSource = ds;
				rptList.DataBind();
			}
			else
			{
				rptList.DataSource = ds;
				rptList.DataBind();
			}
		}

		protected void siteChange(object sender, EventArgs e)
		{
			bind_dataGrid();
		}

		protected void addNewRow(object sender, EventArgs e)
		{
			addRow();
		}

		private void addRow()
		{

			DataTable dtParams =  new DataTable(); 
			dtParams.Columns.Add(new DataColumn("SEQ_NO", typeof(String)));
			dtParams.Columns.Add(new DataColumn("COMMON_TXT", typeof(String))); 
			dtParams.Columns.Add(new DataColumn("USE_YN", typeof(String)));
			dtParams.Columns.Add(new DataColumn("UPD_IDNM", typeof(String))); 
			dtParams.Columns.Add(new DataColumn("UPD_DATE", typeof(String)));
			dtParams.Columns.Add(new DataColumn("FLAG", typeof(String)));
			DataRow dr2 = dtParams.NewRow(); 
			int seq = 0;
			foreach (RepeaterItem item in rptList.Items) 
			{
				DataRow dr = dtParams.NewRow(); 
				

				Literal ltrSeq = (Literal)item.FindControl("ltrSeq");
				dr["SEQ_NO"] = ltrSeq.Text; 

				TextBox txtCommonTxt = (TextBox)item.FindControl("txtCommonTxt");
				dr["COMMON_TXT"] = txtCommonTxt.Text; 

				DropDownList ddlUseYn = (DropDownList)item.FindControl("ddlUseYn");
				dr["USE_YN"] = ddlUseYn.SelectedValue;

				Literal ltrUpdIdNm = (Literal)item.FindControl("ltrUpdIdNm");
				dr["UPD_IDNM"] = ltrUpdIdNm.Text; 

				Literal ltrUpdDate = (Literal)item.FindControl("ltrUpdDate");
				dr["UPD_DATE"] = ltrUpdDate.Text; 

				Literal ltrFlag = (Literal)item.FindControl("ltrFlag");
				dr["FLAG"] = ltrFlag.Text; 

				dtParams.Rows.Add(dr);
				
				seq++;

			}
			dr2["SEQ_NO"] = 0;
			dr2["USE_YN"] = "Y";
			dr2["UPD_DATE"] = null;
			dtParams.Rows.Add(dr2);
			rptList.DataSource = dtParams; 
			rptList.DataBind();
		}

		protected void save_Click(object sender, EventArgs e)
		{
			
			saveData();
		}

		private void saveData()
		{
			int Cnt = 0;

			foreach (RepeaterItem ri in rptList.Items)
			{
				TextBox txtCommonTxt = (TextBox)ri.FindControl("txtCommonTxt");
				Literal ltrSeq = (Literal)ri.FindControl("ltrSeq");
				Literal ltrFlag = (Literal)ri.FindControl("ltrFlag");
				DropDownList ddlUseYn = (DropDownList)ri.FindControl("ddlUseYn");

				

				if (txtCommonTxt != null && txtCommonTxt.Text != "")
				{
					int p1 = 0;
					string p2 = string.Empty;
					string p3 = string.Empty;
					string p4 = string.Empty;
					string pf = string.Empty;

					p1 = Int32.Parse(ltrSeq.Text);
					p2 = ddlSite.SelectedValue;
					p3 = txtCommonTxt.Text;
					p4 = ddlUseYn.SelectedValue;
					pf = ltrFlag.Text;

					Cnt++;
					bool iRtn = false;
					
					if (pf != "D")
					{
						try
						{
							iRtn = cst.SaveT010(p1, p2, p3, p4);
						}

						catch (Exception ex)
						{
							throw ex;
						}
					}

					if (pf == "D")	//삭제 flag 
					{
						try
						{
							iRtn = cst.DeleteT010(p1, p2, p3);
						}

						catch (Exception ex)
						{
							throw ex;
						}
					}
				}
				
			}
			getUtil().AlertMessage("저장 하였습니다.");
			bind_dataGrid();
		}


		protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.ItemType.Equals(ListItemType.Item) || e.Item.ItemType.Equals(ListItemType.AlternatingItem))
			{
				RepeaterItem item = e.Item as RepeaterItem;
				DataRowView Dr = (DataRowView)item.DataItem;

				HtmlTableRow tr = item.FindControl("tr") as HtmlTableRow;

				Literal ltrSeq =  item.FindControl("ltrSeq") as Literal;
				TextBox txtCommonTxt =  item.FindControl("txtCommonTxt") as TextBox;
				DropDownList ddlUseYn = (DropDownList)e.Item.FindControl("ddlUseYn");
				Literal ltrUpdIdNm =  item.FindControl("ltrUpdIdNm") as Literal;
				Literal ltrUpdDate =  item.FindControl("ltrUpdDate") as Literal;
				Literal ltrFlag =  item.FindControl("ltrFlag") as Literal;
				

				ltrSeq.Text = Dr["SEQ_NO"].ToString();
				txtCommonTxt.Text = Dr["COMMON_TXT"].ToString();
				ddlUseYn.SelectedValue = Dr["USE_YN"].ToString();
				ltrUpdIdNm.Text = Dr["UPD_IDNM"].ToString();
				ltrUpdDate.Text = Dr["UPD_DATE"].ToString();
				ltrFlag.Text = Dr["FLAG"].ToString();

				
			}
		}


		protected void status_Change (object sender, EventArgs e)
		{
//			TextBox commonTxt = ((TextBox) (sender));
//
//			RepeaterItem rp1 = ((RepeaterItem)(commonTxt.NamingContainer));
//
//			Literal ltrFlag = (Literal)rp1.FindControl("ltrFlag");
			//ltrFlag.Text = "U";


		}

		protected void moveUp (object source, EventArgs e) 
		{
			rowUp();
		}

		protected void rptItemCommand (object source, RepeaterCommandEventArgs e) 
		{

			//행삭제
			if (e.CommandName == "del_Click")
			{
			   //Literal ltrSeq = 	e.Item.FindControl("ltrSeq") as Literal;
				e.Item.Visible = false;
				Literal ltrFlag =  e.Item.FindControl("ltrFlag") as Literal;
				ltrFlag.Text = "D";
			}
			

			//순번 up
			if (e.CommandName == "up_Click")
			{
				string indX;


				if (e.Item.ItemIndex == 0)
				{
					Response.Write("top");			
				}
				else 
				{
					
					
				}
			}
		}
		
		private void rowUp ()
		{
			Response.Write("up");			
		}

		protected void moveDn (object source, EventArgs e)
		{
			
			
			Response.Write("dn");
			
		}




		#region Web Form 디자이너에서 생성한 코드
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: 이 호출은 ASP.NET Web Form 디자이너에 필요합니다.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// 디자이너 지원에 필요한 메서드입니다.
		/// 이 메서드의 내용을 코드 편집기로 수정하지 마십시오.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
			this.btnAdd.Click += new System.EventHandler(this.addNewRow);
			this.btnSave.Click += new System.EventHandler(this.save_Click);
			

		}
		#endregion
	}
}
