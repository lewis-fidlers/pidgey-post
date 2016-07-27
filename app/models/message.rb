class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }

  belongs_to :user
  belongs_to :client, foreign_key: "client_id", class_name: "User"
end
