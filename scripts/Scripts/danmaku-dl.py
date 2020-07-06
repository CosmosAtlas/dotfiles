#!/usr/bin/env python3

import requests
import sys
import re
import os
import json
from bs4 import BeautifulSoup


video_url = 'https://www.bilibili.com/video/av76218824'
xml_dir = '/tmp/'

if len(sys.argv) >= 3:
    video_url = sys.argv[1]
    xml_file = sys.argv[2]

def get_cid_from_video_url(video_url):
    ua = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'
    headers = {'Accept': '*/*', 'Accept-Language': 'en-US,en;q=0.5', 'User-Agent': ua}
    response = requests.get(video_url, headers=headers)
    bs = BeautifulSoup(response.text, 'html.parser')
    scripts_tag = bs.find_all('script')
    start = re.escape("window.__INITIAL_STATE__=")
    end = re.escape(
        ";(function(){var s;(s=document.currentScript||document.scripts[document.scripts.length-1]).parentNode.removeChild(s);}());")
    for tag in scripts_tag:
        m = re.match(start + "(.+)" + end, str(tag.string))
        if m != None:
            results = json.loads(m.group(1))
            if len(results["error"]) == 0:
                ret_list = list()
                for video in results["videoData"]["pages"]:
                    ret_list.append(str(video["cid"]))
                return ret_list
            else:
                raise Exception(results["error"])
    raise Exception("Html parse JSON failed.")

def get_video_part_id(video_url):
    m = re.search('\?p=(\d+)', video_url)
    if m:
        return int(m.group(1)) - 1
    return 0
    

try:
    comment_id = get_cid_from_video_url(video_url)
    part_id = get_video_part_id(video_url)
    comment_id = comment_id[part_id]
except Exception as e:
    print("Error getting cid: %s", e)
    sys.exit(1)

print(comment_id)

danmaku_url = "http://comment.bilibili.com/%s.xml" % comment_id

response = requests.get(danmaku_url)
response.encoding = 'utf-8'

with open(xml_dir + comment_id + '.xml', 'w', encoding='utf-8') as f:
    f.write(response.text)

