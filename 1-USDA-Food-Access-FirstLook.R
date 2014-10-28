# First look at USDA Food Access data
# http://www.ers.usda.gov/data-products/food-access-research-atlas/download-the-data.aspx

# UMKC Center for Health Insights
# efg, 2014-09-09.

########################################################################
setwd("C:/Data/US-Government/USDA-Food/")  ##### Modify as appropriate
sink("1-USDA-Food-Access-FirstLook.txt", split=TRUE)
print(Sys.time())

# R: Increase heap size for rJava
# http://www.bramschoenmakers.nl/en/node/726
options(java.parameters = "-Xmx4g")
library(XLConnect)

########################################################################
d <- readWorksheetFromFile("Data/Food-Access-Research-Atlas-Current.xlsx", sheet=3)
str(d)

length(unique(d$CensusTract))

table(d$State)
length(unique(paste0(d$State, "|", d$County)))

########################################################################
fields <- readWorksheetFromFile("Data/Food-Access-Research-Atlas-Current-Fields.xlsx", sheet=1)

for (i in 1:nrow(fields))
{
  if (fields$Check[i] %in% c("Binary","Table"))
  {
    cat("\n", i, "|", fields$Field[i], "|", fields$LongName[i])
    print(table(d[,fields$Field[i]]))
    flush.console()
  }

}

pdf("1-USDA-Food-Access-FirstLook.pdf")
for (i in 1:nrow(fields))
{
  if (fields$Check[i] == "Boxplot")
  {
    cat("\n", i, "|", fields$Field[i], "|", fields$LongName[i], "\n")
    print(fivenum(d[,fields$Field[i]]))
    boxplot(d[,fields$Field[i]],
            main=paste0(i, " ", fields$Field[i]))
    mtext(fields$LongName[i])
  }
}
dev.off()


########################################################################
print(Sys.time())
sink()

