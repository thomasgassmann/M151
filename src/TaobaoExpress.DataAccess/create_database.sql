drop database if exists TaobaoExpress;
create database TaobaoExpress;

go

use TaobaoExpress;

go

create table Products(
    Id bigint primary key identity(1, 1),
    Name varchar(100) not null,
    Image varbinary(max) null,
    ReleaseDate datetime null,
    Created datetime not null,
    Updated datetime not null,
    ConcurrencyCheck timestamp null
);

go

create table RelatedProducts(
    ProductId bigint not null foreign key references Products(Id),
    RelatedProductId bigint not null foreign key references Products(Id),
	IsSubstitute bit not null,
    constraint PK_RelatedProducts primary key (ProductId, RelatedProductId),
    constraint CK_RelatedDifferent check (ProductId <> RelatedProductId)
);

go

create table ProductReviews(
    Id bigint primary key identity(1, 1),
    ProductId bigint not null foreign key references Products(Id) on delete cascade,
    Text varchar(1000) not null,
    UserEmail varchar(100) not null,
	Review int not null,
    Created datetime not null
);

go

create table Retailers(
    Id bigint primary key identity(1, 1),
    Name varchar(100) not null,
    Created datetime not null,
    Updated datetime not null,
    ConcurrencyCheck timestamp null
);

go

create table RetailerProducts(
    ProductId bigint not null foreign key references Products(Id),
    RetailerId bigint not null foreign key references Retailers(Id),
    IsManufacturer bit not null,
    constraint PK_RetailerProducts primary key (ProductId, RetailerId),
	constraint PK_RetailerProductsUniqueManufacturer unique (ProductId, RetailerId, IsManufacturer),
    ConcurrencyCheck timestamp null
);

go

create table AuditLog(
	Id bigint not null primary key identity(1, 1),
	UpdatedEntity varchar(200) not null,
	UpdateType varchar(1) not null,
	UpdatedValue xml not null,
	Created datetime not null
);

go

SET IDENTITY_INSERT [dbo].[Products] ON 
GO
GO
INSERT [dbo].[Products] ([Id], [Name], [Image], [ReleaseDate], [Created], [Updated]) VALUES (3, N'Water', NULL, CAST(N'2018-01-05T00:00:00.000' AS DateTime), CAST(N'2018-05-01T08:15:48.833' AS DateTime), CAST(N'1753-01-01T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[RelatedProducts] ([ProductId], [RelatedProductId], [IsSubstitute]) VALUES (1, 3, 1)
GO
SET IDENTITY_INSERT [dbo].[ProductReviews] ON 
GO
INSERT [dbo].[ProductReviews] ([Id], [ProductId], [Text], [UserEmail], [Review], [Created]) VALUES (1, 1, N'Awesome!', N'thomas.gassmann@hotmail.com', 1, CAST(N'2016-02-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[ProductReviews] ([Id], [ProductId], [Text], [UserEmail], [Review], [Created]) VALUES (3, 3, N'I don''t like water!', N'tg.thomas.gassmann@gmail.com', 1, CAST(N'2018-05-01T08:16:21.297' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ProductReviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Retailers] ON 
GO
INSERT [dbo].[Retailers] ([Id], [Name], [Created], [Updated]) VALUES (1, N'Alibaba', CAST(N'2016-03-01T00:00:00.000' AS DateTime), CAST(N'2016-02-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Retailers] ([Id], [Name], [Created], [Updated]) VALUES (2, N'Tencent', CAST(N'2017-03-01T00:00:00.000' AS DateTime), CAST(N'2017-02-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Retailers] ([Id], [Name], [Created], [Updated]) VALUES (3, N'Baidu', CAST(N'2016-03-01T00:00:00.000' AS DateTime), CAST(N'2017-02-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Retailers] ([Id], [Name], [Created], [Updated]) VALUES (4, N'Google', CAST(N'2016-03-01T00:00:00.000' AS DateTime), CAST(N'2016-02-01T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Retailers] OFF
GO
INSERT [dbo].[RetailerProducts] ([ProductId], [RetailerId], [IsManufacturer]) VALUES (1, 1, 0)
GO
INSERT [dbo].[RetailerProducts] ([ProductId], [RetailerId], [IsManufacturer]) VALUES (1, 2, 1)
GO
INSERT [dbo].[RetailerProducts] ([ProductId], [RetailerId], [IsManufacturer]) VALUES (1, 3, 0)
GO
INSERT [dbo].[RetailerProducts] ([ProductId], [RetailerId], [IsManufacturer]) VALUES (3, 1, 1)
GO
INSERT [dbo].[RetailerProducts] ([ProductId], [RetailerId], [IsManufacturer]) VALUES (3, 4, 0)
GO
SET IDENTITY_INSERT [dbo].[AuditLog] ON 
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (1, N'TaobaoExpress.DataAccess.RelatedProduct', N'D', N'<RelatedProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RelatedProductId>2</RelatedProductId><IsSubstitute>false</IsSubstitute></RelatedProduct>', CAST(N'2018-04-24T12:23:24.843' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (2, N'TaobaoExpress.DataAccess.RelatedProduct', N'I', N'<RelatedProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RelatedProductId>2</RelatedProductId><IsSubstitute>false</IsSubstitute></RelatedProduct>', CAST(N'2018-04-24T12:23:47.127' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (3, N'TaobaoExpress.DataAccess.RelatedProduct', N'D', N'<RelatedProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RelatedProductId>2</RelatedProductId><IsSubstitute>false</IsSubstitute></RelatedProduct>', CAST(N'2018-04-24T12:23:51.947' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (4, N'TaobaoExpress.DataAccess.ProductReview', N'D', N'<ProductReview xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Id>2</Id><ProductId>2</ProductId><Text>Bad!</Text><UserEmail>thomas.gassmann@hotmail.com</UserEmail><Review>3</Review><Created>2016-03-01T00:00:00</Created></ProductReview>', CAST(N'2018-04-24T12:25:24.093' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (5, N'TaobaoExpress.DataAccess.RetailerProduct', N'D', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>2</ProductId><RetailerId>1</RetailerId><IsManufacturer>false</IsManufacturer><ConcurrencyCheck>AAAAAAAAB9g=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-04-24T12:25:24.177' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (6, N'TaobaoExpress.DataAccess.Product', N'D', N'<Product xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Id>2</Id><Name>Pepsi</Name><ReleaseDate>2016-03-01T00:00:00</ReleaseDate><Created>2016-02-01T00:00:00</Created><Updated>2016-02-01T00:00:00</Updated><ConcurrencyCheck>AAAAAAAAB9I=</ConcurrencyCheck></Product>', CAST(N'2018-04-24T12:25:24.200' AS DateTime))
GO
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (8, N'TaobaoExpress.DataAccess.Product', N'I', N'<Product xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Id>3</Id><Name>Water</Name><ReleaseDate>2018-01-05T00:00:00</ReleaseDate><Created>2018-05-01T08:15:48.8339047+02:00</Created><Updated>1753-01-01T00:00:00</Updated><ConcurrencyCheck>AAAAAAAAF3I=</ConcurrencyCheck></Product>', CAST(N'2018-05-01T08:15:48.907' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (9, N'TaobaoExpress.DataAccess.RelatedProduct', N'I', N'<RelatedProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RelatedProductId>3</RelatedProductId><IsSubstitute>true</IsSubstitute></RelatedProduct>', CAST(N'2018-05-01T08:16:00.270' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (10, N'TaobaoExpress.DataAccess.ProductReview', N'I', N'<ProductReview xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Id>3</Id><ProductId>3</ProductId><Text>I don''t like water!</Text><UserEmail>tg.thomas.gassmann@gmail.com</UserEmail><Review>1</Review><Created>2018-05-01T08:16:21.2964503+02:00</Created></ProductReview>', CAST(N'2018-05-01T08:16:21.353' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (11, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3M=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:35.870' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (12, N'TaobaoExpress.DataAccess.RetailerProduct', N'D', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAB9c=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:35.917' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (13, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RetailerId>3</RetailerId><IsManufacturer>false</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3Q=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:39.237' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (14, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3U=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:54.073' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (15, N'TaobaoExpress.DataAccess.RetailerProduct', N'D', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3M=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:54.127' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (16, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RetailerId>3</RetailerId><IsManufacturer>false</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3Y=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:56.337' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (17, N'TaobaoExpress.DataAccess.RetailerProduct', N'D', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RetailerId>3</RetailerId><IsManufacturer>false</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3Q=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:56.390' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (18, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3c=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:58.507' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (19, N'TaobaoExpress.DataAccess.RetailerProduct', N'D', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3U=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:16:58.547' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (20, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>4</RetailerId><IsManufacturer>false</IsManufacturer><ConcurrencyCheck>AAAAAAAAJxE=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:22:19.940' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (21, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RetailerId>2</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAJxI=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:22:24.697' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (22, N'TaobaoExpress.DataAccess.RetailerProduct', N'D', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RetailerId>2</RetailerId><IsManufacturer>false</IsManufacturer><ConcurrencyCheck>AAAAAAAAB9k=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:22:24.740' AS DateTime))
GO
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (24, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAANrI=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:26:44.300' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (25, N'TaobaoExpress.DataAccess.RetailerProduct', N'I', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>1</ProductId><RetailerId>1</RetailerId><IsManufacturer>false</IsManufacturer><ConcurrencyCheck>AAAAAAAANrM=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:26:44.300' AS DateTime))
GO
INSERT [dbo].[AuditLog] ([Id], [UpdatedEntity], [UpdateType], [UpdatedValue], [Created]) VALUES (26, N'TaobaoExpress.DataAccess.RetailerProduct', N'D', N'<RetailerProduct xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ProductId>3</ProductId><RetailerId>1</RetailerId><IsManufacturer>true</IsManufacturer><ConcurrencyCheck>AAAAAAAAF3c=</ConcurrencyCheck></RetailerProduct>', CAST(N'2018-05-01T08:26:44.347' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[AuditLog] OFF
GO