library(lubridate)


crimedata = mongo("crime", "TYIT")

domestic = crimedata$find('{"Domestic":true}', fields='{"_id":0, "Domestic":1, "Date":1}')

domestic = data.frame(domestic)

domestic$Date = mdy_hms(domestic$Date)

domestic$Weekday = weekdays(domestic$Date)


weekdayCounts = as.data.frame(table(domestic$Weekday))
weekdayCounts$Var1 = factor(weekdayCounts$Var1, ordered=TRUE, labels=c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'))


ggplot(weekdayCounts, aes(Var1, Freq)) +
  geom_line(aes(group = 1, color= Var1), size=2)+
  xlab("Weekday")+
  ylab("Total Domestic Crimes")


ggtitle("Domestic Crimes")
