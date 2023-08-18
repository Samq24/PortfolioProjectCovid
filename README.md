# Exploring COVID-19 Data, Mobility Changes, and CO2 Emissions

Hello! I took on a project to delve into Covid-19 data from around the world. My main aim was to collect up-to-date information on cases and deaths. Additionally, I wanted to understand how people's mobility changed during the pandemic and how CO2 emissions from sources like oil, gas, and carbon were affected.

To start, I gathered the latest Covid-19 data in CSV format from a website called ourworldindata.org. After that, I obtained mobility data during the pandemic period, which I found as CSV files on google.com/covid19/mobility/. Lastly, I retrieved data on CO2 emissions from oil, gas, and carbon from ourworldindata.org once again.

Once I had all the data in place, I formulated a series of important questions that I wanted to answer. Here's what I was curious about:

- How do the total number of cases compare to the total number of deaths?
- What's the percentage of deaths in relation to the population?
- Which countries were hit the hardest compared to their population?
- Which continents had the highest number of Covid-19 deaths?
- What's the overall global picture?
- Did changes in people's mobility relate to the number of cases?
- Could there be a connection between changes in park visits and new Covid-19 deaths?
- How did mobility at transit stations change along with the level of rules in place?
- And how did CO2 emissions from oil, gas, and carbon look during this time?

I used Microsoft SQL Server Management Studio to work with the data. I set up a database and imported all the information.

Next, I dug into the data using SQL queries to extract the insights I was after. I looked at things like case counts, death counts, and various comparisons. I tried to keep it straightforward while making sure the analyses were meaningful.

Once I had all the results, I used Tableau to create visual representations like charts and graphs. This made it easier to grasp the key takeaways without getting lost in the details.

If you're interested in checking out the actual Covid-19 data, you can find it on ourworldindata.org/coronavirus since the file sizes were a bit too large to share here. And if you're curious about how everything came together, you can see the final visualizations at public.tableau.com/app/profile/samael.quiros.

So, in essence, my Covid-19 project aimed to uncover insights from the data, focusing on the pandemic's impact, changes in mobility, and the CO2 emissions story. It's about using data analysis and visualization to make sense of complex situations in a clear and meaningful way.

**Here's a breakdown of what each query does:**

1. **Creating the Excluded Locations Table:**
   - A temporary table named `#excluded_locations` is created.
   - It contains a list of predefined locations that will be excluded from further analysis.

2. **Final Dashboard Query:**
   - Retrieves COVID-19 data from the 'owid-covid-data$' table.
   - Filters out data for locations listed in the `#excluded_locations` table.
   - Displays selected columns: location, date, new_cases, new_deaths, total_deaths, and population.
   - Orders the result by location and date.

3. **Total Cases vs Total Deaths Query:**
   - Retrieves COVID-19 data from the 'owid-covid-data$' table.
   - Excludes data for locations in the `#excluded_locations` table.
   - Groups data by location.
   - Calculates total cases, total deaths, population, and death percentage.
   - Orders the result by location.

4. **Percentage of Total Deaths vs Population Query:**
   - Retrieves COVID-19 data from the 'owid-covid-data$' table.
   - Excludes data for locations in the `#excluded_locations` table.
   - Groups data by location.
   - Calculates the percentage of the population infected with COVID-19.
   - Orders the result by location.

5. **Countries with Highest Infection Rate Query:**
   - Retrieves COVID-19 data from the 'owid-covid-data$' table.
   - Excludes data for locations in the `#excluded_locations` table.
   - Groups data by location and population.
   - Calculates the highest infection count and percentage of population infected.
   - Orders the result by location and population.

6. **Continents with Highest Death Count Query:**
   - Retrieves COVID-19 data from the 'owid-covid-data$' table.
   - Excludes data for locations and continents in the `#excluded_locations` table.
   - Groups data by continent.
   - Calculates total cases count and total deaths count for each continent.
   - Orders the result by total cases count in descending order.

7. **Global Numbers Query:**
   - Retrieves COVID-19 data from the 'owid-covid-data$' table.
   - Excludes data for locations and continents in the `#excluded_locations` table.
   - Groups data by date.
   - Calculates total cases, total deaths, and death percentage.
   - Orders the result by date.

8. **Workplace Mobility vs Total Cases Query:**
   - Joins data from 'changes-visitors-covid$' and 'owid-covid-data$' tables.
   - Calculates the average workplace mobility and total cases per date.
   - Excludes data for locations in the `#excluded_locations` table.
   - Groups data by date.
   - Orders the result by date.

9. **Correlation Between Mobility in Parks and New COVID-19 Deaths Query:**
   - Joins data from 'changes-visitors-covid$' and 'owid-covid-data$' tables.
   - Calculates the average mobility in parks and total new deaths per date.
   - Excludes data for locations in the `#excluded_locations` table.
   - Groups data by date.
   - Orders the result by date.

10. **Mobility in Transit Stations vs Stringency Index Query:**
   - Joins data from 'changes-visitors-covid$' and 'owid-covid-data$' tables.
   - Calculates the average mobility in transit stations and stringency index per date.
   - Excludes data for locations in the `#excluded_locations` table.
   - Groups data by date.
   - Orders the result by date.

11. **Dropping the Excluded Locations Table:**
   - Drops the temporary table `#excluded_locations`.
