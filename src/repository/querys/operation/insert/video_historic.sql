INSERT INTO PLAYLIST_MOVIE (
    ID_MOVIE,
    TITLE,
    "description",
    LIKES,
    DT_START,
    DT_END,
) VALUES (
    '{{ ID_MOVIE }}',
    '{{ TITLE }}',
    '{{ DESCRIPTION }}',
    '{{ LIKES }}',
    '{{ DT_START }}',
    '{{ DT_END }}'
);