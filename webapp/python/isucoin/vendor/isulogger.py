"""
ISULOG client
"""
from __future__ import annotations

import json
import time
import threading
import urllib.parse

import requests

LOG_POST_INTERVAL = 9.5
LOG_POST_BODY_LIMIT_BYTES = 1 * 1024 * 1024 - 1


class IsuLogger:
    def __init__(self, endpoint, appID):
        self.endpoint = endpoint
        self.appID = appID
        self._requests = []
        self._event = threading.Event()
        self._thread = threading.Thread(target=self._background)
        self._thread.start()

    def __exit__(self):
        self._thread.join()

    def send(self, tag, data):
        self._requests.append({
            "tag": tag,
            "time": time.strftime("%Y-%m-%dT%H:%M:%S+09:00"),
            "data": data,
        })
        self._event.set()
        # self._request(
        #     "/send",
        #     {
        #         "tag": tag,
        #         "time": time.strftime("%Y-%m-%dT%H:%M:%S+09:00"),
        #         "data": data,
        #     },
        # )

    def _request(self, path, data):
        url = urllib.parse.urljoin(self.endpoint, path)
        # body = json.dumps(data)
        body = data
        headers = {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + self.appID,
        }
        print('[ISULOGER] ' + body)
        res = requests.post(url, data=body, headers=headers)
        res.raise_for_status()

    def _background(self):
        while True:
            ## [s1] 初期状態
            self._event.clear()
            self._event.wait()
            ## [s2] 送信待ちのデータが存在する状態
            time.sleep(LOG_POST_INTERVAL)
            raw_data = self._requests[:] # shallow copy
            self._requests = []
            post_data_list = []
            body_str = '['
            for data in raw_data:
                data_str = json.dumps(data,separators=(',', ':'))
                body_str_candidate = body_str + data_str + ','
                if (len(body_str_candidate.encode('utf-8')) < LOG_POST_BODY_LIMIT_BYTES):
                    body_str = body_str_candidate
                else:
                    post_data_list.append(body_str[:-1] + ']')
                    body_str = '[' + data_str + ','
            post_data_list.append(body_str[:-1] + ']')
            for string in post_data_list:
                # self._request('/send_bulk', string)
                threading.Thread(target=self._request, args=('/send_bulk', string, )).start()
