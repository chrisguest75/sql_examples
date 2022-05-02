CREATE TABLE "sboms" (
    filename NVARCHAR(128) NOT NULL, 
    filetext JSON
);

CREATE TABLE "images" 
( 
    [ImageId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [Name] NVARCHAR(128) NOT NULL,
    [Type] NVARCHAR(32) NOT NULL
);

-- CREATE TABLE "scan" 
-- ( 
--     [ImageId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--     [ComponentId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,    
-- };

CREATE TABLE "components" 
( 
    [ComponentId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [Name] NVARCHAR(128) NOT NULL,
    [Type] NVARCHAR(32) NOT NULL,
    [Version] NVARCHAR(128) NOT NULL
);