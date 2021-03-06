# install.packages("ggplot2")
library(ggplot2)

# Source: https://stat.gov.pl/infografiki-widzety/infografiki/infografika-cukier-w-polsce,82,1.html

years = 2010:2017
sugar_consumption_per_capita = c(39.9, 39.4, 42.5, 41.9, 44.3, 40.5, 42.3, 44.5) # in kilograms
sugar_price = c(2.73, 4.07, 3.96, 3.60, 2.50, 2.23, 2.87, 3.04) # for 1 kilogram in PLN

sugar_in_Poland = data.frame(years,
                             sugar_consumption_per_capita,
                             sugar_price)

ggplot(data = sugar_in_Poland, aes(x = years)) +
  ggtitle("Sugar consumption and sugar prices in Poland (2010-2017)") +
  geom_col(data = sugar_in_Poland, 
           aes(x = years, 
               y = sugar_price, 
               fill = sugar_consumption_per_capita), 
           position = "dodge",
           ylab("Sugar prices per kg (PLN)")) + 
  xlab("") +
  ylab("Sugar price for kg (PLN)") +
  guides(fill=guide_legend(title="Consumption pp (kg)")) +
  theme_bw()
