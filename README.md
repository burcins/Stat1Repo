Statistics with R

Introduction
The data to be used for this assignment can be found in the file Drugs.txt. It includes data published by OECD on pharmaceutical drug spending by countries with indicators such as a share of total health spending, in USD per capita (using economy-wide PPPs) and as a share of GDP. Plus, total spending by each countries in the specific year.
The variables in the dataset are:
Variable name /   Description
LOCATION      /   Country code
TIME          /   Date (Year)
PC HEALTHXP   /   % of Health spending that is spent on pharmaceutical drugs
PC GDP        /   % of GDP
USD_CAP       /   CAP in USD per capita (using economy-wide PPPs)
TOTAL SPEND   /   Total spending in millions USD
Questions
1. Load the data in an object named Drugs. You will notice there is an additional variable called FLAG_CODES. Remove this variable from the dataset

2. How many countries are there? Make a table with the countrys' acronyms and the number of datapoints (years) per country, sorted in ascending order (the country with the least datapoints appears first)

3. Make a selection of countries based on the number of datapoints available. Specifically, select the countries that have a number of points in the top 25% of the distribution of number of datapoints, thus representing the countries with the most information available.

4. Using only the data selected in Q3, create a graph with 4 plots (in the same window). Each plot should depict the development of the drug spending for all countries in the reduced dataset, over the available years. Each graph should depict one of the metrics (4 metrics= 4 graphs). In each graph, a separate line should represent a country. The legend should show which line represents each country. The main title of each plot should mention "Drug spending in XX (type of metric)". define the x-axis limits by the range found in the dataset, that is, smallest year found in the dataset up to largest year found in the dataset.)

5. Your client is a multinational pharmaceutical company. They are interested in the probability that Greece (GRC) will increase its drug expenditure in at least 4 of the 5 following consecutive years, in order to assess the investing opportunities. Assume that we are at the year following the last record for Greece. Estimate the probability of drug expenditure increase in any given year by the number of years where the expenditure was higher than the year before (note: this is not an appropriate way of estimating this probability, only use it for this assignment!). Create a list with the following elements, named accordingly:
$Data - The data for Greece
$Years - The range (in years) of available data points for Greece, a vector with two elements, the minimum and maximum years
$Data.points - The number of available data points for Greece
$YearlyProbs - The yearly probabilities of increase in expenditure, in all the four metrics available, thus a vector with 4 elements and names according to the metric
$FiveYeProbs - The requested probabilities for all metrics, thus a vector with 4 elements and names according to the metric

6. Your client asks for a function that can calculate the above probabilities for a variable amount of years and for any country desired. Create a function, that it will take as arguments (and default values):

 $DATA=NULL Data in the same form as the dataset (without the FLAG_CODES variable)
 $METRIC="pc.gdp" The metric in which the required probability needs to be reported. Possible values should be "pc.gdp" (% of GDP), "pc.tot" (% of total health expenditure), "per.ca" (absolute expenditure per capita), and "total" (total absolute spending).
 $nofY=5 The number of following consecutive years that the probability needs to be estimated. Every time the probability estimated should be of the form "The probability of increasing drug expenditure in at least nofY-1 out of the following nofY years".

The outcome of the function should be a sentence of the form:
"Based on (XX) datapoints from years (minYear) to (maxYear), the probability that (countrycode) will increase its drug expenditure, in terms of (metric chosen), in at least (nofY-1) years in the period (maxYear+1) to (maxYear+1+nofY) is (estimated probability)".
If the number of available datapoints for the calculation of the yearly increase probability is less than 10 (thus, less than 11 years of data), the function should return :
"Unable to calculate probability (n< 10)", without any other output.
