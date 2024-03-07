library(lubridate)


crimedata = mongo("crime", "TYIT")

domestic = crimedata$find('{"Domestic":true}', fields='{"_id":0, "Domestic":1, "Date":1}')

domestic = data.frame(domestic)

domestic$Date = mdy_hms(domestic$Date)

domestic$Weekday = weekdays(domestic$Date)

domestic$Hour = hour(domestic$Date)

dayHourCounts = as.data.frame(table(domestic$Weekday, domestic$Hour))

ggplot(dayHourCounts, aes(Var2, Freq)) +
  geom_line(aes(group = Var1, color= Var1), size=2)+
  xlab("Hour")+
  ylab("Total Domestic Crimes")


ggtitle("Domestic Crimes")
