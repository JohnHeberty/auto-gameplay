CREATE MATERIALIZED VIEW mvw_1_info_video AS 
with info_video_clean as (
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
		-- Normalizar textos para busca (minúsculas, sem caracteres especiais)
		LOWER(REGEXP_REPLACE(COALESCE(a.title, ''), '[^a-zA-Z0-9\s.]', '', 'g')) as clean_title,
		LOWER(REGEXP_REPLACE(COALESCE(a.description, ''), '[^a-zA-Z0-9\s.]', '', 'g')) as clean_description,
		LOWER(REGEXP_REPLACE(COALESCE(c.title, ''), '[^a-zA-Z0-9\s.]', '', 'g')) as clean_playlist_title
	from public.playlist_movie_historic a
	left join playlist_movie b on a.id_movie = b.id_movie
	left join playlist c on c.id_playlist = b.id_playlist
), 
info_video_version as (
	select 
		a.*,
		(
			select gv."name"
			from game_versions gv 
			where gv.date <= a.dt_upload 
			order by gv.date desc 
			limit 1
		) as possible_version_data,
		(
			select gv.name
			from game_versions gv
			where position(gv.name in a.clean_title) > 0
			limit 1
		) as version_in_titulo,
		(
			select gv.name
			from game_versions gv
			where position(gv.name in a.clean_description) > 0
			limit 1
		) as version_in_description,
		(
			select gv.name
			from game_versions gv
			where position(gv.name in a.clean_playlist_title) > 0
			limit 1
		) as version_in_playlist
	from info_video_clean a
),
all_possible_version as (
	select
		*,
		coalesce(
			coalesce(
				coalesce(version_in_titulo, version_in_description), 
				version_in_playlist
			), 
			possible_version_data) as final_version
	from info_video_version
)
select
	a.id_movie, 
	a.title,
	a.description,
	a.views,
	a.likes,
	a.id_video,
	a.id_playlist,
	a.title_playlist,
	a.id_youtube,
	a.dt_upload,
	-- Remover nome do canal das strings clean para evitar falsos positivos
	TRIM(REGEXP_REPLACE(
		REGEXP_REPLACE(
			REGEXP_REPLACE(
				REGEXP_REPLACE(a.clean_title, 
					'\y' || LOWER(COALESCE(b.title, '')) || '\y', ' ', 'gi'),
				'\y' || LOWER(COALESCE(b.handle_name, '')) || '\y', ' ', 'gi'),
			'\y' || LOWER(REGEXP_REPLACE(COALESCE(b.handle, ''), '^@', '', 'g')) || '\y', ' ', 'gi'),
		'\s+', ' ', 'g')) as clean_title,
	TRIM(REGEXP_REPLACE(
		REGEXP_REPLACE(
			REGEXP_REPLACE(
				REGEXP_REPLACE(a.clean_description, 
					'\y' || LOWER(COALESCE(b.title, '')) || '\y', ' ', 'gi'),
				'\y' || LOWER(COALESCE(b.handle_name, '')) || '\y', ' ', 'gi'),
			'\y' || LOWER(REGEXP_REPLACE(COALESCE(b.handle, ''), '^@', '', 'g')) || '\y', ' ', 'gi'),
		'\s+', ' ', 'g')) as clean_description,
	TRIM(REGEXP_REPLACE(
		REGEXP_REPLACE(
			REGEXP_REPLACE(
				REGEXP_REPLACE(a.clean_playlist_title, 
					'\y' || LOWER(COALESCE(b.title, '')) || '\y', ' ', 'gi'),
				'\y' || LOWER(COALESCE(b.handle_name, '')) || '\y', ' ', 'gi'),
			'\y' || LOWER(REGEXP_REPLACE(COALESCE(b.handle, ''), '^@', '', 'g')) || '\y', ' ', 'gi'),
		'\s+', ' ', 'g')) as clean_playlist_title,
	a.final_version as version
from all_possible_version a
left join public.channel b on (a.id_youtube = b.id_youtube)
where b.ignore = false;