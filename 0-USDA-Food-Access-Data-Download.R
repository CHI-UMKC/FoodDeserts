# Download USDA Food Access data
# http://www.ers.usda.gov/data-products/food-access-research-atlas/download-the-data.aspx

# UMKC Center for Health Insights
# efg, 2014-09-09.

setwd("C:/Data/US-Government/USDA-Food/")  ##### Modify as appropriate
sink("0-USDA-Food-Access-Data-Download.txt", split=TRUE)

print(Sys.time())

DATA.DIR <- "Data/"
if (! file.exists(DATA.DIR) )
{
  dir.create(DATA.DIR)
}

library(downloader)  # platform neutral download function
library(tools)       # md5sum

URL.BASE <- "http://www.ers.usda.gov/datafiles/Food_Access_Research_Atlas/Download_the_Data/"

online.name <- c("Current_Version/DataDownload.xlsx",
                 "Current_Version/documentation.pdf",
                 "Archived_Version/data_download.xls",
                 "Archived_Version/archived_documentation.pdf")

local.name  <- c("Food-Access-Research-Atlas-Current.xlsx",
                 "Food-Access-Research-Atlas-Current.pdf",
                 "Food-Access-Research-Atlas-Archived.xls",
                 "Food-Access-Research-Atlas-Archived.pdf")

for (i in 1:length(online.name))
{
  cat(online.name[i], local.name[i], "\n")
  download(paste0(URL.BASE, online.name[i]),
           paste0(DATA.DIR, local.name[i]), mode="wb")
  print(md5sum(paste0(DATA.DIR, local.name[i])))
}

print(Sys.time())
print( file.info(list.files(path=DATA.DIR, full.names=TRUE, recursive=TRUE)) )

sink()

