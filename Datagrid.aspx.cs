using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;

namespace Datagrid
{
   public partial class Datagrid : System.Web.UI.Page
   {
      private string p1;

      private int p2;
      private string p3;
      protected System.Web.UI.WebControls.Button btnAdd;

      protected void Page_Load(object sender, EventArgs e)
      {
         if (!IsPostBack)
         {
            SqlCommand cmd = new SqlCommand("select * from csp020 order by order_seq", new SqlConnection(@"Data Source=SYSK-PC\SQLEXPRESS;Initial Catalog=DemoDB;Integrated Security=True"));
            cmd.Connection.Open();
            rptList.DataSource = cmd.ExecuteReader();
            rptList.DataBind();
            cmd.Connection.Close();
            cmd.Connection.Dispose();
         }
         

      }

      protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
      {
            if (e.Item.ItemType.Equals(ListItemType.Item) || e.Item.ItemType.Equals(ListItemType.AlternatingItem))
            {
               RepeaterItem item = e.Item as RepeaterItem;
               //System.Data.Common.DbDataRecord Dr = (System.Data.Common.DbDataRecord)item.DataItem;
               IDataRecord Dr = (IDataRecord)item.DataItem;

               HtmlTableRow tr = item.FindControl("tr") as HtmlTableRow;

               Literal ltrSeq = item.FindControl("ltrSeq") as Literal;
               TextBox txtCommonTxt = item.FindControl("txtCommonTxt") as TextBox;
               DropDownList ddlUseYn = (DropDownList)e.Item.FindControl("ddlUseYn");
               Literal ltrUpdIdNm = item.FindControl("ltrUpdIdNm") as Literal;
               Literal ltrUpdDate = item.FindControl("ltrUpdDate") as Literal;
               Literal ltrFlag = item.FindControl("ltrFlag") as Literal;
               ImageButton btnMoveUp = item.FindControl("btnMoveUp") as ImageButton;
               Button btnMoveDn = item.FindControl("btnMoveDn") as Button;

               ltrSeq.Text = Dr["SEQ_NO"].ToString();
               txtCommonTxt.Text = Dr["COMMON_TXT"].ToString();
               ddlUseYn.SelectedValue = Dr["USE_YN"].ToString();
               ltrUpdIdNm.Text = Dr["UPD_IDNM"].ToString();
               ltrUpdDate.Text = Dr["UPD_DATE"].ToString();
               ltrFlag.Text = Dr["FLAG"].ToString();

               //btnMoveUp.Attributes.Add("onclick", "return rowUp('" + item.ItemIndex + "', '" + txtCommonTxt.ClientID + "' , '" + ddlUseYn.ClientID + "' , '" + ltrUpdIdNm.ClientID + "' , '" + ltrUpdDate.ClientID + "' );");
               btnMoveUp.Attributes.Add("onclick", "return rowUp('" + item.ItemIndex + "');");
               btnMoveDn.Attributes.Add("onclick", "return rowDn('" + item.ItemIndex + "');");
               txtCommonTxt.Attributes.Add("OnTextChanged", "return valChange('" + item.ItemIndex + "');");



            }
      }


      protected void save_Click(object sender, EventArgs e)
      {
         saveData();
      }

      private void saveData()
      {

         for (int i = 0; i < rptList.Items.Count; i++)
         {
            TextBox txtCommonTxt = rptList.Items[i].FindControl("txtCommonTxt") as TextBox;
            Literal ltrSeq = rptList.Items[i].FindControl("ltrSeq") as Literal;
            DropDownList ddlUseYn = rptList.Items[i].FindControl("ddlUseYn") as DropDownList;

            p1 = txtCommonTxt.Text;
            p2 = Int32.Parse(ltrSeq.Text);
            p3 = ddlUseYn.SelectedValue;

            try
            {
               SqlConnection cn = new SqlConnection(@"Data Source=SYSK-PC\SQLEXPRESS;Initial Catalog=DemoDB;Integrated Security=True");
               SqlCommand cmd = new SqlCommand("update csp020 set UPD_DATE = getdate(), COMMON_TXT = @common_txt, ORDER_SEQ = @order_seq, USE_YN = @use_yn where SEQ_NO=@seq_no", cn);

               cmd.Parameters.AddWithValue("@common_txt", p1);
               cmd.Parameters.AddWithValue("@order_seq", i);
               cmd.Parameters.AddWithValue("@use_yn", p3);
               cmd.Parameters.AddWithValue("@seq_no", p2);
               cn.Open();
               cmd.ExecuteNonQuery();
               cn.Close();
            }
            catch (Exception ex)
            {
               throw ex;
            }
         }
      }

      
      private void addRow()
      {

         DataTable dtParams = new DataTable();
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





      private void bind_dataGrid()
      {
         DataTable dtParams = new DataTable();
         dtParams.Columns.Add(new DataColumn("SEQ_NO", typeof(String)));
         dtParams.Columns.Add(new DataColumn("COMMON_TXT", typeof(String)));
         dtParams.Columns.Add(new DataColumn("USE_YN", typeof(String)));
         dtParams.Columns.Add(new DataColumn("UPD_IDNM", typeof(String)));
         dtParams.Columns.Add(new DataColumn("UPD_DATE", typeof(String)));
         dtParams.Columns.Add(new DataColumn("FLAG", typeof(String)));

         DataRow dr1 = dtParams.NewRow();

         dr1["SEQ_NO"] = "11";
         dr1["COMMON_TXT"] = "22";
         dr1["USE_YN"] = "33";
         dr1["UPD_IDNM"] = "44";
         dr1["UPD_DATE"] = "55";
         dr1["FLAG"] = "66";

         dtParams.Rows.Add(dr1);

         DataRow dr2 = dtParams.NewRow();

         dr2["SEQ_NO"] = "a";
         dr2["COMMON_TXT"] = "b";
         dr2["USE_YN"] = "c";
         dr2["UPD_IDNM"] = "d";
         dr2["UPD_DATE"] = "e";
         dr2["FLAG"] = "f";

         dtParams.Rows.Add(dr2);

         DataRow dr3 = dtParams.NewRow();

         dr3["SEQ_NO"] = "가";
         dr3["COMMON_TXT"] = "나";
         dr3["USE_YN"] = "다";
         dr3["UPD_IDNM"] = "라";
         dr3["UPD_DATE"] = "마";
         dr3["FLAG"] = "바";

         dtParams.Rows.Add(dr3);


         //dtParams.Rows.Add(dr1);

         rptList.DataSource = dtParams;
         rptList.DataBind();
      }

      protected void addNewRow(object sender, EventArgs e)
      {
         addRow();
      }

      protected void rowUp(object sender, RepeaterItemEventArgs e)
      {
         int k = e.Item.ItemIndex;
         DataTable dtParams = new DataTable();
         dtParams.Columns.Add(new DataColumn("SEQ_NO", typeof(String)));
         dtParams.Columns.Add(new DataColumn("COMMON_TXT", typeof(String)));
         dtParams.Columns.Add(new DataColumn("USE_YN", typeof(String)));
         dtParams.Columns.Add(new DataColumn("UPD_IDNM", typeof(String)));
         dtParams.Columns.Add(new DataColumn("UPD_DATE", typeof(String)));
         dtParams.Columns.Add(new DataColumn("FLAG", typeof(String)));
      }

      protected void rptItemCommand(object source, RepeaterCommandEventArgs e)
      {

        
         //순번 up
         if (e.CommandName == "up_Click")
         {
            int k = e.Item.ItemIndex;
            Response.Write(k);

            //DataTable dtParams = new DataTable();
            //dtParams.Columns.Add(new DataColumn("SEQ_NO", typeof(String)));
            //dtParams.Columns.Add(new DataColumn("COMMON_TXT", typeof(String)));
            //dtParams.Columns.Add(new DataColumn("USE_YN", typeof(String)));
            //dtParams.Columns.Add(new DataColumn("UPD_IDNM", typeof(String)));
            //dtParams.Columns.Add(new DataColumn("UPD_DATE", typeof(String)));
            //dtParams.Columns.Add(new DataColumn("FLAG", typeof(String)));
            //DataRow dr = dtParams.NewRow();





         }
      }
      



      private void InitializeComponent()
      {
         this.Load += new System.EventHandler(this.Page_Load);
         this.btnAdd.Click += new System.EventHandler(this.addNewRow);
      }
   }
}