library(fixest)

model_percent <- feols(percent_AfD ~ percent_Voters, data = data_regression)
model_number <- feols(number_AfD ~ number_Voters, data = data_regression)

esttex(model_percent, model_number)
