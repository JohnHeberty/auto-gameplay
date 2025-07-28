WITH last_version AS (
    SELECT "name"
    FROM public.game_versions
    ORDER BY ABS("date"::date - CURRENT_DATE) ASC
    LIMIT 2
), update_values AS (
    SELECT miv.id_movie, miv.version
    FROM mvw_0_info_video miv
    WHERE miv.version NOT IN (SELECT "name" FROM last_version)
)
UPDATE playlist_movie_historic 
SET synchronized = false
WHERE id_movie IN (SELECT id_movie FROM update_values);