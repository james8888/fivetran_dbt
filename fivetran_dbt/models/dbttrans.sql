/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

select 
ID,
_modified modified,
f.value:name name,
f.value:email email,
_FIVETRAN_SYNCED FIVETRAN_SYNCED
from "FIVETRAN_DATABASE"."AZURE_BLOB_STORAGE"."JSONFT",
lateral flatten(input => users ) f

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
