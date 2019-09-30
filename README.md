Sta 523 - Midterm 1 - Fall 2018
-----------

Due Friday, October 12th by 11:59 pm.

## Rules

1. Your solutions must be written up using the provided R Markdown file (`midterm1.Rmd)`, this file must include your code and write up for each task.

2. This exam is open book, open internet, closed other people. You may use *any* online or book based resource you would like, but you must include citations for any code that you use (directly or indirectly). You *may not* consult with anyone else about this exam other than the Professor or TAs for this course - this includes posting anything online.

3. You have until 11:59 pm on Friday, October 12th to complete this exam and turn it in via your personal Github repo - late work will not be accepted. Technical difficulties are not an excuse for late work - do not wait until the last minute to commit / push.

4. All of your answers *must* include a brief description / writeup of your approach. This includes both annotating / commenting your code *and* a separate written descriptions of all code / implementations. I should be able to suppress *all* code output in your document and still be able to read and make sense of your answers.

5. You may use any packages you want unless otherwise specified for a particular task.

6. The most important goal is to write code that can accomplish the given tasks, however grading will also be partially based on the quality of the code you write - elegant, efficient code will be rewarded and messy, slow code will be penalized.

<br />

## Data

For this exam you will be working with a data from the 2017 Formula 1 season. The data was downloaded from ergast.com in the form of a single large JSON file which contains information on the results of all 20 races from the 2017 season. Your repo should contain both the original json file (`f1_2017.json`) as well as an RDS binary file (`f1_2017.rds`) which can be read in using

```r
f1 = readRDS(file="f1.rds")
```

The data is structured as a list of lists of lists of lists and so on, it is up to you to look at the data and figure out how it is structured and how best to get at the information you want.

<br />

## Task 1 - Tidy the data (30 pts)

Starting from the `f1` object create a tidy data frame from these data including the following columns:

* `race` - The name of the race (character type)
* `round` - Round of the race (integer type, between 1 and 20)
* `date` - Date of the race (date type)
* `driver` - Name of a driver, including first and last name (character type)
* `constructor` - Name of a driver's constructor, i.e. team (character type)
* `position` - Position (place) driver finished in for the race (integer type, `NA` if they did not finish for any reason)
* `points` - Number of points the driver earned for the race (integer type)

<br/>


## Task 2 - Drivers' Championship (40 pts)

Using the data frame from Task 1, construct a table showing the World Drivers' Championship standings for this F1 season. This table should *resemble* but not be identical to the results available on [Wikipedia](https://en.wikipedia.org/wiki/2017_Formula_One_World_Championship#World_Drivers'_Championship_standings). Your data frame should also have 22 columns: Driver name, finishing position for all 20 races, and finally their overall points total for the season. Failure to finish for any reason (did not start, did not finish, disqualified, retired, etc.) should be coded as an `NA`. Race finishes and points total should all have an integer type. The order of the race columns should follow the chronological order in which the races occured. Finally, your data frame should be sorted by points total, but you do not need to include any additional logic to handle ties. 

<br />

## Task 3 - Cumulative Constructors (30 pts)

Using the data frame from Task 1 (as a starting point), construct a visualization that shows the cumulative points earned by each of the ten teams over the 20 races of the 2017 season. This plot should have points on the y-axis and race on the x-axis with team/constructor identified by color and/or any other reasonable aesthetic(s). 

<br />

## Extra credit

In either the table in Task 2 or the visualization in Task 3 include Emoji flags indicating the country in which each Race took place. For additional credit you can also include these flags for the nationality of the driver and or constructor.
