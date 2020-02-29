
# Exercise

- Read the data file named *toronto_apartment_building_evaluation.csv*

- Inspect the data set using R

- Set the capitalization of the column names to lowercase (hint:`janitor::clean_names`)

- Change `N/A` values to `NA` so that R understands them as missing values (hint:`naniar::replace_with_na_all`)

- Inspect the data using basic graphs (For example, plot a histogram graph of the variable *year_built*) 
- Create a data set for all data from 1900s (hint:`dplyr::filter`)

- Figure out *the mean average* of the *stairwells* variable and *how many missing values exist* in the *laundry_rooms* variable for the new data set.

- Create a new variable: *decade_built* using the *year_built* variable (hint: `dplyr::mutate`)

- Plot the following graph only for the buildings with 3 or more storeys and save it as a PNG file (20 cm x 10 cm) (hint:`geom_jitter`, `ggsave`)


![](doc/toronto_apartments.png)
