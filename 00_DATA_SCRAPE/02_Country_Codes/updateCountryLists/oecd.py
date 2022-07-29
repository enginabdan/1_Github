# Get OECD country list

# Install dependencies
# pip install requests
# pip install BeautifulSoup4

import urllib.request
from bs4 import BeautifulSoup
import datetime

page = urllib.request.urlopen('http://www.oecd.org/about/membersandpartners/list-oecd-member-countries.htm')

soup = BeautifulSoup(page,'html.parser')

soup = soup.find_all('a', href=True, class_='country-list__country')

# Initialise list
oecdCountries = []

# Add link contents to list
for x in soup:
	x = x.text
	oecdCountries.append(x)

# Define countries that are not OECD countries but have the 'country-list__country' class
notReallyOecdCountries = ["Colombia", "Costa Rica", "Brazil", "China", "India", "Indonesia", "South Africa", "Africa", "Eurasia", "Latin America", "Middle East and North Africa", "Southeast Asia", "South East Europe"]

# Remove non OECD countries from our list
for j in notReallyOecdCountries:
	oecdCountries.remove(j)

# Initialise new csv file
f=open('../countryList-OECD.csv','w')
f.write('OecdMembers'+datetime.datetime.today().strftime('%Y-%m-%d')+'\n')
f.close()

# Add countries
for x in oecdCountries:
	f=open('../countryList-OECD.csv','a')
	f.write(x+'\n')
	f.close()
