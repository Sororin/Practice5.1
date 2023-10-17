library(leaflet)
library(rgdal)

# download Taiwan data from internet
url <- 'https://data.moi.gov.tw/MoiOD/System/DownloadFile.aspx?DATA=72874C55-884D-4CEA-B7D6-F60B0BE85AB0'
path1 <- tempfile(fileext = ".zip")
if (file.exists(path1))  'file alredy exists' else download.file(url, path1, mode="wb")
zip::unzip(zipfile = path1,exdir = 'Data')
Taiwan <- readOGR('Data/COUNTY_MOI_1090820.shp', use_iconv=TRUE, encoding='UTF-8')

# mark location (some tourist spots I recommend)
SML <- paste(sep = "<br/>",
             "<b><a href='https://www.sunmoonlake.gov.tw/en'>Sun Moon Lake</a></b>",
             "Sun Moon Lake",
             "Nantou County tourist spot"
)

TPL <- paste(sep = "<br/>",
             "<b><a href='https://lifetree.typl.gov.tw/'>Taoyuan Public Library</a></b>",
             "Life Tree",
             "Taoyuan City tourist spot",
             "No. 303, Nanping Rd, Taoyuan District, Taoyuan City, 330"
)

XP <- paste(sep = "<br/>",
            "<b><a href='https://www.xpark.com.tw/english.php'>Xpark</a></b>",
            "Xpark Aquarium",
            "Taoyuan City tourist spot",
            "No. 105, Chunde Rd, Zhongli District, Taoyuan City, 320"
)

P2 <- paste(sep = "<br/>",
            "<b><a href='https://en.pier2.org/'>Pier-2</a></b>",
            "Pier-2 Art Center",
            "Kaohsiung City tourist spot",
            "No. 1, Dayong Rd, Yancheng District, Kaohsiung City, 803"
)

MMBA <- paste(sep = "<br/>",
              "<b><a href='https://www.nmmba.gov.tw/En/'>NMMBA</a></b>",
              "Museum of Marine Biology & Aquarium",
              "Pingtung County tourist spot",
              "No. 2, Houwan Rd, Checheng Township, Pingtung County, 944"
)

# create a group with four county where the tourist spot locate
tourcounty <- subset(Taiwan, Taiwan$COUNTYENG %in% c(
  "Nantou County","Pingtung County","Kaohsiung City","Taoyuan City"
))

# create interactive map (with marks and purple polygons for tourist county and spot)
leaflet(tourcounty) %>%
  setView(121, 23.8, 7) %>%
  addPolygons(weight=0.8,color = "purple") %>%
  addTiles(group="Kort") %>%
  addMarkers(120.91, 23.85, popup = ~as.character(SML)) %>%
  addMarkers(121.29, 25.01, popup = ~as.character(TPL)) %>%
  addMarkers(121.21, 25.01, popup = ~as.character(XP)) %>%
  addMarkers(120.28, 22.62, popup = ~as.character(P2)) %>%
  addMarkers(120.70, 22.04, popup = ~as.character(MMBA))



