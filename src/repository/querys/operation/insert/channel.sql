INSERT INTO CHANNEL (
    ID_YOUTUBE,
    URL, 
    TITLE, 
    DESCRIPTION, 
    DESCRIPTION_SNIPPET, 
    HANDLE_NAME, 
    HANDLE, 
    ID_GAME, 
    COUNTRY, 
    REGISTER_DATE,
    MY_CHANNEL
) VALUES (
    '{{ channel_id }}', 
    '{{ channel_url }}', 
    '{{ channel_title }}', 
    '{{ channel_description }}', 
    '{{ channel_description_snippet }}', 
    '{{ channel_handle_name }}', 
    '{{ channel_handle }}', 
    '{{ channel_game }}', 
    '{{ channel_country }}', 
    '{{ channel_register }}', 
    '{{ my_channel }}'
);