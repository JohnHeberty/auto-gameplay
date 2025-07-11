create materialized view mvw_video_version_proplayers as 
with pro_players as (
	select 
		replace(replace(lower(name), '-', ''), ' ', ' ') as name1, 
		lower(name) as name2,
		name
	from proplayers
), 
detect_proplayer_name_title as (
	select
		id_movie, 
		title, 
		description, 
		views, 
		likes, 
		id_video, 
		id_playlist, 
		title_playlist, 
		id_youtube, 
		dt_upload, 
		versao_final,
		(
			select gv.name1
			from pro_players gv
			where position(gv.name1 in lower(vvv.title) ) > 0
			limit 1
		) as versao_1_in_title,
		(
			select gv.name2
			from pro_players gv
			where position(gv.name2 in lower(vvv.title) ) > 0
			limit 1
		) as versao_2_in_title
	from vw_video_versao vvv
),
detect_proplayer_name_description as (
	select
		id_movie, 
		title, 
		description, 
		views, 
		likes, 
		id_video, 
		id_playlist, 
		title_playlist, 
		id_youtube, 
		dt_upload, 
		versao_final,
		coalesce(versao_1_in_title, versao_2_in_title) as versao_title,
		(
			select gv.name1
			from pro_players gv
			where position(gv.name1 in lower(vvv.description) ) > 0
			limit 1
		) as versao_1_in_description,
		(
			select gv.name2
			from pro_players gv
			where position(gv.name2 in lower(vvv.description) ) > 0
			limit 1
		) as versao_2_in_description
	from detect_proplayer_name_title vvv
),
detect_proplayer_name_playlist as (
	select
		id_movie, 
		title, 
		description, 
		views, 
		likes, 
		id_video, 
		id_playlist, 
		title_playlist, 
		id_youtube, 
		dt_upload, 
		versao_final,
		versao_title,
		coalesce(versao_1_in_description, versao_2_in_description) as versao_description,
		(
			select gv.name1
			from pro_players gv
			where position(gv.name1 in lower(vvv.title_playlist) ) > 0
			limit 1
		) as versao_1_in_title_playlist,
		(
			select gv.name2
			from pro_players gv
			where position(gv.name2 in lower(vvv.title_playlist) ) > 0
			limit 1
		) as versao_2_in_title_playlist
	from detect_proplayer_name_description vvv
),
end_check as (
	select
		id_movie, 
		title, 
		description, 
		views, 
		likes, 
		id_video, 
		id_playlist, 
		title_playlist, 
		id_youtube, 
		dt_upload, 
		versao_final,
		versao_title,
		versao_description,
		coalesce(versao_1_in_title_playlist, versao_2_in_title_playlist) as versao_playlist
	from detect_proplayer_name_playlist
), 
final_coalesce as (
	select
		id_movie, 
		title, 
		description, 
		views, 
		likes, 
		id_video, 
		id_playlist, 
		title_playlist, 
		id_youtube, 
		dt_upload, 
		versao_final,
		coalesce(coalesce(versao_title, versao_description),versao_playlist) as proplayer
	from end_check
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
	a.versao_final, 
	h.name as proplayer
from final_coalesce a
left join pro_players h on (h.name1 = a.proplayer or h.name2 = a.proplayer);