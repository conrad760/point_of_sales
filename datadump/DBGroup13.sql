USE [master]
GO
/****** Object:  Database [QahwaTesting]    Script Date: 4/23/2019 9:34:50 PM ******/
CREATE DATABASE [QahwaTesting]
GO
ALTER DATABASE [QahwaTesting] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QahwaTesting].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QahwaTesting] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QahwaTesting] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QahwaTesting] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QahwaTesting] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QahwaTesting] SET ARITHABORT OFF 
GO
ALTER DATABASE [QahwaTesting] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QahwaTesting] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QahwaTesting] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QahwaTesting] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QahwaTesting] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QahwaTesting] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QahwaTesting] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QahwaTesting] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QahwaTesting] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QahwaTesting] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QahwaTesting] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [QahwaTesting] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QahwaTesting] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [QahwaTesting] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QahwaTesting] SET  MULTI_USER 
GO
ALTER DATABASE [QahwaTesting] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QahwaTesting] SET ENCRYPTION ON
GO
ALTER DATABASE [QahwaTesting] SET QUERY_STORE = ON
GO
ALTER DATABASE [QahwaTesting] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [QahwaTesting]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_first_name] [varchar](30) NOT NULL,
	[customer_last_name] [varchar](30) NOT NULL,
	[customer_email] [varchar](30) NOT NULL,
	[phone_number] [varchar](30) NOT NULL,
	[date_of_birth] [date] NOT NULL,
	[created_by] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[phone_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[customer_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[invoice_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[employee_id] [int] NOT NULL,
	[invoice_date] [date] NOT NULL,
	[payed] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[invoice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_details]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_details](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[discount] [decimal](10, 0) NOT NULL,
	[invoice_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [varchar](30) NOT NULL,
	[supplier_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[units_in_stock] [int] NOT NULL,
	[price] [smallmoney] NOT NULL,
	[perishable] [int] NOT NULL,
	[exp_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Loyal_Customer]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Loyal_Customer] AS(
    SELECT TOP(200) SUM(P.price* OD.quantity) as "Total Purchases", C.customer_first_name, C.customer_last_name
FROM Products P, Order_Details OD, Invoices I, customers C
WHERE P.Product_ID = OD.Product_ID AND OD.invoice_id = I.Invoice_id
GROUP BY c.customer_first_name, c.customer_last_name
ORDER BY "Total Purchases" DESC
)
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_email] [varchar](30) NOT NULL,
	[employee_first_name] [varchar](30) NOT NULL,
	[employee_last_name] [varchar](30) NOT NULL,
	[employee_access_code] [int] NOT NULL,
	[employee_data_of_birth] [date] NOT NULL,
	[date_hired] [date] NOT NULL,
	[hired_by_id] [int] NOT NULL,
	[hours_per_week] [int] NOT NULL,
	[sex] [nchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[employee_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sales_History]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[Sales_History] AS(
    select TOP(200) E.employee_last_name, E.employee_first_name, sum(p.price*od.quantity) as Sales
    from Invoices o, products p, Order_details od, Employees E
    where p.product_id = od.product_id and od.invoice_id = o.invoice_id and o.employee_id = e.employee_id
    group by e.employee_last_name, e.employee_first_name
    order by sales desc
)
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 4/23/2019 9:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Access_level]    Script Date: 4/23/2019 9:34:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Access_level](
	[access_code] [int] IDENTITY(1,1) NOT NULL,
	[access_value] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[access_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 4/23/2019 9:34:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company_Expenses]    Script Date: 4/23/2019 9:34:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company_Expenses](
	[expenses_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_id] [int] NOT NULL,
	[employee_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[cost] [smallmoney] NOT NULL,
	[order_date] [date] NOT NULL,
	[quantity_purchased] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[expenses_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 4/23/2019 9:34:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[rating] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rewards]    Script Date: 4/23/2019 9:34:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rewards](
	[reward_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[points] [int] NOT NULL,
 CONSTRAINT [PK_Rewards] PRIMARY KEY CLUSTERED 
(
	[reward_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 4/23/2019 9:34:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[supplier_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_name] [varchar](30) NOT NULL,
	[supplier_email] [varchar](30) NOT NULL,
	[supplier_phone_number] [varchar](30) NOT NULL,
	[category_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[supplier_phone_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[supplier_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT ((0)) FOR [payed]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[Employees] ([employee_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([employee_access_code])
REFERENCES [dbo].[Access_level] ([access_code])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[Employees] ([employee_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order_details]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Suppliers] ([supplier_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rewards]  WITH CHECK ADD  CONSTRAINT [FK_Rewards_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rewards] CHECK CONSTRAINT [FK_Rewards_Customers]
GO
ALTER TABLE [dbo].[Suppliers]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
USE [master]
GO
ALTER DATABASE [QahwaTesting] SET  READ_WRITE 
GO
