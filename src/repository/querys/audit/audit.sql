with top_10_players as (
	SELECT *
	FROM public.mvw_103_analysis_version_proplayer
	limit 10
),
top_players_hero as (
	select b.*
	from top_10_players a
	left join mvw_104_analysis_version_proplayer_heroi b on (
		a.proplayer_final = b.proplayer_final and
		a.version = b.version
	)
)
select *
from top_players_hero;


SELECT id_movie, title, description, "views", likes, id_video, id_playlist, title_playlist, id_youtube, dt_upload, clean_title, clean_description, clean_playlist_title, "version", 
       detected_hero_1, id_hero_1, confidence_score_1, heroi, heroi1, heroi2, heroi_final,
       detected_proplayer_1, id_proplayer_1, confidence_score_proplayer_1, proplayer, proplayer1, proplayer2, proplayer_final
FROM public.mvw_4_info_video_heroi_proplayer
where proplayer_final = 'Ace' and heroi_final = 'Faceless Void' and "version" = '7.39'


