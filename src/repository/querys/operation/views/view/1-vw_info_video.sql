create or replace view vw_info_video as 
select 
	a.id_movie, 
	a.title,
	a.description,
	a."views",
	a.likes,
	b.id_video,
	b.id_playlist,
	c.title as title_playlist,
	c.id_youtube,
	a.dt_upload
from public.playlist_movie_historic a
left join playlist_movie b on a.id_movie = b.id_movie
left join playlist c on c.id_playlist = b.id_playlist