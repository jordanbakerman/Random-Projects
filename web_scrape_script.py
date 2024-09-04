#Import Packages
import time
import pandas as pd
import requests
from bs4 import BeautifulSoup
from selenium import webdriver

#Stop collecting data on date
end_date = "27.07.2017"

#Ready chrome driver
chrome_path = r"C:\Users\baker\Desktop\chromedriver.exe"
driver = webdriver.Chrome(chrome_path)
driver.get("https://sputniknews.com/archive/")

#Click button until we get to desired date
temp_len = 1
temp_val = False
while(temp_val==False):
    time.sleep(2)
    driver.find_element_by_xpath("/html/body/div[8]/div[1]/div[3]/a").click()
    
    #Grab the webpage
    soup=BeautifulSoup(driver.page_source)
    links = soup.find_all("a")
    g_data = soup.find_all("div", {"class": "b-plainlist__info"})

    #Save desired information
    vec1 = []
    for item in g_data:
        #print item.contents[0].find_all("span",{"class":"b-plainlist__date"})[0].text
        #print item.contents[1].text
        #print item.contents[2].find("a")["href"]
        vec1.append(item.contents[0].find_all("span",{"class":"b-plainlist__date"})[0].text)


    #Convert format
    vec1 = [x.encode('utf-8') for x in vec1]
    temp_len = len(vec1)-1
    temp_val = vec1[temp_len].split(" ")[1] == end_date

#Grab the final webpage
soup=BeautifulSoup(driver.page_source)
links = soup.find_all("a")
g_data = soup.find_all("div", {"class": "b-plainlist__info"})

#Save desired information
vec1 = []
vec2 = []
vec3 = []
for item in g_data:
    #print item.contents[0].find_all("span",{"class":"b-plainlist__date"})[0].text
    #print item.contents[1].text
    #print item.contents[2].find("a")["href"]
    vec1.append(item.contents[0].find_all("span",{"class":"b-plainlist__date"})[0].text)
    vec2.append(item.contents[1].text)
    vec3.append(item.contents[2].find("a")["href"])

#Convert format
vec1 = [x.encode('utf-8') for x in vec1]
vec2 = [x.encode('utf-8') for x in vec2]
vec3 = [x.encode('utf-8') for x in vec3]

#Delete observations past desired day
rev_range = range(len(vec1)-1, -1, -1)
temp_val=True
count = 0
while(temp_val==True):
    temp_val = vec1[rev_range[count]].split(" ")[1] == end_date
    count+=1

count = count-1
vec1 = vec1[:-count]
vec2 = vec2[:-count]
vec3 = vec3[:-count]

#Add the base URL string onto the href URL
base_url_str = ("https://sputniknews.com")
vec3 = [base_url_str + x for x in vec3]

#Create data frame and save the scrape
df_time = pd.DataFrame(vec1,columns=["Time"])
df_title = pd.DataFrame(vec2,columns=["Title"])
df_url = pd.DataFrame(vec3,columns=["URL"])
df = pd.concat([df_time, df_title,df_url], axis=1)     
df.to_csv('C:\\Users\\baker\\Desktop\\scrape_data.csv',index=False)

print "DONE"

