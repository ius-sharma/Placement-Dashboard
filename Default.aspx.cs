using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementDashboard
{
    public partial class Default : Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            // Bind ViewState to this browser session.
            Session["DashboardStarted"] = true;
            ViewStateUserKey = Session.SessionID;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadSummary();
        }
        private void LoadSummary()
        {
            string cs = ConfigurationManager.ConnectionStrings["PlacementDb"].ConnectionString;
            using (var connection = new SqlConnection(cs))
            using (var command = new SqlCommand(
                "SELECT COUNT(*),COALESCE(SUM(CASE WHEN Status='Placed' THEN 1 ELSE 0 END),0)," +
                "COALESCE(MAX(PackageLpa),0) FROM Students", connection))
            {
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    reader.Read();
                    int total = reader.GetInt32(0), placed = reader.GetInt32(1);
                    lblTotal.Text = total.ToString();
                    lblPlaced.Text = placed.ToString();
                    lblRate.Text = (total == 0 ? 0 : placed * 100.0 / total).ToString("0.0") + "%";
                    lblHighest.Text = reader.GetDecimal(2).ToString("0.00");
                }
            }
        }
        private void ClearSelection()
        {
            gvStudents.SelectedIndex = -1;
            dvStudent.DataBind();
        }
        protected void FilterChanged(object sender, EventArgs e)
        {
            gvStudents.PageIndex = 0;
            ClearSelection();
            gvStudents.DataBind();
        }
        protected void GridChanging(object sender, GridViewPageEventArgs e)
        {
            ClearSelection();
        }
        protected void GridSorting(object sender, GridViewSortEventArgs e)
        {
            ClearSelection();
        }
        protected void StudentSelected(object sender, EventArgs e)
        {
            dvStudent.DataBind();
        }
    }
}

