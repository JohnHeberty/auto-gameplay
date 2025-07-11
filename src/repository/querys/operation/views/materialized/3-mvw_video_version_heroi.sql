create materialized view mvw_video_version_heroi as 
with hero_names as (
	select 
		replace(replace(name, 'npc_dota_hero_', ''), '_', ' ') as name1, 
		lower(localized_name) as name2,
		localized_name
	from heroes h
), 
detect_hero_name_title as (
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
			from hero_names gv
			where position(gv.name1 in lower(vvv.title) ) > 0
			limit 1
		) as versao_1_in_title,
		(
			select gv.name2
			from hero_names gv
			where position(gv.name2 in lower(vvv.title) ) > 0
			limit 1
		) as versao_2_in_title
	from vw_video_versao vvv
),
detect_hero_name_description as (
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
			from hero_names gv
			where position(gv.name1 in lower(vvv.description) ) > 0
			limit 1
		) as versao_1_in_description,
		(
			select gv.name2
			from hero_names gv
			where position(gv.name2 in lower(vvv.description) ) > 0
			limit 1
		) as versao_2_in_description
	from detect_hero_name_title vvv
),
detect_hero_name_playlist as (
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
			from hero_names gv
			where position(gv.name1 in lower(vvv.title_playlist) ) > 0
			limit 1
		) as versao_1_in_title_playlist,
		(
			select gv.name2
			from hero_names gv
			where position(gv.name2 in lower(vvv.title_playlist) ) > 0
			limit 1
		) as versao_2_in_title_playlist
	from detect_hero_name_description vvv
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
	from detect_hero_name_playlist
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
		coalesce(coalesce(versao_title, versao_description),versao_playlist) as heroi
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
	h.localized_name as heroi
from final_coalesce a
left join hero_names h on (h.name1 = a.heroi or h.name2 = a.heroi);