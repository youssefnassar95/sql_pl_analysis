# SQL - Premier League Teams' Performance Analysis

Technology used: *sql, python, ipython-sql, postgresql, pgadmin, docker*

## Abstract

This project uses a database of all historical Premier League results to analyze each team performances, league record etc.

Data source: [Kaggle](https://www.kaggle.com/datasets/evangower/premier-league-matches-19922022)

The project includes:
- running docker container for postgres database
- ingesting data to postgres with python in [*upload_data.py*](https://github.com/youssefnassar95/sql_pl_analysis/blob/main/upload_data.py)
- performing operations on database, calculations, statistics
- creating new tables
- grouping and sorting data
- using subquery to extract desired data and joined them with existing data in table


## Creating a database and tables

The process of creating the database and tables with customers, products and orders was performed using PostgreSQL and stored in file [*premier_league.sql*](https://github.com/youssefnassar95/sql_pl_analysis/blob/main/premier_league.sql).

## Analysis

The documentation of the data analysis process is included in the file [*premier_league.ipynb*](https://github.com/youssefnassar95/sql_pl_analysis/blob/main/premier_league.ipynb).

## Summary

The project was done for the purpose of practice and to improve skills in SQL.