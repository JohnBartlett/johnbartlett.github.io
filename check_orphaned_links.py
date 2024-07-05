import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse
import concurrent.futures

def is_valid_url(url):
    parsed = urlparse(url)
    return bool(parsed.netloc) and bool(parsed.scheme)

def get_all_links(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    links = set()
    for a_tag in soup.findAll("a"):
        href = a_tag.attrs.get("href")
        if href == "" or href is None:
            continue
        href = urljoin(url, href)
        if not is_valid_url(href):
            continue
        if base_url in href:
            links.add(href)
    return links

def check_link(url):
    try:
        response = requests.head(url, allow_redirects=True)
        if response.status_code == 404:
            return url
    except requests.RequestException:
        return url
    return None

base_url = "https://johnbartlett.github.io"
visited_links = set()
to_visit = set([base_url])
orphaned_links = set()

with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
    while to_visit:
        current_url = to_visit.pop()
        visited_links.add(current_url)
        
        print(f"Checking: {current_url}")
        
        links = get_all_links(current_url)
        new_links = links - visited_links
        to_visit.update(new_links)
        
        futures = [executor.submit(check_link, link) for link in links]
        for future in concurrent.futures.as_completed(futures):
            result = future.result()
            if result:
                orphaned_links.add(result)

print("\nOrphaned links:")
for link in orphaned_links:
    print(link)

print(f"\nTotal links checked: {len(visited_links)}")
print(f"Total orphaned links: {len(orphaned_links)}")
