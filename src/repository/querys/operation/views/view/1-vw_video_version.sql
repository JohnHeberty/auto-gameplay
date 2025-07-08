create or replace view vw_video_versao as 
with all_possivel_versao as (
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
		a.dt_upload,
		(
			select gv."name"
			from game_versions gv 
			where gv.date <= a.dt_upload 
			order by gv.date desc 
			limit 1
		) as possivel_versao_data,
		(
			select gv.name
			from game_versions gv
			where position(gv.name in a.description) > 0
			limit 1
		) as versao_na_descricao,
		(
			select gv.name
			from game_versions gv
			where position(gv.name in a.title) > 0
			limit 1
		) as versao_no_titulo
	from public.playlist_movie_historic a
	left join playlist_movie b on a.id_movie = b.id_movie
	left join playlist c on c.id_playlist = b.id_playlist
)
select
	*,
	coalesce(coalesce(versao_no_titulo, versao_na_descricao),possivel_versao_data) as versao_final
from all_possivel_versao
order by dt_upload;