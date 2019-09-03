# frozen_string_literal: true

json.extract! team, :id, :name, :abbreviation
json.set! :manager do
  json.set! :first_name, team&.manager&.first_name
  json.set! :last_name, team&.manager&.last_name
  json.set! :age, team&.manager&.age
end

json.set! :fans do
  json.array! team.fans do |fan|
    json.set! :name, fan.name
    json.set! :alcoholic_level, fan.alcoholic_level
  end
end

json.set! :logo_url do
  json.array! team.logo do |logo|
    json.set! :url, rails_blob_url(logo)
  end
end

