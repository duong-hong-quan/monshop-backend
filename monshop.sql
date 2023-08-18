USE [master]
GO
/****** Object:  Database [MonShop]    Script Date: 8/17/2023 8:46:52 PM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 8/17/2023 8:46:52 PM ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 8/17/2023 8:46:52 PM ******/
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
/****** Object:  Table [dbo].[Messages]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[Sender] [int] NULL,
	[Content] [nvarchar](255) NULL,
	[SendTime] [datetime] NULL,
	[RoomID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MomoPaymentResponses]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MomoPaymentResponses](
	[PaymentResponseId] [bigint] NOT NULL,
	[OrderId] [varchar](255) NOT NULL,
	[Amount] [nvarchar](50) NULL,
	[OrderInfo] [nvarchar](255) NULL,
	[Success] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [varchar](255) NOT NULL,
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
/****** Object:  Table [dbo].[Orders]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [varchar](255) NOT NULL,
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
/****** Object:  Table [dbo].[OrderStatuses]    Script Date: 8/17/2023 8:46:52 PM ******/
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
/****** Object:  Table [dbo].[PayPalPaymentResponses]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayPalPaymentResponses](
	[PaymentResponseId] [nvarchar](255) NOT NULL,
	[OrderId] [varchar](255) NOT NULL,
	[Amount] [nvarchar](50) NULL,
	[OrderInfo] [nvarchar](255) NULL,
	[Success] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/17/2023 8:46:52 PM ******/
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
/****** Object:  Table [dbo].[ProductStatus]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStatus](
	[ProductStatusId] [int] NOT NULL,
	[Status] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 8/17/2023 8:46:52 PM ******/
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
/****** Object:  Table [dbo].[Room]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[RoomName] [nvarchar](255) NULL,
	[RoomImg] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tokens]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tokens](
	[RefreshToken] [varchar](255) NOT NULL,
	[AccountID] [int] NOT NULL,
	[ExpiresAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RefreshToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VNPayPaymentResponses]    Script Date: 8/17/2023 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VNPayPaymentResponses](
	[PaymentResponseId] [bigint] NOT NULL,
	[OrderId] [varchar](255) NOT NULL,
	[Amount] [nvarchar](50) NULL,
	[OrderInfo] [nvarchar](255) NULL,
	[Success] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (1, N'mon@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Hong Quan', N'Ne', N'HCM', N'0999999999', 0, 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (2, N'mon2@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Toi la mon', NULL, NULL, N'0909223123', NULL, 3)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (3, N'johndoe@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'John Doe', NULL, NULL, N'0999999999', 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (4, N'janedoe2@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Jane Doe', NULL, NULL, N'0999999999', 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (5, N'admin@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'Admin', NULL, NULL, NULL, 0, 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (6, N'user1@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 1', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (7, N'user2@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 2', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (8, N'user3@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 3', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (9, N'user4@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 4', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (10, N'user5@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 5', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (11, N'user6@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 6', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (12, N'user7@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 7', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (13, N'user8@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 8', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (14, N'user9@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 9', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (15, N'user10@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 10', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (16, N'user11@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 11', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (17, N'user12@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 12', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (18, N'user13@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 13', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (19, N'user14@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 14', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (20, N'user15@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 15', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (21, N'user16@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 16', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (22, N'user17@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 17', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (23, N'user18@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 18', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (24, N'user19@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 19', NULL, NULL, NULL, 0, 2)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [ImageUrl], [FirstName], [LastName], [Address], [PhoneNumber], [IsDeleted], [RoleId]) VALUES (25, N'user20@gmail.com', N'$2a$11$mKL4uAbanRoUIZvKOFhUKuTx9WKaY6XyBVe36pUgsDkobHBN3v38C', NULL, N'User 20', NULL, NULL, NULL, 0, 2)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (1, N'Pants')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (2, N'Shirts')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (3, N'Shoes')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (4, N'Accessories')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [PricePerUnit], [Subtotal]) VALUES (20, N'31382042-5923-403d-94a2-cdc27fa92aa5', 2, 1, 100000, 100000)
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [PricePerUnit], [Subtotal]) VALUES (21, N'31382042-5923-403d-94a2-cdc27fa92aa5', 3, 1, 200000, 200000)
INSERT [dbo].[OrderItems] ([OrderItemId], [OrderId], [ProductId], [Quantity], [PricePerUnit], [Subtotal]) VALUES (22, N'31382042-5923-403d-94a2-cdc27fa92aa5', 1, 1, 100000, 100000)
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
INSERT [dbo].[Orders] ([OrderId], [OrderDate], [Total], [OrderStatusId], [BuyerAccountId]) VALUES (N'31382042-5923-403d-94a2-cdc27fa92aa5', CAST(N'2023-08-14T22:41:22.423' AS DateTime), 400000, 1, 1)
GO
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (1, N'Pending')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (2, N'Sucess Pay')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (3, N'Fail Pay')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (4, N'Shipped')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (5, N'Delivered')
INSERT [dbo].[OrderStatuses] ([OrderStatusId], [Status]) VALUES (6, N'Cancelled')
GO
INSERT [dbo].[PayPalPaymentResponses] ([PaymentResponseId], [OrderId], [Amount], [OrderInfo], [Success]) VALUES (N'PAYID-MTNS2BY3AP61334JU349125A', N'31382042-5923-403d-94a2-cdc27fa92aa5', N'17.50', N'Customer pays bill #31382042-5923-403d-94a2-cdc27fa92aa5', 1)
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (1, N'T-Shirt Black', N'https://product.hstatic.net/200000195489/product/kem_co_nen_cceb35e8a7be4f6695e060460630a876_grande.jpg', 10000, 20, 100, N'T-shirt black with a white logo.', 2, 2, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (2, N'T-Shirt White', N'https://product.hstatic.net/200000195489/product/kem_co_nen_cceb35e8a7be4f6695e060460630a876_grande.jpg', 100000, 30, 9, N'T-shirt white with a black logo.', 2, 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (3, N'Pants Black', N'https://product.hstatic.net/200000195489/product/den_truoc_31d8c1dbe3de46d3a3170871a06c07b6_master.jpg', 200000, 30, 9, N'Pants black with a white stripe.', 1, 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (4, N'Pants White', N'https://product.hstatic.net/200000195489/product/den_truoc_31d8c1dbe3de46d3a3170871a06c07b6_master.jpg', 200000, 30, 10, N'Pants white with a black stripe.', 1, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (5, N'Shoes Black', N'https://rukminim2.flixcart.com/image/450/500/l51d30w0/shoe/z/w/c/10-mrj1914-10-aadi-white-black-red-original-imagft9k9hydnfjp.jpeg?q=90&crop=false', 300000, 30, 10, N'Shoes black with a white logo.', 3, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (6, N'Shoes White', N'https://rukminim2.flixcart.com/image/450/500/l51d30w0/shoe/z/w/c/10-mrj1914-10-aadi-white-black-red-original-imagft9k9hydnfjp.jpeg?q=90&crop=false', 300000, 30, 10, N'Shoes white with a black logo.', 3, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (7, N'Bag Black', N'https://product.hstatic.net/200000195489/product/artboard_1_copy_2_b134961cb1fa4d3e961d18a8c5c18612_master.jpg', 400000, 30, 10, N'Bag black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (8, N'Bag White', N'https://product.hstatic.net/200000195489/product/artboard_1_copy_2_b134961cb1fa4d3e961d18a8c5c18612_master.jpg', 400000, 30, 10, N'Bag white with a black logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (9, N'Jeans Black', N'https://product.hstatic.net/200000195489/product/den_truoc_31d8c1dbe3de46d3a3170871a06c07b6_master.jpg', 250000, 30, 10, N'Jeans black with a white logo.', 1, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (10, N'Jeans White', N'https://product.hstatic.net/200000195489/product/den_truoc_31d8c1dbe3de46d3a3170871a06c07b6_master.jpg', 250000, 30, 10, N'Jeans white with a black logo.', 1, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (11, N'Dress Black', N'https://product.hstatic.net/200000195489/product/kem_co_nen_cceb35e8a7be4f6695e060460630a876_grande.jpg', 300000, 30, 10, N'Dress black with a white logo.', 2, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (12, N'Dress White', N'https://product.hstatic.net/200000195489/product/kem_co_nen_cceb35e8a7be4f6695e060460630a876_grande.jpg', 300000, 30, 10, N'Dress white with a black logo.', 2, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (13, N'Shoes Sneakers', N'https://rukminim2.flixcart.com/image/450/500/l51d30w0/shoe/z/w/c/10-mrj1914-10-aadi-white-black-red-original-imagft9k9hydnfjp.jpeg?q=90&crop=false', 200000, 30, 10, N'Shoes sneakers black with a white logo.', 3, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (14, N'Shoes Boots', N'https://rukminim2.flixcart.com/image/450/500/l51d30w0/shoe/z/w/c/10-mrj1914-10-aadi-white-black-red-original-imagft9k9hydnfjp.jpeg?q=90&crop=false', 300000, 30, 8, N'Shoes boots black with a white logo.', 3, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (15, N'Bag Backpack', N'https://product.hstatic.net/200000195489/product/artboard_1_copy_2_b134961cb1fa4d3e961d18a8c5c18612_master.jpg', 400000, 30, 8, N'Bag backpack black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (16, N'Bag Handbag', N'https://product.hstatic.net/200000195489/product/artboard_1_copy_2_b134961cb1fa4d3e961d18a8c5c18612_master.jpg', 500000, 30, 10, N'Bag handbag black with a white logo.', 4, 1, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (17, N'Belt Black', N'https://product.hstatic.net/200000195489/product/artboard_1_copy_2_b134961cb1fa4d3e961d18a8c5c18612_master.jpg', 100000, 17, 10, N'Bag handbag black with a white logo.', 4, 2, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (18, N'alooo', N'https://i.ytimg.com/vi/vVVlkU6_w0s/mqdefault.jpg', 1, 2222, 4, N'a', 2, NULL, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (19, N'et o et', N'https://i.ytimg.com/vi/vVVlkU6_w0s/mqdefault.jpg', 123, 22, 1, N'hi', 2, 2, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (20, N'alo', N'https://i.ytimg.com/vi/vVVlkU6_w0s/mqdefault.jpg', 12, NULL, 12, N'ahaha', 2, 2, 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [ImageUrl], [Price], [Discount], [Quantity], [Description], [CategoryId], [ProductStatusId], [IsDeleted]) VALUES (21, N'alo', N'https://i.ytimg.com/vi/vVVlkU6_w0s/mqdefault.jpg', 12, NULL, 12, N'ahaha', 2, 2, 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[ProductStatus] ([ProductStatusId], [Status]) VALUES (1, N'Active')
INSERT [dbo].[ProductStatus] ([ProductStatusId], [Status]) VALUES (2, N'Inactive')
GO
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (2, N'Staff')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (3, N'User')
GO
INSERT [dbo].[Tokens] ([RefreshToken], [AccountID], [ExpiresAt]) VALUES (N'1e8cb1a8-1037-4a88-92ef-ddc00b54607f', 1, CAST(N'2023-09-13T02:44:26.197' AS DateTime))
INSERT [dbo].[Tokens] ([RefreshToken], [AccountID], [ExpiresAt]) VALUES (N'a521fdfb-aa50-4da8-9c01-89b3ec4d67a3', 24, CAST(N'2023-09-17T05:17:12.100' AS DateTime))
INSERT [dbo].[Tokens] ([RefreshToken], [AccountID], [ExpiresAt]) VALUES (N'cf77dab7-b76c-43ee-9d50-a9f5c54503ed', 2, CAST(N'2023-09-17T05:14:50.007' AS DateTime))
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([Sender])
REFERENCES [dbo].[Account] ([AccountId])
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
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([ProductStatusId])
REFERENCES [dbo].[ProductStatus] ([ProductStatusId])
GO
ALTER TABLE [dbo].[Tokens]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[VNPayPaymentResponses]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
USE [master]
GO
ALTER DATABASE [MonShop] SET  READ_WRITE 
GO
