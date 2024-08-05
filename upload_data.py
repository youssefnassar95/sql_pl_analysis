#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from time import time
from sqlalchemy import create_engine

pd.__version__

df = pd.read_csv('premier-league-matches.csv')

engine = create_engine('postgresql://root:root@localhost:5432/pl_data')

print(pd.io.sql.get_schema(df, name='premier-league-matches', con=engine))

df.to_sql(name='premier_league_stats', con=engine, if_exists='replace')
