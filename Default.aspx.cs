using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace app
{
   public partial class Default : System.Web.UI.Page
   {

      private string p1;
      private int p2;
      private string p3;

      protected void Page_Load(object sender, EventArgs e)
      {

         SqlCommand cmd = new SqlCommand("select * from csp020 order by order_seq asc", new SqlConnection(@"Data Source=SYSK-PC\SQLEXPRESS;Initial Catalog=DemoDB;Integrated Security=True"));
         cmd.Connection.Open();
         Repeater1.DataSource = cmd.ExecuteReader();
         Repeater1.DataBind();
         cmd.Connection.Close();
         cmd.Connection.Dispose();
      }

      protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
      {
         if (e.Item.ItemType.Equals(ListItemType.Item) || e.Item.ItemType.Equals(ListItemType.AlternatingItem))
         {
            RepeaterItem item = e.Item as RepeaterItem;
            IDataRecord Dr = (IDataRecord)item.DataItem;
            Literal ltrSeq = item.FindControl("ltrSeq") as Literal;
            DropDownList ddlUseYn = (DropDownList)e.Item.FindControl("ddlUseYn");
            TextBox txtCommonTxt = (TextBox)e.Item.FindControl("txtCommon");
            Literal ltrUpdIdNm = item.FindControl("ltrUpdIdNm") as Literal;
            Literal ltrUpdDate = item.FindControl("ltrUpdDate") as Literal;

            ltrSeq.Text = Dr["SEQ_NO"].ToString();
            txtCommonTxt.Text = Dr["COMMON_TXT"].ToString();
            ddlUseYn.SelectedValue = Dr["USE_YN"].ToString();
            ltrUpdIdNm.Text = Dr["UPD_IDNM"].ToString();
            ltrUpdDate.Text = Dr["UPD_DATE"].ToString();

         }
      }

      protected void save_Click(object sender, EventArgs e)
      {
         saveData();
      }

      private void saveData()
      {

         for (int i = 0; i < Repeater1.Items.Count; i++)
         {
            TextBox txtCommonTxt = Repeater1.Items[i].FindControl("txtCommon") as TextBox;
            Literal ltrSeq = Repeater1.Items[i].FindControl("ltrSeq") as Literal;
            DropDownList ddlUseYn = Repeater1.Items[i].FindControl("ddlUseYn") as DropDownList;

            p1 = txtCommonTxt.Text;
            p2 = Int32.Parse(ltrSeq.Text);
            p3 = ddlUseYn.SelectedValue;

            try
            {
               SqlConnection cn = new SqlConnection(@"Data Source=SYSK-PC\SQLEXPRESS;Initial Catalog=DemoDB;Integrated Security=True");
               SqlCommand cmd = new SqlCommand("update csp020 set  COMMON_TXT = @common_txt, ORDER_SEQ = @order_seq, USE_YN = @use_yn where SEQ_NO=@seq_no", cn);

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



      //public List<Book> Display()
      //{
      //   List<Book> Obj = new List<Book>()
      //  {
      //      new Book{ Id=1, Title="ASP.NET C#", Author="Aamir Hasan", Price= 101.1F},
      //      new Book{ Id=2,Title="ASP.NET Control", Author="Aamir Hasan", Price= 120.1F},
      //      new Book{ Id=3,Title="ASP.NET Development", Author="Aamir Hasan", Price= 140.1F},
      //      new Book{ Id=4,Title="ASP.NET Desing Pattern", Author="Aamir Hasan", Price= 50.1F},
      //      new Book{ Id=5,Title="Sharepoint 2010 Administration", Author="Aamir Hasan", Price= 70.1F},
      //      new Book{ Id=6,Title="Sharepoint 2010 Development", Author="Aamir Hasan", Price= 80.1F},
      //      new Book{ Id=7,Title="jQuery", Author="Aamir Hasan", Price= 90.1F},
      //      new Book{ Id=8,Title="HTML 5", Author="Aamir Hasan", Price= 20.1F},
      //      new Book{ Id=9,Title="Javascript", Author="Aamir Hasan", Price= 40.1F},
      //      new Book{ Id=10,Title="ASP.NET C#", Author="Aamir Hasan", Price= 70.1F}
      //  };

      //   return Obj;
      //}

      public class List
      {
         public int Seq_no { get; set; }
         public string Common_txt { get; set; }
         public string use_yn { get; set; }
         public string upd_ipnm { get; set; }
         public string upd_date { get; set; }
         public string flag { get; set; }
      }

   }
}