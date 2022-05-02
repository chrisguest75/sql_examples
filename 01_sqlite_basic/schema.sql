CREATE TABLE "person" 
( 
    [PersonId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [FirstName] NVARCHAR(128) NOT NULL,
    [LastName] NVARCHAR(128) NOT NULL,
    [Created] datetime default current_timestamp,
    [Modified] datetime default current_timestamp
);
