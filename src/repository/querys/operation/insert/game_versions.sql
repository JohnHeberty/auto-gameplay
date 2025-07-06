INSERT INTO GAME_VERSIONS (
    ID,
    "name", 
    "date", 
    ID_GAME
) VALUES (
    {{ ID }}, 
    '{{ NAME }}', 
    '{{ DATE }}', 
    {{ ID_GAME }} 
);