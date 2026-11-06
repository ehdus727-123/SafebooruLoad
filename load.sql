LOAD DATA LOCAL INFILE 'C:/safebooru_load/current.csv'
REPLACE INTO TABLE posts
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@ID,@Err,@Media,@Ext,@Year,@Month,@Cop,@Chr,@Art,@Gen,@Meta,@Oth,
 @W,@H,@FS,@Sc,@Src,@Url,@Posted,@TC,@DA,@PH)
SET ID=@ID,
    ErrMessage=NULLIF(@Err,''),   MediaType=NULLIF(@Media,''), Ext=NULLIF(@Ext,''),
    `Year`=NULLIF(@Year,''),      `Month`=NULLIF(@Month,''),
    Copyrights=NULLIF(@Cop,''),   `Characters`=NULLIF(@Chr,''), Artists=NULLIF(@Art,''),
    General=NULLIF(@Gen,''),      Meta=NULLIF(@Meta,''),        Other=NULLIF(@Oth,''),
    Width=NULLIF(@W,''),          Height=NULLIF(@H,''),         FileSize=NULLIF(@FS,''),
    Score=NULLIF(@Sc,''),         Source=NULLIF(@Src,''),       ImageURL=NULLIF(@Url,''),
    Posted=NULLIF(@Posted,''),    TimeCollected=NULLIF(@TC,''), DownloadedAt=NULLIF(@DA,''),
    PerceptualHash=NULLIF(@PH,'');
SELECT ROW_COUNT() AS affected, (SELECT COUNT(*) FROM posts) AS total_rows;