USE [master]
GO
/****** Object:  Database [MonShop]    Script Date: 8/11/2023 6:50:13 PM ******/
CREATE DATABASE [MonShop]
 
GO
ALTER DATABASE [MonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [MonShop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MonShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MonShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MonShop] SET  MULTI_USER 
GO
ALTER DATABASE [MonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MonShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MonShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MonShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MonShop] SET QUERY_STORE = OFF
GO
USE [MonShop]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[ImageUrl] [nvarchar](1000) NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[IsDeleted] [bit] NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE Tokens (
[RefreshToken] varchar(255) PRIMARY KEY,
AccountID int NOT NULL,
ExpiresAt Datetime NOT NULL


)
CREATE TABLE [ProductStatus] (
[ProductStatusId] int PRIMARY KEY,
[Status] varchar(255) NOT NULL

)
/****** Object:  Table [dbo].[Categories]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MomoPaymentResponses]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MomoPaymentResponses](
	[PaymentResponseId] [bigint] NOT NULL,
	[OrderId] [varchar] (255) NOT NULL,
	[Amount] [nvarchar](50) NULL,
	[OrderInfo] [nvarchar](255) NULL,
	[Success] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [varchar] (255) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PricePerUnit] [float] NOT NULL,
	[Subtotal] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [varchar] (255) NOT NULL,
	[OrderDate] [datetime] NULL,
	[Total] [float] NULL,
	[OrderStatusId] [int] NOT NULL,
	[BuyerAccountId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatuses]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatuses](
	[OrderStatusId] [int] NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PayPalPaymentResponses]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayPalPaymentResponses](
	[PaymentResponseId] [nvarchar](255) NOT NULL,
	[OrderId] [varchar] (255) NOT NULL,
	[Amount] [nvarchar](50) NULL,
	[OrderInfo] [nvarchar](255) NULL,
	[Success] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/****** Object:  Table [dbo].[Products]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[ImageUrl] [nvarchar](1000) NULL,
	[Price] [float] NOT NULL,
	[Discount] [float] NULL,
	[Quantity] [int] NOT NULL,
	[Description] [text] NULL,
	[CategoryId] [int] NULL,
	[ProductStatusId] [int] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/****** Object:  Table [dbo].[Roles]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] NOT NULL,
	[RoleName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO




/****** Object:  Table [dbo].[VNPayPaymentResponses]    Script Date: 8/11/2023 6:50:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VNPayPaymentResponses](
	[PaymentResponseId] [bigint] NOT NULL,
	[OrderId] [varchar] (255) NOT NULL,
	[Amount] [nvarchar](50) NULL,
	[OrderInfo] [nvarchar](255) NULL,
	[Success] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [Messages] (
[MessageID] int identity(1,1),
[Sender] int NULL,
[Receiver] int NULL,
[Content] nvarchar(255), 
[SendTime] datetime null,

)

SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (1, N'mon@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Hong Quan', NULL, N'0999999999', 0, 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (2, N'mon2@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Toi la mon', NULL, N'0909223123', 1, 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (3, N'johndoe@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'John Doe', NULL, N'0999999999', 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (4, N'janedoe2@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Jane Doe', NULL, N'0999999999', 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (5, N'admin@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Admin', NULL, NULL, 0, 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (6, N'user1@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 1', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (7, N'user2@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 2', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (8, N'user3@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 3', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (9, N'user4@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 4', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (10, N'user5@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 5', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (11, N'user6@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 6', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (12, N'user7@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 7', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (13, N'user8@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 8', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (14, N'user9@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 9', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (15, N'user10@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 10', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (16, N'user11@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 11', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (17, N'user12@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 12', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (18, N'user13@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 13', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (19, N'user14@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 14', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (20, N'user15@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 15', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (21, N'user16@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 16', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (22, N'user17@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 17', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (23, N'user18@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 18', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (24, N'user19@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 19', NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (25, N'user20@gmail.com',N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 20', NULL, NULL, 0, 2)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (1, N'Pants')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (2, N'Shirts')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (3, N'Shoes')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (4, N'Accessories')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (1, N'Pending')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (2, N'Sucess Pay')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (3, N'Fail Pay')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (4, N'Shipped')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (5, N'Delivered')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (6, N'Cancelled')
GO
INSERT INTO [dbo].[ProductStatus] ([ProductStatusId], [Status]) VALUES (1, N'Active')
INSERT INTO [dbo].[ProductStatus] ([ProductStatusId], [Status]) VALUES (2, N'Inactive')


SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (1, N'T-Shirt Black', NULL, 100000, 10, N'T-shirt black with a white logo.', 1, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (2, N'T-Shirt White', NULL, 100000, 10, N'T-shirt white with a black logo.', 1, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (3, N'Pants Black', NULL, 200000, 10, N'Pants black with a white stripe.', 2, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (4, N'Pants White', NULL, 200000, 10, N'Pants white with a black stripe.', 2, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (5, N'Shoes Black', NULL, 300000, 10, N'Shoes black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (6, N'Shoes White', NULL, 300000, 10, N'Shoes white with a black logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (7, N'Bag Black', NULL, 400000, 10, N'Bag black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (8, N'Bag White', NULL, 400000, 10, N'Bag white with a black logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (9, N'Jeans Black', NULL, 250000, 10, N'Jeans black with a white logo.', 2, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (10, N'Jeans White', NULL, 250000, 10, N'Jeans white with a black logo.', 2, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (11, N'Dress Black', NULL, 300000, 10, N'Dress black with a white logo.', 3, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (12, N'Dress White', NULL, 300000, 10, N'Dress white with a black logo.', 3, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (13, N'Shoes Sneakers', NULL, 200000, 10, N'Shoes sneakers black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (14, N'Shoes Boots', NULL, 300000, 10, N'Shoes boots black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (15, N'Bag Backpack', NULL, 400000, 10, N'Bag backpack black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (16, N'Bag Handbag', NULL, 500000, 10, N'Bag handbag black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (17, N'Belt Black', NULL, 100000, 10, N'Bag handbag black with a white logo.', 4, 1, 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (2, N'Staff')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (3, N'User')
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[MomoPaymentResponses]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([BuyerAccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatuses] ([OrderStatusId])
GO
ALTER TABLE [dbo].[PayPalPaymentResponses]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([ProductStatusID])
REFERENCES [dbo].[ProductStatus] ([ProductStatusID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])


GO
ALTER TABLE [dbo].[VNPayPaymentResponses]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
ALTER TABLE [dbo].[Tokens]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([Sender])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([Receiver])
REFERENCES [dbo].[Account] ([AccountID])
GO
USE [master]
GO
ALTER DATABASE [MonShop] SET  READ_WRITE 
GO
