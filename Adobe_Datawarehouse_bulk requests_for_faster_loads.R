library(RSiteCatalyst)

## authenticate using Adobe Analytics credentials

## accessible from your account info page

## if you are in the Web Services Group

SCAuth("uname","key")



## set report suite

rsid <- "report_suite_id"


## get report suite variable and setting information

## this will help you populate the metrics and elements to populate in the report

## e.g. to view enabled events run View(meta_info$event)

meta_info <- list(
  
  ecom = GetEcommerce(rsid),
  
  event = GetSuccessEvents(rsid),
  
  elements = GetElements(rsid),
  
  mc_rules = GetMarketingChannelRules(rsid),
  
  classification = GetClassifications(rsid)
  
)



# set the date range for the first request

# date_index indicates start

# because i want a weekly report i have used +6 for the date_range

date_index <- as.Date("2017-10-01")

date_range <- date_index + 6

# sets an index so i can track progress

i <- 0





## while look creates the request as long as end date is below a certain criteria

## ftp location is where the files will be uploaded

while (date_range < as.Date("2018-10-01")) {
  
  ## print status
  
  print(paste0("date: ",date_index))
  
  print(paste0("index: ",i))
  
  
  ## make request, granularity set to daily
  
  QueueDataWarehouse(reportsuite.id = rsid,
                     
                     date.from = date_index,
                     
                     date.to = date_range,
                     
                     metrics = c("event1", "cartadditions","checkouts","orders","units","revenue"),
                     
                     elements = c("evar48","evar33","visitnumber","geocity","entrypage",
                                  
                                  "firsttouchchannel","lasttouchchannel","evar9","evar6","evar79",
                                  
                                  "product"),
                     
                     date.granularity = "day",
                     
                     enqueueOnly=TRUE,
                     
                     ftp = list(host = "yourftpserver.in",
                                
                                port = "21",
                                
                                directory = "/your/folder/"
                                
                                username = "ftp_username",
                                
                                password = "ftp_password",
                                
                                filename = paste0("output_file_name",date_index,".csv"))
                     
  )
  
  
  ## update index for next call
  
  date_index <- date_range + 1
  
  date_range <- date_index + 6
  
  i <- i + 1 
  
}