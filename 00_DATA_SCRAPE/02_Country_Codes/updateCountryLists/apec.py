# Get UN country list

# Install dependencies
# pip install requests
# pip install BeautifulSoup4

import urllib.request
from bs4 import BeautifulSoup
import datetime

page = urllib.request.urlopen('https://apec.org/About-Us/About-APEC')

soup = BeautifulSoup(page,'html.parser')

print(soup)

# Find all memberstates
memberstates = soup.find_all(class_='w1')

# Delete every second item in the array, since we don't want the dates
memberstates = memberstates[0::2]

# Remove code soup. Reunite "Hong Kong, China" into a single place after a find and replace targeted to another means accidentally separates the two.
memberstates = str(memberstates).replace("<td class=\"w1\">","").replace("</td>","").replace(", ","\n").replace("Hong Kong\nChina","Hong Kong, China").replace("[","CountryName"+datetime.datetime.today().strftime('%Y-%m-%d')+"\n").replace("]","")

# Print to CSV
f = open('../countryList-Apec.csv','w')
f.write(memberstates)
f.close()

f = open('../countryList-Apec.csv','r')
print(f.readlines())

