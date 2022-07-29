# Get Schengen country list

# Install dependencies
# pip install requests
# pip install BeautifulSoup4

import urllib.request
from bs4 import BeautifulSoup
import datetime

page = urllib.request.urlopen('https://europa.eu/european-union/about-eu/countries_en')

soup = BeautifulSoup(page,'html.parser')

soup = soup.find('div',id='sub-section-1')

soup = soup.find_all('li')

print(soup)

# Initialise new csv file
f=open('../countryList-SCHENGEN.csv','w')
f.write('SchengenMemberStates'+datetime.datetime.today().strftime('%Y-%m-%d')+'\n')
f.close()

# Add countries
for x in soup:
	soup = x.text
	print(soup)
	f=open('../countryList-SCHENGEN.csv','a')
	f.write(soup+'\n')
	f.close()

