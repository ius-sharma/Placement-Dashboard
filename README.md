# Practical 9 - Placement Dashboard

**AIM:** Create Placement Dashboard using Data Controls.

Ayush Sharma | 92400103460 | 5EC1 | Batch A | 01CE1523 - .NET Technologies

## Requirements

- Visual Studio with ASP.NET and web development tools and the .NET Framework 4.8 targeting pack.
- SQL Server Express LocalDB instance `MSSQLLocalDB` and IIS Express.

## Database setup

Run `Database/Setup.sql` against `(localdb)\MSSQLLocalDB` using SQL Server Object Explorer or SQL Server Management Studio. With SQL Server command-line tools installed:

```powershell
sqllocaldb start MSSQLLocalDB
sqlcmd -S "(localdb)\MSSQLLocalDB" -E -b -i Database/Setup.sql
```

The script creates a separate `PlacementPractical9` database and seeds 12 sample student records only when the table is first created. Rerunning the script preserves existing records. These are demonstration records, not actual university placement results. Company names and package values are illustrative.

The `PlacementDb` connection string in `Web.config` uses Windows authentication. Update its server name if using another SQL Server instance.

## Run

1. Open `PlacementDashboard.sln` in Visual Studio.
2. Build and run with IIS Express.
3. Open `http://localhost:5099/`.

This is ASP.NET Web Forms on .NET Framework 4.8. No additional NuGet packages are required. Use Visual Studio/MSBuild and IIS Express; `dotnet run` does not apply.

## Data Controls

- **GridView:** six records per page, sorting by student name, department and package, with a View action.
- **DetailsView:** selected student's enrollment, name, department, email, company, package and placement status.
- **Repeater:** company-wise student counts and highest package.
- **SqlDataSource:** SQL Server data binding with typed control parameters for department/status filters and selected record.
- **DropDownList:** department and placement-status filters, including combined filtering.
- **Label:** total students, placed students, placement percentage and highest package.

Summary figures and company summaries cover the entire dataset; filters apply to the student grid. Selecting another filter, sorting or changing page clears the previous detail selection. Package values use LPA (lakh per annum).

The submission PDF and real screenshots from the running application are under `docs/`.
