install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
install.packages("maps")
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)

###PartⅠ-A
## read the dataset
data <- read.csv("Vaccine Coverage and Disease Burden - WHO (2017).csv")

## view the data frame
glimpse(data)
data %>% group_by(Entity)

## select 2015 subdata(2015 is the newest year having data)
sub <- data %>%
  filter(Year==2015)

##number of missing value
sum(is.na(sub$BCG.immunization.coverage.among.1.year.olds..WHO.2017.))
sum(is.na(sub$Hepatitis.B..HepB3..immunization.coverage.among.1.year.olds..WHO.2017.))
sum(is.na(sub$DTP3.immunization.coverage.among.1.year.olds..WHO.2017.))
sum(is.na(sub$Polio..Pol3..immunization.coverage.among.1.year.olds..WHO.2017.))
sum(is.na(sub$Measles..MCV..immunization.coverage.among.1.year.olds..WHO.2017.))
sum(is.na(sub$Number.of.confirmed.tetanus.cases..WHO.2017.))
sum(is.na(sub$Number.confirmed.polio.cases..WHO.2017.))
sum(is.na(sub$Number.of.confirmed.pertussis.cases..WHO.2017.))
sum(is.na(sub$Number.of.confirmed.measles.cases..WHO.2017.))
sum(is.na(sub$Number.of.confirmed.diphtheria.cases..WHO.2017.))
sum(is.na(sub$Estimated.deaths.due.to.tuberculosis.per.100.000.population..excluding.HIV..WHO.2017.))
sum(is.na(sub$Estimated.number.of.deaths.due.to.tuberculosis..excluding.HIV..WHO.2017.))

## get means
mean(sub$BCG.immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
mean(sub$Hepatitis.B..HepB3..immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
mean(sub$DTP3.immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
mean(sub$Polio..Pol3..immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
mean(sub$Measles..MCV..immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
mean(sub$Number.of.confirmed.tetanus.cases..WHO.2017.,na.rm=T)
mean(sub$Number.confirmed.polio.cases..WHO.2017.,na.rm=T)
mean(sub$Number.of.confirmed.pertussis.cases..WHO.2017.,na.rm=T)
mean(sub$Number.of.confirmed.measles.cases..WHO.2017.,na.rm=T)
mean(sub$Number.of.confirmed.diphtheria.cases..WHO.2017.,na.rm=T)
mean(sub$Estimated.deaths.due.to.tuberculosis.per.100.000.population..excluding.HIV..WHO.2017.,na.rm=T)
mean(sub$Estimated.number.of.deaths.due.to.tuberculosis..excluding.HIV..WHO.2017.,na.rm=T)

## get standard deviation
sd(sub$BCG.immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
sd(sub$Hepatitis.B..HepB3..immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
sd(sub$DTP3.immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
sd(sub$Polio..Pol3..immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
sd(sub$Measles..MCV..immunization.coverage.among.1.year.olds..WHO.2017.,na.rm=T)
sd(sub$Number.of.confirmed.tetanus.cases..WHO.2017.,na.rm=T)
sd(sub$Number.confirmed.polio.cases..WHO.2017.,na.rm=T)
sd(sub$Number.of.confirmed.pertussis.cases..WHO.2017.,na.rm=T)
sd(sub$Number.of.confirmed.measles.cases..WHO.2017.,na.rm=T)
sd(sub$Number.of.confirmed.diphtheria.cases..WHO.2017.,na.rm=T)
sd(sub$Estimated.deaths.due.to.tuberculosis.per.100.000.population..excluding.HIV..WHO.2017.,na.rm=T)
sd(sub$Estimated.number.of.deaths.due.to.tuberculosis..excluding.HIV..WHO.2017.,na.rm=T)


###PartⅠ-B
## select the columes we need
data2 <- data[,c("Entity",
                 "Year",
                 "Polio..Pol3..immunization.coverage.among.1.year.olds..WHO.2017."
                )]

## rename the columes
colnames(data2) <- c("Entity","Year","Polio_coverage")
glimpse(data2)

## recoding variables
data$More_Tetanus <- data$Number.of.confirmed.tetanus.cases..WHO.2017. >
  data$Number.confirmed.polio.cases..WHO.2017.
data$More_Tetanus <- as.numeric(data$More_Tetanus)

## deal with NAs
##dat$Number.confirmed.polio.cases..WHO.2017.[is.na(dat$Number.confirmed.polio.cases..WHO.2017.)] <- 0
for(i in (nrow(data)-1):1){
  if(is.na(data$Number.of.confirmed.measles.cases..WHO.2017.[i])){
    data$Number.of.confirmed.measles.cases..WHO.2017.[i] <- data$Number.of.confirmed.measles.cases..WHO.2017.[i+1]
  }}

## creat new variable
data$Number.confirmed.polio.cases..WHO.2017. <- 
  as.numeric(is.na(data$Number.confirmed.polio.cases..WHO.2017.))

## reshape the data (from long format to wide format)
data2.wide <- data2 %>%
  pivot_wider(names_from = "Year",
              values_from = c('Polio_coverage')
  )
View(data2.wide)

# function
fill_na_with_mean <- function(data, column_name) {
  mean_val <- mean(data[[column_name]], na.rm = TRUE)
  data[[column_name]][is.na(data[[column_name]])] <- mean_val
  return(data)
}
data <- fill_na_with_mean(data, "Measles..MCV..immunization.coverage.among.1.year.olds..WHO.2017.")
data <- fill_na_with_mean(data, "Hepatitis.B..HepB3..immunization.coverage.among.1.year.olds..WHO.2017.")



##PartⅡ-A
##select north africa countries
north_Africa <- c("Morocco","Algeria","Tunisia", "Libya", "Egypt")
##creat new variable
data$isNorthAfrica <- data$Entity %in% north_Africa

sub <- data %>%
  filter(data$Year==2015)

##visualization
## plot 1: scatter plot
ggplot(data=sub)+
  geom_point(aes(
    x=Polio..Pol3..immunization.coverage.among.1.year.olds..WHO.2017.,
    y=Measles..MCV..immunization.coverage.among.1.year.olds..WHO.2017.,
    color=isNorthAfrica
  ))+
  ggtitle("MeasleS immunization coverage vs.Polio immunization coverage")+
  xlab("Polio coverage, 2015")+
  ylab("Measles coverage,2015")+
  xlim(0,100)+   
  ylim(0,100)    


##a function to replace NA values with the average of the previous 1 year and the next year
replaceNA <- function(vec){
  vec2 <- vec                                
  for(i in 2:length(vec2)){
    if(is.na(vec[i])){                       
      previous <- vec[1:(i-1)]                 
      last <- tail(previous[!is.na(previous)],1) 
      
      future <- vec[(i+1):length(vec)]        
      nex <- future[!is.na(future)][1]       
      vec2[i] <- (last+nex)/2                
    }
  }
  return(vec2)                              
}

##plot2
visualize2countries <- function(country1, country2){
  sub <- data %>%
    filter(data$Entity%in%c(country1,country2))   ## filter the data of the 2 countries
  
  sub$tetanus <- replaceNA(sub$Number.of.confirmed.tetanus.cases..WHO.2017.)                 ## replace NA with last year/next year average
  
  ggplot(data=sub)+
    geom_line(aes(x=Year,
                  y=tetanus,
                  color=Entity))+
    ggtitle(paste0("Number of tetanus cases ",country1," and ",country2))+
    xlab("Year")+
    ylab("Tetanus cases")
  ## make a line plot
}                    
visualize2countries("Egypt","Sudan")

## plot3
world <- map_data("world")

## select year 2015 data
sub <- data %>%
  filter(data$Year==2015)

## merge the map dataset and the vaccine data
world2 <- merge(world,sub,
                by.x="region",     ## the column in world
                by.y="Entity",     ## the column in sub
                all.x=T)
names(world2)[11] <- "Polio"

## reorder the dataset to ensure the plot can be made
world2 <- world2[order(world2$order),]

ggplot(data=world2)+
  geom_polygon(aes(x=long,y=lat,
                   group=group,
                   fill=Polio))+
  scale_fill_gradient(low="yellow",high="blue",
                      limits=c(0,100))+
  #coord_fixed(1.3)+
  ggtitle("Polio immunization coverage by country, 2015")
labs(color = "")





