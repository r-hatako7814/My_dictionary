json.array! @contributions do |contribution|
  json.id contribution.id
  json.customer_id contribution.customer_id
  json.title contribution.title
  json.body contribution.body
end