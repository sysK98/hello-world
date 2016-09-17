using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Services;


   public partial class _Default : System.Web.UI.Page
   {
   

      protected void Page_Load(object sender, EventArgs e)
      {

      }

      protected void btnInsert_Click(object sender, EventArgs e)
      {

      }

   [WebMethod]
   public static string InsertStudent(StudentDetails details)
   {
      SqlConnection cn = new SqlConnection(@"Data Source=SYSK-PC\SQLEXPRESS;Initial Catalog=DemoDB;Integrated Security=True");
      SqlCommand cmd = new SqlCommand("Insert into Student values (@fname, @lname, @mobileno)", cn);
      cmd.Parameters.AddWithValue("@fname", details.FirstName);
      cmd.Parameters.AddWithValue("@lname", details.Lastname);
      cmd.Parameters.AddWithValue("@mobileno", details.MobileNo);
      cn.Open();
      cmd.ExecuteNonQuery();
      cn.Close();

      return "Insert Success";
   }

   [WebMethod]
   public static string UpdateStudent(StudentDetails details)
   {
      SqlConnection cn = new SqlConnection(@"Data Source=SYSK-PC\SQLEXPRESS;Initial Catalog=DemoDB;Integrated Security=True");
      SqlCommand cmd = new SqlCommand("update Student set  fname = @fname, lname = @lname, mobileno = @mobileno where id=@id", cn);
      cmd.Parameters.AddWithValue("@fname", details.FirstName);
      cmd.Parameters.AddWithValue("@lname", details.Lastname);
      cmd.Parameters.AddWithValue("@mobileno", details.MobileNo);
      cmd.Parameters.AddWithValue("@id", details.RollNo);
      cn.Open();
      cmd.ExecuteNonQuery();
      cn.Close();

      return "Update Success";
   }

   [WebMethod]
   public static string DeleteStudent(String rollno)
   {
      SqlConnection cn = new SqlConnection(@"Data Source=SYSK-PC\SQLEXPRESS;Initial Catalog=DemoDB;Integrated Security=True");
      SqlCommand cmd = new SqlCommand("delete from student where id = @id", cn);
      
      cmd.Parameters.AddWithValue("@id", rollno);
      cn.Open();
      cmd.ExecuteNonQuery();
      cn.Close();

      return "Delete Success";
   }
}


public class StudentDetails
{
   public int RollNo { get; set; }
   public string FirstName { get; set;}
   public string Lastname { get; set; }
   public string MobileNo { get; set; }
}