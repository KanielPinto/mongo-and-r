library(mongolite)

crimedata = mongo(collection = "crime", db = "TYIT")

crimedata$find('{"Location Description":"STREET", "Arrest":true}', fields='{"Location Description":true, "Arrest":true}', limit=5)


query_result = crimedata$aggregate('[
    {
        "$group": {
            "_id": "$Location Description", 
            "count": {
                "$sum": 1
            }
        }
    }, {
        "$sort": {
            "count": -1
        }
    }, {
        "$limit": 5
    }
]')


result_df <- data.frame("Location Description" = sapply(query_result$"_id", function(x) x), 
                        "Count" = sapply(query_result$count, function(x) x))


result_df$Location.Description <- factor(result_df$Location.Description, levels = result_df$Location.Description[order(result_df$Count)])

ggplot(result_df, aes(x=Location.Description, y=Count)) +
  geom_bar(stat="identity") +
  labs(title = "Top 5 Crime Locations", x= "Location Description",y = "Count") +
  theme_minimal()
