# Get ASEAN country list

# Install dependencies
# pip install requests
# pip install BeautifulSoup4

import urllib.request
from bs4 import BeautifulSoup
import datetime

page = urllib.request.urlopen('http://asean.org/asean/asean-member-states/')

soup = BeautifulSoup(page,'html.parser')

soup = soup.find('div',id='post-418')

soup = soup.find_all('h3')

print(soup)

# Initialise new csv file
f=open('../countryList-ASEAN.csv','w')
f.write('AseanMemberStates'+datetime.datetime.today().strftime('%Y-%m-%d')+'\n')
f.close()

# Add countries
for x in soup:
	soup = x.text
	print(soup)
	f=open('../countryList-ASEAN.csv','a')
	f.write(soup+'\n')
	f.close()

