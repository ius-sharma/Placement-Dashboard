<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="PlacementDashboard.Default" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Placement Dashboard</title>
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body><form id="form1" runat="server">
<header><div class="wrap">Placement Dashboard</div></header>
<main class="wrap">
    <h1>Campus Placement Dashboard</h1>
    <p>Student placement records | Sample dataset for lab demonstration</p>
    <div class="stats">
        <div class="stat">Total Students<strong><asp:Label ID="lblTotal" runat="server" /></strong></div>
        <div class="stat">Placed<strong><asp:Label ID="lblPlaced" runat="server" /></strong></div>
        <div class="stat">Placement Rate<strong><asp:Label ID="lblRate" runat="server" /></strong></div>
        <div class="stat">Highest Package<strong><asp:Label ID="lblHighest" runat="server" /> LPA</strong></div>
    </div>
    <p class="note">Summary figures cover all students. LPA = lakh per annum.</p>
    <section class="panel">
        <h2>Student Placement Records</h2>
        <div class="filters">
            <div><asp:Label runat="server" AssociatedControlID="ddlDepartment" Text="Department" />
            <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="FilterChanged">
                <asp:ListItem Value="All">All Departments</asp:ListItem>
                <asp:ListItem>CE</asp:ListItem><asp:ListItem>IT</asp:ListItem>
                <asp:ListItem>EC</asp:ListItem>
            </asp:DropDownList></div>
            <div><asp:Label runat="server" AssociatedControlID="ddlStatus" Text="Placement Status" />
            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="FilterChanged">
                <asp:ListItem Value="All">All Statuses</asp:ListItem>
                <asp:ListItem>Placed</asp:ListItem><asp:ListItem>Pending</asp:ListItem>
            </asp:DropDownList></div>
        </div>
        <div class="table-wrap">
        <asp:GridView ID="gvStudents" runat="server" DataSourceID="dsStudents"
            AutoGenerateColumns="false" DataKeyNames="Id" CssClass="grid"
            AllowPaging="true" PageSize="6" AllowSorting="true"
            OnPageIndexChanging="GridChanging" OnSorting="GridSorting"
            EmptyDataText="No placement records match these filters."
            OnSelectedIndexChanged="StudentSelected">
            <Columns>
                <asp:BoundField DataField="Enrollment" HeaderText="Enrollment" />
                <asp:BoundField DataField="StudentName" HeaderText="Student Name"
                    SortExpression="StudentName" />
                <asp:BoundField DataField="Department" HeaderText="Dept."
                    SortExpression="Department" />
                <asp:BoundField DataField="Company" HeaderText="Company"
                    NullDisplayText="-" />
                <asp:BoundField DataField="PackageLpa" HeaderText="Package (LPA)"
                    DataFormatString="{0:0.00}" NullDisplayText="-"
                    SortExpression="PackageLpa" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:CommandField ShowSelectButton="true" SelectText="View" />
            </Columns>
            <SelectedRowStyle CssClass="selected" />
            <PagerStyle CssClass="pager" />
        </asp:GridView></div>
    </section>
    <section class="panel">
        <h2>Selected Student Details</h2>
        <asp:DetailsView ID="dvStudent" runat="server" DataSourceID="dsDetails"
            AutoGenerateRows="false" CssClass="details"
            EmptyDataText="Select View beside a student to see full details.">
            <Fields>
                <asp:BoundField DataField="Enrollment" HeaderText="Enrollment" />
                <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Company" HeaderText="Company" NullDisplayText="-" />
                <asp:BoundField DataField="PackageLpa" HeaderText="Package (LPA)"
                    DataFormatString="{0:0.00}" NullDisplayText="-" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
            </Fields>
        </asp:DetailsView>
    </section>
    <section class="panel">
        <h2>Company Summary</h2>
        <p class="note">All placed students, grouped by company.</p>
        <div class="companies">
        <asp:Repeater ID="rptCompanies" runat="server" DataSourceID="dsCompanies">
            <ItemTemplate>
                <article class="company"><strong><%#: Eval("Company") %></strong>
                <p>Students placed: <%#: Eval("PlacedCount") %></p>
                <p>Highest: <%#: Eval("HighestPackage", "{0:0.00}") %> LPA</p></article>
            </ItemTemplate>
        </asp:Repeater></div>
    </section>
</main>
<footer class="wrap">Practical 9 | ASP.NET Data Controls<br />
    AYUSH SHARMA | 92400103460 | 5EC1 | Batch A</footer>
<asp:SqlDataSource ID="dsStudents" runat="server"
    ConnectionString="<%$ ConnectionStrings:PlacementDb %>"
    SelectCommand="SELECT Id,Enrollment,StudentName,Department,Company,PackageLpa,Status
        FROM Students WHERE (@Department='All' OR Department=@Department)
        AND (@Status='All' OR Status=@Status) ORDER BY Id">
    <SelectParameters>
        <asp:ControlParameter Name="Department" ControlID="ddlDepartment"
            PropertyName="SelectedValue" Type="String" DefaultValue="All" />
        <asp:ControlParameter Name="Status" ControlID="ddlStatus"
            PropertyName="SelectedValue" Type="String" DefaultValue="All" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="dsDetails" runat="server"
    ConnectionString="<%$ ConnectionStrings:PlacementDb %>"
    SelectCommand="SELECT Enrollment,StudentName,Department,Email,Company,PackageLpa,Status
        FROM Students WHERE Id=@Id">
    <SelectParameters>
        <asp:ControlParameter Name="Id" ControlID="gvStudents"
            PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="dsCompanies" runat="server"
    ConnectionString="<%$ ConnectionStrings:PlacementDb %>"
    SelectCommand="SELECT Company,COUNT(*) AS PlacedCount,MAX(PackageLpa) AS HighestPackage
        FROM Students WHERE Status='Placed' GROUP BY Company ORDER BY Company" />
</form></body></html>
