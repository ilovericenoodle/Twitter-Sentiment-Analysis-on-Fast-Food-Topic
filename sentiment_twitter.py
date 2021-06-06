#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jun  4 17:45:35 2021

@author: kenny
"""

import os
import csv
import pandas as pd

path = os.getcwd()
print(path)
os.chdir("/Users/kenny/Downloads/")

#read in the twitter data 
ana = pd.read_csv('/Users/kenny/Downloads/twitter_for_r.csv')
ana.head(10)
# create a list of tweets
data = list(ana["tweet"])

#sentiment analyis
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
scores = []
analyzer = SentimentIntensityAnalyzer()
for txt in data:
    vs = analyzer.polarity_scores(txt)
    scores.append(vs)
data = pd.DataFrame(data, columns= ['Text'])
data2 = pd.DataFrame(scores)
final_dataset= pd.concat([data, data2], axis=1)

final_dataset.head(10)

#output the wteet + sentiment score
final_dataset.to_csv('tweet_sent.csv' ,index = True, header=True)

filename = "output.txt"
