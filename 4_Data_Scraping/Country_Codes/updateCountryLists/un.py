# Get UN country list

# Install dependencies
# pip install requests
# pip install BeautifulSoup4

import urllib.request
from bs4 import BeautifulSoup
import datetime

page = urllib.request.urlopen('http://www.un.org/en/member-states/index.html')

soup = BeautifulSoup(page,'html.parser')

print(soup)

memberstates = soup.find_all(class_='member-state-name')

memberstates = str(memberstates).replace("<span class=\"member-state-name\">","").replace("</span>","").replace(", ","\n").replace("[","CountryName"+datetime.datetime.today().strftime('%Y-%m-%d')+"\n").replace("]","")

f = open('../countryList-UN.csv','w')
f.write(memberstates)
f.close()

f = open('../countryList-UN.csv','r')
print(f.readlines())

