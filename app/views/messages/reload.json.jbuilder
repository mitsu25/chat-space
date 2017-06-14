json.array! @messages.each do |message|
  json.id         message.id
  json.body       message.body
  json.createdAt  message.created_at
  json.userName   message.user.name
  json.image      message.image
end
