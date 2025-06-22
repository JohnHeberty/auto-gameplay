#!/usr/bin/env python3

"""
https://github.com/youtube/api-samples/tree/master/python

Retrieve the authenticated user's uploaded YouTube videos.
Usage:
    python my_uploads.py
"""

import os
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from google_auth_oauthlib.flow import InstalledAppFlow

CLIENT_SECRETS_FILE = 'client_secret.json'
SCOPES = ['https://www.googleapis.com/auth/youtube.readonly']
API_SERVICE_NAME = 'youtube'
API_VERSION = 'v3'


def get_authenticated_service():
    """Authenticate and return a YouTube API service instance."""
    print("1. Authenticating with YouTube API...")
    flow = InstalledAppFlow.from_client_secrets_file(CLIENT_SECRETS_FILE, SCOPES)
    print("2. Please visit the following URL to authorize the application:")
    credentials = flow.run_local_server(port=8090)
    print("3. Authentication successful!")
    return build(API_SERVICE_NAME, API_VERSION, credentials=credentials)

def get_my_uploads_playlist_id(youtube):
    """
    Retrieve the uploads playlist ID for the authenticated user's channel.
    Returns:
        str: The uploads playlist ID, or None if not found.
    """
    channels_response = youtube.channels().list(
        mine=True,
        part='contentDetails'
    ).execute()

    for channel in channels_response.get('items', []):
        return channel['contentDetails']['relatedPlaylists']['uploads']
    return None

def list_my_uploaded_videos(youtube, uploads_playlist_id, max_results=5):
    """
    Print the titles and IDs of videos in the uploads playlist.
    Args:
        youtube: Authenticated YouTube API service instance.
        uploads_playlist_id (str): The uploads playlist ID.
        max_results (int): Number of results per page.
    """
    request = youtube.playlistItems().list(
        playlistId=uploads_playlist_id,
        part='snippet',
        maxResults=max_results
    )

    print(f'Videos in playlist {uploads_playlist_id}:')
    while request:
        response = request.execute()
        for item in response.get('items', []):
            title = item['snippet']['title']
            video_id = item['snippet']['resourceId']['videoId']
            print(f'{title} ({video_id})')
        request = youtube.playlistItems().list_next(request, response)

def main():
    try:
        youtube = get_authenticated_service()
        uploads_playlist_id = get_my_uploads_playlist_id(youtube)
        if uploads_playlist_id:
            list_my_uploaded_videos(youtube, uploads_playlist_id)
        else:
            print('No uploaded videos playlist found for this user.')
    except HttpError as e:
        print(f'An HTTP error {e.resp.status} occurred:\n{e.content}')


if __name__ == '__main__':
    main()
