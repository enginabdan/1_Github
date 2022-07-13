# Get Mercosur country list

# Recommended use: Do not run this script more than once per day. The Mercosur website uses a Wordpress plugin called Bad Behaviour which blocks access if it observes too many requests from the same source.

# Install dependencies
# pip install requests
# pip install BeautifulSoup4

import urllib.request
from bs4 import BeautifulSoup
import datetime

page = urllib.request.urlopen('https://www.mercosur.int/en/about-mercosur/mercosur-countries/')

soup = BeautifulSoup(page,'html.parser')

print(soup)

memberstates = soup.find_all('h3')


# Replace the cruft
memberstates = str(memberstates).replace("<h3 style=\"text-align: center;\">","").replace("</h3>","").replace("<span style=\"color: #0055b7;\">","").replace("</span>","").replace("<span style=\"color: #ffffff;\">","").replace("<br/>","").replace(" ,",",").replace(" Entry of new member States","").replace("*","")

# Add newline after every comma
memberstates = memberstates.replace(", ","\n")

# Add newline before and after headings
memberstates = memberstates.replace("Associated States","\n"+"# ASSOCIATED STATES"+"\n")
memberstates = memberstates.replace("States Parties","\n"+"# STATES PARTIES"+"\n")

# Add date to beginning of file and remove brackets from end of file
memberstates = memberstates.replace("[","CountryName"+datetime.datetime.today().strftime('%Y-%m-%d')+"\n").replace(",]","\n")

f = open('../countryList-Mercosur.csv','w')
f.write(memberstates)
f.close()

f = open('../countryList-Mercosur.csv','r')
print(f.readlines())
