
json.extract! @logo_variants

json.set! :logo_url do
  json.array! @logo_variants do |logo|
    json.set! :url, rails_representation_url(logo)
  end
end