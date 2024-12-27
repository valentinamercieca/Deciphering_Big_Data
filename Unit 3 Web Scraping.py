import requests
from bs4 import BeautifulSoup
import json

url = 'https://www.careerjet.com.mt/data-science-jobs.html'  # Use the correct URL here

# Send a GET request to the page
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

# List to hold all the job data
jobs = []

# Find all job listings on the page
for job in soup.find_all('article', class_='job clicky'):
    # Try to get the job title from the <a> tag with the title attribute
    title_elem = job.find('a', title=True)
    if title_elem:
        title = title_elem.get('title').strip()
    else:
        title = "N/A"
    
    # Filter for "Data Scientist" in the job title or description
    if "data scientist" not in title.lower():
        continue  # Skip jobs that are not related to Data Scientist
    
    # Extract the company
    company_elem = job.find('p', class_='company')
    company = company_elem.text.strip() if company_elem else "N/A"
    
    # Extract the location
    location_elem = job.find('ul', class_='location')
    location = location_elem.find('li').text.strip() if location_elem and location_elem.find('li') else "N/A"
    
    # Extract the salary
    salary_elem = job.find('ul', class_='salary')
    salary = salary_elem.find('li').text.strip() if salary_elem and salary_elem.find('li') else "N/A"
    
    # Extract the job description
    description_elem = job.find('div', class_='desc')
    description = description_elem.text.strip() if description_elem else "N/A"
    
    # Add the job to the list of jobs
    jobs.append({
        'title': title,
        'company': company,
        'location': location,
        'salary': salary,
        'description': description,
    })

# Save the job data to a JSON file
with open('data_scientist_jobs.json', 'w') as json_file:
    json.dump(jobs, json_file, indent=4)

print("Job data saved to 'data_scientist_jobs.json'.")
