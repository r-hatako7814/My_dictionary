json.array! @contributions do |contribution|
  json.id contribution.id
  json.customer_id contribution.customer_id
  json.title contribution.title
  json.body contribution.body
  json.created_at contribution.created_at
  json.favorite contribution.favorites
end