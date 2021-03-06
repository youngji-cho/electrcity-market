setwd("~/Dropbox/Programming/R/data")
library(dplyr)
library(xlsx)
library(ggplot2)
require(scales)
p 
#eia-826 green pricing 
gp.company<-read.xlsx(file="U.S.-greenpricing-2014.xls",sheetIndex = 1,colIndex=1:20,colClasses = c("numeric","numeric","character","character","character",
                                                                                                     "numeric","numeric","numeric","numeric","numeric","numeric",
                                                                                                     "numeric","numeric","numeric","numeric","numeric","numeric",
                                                                                                     "numeric","numeric","numeric","numeric","numeric","numeric"))
gp.state<-read.xlsx2(file="U.S.-greenpricing-2014.xls",sheetIndex = 3,colClasses = c("numeric","numeric","character",
                                                                                      "numeric","numeric","numeric","numeric","numeric","numeric",
                                                                                      "numeric","numeric","numeric","numeric","numeric","numeric",
                                                                                      "numeric","numeric","numeric","numeric","numeric","numeric"))
names(gp.company)<-c("year","month","state","utility_ID","utility_name","residential_gp_revenue","commercial_gp_revenue","industrial_gp_revenue","trans_gp_revenue", "total_gp_revenue",
                     "residential_gp_sales","commercial_gp_sales","industrial_gp_sales","trans_gp_sales","total_gp_sales",
                     "residential_gp_customer","commercial_gp_customer","industrial_gp_customer","trans_gp_customer","total_gp_customer")
names(gp.state)<-c("year","month","state","residential_gp_revenue","commercial_gp_revenue","industrial_gp_revenue","trans_gp_revenue", "total_gp_revenue",
                   "residential_gp_sales","commercial_gp_sales","industrial_gp_sales","trans_gp_sales","total_gp_sales",
                   "residential_gp_customer","commercial_gp_customer","industrial_gp_customer","trans_gp_customer","total_gp_customer")


gp.company.final<-gp.company[!is.na(gp.company$YEAR),]
gp.state.final$total_gp_sales<-round(gp.state.final$total_gp_sales,0)
gp.state.final<-gp.state[1:45,]

gp.company.price<-data.frame(select(gp.company,year:utility_name),
                           gp_residential_price<-gp.company$residential_gp_revenue/gp.company$residential_gp_sales,
                           gp_commercial_price<-gp.company$commercial_gp_revenue/gp.company$commercial_gp_sales,
                           gp_residential_price<-gp.company$industrial_gp_revenue/gp.company$industrial_gp_sales)

gp.state.price<-data.frame(select(gp.state,year:state),
                           gp_residential_price<-gp.state$residential_gp_revenue/gp.state$residential_gp_sales
                           gp_commercial_price<-gp.state$commercial_gp_revenue/gp.state$commercial_gp_sales
                           gp_residential_price<-gp.state$industrial_gp_revenue/gp.state$industrial_gp_sales)


gp.state.graph.total<-ggplot(gp.state.final,aes(x=state,y=total_gp_sales,fill=total_gp_sales))+
                       geom_bar(stat="identity")+
                       ggtitle("US green price sales per state")+
                       ylab("Green price sales(Mwh)")+
                       xlab("State")+
                       theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                       scale_y_continuous(labels = comma)

gp.state.graph.res<-ggplot(gp.state.final,aes(x=state,y=residential_gp_sales,fill=residential_gp_sales))+
                    geom_bar(stat="identity")+
                    ggtitle("US green price sales per state(residential)")+
                    ylab("Green price sales(Mwh)")+
                    xlab("State")+
                    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                    scale_y_continuous(labels = comma)

gp.state.graph.com<-ggplot(gp.state.final,aes(x=state,y=commercial_gp_sales,fill=commercial_gp_sales))+
                    geom_bar(stat="identity")+
                    ggtitle("US green price sales per state(commercial)")+
                    ylab("Green price sales(Mwh)")+
                    xlab("State")+
                    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                    scale_y_continuous(labels = comma)

gp.state.graph.ind<-ggplot(gp.state.final,aes(x=state,y=industrial_gp_sales,fill=industrial_gp_sales))+
                    geom_bar(stat="identity")+
                    ggtitle("US green price sales per state(industrial)")+
                    ylab("Green price sales(Mwh)")+
                    xlab("State")+
                    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                    scale_y_continuous(labels = comma)
